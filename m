Return-Path: <linux-kernel+bounces-184381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE468CA647
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14D81C2117C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89F433A0;
	Tue, 21 May 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nmo4ySHF"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499181BF24
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259220; cv=none; b=h5QvZ3y4K+NXR6+S5zGDYoP5d2/UM3XuR4JUwlXH0v63ROHQZMCiErFnxpcTZqWyL8T9OzvEmvqQGuOKYeLODPs3geEoNccF8kBGQXDqNL7QmEhsdDkm/8zs1Vk6f2bAgcCx1El1OdglWWt4xD8FpqDCLuiaHgtDMlKq9jzmjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259220; c=relaxed/simple;
	bh=im36wEU2WHavWkkRoWVAdzV3iT/tMu+qzFAlTzvfQ68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=dkjtkcouqXfg2VK8+BvapHivowc+AI1n4JKIMOgVPDSf0ZHFcnf4/oV3Gd52gcFh9R1XNgRhI1u98Y9lAKQbE55LqEs0Ge8nsPOC6cKSU9b+T7AqnlKIINrJWkniJ12RjOOaKzUIzr53G1D4taupXzce3y12h89B4GR+jfd26CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nmo4ySHF; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp03a8cd09909fd80acaf03a9f6c901ba881~RYKiqCAdB0915109151epoutp03L
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240521024010epoutp03a8cd09909fd80acaf03a9f6c901ba881~RYKiqCAdB0915109151epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=PxYQXA34qCgfe8GO97dXEa7W4zQKRhqOk+fXrigSuB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmo4ySHFeHa1k8OqFW4m4SdJ1CA+2GltoaYHpQeo2QbBAq4L8KVMYNLvoXC7Z66OS
	 fG1qVVh8mlTlloumnvo2K/Sqpbu8Mr/90g9qnxUiJqazMaX6opy6shNPGQnpfCQcVr
	 7KEk5SYFKj2AKbfWKoZM9RNowTP9iDIL6mG/ms2A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epcas1p4c9f71380c8227e6c9d58ad4a55f15698~RYKiEKIk_2938729387epcas1p4a;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.240]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VjzDn3hdbz4x9Q3; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	E2.13.10158.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p4451928c8f5b32bf84082a24c59ca7dd0~RYKhVWO221520715207epcas1p43;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp28aac1566bc1d70947e63cddc2b6abc54~RYKhUfLwN2496224962epsmtrp2h;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
X-AuditID: b6c32a38-b41fa700000027ae-08-664c09890d7b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	45.D3.19234.8890C466; Tue, 21 May 2024 11:40:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024008epsmtip211bad4828adbe078dc88acc85576b390~RYKhIrXH91232612326epsmtip2E;
	Tue, 21 May 2024 02:40:08 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 01/10] memblock: introduce memsize showing reserved
 memory
