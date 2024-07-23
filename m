Return-Path: <linux-kernel+bounces-260327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6D93A763
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6755C1F23C16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B413D62C;
	Tue, 23 Jul 2024 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZwA+3BXU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068BFBE6C;
	Tue, 23 Jul 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760435; cv=none; b=kXWvoflIBondr66qzixljq8TjET8aJPZR5ruojGSDAQMiQvbiJCcVyLZUBIrh9c+lD0G5jpfFy7Jyu2lF/FnkvK5khWtlLZ3HaLsBwqeDhGd9183K/AFplfyZmJN+1YYs56H9wlxESW9rHlJ5Je/Ui2ZjbC5wT5xXyDYhniiFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760435; c=relaxed/simple;
	bh=SZ7YZGI5A6Q8VaS+G2weQH36madruxWj9Zz0O/00JHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XL+YMDie6Z+7Lt2LpjK+78gn6cbKNBueuQogNbjA5+ne6kqZeCnlATns6sLvFs/j/bZmtMOgqypF8U0XZyegQrPcSF0RCfBPlGZLgHoIzZh8M5ODLZLR/4cevvJxCnL0DQMFtIBW9h1c34c1o3+rmFHhKS+RPQQI+n+0mAcIHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZwA+3BXU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NA4vDs016652;
	Tue, 23 Jul 2024 18:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/jStz1GR0mU5SlLwDx04e3r6gsiVYDdfWZPMCBuX/E0=; b=ZwA+3BXUvSKZYsmZ
	w8v3aAro29Q/JNUHw/EhnnqdEhijYwU3EECbCMugW41EDs7lGkV9uSOfcMK67gP2
	GGhKaz1a0TggE3gShGOfG5BQnq1inQHi7Q2VSF6lrenN7QbXa8MF0ayEAq3YFaW/
	06x8pPsaVwGNwUzUUidyLWn8/geDObqBPM1tkeosUb59e8x5ELJazsyoB3hK5AvK
	rlAHtT0YwrRJx+WJrI124kw5u7BV9QoQoFcDUVtNuzViyCyTRNnOgvV9NjNTzD71
	1f0P2BRbdb/tPPwU7mhJHX/FJyuqM1jDHD2nEzF8mbeaQxDjnywCI6plWBad1iag
	YOZxYQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5m701h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:47:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIl9QR020610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:47:09 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:47:09 -0700
Message-ID: <a9fbff19-2ace-44d5-99d1-6df759cd45d1@quicinc.com>
Date: Tue, 23 Jul 2024 11:47:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: bitmap: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Yury Norov <yury.norov@gmail.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240531-lib-bitmap-v1-1-45a782cf3686@quicinc.com>
 <ZlqQwbOVxw9an-qZ@yury-ThinkPad>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZlqQwbOVxw9an-qZ@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9CXhgjG2hrrTZi806CT7MB_DfY1DAKti
X-Proofpoint-ORIG-GUID: 9CXhgjG2hrrTZi806CT7MB_DfY1DAKti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230130

On 5/31/2024 8:08 PM, Yury Norov wrote:
> On Fri, May 31, 2024 at 09:03:11AM -0700, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/find_bit_benchmark.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/cpumask_kunit.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bitmap.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>> This is the subset of "missing MODULE_DESCRIPTION()" which fall under
>> the scope of the BITMAP API entry in the MAINTAINERS file.
>> ---
>>  lib/cpumask_kunit.c      | 1 +
>>  lib/find_bit_benchmark.c | 1 +
>>  lib/test_bitmap.c        | 1 +
>>  3 files changed, 3 insertions(+)
>>
>> diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
>> index a105e6369efc..6b62a6bdd50e 100644
>> --- a/lib/cpumask_kunit.c
>> +++ b/lib/cpumask_kunit.c
>> @@ -152,4 +152,5 @@ static struct kunit_suite test_cpumask_suite = {
>>  };
>>  kunit_test_suite(test_cpumask_suite);
>>  
>> +MODULE_DESCRIPTION("KUnit tests for cpumask");
>>  MODULE_LICENSE("GPL");
>> diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
>> index d3fb09e6eff1..402e160e7186 100644
>> --- a/lib/find_bit_benchmark.c
>> +++ b/lib/find_bit_benchmark.c
>> @@ -194,4 +194,5 @@ static int __init find_bit_test(void)
>>  }
>>  module_init(find_bit_test);
>>  
>> +MODULE_DESCRIPTION("Test for find_*_bit functions");
>>  MODULE_LICENSE("GPL");
>> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
>> index 6dfb8d46a4ff..65a75d58ed9e 100644
>> --- a/lib/test_bitmap.c
>> +++ b/lib/test_bitmap.c
>> @@ -1486,4 +1486,5 @@ static void __init selftest(void)
>>  
>>  KSTM_MODULE_LOADERS(test_bitmap);
>>  MODULE_AUTHOR("david decotigny <david.decotigny@googlers.com>");
>> +MODULE_DESCRIPTION("Test cases for bitmap API");
>>  MODULE_LICENSE("GPL");
>>
>> ---
>> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
>> change-id: 20240531-lib-bitmap-7ce67db2d173
> 
> Applied in bitmap-for-next.

Hi,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff


