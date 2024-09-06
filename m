Return-Path: <linux-kernel+bounces-317997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EA896E6E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E6D28412C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3897A15E96;
	Fri,  6 Sep 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eUrPZAbV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A819460;
	Fri,  6 Sep 2024 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582804; cv=none; b=BvEI514iELDU5b3VlMD2EKcVYWvqfN42BZoYcPjL2aM0ziCupHV3ve3dsHPRQP5fSYJ8AiiX3R1lATEg/kyY/lGYDvpc7uNfGCUlfr7v4N6utRKb+dt5BtB3XqROUInRTc4LNfCGm/I3yEDFukSO/4ONdzXkC+b/rM7+fMi++m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582804; c=relaxed/simple;
	bh=+SaG3HdyFFS6K9MpKkI9hXwABspq9K6Y/xEfFlNjwaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d+TpEWifA1KAHo/nHMvnmkyKHFlfzzDwhzMDRyFAa5szaT7Jbg5JlkhpZxAK8+rlpYm5iywm9AG24YordQOrY6E/TYkdcxO7yuVLEVtgHfIp6epKnWm0TCSooOLG7G2jxVvBIYqtrLUGZFaij5BKrH2M7pPZWo5DnQ5OYNf6MKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eUrPZAbV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IPqe9021679;
	Fri, 6 Sep 2024 00:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SwknKDa+lL+CY82EpJaY5gO6oLbM8Im90CEUllwVcbA=; b=eUrPZAbVGIVTJTzI
	49Q8/TnFwsTTfT+Tpp+9FLYp+yK+Kujfx/F9kC34Z8dry3Ocg2B8VMnacer6wIut
	5vibmOPsPKK62Ndw0ksJsl3gSrurkTagsxuuCFeg6jdx+MwOZRI+JtMbPiHuWq+x
	33QN6Yojju+xQoMgqtTn7jk4E24fJLf+BIWYbboOk0rvcnLfCu+h2odyOy7v7l1H
	UvDPL2EbN5aBATa/4+7dDi4PbqG5UU0UbWxwB62d5KLWHASmqF2a6924EOrsKJQS
	PPaicy9St3aUUHz5McWeTHB9Flhdm0syqR0PpnKvAHAZoN3dLwsaVRPI4CPoXotv
	1KcYDA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhws0m55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 00:33:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4860X8Pk000975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 00:33:08 GMT
Received: from [10.110.102.234] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 17:33:04 -0700
Message-ID: <9930c7b8-cddb-4c70-a283-8f0a09d6c30d@quicinc.com>
Date: Thu, 5 Sep 2024 17:33:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: firmware: arm,scmi: allow multiple
 virtual instances
To: Peng Fan <peng.fan@nxp.com>,
        "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        "quic_psodagud@quicinc.com" <quic_psodagud@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20240905201217.3815113-1-quic_nkela@quicinc.com>
 <PAXPR04MB84593380F220DEC7974058D9889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <PAXPR04MB84593380F220DEC7974058D9889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5FU7gNIv7pcATW_JWxF4Eeg1uiw2XcEQ
X-Proofpoint-GUID: 5FU7gNIv7pcATW_JWxF4Eeg1uiw2XcEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060002


On 9/5/2024 5:25 PM, Peng Fan wrote:
>> Subject: [PATCH v3] dt-bindings: firmware: arm,scmi: allow multiple
>> virtual instances
> Just wonder, what do you mean virtual?

Just a term to indicate that these are different SCMI instances within
the same OS. In one of the series from Cristian, he used the term
'virtual SCMI instances' so I used the same term here.

Thanks,

-Nikunj

>
> Thanks,
> Peng.
>
>> This change extends scmi node name so as to allow multiple virtual
>> SCMI instances.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> ---
>>
>> Changes in v3:
>> 	- Added Reviewed-by tag
>> 	- Removed the patch from original series[1]
>>
>> Changes in v2:
>> 	- Fixed scmi nodename pattern
>>
>> [1]:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>> lore.kernel.org%2Fall%2F20240903220240.2594102-1-
>> quic_nkela%40quicinc.com%2F&data=05%7C02%7Cpeng.fan%40nxp.c
>> om%7C350f57ac3042490bed0808dccde71b35%7C686ea1d3bc2b4c6f
>> a92cd99c5c301635%7C0%7C0%7C638611639683033003%7CUnknow
>> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
>> 6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=zYYNSdVovTG
>> h5BBUqW%2BRNyxoO7EXrUtTppk4MiywowU%3D&reserved=0
>> ---
>>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> index 54d7d11bfed4..5d79b15a1610 100644
>> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>> @@ -27,7 +27,7 @@ anyOf:
>>
>>  properties:
>>    $nodename:
>> -    const: scmi
>> +    pattern: '^scmi(-[0-9]+)?$'
>>
>>    compatible:
>>      oneOf:
>> --
>> 2.34.1
>>

