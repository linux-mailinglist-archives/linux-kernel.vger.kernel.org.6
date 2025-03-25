Return-Path: <linux-kernel+bounces-575628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09BDA704FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36993BA72D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8920725D525;
	Tue, 25 Mar 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tzmr1Ig1"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561AC25C6E0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916333; cv=none; b=M/3mXGzVmXOXWND9Rph4hPjXff91ydU6nM32WQCOeAS0UgoywBMv0i16hF9ti9VV8AeP3IqlIf1wiQxwam5jzRGWkz3u6UkshfAESN92ivTRiYKbxyqdtrOgEiQFxQE3BN0fAiibwvLQzCDg0xz2CyTuMWGdFadJ18tFJX78peE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916333; c=relaxed/simple;
	bh=Ng+Lio95IpKbguKiLkuX54DV6nyuAdDFUWNNk6dJLmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3MP7pGJODXjBBS5qUoRHv92kFj/yPhUw8cyegZTGHJBgYMCec12KG3CjaWhP50ikC2WyMBeWk5cK5YvAB7XIFBOgh7bVpVt/EpqI87yHB1LWpo2NmM/6qdA/LuGVt2Z4pZdVvBhQLeP/VlIyrWDVvvu7rcVxUCMZjPObIJT5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tzmr1Ig1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P7vp46010542;
	Tue, 25 Mar 2025 15:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6PPWTdboa2PhVIUe4
	B4/Kwhi9JapPd/TmkNOKigN7s8=; b=Tzmr1Ig1QSFDbPcMjEl/6u3BInsspE69Q
	XpqzC0RcOnNzA2HCe874C8p4qq1sLATa502s//P3iO+RbtFNqOu4Rzhdwmdo6/ax
	a2LXRE5jkb9/GXyIZic6zW9ZtxvPA1aZb8PZSfVBNH5SxRD8hqHTOXW+jb4YAhqW
	bG1t4CLAEHomQvHGJONb6a+HnVbHoEY8mgn3+BhceQHN8GzESSsUCNrg73PQRzgK
	c0r3/GzuNvVJeRN51povCfBCgpYF4RuIGJooefEgzzW8zbQ5VgIic9X7lJAmIk1i
	nn38sXphhUhXJhaLFSo566XLgZZXPc+lq3u57MumDlGGYrt1nUTkg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kejpvgns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 15:25:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PFJeDq012596;
	Tue, 25 Mar 2025 15:25:15 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kejpvgnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 15:25:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PECOdt005791;
	Tue, 25 Mar 2025 15:25:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82bnyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 15:25:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PFPBPI55378178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 15:25:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BACC2004B;
	Tue, 25 Mar 2025 15:25:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C6A620049;
	Tue, 25 Mar 2025 15:25:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 15:25:11 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 2DAA9E0F4E; Tue, 25 Mar 2025 16:25:11 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] powerpc/64s: Do not re-activate batched TLB flush
Date: Tue, 25 Mar 2025 16:25:11 +0100
Message-ID: <3b4e3e28172f09165b19ee7cac67a860d7cc1c6e.1742915600.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1742915600.git.agordeev@linux.ibm.com>
References: <cover.1742915600.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W4JztF7XFuZDc2ndbmEoVo9vzl3Jx9g0
X-Proofpoint-GUID: Uzeiw_TcWN1sWiTe7bgJfO_Q2KwWm7uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=489 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250105

Since commit b9ef323ea168 ("powerpc/64s: Disable preemption in
hash lazy mmu mode") a task can not be preempted while inside
arch_enter_lazy_mmu_mode(). Therefore, the batch re-activation
code is never gets called, so remove it.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/powerpc/include/asm/thread_info.h |  2 --
 arch/powerpc/kernel/process.c          | 25 -------------------------
 2 files changed, 27 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 2785c7462ebf..092118a68862 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -154,12 +154,10 @@ void arch_setup_new_exec(void);
 /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
 #define TLF_NAPPING		0	/* idle thread enabled NAP mode */
 #define TLF_SLEEPING		1	/* suspend code enabled SLEEP mode */
-#define TLF_LAZY_MMU		3	/* tlb_batch is active */
 #define TLF_RUNLATCH		4	/* Is the runlatch enabled? */
 
 #define _TLF_NAPPING		(1 << TLF_NAPPING)
 #define _TLF_SLEEPING		(1 << TLF_SLEEPING)
-#define _TLF_LAZY_MMU		(1 << TLF_LAZY_MMU)
 #define _TLF_RUNLATCH		(1 << TLF_RUNLATCH)
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ef91f71e07c4..b5810b932e21 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1281,9 +1281,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 {
 	struct thread_struct *new_thread, *old_thread;
 	struct task_struct *last;
-#ifdef CONFIG_PPC_64S_HASH_MMU
-	struct ppc64_tlb_batch *batch;
-#endif
 
 	new_thread = &new->thread;
 	old_thread = &current->thread;
@@ -1291,14 +1288,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	WARN_ON(!irqs_disabled());
 
 #ifdef CONFIG_PPC_64S_HASH_MMU
-	batch = this_cpu_ptr(&ppc64_tlb_batch);
-	if (batch->active) {
-		current_thread_info()->local_flags |= _TLF_LAZY_MMU;
-		if (batch->index)
-			__flush_tlb_pending(batch);
-		batch->active = 0;
-	}
-
 	/*
 	 * On POWER9 the copy-paste buffer can only paste into
 	 * foreign real addresses, so unprivileged processes can not
@@ -1369,20 +1358,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	 */
 
 #ifdef CONFIG_PPC_BOOK3S_64
-#ifdef CONFIG_PPC_64S_HASH_MMU
-	/*
-	 * This applies to a process that was context switched while inside
-	 * arch_enter_lazy_mmu_mode(), to re-activate the batch that was
-	 * deactivated above, before _switch(). This will never be the case
-	 * for new tasks.
-	 */
-	if (current_thread_info()->local_flags & _TLF_LAZY_MMU) {
-		current_thread_info()->local_flags &= ~_TLF_LAZY_MMU;
-		batch = this_cpu_ptr(&ppc64_tlb_batch);
-		batch->active = 1;
-	}
-#endif
-
 	/*
 	 * Math facilities are masked out of the child MSR in copy_thread.
 	 * A new task does not need to restore_math because it will
-- 
2.45.2


