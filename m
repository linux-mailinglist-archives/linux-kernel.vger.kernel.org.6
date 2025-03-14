Return-Path: <linux-kernel+bounces-561036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD3A60CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9829F3B0EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180EC1DE4D3;
	Fri, 14 Mar 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mn/OPDYa"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E017E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943313; cv=none; b=hru2dyWWa1RKj9NRZYkPPvDE0fhxHc5D15Q1cZOtUnEKh/K4q5ay2dg9CX96hF8zRwflxrr8lV7/tmXD+YgYcUxYt+Cyv07x0+ay1IEIweGXhaXodp03QR4gG7JQbq0KBMOcuMsS7LXlZMVUQXD+52ofRm1MnR49mP9eA5+CjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943313; c=relaxed/simple;
	bh=zb6xT2oZsSwyTUQB3pD4y4RRJdTB4nnvbdNWmI+Ia6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrm4olsIgNf53Pt0VAci0/3A5V7YeiqyzkGYMJ43PmGe2I4um5XqctoZKuKZE55lYjSBX9rychtLxHcvtfAgZyToCqa3NmX2Pb5T1zkdZNuYxT3FmaYFTd5rtbyxnQ3TevyxbygSRMEN3M2I4tnFJ9bLBR2TZ8f3sbFtyOCbWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mn/OPDYa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNP4Qv018322;
	Fri, 14 Mar 2025 09:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P5Ptco
	o0re4UupnZRhseH76+bGD+NG6A68s8gCEYTzI=; b=Mn/OPDYaG0OL/6nGYnKYOY
	DeQU50X23BQlguz7qfLDTLT0HtWVvH1ff7TYmK3WwBrFIXHbxWJa6glBFk+qBDIJ
	QaeDKrcTXjGTzQFxdOcAaF/3SOBKDxs6TvW9XgRVnQ5cb+UNmqjk7Kc3a/Sb2lhK
	qoSefv4V/2Tns0D6MvLoIxRTbhndbbHnW5ZGLb6kLpGs9Hb3skW3uFZ/+qNAWxVZ
	HT1GIio5HgioUzR5b1AHVzPHV/gZUOClPGQfG37lbvNHV3msXV7ubjJ+PP+BjCmr
	tuM+8ukjrkN1lUrdRFd752D59SQi6u4Ifqa1AzsIbEtkW5Ar8yvFm7me0eSfOu5g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0srcscr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:08:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E96Nbl017054;
	Fri, 14 Mar 2025 09:08:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c0srcscj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:08:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E96kuE027065;
	Fri, 14 Mar 2025 09:08:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsr644r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:08:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E988jd18415970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 09:08:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 767762004B;
	Fri, 14 Mar 2025 09:08:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F65320043;
	Fri, 14 Mar 2025 09:08:05 +0000 (GMT)
Received: from [9.39.22.126] (unknown [9.39.22.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 09:08:05 +0000 (GMT)
Message-ID: <1263bf89-a2dd-4ae9-a8f9-9c36ddd08208@linux.ibm.com>
Date: Fri, 14 Mar 2025 14:38:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] powerpc: fadump: use lock guard for mutex
To: Peter Zijlstra <peterz@infradead.org>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
References: <20250314054544.1998928-1-sshegde@linux.ibm.com>
 <20250314054544.1998928-4-sshegde@linux.ibm.com>
 <20250314082223.GT5880@noisy.programming.kicks-ass.net>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250314082223.GT5880@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2aHaGjGqb04H9xa5NdtJKF2BmYUQP55S
X-Proofpoint-GUID: 5qlFFH1qpa3l-RY29U11zq59JxMJzqO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=744 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140071



On 3/14/25 13:52, Peter Zijlstra wrote:

Thanks Peter for taking a look.

> On Fri, Mar 14, 2025 at 11:15:41AM +0530, Shrikanth Hegde wrote:
>> use guard(mutex) for scope based resource management of mutex.
>> This would make the code simpler and easier to maintain.
>>
>> More details on lock guards can be found at
>> https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/fadump.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 4b371c738213..5fd2c546fd8c 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -1374,15 +1374,13 @@ static void fadump_free_elfcorehdr_buf(void)
>>   
>>   static void fadump_invalidate_release_mem(void)
>>   {
>> -	mutex_lock(&fadump_mutex);
>> +	guard(mutex)(&fadump_mutex);
>> +
>>   	if (!fw_dump.dump_active) {
>> -		mutex_unlock(&fadump_mutex);
>>   		return;
>>   	}
>>   
>>   	fadump_cleanup();
>> -	mutex_unlock(&fadump_mutex);
>> -
> 
> This will result in running the below functions with the mutex held.
> 
>>   	fadump_free_elfcorehdr_buf();
>>   	fadump_release_memory(fw_dump.boot_mem_top, memblock_end_of_DRAM());
>>   	fadump_free_cpu_notes_buf();
> 

Ok. Got it, since the variable is still in scope unlock wont be called.
So, will use scoped_guard as you suggested below in v2.

> 
> The equivalent transformation for the above code would look like:
> 
> static void fadump_invalidate_release_mem(void)
> {
> 	scoped_guard (mutex, &fadump_mutex) {
> 		if (!fw_dump.dump_active)
> 			return;
> 
> 		fadump_cleanup();
> 	}
> 
> 	fadump_free_elfcorehdr_buf();
> 	...

ok.

