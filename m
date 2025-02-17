Return-Path: <linux-kernel+bounces-510452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E17A31D13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C363A8260
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797E81E260C;
	Wed, 12 Feb 2025 03:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BesxhStF"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CD1DC9B0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739332137; cv=none; b=btxGp7NpQoGi+HgGMMmhYH3eDcgCyA/vHGvvTmNcQtkfjfl773eWmIEHj36/24MKGZ/uEmLo4uxPATmBjOd8bRr4i99uCsAw94An9/OhWDX49T2q/XbfiymVXEWqgbBi+Bf+rlj4VpgwHP66IyLk5J3YoiNrCaSH3sstggncpf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739332137; c=relaxed/simple;
	bh=9ZY9RVhzuSiLS6BUP0ZFkF5aZ1Oqz8LAxFfyKUwk3j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHxNvTEARGgXgdMAW2v1nO6oUTqSfJc5z0Ik1sY6a5ApgRYNZOKLt1opnLjgGzicNnMXlM3aly6927RkclWYuAMkFz2GwYghbmPYnp5FYTY1CRYEx47MdB4PcZu2+HwRJU/+Mo9Z6GPmqLwrGltL1piSKyOFPDv0Iu5MYxwiDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BesxhStF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5450f2959f7so2508346e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739332134; x=1739936934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8GuRuhmrPh3WYswydoKTB0sEDfpdVBJ4XAcY5g8knk=;
        b=BesxhStF5JHq/F5bm6HNZrze+YXBVLKJNOsQBJQrLicemDD/3BMpJLM04eQt0zHHJ9
         ITS8g3VXwj77NFpzvQKUrCdBx1xUVE/hV+2rNKyT92CAExK6gFEqEOuCea5xEGpoubVC
         M0DW4A64eIWHsFMitrGYKtKelf2PWpOGr+ZY50hKTjOGUE491Hf8MpwJea9mzNVOoBu2
         9VGIn4aIAjnuaZiTGLoBSwZuLsigaV4kgqk5chRcOfUkTKCogqDMX0T34NBJ5azgMQsE
         xwi/LmNOBTXtpsSoOOKg/rCpADlBP4U2bAA5GRvtSn8PQAKbSI2/7OX2+uxK7Sr+PWe8
         U/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739332134; x=1739936934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8GuRuhmrPh3WYswydoKTB0sEDfpdVBJ4XAcY5g8knk=;
        b=TLbrekt5xcP8CHvpIdx6xfmfuDwetNts5eT+mmem4HAs8g1DPddUYsw0CbGMemI67U
         OnCnbMKW5Ch1clNHvOYyznacKho43TebI8exRbnM2SPW2LOmcceU5/b87B2rJgwUZ3eS
         vkx5zJbTRjXiML4Na9utmbRJdU4QcrGi+KR7LHevA446QTKlm42j8tkj0egYWNj7bF/O
         UyzC0HRw/2zMcpJkgsUafB8DCI2ttGGz30J5j/tCUIPBXDjJxVkQIRthG5XoNzfkm4mf
         hlbp18iBLmKMNurA+TIO4EAPS0GTcma+uPUtgeTGNoqLIakh2r8qYd+UtVzfYaVP1hY2
         gGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1yqlYh4HHC6Tj61StrARfQe93mBv6pq0AvauP7TKEh0JyR3WU5a/EvVM5rwCwER2o+fL96Nx/tU9Ynew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rZ+Vj2PJVf/2+ihEk+j20IZzji48sqKZdxtjH+gxsZAeZNoN
	6iXjLVDzOAtkbXhRZq/Px6KFZlRZUTmqwrQGK56+kJuWTbrtVuwhz+kckxRrJ9c=
X-Gm-Gg: ASbGncv3ZJSOQkydR4uzLgkVNZ3lDn9lX1A7mO/GFO64EFBGErS1o0dBwsfpR0H/hlj
	UkkfQs/Azo2XRev5UEfdaVVpR7tsmEazPCygg4BjjMnGXQ+dhF0anWTZxHZx/fvbs1iKIgR+jjY
	PlnQH25DtEl2jlqruM5y3ddqpSuC4djRO17YeqZSFPk5YYudPCDXlgL103DlOJX/SDcq0CneLxW
	XdOm7kmzDzSgvwZX8Ji43VUZSt9ptEddyB8okhoSJ5sLuqNFEutwwERTUd7HLFdtzntbKpiWHrT
	A2xrln9ZKBK8ie5J6gN085E6VS/xaHnbNk3K3QEFeB7adlP0Z4MLCZVq+HK8L0glkLNVmrM=
X-Google-Smtp-Source: AGHT+IEVl+6pBKX6t+vx2HluRfI+C+04SxlsANu04QKZMiTiL9dgQU6uysyD6WpxI0RnIYuvm1wnRw==
X-Received: by 2002:a05:6512:401e:b0:545:ab8:2be5 with SMTP id 2adb3069b0e04-545181232a7mr314922e87.25.1739332133741;
        Tue, 11 Feb 2025 19:48:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54506cf59a4sm1098911e87.228.2025.02.11.19.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:48:52 -0800 (PST)
Date: Wed, 12 Feb 2025 05:48:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "James A. MacInnes" <james.a.macinnes@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	quic_wcheng@quicinc.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 2/3] regulator: qcom_usb_vbus: Add support for PMI8998
 VBUS
