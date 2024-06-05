Return-Path: <linux-kernel+bounces-202016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094AF8FC6A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2121F1C232ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D39A4965B;
	Wed,  5 Jun 2024 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs6efuSd"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7A1946C8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576582; cv=none; b=A57Nl6WS0AE6/KmPva01GOONS4SjnO7QuW1t6QPk0MIKqT5U4UUtp8t7Igud2CYkk9KZCNcaNg5QkqR+FtiYKhE7VHUeuNpEqHYSaQTLkFjaI4d1F2+aFvpId3PqLBNr3Y0XTCJNRuIt+Y1nQBvasE0bZc5ql7WBjy+H6NCj/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576582; c=relaxed/simple;
	bh=Kx3WlpYz5s6ukkhW/5bmSsiTr8xBh9li3iOKHLi4UNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7H0k/o9Zpb5axUdQACOU0pkhI7quc1rnSsifLZaLaAtZOQfa4zdyKsvhHzTQqotnGgaK/BNecH1I5/Gp82eTCIHu7sRIuqUzROBjDh9waQZP/+MIDoiFEUOfQ/jCZPVfeNh+8SXdSxDT8naeFvbMBGgAnSB5TSk3XB9OZpZMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs6efuSd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so4694898a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717576579; x=1718181379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFCbAcEHZ+AooqUSt7mpzNcbprZCeT+g5prs5/VA3Bo=;
        b=bs6efuSdSvJTyI5k8kiZHQ4paK8ChSpXxPISh4VFoVmJ+8BPldv4O/1Lkux9gl4CRR
         vc4X58iL8u13Oo6b3SGpRTT9BkNEVwxf0Mto4wpsFNV8uWxgUYOcPf2Qx3IURBvrZnFq
         sY0voyASbVXlGZwpZOC46PLAKcFDXVJcPHlTjXLjhQE3mbG3MgHtKKzDY25cKz5LWIY5
         mhhvc0rVkdeRh56owzeJKY+Y9+30I7FdjBCJCMFz9Qt5lvA013QSeOVrucBWDwnH2InB
         iPuc7R4Az0s3y1uXjLn9j07jQbgWEdcI92LKAcuCxf6DUnfQSU3sI2Zlvw0M6LO687fJ
         buJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576579; x=1718181379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFCbAcEHZ+AooqUSt7mpzNcbprZCeT+g5prs5/VA3Bo=;
        b=vLOS3KfkMAQC3+LBoFNBq3GZGa3Deo88IsOyprvPM+1j8EqXEQS3pyaYQL6+PhyVFF
         cF7pNX5pD6vWif1S1HBnIbliEool1m1cNxTtvdpBpo3YPYcaH2NN95Pu0scEyGDX4spb
         4GKpw52wwmlWfIzroUh8TqR1oVVn3FdR5X10y9XSBqx4BxVclAG+AYSsPVAZMwflVhNA
         lbaE9C/k0AF6th7S/zmQVqXXmrTwmklRyeFRY5Zehf5REJL9b2WzkfyW+05/xiYPecvF
         nhezl45TThe2pMdcj2510tuUlMEi8gDSW47Au4+Tb/h8FgqhGT6TQCVUP5i9CQvRzz3x
         Ztjw==
X-Gm-Message-State: AOJu0Yy39xIsTwEUKe1beQBAfE6ATNiCi07yGKEGo+s/2pko1rroKrvQ
	g/MKTBLwNSzeH6vi4VIjwDnz0Lt9O1+EV4Ytv+/EMnvPNdjTgMdUfMzH/2xp
X-Google-Smtp-Source: AGHT+IEcdRMyQrHqQz+AYBXRC6EBrgxq68Tz0RxwrjUTqH2njXpFtlK3us/1GEtnWO36g9vFdvXXIg==
X-Received: by 2002:a17:906:2c0f:b0:a68:44a0:a808 with SMTP id a640c23a62f3a-a699fbd5140mr116334366b.29.1717576578876;
        Wed, 05 Jun 2024 01:36:18 -0700 (PDT)
