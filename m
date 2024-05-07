Return-Path: <linux-kernel+bounces-171189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A98BE0E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EBE1F25466
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1B156885;
	Tue,  7 May 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rKVq1Pft"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1E522E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080871; cv=none; b=niZXcLOu4isARtcQmHLtJuXOdeov0zUJ1Na7s2/4SD5nc1pkiWOxSK0cpyJuZBfU5KZYcKaTku029535ZafW6CmT/IbuQIlgEk32gbVbmXcub94zgAbyvP/wD9YiOztvQPHdvSB7MpmbN8+4ClQaI8JK8y6E8YwmTJXSBb4buPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080871; c=relaxed/simple;
	bh=R86h3dmQNSSgRfUX892bWfltMoDuK38iuJYXz16iPxU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gGuyQMye20JO0LlKiyS6RYx7028y8+B+lJfTaevf7v5ve2MD7Cb4GhViEaqdlrtyIj1OX2RocA19XG8RBMDR14/Su1m4dT3FaLDViWxKjt9dp1qe6vSPoi6iyRcFFJE0+IRqgtt8g15Emg3RRL9/iVYExHehtBuWO6n4aoiEW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rKVq1Pft; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4479Lgje011770;
	Tue, 7 May 2024 11:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eHhh0F2qb2F9s5RxzGqkPTTYhHf+MxJdcLcn2foBTDw=;
 b=rKVq1PftVehZrqC8Nj2xv2uXXy2gxtlU1ESuWaNBxzJnrJzSoh8FUGIgObo15t27gB0a
 vSjyANo05ElGeICQDeLpTGl1Yuz0ZsXyylovOe1X8guCZhtMPf0w+7Zap99DE4SdNWlh
 8FNTULHvRSjd4VLxTguCPabWxweowJZXfu4l7c8+ckifERzZjQ2Xjjw8q3hBHpsWnjqh
 OIlv+5ze2M4Dsx7ZDkrxkTyTzIhY7520whCrA3lo2AAtr9OmI19cR+DzxBEBJOHdvMNt
 6JuElMyCgpUYxM4guQrhT2jzKR3xtThS5KhAfOIcJEz+3P50sKAZRjrjA+biAzS9kKYx nA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyhkg8901-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:19:51 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 447BJo6u029215;
	Tue, 7 May 2024 11:19:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyhkg88x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:19:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 447933BP010569;
	Tue, 7 May 2024 11:16:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xx0bp5rtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:16:58 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 447BGtH759506944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 May 2024 11:16:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD61F5804E;
	Tue,  7 May 2024 11:16:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6FC75803F;
	Tue,  7 May 2024 11:16:38 +0000 (GMT)
Received: from [9.195.44.224] (unknown [9.195.44.224])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2024 11:16:38 +0000 (GMT)
Message-ID: <34f216da-da8f-44cc-a9fc-47c8634e84c6@linux.ibm.com>
Date: Tue, 7 May 2024 16:46:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
To: Ankur Arora <ankur.a.arora@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <74ffd154-5d92-4303-9977-6ddc9accdf01@linux.ibm.com>
 <CAHk-=whrTE30xzuq4mcXidT4M0z_HRYJW9i8M9gD9VG7d29Qpg@mail.gmail.com>
 <63314d92-9226-4005-a166-37c8648c5351@linux.ibm.com>
 <87r0esc5lb.fsf@oracle.com>
Content-Language: en-US
In-Reply-To: <87r0esc5lb.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2gXZq5Fe8Gvy-LtED-SbJaA0hcx4K16e
X-Proofpoint-GUID: LeOZCaEv_7tCGiCEZHStbH2AGOHXVA12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_05,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 mlxlogscore=970 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2405070078



On 4/27/24 12:30 AM, Ankur Arora wrote:
> 

Hi Ankur,

Sorry for the delay, I was on leave last week.
There might be a delay in response as I am recovering from fever. 

> 
> Great. I'm guessing these tests are when running in voluntary preemption
> mode (under PREEMPT_AUTO).
> 

It was run under preempt=none. 

> If you haven't, could you also try full preemption? There you should see
> identical results unless something is horribly wrong.

I tried preempt=full with patch you provided below. ran the hackbench for much longer 
with 100000 loops. I don't see any regression on the larger system. 
I see slight improvement in some cases.  I dont see any major regression with 10k ops 
which was tried earlier as well. 

==========================================================
1L ops.
==========================================================
Process 10 groups          :       9.85,       9.87(-0.20)
Process 20 groups          :      17.69,      17.32(2.09)
Process 30 groups          :      25.89,      25.96(-0.27)
Process 40 groups          :      34.70,      34.61(0.26)
Process 50 groups          :      44.02,      43.79(0.52)
Process 60 groups          :      52.72,      52.10(1.18)
Thread  10 groups          :      10.50,      10.52(-0.19)
Thread  20 groups          :      18.79,      18.60(1.01)
Process(Pipe) 10 groups    :      10.39,      10.37(0.19)
Process(Pipe) 20 groups    :      18.45,      18.54(-0.49)
Process(Pipe) 30 groups    :      25.63,      25.92(-1.13)
Process(Pipe) 40 groups    :      33.79,      33.49(0.89)
Process(Pipe) 50 groups    :      43.15,      41.83(3.06)
Process(Pipe) 60 groups    :      51.94,      50.32(3.12)
Thread(Pipe)  10 groups    :      10.73,      10.85(-1.12)
Thread(Pipe)  20 groups    :      19.24,      19.35(-0.57)

