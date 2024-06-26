Return-Path: <linux-kernel+bounces-230803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 532E691820D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC3F2868A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C37218A929;
	Wed, 26 Jun 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IEtghVvX"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA017FAC4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407463; cv=none; b=nq8VE6vtPrIOrYngdH6L4AfO+fyrsUuQajB0//BYKFlcvUuX6BeygO51RoLrwE7Aqqu+u8uM/RSB/SGWR05H2/T0tGaIUAzYMi/iDLauvxwEaDey6HmB32YUh9VOIJIzoyh6YEs3fhPJAMUYnPJ3W/MwoYMNUdUEkv3josuW7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407463; c=relaxed/simple;
	bh=D53uFKdbu0rUSjZO/RVlECC1r3Mb1FnxEodoilYhPC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVTXSKlno8t6P4HgR7scjcJQgsBtr8AlY8htqmcEPLTxGqg5SPTJlcnp8oqFTU78/KZoycTT7fpoJgg9/DBpK/YwBUAu/opmBmybij69ZhfSfO7x4O98uaaHvhlt99xWpeEXiT7JtkCNAVndfGwQ9pxt8xbfBzxzBjCHOXXOr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IEtghVvX; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cd8897c73so5595224e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407460; x=1720012260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6cx0+kPy/mr4m8koR629ifIafAeU6/dHlLYYLSwNIk=;
        b=IEtghVvXiJf7ehJl2QugBxx8rwqTEU/FoFwTu+EgEkg5IA8ns6Le5fKDbQPapjTG/L
         r2MQTVXcpCJgmTLTqWK2icY++f32/F6/Zrcha9Q24EJzkuAvS2KhgzxgFBsfjWmTV8Qn
         bMI/rXJTtRW2Li+XFCVYWx/QRCHvMG1BypF3l7SYTyNV1AP4AJZfeCrQT7A24lqlIO5M
         Zmig65N6w/50aqfXmpH/m3nSoWsGm7SqvIR+M/2l1JKHLX2vEQxDDyI0FI89/XO20faL
         dDQVRd+5Mcv78XSAzhPZlBbEUZHr2ZoUCa0ZWpX7ndtqwaGdfNx6w4eLE5UOyFLFx5wf
         Wk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407460; x=1720012260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6cx0+kPy/mr4m8koR629ifIafAeU6/dHlLYYLSwNIk=;
        b=kd1mHMQP/ki/M0224FIPtBQBCdCrfwkRl9KSUZ5/zRttBCMwjmcSPmy7Yu4ySVYFyv
         ppTt++/9Skj8j+g14AArThM05STJmyHLttFxm21WAy9pwTS/Ciiu8G79QJDjSeaLbQ/M
         ckXSRMaPMsiVkX3+RDXUHwzkgVOdj3Sphto3K2RHk9kKtb6dPgnZnr1x6I9dUJwiv2Yq
         7TZX+If4WxOgLHp9AbOFKyY9fKXnSjwVd+sc7EGjOORiUgL1ZTWOVf6yVh2iBFBTbEJH
         tBpbcXotBMQnhKtfLm4dtUUYc1OE2Qsuw0ELvd7VkyevPMemdg939ZJHW9+thSF4EFCD
         cmuw==
X-Forwarded-Encrypted: i=1; AJvYcCWPvxr/5ZnaqjBdcNsrEijX0soUQFU5QasxUy5KpNO5MLSOv35KPbXXQGUMdLPXUaGvy+TdTFuW1Ltqe7l/wVKPWGCjmI2gzs8qYVCB
X-Gm-Message-State: AOJu0YwCbVsOO0W443bmkmBT+msJzX2ldIbHUyCSKTkitXpFLbbl1LnW
	3LtkXYQlim3zkeEItZOHCthZ+cYm3xdcVfMMgSHtgtX5dv2nqwvOG6fjZwdRkeI=
X-Google-Smtp-Source: AGHT+IEtNRZjWCdEzOhHydNYZbdtsSBOyhgctkoqWdBmAHXNA7jMkTIIYGJ6ebJAtMiVgYJ66wbTgg==
X-Received: by 2002:a05:6512:1cd:b0:52c:dc57:868b with SMTP id 2adb3069b0e04-52ce18324ebmr7017333e87.13.1719407460052;
        Wed, 26 Jun 2024 06:11:00 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c824eef1sm24890125e9.14.2024.06.26.06.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:10:59 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrea Parri <andrea@rivosinc.com>
