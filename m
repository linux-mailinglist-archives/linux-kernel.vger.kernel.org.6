Return-Path: <linux-kernel+bounces-511010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83405A324C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278C0165A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E120E01A;
	Wed, 12 Feb 2025 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLoeraVh"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F220D51D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359399; cv=none; b=Yf/w7/Oapq5FwHK51rhXHWTDYmhrXZyov5tojpK796lVbyKptbj+nP+U/1YTL7CCXNosI+SmjSPp8mZkEPKID2WqxQV499aNBwpohp1yszR/Cw96WKl6OG6pG3ZbAVmaLD4eiI+jUXuDPWwm9QtXdX+g8K9svupndKtkndR+/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359399; c=relaxed/simple;
	bh=1//OcGv7gI8Rf5rDiwusdTiN/AV8oS31pnzMa0CmGQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnXtE5+SGaH2KGo9VgNR4T/JXMk/3IMvCpK+lXetaeAF+zCAC3N65LIPZG+u/CWoJBrYxqNAO9UqN5LHCftypd12EQSKAPoTV124iQAFM7sivvO+XymVeu7cgc2Oopc+jKp0QzAgSN/CBmamU8smWfKMUFQk/GLYP0k8xmjzmtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lLoeraVh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-308f141518cso31072841fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359395; x=1739964195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUy2L+59XSB2dO0W6jnqgQpUaRtZ0LvR6wu2Q9qABCw=;
        b=lLoeraVhBlUS7fu0JC3aWUId7baQCUUhU5Q/3Apx3QHyA1OBLKyXFdK21jE+U8tnvD
         H0277KYTdJjigVdlgVzs1bHqAff18Q4aQxYSSFT8Z5wfH7VVdq8QJDSkOL8FQVnBc2Zj
         uYTXgiP8LsbHTHRHciJesZmKbRAkioWXG+A7i5wVOjVyUT40z2192JFObEW1mSkVsH3q
         4q2GSamKl5/TvZ5SfenBZugW4nw0yaQoS3wy3fwzm6uyR8w7RMsrLqRxN8eTBr7RdHjz
         tYO7n7zq+nWmYagyHJQRIqFeJAMtQl9xcaE7l+dGo6uw9MUvyAdTAlnykaMuVPkOYdx9
         lEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359395; x=1739964195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUy2L+59XSB2dO0W6jnqgQpUaRtZ0LvR6wu2Q9qABCw=;
        b=bERlE8Dq7mM6N0y1CsSPpO8HYSOvbrYpmp48uLZOL4zifdEVRoAa7zAQS+juGaEYZ6
         MUEvlGFMvSTnsID3nbS8NVZLh33NSrfkWBFpaLvU3vJ11uuQBk7/uD5CCBGhrnMdWEE0
         DAC8LR6ArIyuSuYs1b8qMO47VVCRLwydvmhRXG6QdQGW67Wch9FfG7EbcjlFlXI2aUeG
         e6SBA0ExovVh0y2SrzT27jQ1gHQshrARD/1/yh3SVS69lwXYcG0KDGsJyVNrTMTgqhJH
         egEhXxPLkklKX9eT5h5QPpHUIv8H1Ovg+nLRvNtijf99zqYCnoqM4rZ1dHemDXf9mV/j
         flyg==
X-Forwarded-Encrypted: i=1; AJvYcCXAmgyTJfvuGuYQHAQpCxQgr+s31JLursIRSK7KFwXDMOhyjBCRQmCJSzP+VN1XkRkx8muno2iTUzkDdVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylFUKCtArmCeTCN97WQM95q34m0pJprAnT3dIH38fs4ozVYuCw
	qp2UO1AFIdFZU8SW/jV2y4L+aJx7JDrahchdHJxhBKaZn4GWcpl5fsZ8StCOsQg=
X-Gm-Gg: ASbGncto6B0O/FcyaPQredujJv1dhoveX04tFI70pNLkOwgFN/MpsQTEv2kYfZ3f/F7
	VtO9H9yzqx31D/dJwFZgzz+7x+NfF69Y6UgTQW0bV4otpsEri4oapYfJJ+JBN9PSqWcU7kAiZXO
	SPrYIyDciQQ1loZDCKoS5zdD6ClgWQLhDwfFqH1FvR/omA1Vb4FND6xho3k6jH5+kbT/i8GHBVh
	lMI5YVOBqhlenFQjpFP01Fq8CVwhcPvvB++lkSdjWIggjWazrvfUvlznAJdPVna6NBf5d2nSPYR
	Yd6u0ZivGHiHFoEvkKw98XKYMQ==
X-Google-Smtp-Source: AGHT+IHZJ/tBIMRwnLsYcu+g9QAXHEyBK/NodAzDXyRtpuVQmFBcjHxeJrEL5OicySIl+6hJ7MT1qQ==
X-Received: by 2002:a05:651c:895:b0:308:efa4:d27f with SMTP id 38308e7fff4ca-30904fc98f2mr9827531fa.2.1739359395534;
        Wed, 12 Feb 2025 03:23:15 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:03 +0100
Subject: [PATCH v4 09/31] ARM: entry: save the syscall sp in thread_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-9-a457ff0a61d6@linaro.org>
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
In-Reply-To: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
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


