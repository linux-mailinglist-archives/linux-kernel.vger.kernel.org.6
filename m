Return-Path: <linux-kernel+bounces-413600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1789D1B85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 00:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA71F1F21D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372461EBFFF;
	Mon, 18 Nov 2024 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="ZIrQpp1f"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04DE1EABDD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970895; cv=none; b=PO/BaHgJETvSu2GjonOtZIO56Dn5XZ/i4/s+KA39+OlSi4EUg96KxYFO2WDOtfN7nxTqn1knBXCSRDSPosYXqDOqvvP7ycgYGVmFpzGi1R2ueP16dA6Ox0M0QXHXF0bncKLFoT6qTIKdGXnikDH24gEIgEy/uASl0kXAyoc+uMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970895; c=relaxed/simple;
	bh=3S7sE4A0QXcirClOQ2vojdJdjKT+8NfmgYnWPtv+jH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LA8tIicbLojFOCGSZq5Ytod2vTaDEw2ArgeECysI6Y3SoWO7PNmiKdOZPi8XsypDfxJY3ZjBqyweFHug+N/Z5zrIbrkMniAYQDLiExEdTUwqCxsj8MRenS3KDJL+Ieeezarr0ui7Q7A+pWZh8+PM+Vv1m932MQXk9VRg1uuSBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=ZIrQpp1f; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b155cca097so377817185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1731970893; x=1732575693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRVaI3mI4q3ET8HD94GPC1Sw1Gna7OqKIYTjZxZiUMo=;
        b=ZIrQpp1f/onlCGnZgN1041Vpie4+1LPfHpJhmt/43O4Hdu9I5sNlrHxyB23WiI/aaF
         DU2K0SAeUEUpUm3Uef+Bv7scS0+gFmvIzkvwcC/jW5qEY3MApGtpTqlW69MNPea3/TRA
         XuQERDZmwUpAW987c0bMH/Ssf+hWurhJRFbCfCHKJyZQ0GRxO/N3fVCZSfVY/FxnoKu0
         CipSshe8EbfTBU2DLsLS7VMbUB5BJO5DIquRYunS4zazRrcr9CRyd4FvN2CBEL414Nye
         RYdnQEF04kqG7lv1H6RJtAXv+Z9ST8xL8uM+VlnGt27wLBv+AEmRHAUUM9UXhs/qNcVE
         sxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970893; x=1732575693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRVaI3mI4q3ET8HD94GPC1Sw1Gna7OqKIYTjZxZiUMo=;
        b=VSfRhhu2sYjTCDkzuyl9B+ZxHeOFmdHZxzprR34aaJFdujJMZ4kGOo7taaRUCaOxbQ
         fEWlYXqZ6YbVAbBmoIlsUAxXJo2iEj3znQX2wshgpE6SkLwJYa7kF0t1wRZ7oiJgVB/v
         gdIwNNMOZkTQqWKUd7EiKRqTQqq9LPCIxGHFaSkR6zXAz+LE2xF5u/3mfAnZHy3xDC8l
         0ch5sGfiGZfx1evcn4jVFkJ829P8b8LRh7F2wkJ/CiYf3J8SBjXI6Lx8dJGcDjiTIufC
         A3sTXyOB4sQRWEUFbQ379dN+oqm+/lYxelX6rO4GIe8DZ3/gIjKnIiEDoa9mEOf07pMn
         ai2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQBy7K657Wj2x+ci3PWrXMk+DpmE6ZVJ40jbeQuA8nlUiQi6D+A75sbes97BjRrWMsOzUhbh+Dcsc5sN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1K03z2ZvqU4aPdIt+4Pe8bxZUNQxRYf7M8Y9XUeUAjAUcwNmh
	8ZAOXEV+PJnNKklWLsO6i2ygTwIMY00/QvROw7+TRn2N+CG74jJzbhPTU56mqQ==
X-Google-Smtp-Source: AGHT+IFgOZgADD9g2Yv8LNg2iDmTl9fW41NRsj+KmA2TQmL8rOOG21P3+sAEG4+q3wXTJbLeh7WvWQ==
X-Received: by 2002:a05:620a:8006:b0:7b2:fa17:f7d7 with SMTP id af79cd13be357-7b37aa0dc7amr185728085a.6.1731970892669;
        Mon, 18 Nov 2024 15:01:32 -0800 (PST)
Received: from aus-ird.local.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a897eebsm35344185a.94.2024.11.18.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 15:01:32 -0800 (PST)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v2 4/4] riscv: uaccess: use 'asm goto output' for get_user
Date: Mon, 18 Nov 2024 23:01:12 +0000
Message-Id: <20241118230112.2872978-5-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118230112.2872978-1-cyrilbur@tenstorrent.com>
References: <20241118230112.2872978-1-cyrilbur@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jisheng Zhang <jszhang@kernel.org>

'asm goto output' generates noticeably better code since we don't need
to test the error etc, the exception just jumps to the error handling
directly.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
---
 arch/riscv/include/asm/uaccess.h | 90 +++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 916df594ef3c..62a2ddf8c542 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -63,27 +63,56 @@
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
@@ -92,35 +121,51 @@ do {								\
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
@@ -145,13 +190,16 @@ do {								\
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
 
@@ -336,13 +384,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
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
@@ -364,11 +406,9 @@ static inline void user_access_restore(unsigned long enabled) { }
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
2.34.1


