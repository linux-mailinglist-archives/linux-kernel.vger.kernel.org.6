Return-Path: <linux-kernel+bounces-426716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7E69DF6F6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0884428175E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 19:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A51D86CB;
	Sun,  1 Dec 2024 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DaOMPotv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34571D6DD1
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733081409; cv=none; b=i94dkFVlyu/jMKqmmoaHP2kffVNnDiFvPfHG1VqvKw5Iw8rdimJbGt4eRBip4xn7uugQLsAlU20+02r1b559ULnO07L5KFClGDzqY69V5eXHG3Az9iPu6JyVOb/FhA7XXb4HquUPaoRiTRY3ejJbLy2Cr08yUeSvOzFQchiu2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733081409; c=relaxed/simple;
	bh=6Kf8tB9ilT6d0mpo19SlhSw/5f2ZJINUZXzcpTuVw6E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mCStUXiLkF8IH6flFhhXQZD02WSWTJQT4gqR7mwIXu7g8/7i3bX4JLa2zesyifx85G7JEkaDlQUhz515TPco3IO/lJv13QGKGfeUSh2MNFbUPO1XUyDhQbtqH3+BMZyCtpOyj+1s2rbpytHnHbhmNUaKbESq0Z2l3ET+LzoIkuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DaOMPotv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1CGRp7016242;
	Sun, 1 Dec 2024 19:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ug+81G
	43dnISkLbg6jEKkZvZdG9HXhHvZWd8Vu0ocs4=; b=DaOMPotvFKqZ/GsIRTG5FO
	X0jqt8wz61bidbOHsnNmOKSqIx35DoKWbmCaIw7KEzo54SOGpvueTEOfwGellFeF
	H0ChGly2R7lTv0KjE+kUxG7pq4GZ+Zgdyh2KQydKv01Q5EHM+YdwhdgKcmtVkTYl
	iiaw7WK5TOEq6/AlibyvvDRYqV64xpewTKWprKi55bhO2pGrNWXWIvJfwRHbpxwD
	/MkoDsPrtj0d6Id/1aS64OaJ4UFQlwqXD8l7lx8z21nZvklM8Uy1CGMm8nb0EBew
	dFQNGbuyiOKhoZkIMHRZG4QAoOJijpLUAPaDsg8LlA7rp46lHvKwQYeXRVY8rMpA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4hncnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Dec 2024 19:29:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B1JTYBD023361;
	Sun, 1 Dec 2024 19:29:34 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4hncn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Dec 2024 19:29:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1HGxaE012745;
	Sun, 1 Dec 2024 19:29:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1s155g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Dec 2024 19:29:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B1JT2O712517764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 1 Dec 2024 19:29:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF04720043;
	Sun,  1 Dec 2024 19:29:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A011B20040;
	Sun,  1 Dec 2024 19:29:00 +0000 (GMT)
Received: from [9.124.210.71] (unknown [9.124.210.71])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  1 Dec 2024 19:29:00 +0000 (GMT)
Message-ID: <abbab9de-bafd-4f40-a52e-07c8f8acc128@linux.ibm.com>
Date: Mon, 2 Dec 2024 00:58:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc: Add preempt lazy support
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Luming Yu <luming.yu@shingroup.cn>
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
        ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <20241116192306.88217-1-sshegde@linux.ibm.com>
 <20241116192306.88217-2-sshegde@linux.ibm.com>
 <97991c77-4d9c-4e33-a076-2dd79cd454fb@csgroup.eu>
Content-Language: en-US
In-Reply-To: <97991c77-4d9c-4e33-a076-2dd79cd454fb@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k8rGB5owLKhPA880f-OdP_o_t15JPstq
X-Proofpoint-ORIG-GUID: IiYabAzEM1BEcOD8QjnftRKkUs4pQu-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412010168



On 11/26/24 16:23, Christophe Leroy wrote:
> 
> 
> Le 16/11/2024 à 20:23, Shrikanth Hegde a écrit :
>> Define preempt lazy bit for Powerpc. Use bit 9 which is free and within
>> 16 bit range of NEED_RESCHED, so compiler can issue single andi.
>>
>> Since Powerpc doesn't use the generic entry/exit, add lazy check at exit
>> to user. CONFIG_PREEMPTION is defined for lazy/full/rt so use it for
>> return to kernel.
> 
> FWIW, there is work in progress on using generic entry/exit for powerpc, 
> if you can help testing it that can help, see https:// 
> patchwork.ozlabs.org/project/linuxppc-dev/patch/ 
> F0AE0A4571CE3126+20241111031934.1579-2-luming.yu@shingroup.cn/
>

I gave that series a try. After a lot of manual patching on tip tree and 
removal of multiple definition of regs_irqs_disabled, i was able to 
compile and boot.

I am skimming through the series, but as far as i understand from the 
comments, it needs to be redesigned. I probably get it why. I will go 
through it in more detail to figure out how to do it better. I believe 
the changes have to stem from interrupt_64.S

As far as the bits of this patch with that patch concerned, it is with 
NEED_RESCHED bits. There atleast couple of major issues in that patch 
series that are wrong.

