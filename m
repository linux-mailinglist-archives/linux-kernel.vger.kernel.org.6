Return-Path: <linux-kernel+bounces-233602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A37CD91BA16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F99B245BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B256D14E2DA;
	Fri, 28 Jun 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOhD1gc0"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596184FA5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563695; cv=none; b=TqS1DDf7tr6sQA3YGIE1np89WpNVZlJWY11bCF7a2RM3l2iToOn+ZZNCnUYCNNFAuzIfn848unowqXLwgWIlCvkvBMDlvdNdxssJNiF56IrFQ5v6Cs/Qdtv4OiegCbPOy882qW9li4piP4kn8aDlYoHSLQufpEA5YgdL0vUB/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563695; c=relaxed/simple;
	bh=biRrQhODyDG178r6t+Dc7W8P46eie8EBFQWED+2NYyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQIBdV2AR8C5PFcspkdkJoMjl+Vk2Tkx5WkuLKsd2J23J6ro3ygWA1k2j+txLW4yA5fKHBmWdaK69aZhtpayIPV7MmAkbQ0o9wOp+s6NwQW+/Kd+p0KxVBtNqpCVS7/B1p0IsX/0PqIoDFg11n3U95vrn6IZ4qVyMSXT5KOkSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOhD1gc0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52caebc6137so319696e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719563691; x=1720168491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8zLmoIKPxnK+b9kZdJkrjuWZxz5Rl0SiMo/hxM01Sk=;
        b=kOhD1gc07+kAVc+XuAOP40CvSF4bfY4MNShVg9nBZLZpGEGv71XZh+7BVzMQouU6Ue
         UY73MEkQbwIuaKpAR8T0KIDrdAi/GmB4HDh1j8LR5rfOUssy7QOG8QpgBUiRFpu7IFU3
         9C+Pw30CYc9zYeKTgbmKTMiDteaWgSa/lfER/eJIk5y34/i4GCKrkVrH0jVgs+qvWg64
         InXtwE3emGzgKAH+rWErI5D8dAM/xOcjdEWdDqCkK0Zm07dUSBK9GHEPAzv4AEPqNhIL
         u9irpkzTdFFuuBls3TlqshYzI4rttmCtZnv1C7FOOuIzuCsUPhOzkyl4evbKXtH3N+Wi
         yQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719563691; x=1720168491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8zLmoIKPxnK+b9kZdJkrjuWZxz5Rl0SiMo/hxM01Sk=;
        b=v4PW9m+C4OnykrzgpumpJhnOzlUSAg2O7jUXnB6H4uRLAijckkRWdIpM0uW3P8NPKp
         Wu4gVh3foyANGvFaH2iokw1/0CedZ70avruP8r5IPPUeqXwNETPirCkT12uLg8vgZXJc
         88JkQVh0Dh/lzLbPyb3q9vyhuso/UMgarWmZED5/0arx32q+tDSi8SRfUoEGy2FjH4zH
         15ZQrFX7pqhwAktaweq0DwteeIkAs56d1ylWlqdcDuX9TmSRxnqXqWLYg1BjzFLd86rb
         1Bs3iXtowOFsTUPrBh6tbl0JkRPgWIkTk6lzjIskNewTGmL7BekV4H6x5nvalbXBr+gm
         q65A==
X-Forwarded-Encrypted: i=1; AJvYcCXYboWUKDSlYwqWYG1qq0hDz+54K0HQeXuxplDq0pPY7b7N49CwEkeq3w1RUCSFD0RyuS292SlAzg2DKDzSloVybonoChQaiGRFuww0
X-Gm-Message-State: AOJu0YxUZwhPOLEGFBrbWsl2wLgrCndq2zpSvO9Ea/1RKt5DOKhqCkke
	H6xf51xVvBxrxXjOI/eHSvNykheSnDfRQGGy9ATkqYLRFHU3oU9hPVbN4+UvuoE=
X-Google-Smtp-Source: AGHT+IFFgYROnO/gr2N7QSvXx1fctXVhRczM++VXS2jEv/Xjq0ZPOXaSUkxk3uPcFer4UHzQuZELGw==
X-Received: by 2002:ac2:54a8:0:b0:52c:999b:52f9 with SMTP id 2adb3069b0e04-52ce186457cmr9622295e87.57.1719563691555;
        Fri, 28 Jun 2024 01:34:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab101f3sm207679e87.76.2024.06.28.01.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:34:51 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:34:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: codecs: lpass-rx-macro: Keep static
 regmap_config as const
Message-ID: <grpb57rhum4auor3n66mqd2tpmd52gzofbdog3vlmxlamfxv5a@2mhfkigl6ek2>
References: <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-0-ede31891d238@linaro.org>
 <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-2-ede31891d238@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-2-ede31891d238@linaro.org>

On Thu, Jun 27, 2024 at 05:23:44PM GMT, Krzysztof Kozlowski wrote:
> The driver has static 'struct regmap_config', which is then customized
> depending on device version.  This works fine, because there should not
> be two devices in a system simultaneously and even less likely that such
> two devices would have different versions, thus different regmap config.
> However code is cleaner and more obvious when static data in the driver
> is also const - it serves as a template.
> 
> Mark the 'struct regmap_config' as const and duplicate it in the probe()
> with devm_kmemdup to allow customizing per detected device variant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/lpass-rx-macro.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index 59fe76b13cdb..3d8149665439 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -1662,7 +1662,7 @@ static bool rx_is_readable_register(struct device *dev, unsigned int reg)
>  	return rx_is_rw_register(dev, reg);
>  }
>  
> -static struct regmap_config rx_regmap_config = {
> +static const struct regmap_config rx_regmap_config = {
>  	.name = "rx_macro",
>  	.reg_bits = 16,
>  	.val_bits = 32, /* 8 but with 32 bit read/write */
> @@ -3765,6 +3765,7 @@ static const struct snd_soc_component_driver rx_macro_component_drv = {
>  static int rx_macro_probe(struct platform_device *pdev)
>  {
>  	struct reg_default *reg_defaults;
> +	struct regmap_config *reg_config;
>  	struct device *dev = &pdev->dev;
>  	kernel_ulong_t flags;
>  	struct rx_macro *rx;
> @@ -3851,14 +3852,22 @@ static int rx_macro_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	rx_regmap_config.reg_defaults = reg_defaults;
> -	rx_regmap_config.num_reg_defaults = def_count;
> +	reg_config = devm_kmemdup(dev, &rx_regmap_config, sizeof(*reg_config),
> +				  GFP_KERNEL);
> +	if (!reg_config) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
>  
> -	rx->regmap = devm_regmap_init_mmio(dev, base, &rx_regmap_config);
> +	reg_config->reg_defaults = reg_defaults;
> +	reg_config->num_reg_defaults = def_count;
> +
> +	rx->regmap = devm_regmap_init_mmio(dev, base, reg_config);
>  	if (IS_ERR(rx->regmap)) {
>  		ret = PTR_ERR(rx->regmap);
>  		goto err;
>  	}
> +	devm_kfree(dev, reg_config);
>  	devm_kfree(dev, reg_defaults);

Seeing devm_kfree in the non-error path makes me feel strange. Maybe
it's one of the rare occasions when I can say that __free is suitable
here.

>  
>  	dev_set_drvdata(dev, rx);
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

