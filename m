Return-Path: <linux-kernel+bounces-565536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDF1A66A34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0498E17CC16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9E1DFE0A;
	Tue, 18 Mar 2025 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="X9thB2Q9"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608E1DE89D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278524; cv=none; b=sIx2CwPsgHG420n0cQOZfdfv6ofghHWQ1BFGglNy3ykMH/cnSqxPY84338eCekaGbhYRwE/iFkYVBfhKFBzstoMbvzoNxZARbM/IxslwIZ309uhWACpjAFxcj0Kqpm5rnWd3Ay0YfuCAkO1sZTIHdSfjfkohvIzK+9n54CWaBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278524; c=relaxed/simple;
	bh=9kSVO3zTG7zUffAvq6P8vHARSpZiIby583v5HPyggrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yb/aS1HHulhckwwCBW7WjP+DLJi8elb8/i4bzwmR5wYOEXqpmha6cucq4XaGnesl4L3kZI0exK9LVSsGagzT00Hwh+IL1NBBrmiYSjUb49R+U7+v9tf8pKnNJaX/HzG2SLCiAd6x/Sj1BlVikDDxSLY2VE6Sq1UpU1pt0+q/pAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=X9thB2Q9; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f3da35555eso2727073b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742278522; x=1742883322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HccPZpbZyX4ghGGLQ1GggeTzIynZ7PXEL+v/MCdb8aI=;
        b=X9thB2Q9W7E15werWcEEJAwZ0a4u3FXHWZWih+a6S37i7Dg49eUbdAYLwk9/0Hi3PR
         jrwXnKfsrOcHuhBBtQCMZU5qT/3fh+6w63IfmQiNkAMstPb0l03ZvHgGKJ+ESoRoFIiF
         Vxeu7O9RMwlX08iQCQZryjJ5Z/UtlV3tAzsqIETEfuQBDe0fuq3ymE4qPHr0yzTcGOi2
         0+pT5OkOOqIu7D+jJhPzs0fc/xJgJ1s360CSHDHZLLoi6DGi0KZJxop4/QIMPrB0mP+k
         guPxE1HLTFWXIXzQS2mPTBvUtvV2SV2u7H+apg5E4OBeN1OO5BtIwlhyjtqenBWkXJHH
         /tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742278522; x=1742883322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HccPZpbZyX4ghGGLQ1GggeTzIynZ7PXEL+v/MCdb8aI=;
        b=hjb5DORQyHBd+gTInMH9aYWBtO0sPVUYM5d8HHO1ABUW4jikt7Nb0c5/HziGiWHE2i
         102teD7olf4J9jfhgJCz3nolnZyssp+DSil9g6nM4Wc3Z0W3RyYGnI1lYGjZDCsQsT48
         4IAXh1P/6SSKl3BLo6dxQ3jOZPdHm2mwlf4O4seMuYC99dB3BnhzYVVvFybgnyFo7OUg
         Y4rRKfOkjTOhotW3JhwOT+fgLWjcj5KOh52DWuEoXKt0ckroarZxlHJSgV5+1OIrBEiE
         NCrMTrogq4ngeINdxT/3XoSIDLkevAYvKWbRLuW2fdKmhNuLHi5TmbTV0SsHwrng1C59
         uqoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOEJovc5tkIsOfmn9BcjNO0EIRo/EYs+QcZUgBtz5A6ztEwuAKJg5YOobfqqazDqNNrA+97ZXgoDoprzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxucxb7hOiE+9UW7aGqC9h/aMT+TL2M2xJf/4I7vniyCmWJCyGC
	8PMhgRmGvIPdbzn0pyjINNL9zYX851lCidexMeV/+CllWDfKlnjcCz4ADxSaXw==
X-Gm-Gg: ASbGncufNRRXKHb3jvNARYfSlOaydvKTy8IEg3DhiI2OCo+NnZuNlsfPFrWudRhUkZ6
	nT7lCY7w7d/5F2JFlXCdrEqTXvWiJPE44tLTXU+nghunJQGbe/uC0u8duJvK/nVA6FgXuFWC7hP
	clfHI1WNq5+uBqvQ8jo4wssfW+6lBHyKCli4HJ6ay4QP08gNCflKJKDptjBVUaKgfH/pG74Ewp8
	5MBDcxCs1LMc9GBVMyxfL6JEy5Z4QcGOLdaJKNTXxYashdTdQjJ4WhHWsGv5A51hbwZql6KtWV0
	VDX36A5IVNsZDoF4rVl5QEtjBbOeJmg4MtvzZ9pbFhkbOPUa48EMu3us4nWi+28=
X-Google-Smtp-Source: AGHT+IHEfvBRTZGysFXmW3RRQXGtzyNoB5Q4apt6oGZu+ZdRy6GfL5mJC1oNgLlW5pjKpJDDbIHUXw==
X-Received: by 2002:a05:6808:201a:b0:3f6:7192:6aaf with SMTP id 5614622812f47-3fdeed0d9b8mr9357410b6e.22.1742278522205;
        Mon, 17 Mar 2025 23:15:22 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd403b882sm2051642b6e.8.2025.03.17.23.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:15:21 -0700 (PDT)
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
Subject: [PATCH v4 4/5] riscv: uaccess: use 'asm goto' for put_user()
Date: Tue, 18 Mar 2025 06:15:13 +0000
Message-Id: <20250318061514.1223111-5-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
References: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
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

Because there are no output clobbers which could trigger gcc bugs [1]
the use of asm_goto_output() macro is not necessary here. Not using
asm_goto_output() is desirable as the generated output asm will be
cleaner.

Use of the volatile keyword is redundant as per gcc 14.2.0 manual section
6.48.2.7 Goto Labels:
> Also note that an asm goto statement is always implicitly considered
  volatile.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921 # 1

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
[Cyril Bur: Rewritten commit message]
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
---
 arch/riscv/include/asm/uaccess.h | 71 +++++++++++++++-----------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 180d6e21d5b5..ab91dd2fa230 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -214,61 +214,66 @@ do {								\
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
-		: "+r" (err)					\
-		: "rJ" (__x), "m"(*(ptr)));			\
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
-	__asm__ __volatile__ (					\
+	asm goto(						\
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
@@ -299,7 +304,7 @@ do {								\
 	__chk_user_ptr(__gu_ptr);				\
 								\
 	__enable_user_access();					\
-	__put_user_nocheck(__val, __gu_ptr, __pu_err);		\
+	__put_user_error(__val, __gu_ptr, __pu_err);		\
 	__disable_user_access();				\
 								\
 	__pu_err;						\
@@ -373,13 +378,7 @@ do {									\
 } while (0)
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
-do {									\
-	long __kr_err = 0;						\
-									\
-	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
-	if (unlikely(__kr_err))						\
-		goto err_label;						\
-} while (0)
+	__put_user_nocheck(*((type *)(src)), (type *)(dst), err_label)
 
 static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
 {
@@ -398,12 +397,8 @@ static inline void user_access_restore(unsigned long enabled) { }
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
  */
-#define unsafe_put_user(x, ptr, label)	do {				\
-	long __err = 0;							\
-	__put_user_nocheck(x, (ptr), __err);				\
-	if (__err)							\
-		goto label;						\
-} while (0)
+#define unsafe_put_user(x, ptr, label)					\
+	__put_user_nocheck(x, (ptr), label)
 
 #define unsafe_get_user(x, ptr, label)	do {				\
 	long __err = 0;							\
-- 
2.34.1