Date: Tue, 21 May 2024 11:39:48 +0900
Message-Id: <20240521023957.2587005-2-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTT7eT0yfN4MhvcYs569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
	ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fL
	Sy2xMjQwMDIFKkzIzvg19SVzwUnvirn7rrE3MB626WLk5JAQMJF4d+gHaxcjF4eQwA5Gib5P
	k5ghnE+MEp+m7GWBc84++soO03Lu+VEmiMRORollU6dDVX1mlNj7+i4LSBWbgLbE+wWTWEFs
	EQE7iW+zD4DZzAKlEm/fnGAGsYUFgiX+PFsKZrMIqErMOL8VzOYVsJdoW/4Oapu8xMxL38Fs
	TgEHiflTFrND1AhKnJz5hAViprxE89bZYHdLCHxkl7h4/hUrRLOLxPznr6AGCUu8Or4FypaS
	+PxuLxuEnS9x4eIroHc4gOwaiYUTDSHC9hK7vs5gBQkzC2hKrN+lD7GKT+Ld1x5WiGpeiY42
	IYhqNYmWZ1+hlspI/P33DMr2kNi85TI0rCYzSrxYsZRpAqP8LCQfzELywSyEbQsYmVcxiqUW
	FOempxYbFpjAYzU5P3cTIzhRalnsYJz79oPeIUYmDsZDjBIczEoivJu2eKYJ8aYkVlalFuXH
	F5XmpBYfYjQFhu9EZinR5Hxgqs4riTc0sTQwMTMysTC2NDZTEuc9c6UsVUggPbEkNTs1tSC1
	CKaPiYNTqoFJ99f/yOMcU1ZfaZ72wIzl5s2nMu5zdly7/kz1lkpl8+FncZMZ/peePP2Fe/ZX
	3c2cPC4H/jro7fXmmPE3I0767ckpQeVs7NVlbcKqM3S3ZXdv5ebfke9Z8f9SSXl9kUZynPTU
	FwaRmspbhWdIpfiVHQlrW5FtXnSQp0PYtYh1kptsutzs0itSX5N9irUOqTbLZ3LJ/tL4d2fx
	XcarCw7YrZz1dVX74+bc+l3/S5Y/anj1LjQr/+bvHc+M5n1T7tqcyMy6oe/j+cagk1cd3rhJ
	5N2TtHv3WmGHWsPXaZt4/BR4K2Ieqs15tJ45I/zCY47TExjr3ULV7qjkmy5b8tzo/M0o3TMf
	zd/O4o5K7b+mxFKckWioxVxUnAgAhdToVx0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvG4Hp0+aQf9rG4s569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR3HZpKTmZJalFunbJXBl/Jr6krngpHfF3H3X2BsYD9t0MXJySAiYSJx7
	fpSpi5GLQ0hgO6PE27nNbBAJGYk355+ydDFyANnCEocPF0PUfGSUOPNkP1gNm4C2xPsFk1hB
	bBEBJ4kNV1azgNjMApUS/27fAosLCwRKvFv3ByzOIqAqMeP8VmYQm1fAXqJt+Tt2iF3yEjMv
	fQezOQUcJOZPWQxmCwHVnLl0nhWiXlDi5MwnUPPlJZq3zmaewCgwC0lqFpLUAkamVYyiqQXF
	uem5yQWGesWJucWleel6yfm5mxjBAa4VtINx2fq/eocYmTgYDzFKcDArifBu2uKZJsSbklhZ
	lVqUH19UmpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cAkEmxWovrH48vF7S8a
	7yr7/6xuCHGYFJwwLbd4H0t2jRSPvVzM99jVjOvnz786kZ9vd+qHP+wONaIXVm58yD/pYLCr
	VgHD78rg0P/pk7xO6tX6bI43MD6/5eQDr3KFfYr3/4XMLXyxPXVK5EnlyQ1sZvtnmU3r6HO3
	9r34ezL7j8lmO480l/WovBfk5XKY7JR34/u3s0ftzspZOE3M+iInxfB0hmVb2PW9/if7L/v8
	d9g9yfO0wJcVURc2lIWY79p9hJF1vbHX7zVhqneOSrQzf4sXO/aQOWOntGnSzRWvz02pWHjq
	4W7nftuC3ECzni6Ns+eDfdyehVifqbl44GzH9PsXepkVGG6Lci/nye9RYinOSDTUYi4qTgQA
	Jn5UF98CAAA=
X-CMS-MailID: 20240521024009epcas1p4451928c8f5b32bf84082a24c59ca7dd0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p4451928c8f5b32bf84082a24c59ca7dd0
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p4451928c8f5b32bf84082a24c59ca7dd0@epcas1p4.samsung.com>

Some of memory regions can be reserved for a specific purpose. They are
usually defined through reserved-memory in device tree. If only size
without address is specified in device tree, the address of the region
will be determined at boot time.

We may find the address of the memory regions through booting log, but
it does not show all. And it could be hard to catch the very beginning
log. The memblock_dump_all shows all memblock status but it does not
show region name and its information is difficult to summarize.

This patch introduce a debugfs node, memblock/memsize, to see reserved
memory easily.

The first patch here will show the only reserved-memory in device tree
like following example. The next patches will show more information.

There is a case in which the reserved memory region name has @ staring
string at the end. That information is not actually needed. Let's remove
those string.

$ cat debugfs/memblock/memsize
0x0f9000000-0x0fb000000 0x02000000 (   32768 KB )   map reusable linux,cma
0x0b1900000-0x0b1b00000 0x00200000 (    2048 KB ) nomap unusable test1
0x0b0200000-0x0b0400000 0x00200000 (    2048 KB )   map unusable test2

