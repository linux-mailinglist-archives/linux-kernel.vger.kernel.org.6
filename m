Return-Path: <linux-kernel+bounces-570098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E03CA6AC00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4716C983D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0D0226541;
	Thu, 20 Mar 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xXICdZrj"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA272225795
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491783; cv=none; b=FI4XxVNC263+YPKSPTy8y5mfDURdouQOhjVfjhZCUEpzjZrEKfGLuQM5ZyCinaPgvMUxW1NXiudltc2mUjAi5b8kUqcM+oD0PmLvXH8WEn8BiRV7P9PxyjT/Gj3Cn3oNzAQlVYnjO7q8kC3MIcs+ldsl1WypxD7mIvrGeRgqU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491783; c=relaxed/simple;
	bh=hwgP0eJzDOrIufwWh6p9CUUm5a7+Fj7HYXiMVVUL4i0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FOyIv70oOuYF5z+D95CA9Ws50iaZcVsbZyfEVQyfFNw8J/OJVs9Ijn8zlOdSFfHvymKMhRZwfwXnOL+PRYtPtVTr2r/rSlJ9bf4uqct2DK/loKnJB1sPNG2ZsS6CgaYmZepBzLrLyNsQEx7tRDzB7/alyBBZPENQV1nycywaWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xXICdZrj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2260c91576aso20298085ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742491781; x=1743096581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eCKaISwGTmHrKIN85ACd1M+I+peSRtvNHA2LnoFqyQ=;
        b=xXICdZrjWvULppfczpgiFxp217pTHxukpYPMzGIlXbKQwTG4gTE6SrjcIz2CEnVB+J
         /wjXgpivTY5jdowSKbxYr8Iup3nec+8jrLKHDlERvwomCDy2O2/UsGEN9nJrfaT1Ff29
         4w9ednkTEDNrP/5p1bRbZP0/LEyfsm7bnt2+7hrRk2rmqdlRYUpPTVqaMUolr791cmzb
         /NoHNfYC9/xOyoR+QWxKE8IDT1tw8j4g/O4qzUNUNk52YS+PrtP157vC4tECbbm6uq+F
         gncdt5pZh1yKAIA6/SEPaEc7hGN0fVg2tXuC5t1wuOSHiAXnDstOYyLi5P0ar2KdQWTp
         ZGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742491781; x=1743096581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eCKaISwGTmHrKIN85ACd1M+I+peSRtvNHA2LnoFqyQ=;
        b=dIeesbedNHaWurA/xMj9zaqJY17o9fdFNyjfNjxujJ23WNz8yw/KKIHHH4NLr2wodd
         OmigvgiRZ8DstKsC8eDHVhD1K4VJ6oNl69mhgWR1AJoQABzhGcsDyVf+MqjrawcDTh+X
         qdlSQDR4fQed4hEb4axrx7EmsO/SD0zVYhUGFNHEf6Qx4si6BAAoO60Mlni9Cfy7VY3+
         QseQnlKSvt4T+mfXQFrDqeHS9pbWvM+5vIfmPC1trHfD0XEw2ZmygqzELEIbOWtw9qb9
         R2jiVl5bueSNmJbtn6SpBC6C8CB+WPBHGSv6R2CeAreJeNkVuRGI7qM2C+lVdwtuE0CQ
         zY4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjw0rH2cdGyQ8zcZIh2vxQTuy264lyGAcaiVr8R6hxpxH010JYmfI/VYR7a7xIktg5FerW8Ty1p8beRGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZbG2Wq8cSdJN+RN02HagxY34ir0ngm2g895QWxenm36Tbh2F
	5TUehfg9FYlcvCGYIvP+vrmWfVVC86fJFb4XcLfVi7QU3dwShWESTcGGjlxrA7U=
X-Gm-Gg: ASbGncvAdeWEh6t6g8T5xGa2icqXriQ0iiJgeeVb5TuOAor3Ju5ZzkIZ+YMTJ9mkZWy
	jNNZAX1MwSfjz8my/m6FiF5i8v+K+cNOLSxh+drk867aC2B0C218tF93dHAj7RVguP0b/aPQxkH
	0J9hNJeAoED56AGyT10wWjSEFoSwj5P26nel+EeUtCtNr/GssRkv8J7nn6G2xstuqUeux9oRNq8
	m6eIxA5LWU+C17kbKm69dga3hU8HjDeuEV9vqqD7mjhJ5VqngaRh2ivjYRSGSHIBQJPSAbo2Qc8
	VVTrKNvpYmPmQIrjgfgZ+cPDX/UpGFLEdvKLr1SSV5oNrEEnj+d6W4w1/l3c
X-Google-Smtp-Source: AGHT+IEoiSAT3PG2OtWmoV8mEdtsEZlvOKiVq4y4a6hslPNxV+g32GTCCxsgFDxyvEafNQCPfwNFsA==
X-Received: by 2002:a17:902:d511:b0:21f:61a9:be7d with SMTP id d9443c01a7336-22780e259c5mr2788735ad.49.1742491780987;
        Thu, 20 Mar 2025 10:29:40 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45994sm554075ad.81.2025.03.20.10.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:29:40 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 20 Mar 2025 10:29:24 -0700
