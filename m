Return-Path: <linux-kernel+bounces-561656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359D3A61494
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830373AD270
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9D202994;
	Fri, 14 Mar 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8NKbJJR"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274720126B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965161; cv=none; b=U1qtmSRGHZbJr3rKrJGBt7LY6EZxEZgZ9hjzLf6PE4DfiRrFUfD6RNggBrqzMPYn58oQgqsNQ0e0UNxNckcNKW3dpr8K8ixgEfGmRavsRc2+TjNzAiwBuT3QD/hEe+lH1s3kZpf7KE26heHYV4bBWUXtSts8I5l9gTWD3pegGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965161; c=relaxed/simple;
	bh=UcPYSY91IwtgOB4ai8MToI7AlvlP3dEP0pcPPdj1U+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1kagQfOzxtUyYZdIoXTXkWSf6BN7mENTJgWhXbbcPRqnqKKQ1dafLlUnQ9H9zR7J5fQZuvEpcpCf3uqoHoIyx433eGnPM/dELAKh70G0ex4QbppDomX2s5dNG0V8Utu9yyByA2uXUBnd6yNolbFOF9KTlRYXoqEvTsG6dXr5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8NKbJJR; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2bcbd92d5dbso1187530fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965157; x=1742569957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6+HafW/MGgyXYgn6+okE7Xm8nys/EIGKCy6LM/Z9VQ=;
        b=j8NKbJJR1hs6VX8+4iG1/dFCqzY+pCO5xiWZHV/WMdYjp9EPI1YMSOCxmTZrPuzXwY
         rXQTlNPRUdTwb3JC+FKSshHbTf0AS5rYyhxaMbdv+q4KdUqKZxvR9dq7jY8ENk/btaga
         /G4GNUIJncqPvTqOy6Zg6wgIrvTCwpHKWlMDABI5SDTMOppZpOlLbEhH7nN7B8iQVyZl
         pI8H1XoUJzBwVlUtETwQb1cMpG//wpkyqwGq1cha8uOhX7kYXIGmJyEF2eUr4FK9f5kz
         CdJNGPp2umbXiVLWljaN6TJrSmoDkyoxJknFmClPJAxvFYIDpO9IS6cW78YeHzeKoudo
         8MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965157; x=1742569957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6+HafW/MGgyXYgn6+okE7Xm8nys/EIGKCy6LM/Z9VQ=;
        b=lbRQEKkse0toVvLulTARcpOjFpFj5JieKjnX+XlTnGAse6QjXqJ8V1aIHtjakW2V8+
         1B5lBr+bWK/UEPen5g+iO1ZVraIHpi1LTop0xpMFaP/4Dr6jAbXBxSMIsbVdAPGjUaDj
         J/UOD7Jg8QIb52VTexNKcYHYi7bOi9u6tQW/lBZxFSiNEhHkYAxZ17hrzqJZCljzFRMU
         DAUlU08qFyCB9/TAUFOQUD41MQdpyZHmPGzoaE8e8cw5m4LI+N33VAElfVkXTEM+ljrd
         85RE/agL+iqQY0sMHd4YGYwLSc7S8eDtUJyZoETdWHRs7gS4/O4jCiLmTvemgt7G+oxa
         7Csw==
X-Gm-Message-State: AOJu0YzECx8nE4ZOjwtUoYeLyN1GE5wqczmRUo7C8+SBf1uLLapVf02P
	YDPaOiSXv5DCQG8d1Fm/GwBtMG/wFFpRmr2hDsNHB9lFILzWNJw9DSsr
X-Gm-Gg: ASbGncuDzQ4cikl+l7i14aMZ0CNySmkWaobU+nYe4aigvqo3jXWrvCGpRROG93mfqp1
	2Gy9n/RvFEIe4KhK8Hi5skWaBSoSTuMxZzHEf4blENqEIUTY/DA4oxWMAJiZGi93yyoVGUxRIi6
	jM2KyNWAYNtOPUNlobbL5C7Lv2hcEqgDp26DFCuIo+v8nvVjePX1my1kXgYA8b03kiEXPz9RrVI
	eiDKGjZtBtX7iKQGW0U5b9fPncDzQIJ8xOcyALD520yuCA1fiM1uUdanZ99bDjVh1cdguuq6os6
	rzr8BHnnVhDoe3CzVXw+OnC1aA==
X-Google-Smtp-Source: AGHT+IFD1CaGE2RpgNu5GsbuoCgB4ZtYsC59fwHSOWQMUaE0J9WqCjkeGqQqVqVEV6GTJt5HFWIjwQ==
X-Received: by 2002:a05:6871:6017:b0:261:16da:decb with SMTP id 586e51a60fabf-2c690f3c1c4mr1465210fac.11.1741965157525;
        Fri, 14 Mar 2025 08:12:37 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6710f21efsm883026fac.30.2025.03.14.08.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:12:36 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 3/7] x86/syscall/64: Move 64-bit syscall dispatch code
Date: Fri, 14 Mar 2025 11:12:16 -0400
Message-ID: <20250314151220.862768-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314151220.862768-1-brgerst@gmail.com>
References: <20250314151220.862768-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the 64-bit syscall dispatch code to syscall_64.c.

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/Makefile     |  2 +
 arch/x86/entry/common.c     | 93 -----------------------------------
 arch/x86/entry/syscall_64.c | 96 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 95 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 96a6b86e0a8b..5fd28abfd5a0 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -9,9 +9,11 @@ KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
 CFLAGS_syscall_32.o		+= -fno-stack-protector
