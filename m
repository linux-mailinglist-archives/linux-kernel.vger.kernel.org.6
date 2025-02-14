Return-Path: <linux-kernel+bounces-514534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC8BA35830
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AE5169A62
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048FE2116F3;
	Fri, 14 Feb 2025 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJDQZWsv"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431C21B8F6;
	Fri, 14 Feb 2025 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519318; cv=none; b=nHVFapKY6DPF/to4WNxrdK5HxRAvdiPQUlX+kONOHDnW53tCM+/Wpx2ePdGEhBSaG6kPms5gw0uw8mpSnELxSReIwV0nCem1bp6Re7wn8qMdAQ/OFCgptIf/9lEd0mOzRswUBwvU6mOOyJ2+KV1SOKylJyOSBiIrXBDpNBqw5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519318; c=relaxed/simple;
	bh=m1eG8KHMaFDsXpSi9FNYwgNLf+4v4sQjZ2SUbZoKMYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOCZmKgT4ZRLfErNGPu1UQi6v+HM6AaxPH3NoV+tDIIpGPwRDb/AtYtjhGib+Fvw8fSpBcV+GI65rcIItJhQvkfJFmcpLwtx8Qkaw6FNXva8pU+o9zCtTwdSGRBeCcFj0vpKKkP+EnYVhIZMKeO9tq1dloM7dFRPZmzu+VLyqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJDQZWsv; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85571bd0203so35864439f.3;
        Thu, 13 Feb 2025 23:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739519316; x=1740124116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=731rFs0ET7FwAGuOR3hr8cPMl7QFrpHqNeXFCTqMoFY=;
        b=PJDQZWsvNoY9yBvrRikwjz+68NwHrN5BFrCLt39dRzLlFp0pUTmsLaHIKZtNHmqArl
         2jZP1DatEDXTho0mM4VdpZGanPpOnzItIt7IaBSi3laZ80RV6aN9Degq29b3FdZg4Xtu
         Za5afNUndASwYy+dff0D/qwyXDxvlghBzGgdrXOsdgzEvw8a5Y/d5yPBLRACCJtgPdrB
         tHC2KYivbhi2boVsq/h+T5kXtWAECkR3tMGJzCw/omTAvT2YIjc5iFEugaxaRfCCj+Cq
         KkoEhjPYjrdq1uWx4is1uw4a1c6RPty8Pih5pVpuK8MxF48Ib7xitt9Iuv0nAy7ojBrv
         pKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739519316; x=1740124116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=731rFs0ET7FwAGuOR3hr8cPMl7QFrpHqNeXFCTqMoFY=;
        b=NTkX6BgkBenVdF+jIF1tUvwqDd/7mfpQF5jGM2ekN2G2jmLTntBKYt7B0kIlsZhNwA
         /QrH6tNZf55hqk3lvaREXF51r+TMqLL7hMuu2gCDGQTqwiP62O4sCiUAUCphE1wb8KYr
         yTzW3iZVOnYTx0y5UwgjqDQVJXt7Kr/bxm46AnzAoYP05+OOXcqp5+RlNsjT8UZwfS6/
         +ShGQQauL+rpuEmSZn2AFpTjI2xZTl6z357X8+DQKIG7SERPann1+fjuWJHissaGcBIY
         XGa794r16pX6e6Cu27oYglaoOzA6kD0MdAInFnDQP/1ahusrHpYJzqdD26PapTbcvWwK
         OxfA==
X-Forwarded-Encrypted: i=1; AJvYcCUDDmb7XbR/w865H/bBGxVsuCA6O6hLf456J4ZUXM52P00DNgowr0B6zRviR0x/ZrHvyMRk20f5BhnrKN8=@vger.kernel.org, AJvYcCWhtrCiYy0tXHeSdDgEnaWWN3PCm6us1qfD+ZLc34hS3ruktfe1gzl3W/IFrNE0CzAu1L03USt1+1RdXFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvj1RBmPCSLvJWTFXTOvpAUu+9oPYCypVC7OCfTlFT6Wz0oJA
	ATRw0eiSNZMb4d3RemAeUfl5nxG1BIxLoH02GP1nce8cIubbYgZc3mSynUkWpgc8vnqsY0aqZ5V
	rFOc78/mq1/A3kTSphXqUYLuGLXw=
X-Gm-Gg: ASbGnctsCiwlYmECHHi42Q2EDGdweuqtBk2FTlDUsAYp4296ZIsgReRNq0XOHyGc/yV
	ZY5US4zb+iADny30V0kohAySMie6Y0Ttfk26E1Q710qQLCH1IceY5a59QF/nQNlXkv85qDeM/
X-Google-Smtp-Source: AGHT+IE22ipUxc6uvPnQnBkwGLFiXLKEtvMmYd7z3k09O1lrpjChkZ/Hbhfrn7x//qqetG+GUnCsfUC8k47APTHaH6M=
X-Received: by 2002:a05:6e02:3689:b0:3d0:11ff:a782 with SMTP id
 e9e14a558f8ab-3d18c231101mr54357335ab.9.1739519315915; Thu, 13 Feb 2025
 23:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214071747.229719-1-chancel.liu@nxp.com>
In-Reply-To: <20250214071747.229719-1-chancel.liu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 14 Feb 2025 15:48:24 +0800
X-Gm-Features: AWEUYZm_evk9kNSA0Rf-nfbp1PH6GJ4BxmVu1WRP18sINX7eFOA6CuSK3yph-h8
Message-ID: <CAA+D8AMbW=iWZ1VCWuZvE2u4EHy9FeEMgDBxpTO9XupZeyUzCA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Rename stream name of dai driver
To: Chancel Liu <chancel.liu@nxp.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 3:18=E2=80=AFPM Chancel Liu <chancel.liu@nxp.com> w=
rote:
>
> If stream names of dai driver are duplicated there'll be warnings when
> machine driver tries to add widgets on a route:
>
> [    8.831335] fsl-asoc-card sound-wm8960: ASoC: sink widget CPU-Playback=
 overwritten
> [    8.839917] fsl-asoc-card sound-wm8960: ASoC: source widget CPU-Captur=
e overwritten
>
> Use different stream names to avoid such warnings.

Only this change should cause issue for imx-audmix driver.

Best regards
Shengjiu Wang

>
> Fixes: 15c958390460 ("ASoC: fsl_sai: Add separate DAI for transmitter and=
 receiver")
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
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
> --
> 2.47.1
>

