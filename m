Return-Path: <linux-kernel+bounces-524947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3ADA3E905
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2A517E742
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BBAA31;
	Fri, 21 Feb 2025 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="YPZYIaUM"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C433CA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096572; cv=none; b=GfibyyB93tNo9c9tUr3g9Xx09TQ6AWyuTFxUQ5yDEjwvT+t0TZ0iB9wQgVOmMwQ0LH74Fw40XDDhMH074YC9nziom1Yl06A5lgufFNh5HEZgOevtGGTJvB8AGfdbsBNCZC7zSoDsL5oiNxmYsJTlSlx3Aap+LbDtiazvaqutjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096572; c=relaxed/simple;
	bh=SQw27djHYUdQ5oODFTiumWVTyisqpnqd4IqqlvAk8oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgnDhI0TcVbYZzHynZ3qJgjZiiu9W7V6kKuHekHxtpK7LFv5BlbkOcVVpam2e0IE3sVpkZSETkWp9NB1ehWOqZJVDh6xfacgptIs6jc1cpgwBrjlJv3qdpvicT4X6cIr1tUheiO7+LzH6kiqgXKOgRoawSsCpaxJrZZDYolxB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=YPZYIaUM; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fa9778fa2cso744106eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1740096570; x=1740701370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5hM23iRroiayTpV3ONpzy5pooTVMbj1TF8BFXhb4r4=;
        b=YPZYIaUMJb6lBeQ6mpvVMI533A7QwHinb9+//kUJZ0+3hIUMZFX1ciMAkr8W/rQU3o
         AO3l6xROMBxKUIkNDo82CTA6TxVg47b/ciZBuzCCjVL0/W6oLukQPJ2O2RJ18FO3JqNM
         B5og5pvyxzXz82OJJZU3TINcL4ysYuz5sGzBHtA5pbpjlL/dTSJ5bHj5kDXH1OVajDx3
         8slbUDOhmltKdub1Glup9gErYl0fiVK6L4osy3rQmjvpR7zS+v+Tgxk2Tgw+PygGHgWH
         f3J55qKYtogLb7sD8m5SQzE6EdHG7MFoIX5uIMCDVyNbNsGQ3XyVCiQXcSIAeLRhS+rl
         13qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096570; x=1740701370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5hM23iRroiayTpV3ONpzy5pooTVMbj1TF8BFXhb4r4=;
        b=hMuBmpP21TjqANOYmKV82BCclFsJjoA/UZDkCm0ZqcGLNZy06xHtMHS6SOhEkRA59A
         EfCLQ5gvpZs8Tgz6NWHWT6xtQJwaMNUauRekSulSS9ku1QliLEEyPntqW4StYQgw2wbm
         7U7jbCFSPxhVF7mPFy8322PtLJ/cwauMsfji9tXvbvc4DcEviqBj0UUXoZKoZMG2dZ6M
         IoZ+wfCT7vq3fRuIRjeXf0RbQTcs4VIHDhnNMIMbvJuXzMWbZ8du02wa5AhP7SUOkiES
         oEH5goqyHqXSdy7UAuzviQERm9OjVsfprPhKI3H8CmMykKEomGRsp8pvBmFOZ2Rpbc9F
         7DiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMuaXb1hTwtfiSIhl+QwDDMwDap/pPPBLxNqiHoWx1p6Fhb/Z1H8K01zQbw8WZUsbb/mV5OprCM6YUVHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyaX++Whh+bFkIDBof3NjS3q93KqE+hm3nKNAbSZw673ZCvjk
	o6pWNoSt9VHqUS0yCOcIiIjya+FLNw1peLuP2hDUhSXHnWDGLUQu+nhP8mSRPA==
X-Gm-Gg: ASbGncv0yJwzXgEltse+5nLsgGonnUHTXu0q/8/WwADNwyyKfdHmFgWc5PWvSadeIdf
	Gu6xavjQSjRZs5UdEC9TlDj0rUafuca2kWdJbClp0W+k5J88bAdhI+YQ0YPzuBFUoId9no32YwF
	6m8OFv79m20OD6IN5URB8Q4Edr6eXV3AQia3F0hrfRJ2QPs7T+9pDhrSbMOMxai7oNwJuA0yr71
	0XWitUCb3MZ2u3jKX27k1d61/+AQT+qDBGCyQ4k/z72xFR0740/C8qp/FaZr7N7SI5Q8xJnHJ4I
	LVxBCQ8hNCE9a991tcMO+4HFa6eG1a8d1g==
X-Google-Smtp-Source: AGHT+IF2JM2LKC17wpZxVEWOnlCgEtBUNVIC6uqX4gRfMQHIPsGUXAqsCDrHVc3eY40FDoWxYpcitw==
X-Received: by 2002:a05:6808:3191:b0:3f4:133d:f18 with SMTP id 5614622812f47-3f4247ecff3mr1177279b6e.34.1740096569876;
        Thu, 20 Feb 2025 16:09:29 -0800 (PST)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f40b027906sm1573401b6e.42.2025.02.20.16.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:09:29 -0800 (PST)
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
Subject: [PATCH v3 3/4] riscv: uaccess: use 'asm goto' for put_user()
Date: Fri, 21 Feb 2025 00:09:23 +0000
Message-Id: <20250221000924.734006-4-cyrilbur@tenstorrent.com>
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
 arch/riscv/include/asm/uaccess.h | 70 +++++++++++++++-----------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index fb3961ecf38b..1b926b61af66 100644
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
@@ -398,11 +397,8 @@ static inline void user_access_restore(unsigned long enabled) { }
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
  */
-#define unsafe_put_user(x, ptr, label)	do {				\
-	long __err = 0;							\
-	__put_user_nocheck(x, (ptr), __err);				\
-	if (__err) goto label;						\
-} while (0)
+#define unsafe_put_user(x, ptr, label)					\
+	__put_user_nocheck(x, (ptr), label)
 
 #define unsafe_get_user(x, ptr, label)	do {				\
 	long __err = 0;							\
-- 
2.34.1


