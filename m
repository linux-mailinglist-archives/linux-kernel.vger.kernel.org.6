Return-Path: <linux-kernel+bounces-511131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7795DA32656
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3543D1888839
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C820CCD3;
	Wed, 12 Feb 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I+I5eKY3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B52C2046BE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364966; cv=none; b=N9zpDPonXf0ZqtpSg1wrCY04q9NzNKzpmO9Ci8Ovljyap/JkndUAw0/DLe6cGxi3al58EelUr38Jb+PbMB3uT/3UpRzTVFCbFHvGO77BOtQdbvFz9HQFL7oWpaE4+w9RmBmh7lgdcVh2s5cAowusDOfyO9UeWwb/BnYhK3whhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364966; c=relaxed/simple;
	bh=khCDu6D+a72YvB4zT8c20mSv6D4DLmYGwUIHI1U3gCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7mFPsA7b/F0OQWtbdKQUUF/ZIjkdWtaEsCgJXeYyICnPXId046p3u0e02uSPsqmEHD2vHdiIo4u3G4BK4qCWRTijfsLr1VHYqP/e391/zpLxRbIgH9p/53xsWHIE0rTuEm740GPozZ+BOHCAtoG3xu+cocUYaZ1jV0JAKf/q7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I+I5eKY3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C92kb5031920
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Xcp6yRYRlRMXuclTG7bgL1rCb1qEu5Tl7xJL9ykhdw=; b=I+I5eKY34w5X3xIr
	bcw9ze8TendL06csh9gdmSYr6dFFEY+vdaYXj+FeknlFqplBbiV6RwPZ/XBa+0Qx
	Y9ritnvoRhEXuk1zijJuwzuN7xzUgTNhYDQQD+ufWuOJcFdgtjDl3HWvVdHxHkOY
	uBDqoQlO5Ev2SjTULEm4+9YNW+YZQn+d+Dfr9VNaja3XvrCpf8ipMj/qbBjSMCwy
	N2hYPrevgqfbwkGu4L95US84uZFjrtk8/7QbTfJpoFJMIQpOlaUugdEj+yEfWmOI
	rpMlE0yvx7BTOg5FHuRTKn4844egT5j4pRD9VLo1lcZUCcrHDihKlBaxYyOmqYW4
	EysJFA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qgtk75mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:56:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-471ad2e69d6so1837831cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364962; x=1739969762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xcp6yRYRlRMXuclTG7bgL1rCb1qEu5Tl7xJL9ykhdw=;
        b=f8+k3N+xDWpS5oRargTT+nzSdffEkTJJN3SptzIS9SLsJ4RA9f12oDMnL15189gEDj
         G1wXT3CF4+PRJHYmYOFTB9IHFW7XvkI2iM6hCRClAHeDtpUV3rk35yQIZxMu9SQoQ680
         UId5CUa8jiaM24OzEyjH3nYsST9wtFJvGdSs6b+9noU9KgXB5cwKcUEyHKOTwnyxxLFY
         FA46FHlt6y0nH4KcWY5GiHc/qz6g/MKdjxKPiy21brWBJkzx3wzJMJXMeSLGgEPxExns
         XWUCNIRg71rdfOF+tz/z8NPvfJsSI0XhISMoFH9V4rpjBf+P07BdmRpBtL0M2k6mrBXO
         2GeQ==
X-Gm-Message-State: AOJu0YyJ6jguvELGX98oaQmPrWiC/MtQ5FhPs57CLWHayWszxJG6TFcN
	VkWu6IfK19v7MLcU0r0L9bAKym4/MT5kNuOPWgYRMbJDA1hWgUnCQEGA2bi4MMM2wbM3MhwUDC8
	N4zugqMbWGMcGY9xV/CTgBvA4DUbeumnvSARx27IBXxhBCcv0X0B+4YBiwsRNH1M=
X-Gm-Gg: ASbGncsWd+aVGCvezUsWQHSCYX+hFVNVpk9bKgRZg1u/hSItng4t4Ld+7s4kQpbfPxa
	WZz+kbNZ2Rcf8RNCUuPq3Ks6jqQEW2QcBqXdQVGqpE60d05r4SzBalRioMzRzTGgZt/SygdUpBm
	ifWvmbwd9EhTXGOFS4R0y/0Ttur0ynXd/iubcdsUYeR//nzWqLjRG1TruORAIqcwqM0cNv1KzfP
	YSP3oMYIoavPHkJ6GXrbyTN5eyVs1GYYYy9SuLQYqloVqL+h2P2EOvx/wiRAlYYzaNdFAlcCAfg
	taBpaQy/aPm2H6H0EhY+HT5Iu0APOCWh5vPXh7dL5JS/gN5L0nFLROGG5yQ=
X-Received: by 2002:a05:622a:1342:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-471afef4f1amr16212351cf.14.1739364962403;
        Wed, 12 Feb 2025 04:56:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJufyNHqGlxGr0Oi3YE2cGBUYy45V8eQFPpZVSPoCst+6BP0eWRtHg1bm7zUcq8OPj0Cjl9w==
X-Received: by 2002:a05:622a:1342:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-471afef4f1amr16212161cf.14.1739364962036;
        Wed, 12 Feb 2025 04:56:02 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7dae77599sm362172466b.30.2025.02.12.04.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 04:56:01 -0800 (PST)
Message-ID: <f4a15f6d-1c2c-484b-9a81-6e5e138b3fdb@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 13:55:59 +0100
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
References: <20250212010744.2554574-1-james.a.macinnes@gmail.com>
 <20250212010744.2554574-3-james.a.macinnes@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250212010744.2554574-3-james.a.macinnes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7F-jfCfqSjvyEclq3DgLiHIQsamRP7oh
X-Proofpoint-ORIG-GUID: 7F-jfCfqSjvyEclq3DgLiHIQsamRP7oh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502120100

On 12.02.2025 2:07 AM, James A. MacInnes wrote:
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

To the best of my understanding these numbers are correct

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

'quirks' is one way to put it ;) I'd call it 'desc' or 'data' but it's
totally a potayto/potahto discussion

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

Not sure how useful this is given the previous call creates a sysfs entry
on success, but sure

Konrad