Message-ID: <kvdtyzkhnc7uzjzfdlngj3bko3cuuvmf6d7zbr7r27rlpkz7zk@247hx2uqhnvn>
References: <20250212010744.2554574-1-james.a.macinnes@gmail.com>
 <20250212010744.2554574-3-james.a.macinnes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212010744.2554574-3-james.a.macinnes@gmail.com>

On Tue, Feb 11, 2025 at 05:07:43PM -0800, James A. MacInnes wrote:
> This patch extends the Qualcomm USB VBUS regulator driver to support
> PMI8998 PMIC alongside the existing support for PM8150B.

Please modify this commit message according to follow the example I
provided for the patch 3. If you are unsure `git log drivers/regulator`
will provide you with good enough examples.

> 
> Key changes:
> - Added current limit tables specific to PMI8998.
> - Dynamically configure the VBUS regulator based on the PMIC type.
> - Updated debug messages to reflect successful initialization for
>   supported PMICs.
> - Changed registration log message
> 
> These changes ensure proper VBUS current limit configuration and
> compatibility across multiple Qualcomm PMICs.
> 
> Signed-off-by: James A. MacInnes <james.a.macinnes@gmail.com>
> ---
>  drivers/regulator/qcom_usb_vbus-regulator.c | 38 ++++++++++++++++++---
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_usb_vbus-regulator.c b/drivers/regulator/qcom_usb_vbus-regulator.c
> index cd94ed67621f..804dd1a9e057 100644
> --- a/drivers/regulator/qcom_usb_vbus-regulator.c
> +++ b/drivers/regulator/qcom_usb_vbus-regulator.c
> @@ -20,10 +20,30 @@
>  #define OTG_CFG				0x53
>  #define OTG_EN_SRC_CFG			BIT(1)
>  
> -static const unsigned int curr_table[] = {
> +struct msm_vbus_desc {
> +	const unsigned int *curr_table;
> +	unsigned int n_current_limits;
> +};
> +
> +static const unsigned int curr_table_pm8150b[] = {
>  	500000, 1000000, 1500000, 2000000, 2500000, 3000000,
>  };
>  
> +static const unsigned int curr_table_pmi8998[] = {
> +	250000, 500000, 750000, 1000000,
> +	1250000, 1500000, 1750000, 2000000,
> +};
> +
> +static const struct msm_vbus_desc msm_vbus_desc_pm8150b = {
> +	.curr_table = curr_table_pm8150b,
> +	.n_current_limits = ARRAY_SIZE(curr_table_pm8150b),
> +};
> +
> +static const struct msm_vbus_desc msm_vbus_desc_pmi8998 = {
> +	.curr_table = curr_table_pmi8998,
> +	.n_current_limits = ARRAY_SIZE(curr_table_pmi8998),
> +};
> +
>  static const struct regulator_ops qcom_usb_vbus_reg_ops = {
>  	.enable = regulator_enable_regmap,
>  	.disable = regulator_disable_regmap,
> @@ -37,8 +57,6 @@ static struct regulator_desc qcom_usb_vbus_rdesc = {
>  	.ops = &qcom_usb_vbus_reg_ops,
>  	.owner = THIS_MODULE,
>  	.type = REGULATOR_VOLTAGE,
> -	.curr_table = curr_table,
> -	.n_current_limits = ARRAY_SIZE(curr_table),
>  };
>  
>  static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
> @@ -48,6 +66,7 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
>  	struct regmap *regmap;
>  	struct regulator_config config = { };
>  	struct regulator_init_data *init_data;
> +	const struct msm_vbus_desc *quirks;
>  	int ret;
>  	u32 base;
>  
> @@ -68,6 +87,12 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
>  	if (!init_data)
>  		return -ENOMEM;
>  
> +	quirks = of_device_get_match_data(dev);
> +	if (!quirks)
> +		return -ENODEV;
> +
> +	qcom_usb_vbus_rdesc.curr_table = quirks->curr_table;
> +	qcom_usb_vbus_rdesc.n_current_limits = quirks->n_current_limits;
>  	qcom_usb_vbus_rdesc.enable_reg = base + CMD_OTG;
>  	qcom_usb_vbus_rdesc.enable_mask = OTG_EN;
>  	qcom_usb_vbus_rdesc.csel_reg = base + OTG_CURRENT_LIMIT_CFG;
> @@ -80,18 +105,21 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
>  	rdev = devm_regulator_register(dev, &qcom_usb_vbus_rdesc, &config);
>  	if (IS_ERR(rdev)) {
>  		ret = PTR_ERR(rdev);
> -		dev_err(dev, "not able to register vbus reg %d\n", ret);
> +		dev_err(dev, "Failed to register vbus reg %d\n", ret);
>  		return ret;
>  	}
>  
>  	/* Disable HW logic for VBUS enable */
>  	regmap_update_bits(regmap, base + OTG_CFG, OTG_EN_SRC_CFG, 0);
>  
> +	dev_dbg(dev, "Registered QCOM VBUS regulator\n");
> +
>  	return 0;
>  }
>  
>  static const struct of_device_id qcom_usb_vbus_regulator_match[] = {
> -	{ .compatible = "qcom,pm8150b-vbus-reg" },
> +	{ .compatible = "qcom,pm8150b-vbus-reg", .data = &msm_vbus_desc_pm8150b },
> +	{ .compatible = "qcom,pmi8998-vbus-reg", .data = &msm_vbus_desc_pmi8998 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_usb_vbus_regulator_match);
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

