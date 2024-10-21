Return-Path: <linux-kernel+bounces-373622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD469A597A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC2B1F22082
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419D11D0F50;
	Mon, 21 Oct 2024 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRgJuSxa"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758161D0DCB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484555; cv=none; b=U5HVgADx3Dysqfpz/DZ6GwSTUI/+KfKa5nu6m1JAss+yQuUJf2vQIuEgufwr2G8PjyWPntTKlKa6tsgKhqDfaTmQPVhKrKzuBbrSX03146gFG9s16U9WKWeCly5mKNk07Zl3fc0GHbixhu/rwFw1dnSsSZpRKH++WASUToloSaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484555; c=relaxed/simple;
	bh=IKmv5l1pYnG1SRlKUheSWIhA3bXn6fHcqVHlBZwuIKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m2R31lEKS4idvYGasGLz1vK+N44kTeGbfJ1vX2kPLMj1namyR04b9mQ/C+V0yvwl/t6gJfOHMdEfVe1dYX17gdlQEiOoUveCKjnh5UFu9Sm8WNpm/bYIyRGH0ZK6NpE65uq1XdFnN9y0M1iFJoDZ+TFFycfqOa/9Tg+rMIOZ62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRgJuSxa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2e4874925so68011017b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729484552; x=1730089352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJDQv9BsbNqPzAGIVHBRqdKJMgT8Ksx982Co8Pglskw=;
        b=SRgJuSxauB0Mdh5dF0cXzoRA9OPuv+N13jXzoOeRxGwCNXlUDZ7d7hd9xbMf7ueifC
         /3ovq3TjOdcjLTSmSu/rVZKsY/+GrTtcKkGzLs7w0KicKl1/YcQEJe4KtgI6TGRsZ62z
         NQMKKVh9qLeIZqCkD20wOp7G+cZ28gWhrfp4Tp/SiKqRcLHzDsyv4LCXjf0CGHJEUpto
         DHlKTyNpXqCkfeR9I8cDTVo6N/NPutDc6t5Nq8pc8YboQul6UQQtSpDrcNezo5QDfSen
         smdqfYo4IpwH/srNtkuhDZTK1xPOwy/9AuoEM8yKpbJGp5NXcc9E8/F0VGkHsm1a2K5E
         mHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729484552; x=1730089352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJDQv9BsbNqPzAGIVHBRqdKJMgT8Ksx982Co8Pglskw=;
        b=DQf+sRH/puU+CAb7JFpk1+AQ+IAUd19DiW0Buh3MIqHrNvHdO5XoN8Oo9C0Wz19TyL
         E7FBYtN3ALqF1+0Iq/Bg3IRbyiSGyftCU2BiLxohlZXMzdHqXOlPQDyWcdxJCqZ9TnqX
         irBsXF8S0VVCOejlhlyHJy0TNKdL21X8UaQMz2lwhvR9n7FNtwPW7Bre1jyef7vgA4ZT
         3GiOPkjBatdJ86yttSo7QFSMwQUmDIvvanLQ2calWArVNwu1aPDJCUR9yypc3IiX14+y
         PhOxKrZIRyp1UKV33IkU592WdtY45rA0Hmm+eo9WOH7grWEb4odTtyiREvhaVLPcEpFL
         ywWw==
X-Forwarded-Encrypted: i=1; AJvYcCU+RNqMB3cfA+kh1DhrbadJjmOQHeQRBMuybJTCyjHGmYjR45XvieEpoRxbC+gV9R3/77BIPDb+GTIWFdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztjv8N2vLwylzlVRkix1KRGK6QLCx5VzjPeuf2GpLs491atrJy
	OnOp7hSShYtTBHrI6ZFk03RkVoNMBxMnAKiQMD3Md1r6uv04V13Li/GcXlCfokNC5607NqjcHg6
	K5w==
X-Google-Smtp-Source: AGHT+IGEZGtfLFTAo+zlX7imoG9sifk97tpSM8aK6pq0aGlMOVsYXw6fthvIZGCv/EPFEWt1vDf5ZDyKg70=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:1569:9ef4:20ab:abf9])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:fc2:b0:6e2:70e:e82e with SMTP id
 00721157ae682-6e5bfc0c757mr2067897b3.6.1729484552429; Sun, 20 Oct 2024
 21:22:32 -0700 (PDT)
