Return-Path: <linux-kernel+bounces-172600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A8F8BF426
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E0A283A58
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD91DF59;
	Wed,  8 May 2024 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rnyj1WR6"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90687C2C6
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132208; cv=none; b=YFmiFmCIR9p0Lp9b/AZyy30f6KSAyCt1WIOHoJB7AjEQwFHbhflO+SEbHjH1sqXI+uGeAM9qTR8cj0GbCkiO7hiizhIe+0e2YA6LRfaZTtxtK0oUo/bP/jozg3ExIijMhzt/BZhIyrc+DsG/LcAVV/5i4ovPHxs/5Cg+gsTL0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132208; c=relaxed/simple;
	bh=gHdAyzxOSw9+j0qkNaNh5cV4dO8gj7MOepOEM8Ai+S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+qyLSyurDITnaluGnlcY++1YNikM1bdOfD5F3V/PIVcVoN/KaCGU/5zyoM1IAHRU1URkCLv+KaDFmGq7MmcFWj62erJ9hd/YgGkxbv2i1vhQ6ka+LMIi6TEV33MP3rs8vr18W2kzvbPizFlEd//94WTfPBH42jfKB3uIJ1Ju0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rnyj1WR6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b33d011e5dso262887a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715132205; x=1715737005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyAjbp499S4E60gPGPnq8+Il/FcfjFcaiJmSSEoBy08=;
        b=rnyj1WR6yOr+oOtaZZf0feZ3/HhH0rkXv+F49VpifOnHWQfkrvO/BKBRMiuCjqzb5T
         gY2SAtMOytdTX4PGWvPWMWvS0et7xCunvJadK1sy5ICAc+eI4Qcw6B8dL8VL0Qhm2TiD
         x8tI6lW9glij/nu8eEonYjvMBZGDcSb5oEgZYel6wi8iPbR5fE3lXkuY8Ub2hMsgRUIQ
         ahh3f+JuAPWTWygFtOG26PcpakZ3QZN7SWwutSZyDpaZ5HPf6SUD+R04C8nsjlj2RRml
         q3N0zQjhw10XIAsGR4cIrHhMz27N/hyF8s5xk9eNX6Khi+Ome1D8w6iC2gzuKa5rfgRg
         r4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132205; x=1715737005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyAjbp499S4E60gPGPnq8+Il/FcfjFcaiJmSSEoBy08=;
        b=h+hQfeozmop0wpPXkdbprXUdeHakdnOa+EBOK8nKZAaKE1OCYFNYYrmdP20zkIj9k3
         HkNfFSmalLtR7o33pLmGCBbgk2eI0aYBxtOCDhawaHJMXgFKs78M9EQyOcjfYPuuNnhi
         fYqNCJMSYV5uxzaKWFYB82azXvPTCM+tjMu2k6PzmopQvUiYhwcR7Cnr0e/gIxNBNMpb
         Qd9jAf3VZ6NBOAyH7fTMaCTvnpuZUd3xKJXBsXchgTSgcDXV3C9qjq46dh7w9TBaYPN8
         tUG8dIZrH2SMedRwg41XFRVVEFTLeGO84Tcn1b17fdwTpzxzHd591kBcPKVhIsoRlygb
         Gi6g==
X-Forwarded-Encrypted: i=1; AJvYcCVNd+ZkCbHO4bzXQ0X/WXnIaBT7vfBnL/mZ6XzX3CQ/67iTRTSMPAPlPw/8clRo/x01rUgIkj/strA5aW13z+x17TUtC1kEI/LXhUJi
X-Gm-Message-State: AOJu0YzLGevrSRgAIAoM3L16BNwSnrFfgf+3LzhDDZfiUOJYfrKmwKW1
	QjmjKeaPXHYFTyngMZo17NEmozdAIu7m0sdWS9MBKkN5SMW0dJKjdH2lSZj6t6g=
X-Google-Smtp-Source: AGHT+IHwXlXHG/dkLoF/6u+zxBIvilwus9SDgdbrJPGXciSar+3njjYMfgBvflCo8Xus0Cl4AWNAgQ==
X-Received: by 2002:a17:90a:1001:b0:2ad:f3c3:540d with SMTP id 98e67ed59e1d1-2b611aecf9amr1982459a91.21.1715132205449;
        Tue, 07 May 2024 18:36:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a265sm171994a91.10.2024.05.07.18.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:36:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 May 2024 18:36:29 -0700
Subject: [PATCH v2 3/8] riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT
 Kconfig option
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-compile_kernel_with_extensions-v2-3-722c21c328c6@rivosinc.com>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
In-Reply-To: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715132198; l=4526;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=gHdAyzxOSw9+j0qkNaNh5cV4dO8gj7MOepOEM8Ai+S4=;
 b=n798W2bBPAkZ1DxRbCdpbApDgPYqiZBBEqfBDG7kgws2qQjYG55u+NOtwPJkJ2zwoa3y5JfGj
 1/3Q87QUPqFCAhtwHtP01IYlaKmSvNxxzdLntEkAIGs00uPQ9WLzkTG
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The existing "RISCV_ISA_SVNAPOT" option is repurposed to be used to by
kernel code to determine if either
PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT or
PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT has been set.

PLATFORM_MAY_SUPPORT_RISCV_ISA_SVNAPOT will check if the hardware
supports Svnapot before using it, while
PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT will assume that the hardware
supports Svnapot.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig               | 19 -----------------
 arch/riscv/Kconfig.isa           | 44 ++++++++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  3 ++-
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c2e9eded0a7d..3c1960e8cd7c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
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


