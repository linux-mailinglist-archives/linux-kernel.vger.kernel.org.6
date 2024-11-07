Return-Path: <linux-kernel+bounces-400589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0F9C0F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073A8281E66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFCD21893D;
	Thu,  7 Nov 2024 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9AohT+8"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE7B2185AF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010850; cv=none; b=rPAWjsjkx/GBSmUtMrUWceiu7RFdc+J4OKRfOMffLUxxJlu+1+9B67hLBaEd0xdgXjkM+BGjj6zs8ZF7qZGcuFhoD7VVpSZNF6NDqs3vLALid/UIgfRsPUtskHHGGcimB7jPVcUhdHMklOKEhbpOk371lhLbcKXTuUATEs8NuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010850; c=relaxed/simple;
	bh=PUjGRS5Zbb9JOA3398lDXtzAJaosXV78/5CRo5RCmfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UuanErRqxj928x1hXd7Oh3mW7vGbiJpAnRetaIRRes/nC6Z+etiVYqaP23Et6+xFcGNsQKyWfYtu98NwuuI16/LFje0i6MACY7N188RCENq4TFVZoap6Lenf8naFn/9YOZqUxPo70X47AbPFkaHhbK4rT+ptmJkVHCJMpghrHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T9AohT+8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3313b47a95so2714753276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 12:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731010847; x=1731615647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhIcSe1txNfkCnP7MPXpnY6tOWGMY/4eAudpBxJaXiU=;
        b=T9AohT+8ENhdfJ3iYeW7yzp8GuUk7r9O0FtXM+MQSJUP0yKKxHtMV8TZibbPw1PT7/
         +Ov4T2heJplqRiZrRjHopAPhB3jUiiZgNsbPz+kK0vkS9iZHLFoPxqoT/fwzBKPaOC3A
         dx/FfIF25NCFaKRlc4GJdge1HXFcUB12mSbyesR79VFLFLF91O8QjJhZTcS8kHObtY9d
         lxHyaz/Trn3GBtQER+mpqn+2c6RCQfSUM3b4w3tfl42O+JkJLfUaCMH5oee57zSx0Bt2
         cgH+uSb3eJYBcedekAKHV6x4TgOqPH6zhNDMRRicaFmDhiA+cs848XPL+eFAKZBxUXaa
         awQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731010847; x=1731615647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhIcSe1txNfkCnP7MPXpnY6tOWGMY/4eAudpBxJaXiU=;
        b=qTPkzLaT4OwbTAedBDXTa8MhMEhoth8FZkBXsuH7O5XIzjZyo9LDQXwqp4dZ+UAYw0
         aJiLKIwlU1m8pkbsPEtqsDWIbHFHq0zVdvGEeGm3qf6189gWxf2wHtObW8C44jRCdxcA
         Ob5I/raG7gdzffEb6fP4WEw4OOE+KKO/ovsCqcH7DcI17wU4cNzUk89vpHXnysGkHWdU
         uOlmr0xG7fuEELQFg12dCd/Yf3LIrIARsP7g4KWgH8dx/yRPeQ3N4czgBpXrRb/FLnud
         bTfaJukhfTs95Jv6BY+tmfA+9lsLmO9zee2ALppKY6lT62kS5JlPZ7QDlpOKfdrA3SV2
         hAVg==
X-Forwarded-Encrypted: i=1; AJvYcCWxqseyfM4j6zMPghtjLAM5xDB5y8s0zwUXbp/g0NZNKAOQABhWvXnUprqvRCxAKqYHPefT0s0wbZf5HrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5tAsEurm5RP9MVh/rD16a8yrBZDnO7vs1d9IdAqRhmUu9DHGa
	cj8IWSpDXtfUgxSTxzn9Qgn4ueHRpPE6gRuyzWPDRuKzAoIygmKglJRy8aw1lHB88ZlXtex6Jr3
	KOw==
X-Google-Smtp-Source: AGHT+IEnJ0e357/3OotzjsP9lexlQ5CBUwlEpVYwPI3w1zjYPdS8y4hVyHrOYLJ8xSQLJ2NE0kbCcYElb98=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:a4c0:c64f:6cdd:91f8])
 (user=yuzhao job=sendgmr) by 2002:a25:bc84:0:b0:e2b:d0e9:1cdc with SMTP id
 3f1490d57ef6-e337f908f8dmr320276.10.1731010847379; Thu, 07 Nov 2024 12:20:47
 -0800 (PST)
