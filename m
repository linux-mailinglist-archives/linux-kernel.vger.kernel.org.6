Return-Path: <linux-kernel+bounces-530950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B7A43A65
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D535618883D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7591D267722;
	Tue, 25 Feb 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkLTdvn3"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F932673AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477313; cv=none; b=umXvWH4t3QfyRQum5Yxo6mxhV/BtTnuCKKXTCCLmVupySQdFz0uSD8FHKS8FP5TbJXxLnZ6L10t2/huTMSN6xa+dZ0FjI2zYQSefyx2yXOWx7mRLvw4Vji7JUuI/3ffs7M4xlj+El/d4IugnU8PqDiTXO2fOftN59uWIoulIQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477313; c=relaxed/simple;
	bh=1//OcGv7gI8Rf5rDiwusdTiN/AV8oS31pnzMa0CmGQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNF6Lme2/t/YoBnXa4A/VpEZCRkxDLJKLCzhKL6/wMYbtKIu7d0o0sxa0bqgj8Y9b/xnV4k0pEXg2PFcL+SkKQIdYC93ft2+gCV4upYh9U+XvJBYk1sfbsGG0ZBa8s1aXtvL8wg5cE2BRhemHe3jtpbgJsqcgvA8R6312aV5Gs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YkLTdvn3; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5484fa1401cso1187198e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477310; x=1741082110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUy2L+59XSB2dO0W6jnqgQpUaRtZ0LvR6wu2Q9qABCw=;
        b=YkLTdvn39mAIvAXySe93CfiJukZxVsLhKOSvBj29d8f2sfxTK0w/tP1HbSjydH83kG
         Sv09j/rYODYu7Trgj8kpogjmpCO8a2W4I5dPIrw5+PsM4t69lA+reXgQwlyN7R2gS542
         egqxFZOivmr/JFpAle+yx+/gzLyINZOIPqwja6AUZ8cLzvMEmlCjAhWZb/enw2Z67s01
         HQOhiNeFLiRvkPskOypar0+okwmIF0KjkVVvsPm0fI4hCB3CuF4IQASuiwxIlgCKKG2v
         Tk2pdVGPv3jpBixZi5r1HQAUcJ++NMxYJoKVEe6OtQEVjoEImKO7rogcGP528j7iGUKo
         uwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477310; x=1741082110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUy2L+59XSB2dO0W6jnqgQpUaRtZ0LvR6wu2Q9qABCw=;
        b=hWnF1/r+Em5i9JvAdqIMAsUO6r8POR+hfEN95qGNDuN9B8K6QUHyh7KHLZuKa2N/fa
         ZEHywIuZ2tqnbypW1Led6Bpd92NRwOnoI+1HBEh3lSvaY001tQMM0OWSZgC5lU8L2zUi
         7vdfPZnxnEgDwN0OYF2RXZrg8S5oYemGdYmWp7Y5t3JsSxDFHHbAQUUTEJWIM6QiGoaP
         yCDziwiYMiBP5racE0Xss8flxgPsGe2eVIUL/Xr7l+lysQSZHiRPTt8enDLWR20xL0ts
         TTvwhF0+GXDafqCZBJb0MXxaecknuxoIAzTo/odULVQNwNmsPsWpY1xfgEAZSkHDEuHq
         0uVg==
X-Forwarded-Encrypted: i=1; AJvYcCVdKVIkYqOmNNME+9KSVqmXYemz+uUnN2hA6sUcNbhPCzJcpXNBpZlqcV6XTn5B86sbgGseIfJsYYu7oGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBcP55WCzDtYnLFRLx+Ta+tdLeAujZPLCztK/ihnsNzEF0CebD
	WBpuYJfFf7QRuFf9jbrT3Izjd33qO5umcXaoO/DEbQCb1r5PnSN1BUEGUWvqm9s=
X-Gm-Gg: ASbGncu5ISMXmdTSPX7JYl4x0PvQvugdDYw6L4YDCaypAoOxdgQRTnTrXJmnh414UpX
	a1EwKrMB3eCZ0VryIraifql8tOmaPDVKJntWpVr9J53hLU+y8zLk9cUcMPRhIFfUgFsGtNcVJKD
	CH3U/WewrvIiXVR3qjHEQLc11xru0Ei/ylkoYgQ/piHUzsGxvrGu58i+F3INzMxrs+wsT2Bjcts
	oF+UVMytolw3UgUkH8zSa01tvKHnuXmOhMXRVsP4IE4myjhJ9OF+TX77e4rGTL/Ndcnc/YkzFJS
	WMjjNkjinU2QIaDFqccKAZ1V2tmD+wRlef6Y