unusable  :   4096 KB
reusable  :  32768 KB

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/of/fdt.c             |   3 +
 drivers/of/of_reserved_mem.c |   9 ++-
 include/linux/memblock.h     |   9 +++
 kernel/dma/contiguous.c      |   2 +
 mm/Kconfig                   |  16 +++++
 mm/memblock.c                | 120 +++++++++++++++++++++++++++++++++++
 6 files changed, 156 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8a04f27915b..605c7f471908 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -502,6 +502,8 @@ static void __init fdt_reserve_elfcorehdr(void)
 	}
 
 	memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
+	memblock_memsize_record("elfcorehdr", elfcorehdr_addr, elfcorehdr_size,
+				false, false);
 
 	pr_info("Reserving %llu KiB of memory at 0x%llx for elfcorehdr\n",
 		elfcorehdr_size >> 10, elfcorehdr_addr);
@@ -531,6 +533,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		if (!size)
 			break;
 		memblock_reserve(base, size);
+		memblock_memsize_record("memreserve", base, size, false, false);
 	}
 
 	fdt_init_reserved_mem();
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 46e1c3fbc769..ece678e07304 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -438,9 +438,10 @@ void __init fdt_init_reserved_mem(void)
 		struct reserved_mem *rmem = &reserved_mem[i];
 		unsigned long node = rmem->fdt_node;
 		int err = 0;
-		bool nomap;
+		bool nomap, reusable;
 
 		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+		reusable = of_get_flat_dt_prop(node, "reusable", NULL) != NULL;
 
 		if (rmem->size == 0)
 			err = __reserved_mem_alloc_size(node, rmem->name,
@@ -457,14 +458,16 @@ void __init fdt_init_reserved_mem(void)
 							   rmem->size);
 			} else {
 				phys_addr_t end = rmem->base + rmem->size - 1;
-				bool reusable =
-					(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
 
 				pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
 					&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
 					nomap ? "nomap" : "map",
 					reusable ? "reusable" : "non-reusable",
 					rmem->name ? rmem->name : "unknown");
+
+				memblock_memsize_record(rmem->name, rmem->base,
+							rmem->size, nomap,
+							reusable);
 			}
 		}
 	}
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index e2082240586d..9ccba9bb20cb 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -613,5 +613,14 @@ static inline void early_memtest(phys_addr_t start, phys_addr_t end) { }
 static inline void memtest_report_meminfo(struct seq_file *m) { }
 #endif
 
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+extern void memblock_memsize_record(const char *name, phys_addr_t base,
+				    phys_addr_t size, bool nomap,
+				    bool reusable);
+#else
+static inline void memblock_memsize_record(const char *name, phys_addr_t base,
+				    phys_addr_t size, bool nomap,
+				    bool reusable) { }
+#endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 055da410ac71..437c85878280 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -286,6 +286,8 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 	dma_contiguous_early_fixup(cma_get_base(*res_cma),
 				cma_get_size(*res_cma));
 
+	memblock_memsize_record("dma_cma", cma_get_base(*res_cma),
+				cma_get_size(*res_cma), false, true);
 	return 0;
 }
 
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..7fd25088b9b8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -476,6 +476,22 @@ config HAVE_GUP_FAST
 	depends on MMU
 	bool
 
+config MAX_MEMBLOCK_MEMSIZE
+	int "Maximum number of tracking regions"
+	depends on MEMBLOCK_MEMSIZE
+	default 100
+	range 0 200
+	help
+	  This number sets maximum number of tracking regions. If this is set to
+	  0, nothing will be saved.
+
+config MEMBLOCK_MEMSIZE
+	bool "memblock based reserved memory profiling"
+	default n
+	help
+	  This patch introduce a node, memblock/memsize, to see reserved memory
+	  easily.
+
 # Don't discard allocated memory used to track "memory" and "reserved" memblocks
 # after early boot, so it can still be used to test for validity of memory.
 # Also, memblocks are updated with memory hot(un)plug.
diff --git a/mm/memblock.c b/mm/memblock.c
index d09136e040d3..f05e7df2f8e1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -19,6 +19,7 @@
 
 #include <asm/sections.h>
 #include <linux/io.h>
+#include <linux/sort.h>
 
 #include "internal.h"
 
