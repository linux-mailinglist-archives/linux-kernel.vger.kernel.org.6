Return-Path: <linux-kernel+bounces-561654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72004A61491
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C4D1B63067
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6077200119;
	Fri, 14 Mar 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e733EA1K"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462F20110F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965153; cv=none; b=hnwo7v7ZEIo14mLP9kUis9oALP44kMsJsracyBO9UX3M4Sk1XMfdZvpHF0xyGwfEuZ3exh8jkN9KRlvkRuh5D1A2ZfB7mJn3VnmotKyvDdlif+9sYjq3hgPgzjcKXb5c9ELqDVQj7hXHKh885K+uCg2nHl23exfDyMUNWWRc0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965153; c=relaxed/simple;
	bh=o4SMd5DBp/WKmz7RRjvN3ujNoeYVVFavfZxIfkWgWTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7iFQ8hZXx/Mr0XIgnaVYmM768Jc5OS4uCg2pciKOCecsU93gEkxmfLFkPyQ3VqfZTueKaem7PYe+f3aZAITWnTeRUzWazu3WpgYRfN/Z2XNEP9ZyqlwpofRq5fWPgdMgftKWZUJhFqwTxnMvfhgNkbaY+5qKWXvv6CD0XmPPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e733EA1K; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2bcc5c887efso1829952fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965151; x=1742569951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc/o/a5y2MySh4AIfJv4w5SkZzpsu4/WCrhprAfAfKQ=;
        b=e733EA1KofV87OwznowCs/OT17I/bPIrnNp+0LiPMXLvzGUtOTYh07D4NksZmJ8aJ8
         s7yGfYXXSS34Pktr0BzI43t+GOQuPsns5ovDxOUQupc94sElxJKZNJFvZSVqf0NdxYLa
         lnKuRtzRZsWSUfSBNKX4HgFz5R1zj9Mo0A7Yfs7VBJZCotYNq1qM0y1TUNvXHrRDDWpW
         7CVx9jylXqHhpC52ttAl60yOtgx1se5sx6lRbUK73kW/WZnM6vHlD0t8c9UTgpAoexi0
         rVN4KsXIbUsjxK2hJvPBbgSXBUEvfGHj9QKdTs7blw2B0/3dqhSg2NAHGmL5Pdz4Q2Lf
         5oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965151; x=1742569951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mc/o/a5y2MySh4AIfJv4w5SkZzpsu4/WCrhprAfAfKQ=;
        b=RGQ/8okpVFTx9UDKICoxs4YN8BczJDyw8AHBXJfEfw+v8AguDW8UtzFsJZg2Zj93ff
         zzxnT1E8G9nGhJZFO+umT2t6rzEaYa+n5f9fIB8YqQiNO8GLUd1poxyf1kqnzw0UJqWp
         zjmh3eJ3fGsQbSRaRwDChJV8N4U+bmDUpxghDf0g4CN+zk0x0pFGMpRAYuthClyd2a7R
         /dgejic1yiN9xeoSkG++jDz0843ab7seV20SGLNGzzA2/zTIWivy5IDccVfDRtHITtXy
         6bGKWLRCVR01UzygpJN9daHi9W0srlgJSmAEIDFkv70yMRdv8nO/SS3Ht6o2SdONnCpz
         2cZw==
X-Gm-Message-State: AOJu0YwZ19I6eyfvqdNXJDjwO11XGtJO+idprPQHOq0KwUwcrVte/pk6
	k06bAgYWTLEgv9FMUBHXl6A+qUTrkGgFNGnQYHlrERy/j+qZcRkQOgux
X-Gm-Gg: ASbGncsaLhK4wOMw1pe1GPg/rp+1XgohlyyUDQObhdjo9/PmBTnzFdIyH3qLAoLX0zN
	je+u3Kl8ZUr5N0sxHjwGTMiaV/xYO6Z0fTpVeAtc+j1lkAc+MCXT/oGwpPp0GfhArUcpSd5kzGA
	Jr3xrusSY9bSMZQ9bKl42/H89AyWTEdnbX/x8dREnuneCCty2cf77jXxsFICu4Z33F2VincM4rQ
	UdE2eqqaz1SntTtWECLnKf9tBEZyFr0HBma/L+5fAERbsu3cgI3kITDpJ/TVJhPH3SnMjxcNYF1
	q3jUHeKmXa5237iBn0gBcU8L2lzbwM/WvAVr
X-Google-Smtp-Source: AGHT+IGBB78gG3em3xoLp1wgCCtotC7e6TlZsRJanEmpJivJYIALtItcKk+dInrhVkfjBGfwegNMdg==
X-Received: by 2002:a05:6870:1ce:b0:2c1:6735:4abb with SMTP id 586e51a60fabf-2c690ecfcb2mr1700461fac.5.1741965150960;
        Fri, 14 Mar 2025 08:12:30 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6710f21efsm883026fac.30.2025.03.14.08.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:12:30 -0700 (PDT)
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
Subject: [PATCH v2 1/7] x86/xen: Move Xen upcall handler
Date: Fri, 14 Mar 2025 11:12:14 -0400
Message-ID: <20250314151220.862768-2-brgerst@gmail.com>
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

