Return-Path: <linux-kernel+bounces-207622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A5E9019CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDB51F21C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 04:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADF015EA6;
	Mon, 10 Jun 2024 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MHrYsUe9"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A1E54C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994066; cv=none; b=eg3SxQX+tQk/M2OjUqSo2O5kehGI/ktAAehduGGcNkdjeyW9Kll8ulk/POF9SUQZ6+myZqlFsEX0qx3Svxvsav01Ff0wjtr0DQOO2UHJb1OoY6mjvi2YuCQc4byoJmWq3t96+fImwydKVUWvxG00H2047GQOjUthUQgZ7mjwtvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994066; c=relaxed/simple;
	bh=BRKn/iNBwWd/Co3CsGmqCL5DUn6Jw8PNvX4AjuCz5D4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fd0uh0RE+drkRSRQEYB3YW26Xqj+ZkZRYMgD7gW6c6ac+8x7oV2wjEbrB6geEdSH9G+V1YlD1azQhQZPyP2xDX8fYVSLQyU8hi2QVy/o27FC9/oTE4K46UsR3RAstnYmr5hUj4TAjindwpLGZBsc+5IlVIe9mp/4tPoXcsCfVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MHrYsUe9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2bfffa3c748so3160345a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 21:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717994064; x=1718598864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFh+Yaq4sHDrY//jnAxoeEQik5WMbNjKxo7yD1r3rGk=;
        b=MHrYsUe9bHfBGVlnQGdq01Awcun/R/4UTp5wMxfJLZWf/nrkGATloHlnanhm0q7O4I
         UbQpC3k0eNRikGN/r3/fwOTGmzVzFPawrLzwfHLLyx7oa2Jb2yspglj95cB1bQCazgdx
         eQyz1N7LPwAoE1rDMYucjtYkDNP/CKNyDwfyw29IafN9itDrMSZu37a7aB+na4ji7enc
         xwRIg9HhI8aFN5/Y5yjfiub02ynInBOn25/FOnxc6m7XVJxcv9akP9Hs3F4bjSZkK8tu
         wfc5SJapR26R2pbQOCxv/+NV4ICU/Lx1w+x1AlPvlFHOUjkFo6I4oD0WyF/YUaxT7NBn
         H2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994064; x=1718598864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFh+Yaq4sHDrY//jnAxoeEQik5WMbNjKxo7yD1r3rGk=;
        b=nsboVF1hFuKgx6wFeK42y0nQDRDCsAeBi2LHXMXlUMgoqCIA91OU54JMM2Bn86AJJp
         wzkqzukngAKi77M0qnxow20m0QFX/9bLgw/jk9Rajdut2KyRSzOtjeHi1QP8CnSkHs5r
         L8Ad94c/+AzSzDEiSUPRIsbAPBB9Bon/8P+Nxp3BOjNAhjiJkVzgwamFar5/SeMJtWwP
         quHkKF/GCpHyHlD2YdiUvGBpbq6VRc87auK85sbMnb70bWIyZcDNbKSk2U7rq7c8Yn79
         k1bxC8zdYscHF6yBO5zPnZVU8GGPsOc3LtMhvYJxdGY9ubitMlGbIRskvtJB5no8jKON
         ZxAw==
X-Forwarded-Encrypted: i=1; AJvYcCXFH1Vu2N6Roa1zrmSgvo7MjFdRkn6XteBvyz2CTD+OX7jqvYOKS5lUiaFVlg1hksyApm90yOk8Ksi36CKQzm9JY/m4HR+W+EYy1UJY
X-Gm-Message-State: AOJu0YzbTp/y7PXYXrhDajiYDOzz9rDh6qBCF9mgeEm+LU/auwDr76te
	J2a+bX4vaeHU+UfIQ8B6DJNrPLE0H6euJ6MPZelW9aep7P5xyDx6EtUrgFu/rKY=
X-Google-Smtp-Source: AGHT+IFEO8lawIZO34Zob1QtkyF5RXdf+JbO2dsILLISXWlFzRWMVMWmcWePF8SxOHkYAPm4Y6ss0w==
X-Received: by 2002:a17:90a:c253:b0:2c2:fbe1:1dc7 with SMTP id 98e67ed59e1d1-2c2fbe12004mr1984069a91.40.1717994064135;
        Sun, 09 Jun 2024 21:34:24 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2fe295cf5sm1894756a91.47.2024.06.09.21.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:34:23 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sun, 09 Jun 2024 21:34:16 -0700
