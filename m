Return-Path: <linux-kernel+bounces-570489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D5A6B131
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D2B9840A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA160224249;
	Thu, 20 Mar 2025 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Dic9Oet8"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909522A81D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510674; cv=none; b=dQJgWfnVvaJNoVQwGQSZS3CZXd/2OqDe8K1V2fQC3St3HS+DZqeOF6fZtDVmvet4kF6x0NwNPNaYnL5y1ZzI7WiEV8XplWKGynd4V3Cg8NT4IPUfd5DA/BbCnVMvl0tHTS/hZk5qn7eXRwTMLR3jPXNKWLioYfaIpM75GP5LkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510674; c=relaxed/simple;
	bh=6Rd4HzTmjSi8Wj2+T4c6yX3o6/8i9wfFJ0rHfw2fL5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnjpxrZfTNFuMJS34Sb/O6aaMIKqGNQ+CxVqLZHUMPwwxWEr/KKRY0suNGVsb6znsfZBduG6vTuEJM2U/RqFI8VQFP31cPg+P5l09zik8u8Y6oMQKxdbP702BvY92TMzH+ek5LYXYHwEj+cN7E296HaWg12bwDkQKIOB7B8BOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Dic9Oet8; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fea0363284so764396b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742510671; x=1743115471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpC/LMch4vBncOIb4H+uNBUj+A3evJlilB0f5X4S7k8=;
        b=Dic9Oet8Sshu46gibRue+HinZOLUFUx6Fd36fJqi7VyTKwXyzaSkbHd8FftkwrFkis
         5YIoRz95N2emZX58uMqVJ8lU16TfAfYx/5TJ76dJxtdiRj23/Tr4wKWdcRLASo2U/0+7
         pkHAMwBEsdzEAfPZ6bPh7Cw/MMy/EIi29dSKCJSX4bYm8Qk3RlWikA2GV2Vg1rbD//y3
         HEJ3h4TwIAyTh9S7at+in1UbQy60QJsxKOasj27er5sWZJy5mWfqTkEIb5Q2eUU0vvKJ
         +ES1GB/LLqH1PdToZOomw6yNn5Q9qhtbcksmDMMNP6KdMUzwx0+YSUmpZTKmt/cbI63O
         Ocqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510671; x=1743115471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpC/LMch4vBncOIb4H+uNBUj+A3evJlilB0f5X4S7k8=;
        b=VCV0BHJVOeF182+8wgRt5AwmJ5GEvxA69osixRdsL6lcUDq1+qcH8xAiRiIfCabnh9
         acF0kkRnGRJV79OPN3PtL39+Ffgy9b8I4nu5RW4sD8ZtGYty+1DMrt4H0UHiteMAo5r5
         ZgIXx0HS/NEWEw1ljTe4LWQ0D4udTJMdrkUbZz89mj4TlglIdeiF0b7g8j2xcsJxAIXy
         vMi5jL19TYZUQ8L6q/mVhMsiIjIUgqK226EFwTHWpVIFdN9BxCg/fsb43GFK7aISLXkn
         BsSYkeWeOxqkFp4Nm1caY0k6nRUMkwX+Rb77zc15x4zWS5A9o4RbyjIMqvdKSB5Uej+i
         TYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6EHd9ULO5fuY3Bt/2rpmX9tVPojGOFGheOup8gI0nym5oDdtKBRqwLgCUGsZHrnfzzn7idQ9po3OWW0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8O3sIVP1VBp3JWZ3tcLW3jWYXk7oX4Ufnad+GYAm6KRQWXpp
	CQbsO3N4Otu4wtUMLGt/EZrZzYRL+RlW3HsYaUfBw+YMlNlHJuseh8MZuAZ8LHisYafmXCaXiPH
	nTIyo
X-Gm-Gg: ASbGncs6hROb8E8cLEygPqEVJ7uZaKa0cvgEAWtgObKKYrxPuCFK7Nh69BssKVbt3SQ
	0dfIwuA/qS6kv8YXR6F3j0n8zUMhBh2QWrrqqdivxO7+4IHfVjh6KpDZEGMW8Q9gX4mj24uFoi7
	yMMVIMCzP9TZnK8PXu5cWAnGdygiKX9EVG0+ZrSrCe6J7dT/nalMsvts0ebS8BBSr0yVLLgvaUw
	tZWWwntM1wU1jzcVpcsdgS992hCxQV3+VQ6pmhc7I5m4mT2SBdu6v5WJqCPy3wxOKT+QArAQqdw
	VS37eIHiYVOIzBnxbA1cP73XZT3NBP2GLcnUOiX6Mwzxv5nu2FZqrOFJGxMEp8M=
X-Google-Smtp-Source: AGHT+IE2wGE2Be/0SH2O70UOpsv0bSUloPlhYCg9sxzfrbSR5xy7GPcyoBTaN4dfYwWSgd3IGSKcUA==
X-Received: by 2002:a05:6808:1814:b0:3f4:12a:8ca0 with SMTP id 5614622812f47-3febeda6d98mr810784b6e.4.1742510671178;
        Thu, 20 Mar 2025 15:44:31 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6dcc09sm103524b6e.12.2025.03.20.15.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:44:30 -0700 (PDT)
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
Subject: [PATCH v5 4/5] riscv: uaccess: use 'asm goto' for put_user()
Date: Thu, 20 Mar 2025 22:44:22 +0000
Message-Id: <20250320224423.1838493-5-cyrilbur@tenstorrent.com>
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
index da36057847f0..719c9179a751 100644
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