Subject: [PATCH v2 07/10] riscv: Improve amoswap.X use in xchg()
Date: Wed, 26 Jun 2024 15:03:44 +0200
Message-Id: <20240626130347.520750-8-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626130347.520750-1-alexghiti@rivosinc.com>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xchg() uses amoswap.X instructions from Zabha but still uses
the LR/SC acquire/release semantics which require barriers.

Let's improve that by using proper amoswap acquire/release semantics in
order to avoid any of those barriers.

Suggested-by: Andrea Parri <andrea@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 35 +++++++++++++-------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index eb35e2d30a97..0e57d5fbf227 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,8 +11,8 @@
 #include <asm/fence.h>
 #include <asm/alternative.h>
 
-#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,	\
-			   swap_append, r, p, n)			\
+#define __arch_xchg_masked(sc_sfx, swap_sfx, sc_prepend, sc_append,	\
+			   r, p, n)					\
 ({									\
 	__label__ zabha, end;						\
 									\
@@ -31,7 +31,7 @@
 	ulong __rc;							\
 									\
 	__asm__ __volatile__ (						\
-	       prepend							\
+	       sc_prepend							\
 	       "0:	lr.w %0, %2\n"					\
 	       "	and  %1, %0, %z4\n"				\
 	       "	or   %1, %1, %z3\n"				\
@@ -48,9 +48,7 @@
 zabha:									\
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
 		__asm__ __volatile__ (					\
-			prepend						\
 			"	amoswap" swap_sfx " %0, %z2, %1\n"	\
-			swap_append						\
 			: "=&r" (r), "+A" (*(p))			\
 			: "rJ" (n)					\
 			: "memory");					\
@@ -58,19 +56,17 @@ zabha:									\
 end:;									\
 })
 
-#define __arch_xchg(sfx, prepend, append, r, p, n)			\
+#define __arch_xchg(sfx, r, p, n)					\
 ({									\
 	__asm__ __volatile__ (						\
-		prepend							\
 		"	amoswap" sfx " %0, %2, %1\n"			\
-		append							\
 		: "=r" (r), "+A" (*(p))					\
 		: "r" (n)						\
 		: "memory");						\
 })
 
-#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
-		   sc_append, swap_append)				\
+#define _arch_xchg(ptr, new, sc_sfx, swap_sfx,				\
+		   sc_prepend, sc_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __new = (new);				\
@@ -79,21 +75,19 @@ end:;									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
 		__arch_xchg_masked(sc_sfx, ".b" swap_sfx,		\
-				   prepend, sc_append, swap_append,	\
+				   sc_prepend, sc_append,		\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 2:								\
 		__arch_xchg_masked(sc_sfx, ".h" swap_sfx,		\
-				   prepend, sc_append, swap_append,	\
+				   sc_prepend, sc_append,		\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 4:								\
-		__arch_xchg(".w" swap_sfx, prepend, swap_append,	\
-			      __ret, __ptr, __new);			\
+		__arch_xchg(".w" swap_sfx,  __ret, __ptr, __new);	\
 		break;							\
 	case 8:								\
-		__arch_xchg(".d" swap_sfx, prepend, swap_append,	\
-			      __ret, __ptr, __new);			\
+		__arch_xchg(".d" swap_sfx,  __ret, __ptr, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -102,17 +96,16 @@ end:;									\
 })
 
 #define arch_xchg_relaxed(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", "", "", "")
+	_arch_xchg(ptr, x, "", "", "", "")
 
 #define arch_xchg_acquire(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", "",					\
-		   RISCV_ACQUIRE_BARRIER, RISCV_ACQUIRE_BARRIER)
+	_arch_xchg(ptr, x, "", ".aq", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_release(ptr, x)					\
-	_arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "", "")
+	_arch_xchg(ptr, x, "", ".rl", RISCV_RELEASE_BARRIER, "")
 
 #define arch_xchg(ptr, x)						\
-	_arch_xchg(ptr, x, ".rl", ".aqrl", "", RISCV_FULL_BARRIER, "")
+	_arch_xchg(ptr, x, ".rl", ".aqrl", "", RISCV_FULL_BARRIER)
 
 #define xchg32(ptr, x)							\
 ({									\
-- 
2.39.2


