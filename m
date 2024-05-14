Return-Path: <linux-kernel+bounces-178779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09508C5795
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEA8283881
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B51448ED;
	Tue, 14 May 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYtSJeVM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F9144D25
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695509; cv=none; b=V+scSQC4DH0nkwln4WbInb/1yAQJMlYI7XyH5rfcYrInOafdAL2VsQcnEoO/YqlknSGaSzmiY+luBhwEJANRYqPK4ovS7sDk32l3KvJ5TgtfZsbNH2jOFRyE7iazztf7h1Xe6R5K5nY4aq7OtVy7LD0pjlJdjzwRjjEgfsXZ6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695509; c=relaxed/simple;
	bh=oxMeKBSMHMQ7nR2cm5Yl3ZY7RY3tugjaWnxRJMQRo0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNxx9BzRSeq5yioWPdcc9iKAg8l0SYwdmX8TjtIjGCcEAUU2xZZicTwDdMtg898qhpu7ruAlsE0KqhDnHzJ9Vmg3uaUKkXR9arhTUq/ukWVbf+qgKOKXReaaAsC0FbkTiHJJKYbTDKoorAruJGB0PK10iQx5Wj19+W3VFG6lAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYtSJeVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECB4C32781;
	Tue, 14 May 2024 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695509;
	bh=oxMeKBSMHMQ7nR2cm5Yl3ZY7RY3tugjaWnxRJMQRo0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYtSJeVMCifMMvCoAZTlKZARdYfjyGb+3HXKoeh+9gLb/UkaJfTd3fdRakqc0wiiH
	 xli61NfPUMpvvGx5MC2NpP4aFHaN7qIflyQLsdsGYfftEKuMMD4ZDdwSMxKUopldg2
	 epoHMB0A0f3xCqgRT8XnILBwq4c/Qcf+I9hdtDNmbMUoN6M+E4TfZeNPnRXQe7VCEi
	 mVVd21lXjUiNzuH2g3rQ4vZwbs8BiVsB38K+pOqnMbn3sV+WHj2eBwtH9deDcFJFka
	 VMVpGHW1o/zEaD/fzjuO4Rbeu3m9Kilyv7C53dWfpR7M8Aa7K8gCfy9ZFkXpBtkQwB
	 u0bIh5mMUxCRg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/8] riscv: mm: Pre-allocate vmemmap/direct map PGD entries
Date: Tue, 14 May 2024 16:04:39 +0200
Message-Id: <20240514140446.538622-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514140446.538622-1-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V port copies the PGD table from init_mm/swapper_pg_dir to
all userland page tables, which means that if the PGD level table is
changed, other page tables has to be updated as well.

Instead of having the PGD changes ripple out to all tables, the
synchronization can be avoided by pre-allocating the PGD entries/pages
at boot, avoiding the synchronization all together.

This is currently done for the bpf/modules, and vmalloc PGD regions.
Extend this scheme for the PGD regions touched by memory hotplugging.

Prepare the RISC-V port for memory hotplug by pre-allocate
vmemmap/direct map entries at the PGD level. This will roughly waste
~128 worth of 4K pages when memory hotplugging is enabled in the
kernel configuration.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/kasan.h | 4 ++--
 arch/riscv/mm/init.c           | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index 0b85e363e778..e6a0071bdb56 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -6,8 +6,6 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_KASAN
-
 /*
  * The following comment was copied from arm64:
  * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
@@ -34,6 +32,8 @@
  */
 #define KASAN_SHADOW_START	((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) & PGDIR_MASK)
 #define KASAN_SHADOW_END	MODULES_LOWEST_VADDR
+
+#ifdef CONFIG_KASAN
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 
 void kasan_init(void);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2574f6a3b0e7..5b8cdfafb52a 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -27,6 +27,7 @@
 
 #include <asm/fixmap.h>
 #include <asm/io.h>
+#include <asm/kasan.h>
 #include <asm/numa.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
@@ -1488,10 +1489,16 @@ static void __init preallocate_pgd_pages_range(unsigned long start, unsigned lon
 	panic("Failed to pre-allocate %s pages for %s area\n", lvl, area);
 }
 
+#define PAGE_END KASAN_SHADOW_START
+
 void __init pgtable_cache_init(void)
 {
 	preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc");
 	if (IS_ENABLED(CONFIG_MODULES))
 		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
+		preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, "vmemmap");
+		preallocate_pgd_pages_range(PAGE_OFFSET, PAGE_END, "direct map");
+	}
 }
 #endif
-- 
2.40.1


