Return-Path: <linux-kernel+bounces-381042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6676B9AF97B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF2F1F2329A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3226918DF9C;
	Fri, 25 Oct 2024 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/GRkY7U"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975FA23B0;
	Fri, 25 Oct 2024 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836140; cv=none; b=B+WwBZJzy3byegjHIyQiA/ED8CMAnrn0T5CHSZZGRkPmfrRiK0LbGJIcwMjt2p1zSbP/XWqfRH/xyDJQc1XkvUSud0VDd59DQ5k72/dnZlFLmjqwE9F5bUq6ns9Rbvo1nEtxTX0uCT3AbJS0XP35tbrbl4NTE+YMvdiXI8UCBqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836140; c=relaxed/simple;
	bh=pGlfs/87qW5cbPgrdBoGrYcf0Is6B0O5L6yHvRn1rAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEsDeBL13zY6oNTylURY4n+dYahsTX915uQDHQqQP48aBkJBHGqTTRbnm3ZT1wZO2BQHbunr/7g6eP2IzpjpZFf8Cfa31J2SYXF4Vyqn/7EsGx17gzduorgVKOBh20iU1a0VRHzCFJpRvLmMK/EWyhWhIZUftl9gc3QDBDpCG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/GRkY7U; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a3b463e9b0so6409065ab.3;
        Thu, 24 Oct 2024 23:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729836138; x=1730440938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDg+Vcaf01znu6tLfRn2IhIdAlHb4VMVWFTZr0BKPgA=;
        b=B/GRkY7U8g3XneQzpt1adKNbK2j9EALwzEhysp9QJ8e2lZM+z8R+87X5IHYDPljomv
         rbHfc7xe5tesotwGaNzFNWZGraIEPfkuX+r8yHU6ta45SKaTa3gzLIKxaKWs75xFyg6f
         qKPIFjV6PRIRcfWz5ft0LB78ghZJTtC5/H1sCJ1lICjiE/5eHZlt9Th6ohdVNcBhYtdZ
         AcV4WjtRql+js7DlBeqDhtP8TtoJppFEBVxraziKU6m3lVMiF4RoSSOUn+qkkpQEpQgW
         JdFKx3+BTeHimm6tGxbOuEFuWENc+ilv2EMNEWbXquganOfi008ULB6p0sdtjOeyuI0Q
         Xo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836138; x=1730440938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDg+Vcaf01znu6tLfRn2IhIdAlHb4VMVWFTZr0BKPgA=;
        b=wW3pQ0reGTZy5d1uqDZvxehJCcQagNK6y/vZJx8hTxprrcsNoz+uUoK7ea1R2XWKlp
         x3Khy4J8E5r6O1nlTG1YxpZ0uc+ncjpux5hn9AUbSiGyLEg0ZxJ5xH+fDKZEtzJSdY/8
         v9V0eqSJz0HAS1V31KbH58NxbyM/ht+Wj0jsmRRumQvuTB+r5KLT0pWyz45ma6DYOvXG
         wGBwAC1g84s5ORrNOHk6kKWyQOqVsVtLjX9Q7zPuOy1f7O3XRqRcZ4Lus6aNpvAWA0VN
         shcV+rxkJclE4lVqjvJCc2/F808TsOrHVaRfl5wDMVvIq35HZOV97BR5Qz2xGU1ZlSB0
         mAWw==
X-Forwarded-Encrypted: i=1; AJvYcCUZX9xwd1Wfb2F775ODKQu6Wr+f+Jr9Bj8vAD4QAeKZ9Pp8wvK9nE+VX6e/cNeuAxqzWLNDgzDRNf0F5Q8=@vger.kernel.org, AJvYcCW5wfblKkSW3fgRtd2VtqZAX3ECuQndhLPhS817khyz7Ei0IAXJaw/BZGjWeWaaiuVs3l1CKUbxqwZ7xFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznjm/lN8/JfgMQoMFnz4C39AVd7zCZbtYLLcX5VlULOp7OvGA8
	bqAAKq0RzWHstDco9Mwcp1gwvG/85YMUaQ3SADnUzJDjerfjdka5GbStCQL9+NlE8bk3ytQcLTL
	JppohaB5E2Dg5+KRi6Z5ipPKYH+Q=