Subject: [PATCH v2 3/4] riscv: Introduce vendor variants of extension
 helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240609-support_vendor_extensions-v2-3-9a43f1fdcbb9@rivosinc.com>
References: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
In-Reply-To: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717994057; l=4551;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=BRKn/iNBwWd/Co3CsGmqCL5DUn6Jw8PNvX4AjuCz5D4=;
 b=4yccy4PXfKJAdvU7bYolQc5ufEEMW2Kgu5KVvNWSEXFq/FRywTFoLddxAai/8NN5jS+h+5FlJ
 T0l43mSaG99AGgriIaHNd1j1G3qENU6OAe/iyGl8qI7SukgrDgfLmT6
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Vendor extensions are maintained in per-vendor structs (separate from
standard extensions which live in riscv_isa). Create vendor variants for
the existing extension helpers to interface with the riscv_isa_vendor
bitmaps.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/vendor_extensions.h | 83 ++++++++++++++++++++++++++++++
 drivers/perf/riscv_pmu_sbi.c               |  3 +-
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
index 5fca550fc1f6..04d72b02ae6b 100644
--- a/arch/riscv/include/asm/vendor_extensions.h
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -42,8 +42,91 @@ extern const size_t riscv_isa_vendor_ext_list_size;
 #define VENDOR_EXT_ALL_CPUS			-1
 
 bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit);
+#define riscv_cpu_isa_vendor_extension_available(cpu, vendor, ext)	\
+	__riscv_isa_vendor_extension_available(cpu, vendor, RISCV_ISA_VENDOR_EXT_##ext)
 #define riscv_isa_vendor_extension_available(vendor, ext)	\
 	__riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, \
 					       RISCV_ISA_VENDOR_EXT_##ext)
 
+static __always_inline bool __riscv_has_extension_likely(const unsigned long vendor,
+							 const unsigned long ext)
+{
+	asm goto(ALTERNATIVE("j	%l[l_no]", "nop", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_no);
+
+	return true;
+l_no:
+	return false;
+}
+
+static __always_inline bool __riscv_has_extension_unlikely(const unsigned long vendor,
+							   const unsigned long ext)
+{
+	asm goto(ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)
+	:
+	: [vendor] "i" (vendor), [ext] "i" (ext)
+	:
+	: l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+static __always_inline bool riscv_has_vendor_extension_likely(const unsigned long vendor,
+							      const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_likely(vendor,
+						    ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
+	return __riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, ext);
+}
+
+static __always_inline bool riscv_has_vendor_extension_unlikely(const unsigned long vendor,
+								const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE))
+		return __riscv_has_extension_unlikely(vendor,
+						      ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
+	return __riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, ext);
+}
+
+static __always_inline bool riscv_cpu_has_vendor_extension_likely(const unsigned long vendor,
+								  int cpu, const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_likely(vendor, ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
+		return true;
+
+	return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
+}
+
+static __always_inline bool riscv_cpu_has_vendor_extension_unlikely(const unsigned long vendor,
+								    int cpu,
+								    const unsigned long ext)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE) &&
+	    __riscv_has_extension_unlikely(vendor, ext + RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
+		return true;
+
+	return __riscv_isa_vendor_extension_available(cpu, vendor, ext);
+}
+
 #endif /* _ASM_VENDOR_EXTENSIONS_H */
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 02719e0c6368..e1f0edfb7dcc 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1064,7 +1064,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		   riscv_cached_mimpid(0) == 0) {
 		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
-	} else if (riscv_isa_vendor_extension_available(ANDES_VENDOR_ID, XANDESPMU) &&
+	} else if (riscv_has_vendor_extension_unlikely(ANDES_VENDOR_ID,
+						       RISCV_ISA_VENDOR_EXT_XANDESPMU) &&
 		   IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
 		riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMOVI;
 		riscv_pmu_use_irq = true;

-- 
2.44.0


