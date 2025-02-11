Return-Path: <linux-kernel+bounces-510177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DD8A3195A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155633A68B9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E460A26773A;
	Tue, 11 Feb 2025 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwJUtEBV"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33065267AFC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739315805; cv=none; b=nzolF7E/iJ5lSJYIB2fuZjFIAOfLDJHFWXIpAyIxZ46rp28PnSG1v+uYbPsuWhfZZTNFIo70Ip726UE9wsY+DEXEwVKev1TuhNrZ/EtIfndbNT9xSTeeCmCxHxF/06noEmFFehHC+tHRGi9qFm3HzvengaLR2m5Y8uBkmhyk0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739315805; c=relaxed/simple;
	bh=dCWsKsGHrypWkEy2BhbaTsLTiMr3Y+oercFl/4NqAkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQn1yN83mUGviCFhbyhsMMNRjQdNoO9H28W13xAAZy9XABm4BVorow5801tz0EHXkv5nYHavmKmhWcOSlqLu8WmMy0EhA5j/8CJFxk2nCsiNDLHMMg1egC4wNEX78uTaScrVR8xnPQI2eR79g4CpMzFPpB3BI8dZKXYOGJ8A3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bwJUtEBV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-543e47e93a3so6861449e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739315801; x=1739920601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdPjDM4Ktjpdiq8TPEXfIq9RN+Hdq37W2M7XnzEYgL8=;
        b=bwJUtEBVtMjlTWzxwzyDduDM5gkE0yBQVASyQSiaCnfl8/KSUfaVRxwPuY/5vrQ8Vg
         tHz98FEqMO3UjFVj2ZhEZ4TtOwyAExpZ1R1A7yN+dDgGpAKXjjYUN5zpSi9Ps2GRT4YD
         2eRTr16prXz+8rkXR3Ip3yXycpMVaDJY4sMR8aijqIlz57AH/juYZoHavN3jdgv4Zivi
         l71SWy3a+IzeOuYeQ7oV6WRc6F+nlDxJcxqXv9oUQq2Zcgu6i3a6H6fS5JOqEl/U8UcQ
         0oy/WWvrnLBsid0eu8l3/cLl7abrF0KVKKU9ckOgmeiCQGpl2EPJrV8btTIXwoqmIeNT
         jwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739315801; x=1739920601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdPjDM4Ktjpdiq8TPEXfIq9RN+Hdq37W2M7XnzEYgL8=;
        b=bUe9Tj/fVMswAm+3I0VvWQ/2P+zZV0rtzMfiqQ7tIPmtc8X33XMBgrZLi+WPIpd8oM
         t/JPaXFERvWy4UegAsSs62Y1IumESr5gOW4LrOvWOG7PqhlXUxB4jTo6yFTRPIGkNV+R
         V5w8lKWiR9vePUMbs3j92+rWj6s8wyP7ksbwunVblKSxySsDocAN7NzmerSUTZDMZ9lu
         IfeTZZEZfdUa58byRg4gLdN+GPei+DXiZVF9QXswNmYAyFUsZsyT1Iyn/NIfTyfGHZjj
         e2uq38R+Z/bdk0YdEnu1LKXNKALYNjsZW/gQbmF3oPgZViszXKwcobB+AdLxIX857QAo
         n4iA==
X-Forwarded-Encrypted: i=1; AJvYcCWhISbwuaJnr+ga5ARQ8Wn+6nPWN7UpFl0rolcDK3pzkr34Udt59+QNiTD9vI8a7iYw94FT0CsO68+lP4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwENamMRd+gVaMtNcoQyoUwDiM/pP2HOsGz4D7Rl9k+7MWInkU2
	azktiOqSYd1Lw600ycJWB/3g/iH+GBNM/Zn39ZhGtB7SD/Y+pr56VU4Ma8UiGjM=
X-Gm-Gg: ASbGncvlFuj3gEF4MHpvJ+un0bGf0GlmzGkFRJXLBBBDANP9mxGiAJQ4k/Wqqa/jhwN
	73eTUJLsAIcEGkkUorAXHulnETTJGUWZQVcSe13mZcG0hLLJPjbAfhO4xGQmsI0xXWn/EZ6Lp5E
	Dmu8YKA8G9cqQiAvi6WDZpS3pXSMViFBbIGqfwVvjGy7hkrOuy3RM5t8qbDwJ6oFBkOtEDqmcQa
	SEBKVsNdraNUCX8kGxdBUQdLwpBMYmHDx7KgRFydro+iczPRu9FpCk1QB7lqKiKd8puNKh7A6pB
	dlLrMsdHv9GXRUh2laEMV58lEDr6TjccJ+eWlspOT9ZAX+Ry6xIsjyXW9jNHbrNCCOdGwpM=
