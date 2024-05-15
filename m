Return-Path: <linux-kernel+bounces-180386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF08C6DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FB61F223C9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422A315B96F;
	Wed, 15 May 2024 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HSXuWm+U"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA52E15B55B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715808395; cv=none; b=jxUpmZLzgJEKkLOI5Wo3nDLWroObeCvsfiubJdqQqwj2ai30oxfWIObyGs68fai6IrCCfIl6Q2zXT+psC7jQJgaRQ5bXPOgjUKyIZjm1cm7AccCNPrA1jyJCNZqQw8w535bUuMxGnJtDUEnPvClkCvvhjHXU4J8zO1GlzE9gfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715808395; c=relaxed/simple;
	bh=y0IR/Pz2QI3qpm178zym3SvfojJCPcK8YuTJj6uOgT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFSPkv6IizXTczZ4435/lq6aTIcz3neEM0pzEda7BZPNBlJ9WQt/iu9D2n3DPIsKWR0ur7UfIRj/H6/zAikCMghKLmc2YZtKDyfywHdIQ3txfK0t7P4juKADUGvZRwT6TmAimxqs5w2PlcoTPeP/sCz2Z7Sk4UrAMJnJhvcWiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HSXuWm+U; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-60585faa69fso4834135a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715808393; x=1716413193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDtIgLWGCijnY5frMModlDzzsx4r72xgdzFlwdF2fSc=;
        b=HSXuWm+UGEaaIKm4UIAGp0lHI7i66Ydg4Axs8P+kbeqmmebRAaCgS5aq3bAlR6z3kZ
         fbDrDmH9j4DlA811QHJ6212HDUqHU6jUYXuvC50FHfN1G8+ZMHlDK5qlVx5cbwMf71De
         jymnCS3og+mUG6v8WiQUprPWCsML+ObtDdEnT4Qgox64fhrJTG2m0IdUhmWlhhvb/Jzd
         hls7Q3KjWaaOfk3eS5mhXKSQv4NQqevC3HXWw/nIzz8vnjobrKekJP0qxqjuSTEVdvK7
         2G7IlXRTwwoVagXEu/NixtPhWa+SuF7PKPFJmM/lhrqUq3V3Fr0aocXNw27ui5g+lUqc
         KI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715808393; x=1716413193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDtIgLWGCijnY5frMModlDzzsx4r72xgdzFlwdF2fSc=;
        b=dWNPrqxJqnYDDH5r4IFN/HTqnPhqBybqhjacSZAxsV3mWMekoXJE/6GgyaJ5htK2rq
         wFZ8Mv0NYfN+lii0EtudrV7rLPIXmWZ7CpTh/OdDv/YpBcz/rxedO+QNlaBuDleS+D2u
         biaEYh2nZyo1cR3T+4mvoUmI6RME/M5DFxQhybwUh9DV5rc06gvenRZJfHTb+vDkj5MZ
         ficveQ350cn72IRONe7IpWQOT0697PWH1liTLP6id9t/OScQ7ncQrl1gGB11MH3HytJl
         dbiCqJPePTrP2/1EJIy3T+2rBnSjMLk65w42E2z72SWGQK6vayZU/Vy8GD9hqsTLR5aT
         Hw2g==
X-Forwarded-Encrypted: i=1; AJvYcCXpJDAQIacGpq6qgcmFBRATjyRxPVdSB4EQy8UttZuK46crsx/8pvkO7kuv2duZZiEik+jxe6rUA25AkEmG98T8ykpt40cFDLodrbHx
X-Gm-Message-State: AOJu0YzvoT6mcR+tHwDnNKQKaPfbT6MhmeG/1lfrz/a7p4YzXIs/PuCO
	AXhyuPaT2YUaL3VxTe+rgSrFF101PgKaxt8MO4V8SugOnS3lCGpXlswTyPcUzLo=
X-Google-Smtp-Source: AGHT+IEQ0cRrnKhxXtXXOUeS2dwj2KmFrvDhjaiKlSSegYxOQceqkmUq44b1FyjmSjDSyX7wZk/AdQ==
X-Received: by 2002:a05:6a20:914f:b0:1a8:2cd1:e493 with SMTP id adf61e73a8af0-1afde1c576amr25685367637.29.1715808392929;
        Wed, 15 May 2024 14:26:32 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b30sm11970243b3a.146.2024.05.15.14.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:26:32 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 15 May 2024 14:26:15 -0700
Subject: [PATCH 3/4] riscv: Introduce vendor variants of extension helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-support_vendor_extensions-v1-3-b05dd5ea7d8d@rivosinc.com>
References: <20240515-support_vendor_extensions-v1-0-b05dd5ea7d8d@rivosinc.com>
In-Reply-To: <20240515-support_vendor_extensions-v1-0-b05dd5ea7d8d@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715808387; l=4493;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=y0IR/Pz2QI3qpm178zym3SvfojJCPcK8YuTJj6uOgT4=;
 b=vKx5bPU55zbslweXIsFZqrbVFdAu+OBTPNcIb6wrQD7wYHe6AuPWLrKFZuT2gZ9AwLNwe3+Gh
 lh/gKnjT/FpDj+ZZuCjWsH0yqH1wVLfN6eUJonuy3kN6zegtORWpeJM
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Vendor extensions are maintained in per-vendor structs (separate from
standard extensions which live in riscv_isa). Create vendor variants for
the existing extension helpers to interface with the riscv_isa_vendor
bitmaps.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/vendor_extensions.h | 83 ++++++++++++++++++++++++++++++
 drivers/perf/riscv_pmu_sbi.c               |  3 +-
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
index 5842dacc05cd..a6959836f895 100644
--- a/arch/riscv/include/asm/vendor_extensions.h
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -41,8 +41,91 @@ extern const size_t riscv_isa_vendor_ext_list_size;
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
index 6a5364910cb7..7866276db213 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -841,7 +841,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
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


