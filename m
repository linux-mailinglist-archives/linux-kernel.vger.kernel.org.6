Return-Path: <linux-kernel+bounces-560190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7710A5FF20
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E707A36D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE41EDA0B;
	Thu, 13 Mar 2025 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2AMyT+P"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4917E8E2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890166; cv=none; b=oOIRu6PxhRikzsO6939KV45i12ob/9iB/OaO1wz3v9d7z8pBOMoqRGQqOEmripImymp1vWXFF+/5LYX+k5L17k0xU9WDIdNE6OB+Px1A2u3m7Igb+k8cMc+g2M4rdqxRiI5iRPWWM19PSNDt3t2kkLLp3cNr+UdLA5mSObJZY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890166; c=relaxed/simple;
	bh=g4Kuo2CPanqbJ5fBryROh6KFUqZfMSobOEFj6Rycvvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh2NdMNjgWm0Trg630G00pEBnodj8xVQBeoy8QflIZQZNSAPdwwcwniXTh7/d20zSws7pYXr84SML5GZRAZdfOOjLp/7LZpQDn6pNozevhjbRrLLd6/h5BlaQdCqjdhGeNtvNcUhOmQzm6Yi7o2XP4Ndw55yIIPb9rt0fHF5IWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2AMyT+P; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e63c3a53a4cso1123841276.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741890160; x=1742494960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r249kTrGMfiJdyCvHIqY7lcf73sz6LjLxDDjAJXT47c=;
        b=b2AMyT+Pv0seaCWh19G3pRjWucd5RO329u+jA1QON9jpo85LY6GdKOgTA+kayu4zmT
         BfGIKoPq1iNkfyrR+UDi2YTxe1VB7QridXjsAg/GtaSwwJlj2lOo3CfnWYqfQ2lm6oZa
         UO0XBJcjJ+hxOSp6YVEK3fmbImcf5SKEN6912kGMPtGM3Qs8W20zalpTBvX7RIS2pIiX
         AcrYGUyqOrCy+jBhjXd3nRhOFtzOy1qZnbIGHuIuFph1W/mZfDsKLUyCvIiQ48P+SDrf
         hrV8lZQzmAB/7OFVN+05XCM9oUpAdJF5/3DpUqRHhsSHkrgZiuzePse0NRuLBY87158Z
         q8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890160; x=1742494960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r249kTrGMfiJdyCvHIqY7lcf73sz6LjLxDDjAJXT47c=;
        b=nOITefpwOkU9qoI8TA0i7SIsRg1AoORwQYrQUqPR6d/Rnj+g2ACXChUutkFEMs56jH
         +pZ6VzW3qLgTCNkyGQCsx57Q52jwFN47Q7qQoihGb4vSpo8wtCgxR8TBJvijha0kwhsT
         4gnWrUJzxQNgfSUPwdf321FpkSYZUXawr4+kHHbAWUoBeHAibDzA21M9yzJRTH+hobFz
         1OPBW64pNjNuBBgudJ9oKJQiNE7Dp1+mmngOQa/9B4Bx40Jkcoxf+b0FZGm+HcWxgR2Y
         V+rP8K1fJRZYKYJzsn5kbHnZT6nBUYG5XNo+z5KuKAoncsMiqOKmDM8SNrtaPaVEKd/D
         izow==
X-Gm-Message-State: AOJu0YwXQQCI+HxKXTo1CdnJLDYEX3BMJNJLTAjFKCcSjmRuIjYxi+WT
	PwjqchmLdrXtliawKLu5GZdvM+WuTwGBKCkZDikDrZHON3oIXqzCh68E
X-Gm-Gg: ASbGncsvdBxELTrQliTQoLRTXc/r+QRXlAIoocv95WpURzu78RMzhjtQ78JFEdSLP/f
	oexNE4jt6oTsS7Sr/1iCTHwaFWiKAb0oD82laVuHJUKhczOQmN1dJgVCbf1kax44YF5AaQF5EU9
	4pw0apAUxue6psSnGM5BKj8w1FXftt86g0dI6pgbAegA3ZsdbxkMvE/duX6ibuXn6ExdptlmN4q
	2LjilwY+bGIL5QtYtmbK/eH5qfbgsqi600RIbXQyFIz2O9YfqWP2nVSh5NjDyGiDh/VLfI3iB2y
	il0e1mxwYYVyjXAZVQkS5kqBLnH7pEYiOAd8
X-Google-Smtp-Source: AGHT+IEhb5zRpnSbW+CPM9ho/zNMlWHLm+SLOGqkvx+9244XZjARw7mgTV97uqXDMfpg6SlvLJqCEw==
X-Received: by 2002:a05:690c:45c8:b0:6fb:4fee:6044 with SMTP id 00721157ae682-6ff43539961mr438647b3.15.1741890160624;
        Thu, 13 Mar 2025 11:22:40 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff3288f0absm4910347b3.54.2025.03.13.11.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:22:40 -0700 (PDT)
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
Subject: [PATCH 1/5] x86/xen: Move Xen upcall handler
Date: Thu, 13 Mar 2025 14:22:32 -0400
Message-ID: <20250313182236.655724-2-brgerst@gmail.com>
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

Move the upcall handler to Xen-specific files.

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/entry/common.c     | 72 -------------------------------------
 arch/x86/xen/enlighten_pv.c | 46 ++++++++++++++++++++++++
 include/xen/xen-ops.h       | 19 ++++++++++
 3 files changed, 65 insertions(+), 72 deletions(-)

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
index 5e57835e999d..af9e43c47b07 100644
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
@@ -94,6 +95,21 @@ void *xen_initial_gdt;
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
+#endif
+
 struct tls_descs {
 	struct desc_struct desc[3];
 };
@@ -687,6 +703,36 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_machine_check)
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
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 47f11bec5e90..174ef8e4600f 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -208,10 +208,29 @@ static inline void xen_preemptible_hcall_end(void)
 	__this_cpu_write(xen_in_preemptible_hcall, false);
 }
 
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
 #else
 
 static inline void xen_preemptible_hcall_begin(void) { }
 static inline void xen_preemptible_hcall_end(void) { }
+static __always_inline bool get_and_clear_inhcall(void) { return false; }
+static __always_inline void restore_inhcall(bool inhcall) { }
 
 #endif /* CONFIG_XEN_PV && !CONFIG_PREEMPTION */
 
-- 
2.48.1


