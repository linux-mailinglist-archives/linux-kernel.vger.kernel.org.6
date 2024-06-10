Return-Path: <linux-kernel+bounces-207623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF39019CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60021B213F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 04:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741F14A84;
	Mon, 10 Jun 2024 04:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Gxs+M0XW"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93879F9E8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994068; cv=none; b=pf7Ucy43Wkah8rhxF4oJ5Xr/SXcabU2bnWlsg/vPR60zmg53iN/U0ftB3n7Ns4M4IjZiBW68/mrt3i7nyUyQVwmzbPhInYsHmi2BlDVxdo1e2BUZKO6RXt3hWcMxgVKDdinpH9AZXXBYLIixRKyzhtwhkCkPBfuWsFNldPbcKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994068; c=relaxed/simple;
	bh=uPnFa7HgliYWkEhE+mMi6Koja++p2Kz63ysSy2dgA8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOnbwOkXF1D/UbdgUukHTzONwVDkNZusKJS1JlvZuAcLUidLzxrJheSSd21TAzKt9UDR9ShGqjdxT5+k2WVmu+XcAlEdWw40iZK5mvn7fT812BolYRpLAeA19Vyboc2CbSkZ3WxaowjMpIqqKp+68RCmKPA7G8daazkqI5XJgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Gxs+M0XW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6570bd6c3d7so2200504a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 21:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994066; x=1718598866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRNaUe9j8adPvbr74Z0H2ivwUey2D0tGBGCSxwe2D/U=;
        b=Gxs+M0XW88i6pyxiD0HVyuWseBzsC1eRbBTqTcbugqPnhFu04c4yV4W+hocteyBFy5
         WGQyv20aeRfcHzxonasBVnIrIFjuYSzgOrlM0LRgxuA4S8M7AVvpZD3hVdCln0xJasOm
         2YLoJ/lCfVlad3EVp4Y25pwD/7a8sCafP73nGLhwoOnBJyqMOJilAXFLppvEporQ14Xo
         DwSN3TbcfbY5HGE1HixEMFHHyT66R1MOk8/aZPZZWMZk0shS8Dm0FK89L9nl4gNuavq9
         32QXue3cp7aOlLdNHnVRSxCpO40FNoSVa2XGCUulsVjAgmsWN4jP/9Ix1gMim6NaCk1U
         d/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994066; x=1718598866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRNaUe9j8adPvbr74Z0H2ivwUey2D0tGBGCSxwe2D/U=;
        b=MniFh4Ow77Kg2pyT42cPfE3s6Q4V+S6hkAcvhodZJWo5d1eEv0qOMNMtxvWHTRTS0H
         ui1KbMQ7OF14u/nH+fZTmZlC7JccOHZ4xM0e3J5//dMq5rq2/gms/LyRGIrClHdB0u4P
         q1el3e9l6TAdLAWJwSMY6v8ychHuHM9UqbnNE0Rdv6VFdj+7TTqPbmLbOUqBQ75GOH4I
         JvuL0YEDsv5MlfkBCz5IX5UspOMDbK8+PD/B5xGZkFnlqA1PlmBHDULGECnezIOmKcel
         y26wblDTZEDL8OwTbVlWkwI64PiQTuyhIn4ukNO7fzVtbTMyDD3xSlfBF5DEdK+blGLa
         aU1A==
X-Forwarded-Encrypted: i=1; AJvYcCVthJuYtBXYKMf/MyEtx6JXfTKrrb33Qq5k5AmxLj+3W1my8mh8y1CIfuyVBbCGumDUTEQ7UaUe8WeOwuw5GEGzO0UjegbWAYVY/qlG
X-Gm-Message-State: AOJu0Yw9fD0dUwc/qlyo0ILqI7BhtmvFW6McjoVdWJDWhdxlLXiVj5ib
	aqsd2uvyQB3IY15anu1+D1Kg79jypDAq99qylXddpklXoN3YcOudcbv1QnsCyY0=
X-Google-Smtp-Source: AGHT+IEHuGNZftr0P5W399Ll/GfktVfqQuiEwcOUZM4LeqClcuQW7FJP8H8Qw55t/rgWnRj61I4bRQ==
X-Received: by 2002:a05:6a20:7349:b0:1b6:23ae:b295 with SMTP id adf61e73a8af0-1b623af0b89mr3453563637.38.1717994065826;
        Sun, 09 Jun 2024 21:34:25 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2fe295cf5sm1894756a91.47.2024.06.09.21.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:34:24 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sun, 09 Jun 2024 21:34:17 -0700
