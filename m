Return-Path: <linux-kernel+bounces-555693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BBDA5BB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487B53AF69C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB3D22F3B1;
	Tue, 11 Mar 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oe0xKRIT"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2AF22F386
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683447; cv=none; b=FSJyttYkDVmY8g/wyxdftGhmX8pSqvoKVx3qbGaCN9Ue7pvvW2MRGeIR0a2+iJtkOGbhToIPsrFV0kQhl0ygRXrI8NBHHVLKMvFwZj46aC6XZS2NVnveK9rJjJ7+dW4kChMNrkNKboo+qgREKVukFqIru59J8p79A+l+frOuYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683447; c=relaxed/simple;
	bh=nmAhWj1xqW2lEGfTg1GXwWRGbNntk7hPq9K/xfcs+X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ty7kd1PYaIrg8qP+pNAIP9BpSmCucHHb/m2yuaFfnXGwDHb2fDjLLPXNNMLVJu9jFeyKxpK1CzAOEH49vIZeTbPqioV331smfRBU/Ri5pSSpoyHUy4Jp+wpIBG/rx+Y0SJePUHE9lJM85kxVNm4WsiMxexKQCfeXw+vej18ooi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oe0xKRIT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B3kASa002047;
	Tue, 11 Mar 2025 08:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YQOdL7
	ZraLqRexJPrH+Heu8cFDteK4B6JMywNu4I/CU=; b=oe0xKRITE14RAw8rU99Rwg
	V8OnpmO3GGiTt19bndFhMyTIxcvwZ8ras9us8L+yeHsrXUOp4BCyXMeMtU9q+J9L
	QurInl5j7RqLGlWZcTPMqofKdTgwR8rxJbhkw7PdDlT550wO0XYjqyWl0BtfQJOo
	ZmNOClYWIMPG/vCqIsp5D+/9DvBIOvU6lcO2CCWn/LYJN+XM0n+fTELfFPnKG/lC
	HhqW+zCOhDTp6USinbaP3k6znqjoRgC0LzMzRwCu7zzzxtU9m2/KmjkkbkjjwoSJ
	NBUNOdgxeAK7iHfDL+mDnA7EJVmr0ByJDFszXHW62h9sJhVWz3AJx6fBGfNhCQcQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45adjb1ens-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:57:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52B8pRu9011818;
	Tue, 11 Mar 2025 08:57:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45adjb1emv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:57:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B5gPIS023841;
	Tue, 11 Mar 2025 08:56:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4590kyudk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:56:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52B8uewh33096402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 08:56:41 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B10B358063;
	Tue, 11 Mar 2025 08:56:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 872CA58059;
	Tue, 11 Mar 2025 08:56:38 +0000 (GMT)
Received: from [9.109.210.46] (unknown [9.109.210.46])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 08:56:38 +0000 (GMT)
Message-ID: <a30e4786-ed0e-4460-8b95-c56ab1d790ea@linux.ibm.com>
Date: Tue, 11 Mar 2025 14:26:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver/base/node.c: Fix softlockups during the
 initialization of large systems with interleaved memory blocks
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
References: <20250310115305.13599-1-donettom@linux.ibm.com>
 <2025031051-gab-viability-e288@gregkh>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <2025031051-gab-viability-e288@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mlKANU3lbZnke5qdWbciB9AmX6T4nYtO
X-Proofpoint-GUID: Z7zUU3599bH29MFLvS7yn05z3jIYKO4u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110060


On 3/10/25 6:22 PM, Greg Kroah-Hartman wrote:
> On Mon, Mar 10, 2025 at 06:53:05AM -0500, Donet Tom wrote:
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
>>
>> This patch adds a cond_resched() call in node_dev_init() to avoid
>> this warning.
>>
>> node_dev_init()
>>      register_one_node
>>          register_memory_blocks_under_node
>>              walk_memory_blocks()
>>                  register_mem_block_under_node_early
>>                      get_nid_for_pfn
>>                          early_pfn_to_nid
>>
>> In my system node4 has a memory block ranging from memory30351
>> to memory38524, and memory128433. The memory blocks between
>> memory38524 and memory128433 do not belong to this node.
>>
>> In  walk_memory_blocks() we iterate over all memblocks starting
>> from memory38524 to memory128433.
>> In register_mem_block_under_node_early(), up to memory38524, the
>> first pfn correctly returns the corresponding nid and the function
>> returns from there. But after memory38524 and until memory128433,
>> the loop iterates through each pfn and checks the nid. Since the nid
>> does not match the required nid, the loop continues. This causes
>> the soft lockups.
>>
>> [1]: https://lore.kernel.org/linuxppc-dev/20241116192306.88217-1-sshegde@linux.ibm.com/
>> Fixes: 2848a28b0a60 ("drivers/base/node: consolidate node device subsystem initialization in node_dev_init()")
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   drivers/base/node.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 0ea653fa3433..107eb508e28e 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -975,5 +975,6 @@ void __init node_dev_init(void)
>>   		ret = register_one_node(i);
>>   		if (ret)
>>   			panic("%s() failed to add node: %d\n", __func__, ret);
>> +		cond_resched();
> That's a horrible hack, sorry, but no, we can't sprinkle this around in
> random locations, especially as this is actually fixed by using a
> different scheduler model as you say.
>
> Why not just make the code faster so as to avoid the long time this
> takes?


Thanks Greg

I was checking the code to see how to make it faster in order to
avoid the long time it takes.

In below code path

register_one_node()
     register_memory_blocks_under_node()
         walk_memory_blocks()
             register_mem_block_under_node_early()

walk_memory_blocks() is iterating over all memblocks, and
register_mem_block_under_node_early() is iterating over the PFNs
to find the page_nid

If the page_nid and the requested nid are the same, we will register
the memblock under the node and return.

But if get_nid_for_pfn() returns a different nid (This means the
memblock is part of different nid), then the loop will iterate
over all PFNs of the memblock and check if the page_nid returned by
get_nid_for_pfn() and the requested nid are the same.

IIUC, since all PFNs of a memblock return the same page_nid, we
should stop the loop if the page_nid returned does not match the
requested nid.

With the change below, softlockups are no longer observed.
What are your thoughts on this?

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ea653fa3433..5ca417e8672e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -811,7 +811,7 @@ static int 
register_mem_block_under_node_early(struct memory_block *mem_blk,
          if (page_nid < 0)
              continue;
          if (page_nid != nid)
-            continue;
+            break;

          do_register_memory_block_under_node(nid, mem_blk, MEMINIT_EARLY);
          return 0;


> thanks,
>
> greg k-h

