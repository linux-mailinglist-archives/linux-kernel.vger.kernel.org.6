Return-Path: <linux-kernel+bounces-523122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13025A3D25F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FC9172E20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947CA1E98FF;
	Thu, 20 Feb 2025 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WahCwp+u"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A071B4236;
	Thu, 20 Feb 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036810; cv=none; b=dKO86NZh+SOmDN5IzzXlRSdt6jAQ0OsQOhbAGfMCnENcdqy4q/k7h3sxIp7MTLFf3+un4T339C/I2by7eGj3S+5M0kBpmTZeN6NkcCcrgMDG60tpCTmh8AXnev97l/S3Ip5LK2QgPCf8BqJnlTmn9YZs+sg6bWZWced6aV7OTI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036810; c=relaxed/simple;
	bh=qfktQxsrR0jCrrG973vqi6wovqwwDhVqkQOQ5Cv8kK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZxuHa6Hp/xpZcCj4b5VDAeovyIIzFja4SjhCAFmPZe7qyV06xpDwJ0hKjLOaKRk062bOl/AQU8zaLSauM1QgFQlH5X/1K+7kTwzbbbp2H5Ja+5nvEHH1A5tNiPCSNCFz6BOwVhJifmb8Pr9d2ifAUGT350VICw/3tDZlodlpdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WahCwp+u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6imo6016231;
	Thu, 20 Feb 2025 07:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kswv/0KcplL4nDKeu7ghMCJBi6VuEULInLAZ3cUQB08=; b=WahCwp+uwAlxoZ3b
	f8VoezZ+OHNculTJ3BdZQO31N90x+w1yVx3V1uFVP9dbwI/xoZDAEASe0nXB4PEe
	3NRJwP5vJBfBbEkpZq+e9RByF06JWYqpUS27KPVxAw+n0Cgw8e5+u5Oz8ooaS5bt
	IkCLWUsRn+fh97GPite1duc4vXc1FuExiYAc4M61vJ58ad71f6VFXpd13hCg07n9
	yo9Xmm0f3j3qVHwfhUKSR/yCQVPzrRf6dnvp6lLzf9PpdiEg5wVS4R7TO0iI+vRg
	LTt5o1DFzcCsAdfRkIk7Y20zkTpIcbuk+K9pONChiGbm8XgkqRZ2gYf0UjAip1l1
	EExcsg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy4db0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 07:33:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K7XCAP017270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 07:33:12 GMT
Received: from [10.64.68.119] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Feb
 2025 23:33:06 -0800
Message-ID: <1b22b005-4ad3-4ba9-9f6c-b540ed45dfc7@quicinc.com>
Date: Thu, 20 Feb 2025 15:33:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add MST support for qcs8300 platform
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250212-mst_qcs8300-v1-0-38a8aa08394b@quicinc.com>
 <87058b73-8854-4dbd-9f27-1da2a8240c16@kernel.org>
 <2ede97c5-a4f2-42fb-b3cd-68f26297150b@quicinc.com>
 <ffa5b482-2404-4497-a041-38f970cc9086@kernel.org>
Content-Language: en-US
From: Yongxing Mou <quic_yongmou@quicinc.com>
In-Reply-To: <ffa5b482-2404-4497-a041-38f970cc9086@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PjhgIJL9HvYOkZxFWN795Lzo-iwKEXdo
X-Proofpoint-ORIG-GUID: PjhgIJL9HvYOkZxFWN795Lzo-iwKEXdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200053



On 2025/2/19 20:07, Krzysztof Kozlowski wrote:
> On 19/02/2025 11:02, Yongxing Mou wrote:
>>
>>
>> On 2025/2/12 17:06, Krzysztof Kozlowski wrote:
>>> On 12/02/2025 08:12, Yongxing Mou wrote:
>>>> This series of patches introduces how to enable MST functionality on
>>>> the qcs8300 platform. The qcs8300 platform uses dpu_8_4 hardware, which
>>>> is the same as the sa8775p, but it only has one DPU. So it only has one
>>>> DP0 controller, supporting 4-stream MST. This patch only enables
>>>> 2-stream MST, using intf0 and intf3. The first and second patches are
>>>> modifications to the correspond dt-bindings, third patch is the dp
>>>> controller driver after not reuse sm8650, fourth patch is the qcs8300
>>>> dts modification which add the clk support for stream 1.
>>>>
>>>> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
>>>> ---
>>>> This patch depends on following series:
>>>> https://lore.kernel.org/all/20250120-mdssdt_qcs8300-v4-0-1687e7842125@quicinc.com/
>>>> https://lore.kernel.org/all/20250114-dts_qcs8300-v3-0-d114cc5e4af9@quicinc.com/
>>>> https://lore.kernel.org/all/20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com
>>>> https://lore.kernel.org/all/20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com/
>>>
>>> Buggy patch cannot be the dependency. You need to fix the original patch
>>> instead. You are not supposed to wait till knowingly incorrect patches
>>> get merged so you can send a fix. You must respond to that patch
>>> stopping its merging process.
>>>
>>> Best regards,
>>> Krzysztof
>> Thanks for the reminder. I hadn't noticed that before. We will wait for
>> our dependencies to be ready before sending the new patchset.
> 
> So this means you intend the knowingly incorrect patch to be applied? If
> so, all this should be just NAKed.
> 
> Best regards,
> Krzysztof
Hi, that is not my intention. I will correct the patch after i know it 
is incorrect. Thanks.

