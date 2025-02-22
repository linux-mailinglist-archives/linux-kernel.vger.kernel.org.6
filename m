Return-Path: <linux-kernel+bounces-527427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D516A40B1A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF7E189F727
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8132135BC;
	Sat, 22 Feb 2025 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwQ59tSI"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B1213232
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251207; cv=none; b=lAm3IedyfwttiMZ4kscpN5bX62u7t768KWEELmURmnif0EM9fLCtRUGhk2SGW4MtfDGP5ll5+pq66G2y5KetrYNL8gsnECqn7wWFG143g+q8z3jXmr/3sJ1hNBc+EYvOlWDuYOo8xHR+GrWbV8yBZO0g6PGpStK55vZC+eek8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251207; c=relaxed/simple;
	bh=MEFNrN3i/2AaKco1k/9HpXbv7F2of2F4/2qWL9sh8oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdIi676fnkCzOLu+KeqeuaJ5VD/lGevIH+lIxQVkHV20J2zBoZKzT5qrkwFa82Y0RP/rc4uy17YSauK0lWi/4vEkedSuRykSlwu9Q0O9XTBneWVmCH46JtutoOZ631FWGJzbQrjd4SzFf2rULV+Zx2S+1Sc+y0V1XKmJpDUNdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwQ59tSI; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0ba9825e9so201452285a.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251204; x=1740856004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9GIY+0lnUqZnRfDg+g6eHAlVXI9z0IE0EDIxYSYxYc=;
        b=QwQ59tSITRnihbFmmzmb5DRHD19VV+x6iVFCnKP6qBicXFpBdp+kJb542DvAkliQAb
         ydqN7xkrZRzAggG1iTGUgFmOZnBPJPhjAfh1TtY50d2JSVJHBLiDz2Mxro3f18WEojqq
         T5SPMIpjMhgaoPe+emCKBt/0yCmAWR3yQixegqE4EWxUZPdFbUpB3Y4r/yVLwuA6wQCx
         ZDPEem3kfmjND8XblGuX79WwrlB+cFnhcTNrGC+FBMixJ8MlD4OAO33I/lLmFF1rRARw
         shcIGuyg3sveJoByOaL9MUd5CiIphH419mA5/qTo7PyqHeon0EBGF2ZVeBx8MH72ufUs
         ZqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251204; x=1740856004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9GIY+0lnUqZnRfDg+g6eHAlVXI9z0IE0EDIxYSYxYc=;
        b=U2f8mwsN99n6js7AN330UZkWMIcQh1J6WAwsy2BHGpk6lS/0Bd/8xQJA3faaPHN/eA
         bEyUhroB+NNwRNBnjSkWZbGawYtk3d/n3iFYqI0JEgM606EDJSj3wVZZ8h303vIOJzqX
         D3Fn19HFHdj0zo2JApJJ4+Xwsqe+1H7rk+e0osg6YQnkwHZeoHOXYoT5bzMaI7ti5AJV
         ulmyTsWTe/2paWsfcbWkgDhhiIhrdTPufVbXjWvg1DqkBJiys7CP3P2Yl3zaQa7szQyn
         tlpBGnofMQprix8SJM43fyNaRIK/7uVl529V3kjPUfMVSKuYMjYbLpCEtTo5R3z4Q/gN
         IUFQ==
X-Gm-Message-State: AOJu0YxfvrbwchPMKVVDW8Pr7oTpcyayzX4F0mzIfD6ejB6U4+wLzluK
	FN7Gmqt5HXVQ6V6iasx1F1KkyqlHV5XCIxZRo1QIbXiU3Xp4wEqTvJ91
X-Gm-Gg: ASbGncuF/53PAfDtKEYWrxE61/rfiNibKzDIPg8tDDL7nHFTGKUK308zYEKukAwewXH
	zjqP3bfJyzcIv3R9tp27GmaOwthCbM4fUcwxOpJQclrDMYfHrlIPd1bKt99KC99TeM5ZTn0D/yP
	sWHTzhk6hfEbRfZljJke9v0bsR0g1amwmbwngkZ2UXtuO7sr+3RRbz4BUU+2aF/U+ICH98MtP4j
	//8Wp8FcLSP5tU1v41KqbiJ4GMcm8j+ZTIebFZiBksyQc3RW1kLV+FSJLKWBGz+EQ0Zzmnu6gxl
	CP1zPHg=
X-Google-Smtp-Source: AGHT+IG7+CewSHiEKQLMuuTRv8biNJ3hb9nw9N0yOAiP9fFpvFp5GbMxkkMiXBDHYxq7al086WXRxw==
X-Received: by 2002:a05:620a:1787:b0:7c0:af16:b4b5 with SMTP id af79cd13be357-7c0ceeeb53dmr1275755585a.6.1740251204017;
        Sat, 22 Feb 2025 11:06:44 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:42 -0800 (PST)
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
Subject: [RFC PATCH 04/11] x86/retbleed: Move call depth to percpu hot section
Date: Sat, 22 Feb 2025 14:06:16 -0500
Message-ID: <20250222190623.262689-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222190623.262689-1-brgerst@gmail.com>
References: <20250222190623.262689-1-brgerst@gmail.com>
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
 arch/x86/include/asm/nospec-branch.h | 10 ++++++----
 arch/x86/kernel/asm-offsets.c        |  3 ---
 arch/x86/kernel/callthunks.c         |  3 +++
 arch/x86/lib/retpoline.S             |  2 +-
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 119099431c76..fbc7eb92adb2 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -16,9 +16,6 @@ struct pcpu_hot {
 	union {
 		struct {
 			struct task_struct	*current_task;
-#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-			u64			call_depth;
-#endif
 			unsigned long		top_of_stack;
 			void			*hardirq_stack_ptr;
 			u16			softirq_pending;
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7e8bf78c03d5..8441d1da5382 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -78,21 +78,21 @@
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
@@ -388,6 +388,8 @@ extern void call_depth_return_thunk(void);
 		    __stringify(INCREMENT_CALL_DEPTH),		\
 		    X86_FEATURE_CALL_DEPTH)
 
+DECLARE_PER_CPU_HOT(u64, __x86_call_depth);
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
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 8418a892d195..7032d4caf242 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -39,6 +39,9 @@ static int __init debug_thunks(char *str)
 }
 __setup("debug-callthunks", debug_thunks);
 
+DEFINE_PER_CPU_HOT(u64, __x86_call_depth);
+EXPORT_PER_CPU_SYMBOL(__x86_call_depth);
+
 #ifdef CONFIG_CALL_THUNKS_DEBUG
 DEFINE_PER_CPU(u64, __x86_call_count);
 DEFINE_PER_CPU(u64, __x86_ret_count);
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


