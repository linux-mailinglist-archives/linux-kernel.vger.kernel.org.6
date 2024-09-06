Return-Path: <linux-kernel+bounces-319254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C696F9BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E336A1C21B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512BA1D4617;
	Fri,  6 Sep 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHa0SEhM"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC11D54CF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642429; cv=none; b=QISm/vcd7md/fP7+bET05zxRcHcwnbCF5zKtMxmggmBnqij1HwTteGzaDZLn+Q6Iyk94HB9JJ/NR0uypMcEXmwZJIm9iLoaYB9kvf6w/DXcUxyBsgo5nlXaPGwK6W1Lxae/nXyACjmiLOXa2nS/3L8IqKK2rxJsWojihL3YYrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642429; c=relaxed/simple;
	bh=5lOko4x++LaiuMBYnIcL5wTu9SP0pMlfceld25rlKVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tpg9ho7Azo1LkeNomcsHmNXscgZOPFmKWCdM2VGS7GadRak93v+y9fj3GJQsvu1CPNZw10rVj/uNfiaElmsxwCIM7rEjsZnZ1FPNaGjmO+t+smSeFTaOOB5dJYGKrT92vz39n0ZLs+nyzZGj2anybFknNKgs7360ZphSK5rUEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHa0SEhM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20543fdb7acso18449735ad.1;
        Fri, 06 Sep 2024 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725642427; x=1726247227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTx9T0QsthgtMWPrZGO+mOSHexmLZhoXS2lkiJJqmPw=;
        b=WHa0SEhMuQ8pn8E5INUqpikR2Tt1viWFy7mjliVKpshvwAO9FoYxacc72L39dBqXWZ
         EoY8O/WJ1taLc7QuGNQSUKQ9QMh7dl8+hAzsspW2n51DDl56XTAsO+Wt4TXRw5of0pg9
         E+0DEi1Js/w8QjycfRqqC0M5aoajJe8idNLuguX7gOcdZ9bKZdqXkyM6kMLweCKXO7Lf
         RR/ydHuPho5kHrbngaPG2scXLQJ52adwgJkuGANWc6sK/DvtFcngg0EmFtXtwahcPb7Q
         /erzK3pVqmDrMN+GJu31lypZvXhroronNRgppd/wzfM2W23GIWjIfm5hHh0aGDSV469K
         UmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725642427; x=1726247227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTx9T0QsthgtMWPrZGO+mOSHexmLZhoXS2lkiJJqmPw=;
        b=ghx7BT47tjWA08OsEemSUJipX1YgO3FMSdDhy0uPFEoOiMFzPuldhvV+dk0JK9JWub
         zpodWZ6LDcvGhK9ckyXHTDjjMIalCeW2z0XDCdlLiGhdVjxEpaWNr2mt//ncFKJRmrGC
         EkkMRl0c494eHIyR9HAwJR5UteiwLhArbI2cJhaFGFuP2TO+hEOSUPh/BcAfDwvHW9mV
         DzYO8Wxh9vmJne1Zji9bTu9AFL7saucmG5HcOaNGPSl01PPRooXM+Pnpu+aq0fMAZFFd
         z/DvXWY3kc6DFCJMgiLsLhGoaqsXSANRxzzZyTnGfSGz2GLJWK4allgM+LQvVzOmftq2
         Ed4g==
X-Forwarded-Encrypted: i=1; AJvYcCV+V3penmUzSf0tvNfciiLl1Vs8wepyPKqrsKzUFlvyzUehCXyMqskeKMfkt7WOpwXpnYx2PJdvPP+eZPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2kOZiDX6aGF0AECU5KNrmhUrx2Lkoa6sD9hICIpLAHkaZG4Ns
	e/G4GYlN6SPAplBgMM4gFY9jdsreVga84xxAUQkGiBMeI60ilARm
X-Google-Smtp-Source: AGHT+IERTbesUX7/1yBRFhwFuSYJdRTeKIeNqOki4t1RHxe3gyPAAVRGKR0xZE0hpM1Bk0E8U8IsCQ==
X-Received: by 2002:a17:902:d4c8:b0:206:9519:1821 with SMTP id d9443c01a7336-206f04e17admr29475445ad.14.1725642427514;
        Fri, 06 Sep 2024 10:07:07 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae965b58sm45317185ad.118.2024.09.06.10.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 10:07:07 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: asahi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 1/2] arm64: cputype: Add CPU types for A7-A11, T2 SoCs
Date: Sat,  7 Sep 2024 00:59:38 +0800
Message-ID: <20240906170648.323759-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906170648.323759-1-towinchenmi@gmail.com>
References: <20240906170648.323759-1-towinchenmi@gmail.com>
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


