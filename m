Return-Path: <linux-kernel+bounces-524948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF0A3E906
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC80A7A8929
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B381DFF7;
	Fri, 21 Feb 2025 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="FAFM9OXF"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F278F6E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096574; cv=none; b=YQ9ZgH60c7dXfR+tPtYCcsPZx14iab5vzgtKis/7WDcRP/2+NgySWOTUzvuG/MGnNXf8vLqdyQel1qbdlqCqMyV4oN6NJhhEFb/3ilIMpMP8UW7UxYvcne8UGwIvGQ4zgSJHc9Vh9R0/9g5vVrjiHgizEjT/19hkEONNXQmFIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096574; c=relaxed/simple;
	bh=CQzSTQWE4thoM09MiQ9gz19svPbcWrFRlVo+Hb+XTOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d31L03293W4w0v2pc79tPzZdwMOwOm8WXlT9rqK1V8gqyP0LEjmb9KDqQtb/nRijoM3EzC+SqZMsUoDpCzZ2MZhJ5mYwSAV2FVxoyyKQ4GrN1hcjSTU+lMkEs3QQXSAeesE8CFJbAYtckhzl/eME181BA1vbTsStabPtqobLlGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=FAFM9OXF; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f405e2c761so852640b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1740096571; x=1740701371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+knCqqnB60be5uWSQ10xJ1S6sb+4Be8XtAoVkEDcmKA=;
        b=FAFM9OXFf1EXC7sylAEZ2je/NSpuaNBCpt3OTasjyb9ScN0nymRGQbMhZe4k2UB420
         knhsz9CpHtVb3GwoCHuDM5ZlM7hAg7JCHoAoQPr2x0Z4FLQKoreyf6FSfHQakliPCNVi
         4aYFspia/nvPxSo6wYi+Vp7U4bfFo8HgsYp9wZLk3437lasUvaP0f5WiafpsSbV45h2s
         xzvKFa6uHGcnr+jsmmHZKBVp552g7exc61Vl2XyOjeZlxkP1i3WYOIS0Gw9gTpdb/wYp
         dMxokcz56ti6GRPHr6rH+dZ5IW1yORJO53SmzlsB9grIuOxK7l3xVqRWbSRtf516mhNy
         NiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096571; x=1740701371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+knCqqnB60be5uWSQ10xJ1S6sb+4Be8XtAoVkEDcmKA=;
        b=bxkySZxw4gUzzxb4AefEi1WVK3R87Yv+KQwyUMqFYj/ZVH/U5vqKQCFmfayWwd1x4g
         DvaG1vKG3OyLbN1ujaWdc0YQYEkjoTGnr0KKfQ5z4FrCe63wYToksY2dW9JxCEgH9HvW
         vVe3brW04Am5XR1USoBHBUMIkq+WdQPLdNptpWSaZr2S4xnHKOrICM4FV0VQCnSBrJkn
         ULN8fOrpN9i+rRdcPnbKwwN2d4u3y4xGKsh+2+DR7PTHT8C0E6+KJbrbJ2f0+423JMPd
         Qp36iXs+ilsVFXcvOpMwuAfJEXwlbu8MiYGrlW4BP/DoTbQ3wbkT5uZOfx+GmalwQbGA
         Xk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYNPP/IXIvhEE8EhlW5b0x1tjNk0DMKM2Q/nFmdrdHizDjCvFxxWljgxy0BCdaVrfTdenDepjoz6VGa7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxArkjmW/diwFHY1Qn425Vkel9+AdWLa9YZQdvOt5icr40h7k9w
	swTNh8WLQYa15vUdT4yQIvK3tikMMu/uXfNwbGNwHpVN8AoZC3HFbRrYYKmV5A==
X-Gm-Gg: ASbGncugnVpdvuBFUVDPNnmiVdQvper1xS2YnSRsAnxE+8BF5hvNo4mIiGNifAVcn3i
	9yWFXe+Sl+YCSkqW4ATzKQvP+Ij6qhBC9sCtpcz7WjgUgu6KYlMYFWwiyyUHW2qVxnmZfRL7sXJ
	s6a5myabdt5wiYlZwwQglNU/Mim8k250rMjhZdmWz1ln4oBshbCfZPaUzKfKL9MHWDs57nV0juZ
	+f3zIRU38rh2BYwyj0+J5aC8i65UANJzpovXJYMwVF6FtLvkbaD400sAy2fVPITMS1thfG83csY
	XfGfeK3+nAC9gwND+lMvZ85yU2Mx55x1+g==
X-Google-Smtp-Source: AGHT+IEMGnDVwYsV62cBocsB6VRb+qRff3a2UiPYmr/fXmxdBlq3NZLsTutH+x4Vzk0cSqwcF1F8Ow==
X-Received: by 2002:a05:6808:384e:b0:3f4:d61:36cf with SMTP id 5614622812f47-3f4247a204fmr1275951b6e.30.1740096571285;
        Thu, 20 Feb 2025 16:09:31 -0800 (PST)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f40b027906sm1573401b6e.42.2025.02.20.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:09:30 -0800 (PST)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com,
	charlie@rivosinc.com,
	jrtc27@jrtc27.com,
	ben.dooks@codethink.co.uk
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org
Subject: [PATCH v3 4/4] riscv: uaccess: use 'asm_goto_output' for get_user()
Date: Fri, 21 Feb 2025 00:09:24 +0000
Message-Id: <20250221000924.734006-5-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
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
 arch/riscv/include/asm/uaccess.h | 90 +++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 1b926b61af66..ab48ef57565e 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -96,27 +96,56 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm, unsigne
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
@@ -125,35 +154,51 @@ do {								\
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
@@ -178,13 +223,16 @@ do {								\
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
 
@@ -369,13 +417,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
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
@@ -401,11 +443,9 @@ static inline void user_access_restore(unsigned long enabled) { }
 	__put_user_nocheck(x, (ptr), label)
 
 #define unsafe_get_user(x, ptr, label)	do {				\
-	long __err = 0;							\
 	__inttype(*(ptr)) __gu_val;					\
-	__get_user_nocheck(__gu_val, (ptr), __err);			\
+	__get_user_nocheck(__gu_val, (ptr), label);			\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
-	if (__err) goto label;						\
 } while (0)
 
 #define unsafe_copy_loop(dst, src, len, type, label)				\
-- 
2.34.1