Subject: [PATCH v6 4/4] entry: Inline syscall_exit_to_user_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-riscv_optimize_entry-v6-4-63e187e26041@rivosinc.com>
References: <20250320-riscv_optimize_entry-v6-0-63e187e26041@rivosinc.com>
In-Reply-To: <20250320-riscv_optimize_entry-v6-0-63e187e26041@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5735; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=hwgP0eJzDOrIufwWh6p9CUUm5a7+Fj7HYXiMVVUL4i0=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qdgGq/gwcSBbKN5p44aWIlPpmL3/weZ9XT/V/fHUmOf
 WD/Vr29o5SFQYyLQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgImEVDEyrBLd8GnjvikyV9/F
 i29z36Hy8PXSm5elT8rPVp7dM+fmBkZGhgnvBaQuX9uxPEsj9ztDn3DcJ3+Zs8yioUodqUxax45
 PYgMA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Similar to commit 221a164035fd ("entry: Move
syscall_enter_from_user_mode() to header file"), move
syscall_exit_to_user_mode() to the header file as well.

Testing was done with the byte-unixbench [1] syscall benchmark (which
calls getpid) and QEMU. On riscv I measured a 7.09246% improvement, on
x86 a 2.98843% improvement, on loongarch a 6.07954% improvement, and on
s390 a 11.1328% improvement.

The Intel bot also reported "kernel test robot noticed a 1.9%
improvement of stress-ng.seek.ops_per_sec" [2]

[1] https://github.com/kdlucas/byte-unixbench
[2] https://lore.kernel.org/linux-riscv/202502051555.85ae6844-lkp@intel.com/

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 include/linux/entry-common.h | 43 ++++++++++++++++++++++++++++++++++++--
 kernel/entry/common.c        | 49 +-------------------------------------------
 2 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fc61d0205c97084acc89c8e45e088946f5e6d9b2..f94f3fdf15fc0091223cc9f7b823970302e67312 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -14,6 +14,7 @@
 #include <linux/kmsan.h>
 
 #include <asm/entry-common.h>
+#include <asm/syscall.h>
 
 /*
  * Define dummy _TIF work flags if not defined by the architecture or for
@@ -366,6 +367,15 @@ static __always_inline void exit_to_user_mode(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
+/**
+ * syscall_exit_work - Handle work before returning to user mode
+ * @regs:	Pointer to current pt_regs
+ * @work:	Current thread syscall work
+ *
+ * Do one-time syscall specific work.
+ */
+void syscall_exit_work(struct pt_regs *regs, unsigned long work);
+
 /**
  * syscall_exit_to_user_mode_work - Handle work before returning to user mode
  * @regs:	Pointer to currents pt_regs
@@ -379,7 +389,30 @@ static __always_inline void exit_to_user_mode(void)
  * make the final state transitions. Interrupts must stay disabled between
  * return from this function and the invocation of exit_to_user_mode().
  */
-void syscall_exit_to_user_mode_work(struct pt_regs *regs);
+static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+	unsigned long nr = syscall_get_nr(current, regs);
+
+	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
+
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
+			local_irq_enable();
+	}
+
+	rseq_syscall(regs);
+
+	/*
+	 * Do one-time syscall specific work. If these work items are
+	 * enabled, we want to run them exactly once per syscall exit with
+	 * interrupts enabled.
+	 */
+	if (unlikely(work & SYSCALL_WORK_EXIT))
+		syscall_exit_work(regs, work);
+	local_irq_disable_exit_to_user();
+	exit_to_user_mode_prepare(regs);
+}
 
 /**
  * syscall_exit_to_user_mode - Handle work before returning to user mode
@@ -410,7 +443,13 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
  * exit_to_user_mode(). This function is preferred unless there is a
  * compelling architectural reason to use the separate functions.
  */
-void syscall_exit_to_user_mode(struct pt_regs *regs);
+static __always_inline void syscall_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	syscall_exit_to_user_mode_work(regs);
+	instrumentation_end();
+	exit_to_user_mode();
+}
 
 /**
  * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e33691d5adf7aab4af54cf2bf8e5ef5bd6ad1424..f55e421fb196dd5f9d4e34dd85ae096c774cf879 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -146,7 +146,7 @@ static inline bool report_single_step(unsigned long work)
 	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
 }
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
 
@@ -173,53 +173,6 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 		ptrace_report_syscall_exit(regs, step);
 }
 
-/*
- * Syscall specific exit to user mode preparation. Runs with interrupts
- * enabled.
- */
-static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-	unsigned long nr = syscall_get_nr(current, regs);
-
-	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
-
-	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
-		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
-			local_irq_enable();
-	}
-
-	rseq_syscall(regs);
-
-	/*
-	 * Do one-time syscall specific work. If these work items are
-	 * enabled, we want to run them exactly once per syscall exit with
-	 * interrupts enabled.
-	 */
-	if (unlikely(work & SYSCALL_WORK_EXIT))
-		syscall_exit_work(regs, work);
-}
-
-static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	syscall_exit_to_user_mode_prepare(regs);
-	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
-}
-
-void syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	__syscall_exit_to_user_mode_work(regs);
-}
-
-__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	__syscall_exit_to_user_mode_work(regs);
-	instrumentation_end();
-	exit_to_user_mode();
-}
-
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);

-- 
2.43.0


