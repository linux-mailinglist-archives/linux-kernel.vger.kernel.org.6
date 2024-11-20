Return-Path: <linux-kernel+bounces-415809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC589D3CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3F82826BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469C1AAE3B;
	Wed, 20 Nov 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ywgjHL4z"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7881A4F19
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110979; cv=none; b=ehy44XAwptE5YNu1hzqVaG+cVTd5yxzBjhIboXl92JMDdhkrEXXjJqoRw29GhZvx7VBnbd9Gqz4FtMqz8mAM8IaplsIgpTOKrnRuJiCsNlH0J53nXT6iAd4ccFWC3Y++Eca8egvodyalKe3hCFd4/d8t1nDrpfoC1yj9bqTYCTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110979; c=relaxed/simple;
	bh=dfwcfgfI4H85Ukr3770WXJoLmT/uQHvNcLTWBiKiEZs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jvvwDBzPpOYn5OyC76Tw6Sgwa+eAZ1M0VkaDhVdsA/JX8VJf3I+Z4ugXawO9K+nBFmwOcujdnzjNbpRECX3/AmdYaukoPvf7i7f0cwcPC4oOYSJYyI6TEkF7+0ew3yVSILw3qD3W5M8eFr/ZS7eIa3yXzhLY4udkEqrrpV+6h3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ywgjHL4z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so19328035e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1732110974; x=1732715774; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtLwiYWJMe5D9pQFX6Ax9Ul9+sGhVnnWmSdEh99pxKM=;
        b=ywgjHL4z7RnkNdF42dkBlG0P7vBOSh3+VQ/0c16Ht2fL6iu+SlFc81Dwf2DjmnKUK9
         OLM9VwCjlDkx9vDEvVTh3HZK0U9Gvh0luzxG1cB8WmMt8STz6F25F0AZoB+CvaF3q3NL
         0VWHk9dl6CuEA4u8lGMEDvoHnyD7jXgPIBjbE+SgFdSyJKXerOelmdAY83zCETogOTjJ
         5hmMoQuJf2+YjILj6nRyoSUaC/FVq6mCjuR196CD/ThT0/iTjadBU0h7cnfVEPyopYoK
         /9f8eDN0zkunDFdb0gAUMja0la9sJHSdRQbWt6ORbys87dxKDcZUFVLcodmRkWsNEgqD
         kvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732110974; x=1732715774;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LtLwiYWJMe5D9pQFX6Ax9Ul9+sGhVnnWmSdEh99pxKM=;
        b=HvPSUDXsdlKF18zCdZKfnO91o1uc1ST8fbcgjHrgfpmt2fxAxxNspQjN56sNsY45Ju
         U6jWDiCwYKbgUGeJkybfYWasNYeb8Lj2VhzF//gZznyRqovgmZ7RQmgJDAaBuz9gsdnn
         Jp9CYKlRw8oUZN+zeR2w6p5Tt065p02VPSIjDnjbfMMnJc7J04V6ET9Ss33eathbFCN4
         3KatIKedjUQoPtlCc1CobLJuQUlzCd/xjZr0SqA91dql81G0SDP89ZeN6WknAkHfPE2j
         DjuSjLqrBvtXnH1VDUK5gFyEw2vwvrlC7Lq0XRhIDrR+yreHAwr/hY7dzOpBK4Ma0wpS
         vhEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6/qxO3MgWWRn59OSUarYVZzXb+G2XPVnhJBpnkfswwr2yFevoKVIIQxAWhR7AduxohrA7xSUsG9ZTwr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49NmxT2TRMKKizeHk2OfqgVlzB3Z30TSj2qVAQHwFQ5jhQ+/O
	cpHwMinu9hNegKTeAnQ/BT5S+AtRrebcUDeQysHCPUi2MSFUJERFKzVP9AM4jCQ=
