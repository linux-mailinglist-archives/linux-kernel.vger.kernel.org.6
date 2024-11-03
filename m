Return-Path: <linux-kernel+bounces-393730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A22C9BA488
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C85D1C210C3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2E4157490;
	Sun,  3 Nov 2024 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acZ/WZ1R"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69711632FA;
	Sun,  3 Nov 2024 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730620243; cv=none; b=BPn/zmvmreazFgB9clXZK6+wyBM+3cNtntLZH9hvvCd88eAdjGeiUDG1cnLIerxjAG1UXLaKYXXUsLCHXiK0T06/g9arglaFXW9Prp/VpaTB3T0gopTsUIWIQHOcaaKcVFgfOV/1OEHrlM3yWXKIEOL6SbHkeZ0z5hpQ5ba3n8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730620243; c=relaxed/simple;
	bh=hO+JLZUZHgk4cSEIMkVkf+UtlSQr0K+8x3HKcFiWJgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbGZ7TkZN7CRmHOEL4yxLAx74Mju4Qm+4k7pYIKqCUgZAm+JFvaE6hIcy6sC0nkOUsL/svYZguI5K8S33F4kQhxE/ZCrkAwEX1PbE6wVY/4d9+vBZmGy8WRfNyLGqKE7BGs64wmWBH1v5F1UDVLLUHoDf8zbDJfSdACFs7IT264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acZ/WZ1R; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so2787210b3a.0;
        Sun, 03 Nov 2024 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730620241; x=1731225041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKC325jeeb+bVADWaZpPiV68gFL/gz/ByL8ImcIeld8=;
        b=acZ/WZ1ROWTRZiXEsSE8u2JYrOpjHYKQgoKt7gOSMmRXyVHIYq+5955T9ai7kSOEGQ
         /XePj+R3w0tAcxFTptEDDWppuRiwbfVbGRC2icr6gHvZ79X4KkJZl/NtH2zQwSPQT/h9
         wEFUaIHVh4WxT9k8eIe9KHk8cMRDgBWDSKDxtHDPyGZgK8wiIKTemW207WcPatDq+aTT
         xkS164FTNXEGQtQnRIfbKRcN3xqnv9HnoMzAvnytX2wFo+AoDaUNOaLvwJCDLEZKRqa0
         nCnoNBkAxyvr8VyOYmJDNhtqFqtzxRAhb1Taa71UMAk4sA5WmKPYBLUZpsBhEbVq9GJX
         y/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730620241; x=1731225041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKC325jeeb+bVADWaZpPiV68gFL/gz/ByL8ImcIeld8=;
        b=r4/ia18oRP1hxoP/oqBqb7V0XWqJkCntB6SA2MMMi+R6LNBhSfAhb6aG3M+CZjY1oG
         cMLJGqZckQgL2U+62g7aKJugdsSAmFc5Px5IFd3DV97KlBLO2nxch11ME8rMlsStaRDO
         n1N3TZxwSiFPz+krRjyyExb5j/Yu1W4eJaY/qosnchaUkgsWODa+iiv75mcz6r23Rj3G
         agJrIrpxOVljV0Q75dPNQQWMgfZDdQp7/F7nYyDDaF/UmEJP/t0bwvl8AU8kLf7FUkLT
         fY25KVAfr7xUhvkK2uWOk7P54tdj05ApelMudqj1vIBUKtfOYDjTFIARv9hiNZbM8hL6
         b46A==
X-Forwarded-Encrypted: i=1; AJvYcCVg92JAShY2DhKQw/pWnvtFOZgsmknpgmayhDOE6JXCtKWXfxCCUrBjh5Mq3s8LtpwSjgd09SFmsxWd@vger.kernel.org, AJvYcCXqxPW9LG85CTMG3UKokX2NdupUroEVSwW/7p87uyvtyEfGLIhXirDorhLkRzsz/ptl/uPxMp6VbCGpdLlI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzek7fotCzeEPnZusySdiFllpsIKQn+Jd4+Yo34dnlnSzBQOYSS
	O6mH7SHs7t2t41fjUlRTBsPmPUKynrzT9qJSNUMOKjNH+PxivhZW
X-Google-Smtp-Source: AGHT+IEKYPq7oqoeSULfZN24QbWKB75bFPKLNJo6fZCRP1KNJw6SX/2/tkgq6QHogIYQMwPXETbmyQ==
X-Received: by 2002:a17:902:dace:b0:20c:5cdd:a91 with SMTP id d9443c01a7336-210f76d6870mr236020995ad.41.1730620241063;
        Sun, 03 Nov 2024 00:50:41 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056eda2csm43041595ad.49.2024.11.03.00.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 00:50:40 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andybnac@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 3/3] riscv: hwprobe: export bfloat16 ISA extension
Date: Sun,  3 Nov 2024 15:49:57 +0800
Message-ID: <20241103074959.1135240-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103074959.1135240-1-inochiama@gmail.com>
References: <20241103074959.1135240-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export Zfbmin, Zvfbfmin, Zvfbfwma ISA extension through hwprobe.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 12 ++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h |  3 +++
 arch/riscv/kernel/sys_hwprobe.c       |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 85b709257918..8c30dd06f3c0 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -239,6 +239,18 @@ The following keys are defined:
        ratified in commit 98918c844281 ("Merge pull request #1217 from
        riscv/zawrs") of riscv-isa-manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZFBFMIN`: The Zfbfmin extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFMIN`: The Zvfbfmin extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFWMA`: The Zvfbfwma extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
      mistakenly classified as a bitmask rather than a value.
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 1e153cda57db..95d00a065b4e 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,9 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_ZFBFMIN	(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZVFBFMIN	(1ULL << 50)
+#define		RISCV_HWPROBE_EXT_ZVFBFWMA	(1ULL << 51)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cea0ca2bf2a2..de1966bd1776 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -131,6 +131,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZVE64D);
 			EXT_KEY(ZVE64F);
 			EXT_KEY(ZVE64X);
+			EXT_KEY(ZVFBFMIN);
+			EXT_KEY(ZVFBFWMA);
 			EXT_KEY(ZVFH);
 			EXT_KEY(ZVFHMIN);
 			EXT_KEY(ZVKB);
@@ -147,6 +149,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZCD);
 			EXT_KEY(ZCF);
 			EXT_KEY(ZFA);
+			EXT_KEY(ZFBFMIN);
 			EXT_KEY(ZFH);
 			EXT_KEY(ZFHMIN);
 		}
-- 
2.47.0


