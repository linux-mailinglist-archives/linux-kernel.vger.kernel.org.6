Return-Path: <linux-kernel+bounces-275604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC63948783
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5A11C2222F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028ED2C1A2;
	Tue,  6 Aug 2024 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAQMnU14"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6309629CE6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910888; cv=none; b=bSSfRwKNGktJkEt9498cLm9/TK25Kq38Lu5jdVv8eRQ97yYpk7UQTIwTNzngz/hVf5magR1KtBVvrSjE0Ulb4gqHcfTy2TpEScU83gtwJJQDNRmXlPJMoSOnQNs+cp5tWD3mW0y8ZXvNoni6zgbn2g2q4dD0RvWFKUxx3f6mOoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910888; c=relaxed/simple;
	bh=F5pXY2Sq6J+Yo5E4HFGDQM6LmvvZAzJGj3h1Vm9k0Gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nrD35q5qtm7ZSWyTac18RE7ljsCfx/3ekBUp5BD/87X+gI2pF9DCa9nopQVa+vdSmc1z0A+JdLstmFfw8MKKxRIf3xrjPOAs+KZKslqzO9ZWxwBPRrdKLueCOei36I+tW2Oi3FEvWo80ujEIWw7FRVgr1N7xvBBvq210T77CZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAQMnU14; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664aa55c690so4016817b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 19:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722910884; x=1723515684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O2mshx39uv2zkvLi95oIpi0tXJ9/QGv1zrpIuDCw18w=;
        b=bAQMnU14xFqtZ8u72hK/Xo6KgJY6TR+U7BTKvJgEN/IuyJpG6kOxiMrMFkJUCo9vNl
         3FQzvZ5tsN5LMnqXF1Z0EY3//Zu+p+syuIvDktBsD04UqBBplDhIr6zYyXB8FmVArs08
         muSAh3hfOlE9r1I9YZhJkAO9AnsaSh0MSVl6IsoYdL80hXKc4N06QahsBuchMdlC8bR1
         T0w2bYrAw9P7cpzdRLrN1f5dmFzZTp/zCGWc7xYJhJprKn/TkQoOvdln08MgH1WUf9mp
         mT3bgXOYMJ8HcVgqzl9Xn0/8LRajePMUaW3YllwfDOdDhDQ55PHOGfwDStgpNZYyeLen
         4Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910884; x=1723515684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2mshx39uv2zkvLi95oIpi0tXJ9/QGv1zrpIuDCw18w=;
        b=K/rJgZWl1xy2E0J98qqOmBkZ/gyUSLyG0PqEEUrD/X0SqlLFUBGRe3QlISigUJJkrm
         A8uyhwlJfIRYFt9EswFeSw7jLlE/G26a9BElpzxrYB9twEMu/1TMknZb70HXe/qjhinZ
         //568QuYJbOLTR5VEZvd9iHihbNY2sVuwIbdOseVHWoLtxY8R5xCR3Ey2AIKZWd92ZSM
         WbIzng2Gl8FzFk+XJk4HTujmkvELfBScTvuJk8kAVY+/17+d8I1aglpEMYz3MelFlu3+
         GymTJk4LQ8hehMEVmO+Xz+d2DeJxJnUs5VE2pqT2BfiG5X4jPchcM5vHHLG/mP6CXbqR
         +Q+g==
X-Forwarded-Encrypted: i=1; AJvYcCUEPaDHGkq58l0597lh3jFEPbsvU3T2EXVfoVyrJx3oHPjIRpXYKWkxi6B9qgJeOJNy1jpx9Ly+LK9Fsfxrq5zWtW1ESVRvD3iEaAMf
X-Gm-Message-State: AOJu0YzmpEzlSrPXHjGCwcfBTARrZjkn1K5dckk/yhAuNjceMJyMJjxz
	Iq7vu9Ce26e8h+3YmhiIgImdSEekxHXj/joqFcNusEhGEInKWhu1mqLSZh0CkmG31y14omotnDh
	jzw==
