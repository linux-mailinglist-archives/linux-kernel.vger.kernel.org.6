Return-Path: <linux-kernel+bounces-230799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 964A8918203
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201881F24077
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8A8188CB1;
	Wed, 26 Jun 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FvBI4Q4Q"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88291187575
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407402; cv=none; b=YVvN0sLDxLG++3kwZDoEIuJO0McfS1JSo5u+1YTc7ETeRY9NWOs8yVE7svLJYG+qj/9HrW7CMYJdclhq+pRjI/hQJar1ge10o+pDpmAcJOj82BkDdVfkehK4DuzXe4xGzjcCYSYYwmasN1sSLCF8CQD0Su1WMxBnc/+RWaXdva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407402; c=relaxed/simple;
	bh=1nsWpj/1AHADQ4wqup/AgTW4I3Ye+rUKhZdyv9agWxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gy2mAxpfshRMKY1IDl/D/oQceg2jaQs2KqRkWW/uG6nPbf0VOueSt3Lx0vq217bffkWqe9tv0D8TMjKU6sJXTtmCufV05crJSuxjzK8uIpwL49cxFCweJRvFcWYk69m9afTpcgk0IzpFVc4OlLlfThW9ElEK+QETvwjNFgWILak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FvBI4Q4Q; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42108856c33so3771445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407399; x=1720012199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWrbp7YnSuSg4cTyCRLd07oshRok5ClJY3Zre9Kj0ww=;
        b=FvBI4Q4Q3HQCTqPsoEoLRnI8gOmuBXhqSSPpUCRZPUo4xW5tKaSwy26l0QxSQ/rt+y
         1Q9yizARS8f/nYAdicq2qMYq9s1EemDfqztUruz3B/qIw4/63N+UccACntKQem4nxITR
         FddT4jnF3KxLVlHM8D1qHktQq2ZI4/0IYTr1fQwY1vS7sObxiz2KpDmoucXp1h40lHJI
         /CwSzjlLdq82mfX/KmqE461P6ax0l9rnYnxzZxTADxJ9LEHYQSy1xmdTdZaPwbqvBRai
         ey6rMGb5bRqod+H/R3GR39jkm9PGbLwFfuaOjlFA8UzPJBYeV5/xf3DTiltZtuUU9Nhv
         5fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407399; x=1720012199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWrbp7YnSuSg4cTyCRLd07oshRok5ClJY3Zre9Kj0ww=;
        b=MdovldWS6l2QgLO6lip1ZqzJ2E7Ha3eyqRGKthErCAESpNwAHjmRWtIDZudqQCZG51
         NaOlMbBUa9fQ/e9nvHdl5tU8XhFKMMpe+/su27KWmjFV3ei0MnsJAPPCubFo2k66DbAf
         2X7zObr2LVFHhlRdvfbU6JxNdtm6rUAdFYgGeYBNLeVlZts1N+Mk0nzgZ9jvd6ep2F0r
         IEZ2P3NKvscj5IaQssypmk7JNWqQipaRMsm1G+0b32J+M3uh+o8vc9GeRm6DL+qyk8yN
         RHUImkMT6+Mt7PM/wy1gitHuEU0kpoDGqxAoIFswwmWRDN0xKAEXshQGAcnu79t5HYV3
         QSAw==
X-Forwarded-Encrypted: i=1; AJvYcCVqgQ4L5PWmp/kYOeUVbJ1WabN7aCWy6JcEcO28SPODe6sTPOUkOJCJ1t9h9a/koa1gYEvldA4QnaGQVTSosF9wl1MRkL09zVrSVKR4
X-Gm-Message-State: AOJu0YxabpNSbv/00VOIXcD2oZLzOOLbn5WAIQrQI04IK1Zn1jZGK7x9
	NlN3N5QcZG/PiCGn/Cgzipzz8w+f9kTjZv6YnXybd3JLlME6jHjx2fnabLkilVs=
X-Google-Smtp-Source: AGHT+IF1O9RqB95BpuZCH8OUjPkY7BW4xVu+M+7CZDEbvz5gp1RkR9X5IwXEN5r4vgMt231tIFpnRA==
X-Received: by 2002:a05:6000:1c4:b0:367:3404:1c06 with SMTP id ffacd0b85a97d-36734041cecmr473355f8f.20.1719407398822;
        Wed, 26 Jun 2024 06:09:58 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada0bdesm15712197f8f.113.2024.06.26.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:09:58 -0700 (PDT)
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
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 06/10] riscv: Implement xchg8/16() using Zabha
Date: Wed, 26 Jun 2024 15:03:43 +0200
Message-Id: <20240626130347.520750-7-alexghiti@rivosinc.com>
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

This adds runtime support for Zabha in xchg8/16() operations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cmpxchg.h | 33 +++++++++++++++++++++++++++++---
 arch/riscv/include/asm/hwcap.h   |  1 +
 arch/riscv/kernel/cpufeature.c   |  1 +
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index da42f32ea53d..eb35e2d30a97 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,8 +11,17 @@
 #include <asm/fence.h>
 #include <asm/alternative.h>
 
-#define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)		\
+#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,	\
+			   swap_append, r, p, n)			\
 ({									\
+	__label__ zabha, end;						\
+									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
+		asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,		\
+				     RISCV_ISA_EXT_ZABHA, 1)		\
+			 : : : : zabha);				\
+	}								\
+									\
 	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
 	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
 	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
@@ -28,12 +37,25 @@
 	       "	or   %1, %1, %z3\n"				\
 	       "	sc.w" sc_sfx " %1, %1, %2\n"			\
 	       "	bnez %1, 0b\n"					\
-	       append							\
+	       sc_append							\
 	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
 	       : "rJ" (__newx), "rJ" (~__mask)				\
 	       : "memory");						\
 									\
 	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+	goto end;							\
+									\
+zabha:									\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
+		__asm__ __volatile__ (					\
+			prepend						\
+			"	amoswap" swap_sfx " %0, %z2, %1\n"	\
+			swap_append						\
+			: "=&r" (r), "+A" (*(p))			\
+			: "rJ" (n)					\
+			: "memory");					\
+	}								\
+end:;									\
 })
 
 #define __arch_xchg(sfx, prepend, append, r, p, n)			\
@@ -56,8 +78,13 @@
 									\
 	switch (sizeof(*__ptr)) {					\
 	case 1:								\
+		__arch_xchg_masked(sc_sfx, ".b" swap_sfx,		\
+				   prepend, sc_append, swap_append,	\
+				   __ret, __ptr, __new);		\
+		break;							\
 	case 2:								\
-		__arch_xchg_masked(sc_sfx, prepend, sc_append,		\
+		__arch_xchg_masked(sc_sfx, ".h" swap_sfx,		\
+				   prepend, sc_append, swap_append,	\
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 4:								\
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..f71ddd2ca163 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,7 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_XANDESPMU		74
+#define RISCV_ISA_EXT_ZABHA		75
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 5ef48cb20ee1..c125d82c894b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -257,6 +257,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
+	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
-- 
2.39.2


