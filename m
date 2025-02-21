Return-Path: <linux-kernel+bounces-526501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF7A3FF99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B117AE5E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2730250BE6;
	Fri, 21 Feb 2025 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XXf6pA+Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776245223
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165562; cv=none; b=hp3pT+p7t9PlFS0O+9WXtpkDyven+HdEE3sdADnsZsRN8sAjEvuWHVJoifCqO+b91mkD+M2I7tOQhxDMozyb7r1MhVE+V3KkCr8dfvZNNvILnyH+7yJ1vn7Jvms3oPUkijfpUXBJjKhSoc+MS5j8gR2CGSbCC0D3uo7fpFyzCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165562; c=relaxed/simple;
	bh=3FsXUcjyMsj/fKR24IGMc/BpLIWMyEaL1eNIx4lbbcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeiZie4w4VfbAZHDkmTTFIB7lbpEdHRh2sUbLVRTohqCfzkKpFgNuTsgZeppLvFvu7EC2O36KYmhLD5L2wWPrsspiGZ6BC69GpMOn+jm4QL7SMhApNB8mVa38jRQT0fuoHVZpDLuR8kaRy6+Bzuym94y5ysH4FXHTwaGt4Eaa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XXf6pA+Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCnmnF002872
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t0ZEwLWMa7i2eCHMRsfHLCETFObA7dX+eUVdYB5qpNM=; b=XXf6pA+QAvpQIMqA
	/Hpsbs7kFlPMq73kAyRn8/poULvVG1oNnDebpaQQJk97ZWLBZwLd/GB9t5OylWBm
	odD/3rpymr8daTqCkxmj0RvO8IvhuTTSJkm+kzXnp6fJcYuuH4VUxiLZGDSC8J4f
	+B5c70ETahHcreaTjE2e+BoFOyAvrZg0MPt+kEFPG44W5augA5+eVqsGw2VUR70n
	2EKgZ4kRhrkZ9M4YPvt5oI6HUJc/y8zYvoMisHYFKKE5YrZvVov2yGuAO3dovTda
	8gf+u+HylF+abYZYDlL26dLyT/VVId+IjwruvIQfWgobt73YS8VHITYA5mRjjyGb
	uFt/wQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy2k0nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:19:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e65eae5a26so4564986d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165558; x=1740770358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0ZEwLWMa7i2eCHMRsfHLCETFObA7dX+eUVdYB5qpNM=;
        b=pDfEUAwqShGwXkBI5hRdNziLAfmAXKX8Xs7f/5xSGJ0D7OM9Ypq/lh8FpVkk9ihwUL
         B3A6Pd7xCnI06n+ELbz/WRm3ZAJVKh7p03h4jYuyZ5CsAFCB/jjSil42EOSnjk9Z9ReU
         bKb6wW5Qpu44nUfWQQwxMnhOz5+uN3a7NZG2XB+ZRLoqZRrKswzDL5iwES64qWm4QcA6
         y/zJAVNSdpIIUQiMjxqBvPX0MbBo15W6/yHZSFh5naffindcnUpKhfbyo1cDG6q3UUvV
         A0pNdhqrBoRrFHh2VM+tRJvWTUUoLWb90gKfy621t1uYWPgfX3VUnvPhwlQX9s/JpZzY
         09hA==
X-Forwarded-Encrypted: i=1; AJvYcCV4F7TmIJVLYUzUxFv92yaEeMe+wxD2Hq57KyW/BvyX4XwzWz9M+VjXy73dmm4u7q7DrqzD3NWGhuXHX1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0KKw4w/3XlsJUY/f4yibUNQyuAW3qgPIlyIExMuALvuPb38m
	Fl72UEaxng0fzrbTovScBM+bQBFGZxEzAcKkOzuetzDV4My+vnZgXh06CC/KY3fiSixwgj8h2je
	aDx6lDfeOQ6EAVJMO8LB0SSwBeY1OuINUwPnU1C0UP8eJ9HiAMUzkNNiJg+cK4yM=
X-Gm-Gg: ASbGncuZbirhEb/93783LkeuC02VkCPi7aRx1nJMgc1iQDU5sRl+dmR67NWU0u4uUiI
	ivXvpx1HKmRXSLgXOeIMa1DVk0FDXEGMyPIoJKpzMhcH9CtBBoGzouFLdT0dLHc/JnAGU3sRRF5
	fh719M8bEgR5+CFBqMnKiL1VWO2joeYeGxSVnd6wuz5Unmjn861y9XOYNLxfnuqXqU7FSxBAAdy
	vKEVsYVG9oJ6cq9SSlXN8Yfkmotr4R8c7dPKwI6ct0fu+5n8eM62QVZQCerqG9Psyf5PCtimBGf
	vNGE1L0F8J3bSiNgVZjoELnlJVdqq9VzjGHLi88RmAQ/igboYqDOV7gFUYoVAlA1oOCR+A==
