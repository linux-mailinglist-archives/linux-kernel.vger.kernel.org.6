Return-Path: <linux-kernel+bounces-257479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA6937A99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DF81C212FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB2146A76;
	Fri, 19 Jul 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MwobOj6G"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9C2146586
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405745; cv=none; b=gf/hELNwlGNnVjJnojo3egC6gKDAEkT6bvdml+9uJHYL4KiwBMHsHAXMhj/Eg2E9Fn7WxamWkb1iFIwbhmsq7HfkKh105w89aGmg6UEsTKNdQfGlJFLc3f2EMTAWSebd8CdKse9jtk4r8C6JdORqEQXtHNzrNJUe0bJHHRICjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405745; c=relaxed/simple;
	bh=VELsK6+NYlG6ohY7i8cf0siRJjQKrAmnxmUeW45ryEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4m1D0/etE3LaNqINhQJFHCxbYzI39HuZAPgWD/22QSEBETlQdEwtfyi3dv02DNoPNl7f5G2B9J6MsKIWkzIQqh/a5FvQUSf+qEg+Wpt5I0un8s+soILRCfiPboehmTq7Q7y9RH0aic4OTghpycuvk7yDZpyofUTMVPKzaOGqF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MwobOj6G; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1372796a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721405743; x=1722010543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRRmyx6bhYwfddPBwXx183tDvz43JuYtypdCBENKCpM=;
        b=MwobOj6Gnj7t1OSREHVD9B7Hmsl8QbpXvh+219JlatByfbuXJ8Cr5jIAKMW8sPu4+o
         BbXNupCJV4YUeePvfjNg4ftMchVT7LXwplQHbs/Q5/+D2Zm5y33VdP6d0e0RrUkgDN4E
         BjnGPrYn0+ZAVWiwys7eDicjQ6ET4VbCnwtIVYty4xZaz4wRZW/m4t0nWg6Me5y+c/J0
         FwMFHtRRu9e2f1c+3gpXHjg3DiScqIuNJRV4/ewZu51GToreEGSyB/jVbFfaeHucw8jN
         lJFjoIhK+di8qQ22VrfDr+WngVgmeRWOaZJ53cBNqs68vgNgOo9pigICEYyFa8BRFJoz
         bsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405743; x=1722010543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRRmyx6bhYwfddPBwXx183tDvz43JuYtypdCBENKCpM=;
        b=fKRaM4sU9oIK2o+StdtwVCUIfPyFq/oi+/vOO+/IkK0TQ2IrlxTMShd4+Hib8CtnFD
         KmEfZruRSf0KCYcwofWqzebB0bpCnt5zh9e5kxvKPsCAYD3ue43StDOLrYtLW1vNXR5j
         MrdLHthSFNsW/GyayZ5L92la5CMcAdNMc0+F1NCPvJfAT+5Scl+DqtazKHRiTwssfPWc
         EbeaG3m59R2s8llx2XdNAOMAbqORtIxVPojXRoVu9KFeXeMgE7375WDpFnVTMd5c96yC
         K35FsMxXdmctGu+3NLW7c7gnRC/ueqxyVM0N9n9Vpg6mosBBD+89Wi5x5+1dHqCWWPaB
         n5gg==
X-Forwarded-Encrypted: i=1; AJvYcCU63/7JC0r6mkXZWHCU2UDVzLwg4uSYyhmjxeve0ch1bddRRZzP7ruWnxlFJY3r8az3CiPwlXYwki+l9d3/lgnJcxu9crGGkQ9kwTw7
X-Gm-Message-State: AOJu0Yzx5Z3d+XsJEav6HsLmcAS0pZYi0I1yBeZoxkFpegP42ilzLAKd
	68FS2Iz0e7r6m0rKurleIJFzJE++eX/pVdamakiAOVPysYJMsy3P6zF3HId/Hn8=
X-Google-Smtp-Source: AGHT+IEn/cl4Oa98tqZHk9E+jXd2J2XznEyPxdqB5+rcwyJN0sdt94LS9Ixym0GAk7cBek17P2bHaA==
X-Received: by 2002:a05:6a20:2d10:b0:1c0:eb1e:868e with SMTP id adf61e73a8af0-1c42289e725mr606567637.19.1721405742799;
        Fri, 19 Jul 2024 09:15:42 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0ad73cc4sm579589a12.29.2024.07.19.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:15:41 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 19 Jul 2024 09:15:21 -0700
Subject: [PATCH v3 4/4] riscv: cpufeature: Extract common elements from
 extension checking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-support_vendor_extensions-v3-4-0af7587bbec0@rivosinc.com>
References: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
In-Reply-To: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721405735; l=5672;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=VELsK6+NYlG6ohY7i8cf0siRJjQKrAmnxmUeW45ryEc=;
 b=42jxLHbFmX4mjOuT2MtOGGYkWug50AUQUQbg47HIKLnqrEBFZMyPfvTRq083wDRhQJVvHhF8t
 4R5krn3bediAkRBlQRxvPr/73cBZYgfeMFGv2mISM8ziNCkK7ILNhmx
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The __riscv_has_extension_likely() and __riscv_has_extension_unlikely()
functions from the vendor_extensions.h can be used to simplify the
standard extension checking code as well. Migrate those functions to
cpufeature.h and reorganize the code in the file to use the functions.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/cpufeature.h        | 78 +++++++++++++++++-------------
 arch/riscv/include/asm/vendor_extensions.h | 28 -----------
 2 files changed, 44 insertions(+), 62 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index bfe7c0b881e9..45f9c1171a48 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -104,59 +104,66 @@ extern bool riscv_isa_fallback;
 
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
@@ -164,7 +171,10 @@ static __always_inline bool riscv_cpu_has_extension_likely(int cpu, const unsign
 
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