==========================================================
10k ops.

Process 10 groups          :       1.10,       1.10(0.00)
Process 20 groups          :       1.89,       1.88(0.53)
Process 30 groups          :       2.82,       2.80(0.71)
Process 40 groups          :       3.76,       3.76(0.00)
Process 50 groups          :       4.66,       4.79(-2.79)
Process 60 groups          :       5.74,       5.92(-3.14)
thread  10 groups          :       1.22,       1.20(1.64)
thread  20 groups          :       2.05,       2.05(0.00)
Process(Pipe) 10 groups    :       1.13,       1.13(0.00)
Process(Pipe) 20 groups    :       1.98,       1.93(2.53)
Process(Pipe) 30 groups    :       2.91,       2.75(5.50)
Process(Pipe) 40 groups    :       3.85,       3.65(5.19)
Process(Pipe) 50 groups    :       4.91,       4.91(0.00)
Process(Pipe) 60 groups    :       5.56,       5.90(-6.12)
thread(Pipe)  10 groups    :       1.23,       1.23(0.00)
thread(Pipe)  20 groups    :       1.99,       1.99(0.00)
==========================================================

Other than hackbench, I see slight improvement in unixbench and stress-ng --cpu workloads. 

> 
>> However, I still see 20-50%
>> regression on the larger system(320 CPUS). I will continue to debug why.
> 
> Could you try this patch? This is needed because PREEMPT_AUTO turns on
> CONFIG_PREEMPTION, but not CONFIG_PREEMPT:
> 


> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index eca293794a1e..599410050f6b 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -396,7 +396,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
>                 /* Returning to a kernel context with local irqs enabled. */
>                 WARN_ON_ONCE(!(regs->msr & MSR_EE));
>  again:
> -               if (IS_ENABLED(CONFIG_PREEMPT)) {
> +               if (IS_ENABLED(CONFIG_PREEMPTION)) {
>                         /* Return to preemptible kernel context */
>                         if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
>                                 if (preempt_count() == 0)
> 
> 
> --
> ankur

This patch can be considered as the enablement patch for Powerpc for preempt_auto. 
Michael, Nick, Do you see any concerns? 

Ankur, Could you please add this patch, if there are no objections. 

---
From 878a5a7c990e3459758a5d19d7697b07d8d27d0f Mon Sep 17 00:00:00 2001
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Date: Tue, 7 May 2024 04:42:04 -0500
Subject: [PATCH] powerpc: add support for preempt_auto

Add PowerPC arch support for PREEMPT_AUTO by defining LAZY bits. 

Since PowerPC doesn't use generic exit to functions, Add 
NR_LAZY check in exit to user and exit to kernel from interrupt 
routines.  

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/thread_info.h | 11 ++++++++++-
 arch/powerpc/kernel/interrupt.c        |  6 ++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be3373686..11e7008f5dd3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -268,6 +268,7 @@ config PPC
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_AUTO
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 15c5691dd218..227b9273e2e9 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -118,10 +118,19 @@ void arch_setup_new_exec(void);
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
 
+#ifdef CONFIG_PREEMPT_AUTO
+#define TIF_NEED_RESCHED_LAZY	21	/* Lazy rescheduling */
+#endif
+
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
+
+#ifdef CONFIG_PREEMPT_AUTO
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
+#endif
+
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
@@ -144,7 +153,7 @@ void arch_setup_new_exec(void);
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
 				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
-				 _TIF_NOTIFY_SIGNAL)
+				 _TIF_NOTIFY_SIGNAL | _TIF_NEED_RESCHED_LAZY)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
 
 /* Bits in local_flags */
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index eca293794a1e..0c0b7010995a 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -185,7 +185,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 	ti_flags = read_thread_flags();
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable();
-		if (ti_flags & _TIF_NEED_RESCHED) {
+		if (ti_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
 			schedule();
 		} else {
 			/*
@@ -396,7 +396,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 		/* Returning to a kernel context with local irqs enabled. */
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
-		if (IS_ENABLED(CONFIG_PREEMPT)) {
+
+		if ((IS_ENABLED(CONFIG_PREEMPT_AUTO) && IS_ENABLED(CONFIG_PREEMPTION)) ||
+		    (!IS_ENABLED(CONFIG_PREEMPT_AUTO) && IS_ENABLED(CONFIG_PREEMPT))) {
 			/* Return to preemptible kernel context */
 			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
-- 
2.39.3

