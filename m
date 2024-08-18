Return-Path: <linux-kernel+bounces-290950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2445955B7C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 08:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A63C1F21D55
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 06:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CF31759F;
	Sun, 18 Aug 2024 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CoW2ZonT"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8A14285
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963314; cv=none; b=NuVSZJnBcbnsXWeJ6L0vwRSkFfDoJGrBuE3zwVkrChBiuZi5kyQb+LLbjFO0Ci+pmYYeA7NjXEvAf/jhacoyu7gdJO4EU+erajmow29dBca6YCQxrCKHRjOMRuaWt1kFudew6DLB7hS3ooV56NhdWuRoMFetvsuO6ASDvIFw1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963314; c=relaxed/simple;
	bh=49XBNMxYmaKb1kOfY1Da4EKIlSdrTdQzrpxHv533ook=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mm67QM6TjW5AFw5RHyXMVitvfZopXMf2YcYYhu3tJuLhge9D6lmqVL9Uw0EB4KxnfUnME25vLQEHcWUhOQEdw3Evubz/pgFMiFaNlIEVEfCzIeeDLdNUyJDC6VUCptXPWx5HcG4IJqJ7B2gX+5h8s8QnFymrOl+udxLcX9WDohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CoW2ZonT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37196229343so1256860f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723963311; x=1724568111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzrQ84GOc79Cvd4pehyYMEiToRaVIXWpNcTPRgBQZOo=;
        b=CoW2ZonTZKGkYgSDcskr/DbpxDb5Un6LTrw8TLUVLPruyYhtYsPHi8+L8Y8TpSeJUq
         latWMBkPnFPeWbltwfkNifYIbFx8LYeBz0MLLCkkJM3n5ZChDnU3rWRIvK415/x+3vvD
         4F0MoBhRXlArSjkLL0p9A7W/UxXvN4MnYIQ6LPJo+Ljs1GJfex8XgWwrJXTvlQvztn3J
         AzaIO3LHy8uYevxxBjiEr3JiHTUfrRhrtzS58OLRzBqUp4Qmm9nprVhUbkhrhqBsDs1A
         RbRonYGDegZoF9oNy09lwq8g54scglDhHo2fOBb+K1ovMhQXFmuI03IafdRDox8QCjKe
         SO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963311; x=1724568111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzrQ84GOc79Cvd4pehyYMEiToRaVIXWpNcTPRgBQZOo=;
        b=gfJuUK2Kl6g1oIOW17w6YhOEHd0jf+uHMVOUzkaViHoYycXoGqUoof0GTzAzO2MxPC
         c08aG2m/2tPpwM1/qOHRlZBZYzX4CGfOfcKz1KrFlSKNtttQEhnJ/5HBv3PMOMLov3in
         YOvDVJHNih8TthjIEJdbvKeru2gwaaSIv1YwaVlgj8puYIeh1UhNY0m9TVcxZw6U4hNm
         8KxeOTmyy+tj3+wBShGNCjMm55L9/3mrFofmjMrUdg+GxyZuwNJteHrpCQtAoaBRyLVU
         dbf8sT/38aajIAYKSePL0bXMapdv5A/8X6Cw4lboRCQwRHfoSxbulOyXy3iicV9bl8pb
         2DyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4i7bu5/90yswIZy46CD1H3OCiRwvct+/Em74M18nXRintXeWOtBV/tykBeJXkmLttLug1lkevfLaeD3btyujv0mQWUSRHRqWvop1m
X-Gm-Message-State: AOJu0YycKAsCIzozP8qprKOM/AQlGjqD6lFS6SV5GMD5vubf18gK2+67
	dVqNvK3D6SHpKNl4jAuA8+Jnz69cZq0VHCa5rK4uAb63SXozn4M47pSQRWLYViw=
X-Google-Smtp-Source: AGHT+IH7jXMI8vQlmJu9PzoH6e8IpPUsf9yyX42mqd9sjDsguutH4AFv/sh4mfXo/xTrWqv9pY4RtQ==
X-Received: by 2002:adf:a1ce:0:b0:368:7fbc:4062 with SMTP id ffacd0b85a97d-371946531e9mr4631837f8f.33.1723963310553;
        Sat, 17 Aug 2024 23:41:50 -0700 (PDT)