+CFLAGS_syscall_64.o		+= -fno-stack-protector
 
 obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 183efabefe57..5bd448c0664f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -32,99 +32,6 @@
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
 
-#ifdef CONFIG_X86_64
-
-static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
-{
-	/*
-	 * Convert negative numbers to very high and thus out of range
-	 * numbers for comparisons.
-	 */
-	unsigned int unr = nr;
-
-	if (likely(unr < NR_syscalls)) {
-		unr = array_index_nospec(unr, NR_syscalls);
-		regs->ax = x64_sys_call(regs, unr);
-		return true;
-	}
-	return false;
-}
-
-static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
-{
-	/*
-	 * Adjust the starting offset of the table, and convert numbers
-	 * < __X32_SYSCALL_BIT to very high and thus out of range
-	 * numbers for comparisons.
-	 */
-	unsigned int xnr = nr - __X32_SYSCALL_BIT;
-
-	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
-		xnr = array_index_nospec(xnr, X32_NR_syscalls);
-		regs->ax = x32_sys_call(regs, xnr);
-		return true;
-	}
-	return false;
-}
-
-/* Returns true to return using SYSRET, or false to use IRET */
-__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
-{
-	add_random_kstack_offset();
-	nr = syscall_enter_from_user_mode(regs, nr);
-
-	instrumentation_begin();
-
-	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
-		/* Invalid system call, but still a system call. */
-		regs->ax = __x64_sys_ni_syscall(regs);
-	}
-
-	instrumentation_end();
-	syscall_exit_to_user_mode(regs);
-
-	/*
-	 * Check that the register state is valid for using SYSRET to exit
-	 * to userspace.  Otherwise use the slower but fully capable IRET
-	 * exit path.
-	 */
-
-	/* XEN PV guests always use the IRET path */
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
-		return false;
-
-	/* SYSRET requires RCX == RIP and R11 == EFLAGS */
-	if (unlikely(regs->cx != regs->ip || regs->r11 != regs->flags))
-		return false;
-
-	/* CS and SS must match the values set in MSR_STAR */
-	if (unlikely(regs->cs != __USER_CS || regs->ss != __USER_DS))
-		return false;
-
-	/*
-	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
-	 * in kernel space.  This essentially lets the user take over
-	 * the kernel, since userspace controls RSP.
-	 *
-	 * TASK_SIZE_MAX covers all user-accessible addresses other than
-	 * the deprecated vsyscall page.
-	 */
-	if (unlikely(regs->ip >= TASK_SIZE_MAX))
-		return false;
-
-	/*
-	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
-	 * restoring TF results in a trap from userspace immediately after
-	 * SYSRET.
-	 */
-	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)))
-		return false;
-
-	/* Use SYSRET to exit to userspace */
-	return true;
-}
-#endif
-
 SYSCALL_DEFINE0(ni_syscall)
 {
 	return -ENOSYS;
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index ba8354424860..e0c62d5a397c 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -1,10 +1,12 @@
-// SPDX-License-Identifier: GPL-2.0
-/* System call table for x86-64. */
+// SPDX-License-Identifier: GPL-2.0-only
+/* 64-bit system call dispatch */
 
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
+#include <linux/entry-common.h>
+#include <linux/nospec.h>
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
@@ -34,3 +36,93 @@ long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 	default: return __x64_sys_ni_syscall(regs);
 	}
 };
+
+static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Convert negative numbers to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int unr = nr;
+
+	if (likely(unr < NR_syscalls)) {
+		unr = array_index_nospec(unr, NR_syscalls);
+		regs->ax = x64_sys_call(regs, unr);
+		return true;
+	}
+	return false;
+}
+
+static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Adjust the starting offset of the table, and convert numbers
+	 * < __X32_SYSCALL_BIT to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int xnr = nr - __X32_SYSCALL_BIT;
+
+	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
+		xnr = array_index_nospec(xnr, X32_NR_syscalls);
+		regs->ax = x32_sys_call(regs, xnr);
+		return true;
+	}
+	return false;
+}
+
+/* Returns true to return using SYSRET, or false to use IRET */
+__visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
+{
+	add_random_kstack_offset();
+	nr = syscall_enter_from_user_mode(regs, nr);
+
+	instrumentation_begin();
+
+	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
+		/* Invalid system call, but still a system call. */
+		regs->ax = __x64_sys_ni_syscall(regs);
+	}
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+
+	/*
+	 * Check that the register state is valid for using SYSRET to exit
+	 * to userspace.  Otherwise use the slower but fully capable IRET
+	 * exit path.
+	 */
+
+	/* XEN PV guests always use the IRET path */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+
+	/* SYSRET requires RCX == RIP and R11 == EFLAGS */
+	if (unlikely(regs->cx != regs->ip || regs->r11 != regs->flags))
+		return false;
+
+	/* CS and SS must match the values set in MSR_STAR */
+	if (unlikely(regs->cs != __USER_CS || regs->ss != __USER_DS))
+		return false;
+
+	/*
+	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
+	 * in kernel space.  This essentially lets the user take over
+	 * the kernel, since userspace controls RSP.
+	 *
+	 * TASK_SIZE_MAX covers all user-accessible addresses other than
+	 * the deprecated vsyscall page.
+	 */
+	if (unlikely(regs->ip >= TASK_SIZE_MAX))
+		return false;
+
+	/*
+	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
+	 * restoring TF results in a trap from userspace immediately after
+	 * SYSRET.
+	 */
+	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)))
+		return false;
+
+	/* Use SYSRET to exit to userspace */
+	return true;
+}
-- 
2.48.1


