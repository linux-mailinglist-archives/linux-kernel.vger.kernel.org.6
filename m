Return-Path: <linux-kernel+bounces-184380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051788CA644
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758AD1F21FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97B21106;
	Tue, 21 May 2024 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="muSdhv+c"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524E1BC44
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259220; cv=none; b=eYJeVQ9E/c4T5vAuW0nWonTJ96i/YVtd/9V7CYklTE+TidrqsDVf/n0aTP03uagCQtijqBhf7cZ0OdtM59VCugnhjcoZ/OOSt0J0wYmHG8f7rFZb2DIvoim9TVKY5FwBzvhpP2RbBmAclsRau6xmVH2R7hw/UeMxVp6KMPrHszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259220; c=relaxed/simple;
	bh=7wEi5kE8bwfhHF2F14ATNE3WoMUPNN+o9yVSMVfW9YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=BI71oc5dK+NxkpeTWgyucAQaHgllq99Yj6+Dm4H2/ucx4bU0U6XryyJMrsYxLtfSyMe0mvGg+SBdczPo8cthfH6NHJUaz1HlER1484EfyC+WGxSLx7LxPSQU7Q4uYW4mep58UKui03P+dnScGJxzSVFn5ONiVHtJwqGImycS6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=muSdhv+c; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp0115aff65c3da2d0e7db486888c4b12239~RYKiwuE4J1173811738epoutp012
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240521024010epoutp0115aff65c3da2d0e7db486888c4b12239~RYKiwuE4J1173811738epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=RvOy3FDyQQAo8yQO1IZqkwS+ImL75+nyHDK07TC3cHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=muSdhv+cDnjC2IoX2AQ+taOaMDnDYlA7gEy5suCiGSs+axutgrYlep5EjHuC7Sl5i
	 8f+xm5eiqO63tEcH12evKerEfsXidQ+q8C/o1wrkHK4O8pS/8eS6bJKrbkWY3ePrYe
	 ZSE0sfuhvHrprr5k4ygthfmFV4YR3A+hLArgBORQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240521024010epcas1p2ec24a0caf94e985d6606e0995b215200~RYKiZq-Vd0928709287epcas1p2E;
	Tue, 21 May 2024 02:40:10 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.224]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VjzDn6BCnz4x9Pq; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.5F.09662.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p3ccda7b2d9e6518b4575427c957e19377~RYKhnx8H90314503145epcas1p3c;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp166705647a9d5dccc3e4a41573f7bf81e~RYKhmgNYK2362723627epsmtrp1K;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
X-AuditID: b6c32a35-053ff700000025be-aa-664c09894993
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F6.D3.19234.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epsmtip2fa7c3b4f548e6e646832f9ce331c5706~RYKhbz5Nr1132711327epsmtip2U;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 07/10] memblock: track kernel size on memsize
Date: Tue, 21 May 2024 11:39:54 +0900
Message-Id: <20240521023957.2587005-8-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTV7eT0yfNYOk5VYs569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
	ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fL
	Sy2xMjQwMDIFKkzIzvjfxFuw2qFi1s3LbA2Mi0y7GDk4JARMJK7MDu9i5OIQEtjBKPGr9QMT
	hPOJUWLNv0+scE77vRbmLkZOsI4JO3tYIBI7GSV+/r7PDOF8ZpS4+LSZFaSKTUBb4v2CSWC2
	iICdxLfZB8BsZoFSibdvToBNEhZwkfg+s4cJxGYRUJVou9TBCHITr4C9xLGvYRDL5CVmXvrO
	DmJzCjhIzJ+yGMzmFRCUODnzCQvESHmJ5q2zwW6QEHjLLvGw8S4bxG8uElO+e0LMEZZ4dXwL
	O4QtJfGyvw3Kzpe4cPEVE0R5jcTCiYYQYXuJXV9nsIKEmQU0Jdbv0ofYxCfx7msPK0Q1r0RH
	mxBEtZpEy7OvrBC2jMTff8+gbA+Jw7t/gtlCApMZJS4vz5nAKD8Lyf2zkNw/C2HZAkbmVYxi
	qQXFuempxYYFhvAITc7P3cQITo9apjsYJ779oHeIkYmD8RCjBAezkgjvpi2eaUK8KYmVValF
	+fFFpTmpxYcYTYGBO5FZSjQ5H5ig80riDU0sDUzMjEwsjC2NzZTEec9cKUsVEkhPLEnNTk0t
	SC2C6WPi4JRqYFJI95Qqib0s+edG7+dHVQlqd2dP/Xro5JuUaU8WGvqHbuvLv2F/UETxUITx
	80ad22umzb/JkHvmZEfwNPakjZeMDY8Lbww18uE5uGyi+B3jaGm9ZZ176j1NddxqeQ5M+vFv
	luR7KdX57IFhxgFSKzgLLnSWPK7U52WQj/aaMN9+xcrOhW8XeuvayHjtiVZuZGkVTeDnrl3T
	bZAsskfASeZZUuaWJ37JH87WOzyM+XrTr3wm3/RfZrv4y2cuuLikcOvyCruUq+3f0vdcPisT
	ZJ8kvXDi32iO05fEcsKcrJ/OeVF35+5rvWXvXrr+7j77b8Kj7ClOmSJT+RL+npnbfSJdcOc2
	OfPJTE3zqtwD+5RYijMSDbWYi4oTAWHeV3wYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvG4np0+aQcs+YYs569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR3HZpKTmZJalFunbJXBl/G/iLVjtUDHr5mW2BsZFpl2MnBwSAiYSE3b2
	sHQxcnEICWxnlNjTPoMdIiEj8eb8U6AEB5AtLHH4cDFEzUdGiTX7+9hAatgEtCXeL5jECmKL
	CDhJbLiymgXEZhaolPh3+xZYXFjAReL7zB4mEJtFQFWi7VIHI8hMXgF7iWNfwyBWyUvMvPQd
	bC2ngIPE/CmLwWwhoJIzl86DjeEVEJQ4OfMJ1Hh5ieats5knMArMQpKahSS1gJFpFaNoakFx
	bnpucoGhXnFibnFpXrpecn7uJkZwcGsF7WBctv6v3iFGJg7GQ4wSHMxKIrybtnimCfGmJFZW
	pRblxxeV5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgtgskycXBKNTBJl9+TWb72fnL19NmT
	XlRd05kVclicNYv9qoCuRNti/p8rHBTn9G4qa+bSOBt03OGSq7S7/IeIvsYTYf8Nom966KWr
	arLJujtXGgsZLGTdMcf94Oq44DV/5CY+7nCvbjM0npEQPJ1NhPNB2g3F7vs5B41S+Cey/Jlc
	2iu+Lph97qzVeev6vBPq9jeauhk2WJoZBZyo1r0fZZUxt6BjTWTiFwUvkeWiyckT+ldf/nL9
	luzG9X/tuuLT0mzvVOSr7trw5Wj39O2Crg6HpRyvTNf+G9r4pFPu2OUZNRsfikvPqznH+eix
	6JcH896eKTQ/+KswoYhngy3/43/zqi0CpLfpfb4hWpEu/yw5arr9EiWW4oxEQy3mouJEAAwD
	K73dAgAA
