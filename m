Return-Path: <linux-kernel+bounces-445107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D69F115B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D881644DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B61E377E;
	Fri, 13 Dec 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldGQ9MtP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66EF1E0DE3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105047; cv=none; b=RCXXAegtaB5wmmWNVQiwwpFkAI7O4B5byX+ALRikO37IH4ROZAyd5RD5H4oDIokIheAYj9/tpaCUSw3pyFCajUksIzC35XwORVoaPOqEEKBBAl7RamNoE9tnf5uZNfGBETgznFw8yen75CcrxDLQiM17q+18psp7CHNOWS7pUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105047; c=relaxed/simple;
	bh=AH4YC3G4oAqm/Dy3ioJZ79XaboCBCeJ5Sqlc8mVdEvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0ATgvawxC3B1x15giuOxCanQ6ArVxjdDkbTqML+bMLKuPAkCdAeRVF/gzEgMOLhIJcFw5KIyNENPkFNeThIfZN3n/1zOrMNqZQcs4K2IPqLD0RPfn+Cf7uWMMOqJVavkSmZ5r7iXP6OvA2oGZXeHxuMcSDKKASSvv+SZNgKkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldGQ9MtP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBTqV2001425
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4lWamNQAIDfM3yyUtey6LSacCJIPjLImwXtS4zXm6hU=; b=ldGQ9MtPJZ2QCo2F
	RrlTV+WYdn25DDHsj2e3mZI049VVUyl1EIgquJhPbXwWBnVw30GQ8SpqpOE0tjfv
	OxFLtcJ1iJs9a0qTp8Xxr6R6DCfdld+o+mkLV0dVEe3wrazbbzkJ6WSnIu3V1+zY
	PklmGuuL5g/l5gQUlkyD3R5xM6nvswao9FTVG0sobvYQPj3SEQKlans3hhJFpNA0
	qrKS2qBbots7YBYRduiD5TPOtkF4ghQ4uapPBDVvcw0yYcYfFjDav8Oh4BJDtyzK
	1GMHo90qrqd0fM13cR2x4SHy55CrfF/8CnsUsh565zCFzdHSgjKsqJ44QeFjXlDt
	Uy1oYA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gm3s0pbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:50:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d887d2f283so4806786d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105043; x=1734709843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lWamNQAIDfM3yyUtey6LSacCJIPjLImwXtS4zXm6hU=;
        b=uVjf60o/tRzCBwvy+y1LL0EOCb21HsS4qITCgP8nqzofFY76Bn4WFa06LUvBpPBXnh
         xSy4+2S8DPMHR0BQuyE+cElUdD9kAKicgLE2/B0V6t5fhpd47JWl5oxwDRbqspmDcCyA
         htm6U01lHJ9/es77s4l7R7M5tnMtIkGtIYcy/GGIgbIzUN3xKKPa4tiWAms8RzKlHevY
         FJyRnfGH+rjyRuKp53vharwJ/77ZjL1g8dhnl7C6mjrWQzuO3vju53Px//QFuVITwODG
         MeQGSqASyE9ePZTrJv3qNzJinIqyRECRCFBuCzovNdNUIC9x1nTOhuGQtn928k+w8gZ1
         HAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmVmBn76i5Ur6daQVy+83QpuEhkMl6jL9/1J1XKOn3ewNnVX4UGOkQE9SW7iIpPONJS5+o5cLBdNrB7Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZf+nUrTdVEOWYUElSHGKp5vCudzABBnX6lUKAdsOVfZj58a4
	8ZybX2puL/NYy+mpjl/y0ar/NWBJtziWunnkYdKnpWPWfI0jg58uxggYz9TGWz8Qeyg8qOiLyym
	dgfLOcr46QG7BHEEl7WNC9Wbk9tXhypptnr5JzaYB+bdMxt2Oyo9NBSm9azV6YYA=
X-Gm-Gg: ASbGncv6swyDsmL4svj0+DJ6sagIWKiWTfu5iCzXXEUeMo2LGjt6b7jxgdXUhS+7xvT
	Pyq3DPSOijJmwuSLPP0wihqdU4iVlXtvMSzmHa07NZvoGvJQLj+j6L/JFHnx51B2Z/PHrH4JRPB
	h4VTM4bHjWNtir3Pr6F1A6gctD68cHhI3hPk3PpM+ew5StIgatJ4YKNBeEtewH5ran1f0LFGLOR
	u8YjaaTpbEzg47CIcm8hv3nyMIJWgIsfnnx+9FriGxPLqlcGmKjocqdj2pCSsNXfuU0koe9xlYw
	Z4ni3W6/VyFsOaVR6VOFyMYY3wy8puoPgB8b
X-Received: by 2002:a05:620a:4593:b0:7b6:dc5c:de2 with SMTP id af79cd13be357-7b6fbf402e6mr165103685a.13.1734105043586;
        Fri, 13 Dec 2024 07:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm8l6zBqCg8QGl9x4UXubkofdFN5ahIp8JE2QujG9aG5B1WdYVDkhDOOL+l9SSQJV+oU85hQ==
X-Received: by 2002:a05:620a:4593:b0:7b6:dc5c:de2 with SMTP id af79cd13be357-7b6fbf402e6mr165102485a.13.1734105043193;
        Fri, 13 Dec 2024 07:50:43 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3df2fc65bsm8769201a12.54.2024.12.13.07.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:50:42 -0800 (PST)
Message-ID: <2911fa29-1ecb-4d2d-a89b-2068f6fe3022@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 16:50:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal monitor
 support
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, quic_kamalw@quicinc.com,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4QM-NMbkApqIzfhYCmFXiGwRgfAfP955
X-Proofpoint-GUID: 4QM-NMbkApqIzfhYCmFXiGwRgfAfP955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130112

On 12.12.2024 5:11 PM, Satya Priya Kakitapalli wrote:
> Add PM8775 ADC5 GEN3 Channel info and bindings for the MBG Temp
> alarm peripheral found on PM8775 pmic.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  .../bindings/thermal/qcom-spmi-mbg-tm.yaml         | 86 ++++++++++++++++++++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8775.h           | 41 +++++++++++
>  2 files changed, 127 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..909373eb758e4a8b7c2bbd0022c56ab2e823ca13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-mbg-tm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SPMI PMIC MBG Thermal Monitoring
> +
> +maintainers:
> +  - Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> +
> +description:
> +  Qualcomm's MBG(Master Bandgap) temperature alarm monitors the die
> +  temperature and generates an interrupt if the PMIC die temperature is
> +  over a set of programmable temperature thresholds. It allows monitoring
> +  for both hot and cold, LVL1 and LVL2 thresholds, which makes it different
> +  from the existing temp alarm peripheral. The interrupt comes over SPMI
> +  and the MBG's fault status register gives details to understand whether
> +  it is a hot/cold and LVL1/LVL2 violation.
> +
> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,spmi-pm8775-mbg-tm

The bus the chip is connected over shouldn't be part of the compatible

Konrad

