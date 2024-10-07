Return-Path: <linux-kernel+bounces-352955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC5A992672
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C10D1C22428
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C609718C039;
	Mon,  7 Oct 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a5D49t7E"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E7E18C003
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287519; cv=none; b=BPCy0eXg7NKcZgEPeT0kmaPtXl6G/dLHRhIQGn9s0JXdb3NcZ52azvdM47wky2WiMclAF44S4YvyeTmipQw/3uQwD7UmiD/knexD7fZzlv89sV77uaxEjvm2qBxKruubAbHk9dOzyhAKw6rq5KgjPjShRIJFRmL6iVwWRF81c5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287519; c=relaxed/simple;
	bh=hPUmOF8kOQtM8IO4R5KUqWzoI144Spws1jLDFFYZico=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gD1yr+M3ISUry6oU4IpF4qjEI8VzlaHSsQZJcaRhA2ynWHYu1MVRavrAS2lGVXnvmmmBIlYNoFNbSaQzS20070gjYPMKB6j5eyCVIJyOiEftKl9eRH+aV5om6uQhbDOS0ge/+PDUcgqfibx6KU1zZ9oT8THEajDZRLES4HLSaI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a5D49t7E; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=3bI3Q70c2k0AtlpFzd03paIarv2tCsNPmOKp+gkKSIQ=; b=a5D49t7E9mh74ks4w7aiCnLqMj
	MHdh65GOs0k7++7+CXUOI+3NPOQixDEkoRr5QMXjJEKkJXvsjT8rrMumv423OzKai/1Zz8Ixo/KYR
	buCIm+hFEMrm4tx1wAGA9Xz45/Lk/Gq1nAOrtpHVJC9+mJe8TTaft+klKfyXXtvZxQ6e7R9F6D9VP
	nyJ6nNtVoBsmJHvSR6MlV1JHFYIRsQD3ZSgJErpczkZtgLLOF369jx956qA/QbwA0q/AngzVhGjbR
	WbQ9R1u9o/v/SCU/NuNt+6H8PbDRobk98Fs6KH1ENDbmEwUQzKedKR/O4NAMBUhMgFXI/xl/UoaJd
	2IgxDKMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxiWu-00000004NuY-3xE2;
	Mon, 07 Oct 2024 07:51:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 3FD0B302DD2; Mon,  7 Oct 2024 09:51:44 +0200 (CEST)
Message-Id: <20241007075055.555778919@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 07 Oct 2024 09:46:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: bigeasy@linutronix.de,
 tglx@linutronix.de,
 mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 ankur.a.arora@oracle.com,
 efault@gmx.de
Subject: [PATCH 4/5] sched, x86: Enable Lazy preemption
References: <20241007074609.447006177@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Add the TIF bit and select the Kconfig symbol to make it go.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                   |    1 +
 arch/x86/include/asm/thread_info.h |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -93,6 +93,7 @@ config X86
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -87,8 +87,9 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
-#define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_NEED_RESCHED_LAZY	4	/* rescheduling necessary */
+#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
+#define TIF_SSBD		6	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -110,6 +111,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)



