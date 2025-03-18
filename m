Return-Path: <linux-kernel+bounces-565585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6850A66B41
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46178175DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514B1EF372;
	Tue, 18 Mar 2025 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="do/+C6N4"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39031E1DF2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742281715; cv=none; b=WqrnZONjA0GzWWnSoo9PxXNH1EadNVu1TdVfW4jMSONWeEhP7qV42cb6trbOvPWbPg7rmP9qfm44wkOun3fIGhxOGDFX7IUEtmZ8VhS9dmXju/l5bma7/yswnBTuBFBnlSHbdh0EZdy7mWW/f1SXYWVQT5nru1TOxJadjrf35HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742281715; c=relaxed/simple;
	bh=hgcxlwv3O7NysW0EO6K68ddrFRV8NY9JY1iGQ4+9MkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXWhEoaGs8gkAFD7ZEAa46GzGKlJkLMa6V2HlmKuUrEU4pn6QlfS/Lk2d1oz/olryXW8QIK55tg058Z8hoG2aU/uaDzK2uKRWNBu3Mvz58nHlqXH0+TWdbHGuYU/uylinfnj4NfYrVxs6WDVCh5+ZhtTAO1ZoO4jpW3Ebq8OPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=do/+C6N4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52I781gq903065
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 18 Mar 2025 00:08:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52I781gq903065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742281687;
	bh=Sd4vU2IUp/rXznzCP86w9b2ijtWSA1qOvMabai3LfQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=do/+C6N45Vhz9rLyCSRa4JdMGX5lFVDSXaJmzs0UecF+fbgXCu9dKeNsabRhMzGsf
	 FJSaVjko2ELOpEoeM7qdcM1RTesAuL3h5j5POU3yQWdX8FzGEIpO6pYHhpWBSrOxAN
	 MFLWlrJEnWacFzfyRp41YJJRSEeKURJN0aBiHGZY96Wy/PR9t94yYlTjUbIbVCmsG4
	 kzic+vjJDpywpLQXXDcpKhsbmqJkCsDSgL9qpgeBYpwaLCXLFYj6+LsAlUbYoftA2I
	 NAcp76gLnUbtUATwvgqIatuE2TTMrRx7cWRqPuaOewV5+1eik1TcjT1Z8NWR7A9syc
	 mmqCJ13nNOGEg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com
Subject: [PATCH v2 3/3] x86: Get rid of TOP_OF_KERNEL_STACK_PADDING on x86_64
Date: Tue, 18 Mar 2025 00:08:01 -0700
Message-ID: <20250318070801.903045-4-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318070801.903045-1-xin@zytor.com>
References: <20250318070801.903045-1-xin@zytor.com>
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
 arch/x86/include/asm/processor.h   |  6 ++++--
 arch/x86/include/asm/thread_info.h | 10 ----------
 arch/x86/kernel/process.c          |  3 +--
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cbb5d2158075..ab1f9cb19b71 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -656,8 +656,6 @@ extern unsigned long __end_init_stack[];
  */
 #define TOP_OF_INIT_STACK ((unsigned long)&__end_init_stack)
 
-#define task_top_of_stack(task) ((unsigned long)(task_pt_regs(task) + 1))
-
 /*
  * task_pt_regs() no longer converts a fixed offset from top of a task
  * kernel stack to a pt_regs structure pointer, but rather returns
@@ -672,6 +670,9 @@ extern unsigned long __end_init_stack[];
 #define task_pt_regs(task) ((task)->thread_info.user_pt_regs)
 
 #ifdef CONFIG_X86_32
+#define task_top_of_stack(task) ((unsigned long)task_stack_page(task) + THREAD_SIZE	\
+				 - TOP_OF_KERNEL_STACK_PADDING)
+
 #define INIT_THREAD  {							  \
 	.sp0			= TOP_OF_INIT_STACK,			  \
 	.sysenter_cs		= __KERNEL_CS,				  \
@@ -679,6 +680,7 @@ extern unsigned long __end_init_stack[];
 
 #else
 extern unsigned long __top_init_kernel_stack[];
+#define task_top_of_stack(task) ((unsigned long)task_stack_page(task) + THREAD_SIZE)
 
 #define INIT_THREAD {							\
 	.sp	= (unsigned long)&__top_init_kernel_stack,		\
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 4372f171c65f..8e9badd610bc 100644
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


