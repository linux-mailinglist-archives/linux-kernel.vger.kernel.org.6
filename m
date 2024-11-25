Return-Path: <linux-kernel+bounces-420442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A139D7AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 05:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442472819B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 04:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E9281732;
	Mon, 25 Nov 2024 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lOU1wEwM"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3170383
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732508592; cv=none; b=a8XU8Pc/snrLHuW129EFI/di9gVE5iDjS3nhZE+YFZc5ynV4IES3E/rrPJ8sg0jCan0t0r0aE1eeJuQwxsaa2xgp3VSCb+7a5q/clmmBhzXxeQlPtrBijZVtlHtOf/O62p4xg/09o2D9JsoAJ7YHwh/CTFjQ32NAkiqq757Uz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732508592; c=relaxed/simple;
	bh=aFIoeWEApXhW4dM0/iI/Lv9KnL9OvrgyG2KG5sigGeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFsbfBZIPn2T29agCYKIEkhMIryFm6XJxkwuzUwmDPpd6wh3+2+4EiuDunYd+PntrGLMggLiP71WuzCNjhF4N5lTu2DtUyo5UlwC/zfM6bw5nfdqQpfPl8pEmxXkiFQG5iQMqAHeVlyd/mzPslw4XLHPgwWRSK9McPitBOr0HI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lOU1wEwM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP1qdwb023382;
	Mon, 25 Nov 2024 04:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vwZfMzqjn+yG2tmRV
	pCX/O0QbIUyvcViSEdTodFdAXc=; b=lOU1wEwMUefOCkvHLW1qv0dqvLxx6K5MJ
	rfVnF1qxBg42C8rzViGpo13VQZp+/rZHyD08MIS8BFkG5XWyRNweD91WZoj8j9E7
	S1Hjz3brE09GU3auuGGuFLBwbwDJCVLa1DEtn60V1E2vzi+QI/IjFMC6y0/CFmcb
	M7snL7RD2JxIwMIlDXcAkRHPif8g3wvUfyVESY0DSZChKEt/EW5ZONMTQUl4B6QJ
	BG8ux8uuK5ZZYr2SbpNVRVwB6oNOZAidJFFCB+vTN5AD/kkp1OQMroKpsql1UVXq
	bDGn8/ZoFqFQBeLGXiuPMVCkuLvtqJxTnmtiUNQUOrK0cOx2yrDoQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338a7643s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 04:22:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AP4EPaZ004972;
	Mon, 25 Nov 2024 04:22:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338a7643p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 04:22:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP334oM000691;
	Mon, 25 Nov 2024 04:22:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433srxu2xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 04:22:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AP4MZSv49414532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 04:22:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C97420043;
	Mon, 25 Nov 2024 04:22:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72F0220040;
	Mon, 25 Nov 2024 04:22:33 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.in.ibm.com (unknown [9.109.215.252])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Nov 2024 04:22:33 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        maddy@linux.ibm.com, bigeasy@linutronix.de, ankur.a.arora@oracle.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        vschneid@redhat.com, peterz@infradead.org
Subject: [PATCH 2/3] powerpc: support dynamic preemption
Date: Mon, 25 Nov 2024 09:52:11 +0530
Message-ID: <20241125042212.1522315-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125042212.1522315-1-sshegde@linux.ibm.com>
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -74QK4YVcdR4kW-OOxNeUzH1zbCftcWc
X-Proofpoint-ORIG-GUID: tm4aJ4WkJCNpCh_0O9SzAvk_bbVOwYXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250031

Once the lazy preemption is supported, it would be desirable to change
the preemption models at runtime. So this change adds support for dynamic
preemption using DYNAMIC_KEY.

In irq-exit to kernel path, use preempt_model_preemptible for decision.
Other way would be using static key based decision. Keeping it
simpler since key based change didn't show performance improvement.

Tested lightly on Power10 LPAR. Performance numbers indicate that,
preempt=none(no dynamic) and preempt=none(dynamic) are similar.
Only hackbench pipe shows a regression. There is slight overhead of code
check if it is preemptible kernel. hackbench pipe is prone to such 
patterns[1]

cat /sys/kernel/debug/sched/preempt
(none) voluntary full lazy
perf stat -e probe:__cond_resched -a sleep 1
 Performance counter stats for 'system wide':
             1,253      probe:__cond_resched

echo full > /sys/kernel/debug/sched/preempt
cat /sys/kernel/debug/sched/preempt
none voluntary (full) lazy
perf stat -e probe:__cond_resched -a sleep 1
 Performance counter stats for 'system wide':
                 0      probe:__cond_resched

echo lazy > /sys/kernel/debug/sched/preempt
cat /sys/kernel/debug/sched/preempt
none voluntary full (lazy)
perf stat -e probe:__cond_resched -a sleep 1
 Performance counter stats for 'system wide':
                 0      probe:__cond_resched

[1]: https://lore.kernel.org/all/1a973dda-c79e-4d95-935b-e4b93eb077b8@linux.ibm.com/

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/Kconfig               | 1 +
 arch/powerpc/include/asm/preempt.h | 1 +
 arch/powerpc/kernel/interrupt.c    | 6 +++++-
 arch/powerpc/lib/vmx-helper.c      | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6d6bbd93abab..01c58f5258c9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -270,6 +270,7 @@ config PPC
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_RETHOOK			if KPROBES
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/asm/preempt.h
index 51f8f3881523..c0a19ff3f78c 100644
--- a/arch/powerpc/include/asm/preempt.h
+++ b/arch/powerpc/include/asm/preempt.h
@@ -84,6 +84,7 @@ extern asmlinkage void preempt_schedule_notrace(void);
 
 #if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 void dynamic_preempt_schedule(void);
 void dynamic_preempt_schedule_notrace(void);
 #define __preempt_schedule()		dynamic_preempt_schedule()
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 8f4acc55407b..0fb01019d7e0 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -38,6 +38,10 @@ static inline bool exit_must_hard_disable(void)
 }
 #endif
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+#endif
+
 /*
  * local irqs must be disabled. Returns false if the caller must re-enable
  * them, check for new work, and try again.
@@ -396,7 +400,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 		/* Returning to a kernel context with local irqs enabled. */
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
-		if (IS_ENABLED(CONFIG_PREEMPTION)) {
+		if (preempt_model_preemptible()) {
 			/* Return to preemptible kernel context */
 			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index 58ed6bd613a6..7b069c832ce2 100644
--- a/arch/powerpc/lib/vmx-helper.c
+++ b/arch/powerpc/lib/vmx-helper.c
@@ -45,7 +45,7 @@ int exit_vmx_usercopy(void)
 	 * set and we are preemptible. The hack here is to schedule a
 	 * decrementer to fire here and reschedule for us if necessary.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPTION) && need_resched())
+	if (preempt_model_preemptible() && need_resched())
 		set_dec(1);
 	return 0;
 }
-- 
2.39.3