X-Google-Smtp-Source: AGHT+IG70ROskvb4vGAVk7HFhpn0VwxmpNbq5+lHHNoIlP/q1TqLemnSQjn2n7kwU3OW0QixZ2DVJNXlB8A=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:261c:802b:6b55:e09c])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:288:b0:673:b39a:9291 with SMTP id
 00721157ae682-6895ffbd30dmr4163187b3.3.1722910884345; Mon, 05 Aug 2024
 19:21:24 -0700 (PDT)
Date: Mon,  5 Aug 2024 20:21:12 -0600
In-Reply-To: <20240806022114.3320543-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806022114.3320543-1-yuzhao@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806022114.3320543-3-yuzhao@google.com>
Subject: [RFC PATCH 2/4] arm64: use IPIs to pause/resume remote CPUs
From: Yu Zhao <yuzhao@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Frank van der Linden <fvdl@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Muchun Song <muchun.song@linux.dev>, 
	Nanyong Sun <sunnanyong@huawei.com>, Yang Shi <yang@os.amperecomputing.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Use pseudo-NMI IPIs to pause remote CPUs for a short period of time,
and then reliably resume them when the local CPU exits critical
sections that preclude the execution of remote CPUs.

A typical example of such critical sections is BBM on kernel PTEs.
HugeTLB Vmemmap Optimization (HVO) on arm64 was disabled by commit
060a2c92d1b6 ("arm64: mm: hugetlb: Disable HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
due to the folllowing reason:

  This is deemed UNPREDICTABLE by the Arm architecture without a
  break-before-make sequence (make the PTE invalid, TLBI, write the
  new valid PTE). However, such sequence is not possible since the
  vmemmap may be concurrently accessed by the kernel.

Supporting BBM on kernel PTEs is one of the approaches that can
potentially make arm64 support HVO.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/include/asm/smp.h |   3 +
 arch/arm64/kernel/smp.c      | 110 +++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 2510eec026f7..cffb0cfed961 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -133,6 +133,9 @@ bool cpus_are_stuck_in_kernel(void);
 extern void crash_smp_send_stop(void);
 extern bool smp_crash_stop_failed(void);
 
+void pause_remote_cpus(void);
+void resume_remote_cpus(void);
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 5e18fbcee9a2..aa80266e5c9d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -68,16 +68,25 @@ enum ipi_msg_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
+	IPI_CPU_PAUSE,
+#ifdef CONFIG_KEXEC_CORE
 	IPI_CPU_CRASH_STOP,
+#endif
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	IPI_TIMER,
+#endif
+#ifdef CONFIG_IRQ_WORK
 	IPI_IRQ_WORK,
+#endif
 	NR_IPI,
 	/*
 	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
 	 * with trace_ipi_*
 	 */
 	IPI_CPU_BACKTRACE = NR_IPI,
+#ifdef CONFIG_KGDB
 	IPI_KGDB_ROUNDUP,
+#endif
 	MAX_IPI
 };
 
@@ -821,11 +830,20 @@ static const char *ipi_types[MAX_IPI] __tracepoint_string = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
+	[IPI_CPU_PAUSE]		= "CPU pause interrupts",
+#ifdef CONFIG_KEXEC_CORE
 	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
+#endif
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	[IPI_TIMER]		= "Timer broadcast interrupts",
+#endif
+#ifdef CONFIG_IRQ_WORK
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
+#endif
 	[IPI_CPU_BACKTRACE]	= "CPU backtrace interrupts",
+#ifdef CONFIG_KGDB
 	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
+#endif
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
@@ -884,6 +902,85 @@ void __noreturn panic_smp_self_stop(void)
 	local_cpu_stop();
 }
 
