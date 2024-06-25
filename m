Return-Path: <linux-kernel+bounces-228277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B3915D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402031F22709
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC41E142E6F;
	Tue, 25 Jun 2024 04:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpozG22I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C41419A0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289151; cv=none; b=q65xhb5kmni9g30dPyQj4bc01MPl3vlyeJq/L4+LPZav3DKGqJt50WK0j0TGj6t3Ti4HPAc2CBMde/xyN9OWAIzC1o9MWny0KzAtI2QYxjrSPc4dLdJY9XY0wVrPcZrN3uVnpDZHmog6vw3mhWkRt9w7ljJAa7d13/sPSFwWmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289151; c=relaxed/simple;
	bh=DRenIR1h1uckRbamCPlOygD4TulcG8SHfUvGTveeorc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/+Ed3MJOXWnOOHQoBblGcoJvURd/GovX2ls+YyUuDKLgP+z/ET84fh0Y1gANWFkkS3UdYT6B+kUSddtCQAt7WGcwQvNOAwFMmhPiz/+6yW1Qa0QMiA/1qxl+pzaBhcuAagw4IEOivzj+5aNVLygdrJiBEW0E+dMNlnDcGpTNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpozG22I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F93CC4AF09;
	Tue, 25 Jun 2024 04:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719289150;
	bh=DRenIR1h1uckRbamCPlOygD4TulcG8SHfUvGTveeorc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YpozG22IEVA2nBqJ8c0xsbZt6uPkG5mxT2ifhOUxfWWnac5+tPiACBAcWM39RmioP
	 WAEp3VD2DsbwQ/h9ZTjWxVMH1tZ3Cf1o8lnm9vddSd8BJPc/EW5SxdOZb7p+JcGTfv
	 FtQ2CzUQdlD73BebltlmD75xZ0Xr6cOCwDW5z578rwoZN/2mqabQeVQ2EcrbH4ukK/
	 Sp0FKEHrsCvORglBeIDtt3mX3/ke4g3/aq1MA+0Hkf8hLAgR1my5jQYWl4xrXOGeae
	 wuCggyCvHUqWM6Vv7RI9FJddfZOIUT+7HCOX/iTXnN8b8STZcIKMfmLqYwEaCT+kyW
	 IbkiXTEg1mXKA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] riscv: uaccess: use 'asm goto output' for get_user
Date: Tue, 25 Jun 2024 12:05:00 +0800
Message-ID: <20240625040500.1788-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625040500.1788-1-jszhang@kernel.org>
References: <20240625040500.1788-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'asm goto output' generates noticeably better code since we don't need
to test the error etc, the exception just jumps to the error handling
directly.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/uaccess.h | 88 +++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index d8c44705b61d..d9c32b4f7d13 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -63,27 +63,54 @@
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
+	asm_goto_output(					\
+		"1:\n"						\
+		"	lw %0, %2\n"				\
+		"2:\n"						\
+		"	lw %1, %3\n"				\
+		_ASM_EXTABLE_UACCESS_ERR(1b, %l4, %0)		\
+		_ASM_EXTABLE_UACCESS_ERR(2b, %l4, %0)		\
+		: "=&r" (__lo), "=r" (__hi)			\
+		: "m" (__ptr[__LSW]), "m" (__ptr[__MSW])	\
+		: : label)
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
@@ -92,35 +119,51 @@ do {								\
 		"3:\n"						\
 		_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 3b, %0, %1)	\
 		_ASM_EXTABLE_UACCESS_ERR_ZERO(2b, 3b, %0, %1)	\
-		: "+r" (err), "=&r" (__lo), "=r" (__hi)		\
+		: "+r" (__gu8_err), "=&r" (__lo), "=r" (__hi)	\
 		: "m" (__ptr[__LSW]), "m" (__ptr[__MSW]));	\
-	if (err)						\
+	if (__gu8_err) {					\
 		__hi = 0;					\
+		goto label;					\
+	}							\
 	(x) = (__typeof__(x))((__typeof__((x)-(x)))(		\
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
@@ -145,13 +188,16 @@ do {								\
 ({								\
 	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
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
 
@@ -336,13 +382,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
-do {									\
-	long __kr_err = 0;						\
-									\
-	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
-	if (unlikely(__kr_err))						\
-		goto err_label;						\
-} while (0)
+	__get_user_nocheck(*((type *)(dst)), (type *)(src), err_label);
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
 	__put_user_nocheck(*((type *)(src)), (type *)(dst), err_label);
@@ -364,11 +404,9 @@ static inline void user_access_restore(unsigned long enabled) { }
 	__put_user_nocheck(x, (ptr), label);
 
 #define unsafe_get_user(x, ptr, label)	do {				\
-	long __kr_err = 0;						\
 	__inttype(*(ptr)) __gu_val;					\
-	__get_user_nocheck(__gu_val, (ptr), __kr_err);			\
+	__get_user_nocheck(__gu_val, (ptr), label);			\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
-	if (__kr_err) goto label;					\
 } while (0)
 
 /*
-- 
2.43.0


