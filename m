Return-Path: <linux-kernel+bounces-195024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B2E8D4678
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FB31C211EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC87142E94;
	Thu, 30 May 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="I8V1G/We"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939820322
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055672; cv=none; b=Ck4tgsAkxyuav73QLaHZe0Y0WHBq11q7sKcU06wnyXQoN4124wvOy+QNRNQ/J2/MptpzMAPoS79UezCKW7ZP8adH9NCliTzXucg3ECkI5SEsUcV81A0GapHKdBpvU60r1i9rRwCwRDFZjIJEtUbG0V2go+N05mrBPz/Tq9NQlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055672; c=relaxed/simple;
	bh=Pg4o+asWpOCTw8uWVXUtrvorlIOh3gIZllK53yfxGio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tXcLLIpftqd25XNg8R52wN3L9m3pXRbW65onVegFQsGDrhU/p7g6FSJGe/rZuA6uK3mkFKRih3G9JxxSi9SeiM+yuvtj7cfcXmCj3stZJ0CGqU5f59NLf8izI7kKv/ZyF6R/ByunpLF51f5YYz5xc6Ozs+ZyG2JgFnYmWcGYeAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=I8V1G/We; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42121d28664so6515005e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717055668; x=1717660468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gEk4cRtLIMz1d+ONWzu542I10bGkCjrk9ZcxQfZHt8=;
        b=I8V1G/WeaKlU95gVhfkBoeIAvjNteWHl4zs44I/SoggK9mMqX0dUYggqeTaLSNkPQK
         fZqZhBDGeLXz+TE1+3uAPfkSUVHLZeG3PX1BTp0n2laU+lsqQJHAg7jZ1plGgDHZznfP
         HElR5Rq2Sk8uViJB2TrypRNBsBJVmNv+Yckl5kGMhTkMupskz2ATRpxD0AUIdJ29ERID
         466VbkI5lZPwUbTMM+F+b/+6jfG/ELxIiVSorVBUxiiKs6MsSYwIX3SjkMgXiwIGYYms
         +Q8N4m36lKNbahGSnjdHQbEcLDyyyDC8pl6YnRNXpK6I+NtZ+OWjqAVyBMkmW2AZR/CW
         yOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717055668; x=1717660468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gEk4cRtLIMz1d+ONWzu542I10bGkCjrk9ZcxQfZHt8=;
        b=vVPOc2rIgG/E8WWICgS25MDJL8kEk4ErmXeb2C8UJOS9AGwpa27A5s82g7v6mxwjPb
         uv2wG4Zpz0KuV9QG7ovCz1wIW0mhU67Gi2crktjSlLmNfhBlw2Kp9LtsN/BcEyqUWu6u
         InzRFJKjbQQvqOSqgc3HrM4pv0IofCsXttS9xsX1y0gMUvn16J52peMX4Q+u90P3W+F4
         Zm/RaBtIRQieuhye8F4fs69hi7tyKMjSp3aAd6mO9jvGyigY53NNbvKHr91o9zkg9f9j
         KsSAOp7+Iz3rv3BoqwonEBR4fuLjeZP7kIAGFRs8dkBTayHK1DO98+LRWVOeTIzVUz5S
         RNHA==
X-Forwarded-Encrypted: i=1; AJvYcCVaZPXfYXpyk2Z9u6Xb9rebAx89fe/7RHpO84vhVSD4GcM6yNd436PoIxwraMprCRLVAEgUmBTGOqszYZQqmtQIKFFXg/oVKGQlVvnc
X-Gm-Message-State: AOJu0YzTlwDILnDibS5Vx9XrOXyv+DPgbEvF/zr1+uNXysNmUhgU7nv5
	x5y3yqdjEA9N2KiaykZTg/Z3wua/MwOm9cKY47stbO3JbeE5KbvOqBDrPfBDFRE=
X-Google-Smtp-Source: AGHT+IGeI7XRpZK2v9DADY+iDjOcvT75H36nmiKPi9Fmv16Kmngas9i40NRhcRNrQXkLHUYN59XZKA==
X-Received: by 2002:a05:600c:1896:b0:418:e04b:ee63 with SMTP id 5b1f17b1804b1-42127935444mr15689335e9.36.1717055668219;
        Thu, 30 May 2024 00:54:28 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270791c7sm16650635e9.31.2024.05.30.00.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 00:54:27 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH -fixes] riscv: Fix fully ordered LR/SC xchg[8|16]() implementations
Date: Thu, 30 May 2024 09:54:24 +0200
Message-Id: <20240530075424.380557-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fully ordered versions of xchg[8|16]() using LR/SC lack the
necessary memory barriers to guarantee the order.

Fix this by matching what is already implemented in the fully ordered
versions of cmpxchg() using LR/SC.

Suggested-by: Andrea Parri <parri.andrea@gmail.com>
Reported-by: Andrea Parri <parri.andrea@gmail.com>
Closes: https://lore.kernel.org/linux-riscv/ZlYbupL5XgzgA0MX@andrea/T/#u
Fixes: a8ed2b7a2c13 ("riscv/cmpxchg: Implement xchg for variables of size 1 and 2")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index ddb002ed89de..e1e564f5dc7b 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -10,7 +10,7 @@
 
 #include <asm/fence.h>
 
-#define __arch_xchg_masked(prepend, append, r, p, n)			\
+#define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)		\
 ({									\
 	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
 	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
@@ -25,7 +25,7 @@
 	       "0:	lr.w %0, %2\n"					\
 	       "	and  %1, %0, %z4\n"				\
 	       "	or   %1, %1, %z3\n"				\
-	       "	sc.w %1, %1, %2\n"				\
+	       "	sc.w" sc_sfx " %1, %1, %2\n"			\
 	       "	bnez %1, 0b\n"					\
 	       append							\
 	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
@@ -46,7 +46,7 @@
 		: "memory");						\
 })
 
-#define _arch_xchg(ptr, new, sfx, prepend, append)			\
+#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend, append)		\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __new = (new);				\
@@ -55,15 +55,15 @@
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
 	case 2:								\
-		__arch_xchg_masked(prepend, append,			\
+		__arch_xchg_masked(sc_sfx, prepend, append,		\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 4:								\
-		__arch_xchg(".w" sfx, prepend, append,			\
+		__arch_xchg(".w" swap_sfx, prepend, append,		\
 			      __ret, __ptr, __new);			\
 		break;							\
 	case 8:								\
-		__arch_xchg(".d" sfx, prepend, append,			\
+		__arch_xchg(".d" swap_sfx, prepend, append,		\
 			      __ret, __ptr, __new);			\
 		break;							\
 	default:							\
@@ -73,16 +73,16 @@
 })
 
 #define arch_xchg_relaxed(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", "")
+	_arch_xchg(ptr, x, "", "", "", "")
 
 #define arch_xchg_acquire(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
+	_arch_xchg(ptr, x, "", "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_release(ptr, x)					\
-	_arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
+	_arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_xchg(ptr, x)						\
-	_arch_xchg(ptr, x, ".aqrl", "", "")
+	_arch_xchg(ptr, x, ".rl", ".aqrl", "", "     fence rw, rw\n")
 
 #define xchg32(ptr, x)							\
 ({									\
-- 
2.39.2


