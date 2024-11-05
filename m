Return-Path: <linux-kernel+bounces-396730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72A49BD15D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775DA28307F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3AA1CFED4;
	Tue,  5 Nov 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGxS1Owy"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EE17E012
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822307; cv=none; b=mHoR2yIZeFxHtDsHbU9SU1vMG7D4/fH7irEDg4GQFfovvHPHpmoS/JkMAqHVb5FR/YCmwfyo1juuGVhC6v5nMqaSps00HTbGK/yAmYsB8LFOXa5Zp3KbuKERoa5j46SIywkc6JhuFpn3/WqmKinYe39OYWuuIokiupMDl454sTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822307; c=relaxed/simple;
	bh=Vu4Aru3t+nTD/9DhTWuOwqYb5bFFth9MASE/1e7AN8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9vvx8f1FL/SMb6IZe1h+Q5Rh4oJYuR7oZlZyCzc38+k8g2y/k9srB1oafojEt3C7XdmeTfCKRpzjrZDbFpgn48Mj3mpazM8T/sHFrIbiswg7lWUhh6FVvIo3ellZGbb0Xj8g8kpNl7hZAdfCoYuNV5Vdi9olTaWmJhpMlJvlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGxS1Owy; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cc2ea27a50so55908106d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822304; x=1731427104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxOt6HJKiLxKCbdBkzP9Xb/0alDeNpfIlya14qEzTTk=;
        b=JGxS1OwyFvteJUaRxdET8kWjU80UfTHCO5oaG1apuv2fFfKC8KjhHe6vrOlXu7X2rO
         mZycE7Q6pCa5+FK3vv0XqKk/oHF0Hln/VZ7dcOEkxfvfjBMSZiADHKELDH7Ayx/nfRBk
         L/+KDnXuOb2DaL7XB/HdZndSYhpi9j5/aXLzBeILFW1r5Pr29fRF/h+xMc9gJtceNk1Y
         xwvwmNo2/GWYiXktSP0wVBUk8wHPrdaSFE2DDChT4Ymkz+3TqtiEVc7kVE3f78KXoLde
         RzyJpGNeGmHvwZAiNY6RfuidYRMltdU60T7R9Hi4K/X8/lRbWD1YGjJ6LOXVykXfH4ux
         bu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822304; x=1731427104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxOt6HJKiLxKCbdBkzP9Xb/0alDeNpfIlya14qEzTTk=;
        b=nRPJhkIqtFLxx2XK2CJLdNic+2JdO5Tx9sFgRV4x3UVCrfC/XkeWC5TBM/HFZ8TQeH
         vrccnSTGtdmOv/iYHz/JLc8NLs2PnA9ih0X+tKvtnfj/sXUL1/iSFxYKf6rKOe70Z047
         dYrZSzj2kK5C7Xm0JAFtZKvT0HB2+a014n4hf1wSyJSorcwt4LfOD6dUSudQdPaliwR1
         pCU9Cf4pKbk6b0t44HeYoRJauSdHJAcZMa5eMcQhMDsZmyoabg0QYgCeUvGMKJhWU54r
         +JBjtqRibV0nG4J4GYGaQ1kPj3ko1++yDkVPXx3ca+lqcIQ2RQ1mW33fZxakLzY2o0U4
         u9lw==
X-Gm-Message-State: AOJu0YxTthkeplrJCWGwX/GDEi22OjGiFJjP3pZ34TXB1DGLu+kr8dV9
	p8QvKvULiWR5JcKYQBuTfpAcRKi3sRw8cCDHWjtCAy9972FRQNXDgyx8
X-Google-Smtp-Source: AGHT+IG/lzUnhk7On5qjLnzU09eKlneqCzP/cSnIIFoXsH09tVs6kVXFDfbYtoMnnmFrPC3pghg4OQ==
X-Received: by 2002:a05:6214:2241:b0:6cb:c892:8c17 with SMTP id 6a1803df08f44-6d35b964b39mr319750636d6.22.1730822303581;
        Tue, 05 Nov 2024 07:58:23 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:23 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 08/16] x86/stackprotector/64: Convert to normal percpu variable
