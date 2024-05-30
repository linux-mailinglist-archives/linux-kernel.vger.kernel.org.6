Return-Path: <linux-kernel+bounces-195555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328A78D4E77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2FFB23276
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67117D892;
	Thu, 30 May 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c9z0U+yQ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B6186E38
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080953; cv=none; b=SVro2NBH5y17wd+1tynJSOEjjDx7PN5m6zm14UnPRW9TrspIkBZdrrfkvHFOGrYVvUHZhRYEczzPaoJOYvH/W6DXYQNDvGHPHTlY3jDM+tDucbJrRJxkuIBn7unltPVzSIjUeVxk/nKO7KaQz5r1207rmH8jN2xW634LC5XF6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080953; c=relaxed/simple;
	bh=w1Nw0nZzuw9ioh1PWzH+4KPx2457IuPjvzKZkwIX78M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nGC5Ph/ltfwcHu43Uzvf6MpZEHRi34IYe5EpSIGX/HCcFJXDQU0CaqrORDoctFeoVNjWh1AOOvkQtEjojhWu6dWFnI9VY8a4g/pMmSd4RaSK8ccbQZ4gN+B1AdxyRJeaa7kQzhiD1z+02hQDXzxZiaPSI8Vl1AZup2EcXUpjblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c9z0U+yQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4211245e889so9588115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717080949; x=1717685749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kF9KjPkj/1zZtp+GEuMgpwBghf6s7Q8QVJOIdZrAtlI=;
        b=c9z0U+yQiFfVjcvZDlzxnlt1gtxEOLOyJNThJloNkvL3MTT+wDsBy2n3P6QRdh+49q
         qb/hD/cO9JPIhH4+yVd4POoHf0wR72CiAKJgD8KNXdWLeKUMpriLXydSA2Ei+X8EtxSw
         0pSYdiEyA98YRnMbK8u8wcrUHl54RF80Wsfm0P5djdoLahEOHgOsEbfsrV6QGT6s6g+w
         xN2bfu1o4iGKNTxdy3ZQrdaJiqNy20Qgm5XueYeb52QFQwfp10Azz3rbVfSw4zj8Pl9P
         v8+6ygWLRpAJzmNf7mL35wkJQUywwejBckq+RK6E0rObNjKxkZWNfq8ZOW+jKwGdIZIA
         cDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717080949; x=1717685749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kF9KjPkj/1zZtp+GEuMgpwBghf6s7Q8QVJOIdZrAtlI=;
        b=jdhKBiic2TnIlSvdD2EMqJFfB89yNFgASsv2hnEbXY/8JFX8Lysyxa2MrW/+Z+9vSQ
         5mNlMNH3u4lzTaruogVjMWkt84Y7zEEGnD1/bEj+QKBVjxxjFIx+Y1p7i7IKeOUxHxdS
         rO23hyQU9lF38A3G9sgEAkWSNcdLyoOHabmYqetJ7fH5kYFW2+U2a+T9J5V++dyDtX0V
         IVbAHUxn59Yoqg1H8zm2ZY6m1tljijGxDejwVGXW4ubB9lYjXv7c/xoFGwGQsmPWUHLB
         5gzwC9uhwYCIl6GmgAbV2wnkct5HQ0hjKOFusQzbd/rqql7pOiR/mh6nliLCQQvARDTh
         SRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsx5FrOuj66BUdro9pKJJ2vBZnr8pHiOYWDW6qMY53QzUXgKSOthsxSBb5AIbfIHHQm2AnHXGNYnDxrrHDgeHzQVIdpm10y9MFtBRG
X-Gm-Message-State: AOJu0YwVHmx1TBmNZLHWll7aB7a5HpMkUpYK3F6jMQw2o3/zHVHc9mck
	4L+LR4IME8Vwu0GxWOcnZEe32NbISXicp7VhHViyekGFQOBtEfwhL3NF8EMd5AI=
X-Google-Smtp-Source: AGHT+IG9d2Dhr06uBPNVTlyZtrq3fR1la7qkTtdMZ9XARQizEYKDs2DfO+7rmvJ5eCSaU68b9UjyXw==
X-Received: by 2002:a05:600c:4f8f:b0:418:f991:713f with SMTP id 5b1f17b1804b1-4212781b9bbmr23791285e9.23.1717080949418;
        Thu, 30 May 2024 07:55:49 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270553c9sm27435975e9.8.2024.05.30.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:55:49 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH -fixes v2] riscv: Fix fully ordered LR/SC xchg[8|16]() implementations
Date: Thu, 30 May 2024 16:55:46 +0200
Message-Id: <20240530145546.394248-1-alexghiti@rivosinc.com>
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

Changes in v2:
- Remove the superfluous full barrier introduced in v1 for xchg32/64() (Andrea)
- Use RISCV_FULL_BARRIER instead of the corresponding string (Andrea)

 arch/riscv/include/asm/cmpxchg.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index ddb002ed89de..808b4c78462e 100644
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
@@ -46,7 +46,8 @@
 		: "memory");						\
 })
 
-#define _arch_xchg(ptr, new, sfx, prepend, append)			\
+#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
+		   sc_append, swap_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __new = (new);				\
@@ -55,15 +56,15 @@
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
 	case 2:								\
-		__arch_xchg_masked(prepend, append,			\
+		__arch_xchg_masked(sc_sfx, prepend, sc_append,		\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 4:								\
-		__arch_xchg(".w" sfx, prepend, append,			\
+		__arch_xchg(".w" swap_sfx, prepend, swap_append,	\
 			      __ret, __ptr, __new);			\
 		break;							\
 	case 8:								\
-		__arch_xchg(".d" sfx, prepend, append,			\
+		__arch_xchg(".d" swap_sfx, prepend, swap_append,	\
 			      __ret, __ptr, __new);			\
 		break;							\
 	default:							\
@@ -73,16 +74,17 @@
 })
 
 #define arch_xchg_relaxed(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", "")
+	_arch_xchg(ptr, x, "", "", "", "", "")
 
 #define arch_xchg_acquire(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
+	_arch_xchg(ptr, x, "", "", "",					\
+		   RISCV_ACQUIRE_BARRIER, RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_release(ptr, x)					\
-	_arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
+	_arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "", "")
 
 #define arch_xchg(ptr, x)						\
-	_arch_xchg(ptr, x, ".aqrl", "", "")
+	_arch_xchg(ptr, x, ".rl", ".aqrl", "", RISCV_FULL_BARRIER, "")
 
 #define xchg32(ptr, x)							\
 ({									\
-- 
2.39.2