1. It only tries to move exit to user to generic. exit to kernel is not. 
there is generic irqentry_exit that handles it for generic code. powerpc 
exit to kernel still there.

2. Even for exit to user, it ends up calling exit_to_user_mode_loop 
twice for the same syscall. that seems wrong. once in 
interrupt_exit_user_prepare_main and once through 
syscall_exit_to_user_mode in syscall_exit_prepare.


> Christophe
> 

So I guess, when we do eventually if move, this checks would be removed 
at that point along with rest of the code.

> 
>>
>> Ran a few benchmarks and db workload on Power10. Performance is close to
>> preempt=none/voluntary.
>> Since Powerpc systems can have large core count and large memory,
>> preempt lazy is going to be helpful in avoiding soft lockup issues.
>>
>> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   arch/powerpc/Kconfig                   | 1 +
>>   arch/powerpc/include/asm/thread_info.h | 9 ++++++---
>>   arch/powerpc/kernel/interrupt.c        | 4 ++--
>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 8094a01974cc..2f625aecf94b 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -145,6 +145,7 @@ config PPC
>>       select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>       select ARCH_HAS_PHYS_TO_DMA
>>       select ARCH_HAS_PMEM_API
>> +    select ARCH_HAS_PREEMPT_LAZY
>>       select ARCH_HAS_PTE_DEVMAP        if PPC_BOOK3S_64
>>       select ARCH_HAS_PTE_SPECIAL
>>       select ARCH_HAS_SCALED_CPUTIME        if 
>> VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
>> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/ 
>> include/asm/thread_info.h
>> index 6ebca2996f18..2785c7462ebf 100644
>> --- a/arch/powerpc/include/asm/thread_info.h
>> +++ b/arch/powerpc/include/asm/thread_info.h
>> @@ -103,6 +103,7 @@ void arch_setup_new_exec(void);
>>   #define TIF_PATCH_PENDING    6    /* pending live patching update */
>>   #define TIF_SYSCALL_AUDIT    7    /* syscall auditing active */
>>   #define TIF_SINGLESTEP        8    /* singlestepping active */
>> +#define TIF_NEED_RESCHED_LAZY    9       /* Scheduler driven lazy 
>> preemption */
>>   #define TIF_SECCOMP        10    /* secure computing */
>>   #define TIF_RESTOREALL        11    /* Restore all regs (implies 
>> NOERROR) */
>>   #define TIF_NOERROR        12    /* Force successful syscall return */
>> @@ -122,6 +123,7 @@ void arch_setup_new_exec(void);
>>   #define _TIF_SYSCALL_TRACE    (1<<TIF_SYSCALL_TRACE)
>>   #define _TIF_SIGPENDING        (1<<TIF_SIGPENDING)
>>   #define _TIF_NEED_RESCHED    (1<<TIF_NEED_RESCHED)
>> +#define _TIF_NEED_RESCHED_LAZY    (1<<TIF_NEED_RESCHED_LAZY)
>>   #define _TIF_NOTIFY_SIGNAL    (1<<TIF_NOTIFY_SIGNAL)
>>   #define _TIF_POLLING_NRFLAG    (1<<TIF_POLLING_NRFLAG)
>>   #define _TIF_32BIT        (1<<TIF_32BIT)
>> @@ -142,9 +144,10 @@ void arch_setup_new_exec(void);
>>                    _TIF_SYSCALL_EMU)
>>   #define _TIF_USER_WORK_MASK    (_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
>> -                 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
>> -                 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
>> -                 _TIF_NOTIFY_SIGNAL)
>> +                 _TIF_NEED_RESCHED_LAZY | _TIF_NOTIFY_RESUME | \
>> +                 _TIF_UPROBE | _TIF_RESTORE_TM | \
>> +                 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL)
>> +
>>   #define _TIF_PERSYSCALL_MASK    (_TIF_RESTOREALL|_TIF_NOERROR)
>>   /* Bits in local_flags */
>> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/ 
>> interrupt.c
>> index af62ec974b97..8f4acc55407b 100644
>> --- a/arch/powerpc/kernel/interrupt.c
>> +++ b/arch/powerpc/kernel/interrupt.c
>> @@ -185,7 +185,7 @@ interrupt_exit_user_prepare_main(unsigned long 
>> ret, struct pt_regs *regs)
>>       ti_flags = read_thread_flags();
>>       while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & 
>> ~_TIF_RESTORE_TM))) {
>>           local_irq_enable();
>> -        if (ti_flags & _TIF_NEED_RESCHED) {



>> +        if (ti_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
>>               schedule();
>>           } else {
>>               /*
>> @@ -396,7 +396,7 @@ notrace unsigned long 
>> interrupt_exit_kernel_prepare(struct pt_regs *regs)
>>           /* Returning to a kernel context with local irqs enabled. */
>>           WARN_ON_ONCE(!(regs->msr & MSR_EE));
>>   again:
>> -        if (IS_ENABLED(CONFIG_PREEMPT)) {
>> +        if (IS_ENABLED(CONFIG_PREEMPTION)) {
>>               /* Return to preemptible kernel context */
>>               if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
>>                   if (preempt_count() == 0)


