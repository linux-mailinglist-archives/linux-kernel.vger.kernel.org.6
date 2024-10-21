Return-Path: <linux-kernel+bounces-374152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B18B9A6599
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D851F22FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE81EBFEA;
	Mon, 21 Oct 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DV7Ybs72"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA821E7C07
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508258; cv=none; b=a6I0sNGNnFhkP7PUmquTqChPwLj8GBZkEa33HFyKZSiESwWfaUZIANTnnqh2xULIXgZ4Wze4yuTOVfXh2nOTP8sQSD3+r+UvHTbE0o+J9AT/R2tAsLFCIAtIe68/dqjF85eVhN7nacIIBy4Xn0ojgdBq4LdvcUgrShjwAlXtN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508258; c=relaxed/simple;
	bh=X7oqsq0bMXF50IQWvSxcxdLufH4ePr/ItKwrUI5ikCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep1BKEoxn4Gmkt6R/IH9e9Jp84nuhi0pAlpPvCeMDvwvPo0fuvdDe0/Lo5TSkQLjF82mhmqH6R4aRFQsQMr7o3/jx5TFYJfnVGUjAyLUV664+NwG4Ms3zW2FpaA8CeltRYVfwl30YZNYHGOr7ODFFZGk2zfsIhT70K9qPuz91Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DV7Ybs72; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729508255; x=1761044255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X7oqsq0bMXF50IQWvSxcxdLufH4ePr/ItKwrUI5ikCs=;
  b=DV7Ybs72/2xRDz2tWOpcMM4rfqE1EeLFzzPAg7ZN3naKuxiJwQ3lt0MN
   Da1b5jLq3DBwPnvs7cgKwRecVq/OZaTTKfNm4sfpGRwhtQ6TabTSOJgfI
   hvSfE+ZWWh1Wjjvx9yx+4IvBazUs9Svlyw8b0FyujkVdSxHNMNiSydlL1
   khy2+breFwMZfDSZ3iuWHq8WDZPpYnw8EjqcTbGende9zgaEFgPgTStgb
   Xq7aHFIH4+CB5AcwVSph1ZzSeOL+vwQG0d4DJ5FL3usSs6IgUjrFS/717
   y0sj92ok71utPPKzOJ1TAbOoqT8/Nyl5Iryr8WsBGSQVBJV4SjTdNR++j
   Q==;
X-CSE-ConnectionGUID: 5WqIFAQcTHirZPAwEqGirg==
X-CSE-MsgGUID: lR+J0oqRRgS4Vc4wsfkLYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46451194"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46451194"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:57:35 -0700
X-CSE-ConnectionGUID: 7ZR6J6H3Sle/1LEQ0yzQuQ==
X-CSE-MsgGUID: bp03jTXsSMSXTCJ7NVwGzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79085639"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 21 Oct 2024 03:57:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BEFF612B; Mon, 21 Oct 2024 13:57:27 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Chan <ericchancf@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kai Huang <kai.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Russell King <linux@armlinux.org.uk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 1/2] memremap: Pass down MEMREMAP_* flags to arch_memremap_wb()
Date: Mon, 21 Oct 2024 13:57:22 +0300
Message-ID: <20241021105723.2707507-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
References: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86 version of arch_memremap_wb() needs the flags to decide if the mapping
has be encrypted or decrypted.

Pass down the flag to arch_memremap_wb(). All current implementations
ignore the argument.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/arm/include/asm/io.h   | 2 +-
 arch/arm/mm/ioremap.c       | 2 +-
 arch/arm/mm/nommu.c         | 2 +-
 arch/riscv/include/asm/io.h | 2 +-
 kernel/iomem.c              | 5 +++--
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 1815748f5d2a..bae5edf348ef 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -381,7 +381,7 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 void iounmap(volatile void __iomem *io_addr);
 #define iounmap iounmap
 
-void *arch_memremap_wb(phys_addr_t phys_addr, size_t size);
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags);
 #define arch_memremap_wb arch_memremap_wb
 
 /*
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 794cfea9f9d4..9f7883e6db46 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -411,7 +411,7 @@ void __arm_iomem_set_ro(void __iomem *ptr, size_t size)
 	set_memory_ro((unsigned long)ptr, PAGE_ALIGN(size) / PAGE_SIZE);
 }
 
-void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
 {
 	return (__force void *)arch_ioremap_caller(phys_addr, size,
 						   MT_MEMORY_RW,
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index c415f3859b20..279641f0780e 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -251,7 +251,7 @@ void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size)
 EXPORT_SYMBOL_GPL(pci_remap_cfgspace);
 #endif
 
-void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
 {
 	return (void *)phys_addr;
 }
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 1c5c641075d2..0257f4aa7ff4 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -136,7 +136,7 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #include <asm-generic/io.h>
 
 #ifdef CONFIG_MMU
-#define arch_memremap_wb(addr, size)	\
+#define arch_memremap_wb(addr, size, flags)	\
 	((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
 #endif
 
diff --git a/kernel/iomem.c b/kernel/iomem.c
index dc2120776e1c..75e61c1c6bc0 100644
--- a/kernel/iomem.c
+++ b/kernel/iomem.c
@@ -6,7 +6,8 @@
 #include <linux/ioremap.h>
 
 #ifndef arch_memremap_wb
-static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
+static void *arch_memremap_wb(resource_size_t offset, unsigned long size,
+			      unsigned long flags)
 {
 #ifdef ioremap_cache
 	return (__force void *)ioremap_cache(offset, size);
@@ -91,7 +92,7 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 		if (is_ram == REGION_INTERSECTS)
 			addr = try_ram_remap(offset, size, flags);
 		if (!addr)
-			addr = arch_memremap_wb(offset, size);
+			addr = arch_memremap_wb(offset, size, flags);
 	}
 
 	/*
-- 
2.45.2


