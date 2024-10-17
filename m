Return-Path: <linux-kernel+bounces-370111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB93E9A27D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D10B2B7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6B11DBB2C;
	Thu, 17 Oct 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0jMbSe+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411CF1DEFFB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180628; cv=none; b=mxYZs+yGVeXrCj2mpFyTQGXQ9nk2gw1yl7+xe+9cWYVL4EhVvufmk1PU72R/4MKTKW2GjLUURN5vJlHcGe5IWbzZe2i9CXCX1T6vdK3mH+e6ZrHaRZD8l/PKcHHZ7ggOulcUYEovxYRUQfUyzJ8e9t+LEHLMlX2QKOQDKbQBdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180628; c=relaxed/simple;
	bh=/VD9JVIlRFWH9Bbc/DMmpRuCSyMrevX6I9tRJs6OSeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOp8JxzJpE/LZfiRgHh+kEibT8SDrxneKUDY6RcFpxbzgwFbPPmonxSEjNmTyRrz1gdemSKAlR5VA8Nn1+gYIE8y/JxJNetBXmd2+ZUjjpPcyFWCL/EpIlfdXOg+OLQwcJQp9Uehi5T9UuOZDdfYJ77OyatjT4qe3sMU7ppMfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0jMbSe+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729180624; x=1760716624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/VD9JVIlRFWH9Bbc/DMmpRuCSyMrevX6I9tRJs6OSeA=;
  b=C0jMbSe+pk2jNze4JcBzX+ftAcmVjVnCCYadf4qjW/OeitV2IKNj8svg
   8X2IBthtJ35xFmXFC9yp6+IlLt39Z/sbKP4fFMDBpB44Cep90TGDIOe55
   n9m/JMT7Hz98cAOdmvogdlzQlNNor6tUSQBlcYSggb1InUzM22NZI3v5S
   KkbLjoTmFSROH6qTUfVIoGGzMcWy8yD0Q7veEuJHrhZk7jWqd65SFCAW1
   BVNg68QceuXIwqIMBITJHnSO5B9Dqag9j8wCN8GfONpcJpS6nRUPhFTma
   bIO1aOp+UP6L0+05S+lAFttlYyDpemhcb4h33o1mzyVED8AgbXaY0aEPJ
   w==;
X-CSE-ConnectionGUID: WMmCI3QzT3yPLriChcaNuA==
X-CSE-MsgGUID: gWxLkcvgSg+CZ3w2yzKh2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32471904"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="32471904"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 08:57:03 -0700
X-CSE-ConnectionGUID: vA5l5zXuT9yH2rdgTtEmzA==
X-CSE-MsgGUID: 8Nvm5QWhT6KF+CcCuAQORA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83233226"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 17 Oct 2024 08:56:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D957036B; Thu, 17 Oct 2024 18:56:54 +0300 (EEST)
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
Date: Thu, 17 Oct 2024 18:56:42 +0300
Message-ID: <20241017155642.1942514-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017155642.1942514-1-kirill.shutemov@linux.intel.com>
References: <20241017155642.1942514-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently memremap(MEMREMAP_WB) produces decrypted/shared mapping:

memremap(MEMREMAP_WB)
  arch_memremap_wb()
    ioremap_cache()
      __ioremap_caller(.encrytped = false)

It is a bad default. On TDX guests, access via shared mapping can be
destructive[1].

Kernel already provides a way to request decrypted mapping explicitly
via MEMREMAP_DEC flag.

Make memremap(MEMREMAP_WB) produce encrypted/private mapping by default
unless MEMREMAP_DEC is specified.

It fixes crash on kexec in TDX guests if CONFIG_EISA is enabled.

[1] https://lore.kernel.org/all/20240822095122.736522-1-kirill.shutemov@linux.intel.com

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
---
 arch/x86/include/asm/io.h | 3 +++
 arch/x86/mm/ioremap.c     | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 1d60427379c9..1a3a34b40598 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -180,6 +180,9 @@ extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, un
 extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
 #define ioremap_encrypted ioremap_encrypted
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags);
+#define arch_memremap_wb arch_memremap_wb
+
 /**
  * ioremap     -   map bus memory into CPU space
  * @offset:    bus address of the memory
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 70b02fc61d93..fc65a81fd777 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -503,6 +503,14 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
+{
+	if (flags & MEMREMAP_DEC)
+		return ioremap_cache(phys_addr, size);
+
+	return ioremap_encrypted(phys_addr, size);
+}
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
-- 
2.45.2


