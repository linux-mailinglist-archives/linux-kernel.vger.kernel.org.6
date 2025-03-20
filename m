Return-Path: <linux-kernel+bounces-569344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2113A6A1AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C3F188EA49
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29DA2163BD;
	Thu, 20 Mar 2025 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JmyWlDin"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC004209F4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460301; cv=none; b=bcO0w8kkggdz+KYhJYjOP0MRxTmmphfiBreGTtoHk3WBzYo6/zLqy7TK8YuBXEysq3CSjwpXjw1yff9ItF/GZ+IdoXkMGvkrcTXoyxt6mlo8iVZDYDP7SHlDCkJ82oGNqY/5NWN4gfW1JQA+YtsBRJkdVUyJMn5mLjjcR5p7aQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460301; c=relaxed/simple;
	bh=PUAkcOa6Bl0G2QNTNtI62sTIpXifvuTK+UqRlpvFa3E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DF26Rr0iMzOIaDzBdYaZi8hS9ww8fKf0DFNSLpJtAtA9zemagf4Q51chPGryMBCZgkc98cVavaj72S6aMBB97fNlkwtil9Jpk6D2sI/roBIHQ04+qm6uevZUo5KjLFj9a4HfVy98JXMbAkR1GwRNS4p50T8iJNkjwc8+4PPPHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JmyWlDin; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2243803b776so11444635ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742460298; x=1743065098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ge+2Zy4b/aVKYNPvh9+f0g34JnK38AaqDpbfA611Vw=;
        b=JmyWlDinY9MZNABP1Y4QqLaUgaFWEVf14C210YtFaQLuHExOJyUtJhDzZm+Xix8NZ7
         J/whYnTUVinK72VnwRQwWs5dDzKZYCN6OHhKKAoyWIMF3VdlW6m/o4lT2hVceINwej9/
         kyWjy0ktMf8z5Rj57Fnmaw/xpKB8g67TozbxDnNpkhRgKtMbLBOdcSK6kVdJNcmjHXwg
         uWYdTtfz4WDRPlYtHoofU3A7xQu/8+axEiVFrySKzpeqsGI1cBmiu51JHJabZBY1YToN
         ZsaL4cByQUkkVSwNt1MvZ0E5WREmfK7mhfqxT1VTBQEmt2f6KIj7F2BiFCxzr4XUF7tf
         C93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460298; x=1743065098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ge+2Zy4b/aVKYNPvh9+f0g34JnK38AaqDpbfA611Vw=;
        b=LRmYyJxcUSdH7U5orvDfkmDfUM35GBOhLC7HkuDu8jiv4VX7t+jKgEFSMthtGje24k
         QCz1+V8qnd6jW8ezaMWGWvRYYOQpEu77FOAV5YJz4O9y8mY8GiViNyKns1mSD8YuvhiZ
         36NNJtwYfy8mIaDXJr/AUn2N/CJ9ZsLwzjfWSmfHQNjS22/1fjiwHURCTzo4O/s24s9S
         Zp+tMWTapZBDlJftlyUEwlp8D29ygKtvliTQge5I20AL5iYB4myZvGBW16KXJIxR/wfa
         zp1bq6q66Zd7gdLkzMZTuVbZ/c0GOXj68pWFqSoPKHvP+LzqzhOkZX8WgpUDGqawsupD
         ksBA==
X-Forwarded-Encrypted: i=1; AJvYcCXnbdbjhG9NvvBYPD3WUNzfg5PT/kEyQQXtFI2d2SjeY+H8/ha225jfmwpj0Fxg4DrzVqyEtbtXizI6nMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WjwDH0F9kuJhNL1fMeovpfKZsO3D2qkhnXrG9FIyu51xRBMV
	tUB87H8pINbMAkY0IrfbgYqd34FIW/aih/meKQ2ms3D930+Z6iixhGMantTIspE=
X-Gm-Gg: ASbGncsHJHL1lxdU13z7ckdBcHjqatcNt1A1RNa7W4LpvcgTzWkPaFb0j1/vNejHmel
	k6hk6YzqgoZcu1+nIr+nV5EWnmRfQx/BS8t0SrMzn7SB4RAdm9hsnSnnjD92Zne7/HP+dUQdeXN
	b/digBt9fBxtfDzbwqnQQnZYJsAfGoHkXpU/FDfC0ad3IYvE4CaPZfBHCahD+SBDWDGtZI3XS2K
	wXC2WP4n0vAR1XEK6LGT2/TyNSqv4/cnkdoL2RbhWd3IIlkd5eibj6q/Fj2PWXAgvnrbtZ+GZ1R
	NFqScbuGoHaOf93dWMdMd+HXxc0slPjpKzp3xZiYyn4tTzzOAEx1VFYeXltRGbE9UQYi65TfJcB
	SzjU=
