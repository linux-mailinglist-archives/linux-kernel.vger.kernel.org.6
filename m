Return-Path: <linux-kernel+bounces-434981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BEF9E6DE1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40438166503
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7044200BBC;
	Fri,  6 Dec 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTC13rj/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE520103E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487275; cv=none; b=rS94wDc65RmSnKEs8OHcDIzN2EuN/5xe3U6k9seFiok6hrhQ7Un7bS5u0U8cHZmKxyrAqF+opJBEiSwvFX4OaUOXbw2M/dn6o0LOFXIl7cV6MyF2BPegdDkv2H/y/WoJSm2GwAfG/DBVLGHY42BZ6zy2NW9I7nF6OkHzX4yPxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487275; c=relaxed/simple;
	bh=MdkeGBoFKWIUCAPcL5K9k+34YiNLO8MevDvYtLeiJpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgJSguhbyOiPFgaV2PTIMmn92xq9OAqMZwDqfpfIbyVrfiaxVtwk0cwz0ySSr3iLNFk+lfDh1DXSQSeLfanSw3yFt9ao+O7Kv/oLMPL2h3CsloX0BpND8uy89c0CbdtktD03kjPrbScfBtMj7rQlp3Ic7jDXficZzHbWPZdejUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gTC13rj/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B673dlD031094
	for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2024 12:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aQolUbZ4tdLNvJJPFjB5x4DwtbPK92yn3ct3b1Mhntc=; b=gTC13rj/sZQffvuJ
	4rJv1gAJbzQh2K6Fodc49TEwOy3I1C1M7SiaWbuuR7BANnGPphmoUl8+orRGqY8J
	VFcgCXgrUQ2Cmzk5Gyh7G6pJEWXB0kb6KaZfQYBl1zpAGdowJsRLZygOZVQTjfyA
	r3nYfEM+oGxDu+/1vJF3GUt+CohhSnrY2FGHSSmXk+NkzNqF4MgiVWxaXkwvWwKU
	xXlYxKnhAeHKo3SaffmEvAiOJUdpHa27yC9f4CoOGBfpG0X3gBSZ9MfIgtSEWRQv
	Q7dUxW6sUwASyYztlT+lnhzYt3FVosF/RQ+/ry6tzN9RLLjhuQvKXtYB2Fg/u8fA
	AaZMyg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43be173450-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:14:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4668c9aa8c7so5072281cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 04:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733487271; x=1734092071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQolUbZ4tdLNvJJPFjB5x4DwtbPK92yn3ct3b1Mhntc=;
        b=DNlNPdc86XbJZIKXlfdXcdqJnHzU17qPzP0Nwfl6vAmcrEb959YuKnOZhSzIkBQZE1
         vDRso9Z4Cbg8K59mWB8BdRYAx/6Z9Mvw+jBLgAHApsszvAphwoHaXGWhOfASU2B+3GXN
         h6E0u7iLdVgmccRtmt1yO2WBEjGdcRRdaOKUmLb4YXM+swTmITjfgZyMw8bp097xVlsd
         IQ/TflNBhqFBlzvchN2BBHKOVv3vxc6VO+EgQv7SfBpq0hlll2uU3UGdP1DnXXyQAPjx
         5oYpQ8xuH0bPmT8bZsxbp82OU458BfWkXRjmqWa7TLSkoBibBXX7FMETKN4hmvBHUkGA
         ct2g==
X-Forwarded-Encrypted: i=1; AJvYcCXu1RFlDYA8xKAK02mLiPAGkS4I8KMaQGQls4+DdrmOu5qyEwI7UY63gRHcQ84zogQsucw5rVjtPjJBe1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gyoaOyYdVWy6NtH5TL9dfxy47mCh93RaudqzBG+DpLs5lUaD
	ivYap6MAKyxqK4QPxhKWrlNo/4oI4hxQzj1c7ulygPSFSTO4w0+JgxnvoPVM4Nnp62XYvN8pVJg
	9NwTwaprBzz0hmer3Co+ruUeSfH0qbGKzrZzdjuNvCwnHSNYJcz5aG4skH+yc27I=
