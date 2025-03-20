Return-Path: <linux-kernel+bounces-570490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CE3A6B132
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD9F486F95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9922A4F8;
	Thu, 20 Mar 2025 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="DeHttRIq"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686422AE7F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510675; cv=none; b=BafX7FW8yT5v9ZGHcnqInMD2bUyTOCP8ffWF/MiPCiD+9zAA1V2nijLt68/vjYojzqI6dUcgrRTPfzZrz0PIxKmJ/iIzDGN2MSGGdIwZD2Uz36JJRb7QCOmFnLiVtxIUP1+6dYYBjBRAFx0CmsdtDCzLxaYDG9QFMrBaedyo4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510675; c=relaxed/simple;
	bh=/4Jn1Ns5m8J/PS8HTpLyGbF9ChF8Fk4/RvIEUizoI+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NXeW9k53QdWYorqs58dXhqEwrJm3UUfupje5uOYt8dJzKnIlh/c4FXDSsYj124zL2fpbfLl81OUJyWJi1Tadm5G/vSQS5YJNO4Lj32vek/TIuXUhopPPowPXXEM+PxUrJMbtfLGg6aa4cKhgD8L1+GxpYNHFL19wEpsTq3HII/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=DeHttRIq; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3fa0eb29cebso1475242b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742510672; x=1743115472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUM4cL2icpLrYe67mQWolXHTOhfxBr7CeU0SRh8tC7k=;
        b=DeHttRIqzYg1KebH4c5Rc2gr4ur2MPIAk3PXJCaXLfhIucGyDvriscnkhzWZAuw7g0
         FvJtIcGCPsglo98tlWo+1UiOBce9r9w+GiWHPR5agnLpvUtP+xYgUyqvAIt1FooQkaPu
         DfcHpRyw6wC8vgHAbIYqrET/IIVZG2LUC6XDxcJRky5SZJGRmaUJWofXpnbaKSE4xDY3
         PHDx745WVh5ezJ86tx+1zhLyTBgnLNdNEJ20X1jSkC783+5+gvuBcYTDKndIrXNE1wKT
         YKgXfb6IAeaHPpRHqiTiajCvp6INO0QiYE4B1UipDTIwsy9LtG7wWiLqo7M63s1TzGTn
         MYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510672; x=1743115472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUM4cL2icpLrYe67mQWolXHTOhfxBr7CeU0SRh8tC7k=;
        b=GvUj/sSizhJD5Ba1loTbuS7i6f8W+uHh3XXhcYvfmoU2xCgVMPZ0uhSdV/CfSnehUN
         Q1jM7WcEbOK+/PE0RgdxFB8hvVtVI1+bj3Jm9hPLckNR8BRrX4Fx9yO9WfB/cMHmj9Mx
         U0+AzTgYYXwykVULGMNsILyMUE56edrDmkAQI4MBSLFE2RS7luYZ0NMMVSoVsKCi7ELM
         Z2ektV4HGEfKJvnrDPcooHEUkojsRs2PM3N9vF2TUNeZNZCXSYyK6c6EgImcWNZaFioZ
         h8slx1By5mnMmeBbA7TLxT0Np//tvL846loigteqV3jn00qyVPmKFiK1nhTqasgixpic
         J0hw==
X-Forwarded-Encrypted: i=1; AJvYcCVGyOaRKpdrLnGRwjQTdtsd8cDmJTuKzzakC2n9a60z8OXopMF48q1fCvujgULu1YrdI3sqzZBq8nXitik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/oCCgAbV1/GplxZaDwXRV6YCF1qMuxROFLKrgjGgjJbXsLhGP
	uu1r7FbpFaHWQ0q/0d1qX17N/CHJaM2DyVzI19xNYKUn41jW0jonm4loxIh12g==
X-Gm-Gg: ASbGncvkjAPlHpQi6p3MC4qVH42K5LPxNzcnclYgK5ER8Fdaq+EKaiUMq3YtoEznfFB
	K1wISDZsbjH9eGhHPB8K0F8L0Z+FQMJF3WYuAmvYG8Ko6c3EN/Gte0jzZfLX223wrPKL+dB6JK9
	SNLL6+LMbMKTDnbo5/rfoe/DHDKH0mFyAG7V3wcypS+iRXOJC4+bxvYWGvLrQqr+uVPeYML0gVO
	KPLbHQPsr8wEUlM71NqxHTMI7N2RkcZGs0WfEQ3QcD6W8zxmp01cB+a8M3CaV+7eUxKadRZ37UT
	NSzPQ5p4riciVr2QArWLr/beUx5XSsrKQuvvBhtVvx6+atg2yWsXHR2/VVkzpCs=
