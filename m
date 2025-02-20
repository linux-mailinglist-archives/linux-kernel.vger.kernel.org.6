Return-Path: <linux-kernel+bounces-523238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256AEA3D40B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5473AF859
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2391DDC0F;
	Thu, 20 Feb 2025 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arxK8sDK"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADABB179BC;
	Thu, 20 Feb 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042057; cv=none; b=b95FlEcaByrEVPsQqXFIJ5XZSFgiZg/ol7izbf/0TEr8GPNRd8jHzr859rHyJBiI4bVwYx/r8mBYesnzCfZDX8tBkrXovGVJoh+JBJhc5MvQmJcKxjmPiXpI+OGLk4ii9AVQIuZ/0EYukQT/fFnik5NY2VgcVJ8XQzU/D5tBci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042057; c=relaxed/simple;
	bh=k1RPRZKDI8/Bp3aYAsa2oz9j2Jw8i8GJfERP0AXGqkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXUtPN85HbhpJJvn1d1RLyNhhn3KKL+T8y81o7x0KVhDsVVHIDIBXhK4hPLLXzgdn2UY131nYzMhwkpXCg8kiFOzT9fjAwKKwedPSfVzRpqDUXxtT2LJnEAaG6jeaw4l+AYMokHFqwe/Q85RJgLUzydtEu7smQe2IDIy0YVxQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arxK8sDK; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85598a3e64bso62567039f.1;
        Thu, 20 Feb 2025 01:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740042053; x=1740646853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBGc9kjWvcTT8TmY8LuieFVJI4yuvG9ph/k+PfRmzSM=;
        b=arxK8sDKxK9lfOIyAilvfmUl9rO1LoME12lMTEEpw2CrZtki2BBbY/QNJBcHYlXi9T
         cXk4xJStmH6DVq7/QbW8ETC7eYWTtTOOy0/V6VBuewyXWCz6XPhNWpq04/TmUKTDo4Fs
         UDiszFTHlxZiDoxhA2diIASUMCi7Qn7r5WsSIjdQz/XY5QAEb622RvuEu0GMnH3Asyp2
         6d0i4cLp3B4lYWKQbXr9R1b368yoca25Ag6eaYy6dAhwW7oqELif8d3PkVJyHUNS0Qqy
         PxsKK8U+qtYZl1+nivzAEJLj59Jt1Zuiq4Imdo6jmFuIABJEnEyqz5/TzJYDOfFJVh8z
         tnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740042053; x=1740646853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBGc9kjWvcTT8TmY8LuieFVJI4yuvG9ph/k+PfRmzSM=;
        b=JEYHj/R4+kVDdzBBX0qds7I5tzoky9V2qng01yUlKKxrS5Ab9nr4FvD2CvnMkuW/+i
         qB3gcFxUStC/xHWSgAo5/OZAitMkqkJ0jvSjQXbtl/SN3DTiLly4RIPudoeN5z/NuEzM
         EACwY+sZIwGVqu6yml7TPp8HzpI90E6Q6vdTdoNR61rat27FQzdLCox3GG/v/8yzVokR
         eRjjxL9/nyWM0s2MC4a28zbNbqO279hOZ1FJkTv3TLzV+NXDSGHCgfh3Zyc6EUlrD68a
         5fGv9rpOKARgRYgsKJpoP91xW8qB/uBd4L5/Li0OoV+Us24lKiaL90Gqo66ipcZm/IJf
         no+A==
X-Forwarded-Encrypted: i=1; AJvYcCVaeiRoNd0WoXozSCZAieiF/kDXXUaqc8JISvQlW0sN3YFFetU5W3Vr9NoZlP9mTrDfgZ0pqXJ0LLk1bB0=@vger.kernel.org, AJvYcCXYO/kdL4bLDrKYatLVIGFkELzPfjU14UnoyhYDnEh4su+lSKT1ymMR0qrSVKo1xfHN+eZgg/+7I2RLbO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/unHnKYr2hArMdGqPyv2SutqBc7moyXyUguV93IeO6+bCk3p
	c+HGwWDb+jwN2JnYOwYHrSIOuylNnghk0tEOyKDETRp1kX5UB6JOm5GM0XEY/+7dy6GBopRrcOn
	P0Z0qcVLEonhTSQKjEdvhfMoEzqg=
