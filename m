Return-Path: <linux-kernel+bounces-257476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F22C937A97
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3286B23971
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514F145FFF;
	Fri, 19 Jul 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nM3Z1Fyy"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659F171CC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405741; cv=none; b=lksKNILXbCnRtKONOMcDk0rk1sJpgOvCuVX85AGTynF9E3qppi1A5+ctheMKMye/o1xfsO7vrKRuoPS6AXxsXuewwnha4AUF8DX+Xcf8s4QpgNSmskcBZ+rNaGB1qB2bGRgC5aGG8ihz2J0WctEjJ7U0S2ZJeb0bLmZhR5Q3ogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405741; c=relaxed/simple;
	bh=7p4Z1vEqr+oDYseWRDfra1Z5uqfDh980vJ8R2T0NKvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FaSbBca1ypvNHIjdMCR1LKRoNGfr3isjJCl4KqM8PFGwjrVxrPS8kVxQvO2xp4AG4vJNBSjgzfkp/HalbEipjUb8Sjni1jL/7fW0I43tyNCgeCiC0WaaP1owz9q0QU94d9Z5mAu7vdVDWtg2H2p+6FdYjAJJEoCi8TgJQ+gI9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nM3Z1Fyy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd65aaac27so4937685ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721405738; x=1722010538; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MT4uNr/TLM4J6zlsF/TVg+VGAEuE1pEsbrMOH2FYqw=;
        b=nM3Z1FyyKrWAvYczWZh0ca40Tk9eMbzDExtO2ny2l7jqfMJPnOR4TSFI/6yYr8/BcM
         jMCig9jiYtpt4KNAMxWKuLSw4iwlr1kkyzeQa9o7AnXez6kLCNo/h3lEt8wn89iLcTzc
         cGHXJSWxMrkjwtoDEW15V1ttqTJUnPSPg+exNLeaB37mLMonJmxSYdLdmaQcPjswn48C
         ifkHEPywRE3sM00g1XZ9AUdT/Jn6q6XfxmzUVIzFZxIw6FG/s1cnzlE1w8YJ8lIIIj04
         ibRw6mO9kh4MSZw+mhXbbqpt2B2G2nAw5hD115hFPhf1375C+AVWbW4GCoi81O0GmByY
         cBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405738; x=1722010538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MT4uNr/TLM4J6zlsF/TVg+VGAEuE1pEsbrMOH2FYqw=;
        b=QVdjUlAaNps1YkH0L5t8FO2VOSXRPUDbh42aiO4NEWQryKvJxrMftGFXQG55HXTyqH
         F3JDJylKVFJTZnZfUbD4FSUcne/nZGM5WVndGHilur5Ys6gXwItmvmM/8sz6ZoXA6AKI
         pete5kOFo6Jk7QkYUuFGUkkCGumaTWEBq6AX0otqqgRWhQdeNJROcE7oPcH9ES4sKw8G
         L8OoFKeeMInjr4wvqb2gvPEGaKlXXPsSrzf+NroON2wMdHyr0D0CJ5K4266wGOtYZanO
         tB01ykYERp9xMDy5Dc6hvlYH+AOKf4+0MIrZ0o2DK0lQd2P8T+j4kHrj82VC4NGNsRpJ
         mewA==
X-Forwarded-Encrypted: i=1; AJvYcCWChGSvy67wjDubvtj9oZLdXPlu/AKDgEMbTB9Un7aLB+TEqINrCcSl/OX/Nlc08Rc/har+VKZIJhFprfHtkLA6dnzHPNCbKm1IELg+
X-Gm-Message-State: AOJu0YxX/sA9YVlofrIQP/pXUM4EV01TYD28GL/lpO5finOC7YuARq/D
	8EAVTwBYXkjzqVFzxk8Gc1caZ/Qi5RZErattu2JMKbCpyleWzltqmCN+y7+vf5I=
X-Google-Smtp-Source: AGHT+IE6rv73TO2blZ9dapA/VwW6EZbFPoWYY+mqunsehTAQe6lRl6ps3hFwp2mgPVwyfwuhz/XncQ==
X-Received: by 2002:a17:902:fc45:b0:1fb:53fb:2ce1 with SMTP id d9443c01a7336-1fc5b60a919mr106577585ad.20.1721405738223;
        Fri, 19 Jul 2024 09:15:38 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0ad73cc4sm579589a12.29.2024.07.19.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:15:37 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 19 Jul 2024 09:15:18 -0700
