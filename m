Return-Path: <linux-kernel+bounces-180387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D88C6DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA01282D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC8F15B999;
	Wed, 15 May 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nY3hLGFF"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAD15B579
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715808396; cv=none; b=CPr2xGUt6G58ZGvillRt3wubNBnBUtlbEmcSUJIyGKp3hurfRPXjln5SzmJz8ZVbxpRWkW5dE2y6IM0q5ARzG+tjCob713imCouCmt/H8vFFqCtin5ZEuaDhrmMAXd3VwczWin6Iy0T6EVdh4D0GF7HVWMezGgfdaIDqynphQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715808396; c=relaxed/simple;
	bh=p+999qomFpgC+1QPBVR4U3Loq/+tlgQihw1MdjTQtgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5E7NsexMVjDR+3wh0jdPQoov6OVxvY9arI33xgaWM+ze1LpxkjBvuexOUejIX11rIWaoJKGHfY9XdDbkpbbexvHPBSmsl1SQwMQexqnYZretu9CQ5dbAGbz8e6oLRJQnqwzuw+EFtxxZZzPgCxhNQYwrVzh4bki+KO75LRBgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nY3hLGFF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so6033913b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715808394; x=1716413194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdYFoFjeOLfZ5ODsfLOrb3QUJFvf95EQYI0EaFj358o=;
        b=nY3hLGFFurbw+0bXBJBrQ5ALG4mirhacLK3hniScp07CjXbEtsHlTdojDBPuu8Du9W
         EqpJLdyKfJA/gzkIOwaFwBDwH+1CgsEYV/h3rIVCQrQbM5i8O3iC3TSOFlHfle3UXJWh
         LBcArIq8GK2GndxsU7r6a+ulWCmsNSBkqrHSeGUYTcQD5curfg+wR0JHa05W0w4uoCjb
         Fw4GAQcBxOg4JwOB63qvo/jGj7xxsz7BPWXb3ErdTV3N7+GDwwIEv9gdMeca4BnQH7j2
         AJub2L0Cnjfg4MlJRzKYGhd5eZN0gcHR9HJzkOa2BQrBG0006MfwdaZdfgu1KzrfO+9j
         BW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715808394; x=1716413194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdYFoFjeOLfZ5ODsfLOrb3QUJFvf95EQYI0EaFj358o=;
        b=eI1LgyuQKhEf5D4YspVKsUvebfMmifqZhXj4DmOV3ytxY084rzANvIKkwh3ovt55Zu
         4F1ZPPRySfofwV4AjvhYO97zlcKTo0ww6X7u79zP5gb7XoGV6jny0KQu1b+EzlBHJEmR
         323pnfXk9xAD4NYpWcMBzrKbdnm3P3gfDiAWRN/IA/YT7V30/T9w7/Wd6xZT2jbCibMA
         uX/KWd+fzCMJOJmwkSppnWq9g+nhZOGAzbFYHr+X8u6F2uYRNCd8PvPTePtd9RiIwQuK
         f1GxUIg5S6lC7u8xRBCG6DgLaJlnHyRxxujMNxgJQx2YsDDT+Of/E25ZivEjsYL7jP3n
         6UHg==
X-Forwarded-Encrypted: i=1; AJvYcCWznp0rv86GeewnLu8r5xax8Cm1J40mXrbNx/ifHybldYwmv+s4TTB8Zu8M79r7auOraOmgH+ZO2L0x5vFXSfgMLJOog/Qg2Qg2DQAr
X-Gm-Message-State: AOJu0Yxg0XznFb+KRfo/GSYwclESnaRa9lFH8DluaqJdD6HJu9PcodPZ
	5yvKnoRgj7WEqBRJ4h6h0T6kqYmnBLnttM3GSeUkBw9FC51pOS+pjBQCH67DdjM=
X-Google-Smtp-Source: AGHT+IGllU5Sjdn4D74vK0WmiKeWhr9IivQ0MVkNtABqO2Gg8t9xMx5YjBgNz4JhoD2mNu8caA46SQ==
X-Received: by 2002:a05:6a21:890b:b0:1b0:225:2b2c with SMTP id adf61e73a8af0-1b00225ba86mr10446547637.13.1715808394473;
        Wed, 15 May 2024 14:26:34 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b30sm11970243b3a.146.2024.05.15.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:26:33 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 15 May 2024 14:26:16 -0700
Subject: [PATCH 4/4] riscv: cpufeature: Extract common elements from
 extension checking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-support_vendor_extensions-v1-4-b05dd5ea7d8d@rivosinc.com>
References: <20240515-support_vendor_extensions-v1-0-b05dd5ea7d8d@rivosinc.com>
In-Reply-To: <20240515-support_vendor_extensions-v1-0-b05dd5ea7d8d@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715808387; l=5623;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=p+999qomFpgC+1QPBVR4U3Loq/+tlgQihw1MdjTQtgg=;
 b=nvAv/0LgY6kSiMCHuWGhyPONt3JRLfURhijQYBNGtpiA/+Dzo7zJIn4kc3vJOP6L6e1AmnmTf
 Od31m1W2ikaCwSVkcCJneMyoWiEMl/8gLTK+287SGDd9fAVIyDcJXsi
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
index a6959836f895..d21e411d7338 100644
--- a/arch/riscv/include/asm/vendor_extensions.h
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -47,34 +47,6 @@ bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsig
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


