Return-Path: <linux-kernel+bounces-361662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179199AB0D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE891F22786
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ACC1CF5E9;
	Fri, 11 Oct 2024 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qp051Gr7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B41CF295
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671762; cv=none; b=YzxyqThFHQ53FlSPm1O9hfoyOWTHnSrtVdoSCWoAjohXS/jJGMt2OW2LlBET1+uCG4q7CwoCbjQOKAnzdLXc/9NqeYW8QZPpASmBqeQ/bEN8oZKxyvv6OKiy5tml5iaHyYv9FbYs8FKEzCz9u3zmjYYRHz5QuMeb/xcXlX8ADpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671762; c=relaxed/simple;
	bh=0hidQ5MfkmyvHI40g0/ibcmOTQpGB8cIdghja7+irzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4XYhr6hiJ7zg7rGHqyvvmuVmsXoNQL4BpMUK90BTyJnwO+5idi8Osmg0Lcnd1EGyUarn/AMEXcJH2EgIO7RDyQVhSCKT8ZtbHzOdW1xw6xrmtSpWb+WbJTwT/TepVL+CYW/fK02xd01C1MGjBx3hHRPrbh08xKcOANoreDI+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qp051Gr7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BH0HG0031847;
	Fri, 11 Oct 2024 18:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=4
	LUSWypVJS2G6tDqPkxmJZG2JoNqbbHG78ebm+yZJ34=; b=Qp051Gr77hLWMgR+V
	sMbSYvIXZZHII3j50vQMsx99vQMidn3wLavTx1PquIXtncy+GPATc3I2BU57An6k
	ujAMxlHZlvv9DQ39T/ody0IYjKGZQ2JF2q/IWyAJ3+t8uYpm7PQ4D0Ws4obmdSIC
	SNEfLt2ibgqBSjrJNIRD48bE19+osCrjfRIYFMDhRRHVh4FQWWXp0PV+RC0iTSDk
	3Ld/B29y7416DOBM831nnbi/OGoSbQKlQ9QbixmpQCLFupC1ujBKaFpcifoS0MEb
	I7OPk0xqVRNkOemSvGRf2J8E8HZILACSRheTXO7SiRxzdG9B0qmEilHhWeOriSB2
	Do6WA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42781kree6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 18:35:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49BIZQHJ003482;
	Fri, 11 Oct 2024 18:35:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42781kree1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 18:35:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BIQvX9022840;
	Fri, 11 Oct 2024 18:35:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg1erx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 18:35:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49BIZNrW42729778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 18:35:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C44112004B;
	Fri, 11 Oct 2024 18:35:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5558720049;
	Fri, 11 Oct 2024 18:35:20 +0000 (GMT)
Received: from [9.39.20.32] (unknown [9.39.20.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Oct 2024 18:35:20 +0000 (GMT)
Message-ID: <9f0dcdc6-121d-48a7-8abe-b2ce7acd0cdb@linux.ibm.com>
Date: Sat, 12 Oct 2024 00:05:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] powerpc: add support for PREEMPT_LAZY
To: Ankur Arora <ankur.a.arora@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-8-ankur.a.arora@oracle.com>
 <20241010072221.48wfFV7I@linutronix.de> <87jzef7rsx.fsf@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <87jzef7rsx.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eql3cwKKf8qigizO4nbvnsdAimxjx3eD
X-Proofpoint-ORIG-GUID: oinn3S8R2J25HOYGgoshKr42WtHCBgrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_15,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110128



On 10/10/24 23:40, Ankur Arora wrote:
> 
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
>> On 2024-10-09 09:54:11 [-0700], Ankur Arora wrote:
>>> From: Shrikanth Hegde <sshegde@linux.ibm.com>
>>>
>>> Add PowerPC arch support for PREEMPT_LAZY by defining LAZY bits.
>>>
>>> Since PowerPC doesn't use generic exit to functions, check for
>>> NEED_RESCHED_LAZY when exiting to user or to the kernel from
>>> interrupt routines.
>>>
>>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>> [ Changed TIF_NEED_RESCHED_LAZY to now be defined unconditionally. ]
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>>   arch/powerpc/Kconfig                   | 1 +
>>>   arch/powerpc/include/asm/thread_info.h | 5 ++++-
>>>   arch/powerpc/kernel/interrupt.c        | 5 +++--
>>>   3 files changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index 8094a01974cc..593a1d60d443 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -270,6 +270,7 @@ config PPC
>>>   	select HAVE_PERF_REGS
>>>   	select HAVE_PERF_USER_STACK_DUMP
>>>   	select HAVE_RETHOOK			if KPROBES
>>> +	select ARCH_HAS_PREEMPT_LAZY
>>>   	select HAVE_REGS_AND_STACK_ACCESS_API
>>>   	select HAVE_RELIABLE_STACKTRACE
>>>   	select HAVE_RSEQ
>>
>> I would move this up to the ARCH_HAS_ block.
> 
> Makes sense.
> 
>>> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
>>> index 6ebca2996f18..ae7793dae763 100644
>>> --- a/arch/powerpc/include/asm/thread_info.h
>>> +++ b/arch/powerpc/include/asm/thread_info.h
>>> @@ -117,11 +117,14 @@ void arch_setup_new_exec(void);
>>>   #endif
>>>   #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
>>>   #define TIF_32BIT		20	/* 32 bit binary */
>>> +#define TIF_NEED_RESCHED_LAZY	21	/* Lazy rescheduling */
>>
>> I don't see any of the bits being used in assembly anymore.
>> If you group the _TIF_USER_WORK_MASK bits it a single 16 bit block then
>> the compiler could issue a single andi.
> 

That's a good find. since by default powerpc uses 4 byte fixed ISA, 
compiler would generate extra code for _TIF_USER_WORK_MASK. Looked at 
the objdump. It indeed does.

I see that value 9 isn't being used. It was last used for TIF_NOHZ which 
is removed now. That value could be used for RESCHED_LAZY. Using that 
value i see the code generated is similar to what we have now.

+mpe

Ankur, Could you please change the value to 9?
---------------------------------------------------------------------

I see with value 9, andi is used again.

  254:   80 00 dc eb     ld      r30,128(r28)
  258:   4e 62 c9 73     andi.   r9,r30,25166


--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -103,6 +103,7 @@ void arch_setup_new_exec(void);
  #define TIF_PATCH_PENDING      6       /* pending live patching update */
  #define TIF_SYSCALL_AUDIT      7       /* syscall auditing active */
  #define TIF_SINGLESTEP         8       /* singlestepping active */
+#define TIF_NEED_RESCHED_LAZY  9       /* Lazy rescheduling */
  #define TIF_SECCOMP            10      /* secure computing */
  #define TIF_RESTOREALL         11      /* Restore all regs (implies 
NOERROR) */
  #define TIF_NOERROR            12      /* Force successful syscall 
return */
@@ -117,7 +118,6 @@ void arch_setup_new_exec(void);
  #endif
  #define TIF_POLLING_NRFLAG     19      /* true if poll_idle() is 
polling TIF_NEED_RESCHED */
  #define TIF_32BIT              20      /* 32 bit binary */
-#define TIF_NEED_RESCHED_LAZY  21      /* Lazy rescheduling */