X-Gm-Gg: ASbGncvhyq146qMBrniYjMBZNfLb1MNCdOWFbtqluWAQhPxClE9cBVO2WS80o6EGBrP
	+pn+2xznA3zfGGLgUWkXdAPfty/QpKDmz+94iSv88yjwrFeFkKJYaH++F/W9RDaPhWYCLjiNr29
	YQ6GROcMW1D2++BJgrEncGjXmetuL+jmoOcu8Pk2DViuPwEoYcPqkllDW+aA5tiJYgXVCSsxzUu
	3aP1ef7KlqmHD/Kjmui3RaLUV0nYuXs4kzoIA9C4Acrak06APx6rNMdxVlzO2nRQr9HUu1PtMGA
	J0m5YgvzHpJLyj3yI0n224WGNTrR0JHZf+/pQgXJQ9NrXYCtR1FVeV/iKg==
X-Google-Smtp-Source: AGHT+IFbhr6TKRXwkCurmAT31SRDis1mjzKGAuhFO0ZzdznKHmroXbp056ni2cLo0orO+YGry+0/hQ==
X-Received: by 2002:a05:600c:511b:b0:42c:b750:1a1e with SMTP id 5b1f17b1804b1-43348906b4bmr27745045e9.0.1732110974377;
        Wed, 20 Nov 2024 05:56:14 -0800 (PST)
