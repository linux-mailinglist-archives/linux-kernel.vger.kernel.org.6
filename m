Return-Path: <linux-kernel+bounces-228276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEEE915D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9B91F226D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265EB14265E;
	Tue, 25 Jun 2024 04:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhGk98Mv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC813D608
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289150; cv=none; b=MuoKAElP+la67R70ygaFUJhCDovuJPxnWfBZNI3q+pDI45TMIhnBI4iytTVxmd9k1IvWfy/Rcm5SQmOSYCl1EyJZxWbNnosGXPPLNwjZG7h9X1D2f9I5onQIfheJqgjF2vyEW8UCCUz01UiDYWtBdumGqPxxphHeMBqaGUQqNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289150; c=relaxed/simple;
	bh=ZzlEc7s3uYpxeTkZStcoK6OMbfxXl2VXk7KZNHt3OpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBCfXnwbd+PENfHd63aOWcxbpohqAJPOdnpZ14bQ/6vaX7k0X9KkeiOQNAY8m+pRxN5FWuo8Cpg0K5M0BI+vBgJoR4pxN5trjK+vqKppKeBw2lhIGlxuhq34DSyry2pcVtuvm70yNHlij4B2ganIT8ZibCU7YVWA0t38kEUilzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhGk98Mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2927FC32782;
	Tue, 25 Jun 2024 04:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719289149;
	bh=ZzlEc7s3uYpxeTkZStcoK6OMbfxXl2VXk7KZNHt3OpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhGk98Mv6hs+xLaijlXJ/I4OLbsJW/jkS3axHL7EefamGHEOtW1ZtoJvCEg85A6XL
	 ItftEQ4YK4kTtKWFpCYEXezDscYbWPD3IzrXXzr5tKOecVnYIBSK/ojBHSr+B2y7C4
	 NfeS1uaz7Ayl1voJExBvwc+qq9qNvjMpiTJ8oDytePSBOTK4a5EFOuwdrvWoZqqZhN
	 JAkk4oz1BgQGcHR9zrfBIfqdrdAxPG8hJFdKN6nV42e8vOOKfEXjCIIlcUYIIpsK45
	 DGqRJScKzZV08XVnqphuA+74tE+WeSgl+r5K/FQmbw87cuDBK0FhEsifP3eKlUqCKL
	 dpsr6/4206wgw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] riscv: uaccess: use 'asm goto' for put_user()
Date: Tue, 25 Jun 2024 12:04:59 +0800
Message-ID: <20240625040500.1788-4-jszhang@kernel.org>
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

'asm goto' generates noticeably better code since we don't need to
test the error etc, the exception just jumps to the error handling
directly.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/uaccess.h | 68 +++++++++++++++-----------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 84b084e388a7..d8c44705b61d 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -181,61 +181,66 @@ do {								\
 		((x) = (__force __typeof__(x))0, -EFAULT);	\
 })
 
-#define __put_user_asm(insn, x, ptr, err)			\
+#define __put_user_asm(insn, x, ptr, label)			\
 do {								\
 	__typeof__(*(ptr)) __x = x;				\
-	__asm__ __volatile__ (					\
+	asm goto(						\
 		"1:\n"						\
-		"	" insn " %z1, %2\n"			\
-		"2:\n"						\
-		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %0)		\
-		: "+r" (err)			\
-		: "rJ" (__x), "m"(*(ptr)));					\
+		"	" insn " %z0, %1\n"			\
+		_ASM_EXTABLE(1b, %l2)				\
+		: : "rJ" (__x), "m"(*(ptr)) : : label);		\
 } while (0)
 
 #ifdef CONFIG_64BIT
-#define __put_user_8(x, ptr, err) \
-	__put_user_asm("sd", x, ptr, err)
+#define __put_user_8(x, ptr, label) \
+	__put_user_asm("sd", x, ptr, label)
 #else /* !CONFIG_64BIT */