Date: Thu,  7 Nov 2024 13:20:31 -0700
In-Reply-To: <20241107202033.2721681-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107202033.2721681-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107202033.2721681-5-yuzhao@google.com>
Subject: [PATCH v2 4/6] arm64: broadcast IPIs to pause remote CPUs
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
HVO safe on arm64.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/include/asm/smp.h |  3 ++
 arch/arm64/kernel/smp.c      | 85 +++++++++++++++++++++++++++++++++---
 2 files changed, 81 insertions(+), 7 deletions(-)

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
index 3b3f6b56e733..54e9f6374aa3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -85,7 +85,12 @@ static int ipi_irq_base __ro_after_init;
 static int nr_ipi __ro_after_init = NR_IPI;
 static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
 
-static bool crash_stop;
+enum {
+	SEND_STOP,
+	CRASH_STOP,
+};
+
+static unsigned long stop_in_progress;
 
 static void ipi_setup(int cpu);
 
@@ -917,6 +922,72 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
 #endif
 }
 
+static DEFINE_RAW_SPINLOCK(cpu_pause_lock);
+static bool __cacheline_aligned_in_smp cpu_paused;
+static atomic_t __cacheline_aligned_in_smp nr_cpus_paused;
+
+static void pause_local_cpu(void)
+{
+	atomic_inc(&nr_cpus_paused);
+
+	while (READ_ONCE(cpu_paused))
+		cpu_relax();
+
+	atomic_dec(&nr_cpus_paused);
+
+	/*
+	 * The caller of resume_remote_cpus() should make sure that clearing
+	 * cpu_paused is ordered after other changes that can have any impact on
+	 * this CPU. The isb() below makes sure this CPU doesn't speculatively
+	 * execute the next instruction before it sees all those changes.
+	 */
+	isb();
+}
+
+void pause_remote_cpus(void)
+{
+	cpumask_t cpus_to_pause;
+	int nr_cpus_to_pause = num_online_cpus() - 1;
+
+	lockdep_assert_cpus_held();
+	lockdep_assert_preemption_disabled();
+
+	if (!nr_cpus_to_pause)
+		return;
+
+	cpumask_copy(&cpus_to_pause, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &cpus_to_pause);
+
+	raw_spin_lock(&cpu_pause_lock);
+
+	WARN_ON_ONCE(cpu_paused);
+	WARN_ON_ONCE(atomic_read(&nr_cpus_paused));
+
+	cpu_paused = true;
+
+	smp_cross_call(&cpus_to_pause, IPI_CPU_STOP_NMI);
+
+	while (atomic_read(&nr_cpus_paused) != nr_cpus_to_pause)
+		cpu_relax();
+
+	raw_spin_unlock(&cpu_pause_lock);
+}
+
+void resume_remote_cpus(void)
+{
+	if (!cpu_paused)
+		return;
+
+	raw_spin_lock(&cpu_pause_lock);
+
+	WRITE_ONCE(cpu_paused, false);
+
+	while (atomic_read(&nr_cpus_paused))
+		cpu_relax();
+
+	raw_spin_unlock(&cpu_pause_lock);
+}
+
 static void arm64_backtrace_ipi(cpumask_t *mask)
 {
 	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
@@ -970,7 +1041,9 @@ static void do_handle_IPI(int ipinr)
 
 	case IPI_CPU_STOP:
 	case IPI_CPU_STOP_NMI:
-		if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop) {
+		if (!test_bit(SEND_STOP, &stop_in_progress)) {
+			pause_local_cpu();
+		} else if (test_bit(CRASH_STOP, &stop_in_progress)) {
 			ipi_cpu_crash_stop(cpu, get_irq_regs());
 			unreachable();
 		} else {
@@ -1142,7 +1215,6 @@ static inline unsigned int num_other_online_cpus(void)
 
 void smp_send_stop(void)
 {
-	static unsigned long stop_in_progress;
 	cpumask_t mask;
 	unsigned long timeout;
 
@@ -1154,7 +1226,7 @@ void smp_send_stop(void)
 		goto skip_ipi;
 
 	/* Only proceed if this is the first CPU to reach this code */
-	if (test_and_set_bit(0, &stop_in_progress))
+	if (test_and_set_bit(SEND_STOP, &stop_in_progress))
 		return;
 
 	/*
@@ -1230,12 +1302,11 @@ void crash_smp_send_stop(void)
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
2.47.0.277.g8800431eea-goog


