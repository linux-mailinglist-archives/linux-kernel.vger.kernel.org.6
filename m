Return-Path: <linux-kernel+bounces-239097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3F92562E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A893AB24620
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811713C3DD;
	Wed,  3 Jul 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTH8hQFi"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB564D584;
	Wed,  3 Jul 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997972; cv=none; b=ZX5+22FAGV4RBiL7SA9YfeIZqhCHuNZ+pBCneJ6vK7GxnDSR1s0LoQjUHdJZ6F3WH8ZRi8dQLFQlo1RU+ZEIWct7TyuJEMPUWjAY5ydKW1JKCRQkzqfZbDnwg/DFhoKOBI2djLa3Zwog7U8DeyLw2F1mRx3nFYIl9a5QrZf96kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997972; c=relaxed/simple;
	bh=fZjR28pBAkt6eSylkI8DEksfa2ZuVwFoI2Oxi5vkpOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNJe1CGN1TTm9y21qQq5q9DBd0/kb+kA7awQt2ND4QkCbiVO9n+xFjTreud0XaIU1qcHk+cnOm7jrFOcY+4sPh0uBTqi/5PHAXOa5PTY02PpKT/6izBewbHET+d/FPdnpBuHECc1K065GIGCg5g5mq05Ith3n3oabzVlBPgSs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTH8hQFi; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-375e96f5fddso18821835ab.1;
        Wed, 03 Jul 2024 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719997970; x=1720602770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jI0rslYrv6mUgs3l1hovuzLhd9gfH1CvVqaU89w3P0=;
        b=MTH8hQFirNBf4lGwKB4khOmszChC246s1bRtubp7LAEdkGwMzbZlIHUSmlXBMtWBDP
         xXbYU0HPudwlq5d2+g2lk8eJIsDM2PCfSEta6plx4Uq41gt18Tj7laHeMXr0ml7qe7KX
         ILmFuEAoCzNt/8Bxc8rkf7UBFsqkFZBqZP2liQqWkjclJS7Gm6MiRhZsV/SLKQHI1l8i
         6b5zNZfqW5iaXbk9oK9ijAZtxovqJqH8SuQ6rOUR1d0hxwGf9dDCIbaro4/JeMtbth/V
         htOQIQITlxX4J4Zc8rD9nFK6Im86mYb5Uq34UJbnwA6uy1PRBGW6hakNFSRW/AQz3H8e
         VnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719997970; x=1720602770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jI0rslYrv6mUgs3l1hovuzLhd9gfH1CvVqaU89w3P0=;
        b=GIr6ozBncO6w/IybSs9Gp6rwwtW4c9icAhBwkvfRCA6L45W9oBki5gXsqiSKdrbKNp
         qst8w6QmL/Y1RERVMNr3swGe/7/hKtl+UgJsw5SOGQ7MoqoArqpT7GuRmHStsHmHKYo1
         g8fWD61uZoEZFhjdu6sYvNKwZye6eUiBcgOSjVHePiknDeoGPGAKkVylKUKYCStW/2h/
         bhi7YJdH4oZ1hu6jl0dWl07KQHeHRwHgWzDprUgGneJ3SElpuD5w77DZgnxfo+yRMy/w
         ZrRSPTNsPW3Z9gmj4zw7vZWRIF/8Bbk+ZT+KHKCt7Pj+xiYvkzkFNh7phK56ANbmVmcu
         wpDg==
X-Forwarded-Encrypted: i=1; AJvYcCUFk1+0Plv6k3n7bRNxm3QQixYdA6GEHqcZsvTtArsCAT9DizqfI/uaFIxIgjNdByqbZYrJVmzhS4wmFs/Z+63ykn7WR0z1AU3qgK+TqBW17fdGh1NkMURWLm1DTxIFmIiqT8Dx5gqWTd8=
X-Gm-Message-State: AOJu0YxjL41hXdnUhO0vX4FZLUJ/dyutH/DRRlYLlw9cnhDxgsRhuLZC
	FPNW88/FSLSk083V852vCUzmNbBSveY9cZwh5+88YWLtdYGG144EsJSFOaYAtKxqqKTf2d5ggo4
	qJaY+RfXUDDZdwzJlQLK8zUSenU00UIyGKIQ=
X-Google-Smtp-Source: AGHT+IG1ehcAilYAWAvfE7/9RzOn+5jnvezYCw9DkZlXjjrBfIA432A0Ksubc/kan0xqgCTbvKnpweLKFvy1Sc7lLho=
X-Received: by 2002:a05:6e02:1c2c:b0:374:b0d8:6c4 with SMTP id
 e9e14a558f8ab-37cd0afefdfmr127007475ab.3.1719997969760; Wed, 03 Jul 2024
 02:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628094354.780720-1-chancel.liu@nxp.com>
