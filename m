Return-Path: <linux-kernel+bounces-251086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DFF93006F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79B5B2294F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5618EB8;
	Fri, 12 Jul 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MrzM5IsQ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83AC18EA2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808626; cv=none; b=Ak+1VsUmrd/lLoorAX6s5EmsnWZgSbZq4Hx6LUgAry/6WNY5RnL1xTyA3IP9YJBTQGEQnnx8Hl4T5V15CiU97aWm/MMNogTzi1PD57+VWpfqKL6XDN+VE+c0GE21WT9A5tlf/VjmUVGMPOEaqUir8Wvct51IDv0xB02YLOk8pZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808626; c=relaxed/simple;
	bh=obQauV9WtpcWKNSkw+P6HBBIZeLyV+gz/HdZ8WNewKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9lTOVnya2xuwc+E2fC6McIFc5ez1Gf5yOXYSNVJ5iVKP3P4eagpfquwgcqdKpM1E/brggoY+1m39cvmgMpKWUaUqL+QwxsMh4D6PnkJtiyMyDCpoXVlBP1YvSe3iUg8hZ86ub6FKCmoR5UmJZeLzo4dEZTRunXFx9a7aXJkNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MrzM5IsQ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee817dac89so29736901fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720808623; x=1721413423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeLZjX0XcIxy15WR6vzd+HbVbS4ez8SeQ29NDXBIAz0=;
        b=MrzM5IsQB4CXbPTKhcMpBbv5kKwuDYh/eiZqNipO1dC+SpbztkdHX5WQw7/qif95Gv
         PnsyvI6wriJqqRSIYAT7drBKzir/vLpd5HF7MQ0oVO2KxPu1bSM5LcK9A4LNOH0kHlfx
         NVf/lSyOL8wBj6+F+5SofAsR7lvUBSZxLcP2dRaKUTIP/BNqjvGqmkgLHuNc9C1vo4rZ
         /Z9D9qUp2TjaFg/Fr/94lXdwmAIFFTXrH94x4R9ZGbYbHfYarGfDM6R7Xc7K0gFpxU0N
         lYxbjti+ruEzUu1B4r+nHNQFjI0MA4vGQ0mp1QMTD+D1hgLdnUejJ2kA9h4+e78Gkjsx
         kp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720808623; x=1721413423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeLZjX0XcIxy15WR6vzd+HbVbS4ez8SeQ29NDXBIAz0=;
        b=dOvK+lBSdCjyLLYvp3Rjiyfbd6mUOWLTsgVQ5+GI5sF32FtChMOiCVp3/k6wdmG/MN
         gcbhTDz/KzVYVNcxw3hLw0sigLICy30SvVo75bfPcRJ9aPeCorXrTmprvtn+GR1nbOsv
         xtk+ATqzGUIVLUPjihnkwS24c1yzjqjJjteQL+gtTLiEQhYqwpssD0HE4pnefmreek9h
         skwL6H5pCRnwGKFpFexy4noB11oheTvKS/fHk6vXxO0OeyfThr9Y06FJxFq5MXN06GpW
         JJy1q8ic62OEzf6E++Weql2Gok5QgUrnwjCZOF7g4LDXI6mbfn13IwyArkOdvXsxScPX
         Y1jg==
X-Forwarded-Encrypted: i=1; AJvYcCVJHxcBr3XmKA6yngwPto8bpvtSfLok88xp9OkW2B7HWV9Qm/P3RruHeyEfx+bKR4lReUlLFtzahbufdSULu2rTPPZvnrU7sZlzeiJo
X-Gm-Message-State: AOJu0YzmhX3HGGu9oIG6jaL7GNrRzdr7eQTAcmxxrbMlZ3R7X5xeP6RF
	+BzbgXT/Y+vpDLdpfeFU+mKWzJBtV+pb7jqvmmPjws9c8LQCfemBOZbOn3hDENS2oOjp+3kijs7
	tVz26LAaqlyEgHPYbHHsFnxltMwrLbtzLwTU5WA==
X-Google-Smtp-Source: AGHT+IFr1J1qlgrULvkxVx21H4No5aP9MUmcvCKCEVN949ifyzIDD6A8inKcM3O2Y/kzQx9Z7cwixXOfaJoOz3jcEBc=
X-Received: by 2002:a2e:984f:0:b0:2ee:4cb9:8057 with SMTP id
 38308e7fff4ca-2eed2a50be7mr9628351fa.23.1720808622312; Fri, 12 Jul 2024
 11:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712144546.222119-1-brgl@bgdev.pl> <7d7dcc46-2042-439b-a744-49ae4b507839@suswa.mountain>
 <CAMRc=MdqZZLJLrAb10amgZSz40k1qAVMohVeUvHqobEHR5qaZw@mail.gmail.com> <bf3f5a67-f6cf-44ed-a2d8-5722dcae9869@suswa.mountain>
In-Reply-To: <bf3f5a67-f6cf-44ed-a2d8-5722dcae9869@suswa.mountain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Jul 2024 20:23:31 +0200
Message-ID: <CAMRc=MfjZC1e84eHWaxPBK9Ui_CpeVDDaF+xrQxx3Q63nFr8uA@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: fix NULL-pointer dereference in error path
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 5:24=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Fri, Jul 12, 2024 at 05:02:25PM +0200, Bartosz Golaszewski wrote:
> > On Fri, Jul 12, 2024 at 4:59=E2=80=AFPM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> > >
> > > On Fri, Jul 12, 2024 at 04:45:46PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > We may call pwrseq_target_free() on a target without the final unit
> > > > assigned yet. In this case pwrseq_unit_put() will dereference
> > > > a NULL-pointer. Add a check to the latter function.
> > > >
> > > > Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core"=
)
> > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-25=
4a2dfa47ef@stanley.mountain/
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > ---
> > > >  drivers/power/sequencing/core.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequen=
cing/core.c
> > > > index 9c32b07a55e7..fe07100e4b33 100644
> > > > --- a/drivers/power/sequencing/core.c
> > > > +++ b/drivers/power/sequencing/core.c
> > > > @@ -119,7 +119,8 @@ static void pwrseq_unit_release(struct kref *re=
f);
> > > >
> > > >  static void pwrseq_unit_put(struct pwrseq_unit *unit)
> > > >  {
> > > > -     kref_put(&unit->ref, pwrseq_unit_release);
> > > > +     if (unit)
> > >
> > > I was wondering where you would put the check.  But it needs to be:
> > >
> > >         if (!IS_ERR_OR_NULL(unit))
> > >
> > > regards,
> > > dan carpenter
> > >
> >
> > Am I missing something? pwrseq_unit_new() can only return NULL on error=
.
> >
>
> It's not pwrseq_unit_new() but pwrseq_unit_setup() that's the issue.
> The target->unit =3D pwrseq_unit_setup() assignment in
> pwrseq_do_setup_targets().
>
> regards,
> dan carpenter
>

Indeed. Thanks.

Bart

