Return-Path: <linux-kernel+bounces-212049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8720F905A85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0707B218D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930A383B0;
	Wed, 12 Jun 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0yPwlNJ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF6EED0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216127; cv=none; b=H1dRJGHEFfPWI0Vcg1o/UajOqnJPszf0JCSh2pnAR2z7AdiBafNPawEpIW4sw54iDSnKAUa+EOchKbcYKlhJWrayAWAgM0REBUaGdH0IVIMNMOfv5Bd4z1tbZ6JWQo6D1RLDxi5Zzs9K63F0KC8CsCbpY8ZaFv8MN1kZUv0rhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216127; c=relaxed/simple;
	bh=xiWH756fmXpz8dkWhjOmyz0/S9uN/nhk/v2hE+f3UBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxENAtQt65yLZ1/nRqb6PAwfdUUexrQOPuyFgYoXzdMPMFqSJZUHMoIte5uqpWv7lZ1Ufu/4+UfjzOi9ETghnsbK8lJkQNcJhk7lblXyT+o+6KkV6/U8DySYu13FpZdupMv5thMFf0AnDB0qUeBehX6XEC+9FIqNxddbugZSq/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b0yPwlNJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bbdc237f0so245306e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718216124; x=1718820924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mraezCEzi7HPYzzdi4zkA3wSgYn7YV5wl4ixiQZdTak=;
        b=b0yPwlNJZ5TdPLYw1SGa3tmCQfrxUdlXm/CoboKN9+zKmKKgqy3Lh8xYuv9PUQylCp
         geQ1cuxEHrzCmmwovHBlN3Aiueoxrlti61YDxBTHhNtwZDbgZ+jON2e8fpMMRiPonTaz
         BeEXT9mrFomic6fTcF1badeu0mdZVW4bfDPzanydBogdUUhFCm1fRhvuySB4ryjbwBSd
         iQSddVHmiQSsyyvlUneMiRSW2lNEcZ60yp/7lJGS2ULNgVaGHXx3rlKyN5skBrjnwJBb
         M695TuQs4MGnYylHBDwwOtj/34Nm/7tihOtAiMoFnWaASHetHgfiyZ2aFf7kkmRdNgMJ
         DDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718216124; x=1718820924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mraezCEzi7HPYzzdi4zkA3wSgYn7YV5wl4ixiQZdTak=;
        b=XF2UcLT+WnfG3looD/KE2AnU3xE48tB9H9qrCHl9blCUjyk2XQCufnWG9tlY78kXDF
         sMqdcX4jqNmNxdm2xO8bANnP64ik/DAAizYx3edHzG2ymT2MlGhwope3N0E9gnSc4Lh6
         ddt2zqHYcKKywarrHVeeEZpvQSdSnxGnbbHYzLBy/vqa0mhYQmbqpoxNUi1pXQah3J6S
         3LgP52Nm/UVCap7shOMZKC9aS/3OL+2Ylp/4fiDoazZqGbIy64OuzOxYyAd+DdWWgGic
         eGB+ToU2DjO4l1oJkcwPogwZXLs31HIP5NsmR971+c7/6Q8Wjk1O5pj9yYTGB/4QaGN0
         B9yw==
X-Forwarded-Encrypted: i=1; AJvYcCUSL69ld01f+7/uSraLb2GGA9o/NHoVWlwaF5tHiyB86HMQkkAkWZxkn9uKFovIg3OusHVne1jh/e3ywcDEh1HMf5latfbApF8iFhAG
X-Gm-Message-State: AOJu0YxmHI2gb2xtu/VxqoQCSzY2WItcAdxFsdIWV7w9CWDVGpQ5m4Mp
	hP2/DHD3AIzdiQ/Uw2yAy3usjCEAxN+wcQRpCDlREnOR5vkKvb+H4f1K4CJ0OPE=