@@ -2025,6 +2026,66 @@ static int __init early_memblock(char *p)
 }
 early_param("memblock", early_memblock);
 
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+
+#define NAME_SIZE	100
+struct memsize_rgn_struct {
+	phys_addr_t	base;
+	long		size;
+	bool		nomap;			/*  1/32 byte */
+	bool		reusable;		/*  1/32 byte */
+	char		name[NAME_SIZE];	/* 30/32 byte */
+};
+
+static struct memsize_rgn_struct memsize_rgn[CONFIG_MAX_MEMBLOCK_MEMSIZE] __initdata_memblock;
+static int memsize_rgn_count __initdata_memblock;
+
+static void __init_memblock memsize_get_valid_name(char *valid_name, const char *name)
+{
+	char *head, *tail, *found;
+	int val_size;
+
+	head = (char *)name;
+	tail = head + strlen(name);
+
+	/* get tail position after valid char */
+	found = strchr(name, '@');
+	if (found)
+		tail = found;
+
+	val_size = tail - head;
+	if (val_size > NAME_SIZE - 1)
+		val_size = NAME_SIZE - 1;
+	strscpy(valid_name, head, val_size);
+	valid_name[val_size] = '\0';
+}
+
+void __init_memblock memblock_memsize_record(const char *name, phys_addr_t base,
+			     phys_addr_t size, bool nomap, bool reusable)
+{
+	struct memsize_rgn_struct *rgn;
+	phys_addr_t end;
+
+	if (memsize_rgn_count == CONFIG_MAX_MEMBLOCK_MEMSIZE) {
+		pr_err("not enough space on memsize_rgn\n");
+		return;
+	}
+	rgn = &memsize_rgn[memsize_rgn_count++];
+	rgn->base = base;
+	rgn->size = size;
+	rgn->nomap = nomap;
+	rgn->reusable = reusable;
+
+	if (!name)
+		strscpy(rgn->name, "unknown", sizeof(rgn->name));
+	else
+		memsize_get_valid_name(rgn->name, name);
+	end = base + size - 1;
+	memblock_dbg("%s %pa..%pa nomap:%d reusable:%d\n",
+		     __func__, &base, &end, nomap, reusable);
+}
+#endif /* MEMBLOCK_MEMSIZE */
+
 static void __init free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct page *start_pg, *end_pg;
@@ -2289,6 +2350,61 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 }
 DEFINE_SHOW_ATTRIBUTE(memblock_debug);
 
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+
+static int memsize_rgn_cmp(const void *a, const void *b)
+{
+	const struct memsize_rgn_struct *ra = a, *rb = b;
+
+	if (ra->base > rb->base)
+		return -1;
+
+	if (ra->base < rb->base)
+		return 1;
+
+	return 0;
+}
+
+static int memblock_memsize_show(struct seq_file *m, void *private)
+{
+	int i;
+	struct memsize_rgn_struct *rgn;
+	unsigned long reserved = 0, reusable = 0;
+
+	sort(memsize_rgn, memsize_rgn_count,
+	     sizeof(memsize_rgn[0]), memsize_rgn_cmp, NULL);
+	for (i = 0; i < memsize_rgn_count; i++) {
+		phys_addr_t base, end;
+		long size;
+
+		rgn = &memsize_rgn[i];
+		base = rgn->base;
+		size = rgn->size;
+		end = base + size;
+
+		seq_printf(m, "0x%pK-0x%pK 0x%08lx ( %7lu KB ) %s %s %s\n",
+			   (void *)base, (void *)end,
+			   size, DIV_ROUND_UP(size, SZ_1K),
+			   rgn->nomap ? "nomap" : "  map",
+			   rgn->reusable ? "reusable" : "unusable",
+			   rgn->name);
+		if (rgn->reusable)
+			reusable += (unsigned long)rgn->size;
+		else
+			reserved += (unsigned long)rgn->size;
+	}
+
+	seq_puts(m, "\n");
+	seq_printf(m, " .unusable  : %7lu KB\n",
+		   DIV_ROUND_UP(reserved, SZ_1K));
+	seq_printf(m, " .reusable  : %7lu KB\n",
+		   DIV_ROUND_UP(reusable, SZ_1K));
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(memblock_memsize);
+#endif
+
 static int __init memblock_init_debugfs(void)
 {
 	struct dentry *root = debugfs_create_dir("memblock", NULL);
@@ -2301,6 +2417,10 @@ static int __init memblock_init_debugfs(void)
 	debugfs_create_file("physmem", 0444, root, &physmem,
 			    &memblock_debug_fops);
 #endif
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+	debugfs_create_file("memsize", 0444, root,
+			    NULL, &memblock_memsize_fops);
+#endif
 
 	return 0;
 }
-- 
2.25.1


