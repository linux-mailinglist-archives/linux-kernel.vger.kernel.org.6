Return-Path: <linux-kernel+bounces-556364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A4FA5C48B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39AF178D32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B24625E81B;
	Tue, 11 Mar 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r8c2XwNa"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7560325E821
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705430; cv=none; b=LxMJYBMc29Q8STa+C2pHdYYyAh+MmwT6xq8qn7+9gIAjFEPy/1HM8ZLLMCQzJ33NG/JH2ZQ3U9dE2ur/xThxDG+GjpwoaVMAjHoPuGxWt9fFDKnKvGABIn2qj4lGPM1qef0hPZ7JSIVhzX7PLbhL6DPgavIMVSrwtR9gFo/n46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705430; c=relaxed/simple;
	bh=waqLr/OOQ31C8HcX3vcLyBL1G6pHMyaRaHrBv+13deI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMAKp2H5VNINYDd2PaTqwj6yEIyudZ/BjbSavU8XMveKlN0/UzL2Um15mM8siK3fxukHJ7OcJbzCfbD0lgm/lIqcyVKGWb59XA8U3vKlcIh0ealkIUMnmPHrW7dVpzvX4MVxAuEiNIe+BrfXBPV8Z3SDzxWz3o6vJY89mARWqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r8c2XwNa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCSmRY029598;
	Tue, 11 Mar 2025 15:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zN9XIs
	PmQotwZ5yZKj0m79rnP1mYOW/LvTP9R2Jujnc=; b=r8c2XwNa5MLhI8Hr1p3a/G
	FhkUQFx2nw242T6jXsC/GAIzlHSZqvnMv4iMvW6Mc2vWj28v1P4TU7DXtYVaYuCo
	Jcy3pehpR0aV4oNgsF++8sC5+PMqIk6kaACJhrjsq7tqwk9+3KTOmTY0EPI70n9P
	9a6jjsLip/koK8LrC9RtYB6zfLkIRfUc7sG+yWG9H2lOF4duigk4VsYZejpefQjE
	AcD3h98daYVfM4UDM2VcY57FPNG8CXOo6HMaSNgcMU/J3phC+JvUIVZGeR2ASip3
	KxYMxP8ZFoTxz5jim3oneOsAW/OpOHY9sC8ke/NwLgeRKyuxLEAnCMk14g1WAJlg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45an7bgvas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:03:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52BEYqYJ007508;
	Tue, 11 Mar 2025 15:03:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45an7bgvah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:03:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDG6pW027530;
	Tue, 11 Mar 2025 15:03:34 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4591qkmq92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:03:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BF3YLF64160108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 15:03:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78BAE58059;
	Tue, 11 Mar 2025 15:03:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 527105805B;
	Tue, 11 Mar 2025 15:03:32 +0000 (GMT)
Received: from [9.109.210.46] (unknown [9.109.210.46])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 15:03:31 +0000 (GMT)
Message-ID: <7c8b8dd2-0348-4311-b237-6129fcc60b08@linux.ibm.com>
Date: Tue, 11 Mar 2025 20:33:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver/base/node.c: Fix softlockups during the
 initialization of large systems with interleaved memory blocks
To: David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
References: <20250310115305.13599-1-donettom@linux.ibm.com>
 <5f8db79f-5eb3-48f0-a7cd-a903f9cbe75e@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <5f8db79f-5eb3-48f0-a7cd-a903f9cbe75e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Aor2YRTRTUMe48WhAksC9ogcY6onkXIU
X-Proofpoint-ORIG-GUID: eGOOEG2hc_7dNIdpNJ6n4xIi0a7FGKbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110094


On 3/11/25 2:52 PM, David Hildenbrand wrote:
> On 10.03.25 12:53, Donet Tom wrote:
>> On large systems with more than 64TB of DRAM, if the memory blocks
>> are interleaved, node initialization (node_dev_init()) could take
>> a long time since it iterates over each memory block. If the memory
>> block belongs to the current iterating node, the first pfn_to_nid
>> will provide the correct value. Otherwise, it will iterate over all
>> PFNs and check the nid. On non-preemptive kernels, this can result
>> in a watchdog softlockup warning. Even though CONFIG_PREEMPT_LAZY
>> is enabled in kernels now [1], we may still need to fix older
>> stable kernels to avoid encountering these kernel warnings during
>> boot.
>
> If it's not an issue upstream, there is no need for an upstream patch.
>
> Fix stable kernels separately.
>
> Or did I get you wrong and this can be triggered upstream?


Yes, the issue is present upstream if CONFIG_PREEMPT_LAZY is disabled.

Thanks
Donet


>
>>
>> This patch adds a cond_resched() call in node_dev_init() to avoid
>> this warning.
>>
>> node_dev_init()
>>      register_one_node
>>          register_memory_blocks_under_node
>>              walk_memory_blocks()
>>                  register_mem_block_under_node_early
>>                      get_nid_for_pfn
>>                          early_pfn_to_nid
>>
>> In my system node4 has a memory block ranging from memory30351
>> to memory38524, and memory128433. The memory blocks between
>> memory38524 and memory128433 do not belong to this node.
>>
>> In  walk_memory_blocks() we iterate over all memblocks starting
>> from memory38524 to memory128433.
>> In register_mem_block_under_node_early(), up to memory38524, the
>> first pfn correctly returns the corresponding nid and the function
>> returns from there. But after memory38524 and until memory128433,
>> the loop iterates through each pfn and checks the nid. Since the nid
>> does not match the required nid, the loop continues. This causes
>> the soft lockups.
>>
>> [1]: 
>> https://lore.kernel.org/linuxppc-dev/20241116192306.88217-1-sshegde@linux.ibm.com/
>> Fixes: 2848a28b0a60 ("drivers/base/node: consolidate node device 
>> subsystem initialization in node_dev_init()")
>
> That commit only moved code; so very likely, that is not the 
> problematic commit.
>
>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   drivers/base/node.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 0ea653fa3433..107eb508e28e 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -975,5 +975,6 @@ void __init node_dev_init(void)
>>           ret = register_one_node(i);
>>           if (ret)
>>               panic("%s() failed to add node: %d\n", __func__, ret);
>> +        cond_resched();
>>       }
>>   }
>
>