X-Gm-Gg: ASbGncuAfK6d0j4j2LKLzYFlEjY5xgfGr6eezlNheJ3fuM9LWWQauuEG8q4Ld6TjO6S
	WVMhx0bz8NQyrs2gPCZ+krUFWkBjvC9qmE0yfNCGgo6OxYkdr1rqoOM1qqlq4aqR6exmliGRs
X-Google-Smtp-Source: AGHT+IG7gp55gI6T7N19LupIXyNXuZGTOg7Z9WUU+BixH82XpixCePwY1tGVPmmyOmTvSK8jIL5m5WxoGCqGVuGTA9A=
X-Received: by 2002:a92:c26c:0:b0:3d2:b72d:a507 with SMTP id
 e9e14a558f8ab-3d2c25f4dcbmr17357385ab.19.1740042053529; Thu, 20 Feb 2025
 01:00:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217010437.258621-1-chancel.liu@nxp.com>
In-Reply-To: <20250217010437.258621-1-chancel.liu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 20 Feb 2025 17:00:40 +0800
X-Gm-Features: AWEUYZnC1Oj7Zc6v49m8gK1mM0DpiY64mpQR7L7KBjSe2s7uidTWDyh3xmP5pP0
Message-ID: <CAA+D8ANJR7rVo5e8jA5wk=rZmoPpJS-=9qZw9s2aSWadzWPEmg@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: fsl: Rename stream name of SAI DAI driver
To: Chancel Liu <chancel.liu@nxp.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 9:05=E2=80=AFAM Chancel Liu <chancel.liu@nxp.com> w=
rote:
>
> If stream names of DAI driver are duplicated there'll be warnings when
> machine driver tries to add widgets on a route:
>
> [    8.831335] fsl-asoc-card sound-wm8960: ASoC: sink widget CPU-Playback=
 overwritten
> [    8.839917] fsl-asoc-card sound-wm8960: ASoC: source widget CPU-Captur=
e overwritten
>
> Use different stream names to avoid such warnings.
> DAI names in AUDMIX are also updated accordingly.
>
> Fixes: 15c958390460 ("ASoC: fsl_sai: Add separate DAI for transmitter and=
 receiver")
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
> - changes in v3
> Squash two fix patches in one commit
>
>  sound/soc/fsl/fsl_sai.c    | 6 +++---
>  sound/soc/fsl/imx-audmix.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index c4eb87c5d39e..9f33dd11d47f 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -994,10 +994,10 @@ static struct snd_soc_dai_driver fsl_sai_dai_templa=
te[] =3D {
>         {
>                 .name =3D "sai-tx",
>                 .playback =3D {
> -                       .stream_name =3D "CPU-Playback",
> +                       .stream_name =3D "SAI-Playback",
>                         .channels_min =3D 1,
>                         .channels_max =3D 32,
> -                               .rate_min =3D 8000,
> +                       .rate_min =3D 8000,
>                         .rate_max =3D 2822400,
>                         .rates =3D SNDRV_PCM_RATE_KNOT,
>                         .formats =3D FSL_SAI_FORMATS,
> @@ -1007,7 +1007,7 @@ static struct snd_soc_dai_driver fsl_sai_dai_templa=
te[] =3D {
>         {
>                 .name =3D "sai-rx",
>                 .capture =3D {
> -                       .stream_name =3D "CPU-Capture",
> +                       .stream_name =3D "SAI-Capture",
>                         .channels_min =3D 1,
>                         .channels_max =3D 32,
>                         .rate_min =3D 8000,
> diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
> index 50ecc5f51100..dac5d4ddacd6 100644
> --- a/sound/soc/fsl/imx-audmix.c
> +++ b/sound/soc/fsl/imx-audmix.c
> @@ -119,8 +119,8 @@ static const struct snd_soc_ops imx_audmix_be_ops =3D=
 {
>  static const char *name[][3] =3D {
>         {"HiFi-AUDMIX-FE-0", "HiFi-AUDMIX-FE-1", "HiFi-AUDMIX-FE-2"},
>         {"sai-tx", "sai-tx", "sai-rx"},
> -       {"AUDMIX-Playback-0", "AUDMIX-Playback-1", "CPU-Capture"},
> -       {"CPU-Playback", "CPU-Playback", "AUDMIX-Capture-0"},
> +       {"AUDMIX-Playback-0", "AUDMIX-Playback-1", "SAI-Capture"},
> +       {"SAI-Playback", "SAI-Playback", "AUDMIX-Capture-0"},
>  };
>
>  static int imx_audmix_probe(struct platform_device *pdev)
> --
> 2.47.1
>

