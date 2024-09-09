Return-Path: <linux-kernel+bounces-320989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D1B971312
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B4E1F23AED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E721B2EE6;
	Mon,  9 Sep 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY8DQBfM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B01B2ED0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873305; cv=none; b=qbTrpBsn+XAPzUPB3Vo47hZgC30L+SlwvoZA8VxPGNiqnPe6wHD0c+9rZGe0NG9YCbNaRVXCwkuD5+wPvisTCL40i24g2X1X0JTIGXdLC0RwQhBWhN1iGe/PVYr5MFKtMFdQ5jbUiwlZ1Lv8IMc2QKfCh7KR0rE0HAEMFa56m7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873305; c=relaxed/simple;
	bh=5lOko4x++LaiuMBYnIcL5wTu9SP0pMlfceld25rlKVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bniNrtMjxgP6I2tbEbxbGXC0m6iQrye6VDDD9uBPRs1h8Jn/DJUOObvo1qfprj8eDqUwIo6tNBqudkr9Tsn+Fv5dApl+w24AslilJKtLPr+xLuIlaIxZB4R4+OnR18Lw63Rb8xqCjZJMBlQ8Rrlcuc++aUgIllRx/6QMjucRuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY8DQBfM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e482930bso971680b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 02:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873303; x=1726478103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTx9T0QsthgtMWPrZGO+mOSHexmLZhoXS2lkiJJqmPw=;
        b=aY8DQBfMdfDzs9GYGJ4RoZTVNEXZHwR40yCn3ISIytVIkTqf2w6OFTq9Ee3PzltU9R
         Wg0mvkXOz+8JlXooSI9dgK/nZpSdT+kgXUVas3/H8waXmuskTZxrhMbcuwWBfGXhh56s
         mb1edg2W75J2oq/OSGWxDyPQPjYRkrprrWi4LjUIIsE2TlhOzDsqFI8OTI4Y60oLN1z8
         4EhVpL8lVvIrM4yEeRVxOU/WmsIcTs8nNpUQcNjWujbsiI5Kqt+HdARrZwUa7GqDSv1N
         fl6MbEtKbmvFiNX/7jqHJTQ0lOPcia3Il1z5IiEH+cxzz6pu80bV1aPyUZa9CkR/XvXH
         q1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873303; x=1726478103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTx9T0QsthgtMWPrZGO+mOSHexmLZhoXS2lkiJJqmPw=;
        b=Tf+LklPzTdCN+0ELUximZ5aiivY2hlaSKx3FKzGUhaql1CneazflOFnWn/gsdk58Jr
         HNkLEgrMKWZiMgYe46qE1UarQBE3+U9QNA4VC7Jm3jIsNeJZt2JDUHxvXgBQC+9fHJ74
         mNW5R3FFLhGD8bAr9DyhSqbrId8OQTxNope6FTHcYYFD75mD5lcIHbMv39Eag/ZQyPab
         Mox+V/hY6cYIXu4Gzw8eQ+qfL4/2JWc07Ne2LsUUvj/V4NuKH9/KtNHLcmcS0Wz+dp3V
         fRRWM11Y3MN0HzsVseQHVuZ0LgeTXBJ1ycDCqGz8LxeVs4cU/6W6yQmftX6IQTgm+g/m
         H1pg==
X-Forwarded-Encrypted: i=1; AJvYcCVymWDYkZf4XmEG9zdxi0eKxV0wXPLrmZW0FlfuZBRMDBel/krMW1hJoWvy3ZsVJzNOG684CKj9LbJpc1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlbi75ubxraOCUKVmr3pRRhS5zHQuPUpEXS5AJtaWXBqNpwvO/
	TnbofEFNrBX3N8LzZPWTgJDc+djRYqe/Fs7GcRkuhcDV5JIq7tgX
X-Google-Smtp-Source: AGHT+IFyAFMt/LIKFXTa3+bAyovdbUUEGUIYAFMyLkRq/6rL8sAHUjO2qqjXljlfaVO7kyqBr25C4Q==
X-Received: by 2002:a05:6a00:4b4c:b0:70e:a524:6490 with SMTP id d2e1a72fcca58-718d5dedc1cmr14550954b3a.1.1725873302845;
        Mon, 09 Sep 2024 02:15:02 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e596882esm3120689b3a.135.2024.09.09.02.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:15:02 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 1/2] arm64: cputype: Add CPU types for A7-A11, T2 SoCs
Date: Mon,  9 Sep 2024 17:09:59 +0800
Message-ID: <20240909091425.16258-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909091425.16258-1-towinchenmi@gmail.com>
References: <20240909091425.16258-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A10(X), T2 types will be used soon, and the rest are added for
documentation purposes.

The A9 is made in two different fabs and those have different part
numbers, and the TSMC cores are also used in A9X, so it cannot use
the usual naming scheme.

The A10(X), T2 performance/efficiency core pairs appears as single
logical cores to software, so both the performance and efficiency
core codenames needs to be included.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/include/asm/cputype.h | 42 +++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5a7dfeb8e8eb..f1720158a54f 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -129,18 +129,27 @@
 
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
+#define APPLE_CPU_PART_A7_CYCLONE		0x1
+#define APPLE_CPU_PART_A8_TYPHOON		0x2
+#define APPLE_CPU_PART_A8X_TYPHOON		0x3
+#define APPLE_CPU_PART_SAMSUNG_TWISTER		0x4 /* Used in Samsung A9 */
+#define APPLE_CPU_PART_TSMC_TWISTER		0x5 /* Used in TSMC A9 and A9X */
+#define APPLE_CPU_PART_A10_T2_HURRICANE_ZEPHYR	0x6
+#define APPLE_CPU_PART_A10X_HURRICANE_ZEPHYR	0x7
+#define APPLE_CPU_PART_A11_MONSOON		0x8
+#define APPLE_CPU_PART_A11_MISTRAL		0x9
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
 #define AMPERE_CPU_PART_AMPERE1A	0xAC4
@@ -200,6 +209,15 @@
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_APPLE_A7_CYCLONE MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_A7_CYCLONE)
+#define MIDR_APPLE_A8_TYPHOON MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_A8_TYPHOON)
+#define MIDR_APPLE_A8X_TYPHOON MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_A8X_TYPHOON)
+#define MIDR_APPLE_SAMSUNG_TWISTER MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_SAMSUNG_TWISTER)
+#define MIDR_APPLE_TSMC_TWISTER MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_TSMC_TWISTER)
+#define MIDR_APPLE_A10_T2_HURRICANE_ZEPHYR MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_A10_T2_HURRICANE_ZEPHYR)
+#define MIDR_APPLE_A10X_HURRICANE_ZEPHYR MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_A10X_HURRICANE_ZEPHYR)
+#define MIDR_APPLE_A11_MONSOON MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_A11_MONSOON)
+#define MIDR_APPLE_A11_MISTRAL MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_A11_MISTRAL)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
 #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
-- 
2.46.0


