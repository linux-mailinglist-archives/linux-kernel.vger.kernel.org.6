Return-Path: <linux-kernel+bounces-235528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB52C91D639
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600AC1F218C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B9D535;
	Mon,  1 Jul 2024 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfc4BvKw"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95783BA20;
	Mon,  1 Jul 2024 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719801550; cv=none; b=ZYzBNY4dvSS4sV1iNItm8+BWivGLMjUygpC34EwkXmVsYCYkhpn/qkR9zWmBU36SLLnuMwlU2qK4PMODG00Nb7hRAqsXfifjlus0bZflkhFh51SRurwmAWjlwUgqt5WWFhwjIEDC6bxtrk6qssuOpEXyTWJIXKQtTefuilqDzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719801550; c=relaxed/simple;
	bh=xzi07c7GKOJME/WHCQ/3gDV2INYWUviFigFkDt43Gj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTHjs0KfsijtNEq0K/281I5R2fBdO4xUFHe6FnM1P6BPL8i31dLvg78Vhh3dHWTUJJ27MUWM++ik2Xd4XCkiCFPmTah1p6YFxy/4sgsptMv/zL7WxE/gesiMvSTKSwaqtjVMsi+RqpPVFl+SY0fK/w1e3S3En9DAtICnGolWyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfc4BvKw; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-375af3538f2so13030635ab.3;
        Sun, 30 Jun 2024 19:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719801548; x=1720406348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y40QwGli4KT7ff1uF7HzZYK9rm2EfcOvxXXgg3mEqoo=;
        b=gfc4BvKwtNjbhn612P3gd2BkPZDI4dQJqSIXo1mf8WUk7qluv7VV7AgTwsUVktOtJx
         VxMz+uzkUSi7yD/G9RVzFMnwamfebBFXxvo2Dw++s8cR+G4hqn4QenlhuLKXn/0xvJHt
         sfloPcLqCHF9/geABbT6M2Q6xI6B1oDIDC2P5nH7InBE3Bz+YK8YrFcKHoofeaLzUKl0
         B8lRFXSP8zVwjViRQ65+EMjXckGthTdVsGxIOJFPBBdu8+133KkgxdgZVeL3x4DsLeF4
         xS2ghLut41YgcaKmxPZwCZkiMnXg7PLJZtRcohOyEwgWRU2PLBsNNxjcZ0TmRTPKnys+
         XulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719801548; x=1720406348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y40QwGli4KT7ff1uF7HzZYK9rm2EfcOvxXXgg3mEqoo=;
        b=tUf1gRjZbz7fBrhBy9OE3QM839Ay4g/okK+GlR3oCijaYmhYfw3KPNemK70hBNzUqh
         FC5UdvEQBZ04AE0mC/smov5Se+yOF+Y8HHvv450eARDBsbQFAZdfNK3kclNp+Toybvgk
         G0zKRDPypvFfv3OCi+kNLw5x+1H4VBliCVe4cGGfURbztuq/MeXYK0qrsP7nTgLHLb3Z
         itahnT3bFy/eZgtskS9IUOvtCAYYeE4V9sug4XSnjaWgJ2czog6prZ0uoy+PrB+kSTUT
         XOedqBTzCuosRPz1jMiA/msZUworzYpmESPUqH0wJkUjjfmo4s7DfeV6uQxw7UcAPKq9
         BCJA==
X-Forwarded-Encrypted: i=1; AJvYcCVSskonn/NVRfbKQ00OJnoAiTMtTSha4Q/GOEsg8t901T4Ga3ou+jPQw4AR5Y4E5Km0RH2KmJ94YEdAgx7gaiTM6Krqv9J8TyxBGgPOUk2t6VJ3EOmyrkqZbwXMa5+3BR7XeRyh2Pu2AV182WForGACV3kcXuNhaeWf6iYIHDseYUSSPZ+J
X-Gm-Message-State: AOJu0YzT20sN6zGNwzUVHJhXZxVs+MS5py4tbxu7XL+s4aTIjAave9cN
	r7piWXEoI1EA0veyfEcnxbXboJwYM3g/S734Pk7lnOa/rvRzEfMxgHeV7CWmJwFsjsjL53Dg1tc
	Xig8X5UL+NUEik32IbYpJyPfOAVE=
X-Google-Smtp-Source: AGHT+IFl6hhIVwcNWvb7KuIdXA/G8P41RTV32LeQ6fy/SVP0IkTxdaNJCEE4hHhayovF9Ke2gw9gVLaBx7hagg/hTfU=
X-Received: by 2002:a05:6e02:b46:b0:375:a4e5:1dc9 with SMTP id
 e9e14a558f8ab-37cd0913b1fmr60376685ab.4.1719801547584; Sun, 30 Jun 2024
 19:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626071202.7149-1-chancel.liu@nxp.com> <20240626071202.7149-2-chancel.liu@nxp.com>
In-Reply-To: <20240626071202.7149-2-chancel.liu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 1 Jul 2024 10:38:56 +0800
Message-ID: <CAA+D8ANH8+FBsatondzSfiVD0H0BweRdPLOmoPaBNW6gMFck_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_rpmsg: Add support for i.MX95 platform
To: Chancel Liu <chancel.liu@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, Xiubo.Lee@gmail.com, 
	festevam@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 3:12=E2=80=AFPM Chancel Liu <chancel.liu@nxp.com> w=
rote:
>
> Add compatible string and specific soc data to support rpmsg sound card
> on i.MX95 platform.
>
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/soc/fsl/fsl_rpmsg.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_rpmsg.c b/sound/soc/fsl/fsl_rpmsg.c
> index bc41a0666856..467d6bc9f956 100644
> --- a/sound/soc/fsl/fsl_rpmsg.c
> +++ b/sound/soc/fsl/fsl_rpmsg.c
> @@ -175,6 +175,14 @@ static const struct fsl_rpmsg_soc_data imx93_data =
=3D {
>                    SNDRV_PCM_FMTBIT_S32_LE,
>  };
>
> +static const struct fsl_rpmsg_soc_data imx95_data =3D {
> +       .rates =3D SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_32000 |
> +                SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> +                SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
> +       .formats =3D SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
> +                  SNDRV_PCM_FMTBIT_S32_LE,
> +};
> +
>  static const struct of_device_id fsl_rpmsg_ids[] =3D {
>         { .compatible =3D "fsl,imx7ulp-rpmsg-audio", .data =3D &imx7ulp_d=
ata},
>         { .compatible =3D "fsl,imx8mm-rpmsg-audio", .data =3D &imx8mm_dat=
a},
> @@ -182,6 +190,7 @@ static const struct of_device_id fsl_rpmsg_ids[] =3D =
{
>         { .compatible =3D "fsl,imx8mp-rpmsg-audio", .data =3D &imx8mp_dat=
a},
>         { .compatible =3D "fsl,imx8ulp-rpmsg-audio", .data =3D &imx7ulp_d=
ata},
>         { .compatible =3D "fsl,imx93-rpmsg-audio", .data =3D &imx93_data}=
,
> +       { .compatible =3D "fsl,imx95-rpmsg-audio", .data =3D &imx95_data}=
,
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, fsl_rpmsg_ids);
> --
> 2.43.0
>

