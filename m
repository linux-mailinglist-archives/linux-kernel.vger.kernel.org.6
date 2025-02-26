Return-Path: <linux-kernel+bounces-533595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE9BA45C72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B253B188BDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF3C157E99;
	Wed, 26 Feb 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AB2idIOg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CB8F4A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567715; cv=none; b=F6fHW2YfDoOURy0j72erWmj1lF78bU1WeTSBKuYsS4hO5BAOmi7/S35gdeC0HspI5TKzx3FVBqOOnZvxNVZBzqMe+LnPpBzgE69fITLiU5mjlJRsFQDt8CPhMrjGI/ABtVBoo5hvRVcCrYUJoIHWVP9jkEfMgGdw2xJ0QMlIdL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567715; c=relaxed/simple;
	bh=ELh0DbRCnexYXj3fOKvjLvoyNSPP5ogImvS/80cg/jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GZWiY4jSG94NNyxxWPWkcmQtTJ4RPihbF4WSckP8BnSOgxQY2x/M26FjRELfrAhHZeYm/+wVONrYv0/dkpMwvnla51VsgrDIAF5o/He3v4NqhSkh5PpBcAySd/bnvjxrU0SnbSJ5XZaQaCl/pnx5kOUaZ1LorAfmS/9oZtprRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AB2idIOg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q9t2kE021388;
	Wed, 26 Feb 2025 11:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IpWjfMFq4T0n/31yeL4zQq7DoZUOnPGq6b5MktpgVn0=; b=AB2idIOgvss1mxnA
	aydR8PTnSm1ZHPXDGcFLtMkJl/9OmheQDy9GsHOO9dWttoYB1ce+RXlQZXF4Dh7t
	mvuiQugv/Kch0/emOYsbj2PWbb6Z8k7F1LinlrwicBvUq3i2tni1vZqADAkTL6HT
	ioS5tE61WpuFaVFibeQzSJ/NQX0123zLsSt7UtOblNQ+rTRp4O6/c4BClEA0hOjl
	Ttj90H/jpr50NuMgUuj1zswECRqJMR6teQo4iTb2RAQdc2xkyA5K9q1rT1kqJcUF
	o525Do2GBqDFJDACO9aUn2trAnIqf+BRiZaD+lzpMReSb9kjpUy0qwdvBesbgO0X
	G8i3aw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkhppm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 11:01:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51QB1eLK013037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 11:01:40 GMT
Received: from [10.239.133.114] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Feb
 2025 03:01:33 -0800
Message-ID: <bb9a1614-4702-4b3f-a22d-07402426569a@quicinc.com>
Date: Wed, 26 Feb 2025 19:01:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: Add Coresight device Trace NOC
 definition
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark
	<james.clark@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
CC: <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>
References: <20250220-trace-noc-driver-v1-0-15d78bd48e12@quicinc.com>
 <20250220-trace-noc-driver-v1-1-15d78bd48e12@quicinc.com>
 <1bdf70d0-5011-4faa-88c2-96703d3907e7@kernel.org>
Content-Language: en-US
From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
In-Reply-To: <1bdf70d0-5011-4faa-88c2-96703d3907e7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BebcDKPRBK6xzZx01_9D4Hj-j3Xhbmog
X-Proofpoint-ORIG-GUID: BebcDKPRBK6xzZx01_9D4Hj-j3Xhbmog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260088



On 2/20/2025 8:25 PM, Krzysztof Kozlowski wrote:
> On 20/02/2025 10:41, Yuanfang Zhang wrote:
>> Adds new coresight-tnoc.yaml file describing the bindings required
>> to define Trace NOC in the device trees.
>>
>> Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
> 
updated in https://lore.kernel.org/r/20250221-trace-noc-driver-v1-0-0a23fc643217@quicinc.com
>> ---
>>  .../bindings/arm/qcom,coresight-tnoc.yaml          | 107 +++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..b8c1aaf014fb483fd960ec55d1193fb3f66136d2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml
>> @@ -0,0 +1,107 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/qcom,coresight-tnoc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Ttrace NOC(Network On Chip)
>> +
>> +maintainers:
>> +  - yuanfang Zhang <quic_yuanfang@quicinc.com>
>> +
>> +description:
>> +  The Trace NoC is an integration hierarchy which is a replacement of Dragonlink tile configuration.
>> +  It brings together debug component like TPDA, funnel and interconnect Trace Noc which collects trace
> 
> Wrap according to coding style.
> 
Done in V2.
>> +  from subsystems and transfers to QDSS sink.
>> +
>> +  It sits in the different subsystem of SOC and aggregates the trace and transports it to Aggregation TNoC
>> +  or to QDSS trace sink eventually. Trace NoC embeds bridges for all the interfaces(APB, ATB, QPMDA & NTS).
>> +
>> +  Trace NoC can take inputs from different trace sources i.e. ATB, QPMDA.
>> +
>> +# Need a custom select here or 'arm,primecell' will match on lots of nodes
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - qcom,coresight-tnoc
>> +  required:
>> +    - compatible
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^tn(@[0-9a-f]+)$"
>> +  compatible:
>> +    items:
>> +      - const: qcom,coresight-tnoc
>> +      - const: arm,primecell
>> +
>> +  reg:
>> +    minItems: 1
>> +    maxItems: 2
> 
> Look how existing bindings do it. You need to list and describe the items.
> 
Done in V2.
> Best regards,
> Krzysztof


