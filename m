Return-Path: <linux-kernel+bounces-534592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81561A468E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3E47A4821
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9223643E;
	Wed, 26 Feb 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNnQu1MO"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51DD235BE8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593159; cv=none; b=qW8bCMrb3vHTaalunYmT6BurPWaQ45BMgcm5/+1fGiaFBU/G6GEqlEQkHVm5Jzik7EAhqcRNmGxbL7Xw6T2pDeUcDPxMVF1Xnytm3u6g5zmsvQixVDEqQ1L28EyA99TM0l12OAhpMehX5IDQKRfgOesEzfIolpJrCuOEiHHidsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593159; c=relaxed/simple;
	bh=y7qU9z7lgGcLUfd27np6xyc5Fks+vH2TibzUjRjdRHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTmt3jrlQxgP9wwHG0oAl0OOBIdm64tsWwcYS7ztuujegxpsz+sP1d9+tFixfQ8OtPq+uplYb5Ip7/FisWye+GoLSyU5e/LdGcfFGQekGGXna4Ar67OWqhMBCLjTFUXT/RHWPcTASE0FUGgF4xNmC8MFy21WpMGgtprWdCpZJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNnQu1MO; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5fcd665af4eso23579eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593156; x=1741197956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCuVEC58STAtilTMaj0CWifdxvlJ14gwFXexzm17na8=;
        b=GNnQu1MOm+icmQ/V469Cesj76KN/aSCIENIgGaEgyVgmC8oMEVM+VMc4RAE8qwYvOS
         b0Jh/jP+Wuj3M/USzSSyg8/9HBB2D/iSSooSR6gh2S6m5Kgx7vpNBlt+21kwpBv3Ml6d
         taXXJRE2JadI4Gn5VN308hzVEJhFRaeMZu5FnQFkS4ComUEMxcaXbO39R5Rl2SlFHJ2M
         jTFaIb6kNQXG2BGybJWlYhu88YzxNMy4OW/jFvNkQgb994+UEE6476/kErIDMCJ9ue10
         X0n3DY+uBhChihRRu9EEgS0pnQoNUzbhPfK07xBvRTpMKaAN2vL5AHHm1cFm7x2WEq1K
         uwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593156; x=1741197956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCuVEC58STAtilTMaj0CWifdxvlJ14gwFXexzm17na8=;
        b=oUcJHh6Nky3T1r8IN35Q7q+vPcf145SrOmS1eeIdnkR72xAh/0n9+IfWfc6jEiRaCG
         mDbeFFZUUmwHSu9F8QuHBHp1BeubjsaoBF2W8zakbQy1/4oVR+YdORIEoh/3vLsaF4a+
         jbf9+omh5+Ar8SixYNmd/cYboXWi07pQOAkRzWeGOBQVMPgXDYGwptyKDlDjfALqsaoz
         ZdudDpAbtV1ciWuUX57bLdDiYkyp4/9s5XeSULnunrt8HB4Grde2/UM9sJpUgtOucXLr
         s+x8VZ1IBAwQdNJu3TppLfYRhSaOyoCWq4FAvLhqet9W5khAnil43qMHKlJ0zK73zxDn
         S6fg==
X-Gm-Message-State: AOJu0Ywx8T4AsP8tUHj1nMWxXuPy49TJCwX+B4g05Y1aRW8CAeqz5iBG
	LAacUi87BCm3+dWcOURRfa+SiXtfHzSjoiKuvg31PIHPueSPbi2a3uAP
X-Gm-Gg: ASbGncufpkUgFQNcc3CXbpupoqjJOc2JswLTEtxQCpWlzTuHeN9XmQ2lpFkBOzqIcdE
	co4VClYgBhcgpShfTJujyoWlBUKiz0RpoNGC8y8fueVX3sk7W6HY9rrItVbyAS3y3z9Pq/XajMA
	tUs+lQvDkU08nAyYn4Kdqzx12ELQcoMegNQOYDw1rjJoG8FwtB5Bj37J+4E3jIirPS6zrfRJpjx
	9JoFZaBbFhFY9V1wgGlRAW0Nj5sbsNQfJSFN1LZdqWzoAtVWMf5qeZ28IDkbzQIpiiEqHXdMNia
	3u3Nvgs=