X-Received: by 2002:a05:6214:21a6:b0:6e4:29f8:1e9e with SMTP id 6a1803df08f44-6e6ae605315mr22838306d6.0.1740165558168;
        Fri, 21 Feb 2025 11:19:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhW3MLmL7S2e7Gj91t4H/Nt5yTWA6dC6NoPr4qt9eWPNM1uKafY3+IMSmE5YE2aq9t/fq1RA==
X-Received: by 2002:a05:6214:21a6:b0:6e4:29f8:1e9e with SMTP id 6a1803df08f44-6e6ae605315mr22838096d6.0.1740165557731;
        Fri, 21 Feb 2025 11:19:17 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbe7afb953sm441039466b.143.2025.02.21.11.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:19:17 -0800 (PST)
Message-ID: <1d9b661e-0607-4567-b420-5444b643df99@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 20:19:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: videocc: Add support to attach multiple
 power domains
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-4-cfe6289ea29b@quicinc.com>
 <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RBwmkRx2fq0rfnXENo0PO00fanSnCCXb
X-Proofpoint-GUID: RBwmkRx2fq0rfnXENo0PO00fanSnCCXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210133

On 18.02.2025 4:46 PM, Bryan O'Donoghue wrote:
> On 18/02/2025 14:26, Jagadeesh Kona wrote:
>> During boot-up, the PLL configuration might be missed even after
>> calling pll_configure() from the clock controller probe. This can
>> happen because the PLL is connected to one or more rails that are
>> turned off, and the current clock controller code cannot enable
>> multiple rails during probe. Consequently, the PLL may be activated
>> with suboptimal settings, causing functional issues.
>>
>> To properly configure the video PLLs in the probe on SM8450, SM8475,
>> SM8550, and SM8650 platforms, the MXC rail must be ON along with MMCX.
>> Therefore, add support to attach multiple power domains to videocc on
>> these platforms.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
>>   drivers/clk/qcom/videocc-sm8450.c | 4 ++++
>>   drivers/clk/qcom/videocc-sm8550.c | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
>> index f26c7eccb62e7eb8dbd022e2f01fa496eb570b3f..b50a14547336580de88a741f1d33b126e9daa848 100644
>> --- a/drivers/clk/qcom/videocc-sm8450.c
>> +++ b/drivers/clk/qcom/videocc-sm8450.c
>> @@ -437,6 +437,10 @@ static int video_cc_sm8450_probe(struct platform_device *pdev)
>>       struct regmap *regmap;
>>       int ret;
>>   +    ret = qcom_cc_attach_pds(&pdev->dev, &video_cc_sm8450_desc);
>> +    if (ret)
>> +        return ret;
>> +
>>       ret = devm_pm_runtime_enable(&pdev->dev);
>>       if (ret)
>>           return ret;
>> diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
>> index 7c25a50cfa970dff55d701cb24bc3aa5924ca12d..d4b223d1392f0721afd1b582ed35d5061294079e 100644
>> --- a/drivers/clk/qcom/videocc-sm8550.c
>> +++ b/drivers/clk/qcom/videocc-sm8550.c
>> @@ -542,6 +542,10 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>>       int ret;
>>       u32 sleep_clk_offset = 0x8140;
>>   +    ret = qcom_cc_attach_pds(&pdev->dev, &video_cc_sm8550_desc);
>> +    if (ret)
>> +        return ret;
>> +
>>       ret = devm_pm_runtime_enable(&pdev->dev);
>>       if (ret)
>>           return ret;
>>
> 
> What's the difference between doing the attach here or doing it in really_probe() ?
> 
> There doesn't seem to be any difference except that we will have an additional delay introduced.
> 
> Are you describing a race condition ?
> 
> I don't see _logic_ here to moving the call into the controller's higher level probe.
> 
> Can you describe some more ?

I think this is a sane course of action:

1. associate pll config with the pll (treewide change)
2. add a generic pll_configure call that parses the type
3. store PLLs to be configured in an array of dt-bindings indices
4. move PLL configuration to really_probe
5. move RPM enablement to really_probe, make it conditional to limit resource
   waste on e.g. gcc
6. move attaching GDSCs to really_probe

Konrad