Received: from alex-rivos.guest.squarehotel.net ([130.93.157.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849606sm7362530f8f.32.2024.08.17.23.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:41:50 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrea Parri <andrea@rivosinc.com>
Subject: [PATCH v5 06/13] riscv: Improve zacas fully-ordered cmpxchg()
Date: Sun, 18 Aug 2024 08:35:31 +0200
Message-Id: <20240818063538.6651-7-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818063538.6651-1-alexghiti@rivosinc.com>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current fully-ordered cmpxchgXX() implementation results in:

  amocas.X.rl     a5,a4,(s1)
  fence           rw,rw

This provides enough sync but we can actually use the following better
mapping instead:

  amocas.X.aqrl   a5,a4,(s1)

Suggested-by: Andrea Parri <andrea@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 92 ++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 1f4cd12e4664..5b2f95f7f310 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -107,8 +107,10 @@
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  */
-
-#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
+#define __arch_cmpxchg_masked(sc_sfx, cas_sfx,					\
+			      sc_prepend, sc_append,				\
+			      cas_prepend, cas_append,				\
+			      r, p, o, n)					\
 ({										\
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&				\
 	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&				\
@@ -117,9 +119,9 @@
 		r = o;								\
 										\
 		__asm__ __volatile__ (						\
-			prepend							\
+			cas_prepend							\
 			"	amocas" cas_sfx " %0, %z2, %1\n"		\
-			append							\
+			cas_append							\
 			: "+&r" (r), "+A" (*(p))				\
 			: "rJ" (n)						\
 			: "memory");						\
@@ -134,7 +136,7 @@
 		ulong __rc;							\
 										\
 		__asm__ __volatile__ (						\
-			prepend							\
+			sc_prepend							\
 			"0:	lr.w %0, %2\n"					\
 			"	and  %1, %0, %z5\n"				\
 			"	bne  %1, %z3, 1f\n"				\
@@ -142,7 +144,7 @@
 			"	or   %1, %1, %z4\n"				\
 			"	sc.w" sc_sfx " %1, %1, %2\n"			\
 			"	bnez %1, 0b\n"					\
-			append							\
+			sc_append							\
 			"1:\n"							\
 			: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
 			: "rJ" ((long)__oldx), "rJ" (__newx),			\
@@ -153,16 +155,19 @@
 	}									\
 })
 
-#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
+#define __arch_cmpxchg(lr_sfx, sc_sfx, cas_sfx,				\
+		       sc_prepend, sc_append,				\
+		       cas_prepend, cas_append,				\
+		       r, p, co, o, n)					\
 ({									\
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&			\
 	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)) {	\
 		r = o;							\
 									\
 		__asm__ __volatile__ (					\
-			prepend						\
-			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
-			append						\
+			cas_prepend					\
+			"	amocas" cas_sfx " %0, %z2, %1\n"	\
+			cas_append					\
 			: "+&r" (r), "+A" (*(p))			\
 			: "rJ" (n)					\
 			: "memory");					\
@@ -170,12 +175,12 @@
 		register unsigned int __rc;				\
 									\
 		__asm__ __volatile__ (					\
-			prepend						\
+			sc_prepend					\
 			"0:	lr" lr_sfx " %0, %2\n"			\
 			"	bne  %0, %z3, 1f\n"			\
-			"	sc" sc_cas_sfx " %1, %z4, %2\n"		\
+			"	sc" sc_sfx " %1, %z4, %2\n"		\
 			"	bnez %1, 0b\n"				\
-			append						\
+			sc_append					\
 			"1:\n"						\
 			: "=&r" (r), "=&r" (__rc), "+A" (*(p))		\
 			: "rJ" (co o), "rJ" (n)				\
@@ -183,7 +188,9 @@
 	}								\
 })
 
-#define _arch_cmpxchg(ptr, old, new, sc_cas_sfx, prepend, append)	\
+#define _arch_cmpxchg(ptr, old, new, sc_sfx, cas_sfx,			\
+		      sc_prepend, sc_append,				\
+		      cas_prepend, cas_append)				\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __old = (old);				\
@@ -192,22 +199,28 @@
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
-		__arch_cmpxchg_masked(sc_cas_sfx, ".b" sc_cas_sfx,	\
-					prepend, append,		\
-					__ret, __ptr, __old, __new);    \
+		__arch_cmpxchg_masked(sc_sfx, ".b" cas_sfx,		\
+				      sc_prepend, sc_append,		\
+				      cas_prepend, cas_append,		\
+				      __ret, __ptr, __old, __new);	\
 		break;							\
 	case 2:								\
