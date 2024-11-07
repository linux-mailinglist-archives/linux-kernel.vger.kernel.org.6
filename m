Return-Path: <linux-kernel+bounces-399318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7239BFD64
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20971F22A95
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB818A926;
	Thu,  7 Nov 2024 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd1utv2v"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD4372;
	Thu,  7 Nov 2024 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953890; cv=none; b=OaKyWiznfrPQyBjtVbExmtYcy3Db6c0to/3/PXAoi9DUx7REodsMzr+JKL5a4iTmRr6X2HnSwRdxXcMyKGzilomS6UgC7pYXBnLW6vSms/1B0Ubp5lEbB9nqyBh7gDrIJgDziml19Yrtf1vXaDzSk4fRQSTrebeHhmzOMobEGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953890; c=relaxed/simple;
	bh=YBg7K16J6QX1rjvLstPMBbbo5WtxqTKH7wW9aPT0AZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+5ANXUBkeTGhd0sv4v2ZKz+NztiVCJ7dsMThrQVDPvgeOAeJqR5NiJjCUJF6UT5dobIUcWCE/kS9spsb7A8XF5gEkEsTK2HWjn5Mj/8/l+UNeL5UqfB6E3lrRxCLaFEe9E17lbWXBemESsufmVKQ0m0jHHPafdIji/4GECHhc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd1utv2v; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e59dadebso442194e87.0;
        Wed, 06 Nov 2024 20:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730953886; x=1731558686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRkCg2WwREvUvmuCgqmdpMrJhtUN4b15M25FgIXyNck=;
        b=fd1utv2vDvtxA1ocDqYlYBCPOmUJf8+L1rLsw6jun8KWhkMfg2a3bsieU7bwxgdlpS
         5cHPBCEg2XavHAiQfW4NpQfCx71hKZ+1p796yjl39zvKSSbJNX9Z2qIF3D+gqNVFWSA5
         zT97VSfY7Hbl5C+mXMG/J/DBuoisTzYFIlXJBd5WG5rmM+QQzUDFbt0kXktzLck2u3r0
         QKGFDLA4+EJTdxJwL3+jjxLL83U4XTZHvXAZl3koa7h/sUK63zVRlOJJL5fSii6Qhc0t
         xO6THJHlsCjHwJgkeVunAQfHaz+9sIKaE3J03818b08Wg8O4cYyKstmhfnhMc1aB1scC
         ccXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730953886; x=1731558686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRkCg2WwREvUvmuCgqmdpMrJhtUN4b15M25FgIXyNck=;
        b=rCElltuVUtbHscOiAQ26952GITRHfFj8PE3f2kJsUDGR5QccsgjbRZhps9jW6s6FZf
         nqkiUUgzK1cKtn7wQRJ0rtCxza2Vzf5ho4EJDJbyrGfc6fDBBlI8csVIvbOSHyBzHD1X
         05idM4kVz4/b/lNsoU4qfhQzQBWqhcQMlBBLgJdbWR8UEglyoEEz65Z87aVCsgQO4MeP
         ABrP95BmLN9wA3mctr+6UU69E38E/oezBDFGVj94+Gqd50DVXpIf+doImct48CrFdoPA
         UdVufeS4V7MmvvYXbnC3F4N2yFt5sEQCV/zLfTVfbxTsBroin+C2U+nOSWNDwZfWMpxC
         b9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKKiJ11ja4MivW2l5oeZKVr/fgOhKpreugawEVSHziL8HPkH/2O5/YXsn2XRxzkKYjGBn/OFNn218=@vger.kernel.org, AJvYcCUvT4GOwWysGpP1YTZ8i6yOL/DpBLUkHkdx1m1crp290jKsPp+M43e5vQg5JnvqcvysuAF0QBYkFXr03czO@vger.kernel.org, AJvYcCVzMkBvixUrm3h25sYsUXGOVQM96BxIDhB9Mv/YKEQsly8JGTR1TCrBlMV5yxLDy/abImTmxq5aLvKcOOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6B/szyvn3zVcqHa+961kvcgg12lq1SerWMG4Po3+VXDrde3H
	+mGBzqA0jdVTW3q+hYg74iXs9yDEqFEFC/iYo3XtRRDiRIZUbq/UHHpc7uyqFgU5dd+u8Iz5Lps
	kRAjQ60guFSR5Amrp7q6Xu0kXcWY=
X-Google-Smtp-Source: AGHT+IGIhdamdcK2Mig+wvTrARkH1ryi6qF4sZog+7cY1AgdHa+yA2DoDJJhgLAndDq6NuItiG8RULDjmcrB7BNtDcY=
X-Received: by 2002:a05:6512:3d06:b0:53a:1e5:572a with SMTP id
 2adb3069b0e04-53b348f9926mr22052439e87.16.1730953886244; Wed, 06 Nov 2024
 20:31:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102073718.64040-1-yesanishhere@gmail.com> <Zyb8U3lSvYP0UeuN@archie.me>
In-Reply-To: <Zyb8U3lSvYP0UeuN@archie.me>
From: anish kumar <yesanishhere@gmail.com>
Date: Wed, 6 Nov 2024 20:31:14 -0800
Message-ID: <CABCoZhAV0+MK6FEDRpojHoW4opfqNaYCtTrBTjA8O8+yurLr2A@mail.gmail.com>
Subject: Re: [PATCH] ALSA: machine: update documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark,

Do you have any comments, or should I
go ahead and respin the patch to address
the review comments?

On Sat, Nov 2, 2024 at 9:30=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> On Sat, Nov 02, 2024 at 12:37:18AM -0700, anish kumar wrote:
> > +Additionaly below example macro can be used to register cpu, codec and
> > +platform dai.
> > +
> > +SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
> > +     DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
> > +     DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
> > +     DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
> > +
>
> Make the macro usage a literal code block:
>
> ---- >8 ----
> diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/so=
c/machine.rst
> index af7bad7ba13455..8788953cd160f5 100644
> --- a/Documentation/sound/soc/machine.rst
> +++ b/Documentation/sound/soc/machine.rst
> @@ -76,9 +76,9 @@ either dai name or device tree node but not both. Also,=
 names used here
>  for cpu/codec/platform dais should be globally unique.
>
>  Additionaly below example macro can be used to register cpu, codec and
> -platform dai.
> +platform dai::
>
> -SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
> +  SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
>         DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
>         DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
>         DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
>
> >  Machine Power Map
> > ------------------
> > +---------------------------
>
> Keep the section underline length as-is.
>
> >  Machine Controls
> > -----------------
> > +-----------------------
>
> Likewise.
>
> > +Clocking Controls:
> > +=E2=80=94-----------------
> > +
>
> Fix the underline to render the section name as a heading:
>
> ---- >8 ----
> diff --git a/Documentation/sound/soc/machine.rst b/Documentation/sound/so=
c/machine.rst
> index 8788953cd160f5..bdb9dfc5d88e45 100644
> --- a/Documentation/sound/soc/machine.rst
> +++ b/Documentation/sound/soc/machine.rst
> @@ -113,8 +113,8 @@ Machine Controls
>  Machine specific audio mixer controls can be added in the DAI init funct=
ion.
>
>
> -Clocking Controls:
> -=E2=80=94-----------------
> +Clocking Controls
> +-----------------
>
>  As previously noted, clock configuration is handled within the machine d=
river.
>  For details on the clock APIs that the machine driver can utilize for
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara

