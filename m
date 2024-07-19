Return-Path: <linux-kernel+bounces-257478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43044937A98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C57283B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9014659D;
	Fri, 19 Jul 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Zbzn/PNK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19644145A08
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405743; cv=none; b=bEKvOpPy/JSQUoxHASr9e8PojThjNZrWsSebrNlfOheNPoCsxKi4/QRMYHilbO5hZDb5SOClkeNfgqIaNz2E9WTBmZc4tdXdzy3jwwtb1x4UUuhD3X9VR0VriJ0LhTSPb0+7I6+G/w8Sv+JOqa6ezh1k/2PvMefZAwSkVjfkw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405743; c=relaxed/simple;
	bh=CjE8/rzubqx5R8Iz4IqjgB80B9gjcI9d7XpRrk2z8Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKlZFNKVSjgYD1Ro6RznP4J/1ESWJ7eOBOtOGDTZGK2WHFMd/6NeJVs7groZ33Zh2tzIFbIR3JC7eFiT+qlGaQYGplUhZ8E3xv6xGDVgKruiWUCDDZ3dCyLMiv/vu9lzQEef2xu6DnYFWZCVSVO3ne9E3/VFOcNfhqNyKgXIccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Zbzn/PNK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so773081b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721405741; x=1722010541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKptBNPUToJCgJikTFA3RkO8ZdeJBbCKOsPDQYUnrcw=;
        b=Zbzn/PNKdm2xMf8m/Ex/Jf8oNGq5E7gOavn1n1nzo0md/+dnvSQEZ51Ec4vIi3ETi4
         baIMGqsQXkL2OWYaeAh8bPoxUH8b00AULURaISW76YTJaECeCfIMjg0+r12mEOC3fCfg
         MS6361BR4Efaupvj2O6XHSffPczwgpCir5OeQBHFY967lDyPK6T0jlqPVF6zFjjoPYTN
         y87uM5CzbWx6iJw5cuf5+0I5AA4v0vzF8JOgwri0Yy6fBxjCRGGAcMiVvagnrctpBbv8
         u58p5p4/MVj4xzn6lhri3fNOQCLiBX4bERiyTc4ICz4kpvZWcFQ8OI6whKyxD5E7bP1p
         E84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405741; x=1722010541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKptBNPUToJCgJikTFA3RkO8ZdeJBbCKOsPDQYUnrcw=;
        b=hJnfGWR1zik0YYjvIpk8VxmGzPqtaV0VO3hQolSmQFRHngePaRIHGWAQHFarC9MIPd
         Uy0eV2D987//t0CJzQGWrRXBOJyp2Tipl6lp9ndlHf96VFN6QUvsKzWTD1pvFYnxn7K8
         H8qyxviPg8swDi3vXo28hN1QjuYuncHiLdGWqR4xvH/50dah/T05IpWqlqW6xDwvamnB
         Omt+ukiKFrh7SrtUV5hujKmy9yP9KbppTRwBuYEUe0ij9KH3EL+4duO7h/ZxVoTW3NA8
         wJicvUwfA9niP4oWGVFXK9bCepFdf00dGj/P5xtMXgAvbykgrgGmXqQtiI+tK6uetd9P
         wgiA==
X-Forwarded-Encrypted: i=1; AJvYcCXP5sencQspOs7VDIxF1TLyiCA6ousGhuqNgbuSU1f3V4h1mjzrTx4PjfRp3MXAiG1VdJmAxZ0Kk46Qa/b6tfsHeyZQAY1UJHX0rY/X
X-Gm-Message-State: AOJu0Yx+7KXnJs2TkPYpHhi2/H9Wm4Uo8b6zrVd7/ytusk/WWHvU9gvK
	coUbhmZr3n3UorX/K7yGJXmtyIhq5p8NFMxrg7y/t296PcYCMTIMVrzRv3/jYpk=
X-Google-Smtp-Source: AGHT+IH9oa/gapf6wRvG/n/RRpbOMnqPHYf2oA2uQ+xPbg563um1usCzVEilrCT21+k7uaAfWBoRSw==
X-Received: by 2002:a05:6a00:4f88:b0:706:6867:7a63 with SMTP id d2e1a72fcca58-70d094d2a71mr182048b3a.6.1721405741298;
        Fri, 19 Jul 2024 09:15:41 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0ad73cc4sm579589a12.29.2024.07.19.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:15:40 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 19 Jul 2024 09:15:20 -0700
Subject: [PATCH v3 3/4] riscv: Introduce vendor variants of extension
 helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-support_vendor_extensions-v3-3-0af7587bbec0@rivosinc.com>
References: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
In-Reply-To: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721405735; l=4598;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=CjE8/rzubqx5R8Iz4IqjgB80B9gjcI9d7XpRrk2z8Qs=;
 b=cgJc9U8CKeGbQmMhF8nkxrxoy872cNjd9xtHNOdycdagYpu0adcmK3V/345qAoSy1eexq5Mbd
 EKmq84TacEsAj+nLjgQyW06Q3rDCun28yf2myFXx3Rta5jBdj3j6Hqo
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Vendor extensions are maintained in per-vendor structs (separate from
standard extensions which live in riscv_isa). Create vendor variants for
the existing extension helpers to interface with the riscv_isa_vendor
bitmaps.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
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
index 16daebd0af1e..36d128ff166f 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1099,7 +1099,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
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