Date: Sun, 20 Oct 2024 22:22:16 -0600
In-Reply-To: <20241021042218.746659-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021042218.746659-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241021042218.746659-5-yuzhao@google.com>
Subject: [PATCH v1 4/6] arm64: broadcast IPIs to pause remote CPUs
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nanyong Sun <sunnanyong@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Broadcast pseudo-NMI IPIs to pause remote CPUs for a short period of
time, and then reliably resume them when the local CPU exits critical
sections that preclude the execution of remote CPUs.

A typical example of such critical sections is BBM on kernel PTEs.
HugeTLB Vmemmap Optimization (HVO) on arm64 was disabled by
commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable
HUGETLB_PAGE_OPTIMIZE_VMEMMAP") due to the folllowing reason:

  This is deemed UNPREDICTABLE by the Arm architecture without a
  break-before-make sequence (make the PTE invalid, TLBI, write the
  new valid PTE). However, such sequence is not possible since the
  vmemmap may be concurrently accessed by the kernel.

Supporting BBM on kernel PTEs is one of the approaches that can make
HVO theoretically safe on arm64.

Note that it is still possible for the paused CPUs to perform
speculative translations. Such translations would cause spurious
kernel PFs, which should be properly handled by
is_spurious_el1_translation_fault().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/include/asm/smp.h |  3 ++
 arch/arm64/kernel/smp.c      | 92 +++++++++++++++++++++++++++++++++---
 2 files changed, 88 insertions(+), 7 deletions(-)

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
index 3b3f6b56e733..68829c6de1b1 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -85,7 +85,12 @@ static int ipi_irq_base __ro_after_init;
 static int nr_ipi __ro_after_init = NR_IPI;
 static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
 
-static bool crash_stop;
+enum {
+	SEND_STOP = BIT(0),
+	CRASH_STOP = BIT(1),
+};
+
+static unsigned long stop_in_progress;
 
 static void ipi_setup(int cpu);
 
@@ -917,6 +922,79 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
 #endif
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
+	/* paused_cpus must be set before waiting on resumed_cpus. */
+	barrier();
+	while (!cpumask_test_cpu(cpu, &resumed_cpus))
+		cpu_relax();
+	/* A typical example for sleep and wake-up functions. */
+	smp_mb();
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
+	smp_cross_call(&cpus_to_pause, IPI_CPU_STOP_NMI);
+
+	while (!cpumask_equal(&cpus_to_pause, &paused_cpus))
+		cpu_relax();
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
+	while (cpumask_intersects(&cpus_to_resume, &paused_cpus))
+		cpu_relax();
+
+	spin_unlock(&cpu_pause_lock);
+}
+
 static void arm64_backtrace_ipi(cpumask_t *mask)
 {
 	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
@@ -970,7 +1048,9 @@ static void do_handle_IPI(int ipinr)
 
 	case IPI_CPU_STOP:
 	case IPI_CPU_STOP_NMI:
-		if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop) {
+		if (!test_bit(SEND_STOP, &stop_in_progress)) {
+			pause_local_cpu();
+		} else if (test_bit(CRASH_STOP, &stop_in_progress)) {
 			ipi_cpu_crash_stop(cpu, get_irq_regs());
 			unreachable();
 		} else {
@@ -1142,7 +1222,6 @@ static inline unsigned int num_other_online_cpus(void)
 
 void smp_send_stop(void)
 {
-	static unsigned long stop_in_progress;
 	cpumask_t mask;
 	unsigned long timeout;
 
@@ -1154,7 +1233,7 @@ void smp_send_stop(void)
 		goto skip_ipi;
 
 	/* Only proceed if this is the first CPU to reach this code */
-	if (test_and_set_bit(0, &stop_in_progress))
+	if (test_and_set_bit(SEND_STOP, &stop_in_progress))
 		return;
 
 	/*
@@ -1230,12 +1309,11 @@ void crash_smp_send_stop(void)
 	 * This function can be called twice in panic path, but obviously
 	 * we execute this only once.
 	 *
-	 * We use this same boolean to tell whether the IPI we send was a
+	 * We use the CRASH_STOP bit to tell whether the IPI we send was a
 	 * stop or a "crash stop".
 	 */
-	if (crash_stop)
+	if (test_and_set_bit(CRASH_STOP, &stop_in_progress))
 		return;
-	crash_stop = 1;
 
 	smp_send_stop();
 
-- 
2.47.0.rc1.288.g06298d1525-goog