Received: from kepler.. (1F2EF2F4.nat.pool.telekom.hu. [31.46.242.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b3eaeb69sm611933766b.92.2024.06.05.01.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:36:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 3/3] x86/fpu: Remove init_task FPU state dependencies, add debugging warning
Date: Wed,  5 Jun 2024 10:35:57 +0200
Message-ID: <20240605083557.2051480-4-mingo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605083557.2051480-1-mingo@kernel.org>
References: <20240605083557.2051480-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_task's FPU state initialization was a bit of a hack:

		__x86_init_fpu_begin = .;
		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
		__x86_init_fpu_end = .;

But the init task isn't supposed to be using the FPU in any case,
so remove the hack and add in some debug warnings.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/ZgaNs1lC2Y+AnRG4@gmail.com
---
 arch/x86/include/asm/processor.h |  6 +++++-
 arch/x86/kernel/fpu/core.c       | 12 +++++++++---
 arch/x86/kernel/fpu/init.c       |  5 ++---
 arch/x86/kernel/fpu/xstate.c     |  3 ---
 arch/x86/kernel/vmlinux.lds.S    |  4 ----
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 249c5fa20de4..ed8981866f4d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -504,7 +504,11 @@ struct thread_struct {
 #endif
 };
 
-#define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
+#ifdef CONFIG_X86_DEBUG_FPU
+extern struct fpu *x86_task_fpu(struct task_struct *task);
+#else
+# define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
+#endif
 
 /*
  * X86 doesn't need any embedded-FPU-struct quirks:
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 0ccabcd3bf62..fdc3b227800d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -51,6 +51,15 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
+#ifdef CONFIG_X86_DEBUG_FPU
+struct fpu *x86_task_fpu(struct task_struct *task)
+{
+	WARN_ON_ONCE(task == &init_task);
+
+	return (void *)task + sizeof(*task);
+}
+#endif
+
 /*
  * Can we use the FPU in kernel mode with the
  * whole "kernel_fpu_begin/end()" sequence?
@@ -591,10 +600,8 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	 * This is safe because task_struct size is a multiple of cacheline size.
 	 */
 	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
-	struct fpu *src_fpu = x86_task_fpu(current);
 
 	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
-	BUG_ON(!src_fpu);
 
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
@@ -657,7 +664,6 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	if (update_fpu_shstk(dst, ssp))
 		return 1;
 
-	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
 	return 0;
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 11aa31410df2..53580e59e5db 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		fpstate_init_soft(&x86_task_fpu(current)->fpstate->regs.soft);
+		;
 	else
 #endif
 		asm volatile ("fninit");
@@ -164,7 +164,7 @@ static void __init fpu__init_task_struct_size(void)
 	 * Subtract off the static size of the register state.
 	 * It potentially has a bunch of padding.
 	 */
-	task_size -= sizeof(x86_task_fpu(current)->__fpstate.regs);
+	task_size -= sizeof(union fpregs_state);
 
 	/*
 	 * Add back the dynamically-calculated register state
@@ -209,7 +209,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_kernel_cfg.default_size = size;
 	fpu_user_cfg.max_size = size;
 	fpu_user_cfg.default_size = size;
-	fpstate_reset(x86_task_fpu(current));
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 90b11671e943..1f37da22ddbe 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -844,9 +844,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	if (err)
 		goto out_disable;
 
-	/* Reset the state for the current task */
-	fpstate_reset(x86_task_fpu(current));
-
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 226244a894da..3509afc6a672 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -170,10 +170,6 @@ SECTIONS
 		/* equivalent to task_pt_regs(&init_task) */
 		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
 
-		__x86_init_fpu_begin = .;
-		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
-		__x86_init_fpu_end = .;
-
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
 		NOSAVE_DATA
-- 
2.43.0