-#define __put_user_8(x, ptr, err)				\
+#define __put_user_8(x, ptr, label)				\
 do {								\
 	u32 __user *__ptr = (u32 __user *)(ptr);		\
 	u64 __x = (__typeof__((x)-(x)))(x);			\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
-		"	sw %z1, %3\n"				\
+		"	sw %z0, %2\n"				\
 		"2:\n"						\
-		"	sw %z2, %4\n"				\
-		"3:\n"						\
-		_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %0)		\
-		_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %0)		\
-		: "+r" (err)					\
-		: "rJ" (__x), "rJ" (__x >> 32),			\
+		"	sw %z1, %3\n"				\
+		_ASM_EXTABLE(1b, %l4)				\
+		_ASM_EXTABLE(2b, %l4)				\
+		: : "rJ" (__x), "rJ" (__x >> 32),		\
 			"m" (__ptr[__LSW]),			\
-			"m" (__ptr[__MSW]));			\
+			"m" (__ptr[__MSW]) : : label);		\
 } while (0)
 #endif /* CONFIG_64BIT */
 
-#define __put_user_nocheck(x, __gu_ptr, __pu_err)					\
+#define __put_user_nocheck(x, __gu_ptr, label)			\
 do {								\
 	switch (sizeof(*__gu_ptr)) {				\
 	case 1:							\
-		__put_user_asm("sb", (x), __gu_ptr, __pu_err);	\
+		__put_user_asm("sb", (x), __gu_ptr, label);	\
 		break;						\
 	case 2:							\
-		__put_user_asm("sh", (x), __gu_ptr, __pu_err);	\
+		__put_user_asm("sh", (x), __gu_ptr, label);	\
 		break;						\
 	case 4:							\
-		__put_user_asm("sw", (x), __gu_ptr, __pu_err);	\
+		__put_user_asm("sw", (x), __gu_ptr, label);	\
 		break;						\
 	case 8:							\
-		__put_user_8((x), __gu_ptr, __pu_err);	\
+		__put_user_8((x), __gu_ptr, label);		\
 		break;						\
 	default:						\
 		BUILD_BUG();					\
 	}							\
 } while (0)
 
+#define __put_user_error(x, ptr, err)				\
+do {								\
+	__label__ err_label;					\
+	__put_user_nocheck(x, ptr, err_label);			\
+	break;							\
+err_label:							\
+	(err) = -EFAULT;					\
+} while (0)
+
 /**
  * __put_user: - Write a simple value into user space, with less checking.
  * @x:   Value to copy to user space.
@@ -266,7 +271,7 @@ do {								\
 	__chk_user_ptr(__gu_ptr);				\
 								\
 	__enable_user_access();					\
-	__put_user_nocheck(__val, __gu_ptr, __pu_err);		\
+	__put_user_error(__val, __gu_ptr, __pu_err);		\
 	__disable_user_access();				\
 								\
 	__pu_err;						\
@@ -340,13 +345,7 @@ do {									\
 } while (0)
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
-do {									\
-	long __kr_err = 0;						\
-									\
-	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
-	if (unlikely(__kr_err))						\
-		goto err_label;						\
-} while (0)
+	__put_user_nocheck(*((type *)(src)), (type *)(dst), err_label);
 
 static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
 {
@@ -361,11 +360,8 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 static inline unsigned long user_access_save(void) { return 0UL; }
 static inline void user_access_restore(unsigned long enabled) { }
 
-#define unsafe_put_user(x, ptr, label)	do {				\
-	long __kr_err = 0;						\
-	__put_user_nocheck(x, (ptr), __kr_err);				\
-	if (__kr_err) goto label;					\
-} while (0)
+#define unsafe_put_user(x, ptr, label)					\
+	__put_user_nocheck(x, (ptr), label);
 
 #define unsafe_get_user(x, ptr, label)	do {				\
 	long __kr_err = 0;						\
-- 
2.43.0


