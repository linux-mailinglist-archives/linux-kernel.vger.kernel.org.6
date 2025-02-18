Return-Path: <linux-kernel+bounces-518849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFD9A39547
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F741898EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5C223AE7D;
	Tue, 18 Feb 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRkaE6I5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C522B59D;
	Tue, 18 Feb 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866848; cv=none; b=K8BjZ8WaeM8bNr/iXYeI9MmHEGa8u0FfyeMZXlrtzlsuVptYP+4ETGxOutH2hpYXts0Ph1fKFeDfSVh2XRMk+kPxTkyerIbQv1dzHLS7JioCOuIZDamyZ8vxvisNkE5I48k5XfveW7NzusKYCFJaipBT0840Ymar31+WqdJ4CpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866848; c=relaxed/simple;
	bh=AlEyxh75+r5QiPqcPtjpo+/HVa79C4HAQUROM4qi8Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ49P8OErsjKl4AoazfsZasYIGXu6s5UZ8hWJLsGBnXWccclddRgT2+HtTPBxyrPxNuATjYRQNvckc5fViNmKmtLF7llg15vEGAucLRu48kYoz/mvDQ6nCitnjt8hPcoDU42tSv8CaOz+0tQnxJ97l82qfYTg/crrHWydfq0a34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRkaE6I5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866847; x=1771402847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AlEyxh75+r5QiPqcPtjpo+/HVa79C4HAQUROM4qi8Mc=;
  b=eRkaE6I5/2OliVANuvq01HFglALM2FhrNQ293lcR7gJ4NbSeLzVEhuMn
   82aKqjn8ZsNt+uLQnW29ziafBkiXDTK//a3VgDYPvzxqMPMby8Jo7Q9oT
   DAqmXGuiJDzR9EaWwhQI2QJpQsL2vZkxAqZ/92Ki4pIALqyBy5zO7Gbmh
   HT0gBBsNAR+spUYqkvIcRabM2y7jeUPeF+94FhG0+hH6P0mCOmeuAex9q
   PNF+eXZ1SnsWxxsiFjhz2X4XE7b349ziiYdNAMxSdrm1zOhh0rcZwKRpM
   6i/xMSNPS+jggGZbU9+w36XSvc3Idw75nDp/oFHFR+y7X1afUJz7fQVV5
   g==;
X-CSE-ConnectionGUID: 3kkmb2PGRLKs7b8lX1wtmQ==
X-CSE-MsgGUID: NFY+UX9oTaiknRjy7xZbqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28150619"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="28150619"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:20:46 -0800
X-CSE-ConnectionGUID: WmLxTe3CRhiKO8fnH2NB1g==
X-CSE-MsgGUID: lzXfGprHTkiUTI4Yyjdk7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119248085"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:20:25 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: kees@kernel.org,
	julian.stecklina@cyberus-technology.de,
	kevinloughlin@google.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	justinstitt@google.com,
	catalin.marinas@arm.com,
	wangkefeng.wang@huawei.com,
	bhe@redhat.com,
	ryabinin.a.a@gmail.com,
	kirill.shutemov@linux.intel.com,
	will@kernel.org,
	ardb@kernel.org,
	jason.andryuk@amd.com,
	dave.hansen@linux.intel.com,
	pasha.tatashin@soleen.com,
	ndesaulniers@google.com,
	guoweikang.kernel@gmail.com,
	dwmw@amazon.co.uk,
	mark.rutland@arm.com,
	broonie@kernel.org,
	apopple@nvidia.com,
	bp@alien8.de,
	rppt@kernel.org,
	kaleshsingh@google.com,
	richard.weiyang@gmail.com,
	luto@kernel.org,
	glider@google.com,
	pankaj.gupta@amd.com,
	andreyknvl@gmail.com,
	pawan.kumar.gupta@linux.intel.com,
	kuan-ying.lee@canonical.com,
	tony.luck@intel.com,
	tj@kernel.org,
	jgross@suse.com,
	dvyukov@google.com,
	baohua@kernel.org,
	samuel.holland@sifive.com,
	dennis@kernel.org,
	akpm@linux-foundation.org,
	thomas.weissschuh@linutronix.de,
	surenb@google.com,
	kbingham@kernel.org,
	ankita@nvidia.com,
	nathan@kernel.org,
	maciej.wieczor-retman@intel.com,
	ziy@nvidia.com,
	xin@zytor.com,
	rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	cl@linux.com,
	jhubbard@nvidia.com,
	hpa@zytor.com,
	scott@os.amperecomputing.com,
	david@redhat.com,
	jan.kiszka@siemens.com,
	vincenzo.frascino@arm.com,
	corbet@lwn.net,
	maz@kernel.org,
	mingo@redhat.com,
	arnd@arndb.de,
	ytcoode@gmail.com,
	xur@google.com,
	morbo@google.com,
	thiago.bauermann@linaro.org
Cc: linux-doc@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v2 14/14] x86: Make software tag-based kasan available
Date: Tue, 18 Feb 2025 09:15:30 +0100
Message-ID: <d266338a0eae1f673802e41d7230c4c92c3532b3.1739866028.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make CONFIG_KASAN_SW_TAGS available for x86 machines if they have
ADDRESS_MASKING enabled (LAM) as that works similarly to Top-Byte Ignore
(TBI) that allows the software tag-based mode on arm64 platform.

Set scale macro based on KASAN mode: in software tag-based mode 32 bytes
of memory map to one shadow byte and 16 in generic mode.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Remove KASAN dense code.

 arch/x86/Kconfig                | 6 ++++++
 arch/x86/boot/compressed/misc.h | 1 +
 arch/x86/include/asm/kasan.h    | 2 +-
 arch/x86/kernel/setup.c         | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f4ef64bf824a..dc48eb5b664f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -195,6 +195,7 @@ config X86
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
+	select HAVE_ARCH_KASAN_SW_TAGS		if ADDRESS_MASKING
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KMSAN			if X86_64
 	select HAVE_ARCH_KGDB
@@ -402,6 +403,11 @@ config KASAN_SHADOW_OFFSET
 	hex
 	default 0xdffffc0000000000 if KASAN_GENERIC
 
+config KASAN_SHADOW_SCALE_SHIFT
+	int
+	default 4 if KASAN_SW_TAGS
+	default 3
+
 config HAVE_INTEL_TXT
 	def_bool y
 	depends on INTEL_IOMMU && ACPI
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index dd8d1a85f671..f6a87e9ad200 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -13,6 +13,7 @@
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
 #undef CONFIG_KASAN_GENERIC
+#undef CONFIG_KASAN_SW_TAGS
 
 #define __NO_FORTIFY
 
diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index 4bfd3641af84..cfc31e4a2f70 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -6,7 +6,7 @@
 #include <linux/kasan-tags.h>
 #include <linux/types.h>
 
-#define KASAN_SHADOW_SCALE_SHIFT 3
+#define KASAN_SHADOW_SCALE_SHIFT CONFIG_KASAN_SHADOW_SCALE_SHIFT
 
 /*
  * Compiler uses shadow offset assuming that addresses start
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cebee310e200..768990c573ea 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1124,6 +1124,8 @@ void __init setup_arch(char **cmdline_p)
 
 	kasan_init();
 
+	kasan_init_sw_tags();
+
 	/*
 	 * Sync back kernel address range.
 	 *
-- 
2.47.1


