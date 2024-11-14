Return-Path: <linux-kernel+bounces-408569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872D59C808E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6F5B2501B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ED71F4295;
	Thu, 14 Nov 2024 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a6aX9Rmz"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75671F1304
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550902; cv=none; b=oTx7gbmE8PQlk/rl3z/Uto+o2zNP/5rOc3iflNB5fmZ65i1z2j45QOeW+lSAb/MpVMWCuMAnbCglnCGs0u7NWpid6QCEcL1f5lexfGv00+raSqKj5Yp62GNZxwt5khSnNJDkFwt2fapWXuvT3DKwU8WzmMLebGkHPQ+4iFYfyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550902; c=relaxed/simple;
	bh=VR9AmJvGpk1N7CP/1hUyvJH4L27RWkW4yFjRM0+QHhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtYXNbE7NMYlsHIcDI+lOvyewYJ8GNwW0WDnci/N3QL4aOfO2lEX+U45gBIZzBfOvwdVoGRab+drehhLgqzFrRqDSQ26OZyRoeJ2A5XkuubGlGo8ZSA1DvXjT6krTkGVoXR9qo7Fmor3SGNiLFZiRhurC9jIramYJB3Qcldi1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a6aX9Rmz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so120797a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731550899; x=1732155699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=314jSKy99LEyaAaemoceLKmpwSs7wHQDbema/BPPiYw=;
        b=a6aX9Rmz3oEeNiIf8d55/wC5DGH4XL8eVRMtZ26Lz+qWRfKgHpPUpmoMNM9LuPK/wg
         I5LTPidPXHjJsqkr4mX0FZeEA/2S4hvaAk0Tep1DVW4azMZrahws22PnsY1uAQZlT5sj
         v+beWzXJ3CpzCx445Vq/BIC2P0Ro88V/bWjo2k2CIvmJtdKPrEPwTF80+djFW9xfg7TI
         KtqX1FwEqp/SLfGnGpMHtzdmaHy8G7bNWkYFAyYz7aDwcd/kyR2uVCYUKLDN3qlYu0r5
         YXMvspvd1gKj+WlxIF91hSGjEzNcE8nVxmjUOAiwtAMwowRNPxBh7wiMelzYSTMo74mc
         AB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550899; x=1732155699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=314jSKy99LEyaAaemoceLKmpwSs7wHQDbema/BPPiYw=;
        b=RiEvBsU0uyoeOTEa4BUOoXJ1UwmpawQx7fX7h7UJmJXmF1dUVMrTQbG+aiSCGtFaBg
         PGNlY8YIno4/iS5cBHQ+eeghKfT3/O7KgaI648ebJEMAEeLIPxtM1pm4EK+cOuOgJdVD
         nZ8DNrvfjwgUga50n9Q9sG7vCvLXNzlKJqYUOrC9f3l/y0YmXHvHjNvL8rMTMPj+JPSi
         19e3gcIv5bUv7S5inhoNaHjzosJYO20jdnHfhLgxD5f5Lgp4d0dpBAPuywjxS843Zdm2
         XtpP/FXzdZpi9BOCuv5MyTMoIMvgWT3cvOLH1uxuI0LOY9xqnsRyF8b2+Iyu/BZeyHhF
         qy8w==
X-Forwarded-Encrypted: i=1; AJvYcCULSrY3kjFMmX/UU/iNxig15vSJEa8zuwBPlBmIbyWyIjlYRfCkA55A2ws3MhFiVeBxC3FA6V+8OrZEweQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaqpD4sVkhhcxv08IB1Wssz4SLpW+pj/eKYfUFreMitJIzqjZD
	kUhEuX5jQ+IV6Emt6ziXhkqcZvDkp27NIRkl0UGamFUOJu+FYtSBxNVqSr/5xsM=
X-Google-Smtp-Source: AGHT+IG9Jcid0PRneiXtidrl/nz/AfP1RmjxP0M9V2+K6N+zuRhpPBXDCnzUPPJlgubnaExTAFdXIA==
X-Received: by 2002:a17:90b:1c02:b0:2e5:5ab5:ba4b with SMTP id 98e67ed59e1d1-2e9b17425ffmr31540517a91.22.1731550899162;
        Wed, 13 Nov 2024 18:21:39 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c499c9sm406875ad.68.2024.11.13.18.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:21:38 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 13 Nov 2024 18:21:11 -0800
Subject: [PATCH v11 05/14] riscv: vector: Use vlenb from DT for thead
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-xtheadvector-v11-5-236c22791ef9@rivosinc.com>
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
In-Reply-To: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Yangyu Chen <cyy@cyyself.name>, Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6199; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=VR9AmJvGpk1N7CP/1hUyvJH4L27RWkW4yFjRM0+QHhI=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7pp3ILrW34IWxuH5rXPyHC+/yZuQt8ab4eXvetTTaxad
 s4/1KHaUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwEQ+vGNkeH7P/qQmf8KpmvMT
 p0a/8rW58lSwjHMum+b07e/867I2L2Bk2DjbfOqTnNUvDzUcW2PoU2O3Tez2QTGBN/W3tvZuzV3
 lyw4A
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

