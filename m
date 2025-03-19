Return-Path: <linux-kernel+bounces-567409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A0A6858F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C993AC417
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B092500DF;
	Wed, 19 Mar 2025 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jlMrq0VU"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8C24E007
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368246; cv=none; b=A6no7lPgU9Q9UW59gAwGSoZMVilsPC7gzL6AmX0ujlmX9JZ8dBhT7DVzpXV2xkuGcGyEj65cP6if+DqMPShR2stj6JtlmdS7d/POPJIQ6UJWN1cnYm82jPzNjRbtM9mNqVR7PROUqwn9Jvr3OPcubDTw3pJXVKcw1xBQ9QdGOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368246; c=relaxed/simple;
	bh=Mw/D9/cpOxJ5xjvJanIhep092sQkIq/dpYGXTJVH9Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTBbLGNBJ0t0CTgm3XYnZRKxvFwPY4dUkK0xMRia19ZI6Pl1gc30DwtWIfxdhJGilYq9MFknFtxf7zOA13cxu9s4EIdoTVh1ijLfKHv5FAY6O69cLm9RGG2bjQsG8z4Tyw2af7Y8TSm0aYMACXWDcLzoh38CJ6rNZ2FckkZCVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=jlMrq0VU; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52J7A9qg1391002
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 19 Mar 2025 00:10:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52J7A9qg1391002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742368218;
	bh=wXzmNJRfOP+rKDiXHLmvo9PJ7Aaj6mhz/debxsKklQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlMrq0VUZ02nh61kClVimva8hHmU1Eq9Jdm+zqK4jQYTYKFj7KqAt1g+tu0Zw2cUV
	 34PaDw4c/YliWy5hJvbeWKaRxP/xz6u7WY291pyjXU0p/mds8ilmobftCNABLEzRqQ
	 04Gupv1lE4ld3KC6z9NhVTiU0nMn4ZR+O4HX2tz3Jkyl1XUYOmMNQ1+xg3oL85sK28
	 c3nvIBBnZymCxjEMXtXLtx4W0/YcWgMQBv1ni0Uvqx40ZYcNK9eb/0KIJUnS5sxVFC
	 1sx40u56lUCJDpL9OVk9jbSWOyCfHTDfNTySCYEj95WzjepMxDMa407QLTjfmZA2mt
	 A4jZ81pmy3hRA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v3 3/3] x86: Zap TOP_OF_KERNEL_STACK_PADDING on x86_64
Date: Wed, 19 Mar 2025 00:10:09 -0700
Message-ID: <20250319071009.1390984-4-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319071009.1390984-1-xin@zytor.com>
References: <20250319071009.1390984-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because task_pt_regs() is now just an alias of thread_info.user_pt_regs,
and no matter whether FRED is enabled or not a user level event frame on
x86_64 is always pushed from top of current task kernel stack, i.e.,
'(unsigned long)task_stack_page(task) + THREAD_SIZE', there is no meaning
to keep TOP_OF_KERNEL_STACK_PADDING on x86_64, thus remove it.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Change in v2:
* Rebase on latest tip/master.
---
 arch/x86/include/asm/fred.h        |  2 +-
 arch/x86/include/asm/processor.h   |  6 ++++--
 arch/x86/include/asm/thread_info.h | 10 ----------
 arch/x86/kernel/process.c          |  3 +--
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 2a29e5216881..f9cca8c2c73e 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -97,7 +97,7 @@ static __always_inline void fred_sync_rsp0(unsigned long rsp0)
 
 static __always_inline void fred_update_rsp0(void)
 {
-	unsigned long rsp0 = (unsigned long) task_stack_page(current) + THREAD_SIZE;
+	unsigned long rsp0 = task_top_of_stack(current);
 
 	if (cpu_feature_enabled(X86_FEATURE_FRED) && (__this_cpu_read(fred_rsp0) != rsp0)) {
 		wrmsrns(MSR_IA32_FRED_RSP0, rsp0);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a88ddf5614f2..3b7adefe05ab 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -656,8 +656,6 @@ extern unsigned long __end_init_stack[];
  */
 #define TOP_OF_INIT_STACK ((unsigned long)&__end_init_stack)
 
-#define task_top_of_stack(task) ((unsigned long)(task_pt_regs(task) + 1))
-
 /*
  * Note, this can't be converted to an inline function as this header
  * file defines 'struct thread_struct' which is used in the task_struct
@@ -666,6 +664,9 @@ extern unsigned long __end_init_stack[];
 #define task_pt_regs(task) ((task)->thread_info.user_pt_regs)
 
 #ifdef CONFIG_X86_32
+#define task_top_of_stack(task) ((unsigned long)task_stack_page(task) + THREAD_SIZE	\
+				 - TOP_OF_KERNEL_STACK_PADDING)
+
 #define INIT_THREAD  {							  \
 	.sp0			= TOP_OF_INIT_STACK,			  \
 	.sysenter_cs		= __KERNEL_CS,				  \
@@ -673,6 +674,7 @@ extern unsigned long __end_init_stack[];
 
 #else
 extern unsigned long __top_init_kernel_stack[];
+#define task_top_of_stack(task) ((unsigned long)task_stack_page(task) + THREAD_SIZE)
 
 #define INIT_THREAD {							\
 	.sp	= (unsigned long)&__top_init_kernel_stack,		\
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 915a6839bd61..d8ccca04b4d9 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -30,10 +30,6 @@
  *
  * In vm86 mode, the hardware frame is much longer still, so add 16
  * bytes to make room for the real-mode segments.
- *
- * x86-64 has a fixed-length stack frame, but it depends on whether
- * or not FRED is enabled. Future versions of FRED might make this
- * dynamic, but for now it is always 2 words longer.
  */
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_VM86
@@ -41,12 +37,6 @@
 # else
 #  define TOP_OF_KERNEL_STACK_PADDING 8
 # endif
-#else /* x86-64 */
-# ifdef CONFIG_X86_FRED
-#  define TOP_OF_KERNEL_STACK_PADDING (2 * 8)
-# else
-#  define TOP_OF_KERNEL_STACK_PADDING 0
-# endif
 #endif
 
 /*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 58c1cd4ca60a..51020caac332 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -124,9 +124,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
  */
 void arch_init_user_pt_regs(struct task_struct *tsk)
 {
-	unsigned long top_of_stack = (unsigned long)task_stack_page(tsk) + THREAD_SIZE;
+	unsigned long top_of_stack = task_top_of_stack(tsk);
 
-	top_of_stack -= TOP_OF_KERNEL_STACK_PADDING;
 	tsk->thread_info.user_pt_regs = (struct pt_regs *)top_of_stack - 1;
 }
 
-- 
2.48.1