-		__arch_cmpxchg_masked(sc_cas_sfx, ".h" sc_cas_sfx,	\
-					prepend, append,		\
-					__ret, __ptr, __old, __new);	\
+		__arch_cmpxchg_masked(sc_sfx, ".h" cas_sfx,		\
+				      sc_prepend, sc_append,		\
+				      cas_prepend, cas_append,		\
+				      __ret, __ptr, __old, __new);	\
 		break;							\
 	case 4:								\
-		__arch_cmpxchg(".w", ".w" sc_cas_sfx, prepend, append,	\
-				__ret, __ptr, (long), __old, __new);	\
+		__arch_cmpxchg(".w", ".w" sc_sfx, ".w" cas_sfx,		\
+			       sc_prepend, sc_append,			\
+			       cas_prepend, cas_append,			\
+			       __ret, __ptr, (long), __old, __new);	\
 		break;							\
 	case 8:								\
-		__arch_cmpxchg(".d", ".d" sc_cas_sfx, prepend, append,	\
-				__ret, __ptr, /**/, __old, __new);	\
+		__arch_cmpxchg(".d", ".d" sc_sfx, ".d" cas_sfx,		\
+			       sc_prepend, sc_append,			\
+			       cas_prepend, cas_append,			\
+			       __ret, __ptr, /**/, __old, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -215,17 +228,40 @@
 	(__typeof__(*(__ptr)))__ret;					\
 })
 
+/*
+ * Those macros are there only to make the arch_cmpxchg_XXX() macros
+ * more readable.
+ */
+#define SC_SFX(x)	x
+#define CAS_SFX(x)	x
+#define SC_PREPEND(x)	x
+#define SC_APPEND(x)	x
+#define CAS_PREPEND(x)	x
+#define CAS_APPEND(x)	x
+
 #define arch_cmpxchg_relaxed(ptr, o, n)					\
-	_arch_cmpxchg((ptr), (o), (n), "", "", "")
+	_arch_cmpxchg((ptr), (o), (n),					\
+		      SC_SFX(""), CAS_SFX(""),				\
+		      SC_PREPEND(""), SC_APPEND(""),			\
+		      CAS_PREPEND(""), CAS_APPEND(""))
 
 #define arch_cmpxchg_acquire(ptr, o, n)					\
-	_arch_cmpxchg((ptr), (o), (n), "", "", RISCV_ACQUIRE_BARRIER)
+	_arch_cmpxchg((ptr), (o), (n),					\
+		      SC_SFX(""), CAS_SFX(""),				\
+		      SC_PREPEND(""), SC_APPEND(RISCV_ACQUIRE_BARRIER),	\
+		      CAS_PREPEND(""), CAS_APPEND(RISCV_ACQUIRE_BARRIER))
 
 #define arch_cmpxchg_release(ptr, o, n)					\
-	_arch_cmpxchg((ptr), (o), (n), "", RISCV_RELEASE_BARRIER, "")
+	_arch_cmpxchg((ptr), (o), (n),					\
+		      SC_SFX(""), CAS_SFX(""),				\
+		      SC_PREPEND(RISCV_RELEASE_BARRIER), SC_APPEND(""),	\
+		      CAS_PREPEND(RISCV_RELEASE_BARRIER), CAS_APPEND(""))
 
 #define arch_cmpxchg(ptr, o, n)						\
-	_arch_cmpxchg((ptr), (o), (n), ".rl", "", "	fence rw, rw\n")
+	_arch_cmpxchg((ptr), (o), (n),					\
+		      SC_SFX(".rl"), CAS_SFX(".aqrl"),			\
+		      SC_PREPEND(""), SC_APPEND(RISCV_FULL_BARRIER),	\
+		      CAS_PREPEND(""), CAS_APPEND(""))
 
 #define arch_cmpxchg_local(ptr, o, n)					\
 	arch_cmpxchg_relaxed((ptr), (o), (n))
-- 
2.39.2


