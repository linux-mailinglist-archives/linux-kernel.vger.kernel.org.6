Return-Path: <linux-kernel+bounces-393843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2D29BA625
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43399B21713
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80F617DE15;
	Sun,  3 Nov 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="T7baZdCR"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4AB17BB16
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730646011; cv=none; b=obd2rFp+Mkznnxp+BSaLd38YzTgCB73A0cTpiXVnHq5G5chN031jqqvPkgGmaSTtWSTrwJ3JuvOHtIoCkyhgxxQsM9BksPfjkZ96LAshWBLRg4zMwu+GQbVBSjvSV4+eBTqvKIRTOKhN0SrbHIxRP6IfzwhWqpCjynmXvnEU9tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730646011; c=relaxed/simple;
	bh=Md27kdouLX9lf0nN1/O929Tij6j8YRbNusJGqq+3+5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ol/NdFkMEu80CKHhS1zoiVLEl+d3UcLVzFFAaExBAitGvC3Qjc+s0IzT2+pJtYHXhKFLzyJ149HcdEUe5V6ffD7JY5CPzG+JxIXVc/2v/fa6MXjowA/+i4fCP3Mv4kWcpZ9WbmOqppuGFc5vGP0LC8GhhKlfNfhgZF8WWWEzemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=T7baZdCR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so2144578f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730646006; x=1731250806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7omRwb2buD8uK45bQUSORyOPEIU9zvIfXDatLe8IP8=;
        b=T7baZdCR99cg09+6AmG//hj1PZFk16ugIx52lFcIwW02YrQHUKkB0llKNkL/+CTEQ3
         0x2Pwr8E6rGybSY3efHR3tkDrM+/tWzLn/NPedq5TPREguTcNWCgcRYgdeZrVPH3GOrB
         36UtvdoGh9IhWnsuVpf13XwuWbE7/8Co5RRw3AcS4TYL8e4uV7vLbuxziHkAunkaLC9Y
         +Dv1JJ6d1L36M/Bjl7GGF4mMrFgvEkN1IHxqPubKb/NyTKYjOs9uNQxSSzpSuf32zIEI
         Vq42xGSZGnmM+BkrQTrgYYHpJ2Jxkf6UAhdoRODsUc91hYc1CEdl7RafzLlXR7Vm68nK
         pJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730646006; x=1731250806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7omRwb2buD8uK45bQUSORyOPEIU9zvIfXDatLe8IP8=;
        b=QkMkCCenzWg8pkdTOHDZGaeXpPHAcK488MlksHLUBuySgADmVfZE20Q0BapZLq5T4c
         0X/bEMtSSd5Li+h5Fv1AROYMN+kQDHBNXU2fCOpJQ9+APlWXODxmkbm3lPH+1Jx8ANxB
         UtEhHqFjUHzp48j9Bx8JdjN+k+sOLKO3MZBbe5C/mvUI8S+GJ0gVG1kiDc/XnOQJYlTt
         dJBF1uFc/zJ25JZNh/C75lzWi6CFpua7t92THjRjk6SWHMrAB1+0+JXAavWvz0wFMVz+
         GfHQyI3dRh01USHkLSkNKfFL8FGe0/tFcouLKTEIQ8FqItLOyr+TmHV3kbNkfDba7i4f
         fhEA==
X-Forwarded-Encrypted: i=1; AJvYcCVgF1cLzcN36E63r2cWsIUrWbPFilJBB2kcDDOcxfoC6+hPHDIKaI1fSca3O3xwy40IJ5qr+PX2h16k9ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8933h0O/KnRAY32fZrDnUH9F+pQDO/U6pa9vlamJRGS4Q3Fn
	ky2hHPW3u7vAwhvaylu1+bonLseKpEsCf7T2bDEUaxGaKxiK7jPGBbOJjxNFIhk=
X-Google-Smtp-Source: AGHT+IErbU6/+ESL9c7D4Rkx4JGXztbjh558spmD2njQc7VJwfVBMIIjkXAoMafrlIu7KWoRdehU9Q==
X-Received: by 2002:a05:6000:4029:b0:37e:d2b7:acd5 with SMTP id ffacd0b85a97d-381c7a476a8mr7741924f8f.8.1730646006376;
        Sun, 03 Nov 2024 07:00:06 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7465sm10805300f8f.53.2024.11.03.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 07:00:05 -0800 (PST)
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
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 08/13] riscv: Implement xchg8/16() using Zabha
Date: Sun,  3 Nov 2024 15:51:48 +0100
Message-Id: <20241103145153.105097-9-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241103145153.105097-1-alexghiti@rivosinc.com>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds runtime support for Zabha in xchg8/16() operations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/cmpxchg.h | 65 ++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index f95929f538b2..4cadc56220fe 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -14,29 +14,41 @@
 #include <asm/insn-def.h>
 #include <asm/cpufeature-macros.h>
 
-#define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)		\
-({									\
-	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
-	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
-	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
-			<< __s;						\
-	ulong __newx = (ulong)(n) << __s;				\
-	ulong __retx;							\
-	ulong __rc;							\
-									\
-	__asm__ __volatile__ (						\
-	       prepend							\
-	       "0:	lr.w %0, %2\n"					\
-	       "	and  %1, %0, %z4\n"				\
-	       "	or   %1, %1, %z3\n"				\
-	       "	sc.w" sc_sfx " %1, %1, %2\n"			\
-	       "	bnez %1, 0b\n"					\
-	       append							\
-	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
-	       : "rJ" (__newx), "rJ" (~__mask)				\
-	       : "memory");						\
-									\
-	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,		\
+			   swap_append, r, p, n)				\
+({										\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&				\
+	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {		\
+		__asm__ __volatile__ (						\
+			prepend							\
+			"	amoswap" swap_sfx " %0, %z2, %1\n"		\
+			swap_append						\
+			: "=&r" (r), "+A" (*(p))				\
+			: "rJ" (n)						\
+			: "memory");						\
+	} else {								\
+		u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
+		ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
+		ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+				<< __s;						\
+		ulong __newx = (ulong)(n) << __s;				\
+		ulong __retx;							\
+		ulong __rc;							\
+										\
+		__asm__ __volatile__ (						\
+		       prepend							\
+		       "0:	lr.w %0, %2\n"					\
+		       "	and  %1, %0, %z4\n"				\
+		       "	or   %1, %1, %z3\n"				\
+		       "	sc.w" sc_sfx " %1, %1, %2\n"			\
+		       "	bnez %1, 0b\n"					\
+		       sc_append						\
+		       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
+		       : "rJ" (__newx), "rJ" (~__mask)				\
+		       : "memory");						\
+										\
+		r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+	}									\
 })
 
 #define __arch_xchg(sfx, prepend, append, r, p, n)			\
@@ -59,8 +71,13 @@
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
-- 
2.39.2


