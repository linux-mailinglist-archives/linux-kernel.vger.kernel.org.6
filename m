Return-Path: <linux-kernel+bounces-556352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F90A5C45B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 605287A0721
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950025DAE8;
	Tue, 11 Mar 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rJkKHNaj"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F70925DAEF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705234; cv=none; b=AiRHHtV/GEaIk+/poiVI0BangQ+AdRVMQ4+eoonIwuBl+HX0NmoFWR0kNiQq/Su8awM9OPn6xjdUVZLU996bn1MUK92PwUdSUYpKNeKgw9jPdL15XUuY1N/qdTXLl085Ac9b6P0Upbi1tPIr3eiifq2818aZ3PXcDAHV1EtPVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705234; c=relaxed/simple;
	bh=JlQUoCX0hzqze6qkRk7Ily2Bhy34BxtfNUipKn8yKAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBCRbs7WF9vdiSuTCwpqs6TtbFO4qLsJA8pAm1eqiGFRc53JbbMJsUiCFGbUMCnWc00KOu39E8iS/BY2kHukHlWFry3ti/tdfYGHKOWadFkERL5x/lzc6cGCIYQ2vrGOdm/uYEGhqMd8+6O8KS0xC1MO0o26re+MNlEnt/LCClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rJkKHNaj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9hksk004865;
	Tue, 11 Mar 2025 15:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qaQ2w3
	TLMMjCzYa1vsBD2iAPYa3Qq//yz0jlzCFLYZ8=; b=rJkKHNajy7JRd7W+UKZazw
	MnoAzNtO4sb7pgpwIzfkIM7mDlXAUWR5AYgUsSwczY03BiF7ADLWcS7PXaJgirdv
	JE25ue3oKFHm6OArCUzsVlhqAL30yTkWIIHgwqmZenBedgKAZZ7zcw1V5WF4pBHV
	aPw8iZvy8SQU7pBHIRS/d5q3nk1Chof5SLCExln31w/KIB6cDamaWEzCyTKeFkCO
	wV/kKb/29MO2jxbXYYygdiNAXXkzaEyd4mgQr8VJcOfmDh0mw58lDGwv5NL5Ltlj
	NwLpGGzhiKTTHm21NK9GG21+a+FqszzDIVWxsZHzM1+WVbUtCSM31muXAU2XdGaw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78qvn36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:00:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52BF0Pg1011198;
	Tue, 11 Mar 2025 15:00:25 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78qvn34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:00:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BEi2mJ014011;
	Tue, 11 Mar 2025 15:00:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592x1vb1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:00:24 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BF0NSc29819512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 15:00:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C826C5805C;
	Tue, 11 Mar 2025 15:00:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A0D458059;
	Tue, 11 Mar 2025 15:00:21 +0000 (GMT)
Received: from [9.109.210.46] (unknown [9.109.210.46])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 15:00:21 +0000 (GMT)
Message-ID: <b426c9f0-9d63-4764-825c-6d95e89353c0@linux.ibm.com>
Date: Tue, 11 Mar 2025 20:30:19 +0530
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
References: <20250310115305.13599-1-donettom@linux.ibm.com>
 <2025031051-gab-viability-e288@gregkh>
 <a30e4786-ed0e-4460-8b95-c56ab1d790ea@linux.ibm.com>
 <09f2a2bb-75ab-44e1-9e27-d4fa0c11a47b@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <09f2a2bb-75ab-44e1-9e27-d4fa0c11a47b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kwnNnOLKnNDY0yJA4ZXyNOLJj9cOo7h_
X-Proofpoint-ORIG-GUID: LYaZM-NtroO8oGMPCwpIhiOpZ7D02xzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=803 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110094