X-Google-Smtp-Source: AGHT+IHChpwGgXIo7oPDkSwy3Z8aUFaMgcTSyEt/gVcKCBKfeFe7Livn0EfqfYGjYKQnsyWXdaZjLg==
X-Received: by 2002:a05:6808:444b:b0:3fa:10b4:698c with SMTP id 5614622812f47-3febeea9cf6mr1033217b6e.17.1742510672433;
        Thu, 20 Mar 2025 15:44:32 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6dcc09sm103524b6e.12.2025.03.20.15.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:44:31 -0700 (PDT)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com,
	charlie@rivosinc.com,
	jrtc27@jrtc27.com,
	ben.dooks@codethink.co.uk,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org
Subject: [PATCH v5 5/5] riscv: uaccess: use 'asm_goto_output' for get_user()
Date: Thu, 20 Mar 2025 22:44:23 +0000
Message-Id: <20250320224423.1838493-6-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320224423.1838493-1-cyrilbur@tenstorrent.com>
References: <20250320224423.1838493-1-cyrilbur@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jisheng Zhang <jszhang@kernel.org>

With 'asm goto' we don't need to test the error etc, the exception just
jumps to the error handling directly.

Unlike put_user(), get_user() must work around GCC bugs [1] when using
output clobbers in an asm goto statement.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921 # 1

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
[Cyril Bur: Rewritten commit message]
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
---
 arch/riscv/include/asm/uaccess.h | 95 +++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 719c9179a751..8823471b201f 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -96,27 +96,58 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm, unsigne
  * call.
  */
 
-#define __get_user_asm(insn, x, ptr, err)			\
+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+#define __get_user_asm(insn, x, ptr, label)			\
+	asm_goto_output(					\
+		"1:\n"						\
+		"	" insn " %0, %1\n"			\
+		_ASM_EXTABLE_UACCESS_ERR(1b, %l2, %0)		\
+		: "=&r" (x)					\
+		: "m" (*(ptr)) : : label)
+#else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+#define __get_user_asm(insn, x, ptr, label)			\
 do {								\
-	__typeof__(x) __x;					\
+	long __gua_err = 0;					\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
 		"	" insn " %1, %2\n"			\
 		"2:\n"						\
 		_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %0, %1)	\
-		: "+r" (err), "=&r" (__x)			\
+		: "+r" (__gua_err), "=&r" (x)			\
 		: "m" (*(ptr)));				\
-	(x) = __x;						\
+	if (__gua_err)						\
+		goto label;					\
 } while (0)
+#endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
 
 #ifdef CONFIG_64BIT
-#define __get_user_8(x, ptr, err) \
-	__get_user_asm("ld", x, ptr, err)
+#define __get_user_8(x, ptr, label) \
+	__get_user_asm("ld", x, ptr, label)
 #else /* !CONFIG_64BIT */
-#define __get_user_8(x, ptr, err)				\
+
+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+#define __get_user_8(x, ptr, label)				\
+	u32 __user *__ptr = (u32 __user *)(ptr);		\
+	u32 __lo, __hi;						\
+	asm_goto_output(					\
+		"1:\n"						\
+		"	lw %0, %2\n"				\
+		"2:\n"						\
+		"	lw %1, %3\n"				\
+		_ASM_EXTABLE_UACCESS_ERR(1b, %l4, %0)		\
+		_ASM_EXTABLE_UACCESS_ERR(2b, %l4, %0)		\
+		: "=&r" (__lo), "=r" (__hi)			\
+		: "m" (__ptr[__LSW]), "m" (__ptr[__MSW])	\
+		: : label)                                      \
+	(x) = (__typeof__(x))((__typeof__((x) - (x)))(		\
+		(((u64)__hi << 32) | __lo)));			\
+
+#else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+#define __get_user_8(x, ptr, label)				\
 do {								\
 	u32 __user *__ptr = (u32 __user *)(ptr);		\
 	u32 __lo, __hi;						\
+	long __gu8_err = 0;					\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
 		"	lw %1, %3\n"				\
@@ -125,35 +156,51 @@ do {								\
 		"3:\n"						\
 		_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 3b, %0, %1)	\
 		_ASM_EXTABLE_UACCESS_ERR_ZERO(2b, 3b, %0, %1)	\
-		: "+r" (err), "=&r" (__lo), "=r" (__hi)		\
+		: "+r" (__gu8_err), "=&r" (__lo), "=r" (__hi)	\
 		: "m" (__ptr[__LSW]), "m" (__ptr[__MSW]));	\
