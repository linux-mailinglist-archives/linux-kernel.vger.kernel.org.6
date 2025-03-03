Return-Path: <linux-kernel+bounces-542376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB4DA4C912
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95D817326C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C0025F786;
	Mon,  3 Mar 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfydUpP9"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE925E837
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020803; cv=none; b=PEzph+BAM4gHOq4zL4BZOh8bQj3lSTCgIJsNPhsltXyOWkKc8ADFkacAPHEw++pCP7pJItTgjgaFAHjW/i0djTojyAHLdBPvspq6wi8GgxbTkxA6zQFBEqKEc1jxwalLYWpOG7gJ7h+EDaQCUXVUNCZjz7BuqngVF7DKvWih5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020803; c=relaxed/simple;
	bh=OYJKRaVndOAwuJVwhaYRftxlVapFhnPm4xheG6tycvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRvP/WOSzI5+urQ/YzvrzmCXIhw/wKgiqFkgxkesgnkiA7JUxdtlBbp/ud5PUXAX4GMRDcq+PXeiAXaz1oi3ZKkU350AYkVEZO0yuFVeUUKp5qO8VSijj36QgyPRCkbnRLQahT1SVobNXOlC80SNxnzk8GAggbVvg5MvZ/adYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfydUpP9; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e89959f631so37337056d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020800; x=1741625600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnEWHldBFNu/D2mybRN/4ZjcO3DTEeclYWAdvriLmXo=;
        b=RfydUpP9KG0SyZ/gvvm1qLQPbLbBG3HFBSltIUQopIPCUyk9Xz++RdOUlhL7+OH4jN
         +p3KYGZUQ5JhAokt+43M3QuOoYAz7BfPFwrJYM7MmdhfUdDcWTvFrsJbdq9DrxJwfzs+
         VoVyD4mqM0Dl6RAeYKfSX92T1O3wj0b/fBDCprHsEZig6kuqPTqGHVUbDyUHwrhmOkm5
         KbaQNyU9v7YurB1pqSrKW5OLiC6oO+MmCqoval36qOYwMoJcfOxWKy2WfTpBgLuGLKF9
         ikEbEXy4MMl+UmsUpN4GV0daZUcQFPpIESd8sIpTn77qoA4klvFJ+PiuU8h2FzMrlteM
         0q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020800; x=1741625600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnEWHldBFNu/D2mybRN/4ZjcO3DTEeclYWAdvriLmXo=;
        b=rR99/DLyM6QeDWumwF5PwkyvUsT4dfm54AVax2eT/C+t8Pi7ILXFwheE4ep6qqBT/y
         RnXuDKEiiRgfykRXLDnfXhAyPBkxSnPyTryFy1kX30PEsx8Ui4rvg/v2LF+eTd9XIwIy
         DAHndzUwizjd0NSQ0W/jMCBOOzwTy7RGIxC/1m453x6ic1p3XVI8eP2kkeilmCMg3oFd
         Q/VOTKaS1FQ90CExuYvqgyX1mst7vLv/a9bDAnq76aYea2j3AV1J19An9gWdcSBloD1I
         wSkMU1EBT+WeHwAMcRJOmlhkEMldNthhzHra2eoDoe7VLPJOc48ouB3J36o3f6/+dTwl
         TLUQ==
X-Gm-Message-State: AOJu0YxeOrwj4wDPBDSxXOjoB6q6lW03e0/FukI4bw7z+vRrSqtkWIan
	EXP1Wrz5QEj+jzy/9XTpMIAtdrJhRquF9jEtLU8/ZoGM48TG+wRPV1Pb
X-Gm-Gg: ASbGncuhBX1w25riMbEdg24xCvWE978koYIHzp7Nd1CGO5ZroguAl3fuibWT1ipgkwq
	nOK6MePEqY2Ch3xzu2GWiFG/RBmm4eLzaFu5VZRt9Y5WWOp6lI934yumIpRseK/4phPWq2pOwVf
	wep5vAT9bVUyKFtk2qWqKFVFEje3GUXnuOu095yQYVeYag0TeK6gQ2hCmuAuwSYel4o8IEwPyum
	7dUF6ARSSrkg0RBPYd88BHpTYkgnj8AJ8t1784ipo533QeP4x83AYVu5nfld6kP6CIJWb+gYhFJ
	EA2lUrEsEn9DTeRmhoUzEjVXOw==
X-Google-Smtp-Source: AGHT+IGg/JwlRqTd6J4J4I9Fda9p3LYVTXmcE+NXXjiOh6O/ljL62wgmSfKtoYXIomj962qwjuhlNw==
X-Received: by 2002:a05:6214:2aad:b0:6e6:6c10:76fb with SMTP id 6a1803df08f44-6e8a0d28452mr213528196d6.25.1741020799889;
        Mon, 03 Mar 2025 08:53:19 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:18 -0800 (PST)
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
Subject: [PATCH v3 05/11] x86/retbleed: Move call depth to percpu hot section
Date: Mon,  3 Mar 2025 11:52:40 -0500
Message-ID: <20250303165246.2175811-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
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
index 99daafd5fee2..e8757d7a3582 100644
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
@@ -387,6 +386,8 @@ extern void call_depth_return_thunk(void);
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
index 8db36699dc78..f051fc90b44b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2060,6 +2060,14 @@ DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
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
index 038f49a43ab4..a26c43abd47d 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -343,7 +343,7 @@ SYM_FUNC_START(call_depth_return_thunk)
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


