Return-Path: <linux-kernel+bounces-433787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C63C9E5D06
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F083F281840
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FB225787;
	Thu,  5 Dec 2024 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JIqXCpJ8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A3224B03
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419498; cv=none; b=IHVl6RON0VNBBHqw7GfbFSnJzqcHa4hyEwP0ZxOE+R/vs0DT/LPYJUw1rV4HEJDYjyb286pw1mjvxYuBHykxSlp6FMX4WumhoQ1q1+J9fex4JUrv0mAJXG07tDIHFzvZb4oVsjfbl7C9BiX5wbu+5y0emao/U+sRWST0EuTdxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419498; c=relaxed/simple;
	bh=8iqaVQEzbHatx0dItN9CGjEVuPOwodMcycThZ2wp2ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWq2tfL64JugHhnzQttadwbQ+NovezcmgifFlcEfN0NFIhxSuKhimpodKkBrX8A3KYH3Y2GJvvA0zBbkq4zuXOuiIX/xxUifU1GrLhkNvlQ8YQk4ApqJA6/opitwzTSEXSdAPV7n2RaOdct08Q8m5ZimtkhoLIgwKnz0KOW4ZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JIqXCpJ8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B59vc5Z026537
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 17:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Yk44VEFeQYWq/aMUQP1cCfyktFWIWkcN9QVAYEAMyE=; b=JIqXCpJ8xHu7YLNG
	mH9q06PhkUQ1ha96qEo1/sR4UaPbtrGus2yxZXxNVUYA9hQHDznTsg4baxFPmkdt
	/M6HbHjQv5vhd+Q0tFi9G91Jeub7JOP2x2p3j1+R57InvgEvrGJM/rShXl+FgTHo
	RDf0goRJ6JgAQt0eNKeXPhVxGf22OVCvTP6MLTXHr5P7a85Ci2r8Ny7ET1XHAkRU
	4GqRlK1JAdR3egKiA65SooLS61RIWF63/G/lOAetPJeZlRKsS6gJ8qd/AmDsWZ7w
	3jnuC4cHSk56RxISEpibkkGAg5EDznKiKN8OfSxUCmU61NG5i4otSIQkNvgBy8K+
	naNfTw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba0kh802-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:24:56 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d88b9b62ebso3459456d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419495; x=1734024295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Yk44VEFeQYWq/aMUQP1cCfyktFWIWkcN9QVAYEAMyE=;
        b=hB27wPAjB3KIr6oQiiXAqoRI2xXb4tYMSSFW229Te5zDVUt5aZdXTEhpFJ5zRIuEjV
         V8tW8L8rlwtvWZBKcvwXOX0JEcwUVmC09oU2zRjiZksXJr2Qe9WlkxVe0UPZTgTlXNU3
         nmCnSDOKlBa8qd0RCVflxfVv+rYsVXlrnkmRZkTHj7NUL5Rw/vvRQl9P4Q1mYwecw8k8
         OQnWcH9e4bEOFTXeofXJl5i7pdCVbiRXp4f1aF8RaQhBglcVmiPWGC21vc2dfZbHHmx7
         K+01gtzObxYEoDjLxFHengijF9rYZqNasxSpKbCNjUN7rnkJpYjs/+1YtKdO0/UDnB7j
         iQMA==
X-Forwarded-Encrypted: i=1; AJvYcCUEHr1faNaEzvIsk0RYGOIrhBEos4SYoj545+2n0YQlWrtmKYqBmmMuXHyiSzjoUOxkGW6OWtfrkjGcZeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycrFabV3yO9Bt7OhgDveZSfzFTWSMWCTTxo7lzRq5K0/fEcakd
	h4Z2kcxranfhgTthfeBHijAXbgMVcf/0sgMEDR/LyEOz+x//owMepmomSL8EQwq9pVR9yMjNVDx
	WEwrg6tweW6SXDEv3bAkNi9khIqWzcVSbxmiVaZI7rdSGL0PjnH3uQs8KeFQJquk=