X-Google-Smtp-Source: AGHT+IHI96rZzZ22LDvmBdQuWwH021STYYNGPQR+XjhKSil2TgSc4rDCozUvDSoqdcK4KvzLi4ZSRjHMWOc3Tbh0J84=
X-Received: by 2002:a05:6e02:1c0e:b0:3a4:d9d0:55a6 with SMTP id
 e9e14a558f8ab-3a4de80b425mr47871735ab.19.1729836137602; Thu, 24 Oct 2024
 23:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728712330-4389-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1728712330-4389-1-git-send-email-shengjiu.wang@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 25 Oct 2024 14:02:02 +0800
Message-ID: <CAA+D8ANM9QYe3idfkp5XJOXwqQUQ-qc_FcpQSKFDzQVhuTWZKw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_mqs: Support accessing registers by scmi interface
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 2:15=E2=80=AFPM Shengjiu Wang <shengjiu.wang@nxp.co=
m> wrote:
>
> On i.MX95, the MQS module in Always-on (AON) domain only can
> be accessed by System Controller Management Interface (SCMI)
> MISC Protocol. So define a specific regmap_config for the case.
>

find an issue when IMX_SCMI_MISC_DRV=3Dm but SND_SOC_FSL_MQS=3Dy
will send v2 to fix it.

Best regards
Shengjiu Wang

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_mqs.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
> index 145f9ca15e43..0513e9e8402e 100644
> --- a/sound/soc/fsl/fsl_mqs.c
> +++ b/sound/soc/fsl/fsl_mqs.c
> @@ -6,6 +6,7 @@
>  // Copyright 2019 NXP
>
>  #include <linux/clk.h>
> +#include <linux/firmware/imx/sm.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/mfd/syscon.h>
> @@ -74,6 +75,29 @@ struct fsl_mqs {
>  #define FSL_MQS_RATES  (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
>  #define FSL_MQS_FORMATS        SNDRV_PCM_FMTBIT_S16_LE
>
> +static int fsl_mqs_sm_read(void *context, unsigned int reg, unsigned int=
 *val)
> +{
> +       struct fsl_mqs *mqs_priv =3D context;
> +       int num =3D 1;
> +
> +       if (IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV) &&
> +           mqs_priv->soc->ctrl_off =3D=3D reg)
> +               return scmi_imx_misc_ctrl_get(SCMI_IMX_CTRL_MQS1_SETTINGS=
, &num, val);
> +
> +       return -EINVAL;
> +};
> +
> +static int fsl_mqs_sm_write(void *context, unsigned int reg, unsigned in=
t val)
> +{
> +       struct fsl_mqs *mqs_priv =3D context;
> +
> +       if (IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV) &&
> +           mqs_priv->soc->ctrl_off =3D=3D reg)
> +               return scmi_imx_misc_ctrl_set(SCMI_IMX_CTRL_MQS1_SETTINGS=
, val);
> +
> +       return -EINVAL;
> +};
> +
>  static int fsl_mqs_hw_params(struct snd_pcm_substream *substream,
>                              struct snd_pcm_hw_params *params,
>                              struct snd_soc_dai *dai)
> @@ -188,6 +212,13 @@ static const struct regmap_config fsl_mqs_regmap_con=
fig =3D {
>         .cache_type =3D REGCACHE_NONE,
>  };
>
> +static const struct regmap_config fsl_mqs_sm_regmap =3D {
> +       .reg_bits =3D 32,
> +       .val_bits =3D 32,
> +       .reg_read =3D fsl_mqs_sm_read,
> +       .reg_write =3D fsl_mqs_sm_write,
> +};
> +
>  static int fsl_mqs_probe(struct platform_device *pdev)
>  {
>         struct device_node *np =3D pdev->dev.of_node;
> @@ -219,6 +250,16 @@ static int fsl_mqs_probe(struct platform_device *pde=
v)
>                         dev_err(&pdev->dev, "failed to get gpr regmap\n")=
;
>                         return PTR_ERR(mqs_priv->regmap);
>                 }
> +       } else if (mqs_priv->soc->type =3D=3D TYPE_REG_SM) {
> +               mqs_priv->regmap =3D devm_regmap_init(&pdev->dev,
> +                                                   NULL,
> +                                                   mqs_priv,
> +                                                   &fsl_mqs_sm_regmap);
> +               if (IS_ERR(mqs_priv->regmap)) {
> +                       dev_err(&pdev->dev, "failed to init regmap: %ld\n=
",
> +                               PTR_ERR(mqs_priv->regmap));
> +                       return PTR_ERR(mqs_priv->regmap);
> +               }
>         } else {
>                 regs =3D devm_platform_ioremap_resource(pdev, 0);
>                 if (IS_ERR(regs))
> --
> 2.34.1
>

