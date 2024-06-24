Return-Path: <linux-kernel+bounces-227787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A85B91568F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6F6B22E93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0019FA9E;
	Mon, 24 Jun 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CtlwXt6v"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1B1E4AE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254300; cv=none; b=U/GF+QmbzT9q+DHO6ymZENC/ozD9qF5shbPfNHR6XR+kDtRafke8Qoe/HJ28UycitkguR8qXnnpJX0IOo8dordA70bb1n9Ms6fxptmeBFRkTmjCqb1bN/WsgV0v18pO32g2dtYyMEVV7sDWfHvqoT6ETVESBER9g+yc+99LjomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254300; c=relaxed/simple;
	bh=0rNdYsEeufBzyt2hjCg6a2B/JpK38ANrZYIlfm8eA6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNObuj70BMNEcVbdCippH6P4F2HnKN1s4yJ8qYoD5v2iQmxaP4hP5QwWrKaWEYfJeN6/23OAboXNPkB4KAoh4vr4oQ/+QFe1jNVWjLsvE9GmfVhjUnlKVErWC4HZMenKijddh534Yr4JXfFHyZaVVhDdXZ5PxzhZXtnv1MC2eGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CtlwXt6v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OIUVlf028045;
	Mon, 24 Jun 2024 18:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=f
	Ko1luhsQDp6MrQu+6myONF0tx6tJXyVCKfc6xindTc=; b=CtlwXt6vtgzQ5WEZI
	goazQZ+2+6NZXNeWBhrswpjEMo7YA8MSr9Myxy7ocQvtzUQHLSDUqzz8AQoM52Jp
	w0AbSEMeUSqmuNk6sBfBAEBYU+VS3VcXgBK3NvkGTdbwPUd3phR+w1+LRXDEC8g0
	ondjtNKw3dtEq/nAI7SswTzMkaKgt77/Z1jfQysFAT3iq1Pkmdpgzjml6LJL0V5O
	Etns5F5AHwbGq4H5/Y504G4rhK0KpZQSfrtT/p6xWF75K4cNnMkzvrNRPTEZtBQL
	TEnS+haMQIrCCSe5DvPBrqwdUqFDm0XdPNdl5umPWXUCduBYzzn9MzwuP5je8H6z
	jPkvg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yye47g0r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 18:37:34 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45OIbYO5007180;
	Mon, 24 Jun 2024 18:37:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yye47g0r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 18:37:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OH9KYq019897;
	Mon, 24 Jun 2024 18:37:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5ma0w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 18:37:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45OIbUbL38928724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 18:37:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CFC658076;
	Mon, 24 Jun 2024 18:37:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0A705806F;
	Mon, 24 Jun 2024 18:37:24 +0000 (GMT)
Received: from [9.195.33.245] (unknown [9.195.33.245])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 18:37:24 +0000 (GMT)
Message-ID: <14d4584d-a087-4674-9e2b-810e96078b3a@linux.ibm.com>
Date: Tue, 25 Jun 2024 00:07:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com>
 <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
 <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com>
 <871q4td59k.fsf@oracle.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <871q4td59k.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: do48vBadhubkLN2k4wIhjPOV1DhqQWA9
X-Proofpoint-ORIG-GUID: UiFCHF8wCX8TaHq3YoCYkQlt9u7UkPFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_15,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240147



On 6/19/24 8:10 AM, Ankur Arora wrote:


>>>
>>> SOFTIRQ per second:
>>> ===================
>>> 6.10:
>>> ===================
>>> HI	TIMER	NET_TX	NET_RX	BLOCK	IRQ_POLL	TASKLET		SCHED		HRTIMER		RCU
>>> 0.00	3966.47	0.00	18.25	0.59	0.00		0.34		12811.00	0.00		9693.95
>>>
>>> Preempt_auto:
>>> ===================
>>> HI	TIMER	NET_TX	NET_RX	BLOCK	IRQ_POLL	TASKLET		SCHED		HRTIMER		RCU
>>> 0.00	4871.67	0.00	18.94	0.40	0.00		0.25		13518.66	0.00		15732.77
>>>
>>> Note: RCU softirq seems to increase significantly. Not sure which one triggers. still trying to figure out why.
>>> It maybe irq triggering to softirq or softirq causing more IPI.
>>
>> Did an experiment keeping the number of CPU constant, while changing the number of sockets they span across.CPU 
>> When all CPU belong to same socket, there is no regression w.r.t to PREEMPT_AUTO. Regression starts when the CPUs start
>> spanning across sockets.
> 
> Ah. That's really interesting. So, upto 160 CPUs was okay?

No. In both the cases CPUs are limited to 96. In one case its in single NUMA node and in other case its across two NUMA nodes. 

> 
>> Since Preempt auto by default enables preempt count, I think that may cause the regression. I see Powerpc uses generic implementation
>> which may not scale well.
> 
> Yeah this would explain why I don't see similar behaviour on a 384 CPU
> x86 box.
> 
> Also, IIRC the powerpc numbers on preempt=full were significantly worse
> than preempt=none. That test might also be worth doing once you have the
> percpu based method working.
> 
>> Will try to shift to percpu based method and see. will get back if I can get that done successfully.
> 
> Sounds good to me.
> 

Did give a try. Made the preempt count per CPU by adding it in paca field. Unfortunately it didn't
improve the the performance. Its more or less same as preempt_auto.  

Issue still remains illusive. Likely crux is that somehow IPI-interrupts and SOFTIRQs are increasing 
with preempt_auto. Doing some more data collection with perf/ftrace. Will share that soon. 

