Return-Path: <linux-kernel+bounces-576982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68893A716F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0451890FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78601DE3B5;
	Wed, 26 Mar 2025 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rMQ0Sfzd"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0391E485
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993711; cv=none; b=hKKGFm+4H5hIVOs1RkMqZ2IBFIxFsiUdY7t6TwBitVrsJpuSz/nyU4de6nxVDqBiiDVU0MMR4aXoS2QSMjZIiX+8MQw4iOF2n5HommCt9arCL3HJ9xFT0pqrJIWmX1LWs0Vtot1DpXwCiFPKanbLfczaodBKQo7eT7SaQmQsPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993711; c=relaxed/simple;
	bh=yHaJWfUDOgIcM4VyUEbvZmViTVzoPTaliN4XUQoPTl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDULq1VcsuzNQC9BR51fhbse9dWD4fYtP0WRBwHFRopWqOGPUneD8Tv3GrJIqPsale0Z1pWP1oOdelJ4lINBVeU6vXfP5mKPGL28mn9AUwUqRk4LCiScKYs6wx0ecOMJTEXzstWmiBXpc2/6S2J/siFsuo1ZePOv2FHgKLSHrZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rMQ0Sfzd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q9ocmk032105;
	Wed, 26 Mar 2025 12:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fJNU42
	ThsQPoAClWgMGahyKWXC0siBkUSW80fzgGaoU=; b=rMQ0Sfzd0iCn2qshGj1pDj
	mjzQyPVZ0ijLxMqaIe2xLvSRga2Bq4dyIorOgONvnzoN8sPUoVXKR4JwbQ7aQyk5
	M0XQklT32ibauJV2ubEK0BvVSEmupxveMowK1xu66Vk+i2+4ixVFinafgKOnlAqz
	jyKJ2M1IwejqfVzR2GLD9gkCRp+/CK0ATWnaWyvuuqIApWCLlMbBrNdbLmN6a6HE
	4kgqlk+PqGChL06MqWg1ENhdUlI0hNG4OQOc3mHQxnsJP+ZKVykOTgbxPAqScV9c
	xYPKACyjDYI27uqR0Dm9IzD/QFKRLPMngL0e7gigsa+g9rIEOXpZhsrXy12ZSJwA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3q0krp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 12:54:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QAReGV012352;
	Wed, 26 Mar 2025 12:54:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91m8apa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 12:54:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QCseFq52494646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 12:54:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CB6A2004B;
	Wed, 26 Mar 2025 12:54:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCDB720043;
	Wed, 26 Mar 2025 12:54:37 +0000 (GMT)
Received: from [9.124.217.36] (unknown [9.124.217.36])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 12:54:37 +0000 (GMT)
Message-ID: <7c660d7a-6c70-4307-895f-70d4aa274886@linux.ibm.com>
Date: Wed, 26 Mar 2025 18:24:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        "Nysal Jan K.A." <nysal@linux.ibm.com>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <0713a015-b8dc-49db-a329-30891a10378c@linux.ibm.com>
 <587d45c3-2098-4914-9dfc-275b5d0b9bb7@linux.ibm.com>
 <20250326093153.Ib5b2p6M@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250326093153.Ib5b2p6M@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6D4zOKx5v0RH6aft5mp3FQsG7IqnUT0A
X-Proofpoint-GUID: 6D4zOKx5v0RH6aft5mp3FQsG7IqnUT0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_04,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=945 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260076



On 3/26/25 15:01, Sebastian Andrzej Siewior wrote:
> On 2025-03-26 00:34:23 [+0530], Shrikanth Hegde wrote:
>> Hi Sebastian.
> Hi Shrikanth,
> 

Hi.

>> So, did some more bench-marking using the same perf futex hash.
>> I see that perf creates N threads and binds each thread to a CPU and then
>> calls futex_wait such that it never blocks. It always returns EWOULDBLOCK.
>> only futex_hash is exercised.
> 
> It also does spin_lock() + unlock on the hash bucket. Without the
> locking, you would have constant numbers.
> 
Thanks for explanations.

Plus the way perf is doing, it would cause all the SMT threads to be up and 1 case
probably get the benefit of SMT folding. So anything after 40 threads, numbers don't change with baseline.

>> Numbers with different threads. (private futexes)
>> threads	baseline		with series    (ratio)
>> 1		3386265			3266560		0.96	
>> 10		1972069			 821565		0.41
>> 40		1580497			 277900		0.17
>> 80		1555482			 150450		0.096
>>
>>
>> With Shared Futex: (-s option)
>> Threads	baseline		with series    (ratio)
>> 80		590144			 585067		0.99
> 
> The shared numbers are equal since the code path there is unchanged.
> 
>> After looking into code, and after some hacking, could get the
>> performance back with below change. this is likely functionally not correct.
>> the reason for below change is,
>>
>> 1. perf report showed significant time in futex_private_hash_put.
>>     so removed rcu usage for users. that brought some improvements.
>>     from 150k to 300k. Is there a better way to do this users protection?
> 
> This is likely from the atomic dec operation itself. Then there is also
> the preemption counter operation. The inc should be also visible but
> might be inlined into the hash operation.
> This is _just_ the atomic inc/ dec that doubled the "throughput" but you
> don't have anything from the regular path.
> Anyway. To avoid the atomic part we would need to have a per-CPU counter
> instead of a global one and a more expensive slow path for the resize
> since you have to sum up all the per-CPU counters and so on. Not sure it
> is worth it.
> 

resize would happen when one does prctl right? or
it can happen automatically too?

fph is going to be on thread leader's CPU and using atomics to do
fph->users would likely cause cacheline bouncing no?

Not sure if this happens only due to this benchmark which doesn't actually block.
Maybe the real life use-case this doesn't matter.

>> 2. Since number of buckets would be less by default, this would cause hb
>>     collision. This was seen by queued_spin_lock_slowpath. Increased the hash
>>     bucket size what was before the series. That brought the numbers back to
>>     1.5M. This could be achieved with prctl in perf/bench/futex-hash.c i guess.
> 
> Yes. The idea is to avoid a resize at runtime and setting to something
> you know best. You can also use it now to disable the private hash and
> stick with the global.

yes. SET_SLOTS would take care of it.

> 
>> Note: Just increasing the hash bucket size without point 1, didn't matter much.
> 
> Sebastian