X-Google-Smtp-Source: AGHT+IHt1P5dSEzek/rhSRYjyu1EcKb97y+OgEvT96wL/qYwjHZTpXFCGduS/FI+zG4gVD14oHfTjg==
X-Received: by 2002:a05:6512:696:b0:545:a89:4dd3 with SMTP id 2adb3069b0e04-54518166ac8mr211738e87.46.1739315801127;
        Tue, 11 Feb 2025 15:16:41 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450e1121ebsm646692e87.136.2025.02.11.15.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 15:16:39 -0800 (PST)
Date: Wed, 12 Feb 2025 01:16:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "James A. MacInnes" <james.a.macinnes@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	quic_wcheng@quicinc.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 2/3] regulator: qcom_usb_vbus: Add support for PMI8998
 VBUS
Message-ID: <aldyktqe5sypkb6tdzl5omraohn5ee272b2ww7vwax3sj7csbd@ccldsyvguuc7>
References: <20250211194918.2517593-1-james.a.macinnes@gmail.com>
 <20250211194918.2517593-3-james.a.macinnes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211194918.2517593-3-james.a.macinnes@gmail.com>

On Tue, Feb 11, 2025 at 11:49:15AM -0800, James A. MacInnes wrote:
> This patch extends the Qualcomm USB VBUS regulator driver to support
> PMI8998 PMIC alongside the existing support for PM8150B.
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
>  drivers/regulator/qcom_usb_vbus-regulator.c | 33 +++++++++++++++++----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_usb_vbus-regulator.c b/drivers/regulator/qcom_usb_vbus-regulator.c
> index cd94ed67621f..bfcb77698ba2 100644
> --- a/drivers/regulator/qcom_usb_vbus-regulator.c
> +++ b/drivers/regulator/qcom_usb_vbus-regulator.c
> @@ -20,10 +20,15 @@
>  #define OTG_CFG				0x53
>  #define OTG_EN_SRC_CFG			BIT(1)
>  
> -static const unsigned int curr_table[] = {
> +static const unsigned int curr_table_pm8150b[] = {
>  	500000, 1000000, 1500000, 2000000, 2500000, 3000000,
>  };
>  
> +static const unsigned int curr_table_pmi8998[] = {
> +	250000, 500000, 750000, 1000000,
> +	1250000, 1500000, 1750000, 2000000,
> +};
> +
>  static const struct regulator_ops qcom_usb_vbus_reg_ops = {
>  	.enable = regulator_enable_regmap,
>  	.disable = regulator_disable_regmap,
> @@ -37,8 +42,8 @@ static struct regulator_desc qcom_usb_vbus_rdesc = {
>  	.ops = &qcom_usb_vbus_reg_ops,
>  	.owner = THIS_MODULE,
>  	.type = REGULATOR_VOLTAGE,
> -	.curr_table = curr_table,
> -	.n_current_limits = ARRAY_SIZE(curr_table),
> +	.curr_table = NULL,
> +	.n_current_limits = 0,
>  };
>  
>  static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
> @@ -50,6 +55,7 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
>  	struct regulator_init_data *init_data;
>  	int ret;
>  	u32 base;
> +	const char *pmic_type;
>  
>  	ret = of_property_read_u32(dev->of_node, "reg", &base);
>  	if (ret < 0) {
> @@ -68,6 +74,19 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
>  	if (!init_data)
>  		return -ENOMEM;
>  
> +	// Determine PMIC type
> +	pmic_type = of_device_get_match_data(dev);
> +	if (pmic_type && strcmp(pmic_type, "pmi8998") == 0) {

I think a traditional way is to define an enum and then use that enum
values as match data. Or you can just add a struct with curr_table and
get that as a match data.

> +		qcom_usb_vbus_rdesc.curr_table = curr_table_pmi8998;
> +		qcom_usb_vbus_rdesc.n_current_limits =
> +			ARRAY_SIZE(curr_table_pmi8998);
> +	} else if (pmic_type && strcmp(pmic_type, "pm8150b") == 0) {
> +		qcom_usb_vbus_rdesc.curr_table = curr_table_pm8150b;
> +		qcom_usb_vbus_rdesc.n_current_limits =
> +			ARRAY_SIZE(curr_table_pm8150b);
> +	} else {
> +		return -ENODEV;
> +	}
>  	qcom_usb_vbus_rdesc.enable_reg = base + CMD_OTG;
>  	qcom_usb_vbus_rdesc.enable_mask = OTG_EN;
>  	qcom_usb_vbus_rdesc.csel_reg = base + OTG_CURRENT_LIMIT_CFG;
> @@ -80,18 +99,22 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
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
> +	dev_info(dev, "Registered QCOM %s VBUS regulator\n",
> +		 pmic_type);

dev_dbg, the driver should be silent by default.

> +
>  	return 0;
>  }
>  
>  static const struct of_device_id qcom_usb_vbus_regulator_match[] = {
> -	{ .compatible = "qcom,pm8150b-vbus-reg" },
> +	{ .compatible = "qcom,pm8150b-vbus-reg", .data = "pm8150b" },
> +	{ .compatible = "qcom,pmi8998-vbus-reg", .data = "pmi8998" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_usb_vbus_regulator_match);
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

