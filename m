Return-Path: <linux-kernel+bounces-382444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA49B0DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6128F1C22A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020220EA25;
	Fri, 25 Oct 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h1iyv8Eb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CE20D4FC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882390; cv=none; b=Nm6YLw1u3AnzDHpnr5fAGfu37lNCjH3/rEgk0vFT1iKT+bw8ZsVGUpqNPlLpaCQAeA75z67l4BGtMUam5+x8E9MUU3he0DN5J+O4SyddOu40BuZlO/Xyv67FSScsVYYPxuUemTyVvRVnSM9kdwQ/XmzK+dugkWf6SfwZiZpJcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882390; c=relaxed/simple;
	bh=id4ShyHdQb+sNmUG7Ndjj2is9yUp0Lx9pGm5iy3jm2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MlLGexoQGFF5hzLsUO0klFdLTdGfsHLAD4wZMKLPZk6eZoWoEycyXtLEvrKzLK98vSes8eBaGng3tZ/+6hjOJxocUT6GpgiY3gkp36XxQ9t30YF1TI5TSybWc+ls4thcXNCeNU4DmHLgLx2UyPl9CnyFllPKyjZTSnLiSnSvjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h1iyv8Eb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBITUx021958
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	etKggwlXkqtcz3KUi7T8N916f39wed+1dy++LJRvkF0=; b=h1iyv8EbcacGF6v+
	nJ9JV2/JuFAryZ2hzrEpTsRhfcnFYHzmpZYYTj6HreIV3SVW53gc/+bzsZN/FAfv
	VExP6WFOiso8kEyTbXVikHtw2G87tMlMBkWXHfWXZcH4kT/3mCD3+7OFl/gA+gny
	+hWz39jC8xkyfmKc+gkXmlq+WRXrGxQAara5uG89IQnAb93JBngHor+nvrYLWY+W
	jYdkALoKPHRU1HdvrSjB+UziiPvtvQXHa3ok6xbFTYX0YWlfJ7pnQr5fWgdDxJFM
	SXbhsZMc1vE2RBpwOj5Rtc8oTirkLIKa6ZG4ikTj/mZ0SwzsJtw8K/FJLpn67WUr
	TYXgeA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fk52n18u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:53:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-20d36e4e56fso3129855ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729882386; x=1730487186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etKggwlXkqtcz3KUi7T8N916f39wed+1dy++LJRvkF0=;
        b=mbOaqwj7jmwff1pTGFJ1N4r/nWzOPhFMPScDoijjD6vAna5nHa6gZh7BCgz7y6Nr8q
         t2E5LRW4fDimzntOF7gSh+EsC5exps/jQMjAL9J544nFPRnono3yTFQiaxoYbCj36u4u
         mZM8AmZi9d1T3gqdr6H4YEI0/o6t4rsFivRsZd7/OpMqra9nBwt5MZNq8VVeOCqB4wn/
         dLzW33tA19qZpnZHg8moO/j4pNpY4GPH59kK6w1Yzn59rKeX+ZQv3dJ1Xfft5XGYOIbW
         On5W2dfR4RAzj3j6JWuJykD0WZM+3jFBhfEo2IAlfUYkQW3ONKbruMvbVa0ZnagwUk7E
         iujg==
X-Forwarded-Encrypted: i=1; AJvYcCV7vWOye85fbobehmRPcPpoMG4TM2IyqjCFLaz2Hd3hnGrm10o8xjiUDWsl0v6sReIVC6hhUReJIG1Gnyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJyFGFQeJz1WbIQrGcono02r39jGpb5vwcSmdP+0/WvXTpPXy
	P6DDjnQ7URRzrd8Nm0nBK7mhbIHunsrVAdejeMc/8DBwkJAbTjcefQFSJp76537z1JBYm8iupdH
	b+gBXX51kUNMl84aY9ahKpEycvhc0hPwx8o4Q+qhxqUfH3YxIh2oth/R+0iJmMvs=
X-Received: by 2002:a17:902:e5c4:b0:20c:e250:d4e with SMTP id d9443c01a7336-210c6c47adamr644235ad.9.1729882385870;
        Fri, 25 Oct 2024 11:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmclrkU1rBIfiKP7IvCD+ju7C610wQ5J10FfeGUkoKjCI84JOlKcvKAKmTYO7Mdi97ImDo0g==
X-Received: by 2002:a17:902:e5c4:b0:20c:e250:d4e with SMTP id d9443c01a7336-210c6c47adamr644105ad.9.1729882385417;
        Fri, 25 Oct 2024 11:53:05 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f298ddbsm98733966b.142.2024.10.25.11.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:53:05 -0700 (PDT)
Message-ID: <d5d606b5-1135-4ed2-a2cd-8c2f7053cbbf@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:53:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] soc: qcom: geni-se: Do not keep GPIOs to sleep
 state for shared SE usecase
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        konrad.dybcio@linaro.org, andersson@kernel.org, andi.shyti@kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        conor+dt@kernel.org, agross@kernel.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, linux@treblig.org, dan.carpenter@linaro.org,
        Frank.Li@nxp.com, konradybcio@kernel.org, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, robh@kernel.org
References: <20240927063108.2773304-1-quic_msavaliy@quicinc.com>
 <20240927063108.2773304-4-quic_msavaliy@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20240927063108.2773304-4-quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IvQsozZbh9dhmgtSooinKk6mA1Ca3jxN
X-Proofpoint-ORIG-GUID: IvQsozZbh9dhmgtSooinKk6mA1Ca3jxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250145

On 27.09.2024 8:31 AM, Mukesh Kumar Savaliya wrote:
> Currently the driver provides a function called geni_serial_resources_off()
> to turn off resources like clocks and  pinctrl.
> 
> For shared SE between two SS, we don't need to keep pinctrl to sleep state
> as other SS may be actively transferring data over SE. Hence,bypass keeping
> pinctrl to sleep state conditionally using shared_geni_se flag.
> 
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
>  drivers/soc/qcom/qcom-geni-se.c  | 14 ++++++++++----
>  include/linux/soc/qcom/geni-se.h |  3 +++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 2e8f24d5da80..89cf18699336 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>  
>  /* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
>  #define __DISABLE_TRACE_MMIO__
> @@ -503,10 +504,15 @@ int geni_se_resources_off(struct geni_se *se)
>  
>  	if (has_acpi_companion(se->dev))
>  		return 0;
> -
> -	ret = pinctrl_pm_select_sleep_state(se->dev);
> -	if (ret)
> -		return ret;
> +	/* Keep pinctrl to sleep state only for regular usecase.
> +	 * Do not sleep pinctrl for shared SE because other SS(subsystems)
> +	 * may continueto perform transfer.
> +	 */

/*
 * Don't alter pin states on shared SEs to avoid potentially
 * interrupting transfers started by other subsystems
 */


> +	if (se->shared_geni_se == false) {

if (!se->shared_geni_se)

> +		ret = pinctrl_pm_select_sleep_state(se->dev);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	geni_se_clks_off(se);

Should the clocks be turned off?

Konrad