-	if (err)						\
+	if (__gu8_err) {					\
 		__hi = 0;					\
-	(x) = (__typeof__(x))((__typeof__((x)-(x)))(		\
+		goto label;					\
+	}							\
+	(x) = (__typeof__(x))((__typeof__((x) - (x)))(		\
 		(((u64)__hi << 32) | __lo)));			\
 } while (0)
+#endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+
 #endif /* CONFIG_64BIT */
 
-#define __get_user_nocheck(x, __gu_ptr, __gu_err)		\
+#define __get_user_nocheck(x, __gu_ptr, label)			\
 do {								\
 	switch (sizeof(*__gu_ptr)) {				\
 	case 1:							\
-		__get_user_asm("lb", (x), __gu_ptr, __gu_err);	\
+		__get_user_asm("lb", (x), __gu_ptr, label);	\
 		break;						\
 	case 2:							\
-		__get_user_asm("lh", (x), __gu_ptr, __gu_err);	\
+		__get_user_asm("lh", (x), __gu_ptr, label);	\
 		break;						\
 	case 4:							\
-		__get_user_asm("lw", (x), __gu_ptr, __gu_err);	\
+		__get_user_asm("lw", (x), __gu_ptr, label);	\
 		break;						\
 	case 8:							\
-		__get_user_8((x), __gu_ptr, __gu_err);	\
+		__get_user_8((x), __gu_ptr, label);		\
 		break;						\
 	default:						\
 		BUILD_BUG();					\
 	}							\
 } while (0)
 
+#define __get_user_error(x, ptr, err)					\
+do {									\
+	__label__ __gu_failed;						\
+									\
+	__get_user_nocheck(x, ptr, __gu_failed);			\
+		err = 0;						\
+		break;							\
+__gu_failed:								\
+		x = 0;							\
+		err = -EFAULT;						\
+} while (0)
+
 /**
  * __get_user: - Get a simple variable from user space, with less checking.
  * @x:   Variable to store result.
@@ -178,13 +225,16 @@ do {								\
 ({								\
 	const __typeof__(*(ptr)) __user *__gu_ptr = untagged_addr(ptr); \
 	long __gu_err = 0;					\
+	__typeof__(x) __gu_val;					\
 								\
 	__chk_user_ptr(__gu_ptr);				\
 								\
 	__enable_user_access();					\
-	__get_user_nocheck(x, __gu_ptr, __gu_err);		\
+	__get_user_error(__gu_val, __gu_ptr, __gu_err);		\
 	__disable_user_access();				\
 								\
+	(x) = __gu_val;						\
+								\
 	__gu_err;						\
 })
 
@@ -369,13 +419,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
-do {									\
-	long __kr_err = 0;						\
-									\
-	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
-	if (unlikely(__kr_err))						\
-		goto err_label;						\
-} while (0)
+	__get_user_nocheck(*((type *)(dst)), (type *)(src), err_label)
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
 	__put_user_nocheck(*((type *)(src)), (type *)(dst), err_label)
@@ -401,12 +445,9 @@ static inline void user_access_restore(unsigned long enabled) { }
 	__put_user_nocheck(x, (ptr), label)
 
 #define unsafe_get_user(x, ptr, label)	do {				\
-	long __err = 0;							\
 	__inttype(*(ptr)) __gu_val;					\
-	__get_user_nocheck(__gu_val, (ptr), __err);			\
+	__get_user_nocheck(__gu_val, (ptr), label);			\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
-	if (__err)							\
-		goto label;						\
 } while (0)
 
 #define unsafe_copy_loop(dst, src, len, type, op, label)		\
-- 
2.34.1