X-Google-Smtp-Source: AGHT+IH6mblwDIuISIBCJFBGnvcZ8OHaO+whcezMj+njDJfvbpYtOVoYKoE3kTgPGbUg495gGQPiXA==
X-Received: by 2002:a05:6820:1c93:b0:5fd:d5b:f46c with SMTP id 006d021491bc7-5fd1a456ca4mr13897942eaf.0.1740593156508;
        Wed, 26 Feb 2025 10:05:56 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:05:55 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 05/11] x86/retbleed: Move call depth to percpu hot section
Date: Wed, 26 Feb 2025 13:05:24 -0500
Message-ID: <20250226180531.1242429-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226180531.1242429-1-brgerst@gmail.com>
References: <20250226180531.1242429-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/current.h       |  3 ---
 arch/x86/include/asm/nospec-branch.h | 11 ++++++-----
 arch/x86/kernel/asm-offsets.c        |  3 ---
 arch/x86/kernel/cpu/common.c         |  8 ++++++++
 arch/x86/lib/retpoline.S             |  2 +-
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index f988462d8b69..8ba2c0f8bcaf 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -14,9 +14,6 @@ struct task_struct;
 
 struct pcpu_hot {
 	struct task_struct	*current_task;
-#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-	u64			call_depth;
-#endif
 	unsigned long		top_of_stack;
 	void			*hardirq_stack_ptr;
 	u16			softirq_pending;
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7e8bf78c03d5..a5602055bfc9 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -12,7 +12,6 @@
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
 #include <asm/percpu.h>
-#include <asm/current.h>
 
 /*
  * Call depth tracking for Intel SKL CPUs to address the RSB underflow
@@ -78,21 +77,21 @@
 #include <asm/asm-offsets.h>
 
 #define CREDIT_CALL_DEPTH					\
-	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+	movq	$-1, PER_CPU_VAR(__x86_call_depth);
 
 #define RESET_CALL_DEPTH					\
 	xor	%eax, %eax;					\
 	bts	$63, %rax;					\
-	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+	movq	%rax, PER_CPU_VAR(__x86_call_depth);
 
 #define RESET_CALL_DEPTH_FROM_CALL				\
 	movb	$0xfc, %al;					\
 	shl	$56, %rax;					\
-	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);	\
+	movq	%rax, PER_CPU_VAR(__x86_call_depth);		\
 	CALL_THUNKS_DEBUG_INC_CALLS
 
 #define INCREMENT_CALL_DEPTH					\
-	sarq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth);	\
+	sarq	$5, PER_CPU_VAR(__x86_call_depth);		\
 	CALL_THUNKS_DEBUG_INC_CALLS
 
 #else
@@ -388,6 +387,8 @@ extern void call_depth_return_thunk(void);
 		    __stringify(INCREMENT_CALL_DEPTH),		\
 		    X86_FEATURE_CALL_DEPTH)
 
+DECLARE_PER_CPU_CACHE_HOT(u64, __x86_call_depth);
+
 #ifdef CONFIG_CALL_THUNKS_DEBUG
 DECLARE_PER_CPU(u64, __x86_call_count);
 DECLARE_PER_CPU(u64, __x86_ret_count);
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index a98020bf31bb..6fae88f8ae1e 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -109,9 +109,6 @@ static void __used common(void)
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
 	OFFSET(X86_current_task, pcpu_hot, current_task);
-#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-	OFFSET(X86_call_depth, pcpu_hot, call_depth);
-#endif
 #if IS_ENABLED(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64)
 	/* Offset for fields in aria_ctx */
 	BLANK();
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1470f687f8d6..01f33fb86f05 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2025,6 +2025,14 @@ DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
 #ifdef CONFIG_X86_64
+/*
+ * Note: Do not make this dependant on CONFIG_MITIGATION_CALL_DEPTH_TRACKING
+ * so that this space is reserved in the hot cache section even when the
+ * mitigation is disabled.
+ */
+DEFINE_PER_CPU_CACHE_HOT(u64, __x86_call_depth);
+EXPORT_PER_CPU_SYMBOL(__x86_call_depth);
+
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 391059b2c6fb..04502e843de0 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -342,7 +342,7 @@ SYM_FUNC_START(call_depth_return_thunk)
 	 * case.
 	 */
 	CALL_THUNKS_DEBUG_INC_RETS
-	shlq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth)
+	shlq	$5, PER_CPU_VAR(__x86_call_depth)
 	jz	1f
 	ANNOTATE_UNRET_SAFE
 	ret
-- 
2.48.1