Received: from localhost (2a02-a210-0a3a-6f80-f04f-3897-bedf-0fb0.cable.dynamic.v6.ziggo.nl. [2a02:a210:a3a:6f80:f04f:3897:bedf:fb0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b4643194sm19681675e9.40.2024.11.20.05.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 05:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Nov 2024 14:56:13 +0100
Message-Id: <D5R23G53SGCV.3Q5FLUKYAA5V8@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: imx412: Add missing newline to prints
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241118-imx412-newlines-v1-1-152fe6863838@fairphone.com>
In-Reply-To: <20241118-imx412-newlines-v1-1-152fe6863838@fairphone.com>

On Mon Nov 18, 2024 at 10:45 PM CET, Luca Weiss wrote:
> Add trailing \n to dev_dbg and dev_err prints where missing.
>

Forgot to add:

Fixes: 9214e86c0cc1 ("media: i2c: Add imx412 camera sensor driver")
Cc: stable@vger.kernel.org

> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/media/i2c/imx412.c | 42 +++++++++++++++++++++-------------------=
--
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/media/i2c/imx412.c b/drivers/media/i2c/imx412.c
> index 0bfe3046fcc8726ef4e484d0fbf980422343fccc..c74097a59c42853ff2a1b600f=
28ff5aacedb1c6b 100644
> --- a/drivers/media/i2c/imx412.c
> +++ b/drivers/media/i2c/imx412.c
> @@ -547,7 +547,7 @@ static int imx412_update_exp_gain(struct imx412 *imx4=
12, u32 exposure, u32 gain)
> =20
>  	lpfr =3D imx412->vblank + imx412->cur_mode->height;
> =20
> -	dev_dbg(imx412->dev, "Set exp %u, analog gain %u, lpfr %u",
> +	dev_dbg(imx412->dev, "Set exp %u, analog gain %u, lpfr %u\n",
>  		exposure, gain, lpfr);
> =20
>  	ret =3D imx412_write_reg(imx412, IMX412_REG_HOLD, 1, 1);
> @@ -594,7 +594,7 @@ static int imx412_set_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_VBLANK:
>  		imx412->vblank =3D imx412->vblank_ctrl->val;
> =20
> -		dev_dbg(imx412->dev, "Received vblank %u, new lpfr %u",
> +		dev_dbg(imx412->dev, "Received vblank %u, new lpfr %u\n",
>  			imx412->vblank,
>  			imx412->vblank + imx412->cur_mode->height);
> =20
> @@ -613,7 +613,7 @@ static int imx412_set_ctrl(struct v4l2_ctrl *ctrl)
>  		exposure =3D ctrl->val;
>  		analog_gain =3D imx412->again_ctrl->val;
> =20
> -		dev_dbg(imx412->dev, "Received exp %u, analog gain %u",
> +		dev_dbg(imx412->dev, "Received exp %u, analog gain %u\n",
>  			exposure, analog_gain);
> =20
>  		ret =3D imx412_update_exp_gain(imx412, exposure, analog_gain);
> @@ -622,7 +622,7 @@ static int imx412_set_ctrl(struct v4l2_ctrl *ctrl)
> =20
>  		break;
>  	default:
> -		dev_err(imx412->dev, "Invalid control %d", ctrl->id);
> +		dev_err(imx412->dev, "Invalid control %d\n", ctrl->id);
>  		ret =3D -EINVAL;
>  	}
> =20
> @@ -803,14 +803,14 @@ static int imx412_start_streaming(struct imx412 *im=
x412)
>  	ret =3D imx412_write_regs(imx412, reg_list->regs,
>  				reg_list->num_of_regs);
>  	if (ret) {
> -		dev_err(imx412->dev, "fail to write initial registers");
> +		dev_err(imx412->dev, "fail to write initial registers\n");
>  		return ret;
>  	}
> =20
>  	/* Setup handler will write actual exposure and gain */
>  	ret =3D  __v4l2_ctrl_handler_setup(imx412->sd.ctrl_handler);
>  	if (ret) {
> -		dev_err(imx412->dev, "fail to setup handler");
> +		dev_err(imx412->dev, "fail to setup handler\n");
>  		return ret;
>  	}
> =20
> @@ -821,7 +821,7 @@ static int imx412_start_streaming(struct imx412 *imx4=
12)
>  	ret =3D imx412_write_reg(imx412, IMX412_REG_MODE_SELECT,
>  			       1, IMX412_MODE_STREAMING);
>  	if (ret) {
> -		dev_err(imx412->dev, "fail to start streaming");
> +		dev_err(imx412->dev, "fail to start streaming\n");
>  		return ret;
>  	}
> =20
> @@ -895,7 +895,7 @@ static int imx412_detect(struct imx412 *imx412)
>  		return ret;
> =20
>  	if (val !=3D IMX412_ID) {
> -		dev_err(imx412->dev, "chip id mismatch: %x!=3D%x",
> +		dev_err(imx412->dev, "chip id mismatch: %x!=3D%x\n",
>  			IMX412_ID, val);
>  		return -ENXIO;
>  	}
> @@ -927,7 +927,7 @@ static int imx412_parse_hw_config(struct imx412 *imx4=
12)
>  	imx412->reset_gpio =3D devm_gpiod_get_optional(imx412->dev, "reset",
>  						     GPIOD_OUT_LOW);
>  	if (IS_ERR(imx412->reset_gpio)) {
> -		dev_err(imx412->dev, "failed to get reset gpio %ld",
> +		dev_err(imx412->dev, "failed to get reset gpio %ld\n",
>  			PTR_ERR(imx412->reset_gpio));
>  		return PTR_ERR(imx412->reset_gpio);
>  	}
> @@ -935,13 +935,13 @@ static int imx412_parse_hw_config(struct imx412 *im=
x412)
>  	/* Get sensor input clock */
>  	imx412->inclk =3D devm_clk_get(imx412->dev, NULL);
>  	if (IS_ERR(imx412->inclk)) {
> -		dev_err(imx412->dev, "could not get inclk");
> +		dev_err(imx412->dev, "could not get inclk\n");
>  		return PTR_ERR(imx412->inclk);
>  	}
> =20
>  	rate =3D clk_get_rate(imx412->inclk);
>  	if (rate !=3D IMX412_INCLK_RATE) {
> -		dev_err(imx412->dev, "inclk frequency mismatch");
> +		dev_err(imx412->dev, "inclk frequency mismatch\n");
>  		return -EINVAL;
>  	}
> =20
> @@ -966,14 +966,14 @@ static int imx412_parse_hw_config(struct imx412 *im=
x412)
> =20
>  	if (bus_cfg.bus.mipi_csi2.num_data_lanes !=3D IMX412_NUM_DATA_LANES) {
>  		dev_err(imx412->dev,
> -			"number of CSI2 data lanes %d is not supported",
> +			"number of CSI2 data lanes %d is not supported\n",
>  			bus_cfg.bus.mipi_csi2.num_data_lanes);
>  		ret =3D -EINVAL;
>  		goto done_endpoint_free;
>  	}
> =20
>  	if (!bus_cfg.nr_of_link_frequencies) {
> -		dev_err(imx412->dev, "no link frequencies defined");
> +		dev_err(imx412->dev, "no link frequencies defined\n");
>  		ret =3D -EINVAL;
>  		goto done_endpoint_free;
>  	}
> @@ -1034,7 +1034,7 @@ static int imx412_power_on(struct device *dev)
> =20
>  	ret =3D clk_prepare_enable(imx412->inclk);
>  	if (ret) {
> -		dev_err(imx412->dev, "fail to enable inclk");
> +		dev_err(imx412->dev, "fail to enable inclk\n");
>  		goto error_reset;
>  	}
> =20
> @@ -1145,7 +1145,7 @@ static int imx412_init_controls(struct imx412 *imx4=
12)
>  		imx412->hblank_ctrl->flags |=3D V4L2_CTRL_FLAG_READ_ONLY;
> =20
>  	if (ctrl_hdlr->error) {
> -		dev_err(imx412->dev, "control init failed: %d",
> +		dev_err(imx412->dev, "control init failed: %d\n",
>  			ctrl_hdlr->error);
>  		v4l2_ctrl_handler_free(ctrl_hdlr);
>  		return ctrl_hdlr->error;
> @@ -1183,7 +1183,7 @@ static int imx412_probe(struct i2c_client *client)
> =20
>  	ret =3D imx412_parse_hw_config(imx412);
>  	if (ret) {
> -		dev_err(imx412->dev, "HW configuration is not supported");
> +		dev_err(imx412->dev, "HW configuration is not supported\n");
>  		return ret;
>  	}
> =20
> @@ -1191,14 +1191,14 @@ static int imx412_probe(struct i2c_client *client=
)
> =20
>  	ret =3D imx412_power_on(imx412->dev);
>  	if (ret) {
> -		dev_err(imx412->dev, "failed to power-on the sensor");
> +		dev_err(imx412->dev, "failed to power-on the sensor\n");
>  		goto error_mutex_destroy;
>  	}
> =20
>  	/* Check module identity */
>  	ret =3D imx412_detect(imx412);
>  	if (ret) {
> -		dev_err(imx412->dev, "failed to find sensor: %d", ret);
> +		dev_err(imx412->dev, "failed to find sensor: %d\n", ret);
>  		goto error_power_off;
>  	}
> =20
> @@ -1208,7 +1208,7 @@ static int imx412_probe(struct i2c_client *client)
> =20
>  	ret =3D imx412_init_controls(imx412);
>  	if (ret) {
> -		dev_err(imx412->dev, "failed to init controls: %d", ret);
> +		dev_err(imx412->dev, "failed to init controls: %d\n", ret);
>  		goto error_power_off;
>  	}
> =20
> @@ -1222,14 +1222,14 @@ static int imx412_probe(struct i2c_client *client=
)
>  	imx412->pad.flags =3D MEDIA_PAD_FL_SOURCE;
>  	ret =3D media_entity_pads_init(&imx412->sd.entity, 1, &imx412->pad);
>  	if (ret) {
> -		dev_err(imx412->dev, "failed to init entity pads: %d", ret);
> +		dev_err(imx412->dev, "failed to init entity pads: %d\n", ret);
>  		goto error_handler_free;
>  	}
> =20
>  	ret =3D v4l2_async_register_subdev_sensor(&imx412->sd);
>  	if (ret < 0) {
>  		dev_err(imx412->dev,
> -			"failed to register async subdev: %d", ret);
> +			"failed to register async subdev: %d\n", ret);
>  		goto error_media_entity;
>  	}
> =20
>
> ---
> base-commit: ae58226b89ac0cffa05ba7357733776542e40216
> change-id: 20241118-imx412-newlines-3b0321da960d
>
> Best regards,