X-CMS-MailID: 20240521024009epcas1p3ccda7b2d9e6518b4575427c957e19377
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p3ccda7b2d9e6518b4575427c957e19377
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p3ccda7b2d9e6518b4575427c957e19377@epcas1p3.samsung.com>

Some memory regions are already being tracked by previous patches. But
there are many memory allocations from memblock and frees to memblock
during the boot time.

This patch tracks the memblock size used for the common kernel. To to
this, tracking memblock size is disabled for some memory handling logics
like early param, device tree, and default cma size.

For precise kernel size, this patch counts not actually freed size to
buddy at boot time, and does not count freed size from ramdisk and init
section.

Additionally this patch does one important thing. This patch blocks
memblock_add_range of memblock_remove_range not to update memsize if
free pages were already released to the buddy allocator.

This is an example. The kernel size is newly added by this patch.

 .kernel    :  135137 KB
 .unusable  :  788073 KB
 .reusable  :  294912 KB

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/of/fdt.c         |  6 ++++++
 include/linux/memblock.h |  6 ++++++
 kernel/dma/contiguous.c  |  7 ++++--
 mm/memblock.c            | 46 ++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c          | 10 ++++++++-
 5 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index da82e5afed01..08638673e106 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -524,6 +524,8 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	if (!initial_boot_params)
 		return;
 
+	memblock_memsize_disable_tracking();
+
 	fdt_scan_reserved_mem();
 	fdt_reserve_elfcorehdr();
 
@@ -537,6 +539,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	}
 
 	fdt_init_reserved_mem();
+	memblock_memsize_enable_tracking();
 }
 
 /**
@@ -1189,12 +1192,15 @@ void __init early_init_dt_scan_nodes(void)
 	if (rc)
 		pr_warn("No chosen node found, continuing without\n");
 
+	memblock_memsize_disable_tracking();
+
 	/* Setup memory, calling early_init_dt_add_memory_arch */
 	early_init_dt_scan_memory();
 
 	/* Handle linux,usable-memory-range property */
 	early_init_dt_check_for_usable_mem_range();
 
