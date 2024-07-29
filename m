Return-Path: <linux-kernel+bounces-265751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3993F58A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493F9282D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCAD148FEC;
	Mon, 29 Jul 2024 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Bs8yFHPs"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65A1482FE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256555; cv=none; b=PoulI9kjnM2nXmypT2UJQFtvzW/nJCXdN3c+tq8kDc7Vf2J0dYC6l4KhbaJQmVRh6qscM4KTiMk1ng6bfPTC1WX5OdxJfv2Ck7O92exHoVR7oEqoPf9yKaZxUFsJS8682sF4zPNkBc8kYIlur2yRUlZ/yfZgCp52ZAfAS3+5L1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256555; c=relaxed/simple;
	bh=hJ4yHT6MPu1pwPN3tX/Zx3Ck6OuV9IdbboeszxJnCQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZbxwRGEAVhouc1mjXkUz29Zmk+lEAeoq4UMjAWqx/MIbqEyIvd9sPh4ebxDrSbedUUN8nUubqB4rId4ZnDhRlSskWpQ6aKTQtPRSdRIxx0q0MjLveBLiJrqhz5snclDVS4IPTPZcVLo5Tbuyw7eQ+lxrFl5eMJQR+acgPZgGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Bs8yFHPs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efaae7edfso3750863e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722256552; x=1722861352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Huv68Y9tp9oaKlRzKXLO7qOGiKuAnxEpFcqEhnqL4Os=;
        b=Bs8yFHPsoOHTLGRL/gwMnkuzBzw0nsW/69a6mKTHbrYxbLUSkX9/SqqaO4FTJ86TnX
         aPvU6hN6sSv37N0gZfVeyKlQOeN1dZ/7qWPhUo0xFPMDXfAjT7J/ym+fXdLZRcxngQIj
         yyIe8hiZMzuWGriVkIbZJCu4mH9XhtMxoWaPILqfHyMOrZsIXRW6FJwnkm0Ig/eIjS3Z
         iVpLTaQEJvMmHlBIOdkuYjM7I059uiePQFHZOrypjOYQ35TMsQbC+W9CY8rrlK0h98cC
         pqWHlcdYUoZNTwa6PSltQEpf6kC9j4GCLyZ3odAPMQ5CC2OMeYBvYMPzh13kuVyoHv/Q
         e/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256552; x=1722861352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Huv68Y9tp9oaKlRzKXLO7qOGiKuAnxEpFcqEhnqL4Os=;
        b=gUvY84tZxClX4kNnOtZ0qkyc+Cc3zU9LFWDLAfOBPP2HalhGRd0h914CAr8OhCvj5A
         7VdjCycB4BEU4K6DwBaMarG/c0Hv/x4xRbx7cM+o+WJb9ZN2Qeg8L6+PwiHc2jV5pXRG
         BP20mQ/8VVYjAjQ207jmVrSc2V7oQDSPbiZ8SHf3+nxNJzFVskZBr+br57t2laFI5RkE
         qYIjiM3UJbEzPvenbD19sDJqcPvckj/h1PGrENK656Ies6aobYg9J0hvpienNMXGXyDE
         a9gPerKc62U+hFmVq/BFIoGlzQG2BHO0/m3l0nV81up988bQ3WuvbHYjOXZYnK6XCpCn
         ubkw==
X-Forwarded-Encrypted: i=1; AJvYcCVjujf75oyJLNseXJ9jrRmHe3FQwGxDT4kWZAZDsZynRJ7dQgq2wugl8d4+A5wgrEoluz/roTWgNtYCChjOhQoerR1pJhFS3dCq7utR
X-Gm-Message-State: AOJu0YyWez46zroEzqTLM+NaZ/vtjvzRnphm6uDFMPP373jyy1ZgEdX/
	6TUtnhZyq4higRLzpD58Nz131L+km3TU83rv4h2qFwoV8kDIMa+3oj76fhnhMyFaiRD+s9Ok81y
	3cjqGVGwYduugQ7v/5VSRi4uDIG8wkvji/b1aUA==
