Return-Path: <linux-kernel+bounces-413599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA599D1B82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 00:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D2B1F21EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360051EBA09;
	Mon, 18 Nov 2024 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="VnK2OiCA"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E61EABC0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970894; cv=none; b=q5y0xU7HUC4vYhsJXP1lnsY9fMVmpEngxKPxRM8QYe27BNOWJfAblLyriopc7O0Gylz+jaT3m/GyT9mBRrBGs1aYBvvcpI/6xCVcCNW7SKub4ek0d2l3dfBsTAqGZtxFJrWGi/uu3ugH/sbU+V47iKAl2HOgNxdcQTWzd7F/9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970894; c=relaxed/simple;
	bh=vz/CsLoB3Axx776+m0RBpN204Gas1MIZUEQJapwqFKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+HJ4QJ23J9RxKHACiVDvQgIx2FXPooq6qIo2hR5pGou0mIfuT2Q+5oaD+JqbzucvNsfGoAC4ys9fiMtBL7yK2wFM0w1IZB7VKrUdWGViPMjlkS3/B+nDa2APu69YAsgCaBZ4dfdTj31YIxFPj5mOh0lbwpOtmT7d9gzlgU/SIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=VnK2OiCA; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b152a923a3so252608885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1731970892; x=1732575692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwX5scsTVfAnPzy5utpE8/PcuRTXCsQPKfCiUnW9jEk=;
        b=VnK2OiCAqFu41HyLpthT+P55AV1O8pCNfvWXgGD42X7tHdTcNdG0avnJUWRwfH35kA
         pPALPLpTvGrslUi29nuOB45OgOaIQeNh1YpuvQrFRKInPjXyUf5RYQpGRLRbu5/S/6WM
         e3y7cHSn3i0OGa3vOdfHp4VJ9M/p0JBls8UucvJCSSXdBKZsbiFGyY4n1nLg+eqow0Nd
         /09uiRn96GMZRnkQZdpQAw+r9krCtukOYSVqXdTJmww8i4kTk4gUIDCgBAxXQT7dUWzC
         OynjMg/wTkMsDr4ippZDN50C7swNL20XL9jVoNOhF0fQbwFXHeRiqzoBLtjp+RkM0ERt
         0XTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970892; x=1732575692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwX5scsTVfAnPzy5utpE8/PcuRTXCsQPKfCiUnW9jEk=;
        b=H219V5tq5YFXjLOajYvfBEtYWHg7w3l/uff9Cl3eFyK1TOS/AunzTJgPElaUXrCnHt
         zrq412+pf9UeZXei5JhW4ydoYcU10WfyKFhui6AygYS2uAXeMaj1UYRvUBu4f/y1rJKW
         4heL+m2XzcC4ua290Noob0xcVouE4FqHYGy5daBQ0UqopLI+tu/jmiKdIMrdpktxMnBb
         NE99rdf5PtMt7XDJkz2xHiWRbZ/ndYnIdHS7JH6XIuVNxtql1+zIwxzYDPaIu2lqtDNp
         dPk1NVIUQudFGbtflgKxMr9YicDPiC+0Sj5ED9ybNQPHn95B8zM9GWJgrObFBvth+S5g
         z2hw==
X-Forwarded-Encrypted: i=1; AJvYcCUjnqNcpNO63g21Sjp4HNARUHHPlZiQc8zlK9yjBwSGmq/vU3obgdbxaW0ZvpLq+46np96GrDpjeoK5ON0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9ZoM8SJ99Jn1F61Ytk4nM5qm7sJCgmzUev4apHmTS9AKz/tU
	uhrxPXGGX4e1TIRMJnW8QAhxKEuwMF84L/PNbdIKfmgcPNZf+hNZ5GD0kjbZCg==
X-Google-Smtp-Source: AGHT+IFmUQ6Alw6TgMZvuOtrCvlZCP/drMIJBLXEykYvSL6Eocpr3m7d3KptR1usfQOxg1R4KAxCyg==
X-Received: by 2002:a05:620a:4714:b0:7b1:8e09:5119 with SMTP id af79cd13be357-7b3622a57e4mr1938760285a.2.1731970891735;
        Mon, 18 Nov 2024 15:01:31 -0800 (PST)
Received: from aus-ird.local.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a897eebsm35344185a.94.2024.11.18.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 15:01:31 -0800 (PST)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v2 3/4] riscv: uaccess: use 'asm goto' for put_user()
Date: Mon, 18 Nov 2024 23:01:11 +0000
Message-Id: <20241118230112.2872978-4-cyrilbur@tenstorrent.com>
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

'asm goto' generates noticeably better code since we don't need to
test the error etc, the exception just jumps to the error handling
directly.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
---
 arch/riscv/include/asm/uaccess.h | 70 +++++++++++++++-----------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 84b084e388a7..916df594ef3c 100644
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
2.34.1