+	memblock_memsize_enable_tracking();
 	memblock_memsize_detect_hole();
 }
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index aef02c150f2c..a83ad98ac252 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -620,6 +620,9 @@ extern void memblock_memsize_record(const char *name, phys_addr_t base,
 extern void memblock_memsize_detect_hole(void);
 extern void memblock_memsize_set_name(const char *name);
 extern void memblock_memsize_unset_name(void);
+extern void memblock_memsize_enable_tracking(void);
+extern void memblock_memsize_disable_tracking(void);
+extern void memblock_memsize_mod_kernel_size(long size);
 #else
 static inline void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
@@ -627,6 +630,9 @@ static inline void memblock_memsize_record(const char *name, phys_addr_t base,
 static inline void memblock_memsize_detect_hole(void) { }
 static inline void memblock_memsize_set_name(const char *name) { }
 static inline void memblock_memsize_unset_name(void) { }
+static inline void memblock_memsize_enable_tracking(void){ }
+static inline void memblock_memsize_disable_tracking(void){ }
+static inline void memblock_memsize_mod_kernel_size(long size) { }
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 437c85878280..e9c68b1ee975 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -277,10 +277,11 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 {
 	int ret;
 
+	memblock_memsize_disable_tracking();
 	ret = cma_declare_contiguous(base, size, limit, 0, 0, fixed,
 					"reserved", res_cma);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* Architecture specific contiguous memory fixup. */
 	dma_contiguous_early_fixup(cma_get_base(*res_cma),
@@ -288,7 +289,9 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 
 	memblock_memsize_record("dma_cma", cma_get_base(*res_cma),
 				cma_get_size(*res_cma), false, true);
-	return 0;
+out:
+	memblock_memsize_enable_tracking();
+	return ret;
 }
 
 /**
diff --git a/mm/memblock.c b/mm/memblock.c
index de49e7ce74f1..bb033c20ec43 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2060,6 +2060,23 @@ struct memsize_rgn_struct {
 static struct memsize_rgn_struct memsize_rgn[CONFIG_MAX_MEMBLOCK_MEMSIZE] __initdata_memblock;
 static int memsize_rgn_count __initdata_memblock;
 static const char *memblock_memsize_name __initdata_memblock;
+static long memsize_kinit __initdata_memblock;
+static bool memblock_memsize_tracking __initdata_memblock = true;
+
+void __init memblock_memsize_enable_tracking(void)
+{
+	memblock_memsize_tracking = true;
+}
+
+void __init memblock_memsize_disable_tracking(void)
+{
+	memblock_memsize_tracking = false;
+}
+
+void memblock_memsize_mod_kernel_size(long size)
+{
+	memsize_kinit += size;
+}
 
 static void __init_memblock memsize_get_valid_name(char *valid_name, const char *name)
 {
@@ -2313,6 +2330,12 @@ static void __init_memblock memblock_memsize_record_add(struct memblock_type *ty
 						base, size, false, false);
 		else if (type == &memblock.memory)
 			memblock_memsize_free(base, size);
+	} else if (memblock_memsize_tracking) {
+		if (type == &memblock.reserved) {
+			memblock_dbg("%s: kernel %lu %+ld\n", __func__,
+				     memsize_kinit, (unsigned long)size);
+			memsize_kinit += size;
+		}
 	}
 }
 
@@ -2325,6 +2348,12 @@ static void __init_memblock memblock_memsize_record_remove(struct memblock_type
 		else if (type == &memblock.memory)
 			memblock_memsize_record(memblock_memsize_name,
 						base, size, true, false);
+	} else if (memblock_memsize_tracking) {
+		if (type == &memblock.reserved) {
+			memblock_dbg("%s: kernel %lu %+ld\n", __func__,
+				     memsize_kinit, (unsigned long)size);
+			memsize_kinit -= size;
+		}
 	}
 }
 #endif /* MEMBLOCK_MEMSIZE */
@@ -2442,6 +2471,19 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
 	unsigned long end_pfn = min_t(unsigned long,
 				      PFN_DOWN(end), max_low_pfn);
 
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+	unsigned long start_align_up = PFN_ALIGN(start);
+	unsigned long end_align_down = PFN_PHYS(end_pfn);
+
+	if (start_pfn >= end_pfn) {
+		memblock_memsize_mod_kernel_size(end - start);
+	} else {
+		if (start_align_up > start)
+			memblock_memsize_mod_kernel_size(start_align_up - start);
+		if (end_pfn != max_low_pfn && end_align_down < end)
+			memblock_memsize_mod_kernel_size(end - end_align_down);
+	}
+#endif
 	if (start_pfn >= end_pfn)
 		return 0;
 
@@ -2546,6 +2588,8 @@ void __init memblock_free_all(void)
 
 	pages = free_low_memory_core_early();
 	totalram_pages_add(pages);
+
+	memblock_memsize_disable_tracking();
 }
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
@@ -2672,6 +2716,8 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 	}
 
 	seq_puts(m, "\n");
+	seq_printf(m, " .kernel    : %7lu KB\n",
+		   DIV_ROUND_UP(memsize_kinit, SZ_1K));
 	seq_printf(m, " .unusable  : %7lu KB\n",
 		   DIV_ROUND_UP(reserved, SZ_1K));
 	seq_printf(m, " .reusable  : %7lu KB\n",
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e22ce5675ca..a4c692635e9b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -20,6 +20,7 @@
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
+#include <linux/memblock.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/kasan.h>
@@ -5776,8 +5777,15 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 		free_reserved_page(page);
 	}
 
-	if (pages && s)
+	if (pages && s) {
 		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
+		if (!strcmp(s, "initrd") || !strcmp(s, "unused kernel")) {
+			long size;
+
+			size = -1 * (long)(pages << PAGE_SHIFT);
+			memblock_memsize_mod_kernel_size(size);
+		}
+	}
 
 	return pages;
 }
-- 
2.25.1