In-Reply-To: <20240628094354.780720-1-chancel.liu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 3 Jul 2024 17:12:38 +0800
Message-ID: <CAA+D8APvL_wo_L62M-LD88B9EZ6Sg89jtJrCkt4vuCuH3q9p4A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: Improve suspend/resume flow in fsl_xcvr_trigger()
To: Chancel Liu <chancel.liu@nxp.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 5:44=E2=80=AFPM Chancel Liu <chancel.liu@nxp.com> w=
rote:
>
> In the current flow all interrupts are disabled in runtime suspend
> phase. However interrupts enablement only exists in fsl_xcvr_prepare().
> After resume fsl_xcvr_prepare() may not be called so it will cause all
> interrupts still disabled even if resume from suspend. Interrupts
> should be explictily enabled after resume.
>
> Also, DPATH reset setting only exists in fsl_xcvr_prepare(). After
> resume from suspend DPATH should be reset otherwise there'll be channel
> swap issue.
>
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/soc/fsl/fsl_xcvr.c | 43 +++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
> index 337da46a2f90..bf9a4e90978e 100644
> --- a/sound/soc/fsl/fsl_xcvr.c
> +++ b/sound/soc/fsl/fsl_xcvr.c
> @@ -529,16 +529,6 @@ static int fsl_xcvr_prepare(struct snd_pcm_substream=
 *substream,
>                 break;
>         }
>
> -       ret =3D regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
> -                                FSL_XCVR_IRQ_EARC_ALL, FSL_XCVR_IRQ_EARC=
_ALL);
> -       if (ret < 0) {
> -               dev_err(dai->dev, "Error while setting IER0: %d\n", ret);
> -               return ret;
> -       }
> -
> -       /* set DPATH RESET */
> -       m_ctl |=3D FSL_XCVR_EXT_CTRL_DPTH_RESET(tx);
> -       v_ctl |=3D FSL_XCVR_EXT_CTRL_DPTH_RESET(tx);
>         ret =3D regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_CTRL, m_ctl=
, v_ctl);
>         if (ret < 0) {
>                 dev_err(dai->dev, "Error while setting EXT_CTRL: %d\n", r=
et);
> @@ -679,6 +669,15 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream=
 *substream, int cmd,
>         case SNDRV_PCM_TRIGGER_START:
>         case SNDRV_PCM_TRIGGER_RESUME:
>         case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +               /* set DPATH RESET */
> +               ret =3D regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_CTR=
L,
> +                                        FSL_XCVR_EXT_CTRL_DPTH_RESET(tx)=
,
> +                                        FSL_XCVR_EXT_CTRL_DPTH_RESET(tx)=
);
> +               if (ret < 0) {
> +                       dev_err(dai->dev, "Failed to set DPATH RESET: %d\=
n", ret);
> +                       return ret;
> +               }
> +
>                 if (tx) {
>                         switch (xcvr->mode) {
>                         case FSL_XCVR_MODE_EARC:
> @@ -711,6 +710,13 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream=
 *substream, int cmd,
>                         return ret;
>                 }
>
> +               ret =3D regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER=
0,
> +                                        FSL_XCVR_IRQ_EARC_ALL, FSL_XCVR_=
IRQ_EARC_ALL);
> +               if (ret < 0) {
> +                       dev_err(dai->dev, "Error while setting IER0: %d\n=
", ret);
> +                       return ret;
> +               }
> +
>                 /* clear DPATH RESET */
>                 ret =3D regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_CTR=
L,
>                                          FSL_XCVR_EXT_CTRL_DPTH_RESET(tx)=
,
> @@ -733,6 +739,13 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream=
 *substream, int cmd,
>                         return ret;
>                 }
>
> +               ret =3D regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER=
0,
> +                                        FSL_XCVR_IRQ_EARC_ALL, 0);
> +               if (ret < 0) {
> +                       dev_err(dai->dev, "Failed to clear IER0: %d\n", r=
et);
> +                       return ret;
> +               }
> +
>                 if (tx) {
>                         switch (xcvr->mode) {
>                         case FSL_XCVR_MODE_SPDIF:
> @@ -1411,16 +1424,6 @@ static int fsl_xcvr_runtime_suspend(struct device =
*dev)
>         struct fsl_xcvr *xcvr =3D dev_get_drvdata(dev);
>         int ret;
>
> -       /*
> -        * Clear interrupts, when streams starts or resumes after
> -        * suspend, interrupts are enabled in prepare(), so no need
> -        * to enable interrupts in resume().
> -        */
> -       ret =3D regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
> -                                FSL_XCVR_IRQ_EARC_ALL, 0);
> -       if (ret < 0)
> -               dev_err(dev, "Failed to clear IER0: %d\n", ret);
> -
>         if (!xcvr->soc_data->spdif_only) {
>                 /* Assert M0+ reset */
>                 ret =3D regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_CTR=
L,
> --
> 2.43.0
>

