Return-Path: <linux-kernel+bounces-257350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AB49378E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FE01F22C18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E02144317;
	Fri, 19 Jul 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ICoQjZ8N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7E1DDC5;
	Fri, 19 Jul 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397808; cv=none; b=uecYStBaNM3lZ2bc9e2erlGAa+JMHSN9SIX1NGM04FFfMHIVoUf0cipKJjQxKHZEPxchL3WTdQzvaeeVJnP0TMZeOriJZXc8/an/K3GIbBMRGwRGsVLEfbgdd+QKtdUIv85iuXqlKySquEhWzV1w2vpbHj516oH0sSa748aKL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397808; c=relaxed/simple;
	bh=ULacYTSPCJ3wjF/9KOm4n0j8t29ntCigF+U5vIugRVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d/aQ5QpmBjwjbdVK1R5JCJ0bB6HGq7v7M2hLBCFvlUIhmbVDtiIP6Mqj7YATCL/PzcSLz7xOxEDriq1UU4m/PMBqpUKwlUbd4kknMojqOP7zR9z/r6aMMLel/5fpPanIZL5fwSZaDh1zGOJRxFpbc2+30OzhuUsT+2khTQ7tqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ICoQjZ8N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBaV5K016778;
	Fri, 19 Jul 2024 14:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TqH5ThulB6eCstIaJDjWzKRXS5vnwShMKgFVDmGVb/0=; b=ICoQjZ8NUPNe5f4N
	mDclJekaKVgroQ6Qrz14tR/RiPaux8UsniApsvhjPgv7JIgOE9F3nmTn/OULJfGG
	tROYUtyvXbo6i3SwqP7LjknvrmAOIxSKke8R3CgTULJHuNGVlhEj6nu6BNlbHi1U
	O+XqJRNlDQk+GLDRmOXQ9zrjNf9KOdH3jfKWC30a8lbtuW/zP6H83FAlpWdIjSjF
	9GXN9OLQbCIUv9B+QX46nh4tWwUYFP/6/V+8a6Htn3EBKf2+yeEJyTbYIORrXMy+
	TqULB5t7J0ePUXXbk3zzykQQ5mE12qUJGnOrHPy1X3K9FINTdER6jh3THc+gkcB0
	SVVhOA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40fe33hme0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 14:03:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46JE3D6F030286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 14:03:13 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Jul
 2024 07:03:13 -0700
Message-ID: <23bd2022-3c9d-4d9d-943b-7d58c9dabf81@quicinc.com>
Date: Fri, 19 Jul 2024 07:03:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: kprobes: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240622-md-arm-arch-arm-probes-kprobes-v1-1-0832bd6e45db@quicinc.com>
 <3808c973-1315-420c-900d-122a73a34f9e@quicinc.com>
 <05cacd03-686a-4ede-b485-7f4781f69b99@app.fastmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <05cacd03-686a-4ede-b485-7f4781f69b99@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0RWw6JnGzOaGyy_gip3MXxoTE7nIgdgC
X-Proofpoint-GUID: 0RWw6JnGzOaGyy_gip3MXxoTE7nIgdgC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407190106

On 7/19/2024 4:28 AM, Arnd Bergmann wrote:
> On Tue, Jul 9, 2024, at 21:53, Jeff Johnson wrote:
>> On 6/22/2024 9:34 PM, Jeff Johnson wrote:
>>> With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
>>>
>>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> ---
>>>  arch/arm/probes/kprobes/test-core.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
>>> index 171c7076b89f..6e9041a76b8b 100644
>>> --- a/arch/arm/probes/kprobes/test-core.c
>>> +++ b/arch/arm/probes/kprobes/test-core.c
>>> @@ -1664,6 +1664,7 @@ static void __exit kprobe_test_exit(void)
>>>  
>>>  module_init(run_all_tests)
>>>  module_exit(kprobe_test_exit)
>>> +MODULE_DESCRIPTION("ARM kprobes test module");
>>>  MODULE_LICENSE("GPL");
>>>  
>>>  #else /* !MODULE */
>>>
>>> ---
>>> base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
>>> change-id: 20240622-md-arm-arch-arm-probes-kprobes-34037098a2c3
>>
>> I don't see this in linux-next yet so following up to see if anything else is
>> needed to get this merged.
> 
> Hi Jeff,
> 
> The arm tree uses a separate submission system for reviewed
> patches to get into the tree, see
> 
> https://www.arm.linux.org.uk/developer/patches/info.php
> https://www.arm.linux.org.uk/developer/patches/section.php?section=0

Thanks for the pointer. Hard to keep track of these when submitting tree-wide!

> I looked at this file as well during build testing
> and ended up combining the change with a cleanup,
> If you like, I can send my version instead, see below.

Please send your version since it has additional cleanup.

/jeff