Move the upcall handler to Xen-specific files.

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/entry/common.c     | 72 -------------------------------------
 arch/x86/xen/enlighten_pv.c | 69 +++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 72 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3514bf2978ee..ce4d88eda693 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -21,11 +21,6 @@
 #include <linux/uaccess.h>
 #include <linux/init.h>
 
-#ifdef CONFIG_XEN_PV
-#include <xen/xen-ops.h>
-#include <xen/events.h>
-#endif
-
 #include <asm/apic.h>
 #include <asm/desc.h>
 #include <asm/traps.h>
@@ -455,70 +450,3 @@ SYSCALL_DEFINE0(ni_syscall)
 {
 	return -ENOSYS;
 }
-
-#ifdef CONFIG_XEN_PV
-#ifndef CONFIG_PREEMPTION
-/*
- * Some hypercalls issued by the toolstack can take many 10s of
- * seconds. Allow tasks running hypercalls via the privcmd driver to
- * be voluntarily preempted even if full kernel preemption is
- * disabled.
- *
- * Such preemptible hypercalls are bracketed by
- * xen_preemptible_hcall_begin() and xen_preemptible_hcall_end()
- * calls.
- */
-DEFINE_PER_CPU(bool, xen_in_preemptible_hcall);
-EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
-
-/*
- * In case of scheduling the flag must be cleared and restored after
- * returning from schedule as the task might move to a different CPU.
- */
-static __always_inline bool get_and_clear_inhcall(void)
-{
-	bool inhcall = __this_cpu_read(xen_in_preemptible_hcall);
-
-	__this_cpu_write(xen_in_preemptible_hcall, false);
-	return inhcall;
-}
-
-static __always_inline void restore_inhcall(bool inhcall)
-{
-	__this_cpu_write(xen_in_preemptible_hcall, inhcall);
-}
-#else
-static __always_inline bool get_and_clear_inhcall(void) { return false; }
-static __always_inline void restore_inhcall(bool inhcall) { }
-#endif
-
-static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	inc_irq_stat(irq_hv_callback_count);
-
-	xen_evtchn_do_upcall();
-
-	set_irq_regs(old_regs);
-}
-
-__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
-{
-	irqentry_state_t state = irqentry_enter(regs);
-	bool inhcall;
-
-	instrumentation_begin();
-	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
-
-	inhcall = get_and_clear_inhcall();
-	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-		irqentry_exit_cond_resched();
-		instrumentation_end();
-		restore_inhcall(inhcall);
-	} else {
-		instrumentation_end();
-		irqentry_exit(regs, state);
-	}
-}
-#endif /* CONFIG_XEN_PV */
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5e57835e999d..dcc2041f8e61 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -73,6 +73,7 @@
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
 #include <asm/cpu.h>
+#include <asm/irq_stack.h>
 #ifdef CONFIG_X86_IOPL_IOPERM
 #include <asm/io_bitmap.h>
 #endif
@@ -94,6 +95,44 @@ void *xen_initial_gdt;
 static int xen_cpu_up_prepare_pv(unsigned int cpu);
 static int xen_cpu_dead_pv(unsigned int cpu);
 
+#ifndef CONFIG_PREEMPTION
+/*
+ * Some hypercalls issued by the toolstack can take many 10s of
+ * seconds. Allow tasks running hypercalls via the privcmd driver to
+ * be voluntarily preempted even if full kernel preemption is
+ * disabled.
+ *
+ * Such preemptible hypercalls are bracketed by
+ * xen_preemptible_hcall_begin() and xen_preemptible_hcall_end()
+ * calls.
+ */
+DEFINE_PER_CPU(bool, xen_in_preemptible_hcall);
+EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
+
+/*
+ * In case of scheduling the flag must be cleared and restored after
+ * returning from schedule as the task might move to a different CPU.
+ */
+static __always_inline bool get_and_clear_inhcall(void)
+{
+	bool inhcall = __this_cpu_read(xen_in_preemptible_hcall);
+
+	__this_cpu_write(xen_in_preemptible_hcall, false);
+	return inhcall;
+}
+
+static __always_inline void restore_inhcall(bool inhcall)
+{
+	__this_cpu_write(xen_in_preemptible_hcall, inhcall);
+}
+
+#else
+
+static __always_inline bool get_and_clear_inhcall(void) { return false; }
+static __always_inline void restore_inhcall(bool inhcall) { }
+
+#endif
+
 struct tls_descs {
 	struct desc_struct desc[3];
 };
@@ -687,6 +726,36 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_machine_check)
 }
 #endif
 
+static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	inc_irq_stat(irq_hv_callback_count);
+
+	xen_evtchn_do_upcall();
+
+	set_irq_regs(old_regs);
+}
+
+__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+	bool inhcall;
+
+	instrumentation_begin();
+	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
+
+	inhcall = get_and_clear_inhcall();
+	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
+		irqentry_exit_cond_resched();
+		instrumentation_end();
+		restore_inhcall(inhcall);
+	} else {
+		instrumentation_end();
+		irqentry_exit(regs, state);
+	}
+}
+
 struct trap_array_entry {
 	void (*orig)(void);
 	void (*xen)(void);
-- 
2.48.1