X-Google-Smtp-Source: AGHT+IF8cIBO3SlK9WGiwosYyqGfJqHooI+lszN8vN5QA7gNtCgUPpe2l1NosqypYf0ggr1xuNTUZw==
X-Received: by 2002:a05:6512:110d:b0:53e:383a:639a with SMTP id 2adb3069b0e04-54838f4e402mr7330345e87.37.1740477309978;
        Tue, 25 Feb 2025 01:55:09 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:08 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:56 +0100
Subject: [PATCH v5 09/31] ARM: entry: save the syscall sp in thread_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-9-2f02313653e5@linaro.org>
References: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
In-Reply-To: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
To: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

We are going to rewrite the syscall handling in C, which
means that the stack used by the call code is no longer
predicatably 8 bytes (for syscall arguments r4 and r5)
but a varying number of bytes depending on how nested the
C code is.

However the current code is just assuming it can rewind
the stack by adding 8 to sp if a syscall is interrupted by
a sigreturn call.

Solve this by storing the entry sp in the per-task
struct thread_info and use that in the sigreturn wrapper
instead. We already have the thread info available in
the SWI entry and sigreturn is probably not so common
that retrieveing a pointer to thread_info should affect
anything very much.

Storing this per-task in thread_info makes the solution
SMP robust.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/thread_info.h | 1 +
 arch/arm/kernel/asm-offsets.c      | 1 +
 arch/arm/kernel/entry-common.S     | 8 ++++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 943ffcf069d29cf4a035964d20d56f7ebdd6d602..d8a45c5a10496aaf806bfeaa0353d5e8985bd6f5 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -67,6 +67,7 @@ struct thread_info {
 	__u32			cpu_domain;	/* cpu domain */
 	struct cpu_context_save	cpu_context;	/* cpu context */
 	__u32			abi_syscall;	/* ABI type and syscall nr */
+	__u32			sp_syscall;	/* SP when entering syscall */
 	unsigned long		tp_value[2];	/* TLS registers */
 	union fp_state		fpstate __attribute__((aligned(8)));
 	union vfp_state		vfpstate;
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 4853875740d0fe61c6bbc32ddd9a16fa8d1fb530..c9525cbb26b73827821aa746030e56b037f49556 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -49,6 +49,7 @@ int main(void)
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
   DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
   DEFINE(TI_ABI_SYSCALL,	offsetof(struct thread_info, abi_syscall));
+  DEFINE(TI_SP_SYSCALL,		offsetof(struct thread_info, sp_syscall));
   DEFINE(TI_TP_VALUE,		offsetof(struct thread_info, tp_value));
   DEFINE(TI_FPSTATE,		offsetof(struct thread_info, fpstate));
 #ifdef CONFIG_VFP
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 3cfc6d952ff99be9c4c1be4481ac3039260e3e57..8baab7f97f59c434396f30b08ddd3029c5f9c0e5 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -232,6 +232,8 @@ ENTRY(vector_swi)
 
 	uaccess_disable tbl
 	get_thread_info tsk
+	/* Save a per-task copy of SP for sigreturn */
+	str	sp, [tsk, #TI_SP_SYSCALL]
 
 	adr	tbl, sys_call_table		@ load syscall table pointer
 
@@ -377,13 +379,15 @@ sys_syscall:
 ENDPROC(sys_syscall)
 
 sys_sigreturn_wrapper:
-		add	r0, sp, #S_OFF
+		get_thread_info tsk
+		ldr	r0, [tsk, #TI_SP_SYSCALL]	@ read back SP
 		mov	why, #0		@ prevent syscall restart handling
 		b	sys_sigreturn
 ENDPROC(sys_sigreturn_wrapper)
 
 sys_rt_sigreturn_wrapper:
-		add	r0, sp, #S_OFF
+		get_thread_info tsk
+		ldr	r0, [tsk, #TI_SP_SYSCALL]	@ read back SP
 		mov	why, #0		@ prevent syscall restart handling
 		b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)

-- 
2.48.1


