Return-Path: <linux-kernel+bounces-306549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA5796405A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE891F26246
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357418E356;
	Thu, 29 Aug 2024 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir1hcivF"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DEF18CBFE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924249; cv=none; b=pjEk+2Rq/DjXonEEJx5JS42EBI9dhTqT1LYO0fpdxI8jkl23piqTvAWeskJVhu+3sdt8yzqW72CUPSya4oU0G88Lz48b+Su8b9I/UPkWyBtiCtSiW7h4SIqTagEE2YE+MtVRglpCXy3krzfyqeZr+9Hpv5IEIDJPuxnzjP7qLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924249; c=relaxed/simple;
	bh=wzVEYIyVLU/XUqpOixwiCuSzjP5LWtzillnjfCOab+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kk6sUnclOB7utX7NGnJQaOa6auC5W26CbBlyjNjUvmLLoTx+M5nKHndzihCLaKN6P5UC1HMrcTmze0QvyydlfYpi2MvgBd55VkBgFWtJ2I9Pc1CFrXeWzrspqFUC39puewqQ4QH/q8GIummKzkcdnFR+lLmG09cbqXbCZoygXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir1hcivF; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d69e2a88e8so312201a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724924246; x=1725529046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2rR82lQzAfdYfNO08CkdW0mj+2M0U77o3AfbVOEAdo=;
        b=Ir1hcivF7IBM6f0oVS5h1Fb66vbv4TAy6MypIzSdKesZI89t8uGd6/EpETD4PEvJ2N
         nJxoaTFNRVPIv7z3sEMgnlluxY7VYk0SKrJ9Z0TRaupGa+5jCnxxRUNKRCqJgyDj+o5Q
         oFmn9kA0u33ocRT7DuGvQKYJYP+HkV4llx09kZrzlk3fRTQVGzSkyyweAjxKw7cpga7c
         DlSRr7pmR7SXWox+WPcD3QnCPq+92DwN18BLV2t0ldk+H9/pX0zLHxUFIcUygXtG1AUL
         TX9djnvq7daNmKYspoywYGBbPjYLAouM3g3ObBSAxz3ERkXvPEUHImLaUvLkM9bRblGL
         qrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924246; x=1725529046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2rR82lQzAfdYfNO08CkdW0mj+2M0U77o3AfbVOEAdo=;
        b=MT/yplNU5iWDH5D2FGmesoBISY16NtG5byWFyByEU7/Wo00dxooHrrzrsBFmKgTBJh
         s6mTQVQoi3bZnJkrX/66CEkVH9TbwFS37rc/ThZG1yxGFV/aMer1ElKFzpMIgjMTlb+w
         m4epfaZWzk6ZhXppo6IIQCXtv3k8d/GUbS7/FNBH+C2AHceNKdJ/glx/svjzDRt98d78
         35v/Oa7j3bmIk1dXDtEPutp9rB+6+npTi+HtFhe7x7a2ASt9+LeK5EfbPCeh2nuk2WuA
         rrV7CAUWOBVf5JtkB3TxHEus01+NvkjFYcQAXWj49JPBALeJt2WV/sOa1UC5DNYvXsS7
         wyww==
X-Forwarded-Encrypted: i=1; AJvYcCUd/ATVEkJm5v5FvBrM1SHd3lzgCKCRLnPmtG3QuItc4AyKQqBN2p08IS9Cfaw9tqrAqsfLLivZVX3R5Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1zf/Juoh/y/8pxpaZYiXDHEd21ptwoJml9X/gtQVs72G0PWnv
	onGE3bfN6i+36yaenYGX8o3p177o5QfoLz5310CtrpTvcyYhIApdM5H6iwRZymo=
X-Google-Smtp-Source: AGHT+IFkitwbJH227y2ThXZiowMXdKGU0i1Pl7ZI6auE2pQpK6E0w2GKgfLaxRn/ED0cO1gqwDnTbg==
X-Received: by 2002:a17:90b:3e8a:b0:2c9:7616:dec7 with SMTP id 98e67ed59e1d1-2d85617be6amr1938802a91.6.1724924245615;
        Thu, 29 Aug 2024 02:37:25 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d85b133e0csm1087071a91.25.2024.08.29.02.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:37:25 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [RFC PATCH] arm64: cpufeature: Pretend that A10(X) does not support 32-bit EL0