Subject: [PATCH v2 4/4] riscv: cpufeature: Extract common elements from
 extension checking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240609-support_vendor_extensions-v2-4-9a43f1fdcbb9@rivosinc.com>
References: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
In-Reply-To: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994057; l=5623;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=uPnFa7HgliYWkEhE+mMi6Koja++p2Kz63ysSy2dgA8g=;
 b=rpbJpMF89ukqLlHxGd6VYgyyx0i+/SKiuUESb5JSY6z3mso294tYGLGnKTBoowGZ1Hz3+sw33
 LHEE+gItcHFCd1Pnb882zm1sWefh3cFF9NbIY4hmQZ2kNrKZiRJItSb
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The __riscv_has_extension_likely() and __riscv_has_extension_unlikely()
functions from the vendor_extensions.h can be used to simplify the
standard extension checking code as well. Migrate those functions to
cpufeature.h and reorganize the code in the file to use the functions.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/cpufeature.h        | 78 +++++++++++++++++-------------
 arch/riscv/include/asm/vendor_extensions.h | 28 -----------
 2 files changed, 44 insertions(+), 62 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 550d661dc78d..b029ca72cebc 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -96,59 +96,66 @@ extern bool riscv_isa_fallback;
 
 unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
 
+#define STANDARD_EXT		0
+
 bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned int bit);
 #define riscv_isa_extension_available(isa_bitmap, ext)	\
 	__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
 
-static __always_inline bool
-riscv_has_extension_likely(const unsigned long ext)
+static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
+							 const unsigned long ext)
 {
-	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
-			   "ext must be < RISCV_ISA_EXT_MAX");
-
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		asm goto(
-		ALTERNATIVE("j	%l[l_no]", "nop", 0, %[ext], 1)
-		:
-		: [ext] "i" (ext)
-		:
-		: l_no);
-	} else {
-		if (!__riscv_isa_extension_available(NULL, ext))
-			goto l_no;
-	}
+	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_no);
 
 	return true;
 l_no:
 	return false;
 }
 
-static __always_inline bool
-riscv_has_extension_unlikely(const unsigned long ext)
+static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
+							   const unsigned long ext)
 {
-	compiletime_assert(ext < RISCV_ISA_EXT_MAX,
-			   "ext must be < RISCV_ISA_EXT_MAX");
-
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
-		asm goto(
-		ALTERNATIVE("nop", "j	%l[l_yes]", 0, %[ext], 1)
-		:
-		: [ext] "i" (ext)
-		:
-		: l_yes);
-	} else {
-		if (__riscv_isa_extension_available(NULL, ext))
-			goto l_yes;
-	}
+	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_yes);
 
 	return false;
 l_yes:
 	return true;
 }
 
+static __always_inline bool riscv_has_extension_unlikely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_unlikely(STANDARD_EXT, ext);
+
+	return __riscv_isa_extension_available(NULL, ext);
+}
+
+static __always_inline bool riscv_has_extension_likely(const unsigned long ext)
+{
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_likely(STANDARD_EXT, ext);
+
+	return __riscv_isa_extension_available(NULL, ext);
+}
+
 static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsigned long ext)
 {
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_likely(ext))
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_likely(STANDARD_EXT, ext))
 		return true;
 
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
@@ -156,7 +163,10 @@ static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsign
 
 static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsigned long ext)
 {
-	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) && riscv_has_extension_unlikely(ext))
+	compiletime_assert(ext < RISCV_ISA_EXT_MAX, "ext must be < RISCV_ISA_EXT_MAX");
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_unlikely(STANDARD_EXT, ext))
 		return true;
 
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
index 04d72b02ae6b..7437304a71b9 100644
--- a/arch/riscv/include/asm/vendor_extensions.h
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -48,34 +48,6 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
 	__riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, \
 					       RISCV_ISA_VENDOR_EXT_##ext)
 
-static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
-							 const unsigned long ext)
-{
-	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
-	:
-	: [vendor] "i" (vendor), [ext] "i" (ext)
-	:
-	: l_no);
-
-	return true;
-l_no:
-	return false;
-}
-
-static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
-							   const unsigned long ext)
-{
-	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
-	:
-	: [vendor] "i" (vendor), [ext] "i" (ext)
-	:
-	: l_yes);
-
-	return false;
-l_yes:
-	return true;
-}
-
 static __always_inline bool riscv_has_vendor_extension_likely(const unsigned long vendor,
 							      const unsigned long ext)
 {

-- 
2.44.0


