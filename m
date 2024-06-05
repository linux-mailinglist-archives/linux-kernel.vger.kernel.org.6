Return-Path: <linux-kernel+bounces-202276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE45E8FCAA4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7FB2840FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75D194124;
	Wed,  5 Jun 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HATjXYku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D93140380
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587684; cv=none; b=uudsI2FISMMGXKLbrEgZDhi2GoOOBylh+Gp01UKpJh8GZR2owC4O0nTjalVgWG8YjIP+IYEXWX1G24+d9+P3sVMaNoun9Afayp9NaxM5/DB+o1dy1hxWci2ZPPT2v32sVk4OqYyK7n933ttfP8tNs6uYcGFrI1mYukn0XOXfuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587684; c=relaxed/simple;
	bh=HsHTP5EMBxXRbP7gHM9U5cuEmdv/0OsepSBXxmcR9vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWKEN5MJedXWEZSVUNhGqqyaZvEXvELcUWhh1YvWABaO+rDAQdEjZCZcBDAlwT3It2KOETJl+d6tK/4uL3RCvbgIns5fyzBJBpgeOEJJTudhnt380d5j72KWNAlkMTdYoI25DmwrzRWIk8Y0bUaXz5ZxCOomAUYqzJ7ed96wwLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HATjXYku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A38C32781;
	Wed,  5 Jun 2024 11:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587683;
	bh=HsHTP5EMBxXRbP7gHM9U5cuEmdv/0OsepSBXxmcR9vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HATjXYkuNGAJd6ZLv+T2v73tr+Mc6k2jRhJItwlkYIAMhhwWJcS9UAkccUyjIGocm
	 FpT5Qk21uUbdooqRUAgy0kZUw+P/J0vSaZ/BBxDRdx4Ux/+hf7kGQ9N5Qrv6wvPA7i
	 nDivxB55BW0xjUIvNRnHMGR086mp0iiVgd/1dXwNc6PCovq009SjJTw4oRIZcmWQYR
	 jCrbPH4Os670nJF5DH11/jvO5GP+uTC5v335/W5W7nBd01MhUwdEyweJtBVvSA7sad
	 ALF4qUwr8X3xtfo2/HtKrJcfrhAbSKFg21UaNds30Hdi0KwftR7UHoI+cd51TBVay7
	 nivI6FKPDR+hA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v4 02/11] riscv: mm: Pre-allocate vmemmap/direct map/kasan PGD entries
Date: Wed,  5 Jun 2024 13:40:45 +0200
Message-ID: <20240605114100.315918-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
References: <20240605114100.315918-1-bjorn@kernel.org>
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
vmemmap/direct map/kasan entries at the PGD level. This will roughly
waste ~128 (plus 32 if KASAN is enabled) worth of 4K pages when memory
hotplugging is enabled in the kernel configuration.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/kasan.h | 4 ++--
 arch/riscv/mm/init.c           | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

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
index fe5072f66c8c..a5b3bc1f3b88 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -28,6 +28,7 @@
 
 #include <asm/fixmap.h>
 #include <asm/io.h>
+#include <asm/kasan.h>
 #include <asm/numa.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
@@ -1493,11 +1494,19 @@ static void __init preallocate_pgd_pages_range(unsigned long start, unsigned lon
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
+		if (IS_ENABLED(CONFIG_KASAN))
+			preallocate_pgd_pages_range(KASAN_SHADOW_START, KASAN_SHADOW_END, "kasan");
+	}
 }
 #endif
 
-- 
2.43.0


