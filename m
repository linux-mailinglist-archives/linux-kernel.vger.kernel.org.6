Return-Path: <linux-kernel+bounces-304559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8589621D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFD41F24CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECEC15A851;
	Wed, 28 Aug 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjYI852q"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D215853A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831598; cv=none; b=FN06n9ExmdEPutHiAl65J59ucTxMybqipR4kFjWVsI0LMdC7kRDhHZC1Z0hm18/IIT7eohXI16rzcRVh4FEuDKqUfwS2/RyiTsrl+c3uMTrlIgII6e32c3YlpRkPrJEgCu1tPIGuaNx7S/crZ4QbFC0BsaOcIgRoJsxYGL2K/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831598; c=relaxed/simple;
	bh=21a/MHKVnT6XBlWWTo2Q1achWYbwUOVFk7jow4EG1/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAn0hWE9EIA+A8OX81uAt+93qBlulQ8XrLWRCqzdjPeiMq3D6f7GMB7NH2qsPY1N5a4gng09HEHIuNNH/jGvc5VV0WaaiphJ9qb5L4bQiKllv34OpvBeqROlb9I2SD85Azq8JOOGwfH7APdCQsYFlwytfh3A+/nfNtmTA/i2tMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fjYI852q; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533463f6b16so7433145e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724831595; x=1725436395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsoLJnR1HavX8ieXrR58m8Zt34PxhdbdX51ID+vKbNE=;
        b=fjYI852qrMpbaGUgYhK4Wg8armTjpjX45HdXhbq8p4DeCTy+LtjjRN2tEzceVq4eCI
         eBwodFZczzgvP3qvve8na7BA7V4y0y9G0pFYciFHVkJd2RiSo1jLRof/FTUoXUsO7D2n
         ykNp+csgIpu/dgqSx4l0+dWDyh7dzaIPurUwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724831595; x=1725436395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsoLJnR1HavX8ieXrR58m8Zt34PxhdbdX51ID+vKbNE=;
        b=MBhEYtrPK34doP+9ez8iEv8adttvzUNjvm5hLyp1RktqkG6nnYIiGrGpaVqWlgaC4W
         Ipe97e44T0wLNfk3a9okdzpLOmVEXqg8NuY1JDMpnEaj8icuY4ccSzI/lvCzg/aI+eWn
         3j3XnWpXm69IaxMSBCpNvwBb2+yS8pmJnmE0bvHZNbAaPU28nis2Sje//eutDuawiPuJ
         BZH92kYWjw4V1vwcFwEOHCDCUrGvdPsbZRZ9nYJ/B8SSk0s/pFjEHIF8F5Pc8mpeFG6L
         qiXqjmiFSlHp3YBKQ0rjW1LgBJsQxu/ZT9YXAGhM3HV/YR2pbtSIyRe2bBn7Gj3zYWZV
         qn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz/DeuMbuewr+ORO1vuqZhtwJP5JCgVDx7xG4KTs+sVV5MmRxl/cEB9IYbP6WI3g3KbIM5NG8xR1IxlqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf3J9epT/kOHWmcPMbQRlDqqEOuWLRtDSEITaGQ7iRGIkIUfeB
	JjM0mFvWmUEaowUVslnZUM08ry0PN+rHL/csz+x/9NZAO+MaO7bEMyK1NlMWICfjBagapNYSEmG
	ntG0baRktwHjrrA7BgzBYbofkyi/GKwQgKwD7
X-Google-Smtp-Source: AGHT+IGfRHU4N27WpfX66Kn8c7GoY5FHx7iIaM4T3z660sfUYPwkmVBovtba1TaQ1/f9ALuRCW5H+nZ237eSMJnAJJk=
X-Received: by 2002:a05:6512:3e0d:b0:52c:812b:6e72 with SMTP id
 2adb3069b0e04-5343876c25dmr8620718e87.1.1724831595041; Wed, 28 Aug 2024
 00:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827095550.675018-1-wenst@chromium.org> <20240827095550.675018-9-wenst@chromium.org>
 <e341240e-1c1f-49a2-91cd-440888fdbda0@gmail.com>
In-Reply-To: <e341240e-1c1f-49a2-91cd-440888fdbda0@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 28 Aug 2024 15:53:03 +0800
Message-ID: <CAGXv+5EcHQ7E979fKPEci2qwXBnKPfVHc_aB02amUbdVB3KTxg@mail.gmail.com>
Subject: Re: [PATCH 8/8] regulator: irq_helpers: Add missing "Return"
 kerneldoc section
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 1:55=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> On 8/27/24 12:55, Chen-Yu Tsai wrote:
> > kernel-doc complains about missing "Return" section for the function
> > regulator_irq_map_event_simple().
> >
> > Add a "Return" section for it based on its behavior.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Thank You for improving this! I appreciate it :)
>
> > ---
> >   drivers/regulator/irq_helpers.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_he=
lpers.c
> > index 5ab1a0befe12..5803ef016b7d 100644
> > --- a/drivers/regulator/irq_helpers.c
> > +++ b/drivers/regulator/irq_helpers.c
> > @@ -414,6 +414,10 @@ EXPORT_SYMBOL_GPL(regulator_irq_helper_cancel);
> >    * notification helperk. Exactly one rdev and exactly one error (in
>
> I just noticed (an existing) typo "helperk". I wonder if it was Ok to
> fix it while anyways changing the doc. It's not strictly speaking
> related to the return values though :)

Why not? Only the kerneldoc this function is touched. It looks like the
'k' belongs to the "callbac" on the previous line.

> >    * "common_errs"-field) can be given at IRQ helper registration for
> >    * regulator_irq_map_event_simple() to be viable.
> > + *
> > + * Return: 0
> > + *
> Anyways, I agree with Andy about not needing the blank line here - but

I disagree because of the formatting result. See my other reply.

> other than that:
>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>
> > + * Actual regulator error and notification are passed back through @ri=
d.
> >    */
> >   int regulator_irq_map_event_simple(int irq, struct regulator_irq_data=
 *rid,
> >                           unsigned long *dev_mask)
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>

