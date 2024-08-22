Return-Path: <linux-kernel+bounces-296821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B1C95AF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862841F228FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782BB179206;
	Thu, 22 Aug 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eocL3/ZF"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD51531F8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312411; cv=none; b=mwDzDKPhmdkMg9CHYrD4C0vxAi9dJrzfxlWWsmnMYd4BDciWlSVKlU7AXtZ/Gecq4YHHDCrv4js8bGQuzSW0szU5plLlvFdUI6xf/ZU0StAwPU+M9pg+nHdR3dZYd1MLiYhJLVKI6a7nWcy9ceiF58VciWLeLA+ncXZFXjdUFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312411; c=relaxed/simple;
	bh=aNYnXJfAjoHaQ/QbdLgAYt+ETay54vFfF5z45r3L8a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKTiAK2+/WD6iURBLaKJRX8YbY+BK1bCW4S/zVdCfubXue1GrIH1bczWlB5s3T6EQQIwB5HaaCNJ6rGC2vAn9VI42mSl9cVoJlepeDorZ0K7WJOkVigSvqLj54OT/dNi/rPu/whxTqz53izW1ir+11O/M4p/yCi35tunlczOq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=eocL3/ZF; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47M7d7s82176365
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 22 Aug 2024 00:39:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47M7d7s82176365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1724312353;
	bh=IeFVXk/e0IdKRKA1IK5jS0OXRd7M07rrVaEv/CTf7Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eocL3/ZFw52FiPYTLHSyM4KV4lLsfwZZnQsoUuvs6jJ+evfyUQ10Wmx3WXiq9Cmnf
	 pnl32OtZtjRO6hRwf8LEItDdtGkWn5fU6tGoXiIZM4sGv6sKLiNbWpXdcKUGa3RYRO
	 1Ws3j250ZhqjyEmD7F/UJbNQ3GI50uFGDHYjr3J7iCuOeJBme4+JTvHyCYQDWXOwmp
	 tmAJHKG15ml2RS7Isr+8MkuxDX6uELP7Pf6blE6iASZuILeLzz0Tyym6dbH6TjcYKO
	 60i+E7eR9mcKz/yHlm/PagofJycb5xCTzW2gVNCRdQaxQ+eOA+tctFbGr9LeHWtlTF
	 d7u5U5mkA49QA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, andrew.cooper3@citrix.com, seanjc@google.com
Subject: [PATCH v2 3/3] x86/entry: Set FRED RSP0 on return to userspace instead of context switch
Date: Thu, 22 Aug 2024 00:39:06 -0700
Message-ID: <20240822073906.2176342-4-xin@zytor.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822073906.2176342-1-xin@zytor.com>
References: <20240822073906.2176342-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FRED RSP0 is a per task constant pointing to top of its kernel stack
for user level event delivery, and needs to be updated when a task is
scheduled in.

Keep FRED RSP0 in per CPU cache, and update FRED RSP0 and its copy in
per CPU cache only when switching to a new task, i.e., current stack
is changed.

An API fred_sync_rsp0() is added for KVM to stuff the cache with the
guest's FRED RSP0 when switching to host.

Suggested-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Change since v1:
* Use per CPU cache, rather than a new TI flag. (Thomas Gleixner)
---
 arch/x86/include/asm/entry-common.h |  3 +++
 arch/x86/include/asm/fred.h         | 21 ++++++++++++++++++++-
 arch/x86/include/asm/switch_to.h    |  5 +----
 arch/x86/kernel/fred.c              |  3 +++
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index db970828f385..77d20555e04d 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -8,6 +8,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
 #include <asm/fpu/api.h>
+#include <asm/fred.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
@@ -63,6 +64,8 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	if (IS_ENABLED(CONFIG_X86_DEBUG_FPU) || unlikely(ti_work))
 		arch_exit_work(ti_work);
 
+	fred_update_rsp0();
+
 #ifdef CONFIG_COMPAT
 	/*
 	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 66d7dbe2d314..25ca00bd70e8 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -36,6 +36,7 @@
 
 #ifdef CONFIG_X86_FRED
 #include <linux/kernel.h>
+#include <linux/sched/task_stack.h>
 
 #include <asm/ptrace.h>
 
@@ -87,12 +88,30 @@ void cpu_init_fred_exceptions(void);
 void cpu_init_fred_rsps(void);
 void fred_complete_exception_setup(void);
 
+DECLARE_PER_CPU(unsigned long, fred_rsp0);
+
+static __always_inline void fred_sync_rsp0(unsigned long rsp0)
+{
+	__this_cpu_write(fred_rsp0, rsp0);
+}
+
+static __always_inline void fred_update_rsp0(void)
+{
+	unsigned long rsp0 = (unsigned long) task_stack_page(current) + THREAD_SIZE;
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED) && (__this_cpu_read(fred_rsp0) != rsp0)) {
+		wrmsrns(MSR_IA32_FRED_RSP0, rsp0);
+		__this_cpu_write(fred_rsp0, rsp0);
+	}
+}
 #else /* CONFIG_X86_FRED */
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
 static inline void cpu_init_fred_exceptions(void) { }
 static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
-static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
+static inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
+static inline void fred_sync_rsp0(unsigned long rsp0) { }
+static inline void fred_update_rsp0(void) { }
 #endif /* CONFIG_X86_FRED */
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index e9ded149a9e3..75248546403d 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -70,12 +70,9 @@ static inline void update_task_stack(struct task_struct *task)
 #ifdef CONFIG_X86_32
 	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
-		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);
-	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) && cpu_feature_enabled(X86_FEATURE_XENPV))
 		/* Xen PV enters the kernel on the thread stack. */
 		load_sp0(task_top_of_stack(task));
-	}
 #endif
 }
 
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 99a134fcd5bf..036d5cd47f88 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -21,6 +21,9 @@
 
 #define FRED_STKLVL(vector, lvl)	((lvl) << (2 * (vector)))
 
+DEFINE_PER_CPU(unsigned long, fred_rsp0);
+EXPORT_PER_CPU_SYMBOL(fred_rsp0);
+
 void cpu_init_fred_exceptions(void)
 {
 	/* When FRED is enabled by default, remove this log message */
-- 
2.46.0


