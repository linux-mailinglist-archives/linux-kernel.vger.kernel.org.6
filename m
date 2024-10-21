Return-Path: <linux-kernel+bounces-374162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31BD9A65DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7CEB22DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85831E47A1;
	Mon, 21 Oct 2024 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TepYvfmM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE71E1C19
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508679; cv=none; b=OZwrVWbFulvXrfj2/f6pos2juAijNt+/1hX8+RO+k//RwYFS698TXS0j3LPYsLbN8sPDvAWlw2F2LePp2e+nuaoUPvdjpoL88HbfqRriy0SmK4qsXLjbnJOb9l3vRh2CJidfymlexyZwYdX8WtZFhTZqY9+ezNC5cWGIo8rfdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508679; c=relaxed/simple;
	bh=LvxPIKw0Wc6uzyJGMhWnJXsVOAN4ixv2zbjyRPGFRrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9Z2GCWxx/qlaP8QIrd0LvnM5Blo1UNZR8aN70++9kmMpEQb6xHKcWMx66NEqHfgFj9PwxkbmYjuGFHHmNv2a6OBRiGryCYTHq0doaAsJIKNkCvdrjaoiRYSRoxOEKDwX6BrdHB6epBxTLZSPmuGmNTBodBaD+cWaek8fNJ8x0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TepYvfmM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LAM3sE009222
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dcngVYJfUYun0KaV2VXI+C+nI+5NsaRAfwQ2oaU47dA=; b=TepYvfmMQ7RGWfx8
	kzP7XkguUVIeG4R0XvPn39g3Eom5MfLBIfc9Rln1F3NRBZTEbjdpbXCFdleAXA9V
	jpJhj2QId88OZh5ZjVm+51DXiMTADJ2m/EchfJfb7AucbPRASXHvyaIh/Dn35l/s
	ODcbLlnTaqc1zzcq27y9GzPG8ilJL3lMhVsjXqotU+qf6YR8yioOT38mCwT0hQ/c
	JNA887n6+e/iJWbFbX/torkg6J3UvubSkMrBpGZA1kalCwldKF8vXMlTnLy1vmYQ
	6jGu0SaN20Qfe2gxf2ZhVZC0FTKCIdegaumZahHY+2L31w0DTmNc0Yd9y4nbOy0M
	cEwQfw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6rj4b6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:04:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe40565feso11610456d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729508675; x=1730113475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcngVYJfUYun0KaV2VXI+C+nI+5NsaRAfwQ2oaU47dA=;
        b=QEN6h+gFnhAizk+sz5FKzqpmyiOKBlXqP2VfG1sp6HTtGerncy7xR+S83zJ49vRbcZ
         8YbVAUaJ5H4CVW/j/4uhHKFDt7+iU2lwT2OR2OtMwF6NH8DogafoswD5WJAZG/F7iZm2
         c9hDD8dc0oe8srVfMDSr50xJpEsIiXtqp1jWb6u52XPamGLRoExw4GePRlhXviiefA1Q
         D09IP3N8KQkLNsTS/3nG6Kif8fmiC68bXNEdIytZSCNVYe6grQ8Cn5kReg8wtXn850nj
         bWNDm8SzFQXDaHjb0KhUeHROeUiS6IYkzQpO3RnsVZSvcVbk05TV/tSEDebfjWhye+GM
         nYFg==
X-Forwarded-Encrypted: i=1; AJvYcCWrTZTRr21ba/mTdYx0Iw2p9p/6lDoRJVrHOBQFPsYLitfcCOOfCnV+tgchvuxLRaRG6A+5xRnBO7TWKIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+nQmWY4K5I763zB0K86TdOdkaaoi5ZQ9FkCtw8DaBmfh/VUa+
	hhwuoe4WHVvreoRQzns14i5LDg89Wqtz3uWFliLgLpOZ3+6Lf/+8cwf2BER8YF32CJ2oaFykbvn
	SuZ05LpjSOPWWCSYl47ONaF/yBbGwPStZ8ieYIYc3iJZZST1Q04PaKExGizBJSmg=
