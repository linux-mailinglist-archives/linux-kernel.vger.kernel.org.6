Return-Path: <linux-kernel+bounces-170561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10F28BD924
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E9E1C21BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98242AD54;
	Tue,  7 May 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OYvD8wYI"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C54C90
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046166; cv=none; b=uL2R7ifpx2cp6zTE40VpMtPFGCUpU/0TRnh9Jn7aMc4kXScBYXfS6WYqSinx4+XBNTHrf6BH1NGwatL0a6FPi5SQlPjB+f6cpA3cZN9uOrH0yyqnDm1EpUcZXe2a/BWOveZGIoaFdXY6bLdnrmVn2wOnNGOvc1ZlpVT6yDwGCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046166; c=relaxed/simple;
	bh=qAYZSJKQfo6KGBAG143+WCG6TYn1nYEXzCXt3LEyG3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbNS2+xk8goL+KTUnAA/HBgepE4KnKoUr/h+ob9X8GEGiPBzwZ+X9mS0mrEJfdN9SqPB2/lcBOaXB1n0UwmDmSMCDni766Pedf2L8ObHileNcPL+82NXCHZCHpyV9jjrS0rQZ+EHhbVVLJAAjaH3n+9DkNKYN+w/XhzPkOTWEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OYvD8wYI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b38f2e95aeso3374565a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715046164; x=1715650964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WABN/DyVMubZMdulfTheMLTH5TZr96UUGzB/KSHHr2M=;
        b=OYvD8wYILN6CuiCiuR1ahcg+mBVJQtqwSJm8yE6pHiTQklxvrrght6xhF4bpaEq4Nd
         1aUDrw9iY+7TI5SYBCoX0UQYfs+AE8ecpBom0Fe3f/dqYR51kF+Ih53o3F0VNtE0LXIV
         JzTiqioqwSiiKrFfs4QtQwh4x4+pAiJiLyNv1i4nNcxjCORGyVNhU9JtD3NOJs88S4gH
         1nFWQYuyeGl6R1Q/PqGzmVBlSIs6rLzk6l4HKC6a1NmDf9Qa5MhDQiWoqhilwNZO20aU
         CIOOQ2rS9/1l+KDZfXojQ9UDgVoBBYfZKPcw712KVASbeL/72p1HR7CrVSl7AEVsJzM7
         lCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046164; x=1715650964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WABN/DyVMubZMdulfTheMLTH5TZr96UUGzB/KSHHr2M=;
        b=tP8gttZBKXo4hlzylv/8nhVdyQALNBFWpd1U1N0sBR4f8S82JJUHKXJ9fuTCglK45n
         wfF6HkZ1VMP2V+VSW7J3k0YqYLWB49Di+INm/1AneaEzgGjl9F45K59pY7KwrCJr6opw
         NSqRF6M1u7ap4LkHoDwcRoUFxeRqLoRMSgpKJFfg/QzdEPNIUFTwO0nJ947H8KrkFJ0D
         BF4KbucpEY8b11RffGp6h/4HqqBUcvNtyZ6GhYSbQsIlKoyDbWN13x05PaI2kEEz7SlS
         7dFSpPW9CwuktHwXyfS6nfLC3QfeUstLBwBFhO2WvGSgEnfVKbYfh02A+f/Wy12E/agh
         L3xg==
X-Forwarded-Encrypted: i=1; AJvYcCVtHAouzdIp1XprSehJnMFDpcz4j97BeoEA7HYI9aA/dYmxqaLYuxUmGxmW6sXlTLoQfvk/pNpnvx5s7ykCSGyUmklNiBHuzOqMkEPe
X-Gm-Message-State: AOJu0YxbLuIiqWuA2pcO+TZI22E3lSpGHsHsYpqZFaPGOYnO7gwyddY5
	UgK9ytqyuUsmqWUELGYGKwdht/0GhFH96wQae7sc7zrlRhbxUpWIxuSvo7CkGQs=
X-Google-Smtp-Source: AGHT+IFZ1scUzbuEqN66Ol90xyUVgNHeMyyZi+HIv5KQYsgIR1rnTKs0egQjffSyS6hOuZPi2utSfQ==
X-Received: by 2002:a17:90b:94f:b0:2b0:9544:59e7 with SMTP id 98e67ed59e1d1-2b5bc2c9156mr1704507a91.23.1715046164132;
        Mon, 06 May 2024 18:42:44 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001eb3f705ddasm8915311plx.255.2024.05.06.18.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:42:43 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 06 May 2024 18:40:44 -0700
