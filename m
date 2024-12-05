Return-Path: <linux-kernel+bounces-432948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFC69E5239
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C72C283A4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555741D6187;
	Thu,  5 Dec 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JofWgZfK"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828B1D5ACD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394439; cv=none; b=TOHNpzywl8auZSEqtFALxLHBa74ehViZBglETST703Ea0sR7c9hBQ67lPCmuSukQBLT4zhtFGvM1EjTYGjJQcxPaRBvc2pmPCzZ5ERDXhVevQfpBweCog59TLaGtqxFtUzquSVHG2UELm55jxlI2x1AhR5c/ZnRiMLcs1LYM6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394439; c=relaxed/simple;
	bh=8q46dqRV1v2ND/3kJc778fBE2wfFmek/CR405bLPtMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQWJ3ObA9FRHQAbdfm4OLbBAqBuP9IfRpg8HpKPq4SQRWhoY2zGNN+yF9rUg8mkDhawxFlj5vyYRDQ0O8u1JNJ5dIdS6AjjHa0UJilMrHLYw/rqb3MPVcDi9/kGXycQtWkPgN46mFVdq2qRerjzO19ACt3OJpFKp7BQ2+U3mmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JofWgZfK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffc016f301so6056961fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733394435; x=1733999235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWr2sPdmT358XoDKa9V480ufmwo78bf7Tj2jfcCUPKQ=;
        b=JofWgZfKJr/hMvKcIYz1asdNoppYTpgCstHlvRTRmAsIdRmkvoNUUXKuL6sziGiLfv
         KSnUvmXpULP/UT1w9wfxFw5HtCHW49Sw8EGzRt8HDOWhwXaFcn4Tpzb4Wz6Q6JZTugds
         rQ0Fh5x7/5XwZw9JFIvYseRJRM8rm7ifdSOBHeKWvoitWq/DxqqSqVOC2B6cLSVHMWCZ
         SIycHzQmuLvfqQILRRkJi77BhYWO75ydVxAIFfb9HvSEfBhl74FIlBbpysvnG2iAVgvV
         +SccNVaRWPtpoDYxx1Z2lpGuw5v7tH85GLhhVGV8cwIYFcK9tJoRSE2M7rO02Y4u9RTi
         7aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394435; x=1733999235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWr2sPdmT358XoDKa9V480ufmwo78bf7Tj2jfcCUPKQ=;
        b=POsVvMizPQLx25Vs6pRT0mSMipXlzVyF6X828PB7hmXRo5OuJqVcEhpJwrbCJZljQl
         KFsPteKwY/t31/61yKWwiD2s1KVc056g6gm0cYmwrasOn9+77oA2hunOuEFPFvp9IN+U
         41Av5rbhhhcwkV/BHFIc9W+NAn6L5wSy2MTvmsrO1NRo0fSotFpybM/IlgxvcECknq3X
         geZ0o7MTntwsfFRJtVv6tvG1pyxrW8oZpHtyyf5+4hJ13CjMhWK7i94w75PXsyX4TKiT
         WL1cDTRN304fUjuz1etohDzuT/U6vF5IQwLLVQyAWrjp2kNiKy0855lwlXjwdPR8GySZ
         A7dA==
X-Forwarded-Encrypted: i=1; AJvYcCWEwJELJU61xescOJMs+FFk/FPy2CiaMaZjR6k/6Lu0gKg52EUJ06kN/jEaHTw9h0r+sK0Q3sPjSV0acIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBZNGNy+AqHUSqGILYFi9AxrtXNcnBiqfryT2cRvPh7X19bUW
	Ql5v4I3MmG9g4tnnbOFiwEtqzFhtofVC2uLZzXr++Xs5FT0vGZvKsphM/T4S2gz7LgsdbfX3AAf
	crihY6WhnBLvpQgavfJhYCZRw6e8j1Ts0FsqM6w==