Date: Tue,  5 Nov 2024 10:57:53 -0500
Message-ID: <20241105155801.1779119-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older versions of GCC fixed the location of the stack protector canary
at %gs:40.  This constraint forced the percpu section to be linked at
absolute address 0 so that the canary could be the first data object in
the percpu section.  Supporting the zero-based percpu section requires
additional code to handle relocations for RIP-relative references to
percpu data, extra complexity to kallsyms, and workarounds for linker
bugs due to the use of absolute symbols.

GCC 8.1 supports redefining where the canary is located, allowng it to
become a normal percpu variable instead of at a fixed location.  This
removes the contraint that the percpu section must be zero-based.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Makefile                     | 20 +++++++++------
 arch/x86/entry/entry.S                |  2 --
 arch/x86/entry/entry_64.S             |  2 +-
 arch/x86/include/asm/processor.h      | 16 ++----------
 arch/x86/include/asm/stackprotector.h | 36 ++++-----------------------
 arch/x86/kernel/asm-offsets_64.c      |  6 -----
 arch/x86/kernel/cpu/common.c          |  5 +---
 arch/x86/kernel/head_64.S             |  3 +--
 arch/x86/xen/xen-head.S               |  3 +--
 9 files changed, 23 insertions(+), 70 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b773b34768d..88a1705366f9 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -140,14 +140,7 @@ ifeq ($(CONFIG_X86_32),y)
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
 
-    ifeq ($(CONFIG_STACKPROTECTOR),y)
-        ifeq ($(CONFIG_SMP),y)
-            KBUILD_CFLAGS += -mstack-protector-guard-reg=fs \
-                             -mstack-protector-guard-symbol=__ref_stack_chk_guard
-        else
-            KBUILD_CFLAGS += -mstack-protector-guard=global
-        endif
-    endif
+        percpu_seg := fs
 else
         BITS := 64
         UTS_MACHINE := x86_64
@@ -197,6 +190,17 @@ else
         KBUILD_CFLAGS += -mcmodel=kernel
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
+
+        percpu_seg := gs
+endif
+
+ifeq ($(CONFIG_STACKPROTECTOR),y)
+    ifeq ($(CONFIG_SMP),y)
+	KBUILD_CFLAGS += -mstack-protector-guard-reg=$(percpu_seg)
+	KBUILD_CFLAGS += -mstack-protector-guard-symbol=__ref_stack_chk_guard
+    else
+	KBUILD_CFLAGS += -mstack-protector-guard=global
+    endif
 endif
 
 #
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index b7ea3e8e9ecc..fe5344a249a1 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -52,7 +52,6 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
 
 THUNK warn_thunk_thunk, __warn_thunk
 
-#ifndef CONFIG_X86_64
 /*
  * Clang's implementation of TLS stack cookies requires the variable in
  * question to be a TLS variable. If the variable happens to be defined as an
@@ -66,4 +65,3 @@ THUNK warn_thunk_thunk, __warn_thunk
 #ifdef CONFIG_STACKPROTECTOR
 EXPORT_SYMBOL(__ref_stack_chk_guard);
 #endif
-#endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1b5be07f8669..f78ef9667c39 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -192,7 +192,7 @@ SYM_FUNC_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(fixed_percpu_data + FIXED_stack_canary)
+	movq	%rbx, PER_CPU_VAR(__stack_chk_guard)
 #endif
 
 	/*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c0975815980c..a113c3f4f558 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -419,16 +419,8 @@ struct irq_stack {
 
 #ifdef CONFIG_X86_64
 struct fixed_percpu_data {
-	/*
-	 * GCC hardcodes the stack canary as %gs:40.  Since the
-	 * irq_stack is the object at %gs:0, we reserve the bottom
-	 * 48 bytes of the irq stack for the canary.
-	 *
-	 * Once we are willing to require -mstack-protector-guard-symbol=
-	 * support for x86_64 stackprotector, we can get rid of this.
-	 */
 	char		gs_base[40];