Subject: [PATCH v3 1/4] riscv: Extend cpufeature.c to detect vendor
 extensions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-support_vendor_extensions-v3-1-0af7587bbec0@rivosinc.com>
References: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
In-Reply-To: <20240719-support_vendor_extensions-v3-0-0af7587bbec0@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721405734; l=23167;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=7p4Z1vEqr+oDYseWRDfra1Z5uqfDh980vJ8R2T0NKvw=;
 b=+FzPqmcrdMg8kyiGFERsAVJLaBgPhcVgOemFdF/aKWm58bZABBNPy1oo/WwsMCKtrZHrsc96X
 WIV7TQkndmHD+RgU5Zm0tJ3D7dDpU1C2RJKhH3OmZeNrjDhXa00BZ5T
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Instead of grouping all vendor extensions into the same riscv_isa_ext
that standard instructions use, create a struct
"riscv_isa_vendor_ext_data_list" that allows each vendor to maintain
their vendor extensions independently of the standard extensions.
xandespmu is currently the only vendor extension so that is the only
extension that is affected by this change.

An additional benefit of this is that the extensions of each vendor can
be conditionally enabled. A config RISCV_ISA_VENDOR_EXT_ANDES has been
added to allow for that.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
Tested-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>
---
 arch/riscv/Kconfig                               |   2 +
 arch/riscv/Kconfig.vendor                        |  19 +++
 arch/riscv/errata/andes/errata.c                 |   3 +
 arch/riscv/errata/sifive/errata.c                |   3 +
 arch/riscv/errata/thead/errata.c                 |   3 +
 arch/riscv/include/asm/cpufeature.h              |  25 ++++
 arch/riscv/include/asm/hwcap.h                   |  25 ++--
 arch/riscv/include/asm/vendor_extensions.h       |  49 ++++++++
 arch/riscv/include/asm/vendor_extensions/andes.h |  19 +++
 arch/riscv/kernel/Makefile                       |   2 +
 arch/riscv/kernel/cpufeature.c                   | 143 ++++++++++++++++-------
 arch/riscv/kernel/vendor_extensions.c            |  56 +++++++++
 arch/riscv/kernel/vendor_extensions/Makefile     |   3 +
 arch/riscv/kernel/vendor_extensions/andes.c      |  18 +++
 drivers/perf/riscv_pmu_sbi.c                     |  10 +-
 15 files changed, 324 insertions(+), 56 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3ceec2ca84fa..617f5bdf9c4c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -820,6 +820,8 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
 
 endchoice
 
+source "arch/riscv/Kconfig.vendor"
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
new file mode 100644
index 000000000000..6f1cdd32ed29
--- /dev/null
+++ b/arch/riscv/Kconfig.vendor
@@ -0,0 +1,19 @@
+menu "Vendor extensions"
+
+config RISCV_ISA_VENDOR_EXT
+	bool
+
+menu "Andes"
+config RISCV_ISA_VENDOR_EXT_ANDES
+	bool "Andes vendor extension support"
+	select RISCV_ISA_VENDOR_EXT
+	default y
+	help
+	  Say N here if you want to disable all Andes vendor extension
+	  support. This will cause any Andes vendor extensions that are
+	  requested by hardware probing to be ignored.
+
+	  If you don't know what to do here, say Y.
+endmenu
+
+endmenu
diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
index f2708a9494a1..fc1a34faa5f3 100644
--- a/arch/riscv/errata/andes/errata.c
+++ b/arch/riscv/errata/andes/errata.c
@@ -17,6 +17,7 @@
 #include <asm/processor.h>
 #include <asm/sbi.h>
 #include <asm/vendorid_list.h>
+#include <asm/vendor_extensions.h>
 
 #define ANDES_AX45MP_MARCHID		0x8000000000008a45UL
 #define ANDES_AX45MP_MIMPID		0x500UL
@@ -65,6 +66,8 @@ void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct al
 					      unsigned long archid, unsigned long impid,
 					      unsigned int stage)
 {
+	BUILD_BUG_ON(ERRATA_ANDES_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
 	if (stage == RISCV_ALTERNATIVES_BOOT)
 		errata_probe_iocp(stage, archid, impid);
 
diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 716cfedad3a2..cea3b96ade11 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -12,6 +12,7 @@
 #include <asm/alternative.h>
 #include <asm/vendorid_list.h>
 #include <asm/errata_list.h>
+#include <asm/vendor_extensions.h>
 
 struct errata_info_t {
 	char name[32];
@@ -96,6 +97,8 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	u32 cpu_apply_errata = 0;
 	u32 tmp;
 
+	BUILD_BUG_ON(ERRATA_SIFIVE_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return;
 
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index bf6a0a6318ee..f5120e07c318 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
+#include <asm/vendor_extensions.h>
 
 #define CSR_TH_SXSTATUS		0x5c0
 #define SXSTATUS_MAEE		_AC(0x200000, UL)
@@ -166,6 +167,8 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	u32 tmp;
 	void *oldptr, *altptr;
 
+	BUILD_BUG_ON(ERRATA_THEAD_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
+
 	for (alt = begin; alt < end; alt++) {
 		if (alt->vendor_id != THEAD_VENDOR_ID)
 			continue;
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 000796c2d0b1..bfe7c0b881e9 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -33,6 +33,31 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 void riscv_user_isa_enable(void);
 
+#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
+	.name = #_name,									\
+	.property = #_name,								\
+	.id = _id,									\
+	.subset_ext_ids = _subset_exts,							\
+	.subset_ext_size = _subset_exts_size,						\
+	.validate = _validate								\
+}
+
+#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, NULL)
+
+#define __RISCV_ISA_EXT_DATA_VALIDATE(_name, _id, _validate) \
+			_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, _validate)
+
+/* Used to declare pure "lasso" extension (Zk for instance) */
+#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
+	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
+			    ARRAY_SIZE(_bundled_exts), NULL)
+
+/* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
+#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
+	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), NULL)
+#define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _validate) \
+	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
+
 #if defined(CONFIG_RISCV_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
 void unaligned_emulation_finish(void);
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b18b202ca141..5a0bd27fd11a 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -80,19 +80,18 @@
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
-#define RISCV_ISA_EXT_XANDESPMU		74
-#define RISCV_ISA_EXT_ZVE32X		75
-#define RISCV_ISA_EXT_ZVE32F		76
-#define RISCV_ISA_EXT_ZVE64X		77
-#define RISCV_ISA_EXT_ZVE64F		78
-#define RISCV_ISA_EXT_ZVE64D		79
-#define RISCV_ISA_EXT_ZIMOP		80
-#define RISCV_ISA_EXT_ZCA		81
-#define RISCV_ISA_EXT_ZCB		82
-#define RISCV_ISA_EXT_ZCD		83
-#define RISCV_ISA_EXT_ZCF		84
-#define RISCV_ISA_EXT_ZCMOP		85
-#define RISCV_ISA_EXT_ZAWRS		86
+#define RISCV_ISA_EXT_ZVE32X		74
+#define RISCV_ISA_EXT_ZVE32F		75
+#define RISCV_ISA_EXT_ZVE64X		76
+#define RISCV_ISA_EXT_ZVE64F		77
+#define RISCV_ISA_EXT_ZVE64D		78
+#define RISCV_ISA_EXT_ZIMOP		79
+#define RISCV_ISA_EXT_ZCA		80
+#define RISCV_ISA_EXT_ZCB		81
+#define RISCV_ISA_EXT_ZCD		82
+#define RISCV_ISA_EXT_ZCF		83
+#define RISCV_ISA_EXT_ZCMOP		84
+#define RISCV_ISA_EXT_ZAWRS		85
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/include/asm/vendor_extensions.h
new file mode 100644
index 000000000000..5fca550fc1f6
--- /dev/null
+++ b/arch/riscv/include/asm/vendor_extensions.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2024 Rivos, Inc
+ */
+
+#ifndef _ASM_VENDOR_EXTENSIONS_H
+#define _ASM_VENDOR_EXTENSIONS_H
+
+#include <asm/cpufeature.h>
+
+#include <linux/array_size.h>
+#include <linux/types.h>
+
+/*
+ * The extension keys of each vendor must be strictly less than this value.
+ */
+#define RISCV_ISA_VENDOR_EXT_MAX 32
+
+struct riscv_isavendorinfo {
+	DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX);
+};
+
+struct riscv_isa_vendor_ext_data_list {
+	bool is_initialized;
+	const size_t ext_data_count;
+	const struct riscv_isa_ext_data *ext_data;
+	struct riscv_isavendorinfo per_hart_isa_bitmap[NR_CPUS];
+	struct riscv_isavendorinfo all_harts_isa_bitmap;
+};
+
+extern struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[];
+
+extern const size_t riscv_isa_vendor_ext_list_size;
+
+/*
+ * The alternatives need some way of distinguishing between vendor extensions
+ * and errata. Incrementing all of the vendor extension keys so they are at
+ * least 0x8000 accomplishes that.
+ */
+#define RISCV_VENDOR_EXT_ALTERNATIVES_BASE	0x8000
+
+#define VENDOR_EXT_ALL_CPUS			-1
+
+bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit);
+#define riscv_isa_vendor_extension_available(vendor, ext)	\
+	__riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor, \
+					       RISCV_ISA_VENDOR_EXT_##ext)
+
+#endif /* _ASM_VENDOR_EXTENSIONS_H */
diff --git a/arch/riscv/include/asm/vendor_extensions/andes.h b/arch/riscv/include/asm/vendor_extensions/andes.h
new file mode 100644
index 000000000000..7bb2fc43438f
--- /dev/null
+++ b/arch/riscv/include/asm/vendor_extensions/andes.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_ANDES_H
+#define _ASM_RISCV_VENDOR_EXTENSIONS_ANDES_H
+
+#include <asm/vendor_extensions.h>
+
+#include <linux/types.h>
+
+#define RISCV_ISA_VENDOR_EXT_XANDESPMU		0
+
+/*
+ * Extension keys should be strictly less than max.
+ * It is safe to increment this when necessary.
+ */
+#define RISCV_ISA_VENDOR_EXT_MAX_ANDES			32
+
+extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_andes;
+
+#endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 5b243d46f4b1..b0aea202273d 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -58,6 +58,8 @@ obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
 obj-y	+= patch.o
+obj-y	+= vendor_extensions.o
+obj-y	+= vendor_extensions/
 obj-y	+= probes/
 obj-y	+= tests/
 obj-$(CONFIG_MMU) += vdso.o vdso/
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 0366dc3baf33..8f20607adb40 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -24,6 +24,7 @@
 #include <asm/processor.h>
 #include <asm/sbi.h>
 #include <asm/vector.h>
+#include <asm/vendor_extensions.h>
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
@@ -100,31 +101,6 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
-#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
-	.name = #_name,									\
-	.property = #_name,								\
-	.id = _id,									\
-	.subset_ext_ids = _subset_exts,							\
-	.subset_ext_size = _subset_exts_size,						\
-	.validate = _validate								\
-}
-
-#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, NULL)
-
-#define __RISCV_ISA_EXT_DATA_VALIDATE(_name, _id, _validate) \
-			_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, _validate)
-
-/* Used to declare pure "lasso" extension (Zk for instance) */
-#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
-	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
-			    ARRAY_SIZE(_bundled_exts), NULL)
-
-/* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
-#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
-	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), NULL)
-#define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _validate) \
-	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
-
 static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,
 				 const unsigned long *isa_bitmap)
 {
@@ -405,7 +381,6 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
-	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
@@ -512,6 +487,21 @@ static void __init riscv_parse_isa_string(const char *isa, unsigned long *bitmap
 		bool ext_err = false;
 
 		switch (*ext) {
+		case 'x':
+		case 'X':
+			if (acpi_disabled)
+				pr_warn_once("Vendor extensions are ignored in riscv,isa. Use riscv,isa-extensions instead.");
+			/*
+			 * To skip an extension, we find its end.
+			 * As multi-letter extensions must be split from other multi-letter
+			 * extensions with an "_", the end of a multi-letter extension will
+			 * either be the null character or the "_" at the start of the next
+			 * multi-letter extension.
+			 */
+			for (; *isa && *isa != '_'; ++isa)
+				;
+			ext_err = true;
+			break;
 		case 's':
 			/*
 			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
@@ -527,8 +517,6 @@ static void __init riscv_parse_isa_string(const char *isa, unsigned long *bitmap
 			}
 			fallthrough;
 		case 'S':
-		case 'x':
-		case 'X':
 		case 'z':
 		case 'Z':
 			/*
@@ -728,6 +716,61 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		acpi_put_table((struct acpi_table_header *)rhct);
 }
 
+static void __init riscv_fill_cpu_vendor_ext(struct device_node *cpu_node, int cpu)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return;
+
+	for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
+		struct riscv_isa_vendor_ext_data_list *ext_list = riscv_isa_vendor_ext_list[i];
+
+		for (int j = 0; j < ext_list->ext_data_count; j++) {
+			const struct riscv_isa_ext_data ext = ext_list->ext_data[j];
+			struct riscv_isavendorinfo *isavendorinfo = &ext_list->per_hart_isa_bitmap[cpu];
+
+			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
+						     ext.property) < 0)
+				continue;
+
+			/*
+			 * Assume that subset extensions are all members of the
+			 * same vendor.
+			 */
+			if (ext.subset_ext_size)
+				for (int k = 0; k < ext.subset_ext_size; k++)
+					set_bit(ext.subset_ext_ids[k], isavendorinfo->isa);
+
+			set_bit(ext.id, isavendorinfo->isa);
+		}
+	}
+}
+
+/*
+ * Populate all_harts_isa_bitmap for each vendor with all of the extensions that
+ * are shared across CPUs for that vendor.
+ */
+static void __init riscv_fill_vendor_ext_list(int cpu)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
+		return;
+
+	for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
+		struct riscv_isa_vendor_ext_data_list *ext_list = riscv_isa_vendor_ext_list[i];
+
+		if (!ext_list->is_initialized) {
+			bitmap_copy(ext_list->all_harts_isa_bitmap.isa,
+				    ext_list->per_hart_isa_bitmap[cpu].isa,
+				    RISCV_ISA_VENDOR_EXT_MAX);
+			ext_list->is_initialized = true;
+		} else {
+			bitmap_and(ext_list->all_harts_isa_bitmap.isa,
+				   ext_list->all_harts_isa_bitmap.isa,
+				   ext_list->per_hart_isa_bitmap[cpu].isa,
+				   RISCV_ISA_VENDOR_EXT_MAX);
+		}
+	}
+}
+
 static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 {
 	unsigned int cpu;
@@ -760,6 +803,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		}
 
 		riscv_resolve_isa(source_isa, isainfo->isa, &this_hwcap, isa2hwcap);
+		riscv_fill_cpu_vendor_ext(cpu_node, cpu);
 
 		of_node_put(cpu_node);
 
@@ -776,6 +820,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 			bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
 		else
 			bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
+
+		riscv_fill_vendor_ext_list(cpu);
 	}
 
 	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
@@ -918,28 +964,45 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
 {
 	struct alt_entry *alt;
 	void *oldptr, *altptr;
-	u16 id, value;
+	u16 id, value, vendor;
 
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		return;
 
 	for (alt = begin; alt < end; alt++) {
-		if (alt->vendor_id != 0)
-			continue;
-
 		id = PATCH_ID_CPUFEATURE_ID(alt->patch_id);
+		vendor = PATCH_ID_CPUFEATURE_ID(alt->vendor_id);
 
-		if (id >= RISCV_ISA_EXT_MAX) {
-			WARN(1, "This extension id:%d is not in ISA extension list", id);
-			continue;
-		}
+		/*
+		 * Any alternative with a patch_id that is less than
+		 * RISCV_ISA_EXT_MAX is interpreted as a standard extension.
+		 *
+		 * Any alternative with patch_id that is greater than or equal
+		 * to RISCV_VENDOR_EXT_ALTERNATIVES_BASE is interpreted as a
+		 * vendor extension.
+		 */
+		if (id < RISCV_ISA_EXT_MAX) {
+			/*
+			 * This patch should be treated as errata so skip
+			 * processing here.
+			 */
+			if (alt->vendor_id != 0)
+				continue;
 
-		if (!__riscv_isa_extension_available(NULL, id))
-			continue;
+			if (!__riscv_isa_extension_available(NULL, id))
+				continue;
 
-		value = PATCH_ID_CPUFEATURE_VALUE(alt->patch_id);
-		if (!riscv_cpufeature_patch_check(id, value))
+			value = PATCH_ID_CPUFEATURE_VALUE(alt->patch_id);
+			if (!riscv_cpufeature_patch_check(id, value))
+				continue;
+		} else if (id >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE) {
+			if (!__riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendor,
+								    id - RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
+				continue;
+		} else {
+			WARN(1, "This extension id:%d is not in ISA extension list", id);
 			continue;
+		}
 
 		oldptr = ALT_OLD_PTR(alt);
 		altptr = ALT_ALT_PTR(alt);
diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/vendor_extensions.c
new file mode 100644
index 000000000000..b6c1e7b5d34b
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Rivos, Inc
+ */
+
+#include <asm/vendorid_list.h>
+#include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/andes.h>
+
+#include <linux/array_size.h>
+#include <linux/types.h>
+
+struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] = {
+#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
+	&riscv_isa_vendor_ext_list_andes,
+#endif
+};
+
+const size_t riscv_isa_vendor_ext_list_size = ARRAY_SIZE(riscv_isa_vendor_ext_list);
+
+/**
+ * __riscv_isa_vendor_extension_available() - Check whether given vendor
+ * extension is available or not.
+ *
+ * @cpu: check if extension is available on this cpu
+ * @vendor: vendor that the extension is a member of
+ * @bit: bit position of the desired extension
+ * Return: true or false
+ *
+ * NOTE: When cpu is -1, will check if extension is available on all cpus
+ */
+bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendor, unsigned int bit)
+{
+	struct riscv_isavendorinfo *bmap;
+	struct riscv_isavendorinfo *cpu_bmap;
+
+	switch (vendor) {
+	#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
+	case ANDES_VENDOR_ID:
+		bmap = &riscv_isa_vendor_ext_list_andes.all_harts_isa_bitmap;
+		cpu_bmap = &riscv_isa_vendor_ext_list_andes.per_hart_isa_bitmap[cpu];
+		break;
+	#endif
+	default:
+		return false;
+	}
+
+	if (cpu != -1)
+		bmap = &cpu_bmap[cpu];
+
+	if (bit >= RISCV_ISA_VENDOR_EXT_MAX)
+		return false;
+
+	return test_bit(bit, bmap->isa) ? true : false;
+}
+EXPORT_SYMBOL_GPL(__riscv_isa_vendor_extension_available);
diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/kernel/vendor_extensions/Makefile
new file mode 100644
index 000000000000..6a61aed944f1
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)	+= andes.o
diff --git a/arch/riscv/kernel/vendor_extensions/andes.c b/arch/riscv/kernel/vendor_extensions/andes.c
new file mode 100644
index 000000000000..ec688c88456a
--- /dev/null
+++ b/arch/riscv/kernel/vendor_extensions/andes.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/cpufeature.h>
+#include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/andes.h>
+
+#include <linux/array_size.h>
+#include <linux/types.h>
+
+/* All Andes vendor extensions supported in Linux */
+const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] = {
+	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_VENDOR_EXT_XANDESPMU),
+};
+
+struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_andes = {
+	.ext_data_count = ARRAY_SIZE(riscv_isa_vendor_ext_andes),
+	.ext_data = riscv_isa_vendor_ext_andes,
+};
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 4e842dcedfba..16daebd0af1e 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -25,6 +25,8 @@
 #include <asm/errata_list.h>
 #include <asm/sbi.h>
 #include <asm/cpufeature.h>
+#include <asm/vendor_extensions.h>
+#include <asm/vendor_extensions/andes.h>
 
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
 asm volatile(ALTERNATIVE_2(						\
@@ -33,7 +35,8 @@ asm volatile(ALTERNATIVE_2(						\
 		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
 		CONFIG_ERRATA_THEAD_PMU,				\
 	"csrr %0, " __stringify(ANDES_CSR_SCOUNTEROF),			\
-		0, RISCV_ISA_EXT_XANDESPMU,				\
+		ANDES_VENDOR_ID,					\
+		RISCV_ISA_VENDOR_EXT_XANDESPMU + RISCV_VENDOR_EXT_ALTERNATIVES_BASE, \
 		CONFIG_ANDES_CUSTOM_PMU)				\
 	: "=r" (__ovl) :						\
 	: "memory")
@@ -42,7 +45,8 @@ asm volatile(ALTERNATIVE_2(						\
 asm volatile(ALTERNATIVE(						\
 	"csrc " __stringify(CSR_IP) ", %0\n\t",				\
 	"csrc " __stringify(ANDES_CSR_SLIP) ", %0\n\t",			\
-		0, RISCV_ISA_EXT_XANDESPMU,				\
+		ANDES_VENDOR_ID,					\
+		RISCV_ISA_VENDOR_EXT_XANDESPMU + RISCV_VENDOR_EXT_ALTERNATIVES_BASE, \
 		CONFIG_ANDES_CUSTOM_PMU)				\
 	: : "r"(__irq_mask)						\
 	: "memory")
@@ -1095,7 +1099,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		   riscv_cached_mimpid(0) == 0) {
 		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
-	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
+	} else if (riscv_isa_vendor_extension_available(ANDES_VENDOR_ID, XANDESPMU) &&
 		   IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
 		riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMOVI;
 		riscv_pmu_use_irq = true;

-- 
2.44.0