If thead,vlenb is provided in the device tree, prefer that over reading
the vlenb csr.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.vendor                        | 13 +++++++
 arch/riscv/include/asm/cpufeature.h              |  2 +
 arch/riscv/include/asm/vendor_extensions/thead.h |  6 +++
 arch/riscv/kernel/cpufeature.c                   | 48 ++++++++++++++++++++++++
 arch/riscv/kernel/vector.c                       | 12 +++++-
 arch/riscv/kernel/vendor_extensions/thead.c      | 11 ++++++
 6 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
index 9897442bd44f..b096548fe0ff 100644
--- a/arch/riscv/Kconfig.vendor
+++ b/arch/riscv/Kconfig.vendor
@@ -26,6 +26,19 @@ config RISCV_ISA_VENDOR_EXT_THEAD
 	  extensions. Without this option enabled, T-Head vendor extensions will
 	  not be detected at boot and their presence not reported to userspace.
 
+	  If you don't know what to do here, say Y.
+
+config RISCV_ISA_XTHEADVECTOR
+	bool "xtheadvector extension support"
+	depends on RISCV_ISA_VENDOR_EXT_THEAD
+	depends on RISCV_ISA_V
+	depends on FPU
+	default y
+	help
+	  Say N here if you want to disable all xtheadvector related procedures
+	  in the kernel. This will disable vector for any T-Head board that
+	  contains xtheadvector rather than the standard vector.
+
 	  If you don't know what to do here, say Y.
 endmenu
 
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 4bd054c54c21..569140d6e639 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -34,6 +34,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
+extern u32 thead_vlenb_of;
+
 void __init riscv_user_isa_enable(void);
 
 #define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/riscv/include/asm/vendor_extensions/thead.h
index 48421d1553ad..93fcbf46c87e 100644
--- a/arch/riscv/include/asm/vendor_extensions/thead.h
+++ b/arch/riscv/include/asm/vendor_extensions/thead.h
@@ -13,4 +13,10 @@
 
 extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
 
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_THEAD
+void disable_xtheadvector(void);
+#else
+static inline void disable_xtheadvector(void) { }
+#endif
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d752291d829b..7d9e8bbfaef2 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -39,6 +39,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
+u32 thead_vlenb_of;
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -779,6 +781,46 @@ static void __init riscv_fill_vendor_ext_list(int cpu)
 	}
 }
 
+static int has_thead_homogeneous_vlenb(void)
+{
+	int cpu;
+	u32 prev_vlenb = 0;
+	u32 vlenb;
+
+	/* Ignore thead,vlenb property if xtheavector is not enabled in the kernel */
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		struct device_node *cpu_node;
+
+		cpu_node = of_cpu_device_node_get(cpu);
+		if (!cpu_node) {
+			pr_warn("Unable to find cpu node\n");
+			return -ENOENT;
+		}
+
+		if (of_property_read_u32(cpu_node, "thead,vlenb", &vlenb)) {
+			of_node_put(cpu_node);
+
+			if (prev_vlenb)
+				return -ENOENT;
+			continue;
+		}
+
+		if (prev_vlenb && vlenb != prev_vlenb) {
+			of_node_put(cpu_node);
+			return -ENOENT;
+		}
+
+		prev_vlenb = vlenb;
+		of_node_put(cpu_node);
+	}
+
+	thead_vlenb_of = vlenb;
+	return 0;
+}
+
 static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 {
 	unsigned int cpu;
@@ -832,6 +874,12 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		riscv_fill_vendor_ext_list(cpu);
 	}
 
+	if (riscv_isa_vendor_extension_available(THEAD_VENDOR_ID, XTHEADVECTOR) &&
+	    has_thead_homogeneous_vlenb() < 0) {
+		pr_warn("Unsupported heterogeneous vlenb detected, vector extension disabled.\n");
+		disable_xtheadvector();
+	}
+
 	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
 		return -ENOENT;
 
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 821818886fab..3877a0454239 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
 {
 	unsigned long this_vsize;
 
-	/* There are 32 vector registers with vlenb length. */
+	/*
+	 * There are 32 vector registers with vlenb length.
+	 *
+	 * If the thead,vlenb property was provided by the firmware, use that
+	 * instead of probing the CSRs.
+	 */
+	if (thead_vlenb_of) {
+		riscv_v_vsize = thead_vlenb_of * 32;
+		return 0;
+	}
+
 	riscv_v_enable();
 	this_vsize = csr_read(CSR_VLENB) * 32;
 	riscv_v_disable();
diff --git a/arch/riscv/kernel/vendor_extensions/thead.c b/arch/riscv/kernel/vendor_extensions/thead.c
index 0f27baf8d245..519dbf70710a 100644
--- a/arch/riscv/kernel/vendor_extensions/thead.c
+++ b/arch/riscv/kernel/vendor_extensions/thead.c
@@ -5,6 +5,7 @@
 #include <asm/vendor_extensions/thead.h>
 
 #include <linux/array_size.h>
+#include <linux/cpumask.h>
 #include <linux/types.h>
 
 /* All T-Head vendor extensions supported in Linux */
@@ -16,3 +17,13 @@ struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead = {
 	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_thead),
 	.ext_data = riscv_isa_vendor_ext_thead,
 };
+
+void disable_xtheadvector(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, riscv_isa_vendor_ext_list_thead.per_hart_isa_bitmap[cpu].isa);
+
+	clear_bit(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR, riscv_isa_vendor_ext_list_thead.all_harts_isa_bitmap.isa);
+}

-- 
2.34.1