This was the patch which I tried to make it per cpu for powerpc: It boots and runs workload.
Implemented a simpler one instead of folding need resched into preempt count. By hacky way avoided 
tif_need_resched calls as didnt affect the throughput. Hence kept it simple. Below is the patch 
for reference. It didn't help fix the regression unless I implemented it wrongly.  


diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 1d58da946739..374642288061 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -268,6 +268,7 @@ struct paca_struct {
 	u16 slb_save_cache_ptr;
 #endif
 #endif /* CONFIG_PPC_BOOK3S_64 */
+	int preempt_count;
 #ifdef CONFIG_STACKPROTECTOR
 	unsigned long canary;
 #endif
diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/asm/preempt.h
new file mode 100644
index 000000000000..406dad1a0cf6
--- /dev/null
+++ b/arch/powerpc/include/asm/preempt.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_PREEMPT_H
+#define __ASM_PREEMPT_H
+
+#include <linux/thread_info.h>
+
+#ifdef CONFIG_PPC64
+#include <asm/paca.h>
+#endif
+#include <asm/percpu.h>
+#include <asm/smp.h>
+
+#define PREEMPT_ENABLED (0)
+
+/*
+ * We mask the PREEMPT_NEED_RESCHED bit so as not to confuse all current users
+ * that think a non-zero value indicates we cannot preempt.
+ */
+static __always_inline int preempt_count(void)
+{
+	return READ_ONCE(local_paca->preempt_count);
+}
+
+static __always_inline void preempt_count_set(int pc)
+{
+	WRITE_ONCE(local_paca->preempt_count, pc);
+}
+
+/*
+ * must be macros to avoid header recursion hell
+ */
+#define init_task_preempt_count(p) do { } while (0)
+
+#define init_idle_preempt_count(p, cpu) do { } while (0)
+
+static __always_inline void set_preempt_need_resched(void)
+{
+}
+
+static __always_inline void clear_preempt_need_resched(void)
+{
+}
+
+static __always_inline bool test_preempt_need_resched(void)
+{
+	return false;
+}
+
+/*
+ * The various preempt_count add/sub methods
+ */
+
+static __always_inline void __preempt_count_add(int val)
+{
+	preempt_count_set(preempt_count() + val);
+}
+
+static __always_inline void __preempt_count_sub(int val)
+{
+	preempt_count_set(preempt_count() - val);
+}
+
+static __always_inline bool __preempt_count_dec_and_test(void)
+{
+	/*
+	 * Because of load-store architectures cannot do per-cpu atomic
+	 * operations; we cannot use PREEMPT_NEED_RESCHED because it might get
+	 * lost.
+	 */
+	preempt_count_set(preempt_count() - 1);
+	if (preempt_count() == 0 && tif_need_resched())
+		return true;
+	else
+		return false;
+}
+
+/*
+ * Returns true when we need to resched and can (barring IRQ state).
+ */
+static __always_inline bool should_resched(int preempt_offset)
+{
+	return unlikely(preempt_count() == preempt_offset && tif_need_resched());
+}
+
+//EXPORT_SYMBOL(per_cpu_preempt_count);
+
+#ifdef CONFIG_PREEMPTION
+extern asmlinkage void preempt_schedule(void);
+extern asmlinkage void preempt_schedule_notrace(void);
+
+#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+
+void dynamic_preempt_schedule(void);
+void dynamic_preempt_schedule_notrace(void);
+#define __preempt_schedule()		dynamic_preempt_schedule()
+#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
+
+#else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
+
+#define __preempt_schedule() preempt_schedule()
+#define __preempt_schedule_notrace() preempt_schedule_notrace()
+
+#endif /* CONFIG_PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_KEY*/
+#endif /* CONFIG_PREEMPTION */
+
+#endif /* __ASM_PREEMPT_H */
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 0d170e2be2b6..bf2199384751 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -52,8 +52,8 @@
  * low level task data.
  */
 struct thread_info {
-	int		preempt_count;		/* 0 => preemptable,
-						   <0 => BUG */
+	//int		preempt_count;		// 0 => preemptable,
+						//   <0 => BUG
 #ifdef CONFIG_SMP
 	unsigned int	cpu;
 #endif
@@ -77,7 +77,6 @@ struct thread_info {
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.preempt_count = INIT_PREEMPT_COUNT,	\
 	.flags =	0,			\
 }
 
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 7502066c3c53..f90245b8359f 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -204,6 +204,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 #ifdef CONFIG_PPC_64S_HASH_MMU
 	new_paca->slb_shadow_ptr = NULL;
 #endif
+	new_paca->preempt_count = PREEMPT_DISABLED;
 
 #ifdef CONFIG_PPC_BOOK3E_64
 	/* For now -- if we have threads this will be adjusted later */
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 85050be08a23..2adab682aab9 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -33,6 +33,8 @@
 #include <asm/ultravisor.h>
 #include <asm/crashdump-ppc64.h>
 
+#include <linux/percpu-defs.h>
+
 int machine_kexec_prepare(struct kimage *image)
 {
 	int i;
@@ -324,7 +326,7 @@ void default_machine_kexec(struct kimage *image)
 	 * XXX: the task struct will likely be invalid once we do the copy!
 	 */
 	current_thread_info()->flags = 0;
-	current_thread_info()->preempt_count = HARDIRQ_OFFSET;
+	local_paca->preempt_count = HARDIRQ_OFFSET;
 
 	/* We need a static PACA, too; copy this CPU's PACA over and switch to
 	 * it. Also poison per_cpu_offset and NULL lppaca to catch anyone using

