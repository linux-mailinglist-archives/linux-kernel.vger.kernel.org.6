Return-Path: <linux-kernel+bounces-307818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A97965339
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA05D1C2139A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0D51BA876;
	Thu, 29 Aug 2024 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iTJlKGwE"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F118B479
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972370; cv=none; b=fj3974S3nysNDdWldsdUi2x+YTx244mbrjYfkLAZJUSjbw/INllwyjNJpppu7QK3N4evguD20iTfg/1cJ/lhU5KvhxzHOuSVs97kB2iyfRnvMQbPtOQctaeyf5ggACOowMTC6fC4vtySYFMRKiSKSH50OMR+U61RFrOWsEIGxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972370; c=relaxed/simple;
	bh=Bk9nvcNPuYQCoPoIErsrsyNLN3loPMb8Zblzi2Foa6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwCvPSELUooJFPtkc2DEv8yELdoVpLpkJJZ8bitls9/nIx43YS59OT5AFgQK+FynQkMY1QI6Oul96HzIW/tCWeZZLoJUDXm9piwg7C6FqceQPAksJEBAEjYPVMeXywxiB62K5ZaUcXBKYNKG8XEhOBSodhXIQHJaIC+wHNPs+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iTJlKGwE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5343eeb4973so1861026e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724972367; x=1725577167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVsb5vloMAD1GdpMiG4rd0u1mzBdAZQfDwkldS8oXjs=;
        b=iTJlKGwEy3AiC3tzBdTEKk+j49kT3dDHGiLv/doa4rzzqvaO/7I+5iVr2jTkcromyW
         IXAPXAnoZe24TjiWiSH/ABd+bQ+p9vxMXY6nW+mgsByHYc7RDXhtuvOyCZkAdM2Q5seb
         64cm8uc6IVHjxtMej32C5Ou96bgoZBagChTsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724972367; x=1725577167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVsb5vloMAD1GdpMiG4rd0u1mzBdAZQfDwkldS8oXjs=;
        b=jQCQImI9enVki+pJjzt4BQY3OAIMcU3JBVfVqYFTTyO1g4WEedIe1X4xSgTSjKY1t4
         6t/FN5HfUWmh5+wEo+lt72qYZtxtw8KV8fACJMwx5JjIkl2+r1HkZId792ajVnchYkOu
         R4j5t8QReUlb/+pKxXa/ou6X/EJIWyqWjnfh4Li+emrax4//kD7g9tGnDFcGWMso3my2
         3SyV8GBYXxGXVB/XDd9Z4O2CvI5U78+vBjUFiNnRz+Ya6PsfYbtdY+hCsxenaolBcUM0
         atggk3iA7RFTbMGQ28O6S0y042x6WADnP/3jv11kYE4d9m1owkAHyOAIKMkfTaejp6jh
         0K/g==
X-Forwarded-Encrypted: i=1; AJvYcCV5QVyukmgzlhEL8Ir0iIOscsqB7KCBuAuCBzwUiA9Cc/ebedJcmlb33fw9vsGiZm+Z6R+yH5esXg+X4/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlZyg0BbtybdHVLqvjzmJ/i60HVVjic9Vo3SxzBsJksGDRDWB
	mKgefk0gb7Zyh+baNvhv/98cvAgJGMux4OwVXonGSfLF1t6hUSaJ9V5K8KIEw5VgMWdX4cZH2lP
	Fout1FDO9I+obSekqLLdxIs2zpTs1RyF6Y3v9mi1C86aEk9LrEA==
X-Google-Smtp-Source: AGHT+IGdWMNOyEphrsPzqoD48h8mU45+hovuNUAzyuuz1RE9w9iKv6BseGfwi82INKvOJD1d4bt2ThiBjobdgBRgiOM=
X-Received: by 2002:a05:6512:32c8:b0:52c:9ae0:beed with SMTP id
 2adb3069b0e04-53546bfbf9dmr72183e87.52.1724972366622; Thu, 29 Aug 2024
 15:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829085131.1361701-1-wenst@chromium.org> <20240829085131.1361701-3-wenst@chromium.org>
 <ZtBtqPB2MgwUCsM3@smile.fi.intel.com>
In-Reply-To: <ZtBtqPB2MgwUCsM3@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 30 Aug 2024 07:59:15 +0900
Message-ID: <CAGXv+5GBgWqz2_WaSLdQzd6dzK-vSHyMYPpQRWzCj7vt3u8EoQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] regulator: core: Fix regulator_is_supported_voltage()
 kerneldoc return value
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 29, 2024 at 04:51:22PM +0800, Chen-Yu Tsai wrote:
> > The kerneldoc for regulator_is_supported_voltage() states that the
> > return value is a boolean. That is not correct, as it could return an
> > error number if the check failed.
> >
> > Fix the description by expanding it to cover the valid return values an=
d
> > error conditions. The description is also converted to a proper "Return=
"
> > section.
>
> ...
>
> > - * Returns a boolean.
> > + * Return: 1 if the voltage range is supported, 0 if not, or a negativ=
e error
> > + *      number if @regulator's voltage can't be changed and voltage re=
adback
> > + *      failed.
>
> Not sure why you have TABs in the following lines, but I think you have c=
hecked
> the rendered files (html, man, pdf) and all look good.

It seems that the kernel-doc tool isn't properly trimming the leading
whitespace for RST output. However it is doing it correctly for manpage
output. And for html, pdf and all the other outputs that go through
Sphinx, the latter reformats stuff and seems to drop the extra whitespace.

I looked at the kernel-doc a bit, but wasn't able to immediately spot where
the problem was.

> Alternatively it might be written as
>
>  * Return:
>  * 1 if the voltage range is supported, 0 if not, or a negative error num=
ber
>  * if @regulator's voltage can't be changed and voltage readback failed.
>
> which should be the same in the render.

The RST output then has extra empty lines. *shrugs*


ChenYu

>
> (Also similar applies to the other patch(es))
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