On 3/11/25 2:59 PM, David Hildenbrand wrote:
> On 11.03.25 09:56, Donet Tom wrote:
>>
>> On 3/10/25 6:22 PM, Greg Kroah-Hartman wrote:
>>> On Mon, Mar 10, 2025 at 06:53:05AM -0500, Donet Tom wrote:
>>>> On large systems with more than 64TB of DRAM, if the memory blocks
>>>> are interleaved, node initialization (node_dev_init()) could take
>>>> a long time since it iterates over each memory block. If the memory
>>>> block belongs to the current iterating node, the first pfn_to_nid
>>>> will provide the correct value. Otherwise, it will iterate over all
>>>> PFNs and check the nid. On non-preemptive kernels, this can result
>>>> in a watchdog softlockup warning. Even though CONFIG_PREEMPT_LAZY
>>>> is enabled in kernels now [1], we may still need to fix older
>>>> stable kernels to avoid encountering these kernel warnings during
>>>> boot.
>>>>
>>>> This patch adds a cond_resched() call in node_dev_init() to avoid
>>>> this warning.
>>>>
>>>> node_dev_init()
>>>>       register_one_node
>>>>           register_memory_blocks_under_node
>>>>               walk_memory_blocks()
>>>>                   register_mem_block_under_node_early
>>>>                       get_nid_for_pfn
>>>>                           early_pfn_to_nid
>>>>
>>>> In my system node4 has a memory block ranging from memory30351
>>>> to memory38524, and memory128433. The memory blocks between
>>>> memory38524 and memory128433 do not belong to this node.
>>>>
>>>> In  walk_memory_blocks() we iterate over all memblocks starting
>>>> from memory38524 to memory128433.
>>>> In register_mem_block_under_node_early(), up to memory38524, the
>>>> first pfn correctly returns the corresponding nid and the function
>>>> returns from there. But after memory38524 and until memory128433,
>>>> the loop iterates through each pfn and checks the nid. Since the nid
>>>> does not match the required nid, the loop continues. This causes
>>>> the soft lockups.
>>>>
>>>> [1]: 
>>>> https://lore.kernel.org/linuxppc-dev/20241116192306.88217-1-sshegde@linux.ibm.com/
>>>> Fixes: 2848a28b0a60 ("drivers/base/node: consolidate node device 
>>>> subsystem initialization in node_dev_init()")
>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>> ---
>>>>    drivers/base/node.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>>>> index 0ea653fa3433..107eb508e28e 100644
>>>> --- a/drivers/base/node.c
>>>> +++ b/drivers/base/node.c
>>>> @@ -975,5 +975,6 @@ void __init node_dev_init(void)
>>>>            ret = register_one_node(i);
>>>>            if (ret)
>>>>                panic("%s() failed to add node: %d\n", __func__, ret);
>>>> +        cond_resched();
>>> That's a horrible hack, sorry, but no, we can't sprinkle this around in
>>> random locations, especially as this is actually fixed by using a
>>> different scheduler model as you say.
>>>
>>> Why not just make the code faster so as to avoid the long time this
>>> takes?
>>
>>
>> Thanks Greg
>>
>> I was checking the code to see how to make it faster in order to
>> avoid the long time it takes.
>>
>> In below code path
>>
>> register_one_node()
>>       register_memory_blocks_under_node()
>>           walk_memory_blocks()
>>               register_mem_block_under_node_early()
>>
>> walk_memory_blocks() is iterating over all memblocks, and
>> register_mem_block_under_node_early() is iterating over the PFNs
>> to find the page_nid
>>
>> If the page_nid and the requested nid are the same, we will register
>> the memblock under the node and return.
>>
>> But if get_nid_for_pfn() returns a different nid (This means the
>> memblock is part of different nid), then the loop will iterate
>> over all PFNs of the memblock and check if the page_nid returned by
>> get_nid_for_pfn() and the requested nid are the same.
>>
>> IIUC, since all PFNs of a memblock return the same page_nid, we
>> should stop the loop if the page_nid returned does not match the
>> requested nid.
>
> Nodes can easily partially span "memory blocks". So your patch would 
> break these setups?


Does this mean one memory block can be part of two or
more nodes ? Some PFNs belong to one node, and the remaining
PFNs belong to another node?"

In that case, the current implementation adds the memory block to
only one node. In register_mem_block_under_node_early(), if the
first PFN returns the correct expected nid, the memory block will
be registered under that node. It does not iterate over the other
PFNs. Is this because of the assumption that one memory block
cannot be part of multiple nodes?

If one memory block cannot be part of multiple nodes, then we can
break if get_nid_for_pfn() returns the wrong nid, right?


>
> But I agree that iterating all pages is rather nasty. I wonder if we 
> could just walk all memblocks in the range?
>
> early_pfn_to_nid()->__early_pfn_to_nid() would lookup the memblock ... 
> for each PFN. Testing a range instead could be better.
>
> Something like "early_pfn_range_spans_nid()" could be useful for that.

Do you mean we should do it section by section within a memory block?

Thanks
Donet