Date: Thu, 29 Aug 2024 17:34:22 +0800
Message-ID: <20240829093636.100840-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Apple A10(X) consists of logical cores that can switch between P-mode
and E-mode based on the frequency. However, only P-mode supported 32-bit
EL0.

Trying to support 32-bit EL0 on a CPU that can only execute it in certain
states is a bad idea. The A10(X) only supports 16KB page size anyway so
many AArch32 executables won't run anyways. Pretend that it does not
support 32-bit EL0 at all.

Note that this patch does not make sense without [1].

[1]: https://lore.kernel.org/asahi/20240829092610.89731-1-towinchenmi@gmail.com

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/include/asm/cpufeature.h | 18 ++++++++++++++++++
 arch/arm64/include/asm/cputype.h    | 28 ++++++++++++++++------------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 558434267271..447c4d598797 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -595,6 +595,24 @@ static inline bool id_aa64pfr0_32bit_el0(u64 pfr0)
 {
 	u32 val = cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_EL1_EL0_SHIFT);
 
+#if CONFIG_ARCH_APPLE
+	/*
+	 * The Apple A10(X) consist of logical cores that can switch between
+	 * P-mode and E-mode based on the frequency. Only the P-mode supports
+	 * 32-bit EL0. Pretend that the CPU does not support 32-bit EL0.
+	 */
+
+	static const struct midr_range hurricane_zephyr_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_APPLE_A10_T2_HURRICANE_ZEPHYR),
+		MIDR_ALL_VERSIONS(MIDR_APPLE_A10X_HURRICANE_ZEPHYR),
+		{}
+	};
+
+	if (is_midr_in_range_list(read_cpuid_id(), hurricane_zephyr_list))
+		return false;
+
+#endif
+
 	return val == ID_AA64PFR0_EL1_EL0_AARCH32;
 }
 
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5fd7caea4419..840ecaea9b79 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -129,18 +129,20 @@
 
 #define HISI_CPU_PART_TSV110		0xD01
 
-#define APPLE_CPU_PART_M1_ICESTORM	0x022
-#define APPLE_CPU_PART_M1_FIRESTORM	0x023
-#define APPLE_CPU_PART_M1_ICESTORM_PRO	0x024
-#define APPLE_CPU_PART_M1_FIRESTORM_PRO	0x025
-#define APPLE_CPU_PART_M1_ICESTORM_MAX	0x028
-#define APPLE_CPU_PART_M1_FIRESTORM_MAX	0x029
-#define APPLE_CPU_PART_M2_BLIZZARD	0x032
-#define APPLE_CPU_PART_M2_AVALANCHE	0x033
-#define APPLE_CPU_PART_M2_BLIZZARD_PRO	0x034
-#define APPLE_CPU_PART_M2_AVALANCHE_PRO	0x035
-#define APPLE_CPU_PART_M2_BLIZZARD_MAX	0x038
-#define APPLE_CPU_PART_M2_AVALANCHE_MAX	0x039
+#define APPLE_CPU_PART_A10_T2_HURRICANE_ZEPHYR	0x6
+#define APPLE_CPU_PART_A10X_HURRICANE_ZEPHYR	0x7
+#define APPLE_CPU_PART_M1_ICESTORM		0x022
+#define APPLE_CPU_PART_M1_FIRESTORM		0x023
+#define APPLE_CPU_PART_M1_ICESTORM_PRO		0x024
+#define APPLE_CPU_PART_M1_FIRESTORM_PRO		0x025
+#define APPLE_CPU_PART_M1_ICESTORM_MAX		0x028
+#define APPLE_CPU_PART_M1_FIRESTORM_MAX		0x029
+#define APPLE_CPU_PART_M2_BLIZZARD		0x032
+#define APPLE_CPU_PART_M2_AVALANCHE		0x033
+#define APPLE_CPU_PART_M2_BLIZZARD_PRO		0x034
+#define APPLE_CPU_PART_M2_AVALANCHE_PRO		0x035
+#define APPLE_CPU_PART_M2_BLIZZARD_MAX		0x038
+#define APPLE_CPU_PART_M2_AVALANCHE_MAX		0x039
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
 
@@ -199,6 +201,8 @@
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_APPLE_A10_T2_HURRICANE_ZEPHYR MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_A10_T2_HURRICANE_ZEPHYR)
+#define MIDR_APPLE_A10X_HURRICANE_ZEPHYR MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_A10X_HURRICANE_ZEPHYR)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
 #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
-- 
2.46.0