+static DEFINE_SPINLOCK(cpu_pause_lock);
+static cpumask_t paused_cpus;
+static cpumask_t resumed_cpus;
+
+static void pause_local_cpu(void)
+{
+	int cpu = smp_processor_id();
+
+	cpumask_clear_cpu(cpu, &resumed_cpus);
+	/*
+	 * Paired with pause_remote_cpus() to confirm that this CPU not only
+	 * will be paused but also can be reliably resumed.
+	 */
+	smp_wmb();
+	cpumask_set_cpu(cpu, &paused_cpus);
+	/* A typical example for sleep and wake-up functions. */
+	smp_mb();
+	while (!cpumask_test_cpu(cpu, &resumed_cpus)) {
+		wfe();
+		barrier();
+	}
+	barrier();
+	cpumask_clear_cpu(cpu, &paused_cpus);
+}
+
+void pause_remote_cpus(void)
+{
+	cpumask_t cpus_to_pause;
+
+	lockdep_assert_cpus_held();
+	lockdep_assert_preemption_disabled();
+
+	cpumask_copy(&cpus_to_pause, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &cpus_to_pause);
+
+	spin_lock(&cpu_pause_lock);
+
+	WARN_ON_ONCE(!cpumask_empty(&paused_cpus));
+
+	smp_cross_call(&cpus_to_pause, IPI_CPU_PAUSE);
+
+	while (!cpumask_equal(&cpus_to_pause, &paused_cpus)) {
+		cpu_relax();
+		barrier();
+	}
+	/*
+	 * Paired with pause_local_cpu() to confirm that all CPUs not only will
+	 * be paused but also can be reliably resumed.
+	 */
+	smp_rmb();
+	WARN_ON_ONCE(cpumask_intersects(&cpus_to_pause, &resumed_cpus));
+
+	spin_unlock(&cpu_pause_lock);
+}
+
+void resume_remote_cpus(void)
+{
+	cpumask_t cpus_to_resume;
+
+	lockdep_assert_cpus_held();
+	lockdep_assert_preemption_disabled();
+
+	cpumask_copy(&cpus_to_resume, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &cpus_to_resume);
+
+	spin_lock(&cpu_pause_lock);
+
+	cpumask_setall(&resumed_cpus);
+	/* A typical example for sleep and wake-up functions. */
+	smp_mb();
+	while (cpumask_intersects(&cpus_to_resume, &paused_cpus)) {
+		sev();
+		cpu_relax();
+		barrier();
+	}
+
+	spin_unlock(&cpu_pause_lock);
+}
+
 #ifdef CONFIG_KEXEC_CORE
 static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
 #endif
@@ -963,6 +1060,11 @@ static void do_handle_IPI(int ipinr)
 		local_cpu_stop();
 		break;
 
+	case IPI_CPU_PAUSE:
+		pause_local_cpu();
+		break;
+
+#ifdef CONFIG_KEXEC_CORE
 	case IPI_CPU_CRASH_STOP:
 		if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
 			ipi_cpu_crash_stop(cpu, get_irq_regs());
@@ -970,6 +1072,7 @@ static void do_handle_IPI(int ipinr)
 			unreachable();
 		}
 		break;
+#endif
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
@@ -991,9 +1094,11 @@ static void do_handle_IPI(int ipinr)
 		nmi_cpu_backtrace(get_irq_regs());
 		break;
 
+#ifdef CONFIG_KGDB
 	case IPI_KGDB_ROUNDUP:
 		kgdb_nmicallback(cpu, get_irq_regs());
 		break;
+#endif
 
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
@@ -1023,9 +1128,14 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 
 	switch (ipi) {
 	case IPI_CPU_STOP:
+	case IPI_CPU_PAUSE:
+#ifdef CONFIG_KEXEC_CORE
 	case IPI_CPU_CRASH_STOP:
+#endif
 	case IPI_CPU_BACKTRACE:
+#ifdef CONFIG_KGDB
 	case IPI_KGDB_ROUNDUP:
+#endif
 		return true;
 	default:
 		return false;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


