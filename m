Return-Path: <linux-kernel+bounces-510228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856FDA31A03
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F323A245B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53ED27180D;
	Tue, 11 Feb 2025 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dS82vaaX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB28271803
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318154; cv=none; b=ZG9dtqPKCoPIyLTYS29PdimYx1sis+KfUiCRvybV/5o58Q8Ns95aX06qqe+rhEoAMBSejmPG82wyj4irA4Q7ocDdovZggFZhTy2e0dD079lKtyLZcTuGB6mA8CxuqSP6+1YFay6a21If/AfyhB36DH/QbHOB2xiNL2uLJagEuTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318154; c=relaxed/simple;
	bh=zn/MEiaeMkqS+6/kfEldZQ8JkX+t51eC6E+hsKs0h2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e79WOY7yd6tNkMSeW+7iIQoSMtFddpXuVod7pl+UGddszWlDAQUwqe1KRmnG+O3dY6FmuhNFNECFrqg4iyv/QC34xeSA5d6puV2nPmIUT4I0F2Glr/bsmE5mCyE/r3feeUGInrEZHx6sLGe56qTSuUd+tyXqdbReGojJzvBDHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dS82vaaX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439307d83f0so24123495e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 15:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739318149; x=1739922949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XexwhaJfLPqQn5rqo8bd5EO9HVDdHe/LGV/GV+wRqWQ=;
        b=dS82vaaXtKVfgnmhxVcCcBboTBRAHZY+g/eYdygtNtAV4IPtKlr5gGtgUf9XocHiVe
         RMv6CHVhodW7VV9Ry+ri3ZQdS2gJ943Vom3FnWn+eGEEafCWikvZDijtOOVYOEfmm2k7
         onSzVTqOGw/4Zobmb6SO0dSeQq+9ruw4mJLBie4ey5gHvletRuvqH7h2TiOP5Unp7DaA
         uq1idplKGBwgBhydneJenQHp+CMSt6ANXOHZQsDgdN4FpHzKF1Q1UBLD0+CmHIZdBkNy
         LeaxJmBEgyhR6++A/YMF1gTUskD2YcgVhLKzR1K+6rblvvC+4sGYzI9zuj+mM41cn9F2
         DvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318149; x=1739922949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XexwhaJfLPqQn5rqo8bd5EO9HVDdHe/LGV/GV+wRqWQ=;
        b=LG/DbPlU9OPmGi1To+R+QaQ5NjVPKJcVyd2qaRja8ITuwe5W/f/FCVBjnNmEy57CK4
         VcULg2Ea0HrnV54crgJsK7+TIl1tEks8zcN44zS5tnmAwIntBGCNiCvDpBN4ckrOwuPG
         20ei1anwHll7KMGrFbudCa1pcqxjHcIghPaLb4NBMxfA3qnw8lpWkcN7Kjjb8bvwyPb8
         2X8bqBPwZEfZcpzCqiVZV4QXHV5PFcueNfJwWUkOaAEw18dhZx62ObuO4Zo377LHG8cN
         3O9NdQv1R/UprhoyzTYIJgNeR4o7UpzOZigM7EsLEZi+xbyvwHY3TJB/nstAalG5G4De
         6Kxw==
X-Gm-Message-State: AOJu0YxIkuwajJ1TJ8S5OVbv6eMcA0oJd1whNmitk81qJVMzuXobSwPS
	eMPZPmeewe89vgPPLs1hEOSZmFvlfESfzJKOkLkpoJI4m++UrkIUOly7Yn4LwGw=
X-Gm-Gg: ASbGncs5iSkdZxQBYCyHodH46GSFDliNxv2PjKk4rES0inmRp+dIY7MSzUiFQdp0LU/
	a5kSUJ6WEabhOEIK0zmDS2/aKsdMF02FMy9XsCXlAmbkNG3TUW3LVwqfrFauue2V1iF1gW3xQ1N
	LeC61rCadFRhtRAgLZe8ojqRC9Ynxooh3mP1kD/yUmRQamt3ShqUgYsNnIta41Ksl5x8a8/QJDD
	Ni3InSBe/HOleRlNPLyDQF5Foni+6rCwzGvDpY1Rdxc/tOvEPtYMqiAQvNUcRF14hyd67KTld53
	PQnaWMzYbx7LWjdZ92G/PzHb91xEiZuuL67UPxyZ79EQh5rGFTtyqocLig==
X-Google-Smtp-Source: AGHT+IFLEnmaQXwA+RH1booCyaG9+or+G+muqfT8GCpoI2uuGUFMyD0LCVE1muL7WO/wlnwcoEr3/Q==
X-Received: by 2002:a05:600c:1d9a:b0:439:4a2a:f318 with SMTP id 5b1f17b1804b1-439581c17f3mr8639005e9.28.1739318149510;
        Tue, 11 Feb 2025 15:55:49 -0800 (PST)
Received: from [192.168.0.156] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04cda4sm2862615e9.1.2025.02.11.15.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 15:55:49 -0800 (PST)
Message-ID: <84682c43-e480-41df-a258-1f5311bb441a@linaro.org>
Date: Tue, 11 Feb 2025 23:55:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] regulator: qcom_usb_vbus: Add support for PMI8998
 VBUS
To: "James A. MacInnes" <james.a.macinnes@gmail.com>,
 linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, quic_wcheng@quicinc.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org
References: <20250211194918.2517593-1-james.a.macinnes@gmail.com>
 <20250211194918.2517593-3-james.a.macinnes@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250211194918.2517593-3-james.a.macinnes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/2025 19:49, James A. MacInnes wrote:
> +	// Determine PMIC type
> +	pmic_type = of_device_get_match_data(dev);
> +	if (pmic_type && strcmp(pmic_type, "pmi8998") == 0) {
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
>   	qcom_usb_vbus_rdesc.enable_reg = base + CMD_OTG;
>   	qcom_usb_vbus_rdesc.enable_mask = OTG_EN;
>   	qcom_usb_vbus_rdesc.csel_reg = base + OTG_CURRENT_LIMIT_CFG;
> @@ -80,18 +99,22 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
>   	rdev = devm_regulator_register(dev, &qcom_usb_vbus_rdesc, &config);
>   	if (IS_ERR(rdev)) {
>   		ret = PTR_ERR(rdev);
> -		dev_err(dev, "not able to register vbus reg %d\n", ret);
> +		dev_err(dev, "Failed to register vbus reg %d\n", ret);
>   		return ret;
>   	}
>   
>   	/* Disable HW logic for VBUS enable */
>   	regmap_update_bits(regmap, base + OTG_CFG, OTG_EN_SRC_CFG, 0);
>   
> +	dev_info(dev, "Registered QCOM %s VBUS regulator\n",
> +		 pmic_type);
> +
>   	return 0;
>   }
>   
>   static const struct of_device_id qcom_usb_vbus_regulator_match[] = {
> -	{ .compatible = "qcom,pm8150b-vbus-reg" },
> +	{ .compatible = "qcom,pm8150b-vbus-reg", .data = "pm8150b" },
> +	{ .compatible = "qcom,pmi8998-vbus-reg", .data = "pmi8998" },

I think the other two said much the same thing but .data should point to 
the differentiator instead of being a string which you disjoin on and 
then hook your differentiated data.

i.e.

.data = &my_driver_specific_static_data_here.

---
bod