X-Google-Smtp-Source: AGHT+IGpZnMUz3aNkSz4lCZ4lxTHMzea8UwmPxzl9b/dm1grVRgitblsPBXeHqLKUTHra0EyfaksNA==
X-Received: by 2002:a17:903:2281:b0:223:635d:3e38 with SMTP id d9443c01a7336-2264993225bmr75908705ad.15.1742460297818;
        Thu, 20 Mar 2025 01:44:57 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4af3sm129719715ad.236.2025.03.20.01.44.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Mar 2025 01:44:57 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	anshuman.khandual@arm.com,
	akpm@linux-foundation.org,
	mingo@kernel.org,
	cuiyunhui@bytedance.com,
	catalin.marinas@arm.com,
	ryan.roberts@arm.com,
	kirill.shutemov@linux.intel.com,
	namcao@linutronix.de,
	bjorn@rivosinc.com,
	arnd@arndb.de,
	stuart.menefy@codasip.com,
	luxu.kernel@bytedance.com,
	vincenzo.frascino@arm.com,
	samuel.holland@sifive.com,
	christophe.leroy@csgroup.eu,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: introduce the ioremap_prot() function
Date: Thu, 20 Mar 2025 16:44:28 +0800
Message-Id: <20250320084428.51151-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's advisable to avoid mapping memory with the non-cache attribute.
This is because issues may arise when the same physical address is
mapped as both cacheable and non-cacheable simultaneously, such as
in the case of hardware prefetching.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/io.h   |  2 ++
 arch/riscv/include/asm/page.h |  2 ++
 arch/riscv/mm/Makefile        |  1 +
 arch/riscv/mm/init.c          | 12 ++++++++++++
 arch/riscv/mm/ioremap.c       | 15 +++++++++++++++
 5 files changed, 32 insertions(+)
 create mode 100644 arch/riscv/mm/ioremap.c

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index a0e51840b9db..736c5557bd06 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -133,6 +133,8 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, count)
 #endif
 
+#define ioremap_prot ioremap_prot
+
 #include <asm-generic/io.h>
 
 #ifdef CONFIG_MMU
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 125f5ecd9565..181d2d3a0922 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -202,6 +202,8 @@ static __always_inline void *pfn_to_kaddr(unsigned long pfn)
 	return __va(pfn << PAGE_SHIFT);
 }
 
+int pfn_is_map_memory(unsigned long pfn);
+
 #endif /* __ASSEMBLY__ */
 
 #define virt_addr_valid(vaddr)	({						\
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index b916a68d324a..58a75f7d66e9 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o pgtable.o tlbflush.o
 obj-y += cacheflush.o
 obj-y += context.o
 obj-y += pmem.o
+obj-y += ioremap.o
 
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_PTDUMP) += ptdump.o
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 3ec9bfaa088a..74ad96e973a4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -92,6 +92,18 @@ static void __init zone_sizes_init(void)
 	free_area_init(max_zone_pfns);
 }
 
+int pfn_is_map_memory(unsigned long pfn)
+{
+	phys_addr_t addr = PFN_PHYS(pfn);
+
+	/* avoid false positives for bogus PFNs, see comment in pfn_valid() */
+	if (PHYS_PFN(addr) != pfn)
+		return 0;
+
+	return memblock_is_map_memory(addr);
+}
+EXPORT_SYMBOL(pfn_is_map_memory);
+
 #if defined(CONFIG_MMU) && defined(CONFIG_DEBUG_VM)
 
 #define LOG2_SZ_1K  ilog2(SZ_1K)
diff --git a/arch/riscv/mm/ioremap.c b/arch/riscv/mm/ioremap.c
new file mode 100644
index 000000000000..037f87dfe88d
--- /dev/null
+++ b/arch/riscv/mm/ioremap.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/mm.h>
+#include <linux/io.h>
+
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
+			   pgprot_t pgprot)
+{
+	/* Don't allow RAM to be mapped. */
+	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
+		return NULL;
+
+	return generic_ioremap_prot(phys_addr, size, pgprot);
+}
+EXPORT_SYMBOL(ioremap_prot);
-- 
2.39.2