X-Gm-Gg: ASbGncvBlV4uAWKQ409fqXu36xiQMGnvACwLfHaaEQMqbkWmtrz5hqKEimMtdwErjYE
	jKm7mAG2EudoByyRBbKweui1BriRuAp6rrEoTeQYN57D+4AdEoY8g3xYNLGz5Ew==
X-Google-Smtp-Source: AGHT+IGUNiZ2Zr0AGmSGs2mdBuCRnV4lKq45/HGJjBiaJ21c71eSWgLHkCTxlmAm2wmJM4o2z+eKzX5aHRxBC7VjXr8=
X-Received: by 2002:a05:6512:39d2:b0:53d:cefe:ffbd with SMTP id
 2adb3069b0e04-53e12a34417mr5547500e87.55.1733394434644; Thu, 05 Dec 2024
 02:27:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203164143.29852-1-brgl@bgdev.pl> <213de4bc-3706-4bb0-a827-06c63bfe0294@ti.com>
 <CAMRc=Md_u3YmseW5kV5VH4F99_0P=tc4pWty_fB3dVfv_JDxWQ@mail.gmail.com> <37f90519-48e9-4caa-80c6-9f6ae61aae0a@ti.com>
In-Reply-To: <37f90519-48e9-4caa-80c6-9f6ae61aae0a@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Dec 2024 11:27:03 +0100
Message-ID: <CAMRc=MdMiYE6xmmPqvZcx7MRjzppWkdWerxTiqn6Z9kmiUruwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: omap: allow building the module with COMPILE_TEST=y
To: Andrew Davis <afd@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:54=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> On 12/3/24 2:36 PM, Bartosz Golaszewski wrote:
> > On Tue, Dec 3, 2024 at 7:41=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
> >>
> >> On 12/3/24 10:41 AM, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> For better build coverage, allow building the gpio-omap driver with
> >>> COMPILE_TEST Kconfig option enabled.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> ---
> >>>    drivers/gpio/Kconfig | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> >>> index 56fee58e281e7..fb923ccd79028 100644
> >>> --- a/drivers/gpio/Kconfig
> >>> +++ b/drivers/gpio/Kconfig
> >>> @@ -530,7 +530,7 @@ config GPIO_OCTEON
> >>>    config GPIO_OMAP
> >>>        tristate "TI OMAP GPIO support" if ARCH_OMAP2PLUS || COMPILE_T=
EST
> >>>        default y if ARCH_OMAP
> >>> -     depends on ARM
> >>> +     depends on ARM || COMPILE_TEST
> >>
> >> Why do we have this depends on ARM at all? It already has that conditi=
on
> >> above on ARCH_OMAP2PLUS which limits to ARM outside of compile testing=
.
> >>
> >> And anything that selects ARCH_OMAP2PLUS also selects ARCH_OMAP, so we
> >> could just do this:
> >>
> >
> > I agree we can drop that bit.
> >
> >> --- a/drivers/gpio/Kconfig
> >> +++ b/drivers/gpio/Kconfig
> >> @@ -528,9 +528,9 @@ config GPIO_OCTEON
> >>             family of SOCs.
> >>
> >>    config GPIO_OMAP
> >> -       tristate "TI OMAP GPIO support" if ARCH_OMAP2PLUS || COMPILE_T=
EST
> >> -       default y if ARCH_OMAP
> >> -       depends on ARM
> >> +       tristate "TI OMAP GPIO support"
> >> +       default y
> >> +       depends on ARCH_OMAP2PLUS || COMPILE_TEST
> >
> > This would default to y with COMPILE_TEST. We definitely don't want
> > that. IMO it should be:
> >
> > tristate "TI OMAP GPIO support"
> > depends on ARCH_OMAP2PLUS || COMPILE_TEST
> > default y if ARCH_OMAP2PLUS
> >
>
> Looks good to me
>
> Andrew

Nah, this is incorrect, it doesn't build gpio-omap for
omap1_defconfig. I has to depend on ARCH_OMAP under which all omap
platforms fall and they all use this driver.

Bart