Subject: [PATCH 3/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT Kconfig
 option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-compile_kernel_with_extensions-v1-3-5c25c134c097@rivosinc.com>
References: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
In-Reply-To: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715046158; l=4952;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=qAYZSJKQfo6KGBAG143+WCG6TYn1nYEXzCXt3LEyG3U=;
 b=AvAZPB6bKKxnhol7r99rPIU1Pp2DEmoyg2c6T9E0ATto3yAcQP2LL90sm7dlTt4exCfuHixAo
 ntqpY+6BJPTD2LRKfeuz9WcTRYfwxclkgO17m1GznmGptTENuDnO/53
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The previously supported config RISCV_ISA_SVNAPOT has been renamed to
PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT and the config
PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT has been introduced to compile a
kernel that will use svnapot by default. Both of these configs select a
hidden CONFIG_RISCV_ISA_SVNAPOT that can be used to determin if SVNAPOT
is allowed to be used.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig               | 21 +------------------
 arch/riscv/Kconfig.isa           | 44 ++++++++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  3 ++-
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c2e9eded0a7d..9c3a4347953b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -63,7 +63,7 @@ config RISCV
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
-	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
+	select ARCH_WANT_GENERAL_HUGETLB if !PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
@@ -484,25 +484,6 @@ config RISCV_ALTERNATIVE_EARLY
 	help
 	  Allows early patching of the kernel for special errata
 
-config RISCV_ISA_SVNAPOT
-	bool "Svnapot extension support for supervisor mode NAPOT pages"
-	depends on 64BIT && MMU
-	depends on RISCV_ALTERNATIVE
-	default y
-	help
-	  Add support for the Svnapot ISA-extension in the kernel when it
-	  is detected at boot.
-
-	  The Svnapot extension is used to mark contiguous PTEs as a range
-	  of contiguous virtual-to-physical translations for a naturally
-	  aligned power-of-2 (NAPOT) granularity larger than the base 4KB page
-	  size. When HUGETLBFS is also selected this option unconditionally
-	  allocates some memory for each NAPOT page size supported by the kernel.
-	  When optimizing for low memory consumption and for platforms without
-	  the Svnapot extension, it may be better to say N here.
-
-	  If you don't know what to do here, say Y.
-
 config RISCV_ISA_SVPBMT
 	bool "Svpbmt extension support for supervisor mode page-based memory types"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/Kconfig.isa b/arch/riscv/Kconfig.isa
index 0663c98b5b17..37585bcd763e 100644
--- a/arch/riscv/Kconfig.isa
+++ b/arch/riscv/Kconfig.isa
@@ -124,3 +124,47 @@ config RISCV_ISA_V_PREEMPTIVE
 	  This config allows kernel to run SIMD without explicitly disable
 	  preemption. Enabling this config will result in higher memory
 	  consumption due to the allocation of per-task's kernel Vector context.
+
+config RISCV_ISA_SVNAPOT
+	bool
+
+choice
+	prompt "Svnapot extension support for supervisor mode NAPOT pages"
+	default PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT
+	help
+	  This selects the level of support for Svnapot in the Linux Kernel.
+
+	  The Svnapot extension is used to mark contiguous PTEs as a range
+	  of contiguous virtual-to-physical translations for a naturally
+	  aligned power-of-2 (NAPOT) granularity larger than the base 4KB page
+	  size. When HUGETLBFS is also selected this option unconditionally
+	  allocates some memory for each NAPOT page size supported by the kernel.
+	  When optimizing for low memory consumption and for platforms without
+	  the Svnapot extension, it may be better to prohibit Svnapot.
+
+config PROHIBIT_RISCV_ISA_SVNAPOT
+	bool "Prohibit Svnapot extension"
+	help
+	  Regardless of if the platform supports Svnapot, prohibit the kernel
+	  from using Svnapot.
+
+config PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT
+	bool "Allow Svnapot extension if supported"
+	depends on 64BIT && MMU
+	depends on RISCV_ALTERNATIVE
+	select RISCV_ISA_SVNAPOT
+	help
+	  Add support for the Svnapot ISA-extension in the kernel when it
+	  is detected at boot.
+
+config PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
+	bool "Emit Svnapot mappings when building Linux"
+	depends on 64BIT && MMU
+	depends on NONPORTABLE
+	select RISCV_ISA_SVNAPOT
+	help
+	  Compile a kernel that assumes that the platform supports Svnapot.
+	  This option produces a kernel that will not run on systems that do
+	  not support Svnapot.
+
+endchoice
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 6afd6bb4882e..432be9691b78 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -289,7 +289,8 @@ static inline pte_t pud_pte(pud_t pud)
 
 static __always_inline bool has_svnapot(void)
 {
-	return riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);
+	return IS_ENABLED(CONFIG_PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT) ||
+	       riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);
 }
 
 static inline unsigned long pte_napot(pte_t pte)

-- 
2.44.0


