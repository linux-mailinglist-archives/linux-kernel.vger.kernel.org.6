Return-Path: <linux-kernel+bounces-565537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47641A66A35
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B4617CCBB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE71B85D1;
	Tue, 18 Mar 2025 06:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="EIAfLQ4D"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13FA1DF263
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278526; cv=none; b=Pv3imnNpcdthWkbkqTUR5KY+u+gcpVwl+bhKE/dQExKzVgaevhh1vBPQ7g0F+18mpadhevjVIWuhsESnbjAvAMfuUGIXFhQdzFHetHtu+cF9ReYGqCrI5bCpbGSkFVgDOezIZBzvKgrwxqQOxRu+uXW6eRWHMfDqNHTPbx0cxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278526; c=relaxed/simple;
	bh=pgpE4cukBlxGicXc0bp7gSGepbKSiUK/JKJ8Zip6/lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZ+QJ7Oyv0r9OvzbvqHh9ByVYNU5Orv/4nVmlYVioIHP5K2ro8dtgVMSyL+I+IcGzfe+13WmVhosgye1rBtX7LqKGbbkbguuuk15uGCTOcED+tP6wWs/dptWboMqi7CYiYdNJlgGLjhP720cvJNf4q7ZSbsaTp7fE1d05sa+8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=EIAfLQ4D; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f682a2c3c8so3019366b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742278523; x=1742883323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB88SWzbKOqS560oNmcGvhVMbrzNnGmMk8r7GYi48TU=;
        b=EIAfLQ4D120I2VEXwtijdORoxc3AYndf72ZtXVpQPM2PS1kWX5fm1reiKnPZFSA6EG
         7iDFflLwQquabEt9lfJKvu592FwC8yW89wVkcEB6luwft1me311BRgjXv1SVh3CtaZXI
         1PS+uBWN/g8FbSyf5dIdterDb0ACyoVpSz0CdksKUsnhLXoMxHAVaSvAbRJGLfIfVQx5
         Acwb6uwHDb51hApllQ3vAOScBkXUooGKgFJJoj0R7RwhN9cTLEhJUqk0dYfoyU8ccp7v
         IX32KhwaMna18a1eUO2gqtCSmbc7Q3zLVY3U/7PzHqLrci72/FsduovouJ+IF89EsKiH
         aNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742278523; x=1742883323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB88SWzbKOqS560oNmcGvhVMbrzNnGmMk8r7GYi48TU=;
        b=W3ld/UpROmoa8t4WyR1cLlbVCeb9TUEmwYCggYLGgYUYtLt4sozS2KRxx+dTHnXPaj
         HWokz3HELVzJuvN0oSlY7gMs5HCWEzTSl7DeddBbGPAbnC33bk0nqdVq4/1GAYOvY2qW
         cJnQb31+xdIOzcS3bKkdeGw1Y2SCjHrECOdu/Ba0YFesM0+bLt4i/OFTfEVc1RBhl04y
         FBm6L/ZI6tqRHz/UFMp2xm4URL2lsmQHuivWa8E5NbN9JQG1mDaFg9BGfJHH2Z0BZLeT
         tHibDbGx8zuILuxou9sy4I+E1W275nXGQsE030p77EJBopeYendNmFdHMv21xDK3UAbH
         Cohw==
X-Forwarded-Encrypted: i=1; AJvYcCXZHeGsyddhIBx8C+vxh8GHYDSsN3iQ4w2+1oDEgB4UYgZMumjpCuTx7bG8GxjbSG521vohSGUYaVjuyNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytngcbNLo6Tak59jeJAbyRL8kIwirrRPRgE2s1lffoZo3sMGci
	oLJ0w5klRy31iYp55Im1gfQ9fNEDNjTmKJT67QaMPvVB5XzK6hFRmCMvIh9LPw==
X-Gm-Gg: ASbGncsvtoxHQ1F3bY+ghtvt1D5W6DLgcKWwKHBiaGF6KlpFyJ4Iw/CuFp9qNdrL9Eo
	KpNVS3aiFTE/DMUeDZcm4YasSFT4tVzYkjNh6dSVIjsfxLS0iqix/U+11mUFQHb/jMgy/SAp7OJ
	ZQ4DBUZxCQbE86D3uhKMafE/olafxxc27YiiHvZDV8TjP3KzYYq6nvxu59+ek1ygAq3x6yQK3Vz
	RAIMGdGLn0B+NX85Ww2lxzP08tYYbndK9b31FdgAa5Ihz/wk63ROfVnx9qN1x21C9V9vgXT3HEl
	bifRJ+r5JfCrw/I4xllqX/8cZohiNB84RV4l+EdNZifNlWQuzLm3AKfILfV3fDw=
X-Google-Smtp-Source: AGHT+IG5rNTfQnLxyptciRc/2MpA8tF5u7O/A4GY0S1qU3Z6Z6RSpie2GzJANFt/uJHp/UYORqcpgQ==
X-Received: by 2002:a05:6808:f05:b0:3fb:3be7:ac9c with SMTP id 5614622812f47-3fdf0081260mr8892498b6e.30.1742278523672;
        Mon, 17 Mar 2025 23:15:23 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd403b882sm2051642b6e.8.2025.03.17.23.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:15:22 -0700 (PDT)
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
Subject: [PATCH v4 5/5] riscv: uaccess: use 'asm_goto_output' for get_user()
Date: Tue, 18 Mar 2025 06:15:14 +0000
Message-Id: <20250318061514.1223111-6-cyrilbur@tenstorrent.com>
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
index ab91dd2fa230..ef693aca5236 100644
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