X-Gm-Gg: ASbGncuT86bnS90nb9xK46QbmUV9jovFOQT7GE9pdUMHk4YHctXRJCf2IdLM8ogICQw
	M66D5f8TfgL+VH+cO7PUOi8DdYUxujgScYmBigNFd2PAsgnocqbqzNJYp58oEkqSveGKp6LlyEk
	X8fZxpjEwLS75EcdVXpYJf/paS9A619TC/IvU9Pq5KWrvzvWGArOIjFtQlPaLbIefLgEQyajtQS
	Umnz+PGJcPYpzMib+xgsRs69dy2/vOinSRho3i4Rric7Y/69tAVYCCR/Q5a7VRZwd4tKxcClsZ0
	nz44CZErsgzV/77XdOPuB45kbYfTog0=
X-Received: by 2002:a05:6214:21e4:b0:6d8:adb8:eb92 with SMTP id 6a1803df08f44-6d8b72eec55mr75126636d6.1.1733419494929;
        Thu, 05 Dec 2024 09:24:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw9bsOhJSV0/o/fbAR4Gewtit13XCazbhsTB/3e9KkmJBjvW+hEQtMSQWw487E9cgauG0+qw==
X-Received: by 2002:a05:6214:21e4:b0:6d8:adb8:eb92 with SMTP id 6a1803df08f44-6d8b72eec55mr75126446d6.1.1733419494554;
        Thu, 05 Dec 2024 09:24:54 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e58ddesm121274466b.40.2024.12.05.09.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:24:53 -0800 (PST)
Message-ID: <5255398f-cc9d-4f85-8433-d6a4183dc449@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 18:24:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] soc: qcom: ice: Prevent UFS probe deferral on ICE
 probe failure
To: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241203024005.391654-1-quic_yrangana@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241203024005.391654-1-quic_yrangana@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xzRGkXWx9sajDKnWQvRzxACy457SEeCF
X-Proofpoint-GUID: xzRGkXWx9sajDKnWQvRzxACy457SEeCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050127

On 3.12.2024 3:40 AM, Yuvaraj Ranganathan wrote:
> When the ICE key programming interface is unavailable, the ice create
> function fails, causing the probe to set NULL as the driver data. As a 
> result, when the UFS driver reads the ICE driver data and encounters a 
> NULL, leading to the deferral of the UFS probe and preventing the device
> from booting to the shell.
> 
> To address this issue, modify the behavior to return an "operation not
> supported" error when the ICE key programming interface is unavailable.
> Additionally, mark this error in a global variable. When the UFS driver
> attempts to read the ICE driver data, it will check for this error and
> return it, rather than deferring the probe.
> 
> Signed-off-by: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
> ---
>  drivers/soc/qcom/ice.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index 393d2d1d275f..160916cb8fb0 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -41,6 +41,8 @@
>  #define qcom_ice_readl(engine, reg)	\
>  	readl((engine)->base + (reg))
>  
> +static bool qcom_ice_create_error;

So you could drop this..

> +
>  struct qcom_ice {
>  	struct device *dev;
>  	void __iomem *base;
> @@ -215,7 +217,7 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
>  
>  	if (!qcom_scm_ice_available()) {
>  		dev_warn(dev, "ICE SCM interface not found\n");
> -		return NULL;
> +		return ERR_PTR(-EOPNOTSUPP);
>  	}
>  
>  	engine = devm_kzalloc(dev, sizeof(*engine), GFP_KERNEL);
> @@ -303,6 +305,9 @@ struct qcom_ice *of_qcom_ice_get(struct device *dev)
>  		return ERR_PTR(-EPROBE_DEFER);
>  	}
>  
> +	if (qcom_ice_create_error)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	ice = platform_get_drvdata(pdev);
>  	if (!ice) {

..and check for || IS_ERR(ice) here

if I'm reading things right

Konrad