X-Google-Smtp-Source: AGHT+IFSBNLRqXQ9ycHtcrkpAwckrL3o8yPmK68fpMaDQWCd4BwUD6ZjT6xvrWnTk6ysDRpq/EKUEA==
X-Received: by 2002:a05:6512:239f:b0:52c:93f4:390 with SMTP id 2adb3069b0e04-52c9a3b8d57mr2685629e87.4.1718216123471;
        Wed, 12 Jun 2024 11:15:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c1e056c05sm2050458e87.80.2024.06.12.11.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 11:15:23 -0700 (PDT)
Date: Wed, 12 Jun 2024 21:15:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Banajit Goswami <bgoswami@quicinc.com>, neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 1/3] ASoC: codecs: lpass-macro: add helpers to get
 codec version
Message-ID: <jowqhnspiai4ydp7m7mn3p654kufg4ufbm2iexjg5dqbcxqatu@jfex2rnes5vu>
References: <20240612-lpass-codec-v25-v1-0-9f40611a1370@linaro.org>
 <20240612-lpass-codec-v25-v1-1-9f40611a1370@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-lpass-codec-v25-v1-1-9f40611a1370@linaro.org>

On Wed, Jun 12, 2024 at 05:57:21PM +0100, Srinivas Kandagatla wrote:
> LPASS Digital codec have changes in register layout across multiple
> versions. Add a proper way read the codec version allowint all the lpass
> macro drivers (tx, rx, wsa, va) to configure the registers correctly.
> 
> LPASS VA macro has the required registers to read the codec version.
> Read the the version and make it available to other lpass codec macros
> using the common helper functions.
> 
> Existing method of using LPASS IP version is not accurate as the same
> the codec versioning is totally independent of LPASS IP block versions.
> 
> These helper functions should be able to provide a convient way to get
> the codec version, and will help scale the drivers in right direction.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/lpass-macro-common.c | 23 +++++++++++++++++++++++
>  sound/soc/codecs/lpass-macro-common.h | 35 +++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/lpass-va-macro.c     | 29 +++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
> index da1b422250b8..8b038a99a8f9 100644
> --- a/sound/soc/codecs/lpass-macro-common.c
> +++ b/sound/soc/codecs/lpass-macro-common.c
> @@ -11,6 +11,9 @@
>  
>  #include "lpass-macro-common.h"
>  
> +static DEFINE_MUTEX(lpass_codec_mutex);
> +static int lpass_codec_version;
> +
>  struct lpass_macro *lpass_macro_pds_init(struct device *dev)
>  {
>  	struct lpass_macro *l_pds;
> @@ -66,5 +69,25 @@ void lpass_macro_pds_exit(struct lpass_macro *pds)
>  }
>  EXPORT_SYMBOL_GPL(lpass_macro_pds_exit);
>  
> +void lpass_macro_set_codec_version(int version)
> +{
> +	mutex_lock(&lpass_codec_mutex);
> +	lpass_codec_version = version;
> +	mutex_unlock(&lpass_codec_mutex);
> +}
> +EXPORT_SYMBOL_GPL(lpass_macro_set_codec_version);
> +
> +int lpass_macro_get_codec_version(void)
> +{
> +	int ver;
> +
> +	mutex_lock(&lpass_codec_mutex);
> +	ver = lpass_codec_version;
> +	mutex_unlock(&lpass_codec_mutex);
> +
> +	return ver;
> +}
> +EXPORT_SYMBOL_GPL(lpass_macro_get_codec_version);
> +
>  MODULE_DESCRIPTION("Common macro driver");
>  MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
> index d98718b3dc4b..f6f1bfe8eb77 100644
> --- a/sound/soc/codecs/lpass-macro-common.h
> +++ b/sound/soc/codecs/lpass-macro-common.h
> @@ -18,6 +18,18 @@ enum lpass_version {
>  	LPASS_VER_11_0_0,
>  };
>  
> +enum lpass_codec_version {
> +	LPASS_CODEC_VERSION_1_0 = 1,
> +	LPASS_CODEC_VERSION_1_1,
> +	LPASS_CODEC_VERSION_1_2,
> +	LPASS_CODEC_VERSION_2_0,
> +	LPASS_CODEC_VERSION_2_1,
> +	LPASS_CODEC_VERSION_2_5,
> +	LPASS_CODEC_VERSION_2_6,
> +	LPASS_CODEC_VERSION_2_7,
> +	LPASS_CODEC_VERSION_2_8,
> +};
> +
>  struct lpass_macro {
>  	struct device *macro_pd;
>  	struct device *dcodec_pd;
> @@ -25,5 +37,28 @@ struct lpass_macro {
>  
>  struct lpass_macro *lpass_macro_pds_init(struct device *dev);
>  void lpass_macro_pds_exit(struct lpass_macro *pds);
> +void lpass_macro_set_codec_version(int version);
> +int lpass_macro_get_codec_version(void);
> +
> +static inline const char *lpass_macro_get_codec_version_string(int version)
> +{
> +	switch (version) {
> +	case LPASS_CODEC_VERSION_2_0:
> +		return "v2.0";
> +	case LPASS_CODEC_VERSION_2_1:
> +		return "v2.1";
> +	case LPASS_CODEC_VERSION_2_5:
> +		return "v2.5";
> +	case LPASS_CODEC_VERSION_2_6:
> +		return "v2.6";
> +	case LPASS_CODEC_VERSION_2_7:
> +		return "v2.7";
> +	case LPASS_CODEC_VERSION_2_8:
> +		return "v2.8";
> +	default:
> +		break;
> +	}
> +	return "NA";
> +}
>  
>  #endif /* __LPASS_MACRO_COMMON_H__ */
> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
> index 6eceeff10bf6..0ae9e6377e3a 100644
> --- a/sound/soc/codecs/lpass-va-macro.c
> +++ b/sound/soc/codecs/lpass-va-macro.c
> @@ -1461,6 +1461,33 @@ static int va_macro_validate_dmic_sample_rate(u32 dmic_sample_rate,
>  	return dmic_sample_rate;
>  }
>  
> +static void va_macro_set_lpass_codec_version(struct va_macro *va)
> +{
> +	int core_id_0 = 0, core_id_1 = 0, core_id_2 = 0, version;
> +
> +	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_0, &core_id_0);
> +	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_1, &core_id_1);
> +	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_2, &core_id_2);
> +
> +	if ((core_id_0 == 0x01) && (core_id_1 == 0x0F))
> +		version = LPASS_CODEC_VERSION_2_0;
> +	if ((core_id_0 == 0x02) && (core_id_1 == 0x0E))
> +		version = LPASS_CODEC_VERSION_2_1;
> +	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x50 || core_id_2 == 0x51))
> +		version = LPASS_CODEC_VERSION_2_5;
> +	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x60 || core_id_2 == 0x61))
> +		version = LPASS_CODEC_VERSION_2_6;
> +	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x70 || core_id_2 == 0x71))
> +		version = LPASS_CODEC_VERSION_2_7;
> +	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x80 || core_id_2 == 0x81))
> +		version = LPASS_CODEC_VERSION_2_8;
> +
> +	lpass_macro_set_codec_version(version);
> +
> +	dev_info(va->dev, "LPASS Codec Version %s\n",
> +			lpass_macro_get_codec_version_string(version));

dev_dbg(), please. I think the kernel should be mostly quiet by default.

> +}
> +
>  static int va_macro_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1554,6 +1581,8 @@ static int va_macro_probe(struct platform_device *pdev)
>  			goto err_npl;
>  	}
>  
> +	va_macro_set_lpass_codec_version(va);
> +
>  	if (va->has_swr_master) {
>  		/* Set default CLK div to 1 */
>  		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL0,
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

