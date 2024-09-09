Return-Path: <linux-kernel+bounces-321767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E425B971F32
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70998B22BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB21C1531D6;
	Mon,  9 Sep 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="maX7j6w8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91C2C87A;
	Mon,  9 Sep 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899261; cv=none; b=lP0JSPnf1GHeOBqwEEhu4C1bpSQDR/ZbA1uIdtKL/5dlo3AR5L6oR9awJRjfes2spaswy6xzVJMsXl3iFZCR1gL4WFwddGfxe/AUdDlNBOHadgBccI0mFW03rE3d75fcPlc7bZrGZnK0MIrsYKXqkXlS4VJqtImRWn5ze2kzKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899261; c=relaxed/simple;
	bh=gReMfDfyQxK0TNX+VbTFEwbiTxD2pt6LzymgTSl1Vi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k52jn3zo+Ocf2j0JjXlxMMFYvbLHafLVsQQoGqViuUeHvZ+Q7/+5vrQed/Y+Luq9uKKSc5dGcnToZFoftEBG9yGc69OskWhRPbD0xI3aj3mzrVG34LncVHZNk5QP9QKN0xi6bMHjYsQQ3yx9/tub9cFw0OqTzFLIGB3y3di2w5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=maX7j6w8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DRSHV024830;
	Mon, 9 Sep 2024 16:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QEnHSC22Ligfn27HbKmLaJnl2aanTUvxvtU0qRFqNk=; b=maX7j6w8BxPDGEMc
	QswnA7mdRwzT+aCa7v9Y77d99cRaIzi013VH0pQhp1iq3/0Y6LunMiSsUwMeaE8l
	j/xcQnrNqhw1D8RrrjMgOy7stQDl/qafOukBO75MF+h2nYpMKneebBkdEoJguhYA
	0oxDze4TzIR1ndUOnGF1bDcXe8wqGuQtyTUWvsIOhAz89DTf73T4N0TAPJx46+CE
	GxqlBuGgT90p0YDXwtmdFsvr8HrN0EpgrSzNR2u282DAgesFophR8F8kPNkvClVj
	f/Pz98x7IyBJqWYOYTmUG8Q4mrp5cpwdnY4lctvsf8S1xGmeMbD0o83IeiphUXfL
	UJgGag==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5rbdra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 16:27:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 489GRYT6013497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 16:27:34 GMT
Received: from [10.110.76.134] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Sep 2024
 09:27:31 -0700
Message-ID: <3f4bfa7b-c365-4fcb-a818-18e2f9351475@quicinc.com>
Date: Mon, 9 Sep 2024 09:27:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: arm: GIC: add ESPI and EPPI specifiers
To: Rob Herring <robh@kernel.org>
CC: <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_psodagud@quicinc.com>
References: <20240908010205.863701-1-quic_nkela@quicinc.com>
 <20240909155431.GA207498-robh@kernel.org>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20240909155431.GA207498-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sQ4O9qt3Gn1LRs0oXduX4kD6-FmdVpha
X-Proofpoint-ORIG-GUID: sQ4O9qt3Gn1LRs0oXduX4kD6-FmdVpha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=751 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409090130


On 9/9/2024 8:54 AM, Rob Herring wrote:
> On Sat, Sep 07, 2024 at 06:02:05PM -0700, Nikunj Kela wrote:
>> Add interrupt specifier for extended SPI and extended PPI interrupts.
> Are extended SPI and PPI a GIC defined thing? What version of GIC?
>
> Yes, I think I already asked these questions, but I only remember what 
> you put into the commit message.

Got it, let me add those details in the commit description. Thanks


>
>> Qualcomm SA8255p platform uses extended SPI for SCMI 'a2p' doorbells.
>>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> ---
>>
>> Changes in v3:
>> 	- Removed the patch from original series[1]
>>
>> Changes in v2:
>> 	- Modified subject line and description
>> 	- Added EPPI macro
>>
>> [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
>> ---
>>  include/dt-bindings/interrupt-controller/arm-gic.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/dt-bindings/interrupt-controller/arm-gic.h b/include/dt-bindings/interrupt-controller/arm-gic.h
>> index 35b6f69b7db6..887f53363e8a 100644
>> --- a/include/dt-bindings/interrupt-controller/arm-gic.h
>> +++ b/include/dt-bindings/interrupt-controller/arm-gic.h
>> @@ -12,6 +12,8 @@
>>  
>>  #define GIC_SPI 0
>>  #define GIC_PPI 1
>> +#define GIC_ESPI 2
>> +#define GIC_EPPI 3
>>  
>>  /*
>>   * Interrupt specifier cell 2.
>> -- 
>> 2.34.1
>>