X-Received: by 2002:a05:6214:2268:b0:6c5:3338:45d5 with SMTP id 6a1803df08f44-6cde1635d54mr69115596d6.10.1729508675361;
        Mon, 21 Oct 2024 04:04:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSOUk7F+0PG+KYcCOi0xlveTYyYfaksaIxdy5jdFMTlNyIJZuGZYLXKfzZqdvLn3luov5JYA==
X-Received: by 2002:a05:6214:2268:b0:6c5:3338:45d5 with SMTP id 6a1803df08f44-6cde1635d54mr69115376d6.10.1729508675042;
        Mon, 21 Oct 2024 04:04:35 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ed80fsm190291766b.46.2024.10.21.04.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 04:04:34 -0700 (PDT)
Message-ID: <7fa066b6-a214-4866-9d0a-f75896531d84@oss.qualcomm.com>
Date: Mon, 21 Oct 2024 13:04:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: llcc: add support for SAR2130P and
 SAR1130P
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241019-sar2130p-llcc-v1-0-4e09063d04f2@linaro.org>
 <20241019-sar2130p-llcc-v1-2-4e09063d04f2@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241019-sar2130p-llcc-v1-2-4e09063d04f2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9BNSEuKPffXi1qX8B1loWWlQ40Iu3HtP
X-Proofpoint-ORIG-GUID: 9BNSEuKPffXi1qX8B1loWWlQ40Iu3HtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410210078

On 19.10.2024 6:26 PM, Dmitry Baryshkov wrote:
> Implement necessary support for the LLCC control on the SAR1130P and
> SAR2130P platforms. These two platforms use different ATTR1_MAX_CAP
> shift and also require manual override for num_banks.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/soc/qcom/llcc-qcom.c       | 468 ++++++++++++++++++++++++++++++++++++-
>  include/linux/soc/qcom/llcc-qcom.h |  12 +
>  2 files changed, 474 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index a470285f54a875bf2262aac7b0f84ed8fd028ef1..ef84fe3b2af4e777126a8308bfd4ec47b28aeae2 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -32,6 +32,7 @@
>  #define ATTR1_FIXED_SIZE_SHIFT        0x03
>  #define ATTR1_PRIORITY_SHIFT          0x04
>  #define ATTR1_MAX_CAP_SHIFT           0x10
> +#define ATTR1_MAX_CAP_SHIFT_sar       0x0e
>  #define ATTR0_RES_WAYS_MASK           GENMASK(15, 0)
>  #define ATTR0_BONUS_WAYS_MASK         GENMASK(31, 16)
>  #define ATTR0_BONUS_WAYS_SHIFT        0x10
> @@ -140,6 +141,11 @@ struct qcom_llcc_config {
>  	bool need_llcc_cfg;
>  	bool no_edac;
>  	bool irq_configured;
> +	/*
> +	 * special workarounds for SAR2130P and similar platforms which have
> +	 * slightly different register mapping.
> +	 */
> +	bool is_sar_chip;

This is not the only odd ball, please make max_cap_width variable

[...]

> +	/*
> +	 * For some reason register returns incorrect value here.
> +	 * List compatibles instead of using .is_sar_chip since there might be
> +	 * SAR-like chips which have other number of banks.
> +	 */
> +	if (of_device_is_compatible(dev->of_node, "qcom,sar1130p-llcc") ||
> +	    of_device_is_compatible(dev->of_node, "qcom,sar2130p-llcc")) {
> +		num_banks = 2;
> +	} else {
> +		ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
> +		if (ret)
> +			goto err;
> +
> +		num_banks &= LLCC_LB_CNT_MASK;
> +		num_banks >>= LLCC_LB_CNT_SHIFT;
> +	}
>  
> -	num_banks &= LLCC_LB_CNT_MASK;
> -	num_banks >>= LLCC_LB_CNT_SHIFT;
>  	drv_data->num_banks = num_banks;

This too

Konrad