X-Gm-Gg: ASbGncvmDQHLp4hfyRJpDVFYF5HpOw5kJvZAYeMq5g16MrcWWR+5zwt7XZL05XH7HtT
	fea4C8GhWlq2lxyD0fE8UuRwmrDp3eONRwSocL9iPZLerGFwJFnYA3Tp8Y8VnS3OJyWmDrJMIBC
	/k/2dgOulSthQj9dg2c2UwygEa3/3Hl3ZTvlAllSN0gD6mUcJW+nv2U1JQQuvpuaauASEXVKOKy
	WzaoLI1/h7ni8MKvHyQ7Abw+5d8MsUz2muBp8Z3/W098kOJVYy921neWcm4EoDdn5p5it2HishK
	L7uZb7OnV/BKh+0Mfn1wX0yteun+oI8=
X-Received: by 2002:ac8:7f06:0:b0:461:7457:d802 with SMTP id d75a77b69052e-46734d9dbccmr17678121cf.11.1733487270956;
        Fri, 06 Dec 2024 04:14:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFjwFn34SakpnAe+V4sfh6VOa9cWYtqnDDUM06wcuTSCY5LC8ey7fhpFsyeBAmwUBNBMbfJw==
X-Received: by 2002:ac8:7f06:0:b0:461:7457:d802 with SMTP id d75a77b69052e-46734d9dbccmr17677931cf.11.1733487270554;
        Fri, 06 Dec 2024 04:14:30 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7ab1fasm2096091a12.86.2024.12.06.04.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 04:14:30 -0800 (PST)
Message-ID: <cbed17c2-d839-42cb-8a33-b59538bfccf3@oss.qualcomm.com>
Date: Fri, 6 Dec 2024 13:14:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: Add support for QCS9075 Ride &
 Ride-r3
To: Wasim Nazir <quic_wasimn@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com
References: <20241119174954.1219002-1-quic_wasimn@quicinc.com>
 <20241119174954.1219002-6-quic_wasimn@quicinc.com>
 <9e351979-be01-4d38-9b94-cc23efac4c3f@kernel.org>
 <Z1LaN9nFr5msfq61@hu-wasimn-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z1LaN9nFr5msfq61@hu-wasimn-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vgUMFhkN3F804lJEjfgZwdXtNEi-uVho
X-Proofpoint-ORIG-GUID: vgUMFhkN3F804lJEjfgZwdXtNEi-uVho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060090

On 6.12.2024 12:04 PM, Wasim Nazir wrote:
> On Wed, Nov 20, 2024 at 05:44:11PM +0100, Krzysztof Kozlowski wrote:
>> On 19/11/2024 18:49, Wasim Nazir wrote:
>>> Add device tree support for QCS9075 Ride & Ride-r3 boards.
>>> QCS9075 Ride & Ride-r3 are similar to QCS9100 Ride and Ride-r3
>>> boards but without safety monitoring feature of SAfety-IsLand
>>> subsystem.
>>>
>>> Difference between ride and ride-r3 is the ethernet phy.
>>> Ride uses 1G ethernet phy while ride-r3 uses 2.5G ethernet phy.
>>>
>>> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/Makefile            |  2 ++
>>>  arch/arm64/boot/dts/qcom/qcs9075-ride-r3.dts | 12 ++++++++++++
>>>  arch/arm64/boot/dts/qcom/qcs9075-ride.dts    | 12 ++++++++++++
>>>  3 files changed, 26 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/qcs9075-ride-r3.dts
>>>  create mode 100644 arch/arm64/boot/dts/qcom/qcs9075-ride.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index 5d9847119f2e..91c811aca2ca 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -116,6 +116,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9075-rb8.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9075-ride.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9075-ride-r3.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/qcs9075-ride-r3.dts b/arch/arm64/boot/dts/qcom/qcs9075-ride-r3.dts
>>> new file mode 100644
>>> index 000000000000..a04c8d1fa258
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/qcs9075-ride-r3.dts
>>> @@ -0,0 +1,12 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +/dts-v1/;
>>> +
>>> +#include "sa8775p-ride-r3.dts"
>> No guys, you are making these things up. This is EXACTLY the same as
>> qcs9100.
> 
> 9100 & 9075 are different from “safe” perspective. They differ in
> changes related to thermal which will be added later in devicetree.

Since this can't be inferred from just looking at the changes, please
make sure to add that to the commit message

Konrad