-	unsigned long	stack_canary;
+	unsigned long	reserved;
 };
 
 DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
@@ -443,11 +435,7 @@ extern asmlinkage void entry_SYSCALL32_ignore(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
-#else	/* X86_64 */
-#ifdef CONFIG_STACKPROTECTOR
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
-#endif
-#endif	/* !X86_64 */
+#endif	/* X86_64 */
 
 struct perf_event;
 
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 00473a650f51..d43fb589fcf6 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -2,26 +2,10 @@
 /*
  * GCC stack protector support.
  *
- * Stack protector works by putting predefined pattern at the start of
+ * Stack protector works by putting a predefined pattern at the start of
  * the stack frame and verifying that it hasn't been overwritten when
- * returning from the function.  The pattern is called stack canary
- * and unfortunately gcc historically required it to be at a fixed offset
- * from the percpu segment base.  On x86_64, the offset is 40 bytes.
- *
- * The same segment is shared by percpu area and stack canary.  On
- * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
- * base of percpu area.  The first occupant of the percpu area is always
- * fixed_percpu_data which contains stack_canary at the appropriate
- * offset.  On x86_32, the stack canary is just a regular percpu
- * variable.
- *
- * Putting percpu data in %fs on 32-bit is a minor optimization compared to
- * using %gs.  Since 32-bit userspace normally has %fs == 0, we are likely
- * to load 0 into %fs on exit to usermode, whereas with percpu data in
- * %gs, we are likely to load a non-null %gs on return to user mode.
- *
- * Once we are willing to require GCC 8.1 or better for 64-bit stackprotector
- * support, we can remove some of this complexity.
+ * returning from the function.  The pattern is called the stack canary
+ * and is a unique value for each task.
  */
 
 #ifndef _ASM_STACKPROTECTOR_H
@@ -36,6 +20,8 @@
 
 #include <linux/sched.h>
 
+DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+
 /*
  * Initialize the stackprotector canary value.
  *
@@ -51,25 +37,13 @@ static __always_inline void boot_init_stack_canary(void)
 {
 	unsigned long canary = get_random_canary();
 
-#ifdef CONFIG_X86_64
-	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
-#endif
-
 	current->stack_canary = canary;
-#ifdef CONFIG_X86_64
-	this_cpu_write(fixed_percpu_data.stack_canary, canary);
-#else
 	this_cpu_write(__stack_chk_guard, canary);
-#endif
 }
 
 static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
 {
-#ifdef CONFIG_X86_64
-	per_cpu(fixed_percpu_data.stack_canary, cpu) = idle->stack_canary;
-#else
 	per_cpu(__stack_chk_guard, cpu) = idle->stack_canary;
-#endif
 }
 
 #else	/* STACKPROTECTOR */
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index bb65371ea9df..590b6cd0eac0 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -54,11 +54,5 @@ int main(void)
 	BLANK();
 #undef ENTRY
 
-	BLANK();
-
-#ifdef CONFIG_STACKPROTECTOR
-	OFFSET(FIXED_stack_canary, fixed_percpu_data, stack_canary);
-	BLANK();
-#endif
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9d42bd15e06c..1f33d5feb050 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2086,8 +2086,7 @@ void syscall_init(void)
 	if (!cpu_feature_enabled(X86_FEATURE_FRED))
 		idt_syscall_init();
 }
-
-#else	/* CONFIG_X86_64 */
+#endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
@@ -2096,8 +2095,6 @@ EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
 #endif
 
-#endif	/* CONFIG_X86_64 */
-
 /*
  * Clear all 6 debug registers:
  */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 56163e2124cf..c3028b4df85f 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -355,8 +355,7 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data. If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	 * The base of %gs always points to fixed_percpu_data.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 758bcd47b72d..ae4672ea00bb 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -53,8 +53,7 @@ SYM_CODE_START(startup_xen)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data.  If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	 * The base of %gs always points to fixed_percpu_data.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
-- 
2.47.0