X-Google-Smtp-Source: AGHT+IHbPY3EmAFT+z3ypCGly+i6vaPT4QcdzFtzNLARKgkO7m2L9wjuWBDFuGq2Od9gf4WKnsAtIMYfvmQCnEBfPAo=
X-Received: by 2002:a05:6512:2c0b:b0:52e:f99e:5dd1 with SMTP id
 2adb3069b0e04-5309b2c320fmr4419310e87.47.1722256551444; Mon, 29 Jul 2024
 05:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729095542.21097-1-johan+linaro@kernel.org>
 <CAMRc=McuqEv1Sk9O6kn4aHo9wOfzskZS0z2QxzNM=q2N8XZ3zw@mail.gmail.com> <Zqduv66H2OczRgaH@hovoldconsulting.com>
In-Reply-To: <Zqduv66H2OczRgaH@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 29 Jul 2024 14:35:39 +0200
Message-ID: <CAMRc=MfEkPcKUNb7HbiNrqv+7q1n0wRD9sKQ8WrydoR4grao2A@mail.gmail.com>
Subject: Re: [PATCH] Revert "firmware: qcom: qseecom: convert to using the TZ allocator"
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Amirreza Zarrabi <quic_azarrabi@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 12:28=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
>
> On Mon, Jul 29, 2024 at 12:03:55PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Jul 29, 2024 at 11:58=E2=80=AFAM Johan Hovold <johan+linaro@ker=
nel.org> wrote:
> > >
> > > This reverts commit 6612103ec35af6058bb85ab24dae28e119b3c055.
> > >
> > > Using the "TZ allocator" for qcseecom breaks efivars on machines like
> > > the Lenovo ThinkPad X13s and x1e80100 CRD:
> > >
> > >         qcom_scm firmware:scm: qseecom: scm call failed with error -2=
2
> > >
> > > Reverting to the 6.10 state makes qseecom work again.
> > >
> > > Fixes: 6612103ec35a ("firmware: qcom: qseecom: convert to using the T=
Z allocator")
> > > Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > > Cc: regressions@lists.linux.dev
> > >
> > > #regzbot introduced: 6612103ec35a
> >
> > How about at least giving me the chance to react to the report and fix
> > it instead of reverting it right away?
>
> Lots of folks have been running linux-next on Qualcomm machines for a
> month without reporting or fixing the issue. And v10 of the offending
> patch was apparently never even tested before being merged.
>
> I'm sure you'll have a few days to look at this before we revert.
>
> I'll be on holiday for a few weeks, but you have an X13s so you should
> be able to reproduce this yourself.
>
> > Are there any other messages about SHM bridge/SCM calls in the kernel l=
og?
>
> I've also seen this combo:
>
>         [    3.219296] qcom_scm firmware:scm: qseecom: scm call failed wi=
th error -22
>         [    3.227153] efivars: get_next_variable: status=3D8000000000000=
007
>
> But usually the first message is the only hint why efivars is completely
> broken.
>
> > Do you have QCOM_TZMEM_MODE_GENERIC=3Dy or QCOM_TZMEM_MODE_SHM_BRIDGE=
=3Dy
> > in your config? If the latter: can you try changing it to the former
> > and retest?
>
> I have the former in my config but have tested both, made no difference.
>
> > > It's a little frustrating to find that no-one tested this properly or
> > > even noticed the regression for the past month that this has been
> > > sitting in linux-next.
> >
> > I have tested many platforms and others have done the same but
> > unfortunately cannot possibly test every single use-case on every
> > platform. This is what next is for after all.
>
> I doubt this is specific to sc8280xp and x1e80100. Which platforms did
> you test qseecom and efivars on?
>
> > > Looks like Maximilian may have hit this with v9 too:
> > >
> > >         https://lore.kernel.org/lkml/CAMRc=3DMf_pvrh2VMfTVE-ZTypyO010=
p=3Dto-cd8Q745DzSDXLGFw@mail.gmail.com/
> > >
> > > even if there were further issues with that revision.
> >
> > This is a different issue that was fixed in a later iteration.
>
> The symptoms appear to be the same once you get past the locking splats:
>
>         [    2.507347] qcom_scm firmware:scm: qseecom: scm call failed wi=
th error -22
>         [    2.507813] efivars: get_next_variable: status=3D8000000000000=
007
>
> So it's possible that this never worked.
>
> Johan

How do you reproduce this on x1e?

Bart

