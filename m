Return-Path: <linux-kernel+bounces-374153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086719A659B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF87284283
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28AF1EF084;
	Mon, 21 Oct 2024 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LenFqjpz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F311EBA00
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508260; cv=none; b=ZIGh+WlyO2QKC8NrHugKen8bA/NhWDY9yc0l67ct2fNa+kxmsNQhSeGUlZpF68RACXCc7Su/FZGPTEq1a/gpl4kOGVG3V0wuccqMdP2cSsceTNKrsY0/+aAYxtOfM+bK6H/DAACBz4Rct7Tl0zBUPOBgPh34kjNa0TShMvpF5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508260; c=relaxed/simple;
	bh=NJWPKuhJFb05qZHrkoFF+r7qnXfD1RCxCtsgrjO7Isw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTWHZkKTRqVSfI6V83rYlepZPphWYfYK/+K/pJF0BgoUtJJpCGzTgykg+pSEVLYnKcbl96qNbY+v/2dqlXo9T+rguWJo4B2y3FnLboP7Z3kDgIO01UY1HWO0GRefcIvKOkJw02nfui+qcmmgFx7WACO+OO8HeFq6FRAQ57pYMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LenFqjpz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729508258; x=1761044258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NJWPKuhJFb05qZHrkoFF+r7qnXfD1RCxCtsgrjO7Isw=;
  b=LenFqjpzssmxYpY6KHV7NKu8TQalynFQlQGfqYXgr7AEUoP99QIZ2dUL
   zMTXoaCWMDPnd17er0TOmpIJYdm+Y/6DUt3xrAqm67M9qUVnF3EuSmSmS
   h8Qzm2vxda1P+soegVAy+CBQX3LTEPpLt4I8yJkN7kq7dwgYDx/3oflbu
   CR0dH3OJJqEnapch79gvp89g9yUv0re08MyVAhrR5SD1iXVs+KVcaZ0fn
   0HpXkUzWZAg9X9xl36qnI1kGj5Nk3i/crDihOZgth1zJMXQl6kXyvK/0o
   clK76874xx9q9qecA0drnKUtjQE4uieXQzCECOegAze0p5FdRq+yijE6o
   A==;
X-CSE-ConnectionGUID: dGZtpzhHRT6OZPRusyTBWw==
X-CSE-MsgGUID: TgTx/apURJ2K1wvvAQyDMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46451210"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46451210"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:57:35 -0700
X-CSE-ConnectionGUID: e96WSJFySh+rbRuPL1Zqig==
X-CSE-MsgGUID: 7LZcYE+iTLmj/X/JF4w6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79085643"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 21 Oct 2024 03:57:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CE8F235B; Mon, 21 Oct 2024 13:57:27 +0300 (EEST)
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
Subject: [PATCHv2 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
Date: Mon, 21 Oct 2024 13:57:23 +0300
Message-ID: <20241021105723.2707507-3-kirill.shutemov@linux.intel.com>
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
index 70b02fc61d93..f04df30f0a27 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -503,6 +503,14 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
+{
+	if (flags & MEMREMAP_DEC)
+		return (void __force *)ioremap_cache(phys_addr, size);
+
+	return (void __force *)ioremap_encrypted(phys_addr, size);
+}
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
-- 
2.45.2


