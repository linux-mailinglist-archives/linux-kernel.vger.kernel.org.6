Return-Path: <linux-kernel+bounces-560192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308DA5FF22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D0B3BCE16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C441EF0B6;
	Thu, 13 Mar 2025 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFAHh11u"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8A1E8353
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890167; cv=none; b=Fd6N/Y8SRiR3mQeL4R7IKtXoUV15gdGip9iVY4kTInFyZha+ybTcijdQhKC8yJ+KhXqUOqp9axhK5iQS4pCvHuChcyJNDIwuv6FMtu+h7vaMro4a2PKKrPCJUhrLmViowd/D4x/xZvDFJ18LxgJ9isu5gzIY3/iYS38JnBVjjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890167; c=relaxed/simple;
	bh=moN+wU/LJ/MudLZn/5ShH666yGXIqDM/7zexntBbRnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7Z3cNK/wtMiz9IfODMZojxlunQLg9QuLh92gCmpk41raEGOJ//xZ5J0SBspbrU2pOh4ADO1sn2LcPR68EPQyo3n0Ik0Zj2pXcswPHjstziZPojBi104Vx+rP1DRgXvbhqEiArK4rrd8XMAk+mjYCBPgji/az4GPfUBT3SRTjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFAHh11u; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ef9b8b4f13so12985497b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741890164; x=1742494964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHNDYN7puwtfPRioM9eDOR4JOExw68tKK5iB+G+beM4=;
        b=CFAHh11uwD4/9uBX/teXbLh4Ddi3BRSpgJvtWlGruELv2vkkJWjxr3k7e7yJEnPUad
         YgoPoWmeo+E8PFmXWLLOk+vPCqc0RxjztQgDoitaXV99jQjEMbcwgz5pBVhQl8aOH7T9
         AbzJgvYTbk7TMzUjnWGk+46rDDm5SawZw30n+z7BnGMRThSQY+TtwXgUH3bvxYmTArJr
         WjsGYsTlWo2T8mso6hGmesmnTLCSeSd7/Qq+iofPZF4iv1Q80b8jOYW9qGXYMQGJytHh
         jH0dp1DM+FiAgtRxSH+YpLwnpqsIt9WRzf8LIsHWWQ5blbZP4BYj7ZNNHLxYRX9UQV+M
         +Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890164; x=1742494964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHNDYN7puwtfPRioM9eDOR4JOExw68tKK5iB+G+beM4=;
        b=UErrC9kADxRVT7qDFMUE4TUTLqswIaIR0+cZN5vD1tQRBI4i73EWXTPomFGneakR/3
         IA+kGjcTkA/StmPsgmSYyLvVxGHtAh8Cro/ZcIIGIf513wVu+lPO3xhxiTgxZz0q4Bpv
         fWtYcZ35MSbujpm7jKkfBwuirKVv/8KZB7COQ68Dw/ja2mnLp24yazLWVEiJPhxl2bFg
         voLeq3DqemWgxE7NoV3gvUOFRvao9InKCBGpZdEtemEdCECUtGytReODS1phNv8NQVN6
         WcId+PGTsmGKEXW7sxzbBANciaer8TQScwRKZ9m4FHqPjiRCpfNtaTl60rPnSVBXw/cs
         3tzw==
X-Gm-Message-State: AOJu0Yxnbd5qyPK/XGk6va2V5/MXc2miiYbrI4QC0jsGd/A+qh0QpHAq
	MQf2+z2CNSBn8iPNaYkTEFWtpYbWKKpE9rBcWQ9g5J5DBm6sMJxHQD6t
X-Gm-Gg: ASbGnctnctadJ/ho2AGLLdQWSl4qKcmSYXPYMY1pAR/XHOwY73//+fLjaB8ZmaAboBJ
	dXuwgs7MwLSJ6hETM5sY3ka0aetK3bHRsX0bCTA+eZsbeGCwfKwgNu3aUUXbXVpRDq5qw3mZdgS
	VVobk+/LyZmLBNM1G8u8VVzQffr+XPIW/G4QxFmR5EtvVnv5wg0nZyFpgwZBg4piFxLBcIOM514
	TdD29An6Z6O7NGMAhlD+M4zw71Kuv3yJ0MszwqAUUidsK+YeUElTjsHsxflVV4mDW1ewWssFNKY
	bcvls+/DYz+/PemGF2kj3lsnrA==
X-Google-Smtp-Source: AGHT+IHDw3iC1bxlby/+x2sfiQCv10ZlXNkqQL3f+hzI0ft5LgVvyAc9xRcHhIdOwcfQVnZ+tcM/jg==
X-Received: by 2002:a05:690c:700d:b0:6fe:c021:f745 with SMTP id 00721157ae682-6ff41f03320mr7698957b3.4.1741890164045;
        Thu, 13 Mar 2025 11:22:44 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff3288f0absm4910347b3.54.2025.03.13.11.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:22:43 -0700 (PDT)
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
Subject: [PATCH 3/5] x86/syscall/64: Move 64-bit syscall dispatch code
Date: Thu, 13 Mar 2025 14:22:34 -0400
Message-ID: <20250313182236.655724-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313182236.655724-1-brgerst@gmail.com>
References: <20250313182236.655724-1-brgerst@gmail.com>
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
 arch/x86/entry/Makefile     |   2 +
 arch/x86/entry/common.c     |  93 --------------------------------
 arch/x86/entry/syscall_64.c | 103 +++++++++++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 95 deletions(-)

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
index ba8354424860..9e0ba339013c 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -1,10 +1,19 @@
-// SPDX-License-Identifier: GPL-2.0
-/* System call table for x86-64. */
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * 64-bit system call dispatch
+ *
+ * Copyright (c) 2015 Andrew Lutomirski
+ *
+ * Based on asm and ptrace code by many authors.  The code here originated
+ * in ptrace.c and signal.c.
+ */
 
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
+#include <linux/entry-common.h>
+#include <linux/nospec.h>
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
@@ -34,3 +43,93 @@ long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
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


