Return-Path: <linux-kernel+bounces-402797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1749C2C48
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35F81F21E54
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3C3183CC3;
	Sat,  9 Nov 2024 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljK6H66X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C213B280
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153192; cv=none; b=iuJGOhmebRn4wAQ9HLvE7qZ9NlstGuNOgB8flUmXjpBaubGYQHfsB9/UDt7QOdLBh900KcpzSwvwqA8rqdx/zTfUwPnb2vsgmDzVVMzpNgl8HD2ZOhnxOX+vESmIzKCpizrHLpa30Ni1YPkcJPmR14iqWsqFpU7fZtvKtzyO/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153192; c=relaxed/simple;
	bh=WbO3bwNTbo9CJaITdFuh3lFQvk9b5CAZsrlvd0nPISU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTC+l2NPX/vUWqs2VQTOq5j+yoGq8Hgaii7ZavonHvfIeNS3g/ORgAF79+g1gLS9DNJhkbFTUE5QRd4u+nRTGe15Yhspyrlu1BvfK7dW7Ys2Wg3avcIFFnGWtdPuVdUn0hUDnX76Ww/GoloQwRPGxg8NzsDcrHFGbHvihUGLhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljK6H66X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A9BoY2p017067
	for <linux-kernel@vger.kernel.org>; Sat, 9 Nov 2024 11:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WbO3bwNTbo9CJaITdFuh3lFQvk9b5CAZsrlvd0nPISU=; b=ljK6H66Xjg6/l9L5
	msKLXhOB/aHsEyWw+SyAtPdiDrmdJAhQ28YGhSTKoJQtf4p0C8rDC1BA6Y9whRj+
	hEad6Zwc+rPEziO5SypeoWR/kb2EE95u+c1pFEvXmmSg6ihutXg9iaMtPrZzNIy0
	jPu2boRS2nh9zbeSZ1hOcnOLo7h2kxQP7rKOdfhdhOMW8ZWIvXVGpdF8adUYRdUu
	l0gfU8OrIfPtgFLpwoI/tjbFcE7uezjmYBqGh+nXPskqaoR8RrTAd/X385AlN3r9
	t6bjk1NlqgFOk+RH2w6qxzS4UEHh7RI6YBd9jFLZtAyxscsdXnL3WEORzSAjTmcs
	45jZhQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sytsgjpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 11:53:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cda6fd171bso1093336d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 03:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731153188; x=1731757988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbO3bwNTbo9CJaITdFuh3lFQvk9b5CAZsrlvd0nPISU=;
        b=DCP8FOA06n+CZe47R0aPY7Uz1v2622BFIdUjdD66akN4CA1e21SZJHS7PTRVCHk8D1
         E8eQ80jMiRG2zKXBi2knUs8HnuMXRZr4SYZ8WSCNMRQ9xdpHh5Gbckfd0204geqJpmla
         MI310GCSHr7GCxzNOTCbg8Ve3hWAU6UUVU2Ig4uSiatvYgd+VUlBz88D56nuZiJTjSQy
         ZSNTaVhWgFpkaufNJfG94wPDwVldi+Y6abAFB9e9nS+qM6AIn64Ml5eJQGvtncHALUUV
         JEP2TAurX3RdMCYIH2qekFkxhq+JjhZx/Mgrfgv2rKxJr/rqO7UgKeKxbPnscSj42UvO
         e6DA==
X-Forwarded-Encrypted: i=1; AJvYcCUtJJChGMMxqjWhupjhUc6hXl1y0BsL0PXRnOovUMQYHrDFNxRQvz6XDDOrJG5ZqmzG08iG6nJPWleOtkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznw4Y5rOxOyHxFkzrHYUGMissu8KB/T9V/k7CzdyAwgYCmNibt
	ataJSVkz6P90M5uiObWAySCCxvtPO5B5Z+mPveSmaQ0ED1K7UExoJ+Z+qnAqnEIiaP9OoJa9G9Q
	vl3mMn0J5zL4XFpOucma/gnLBh3GVIfx/wMmpLvvybxN2ooMQYEXOGaSUWgyGR0Y=
X-Received: by 2002:a05:620a:24d6:b0:7b1:8e09:5122 with SMTP id af79cd13be357-7b331dc1d1amr357301785a.1.1731153188350;
        Sat, 09 Nov 2024 03:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl7UYZzV/NRfxqM1jrH9cTW8r3ctv9OuDpOq1GOlGbjBAVwnStnlfGHEtxjiNYaEuj2o1SYw==
X-Received: by 2002:a05:620a:24d6:b0:7b1:8e09:5122 with SMTP id af79cd13be357-7b331dc1d1amr357300985a.1.1731153188005;
        Sat, 09 Nov 2024 03:53:08 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a48561sm351434366b.48.2024.11.09.03.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 03:53:07 -0800 (PST)
Message-ID: <f4a2598f-28be-47f5-9f6c-5cbbf911c3ef@oss.qualcomm.com>
Date: Sat, 9 Nov 2024 12:53:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] arm64: dts: qcom: Add initial support for
 MSM8917
To: barnabas.czeman@mainlining.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
 <20241107-msm8917-v3-12-6ddc5acd978b@mainlining.org>
 <0293b1c5-d405-4021-b9c1-205271107350@oss.qualcomm.com>
 <2c5f429d01fc04b2b40251e841bd4f64@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2c5f429d01fc04b2b40251e841bd4f64@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5KYe6ejVFvaJ-x4thhYcNwxrlQj6opjn
X-Proofpoint-ORIG-GUID: 5KYe6ejVFvaJ-x4thhYcNwxrlQj6opjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxlogscore=875 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411090101

On 9.11.2024 12:36 PM, barnabas.czeman@mainlining.org wrote:
> On 2024-11-08 18:03, Konrad Dybcio wrote:
>> On 7.11.2024 6:02 PM, Barnabás Czémán wrote:
>>> From: Otto Pflüger <otto.pflueger@abscue.de>
>>>
>>> Add initial support for MSM8917 SoC.
>>>
>>> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
>>> [reword commit, rebase, fix schema errors]
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---

[...]

>>> +                opp-19200000 {
>>> +                    opp-hz = /bits/ 64 <19200000>;
>>> +                };
>>
>> Does the GPU actually function at 19.2 MHz? You can check this by removing
>> all other entries and starting some gpu workload
> Yes

Thanks for confirming, feel free to keep this entry then

Konrad

