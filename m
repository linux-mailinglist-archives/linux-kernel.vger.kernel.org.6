Return-Path: <linux-kernel+bounces-184383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2788CA648
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B381C20FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA0E433B9;
	Tue, 21 May 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ioKZ5v8+"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B381B970
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259221; cv=none; b=d3HOF52+H+ooY/o51PWCX0b4BNmDJ4sQbr0Lmho1FI2YVqEC3KiuQZSmw65U3fxiDlKO/KNM/aVEYUXtTRPdQsSiWkNiM/hVOrhKRF2VOP12WwyH11JQ6nzHYHWeUDRATWc/fK/wrFYrWv1f9CzMeN2a35tkwJwYdg/ypE9JW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259221; c=relaxed/simple;
	bh=WsZRGGNqmvBYXTDBYNGv+98AjYFP7QiwZGNsVDoedc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=j5pQgERe+6yzNlG2iaHrvjc58vTWAXQ5O4oUJUWt841hMsgJ2CshZMUyj2R3CZQJ4FjnTOBaYZFzfe3Ftrdd7rVJs3BzYx0uTvsQd4a+LKNigGVHg4cpQQlWbkCkFSaVxv2eQC342Fxp9YJQKDXmjzoKML2KhqpsUIfeU6lt57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ioKZ5v8+; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp01f328d3c398ee331b2f946afb11797cb7~RYKiyaXTI1198511985epoutp01x
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240521024010epoutp01f328d3c398ee331b2f946afb11797cb7~RYKiyaXTI1198511985epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=3kKY9p5rX9c1bN2ssSLpLQuO2G9ldZSHB4ioCNHoa30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioKZ5v8+EiGjygozsgC5p+pkEgQD7JtEhkp4fN0M3y/s/D/L3qEG5YWaLeDKQDydR
	 P9usUwGGq173W1LY+Ivw3z2D5R6Y4x9wCwreahs5irq2gx+TifrgR5xHU14xuEg8R7
	 AJO7t7DQCYACPiabfKp742Xo0JJVZe3pYTeXjMnM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epcas1p1cf3280cf33e9d6057ea5c4b3f7d01c0b~RYKiHzV952332223322epcas1p1j;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.224]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VjzDn48LTz4x9Q0; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AF.4F.09662.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p20ddcabed3d037904a9c651d27f82c077~RYKhfz-vs0129801298epcas1p2n;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp22b86ded1b29f1daf8837089c371f91f3~RYKhfM07S2496124961epsmtrp2q;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
X-AuditID: b6c32a35-8da83a80000025be-a9-664c0989ddba
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.EA.09238.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epsmtip24e01e0bac44534b743d22ec2b6b08031~RYKhVkH0A1233912339epsmtip2D;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 05/10] memblock: track memblock changed at early
 param
Date: Tue, 21 May 2024 11:39:52 +0900
Message-Id: <20240521023957.2587005-6-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTX7eT0yfN4PBpOYs569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
	ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fL
	Sy2xMjQwMDIFKkzIztg4+zdrwX6rir69G1kbGG/qdTFycEgImEgcXGrSxcjFISSwg1HiwPEJ
	jBDOJ0aJbztXs0A43xglmiYfZe9i5ATruPV6OxtEYi+jxPXj06CqPjNKnNv6ngWkik1AW+L9
	gkmsILaIgJ3Et9kHwGxmgVKJt29OMIPYwgL+Es1b1rGB2CwCqhLLPk4D6+UVsJdoO7SQEWKb
	vMTMS9/BNnMKOEjMn7KYHaJGUOLkzCcsEDPlJZq3zmaGqP/KLnFkfRqE7SKxc84hFghbWOLV
	8S1QH0hJfH63lw3Czpe4cPEVEyQsaiQWTjSECNtL7Po6gxUkzCygKbF+lz7EJj6Jd197WCGq
	eSU62oQgqtUkWp59ZYWwZST+/nsGZXtIXL/eDLZISGAyo8S/BZwTGOVnIbl/FpL7ZyEsW8DI
	vIpRLLWgODc9tdiwwBAepcn5uZsYwSlSy3QH48S3H/QOMTJxMB5ilOBgVhLh3bTFM02INyWx
	siq1KD++qDQntfgQoykwdCcyS4km5wOTdF5JvKGJpYGJmZGJhbGlsZmSOO+ZK2WpQgLpiSWp
	2ampBalFMH1MHJxSDUxBweqVd2dt+R1S9Znl6YuEpLauBfxmf25dzFe4bVUw809f7eMzrzfb
	2YetKn9Xd6f2/4OpBZPrjXtX5mw6MnFFcLbv5IUmfFu/LJRViJwwf/qewl4OeYZW0fDNrct8
	u/4dm6kt7H3k3DslNp7EM84RxYd9Y/NM5Y5O5T1ee45/j5rtnR5b8T6mTyv1XnUHfp7272u4
	9VJPdrdLJqY2La17H116LqIUuCx6Y/h2J8Pyt6uNeba7/OD3cnp5+3Fe7qWCW4b1iRXxL6Xr
	Qo+KxuWxmObmrq2MUupn7Xp05sDXV9VPhSTubn2rGj0rZmJ6ppaA9AnzOdHHZY4la8lq+Is0
	xgvG3v3to6Fl3zJhsRJLcUaioRZzUXEiAFLscDAaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvG4np0+awYN/PBZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgd2D12zrrL7rFpVSebx6ZPk9g9Tsz4zeLRt2UV
	o8eZBUfYPT5vkgtgj+KySUnNySxLLdK3S+DK2Dj7N2vBfquKvr0bWRsYb+p1MXJySAiYSNx6
	vZ2ti5GLQ0hgN6PEvedXWCESMhJvzj9l6WLkALKFJQ4fLoao+cgoMXPjRzaQGjYBbYn3CyaB
	1YsIOElsuLKaBcRmFqiU+Hf7FlhcWMBXYnM7RJxFQFVi2cdpYDavgL1E26GFjBC75CVmXvrO
	DmJzCjhIzJ+yGMwWAqo5c+k8K0S9oMTJmU+g5stLNG+dzTyBUWAWktQsJKkFjEyrGCVTC4pz
	03OTDQsM81LL9YoTc4tL89L1kvNzNzGCA11LYwfjvfn/9A4xMnEwHmKU4GBWEuHdtMUzTYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC6YklqdmpqQWpRTBZJg5OqQYmfb3DTy/di7V6
	m6a1UGd7vcG8afulHjjKcyZZrFc2vGsZeYJv2oW8LlYdCanDNVmrTrObNtge/5R48PGXVlmh
	XjfZy54cUS4P55xfs+qgzbk25WPfqw5O+3kja7ZR1eWzEZMPse/Kr9t+pGmh0M+tk9W+fuHP
	idXY0SzSpLbG23FG7MyDh84FK1/Z4hzhoOLQV5Rr1rxE8egR64gf/NPZ8+SLmoUltzat9bz7
	YuU0G97bUa+nq2/P4Jd7t2Tp5sod8y8lCiVdOXZ69/YLS78t0vSsktedHKE2WW5i1s3816nb
	A+e7rIj+F7Jc1ql4yYf6r99vnuXY56d6o20L1xMRnrt6kWVhwkX3BXjVUnnPKLEUZyQaajEX
	FScCALkqXMfjAgAA
X-CMS-MailID: 20240521024009epcas1p20ddcabed3d037904a9c651d27f82c077
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p20ddcabed3d037904a9c651d27f82c077
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p20ddcabed3d037904a9c651d27f82c077@epcas1p2.samsung.com>

In addition to reserved-memory in device tree, an option in cmdline may
result in memblock allocation. This patch tries to distinguish memblock
changes done at early param.

A region in memsize will be created with name as the param string. And
the region size will be updated during the param function.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 include/linux/memblock.h |  4 ++
 init/main.c              | 13 +++++-
 mm/memblock.c            | 94 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 049313871059..aef02c150f2c 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -618,11 +618,15 @@ extern void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
 				    bool reusable);
 extern void memblock_memsize_detect_hole(void);
+extern void memblock_memsize_set_name(const char *name);
+extern void memblock_memsize_unset_name(void);
 #else
 static inline void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
 				    bool reusable) { }
 static inline void memblock_memsize_detect_hole(void) { }
+static inline void memblock_memsize_set_name(const char *name) { }
+static inline void memblock_memsize_unset_name(void) { }
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/init/main.c b/init/main.c
index 206acdde51f5..17c751aac854 100644
--- a/init/main.c
+++ b/init/main.c
@@ -212,8 +212,15 @@ static bool __init obsolete_checksetup(char *line)
 				pr_warn("Parameter %s is obsolete, ignored\n",
 					p->str);
 				return true;
-			} else if (p->setup_func(line + n))
-				return true;
+			} else {
+				int ret;
+
+				memblock_memsize_set_name(p->str);
+				ret = p->setup_func(line + n);
+				memblock_memsize_unset_name();
+				if (ret)
+					return true;
+			}
 		}
 		p++;
 	} while (p < __setup_end);
@@ -758,8 +765,10 @@ static int __init do_early_param(char *param, char *val,
 		    (strcmp(param, "console") == 0 &&
 		     strcmp(p->str, "earlycon") == 0)
 		) {
+			memblock_memsize_set_name(p->str);
 			if (p->setup_func(val) != 0)
 				pr_warn("Malformed early option '%s'\n", param);
+			memblock_memsize_unset_name();
 		}
 	}
 	/* We accept everything at this stage. */
diff --git a/mm/memblock.c b/mm/memblock.c
index 9b68ddc4af5e..edb2575967ab 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -178,6 +178,18 @@ static inline phys_addr_t memblock_cap_size(phys_addr_t base, phys_addr_t *size)
 	return *size = min(*size, PHYS_ADDR_MAX - base);
 }
 
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+static void memblock_memsize_record_add(struct memblock_type *type,
+			phys_addr_t base, phys_addr_t size);
+static void memblock_memsize_record_remove(struct memblock_type *type,
+			phys_addr_t base, phys_addr_t size);
+#else
+static inline void memblock_memsize_record_add(struct memblock_type *type,
+			phys_addr_t base, phys_addr_t size) { }
+static inline void memblock_memsize_record_remove(struct memblock_type *type,
+			phys_addr_t base, phys_addr_t size) { }
+#endif /* CONFIG_MEMBLOCK_MEMSIZE */
+
 /*
  * Address comparison utilities
  */
@@ -595,6 +607,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	phys_addr_t end = base + memblock_cap_size(base, &size);
 	int idx, nr_new, start_rgn = -1, end_rgn;
 	struct memblock_region *rgn;
+	phys_addr_t new_size = 0;
 
 	if (!size)
 		return 0;
@@ -607,7 +620,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		type->regions[0].flags = flags;
 		memblock_set_region_node(&type->regions[0], nid);
 		type->total_size = size;
-		return 0;
+		new_size = size;
+		goto done;
 	}
 
 	/*
@@ -654,6 +668,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 				memblock_insert_region(type, idx++, base,
 						       rbase - base, nid,
 						       flags);
+				new_size += rbase - base;
 			}
 		}
 		/* area below @rend is dealt with, forget about it */
@@ -669,6 +684,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 			end_rgn = idx + 1;
 			memblock_insert_region(type, idx, base, end - base,
 					       nid, flags);
+			new_size += end - base;
 		}
 	}
 
@@ -687,8 +703,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		goto repeat;
 	} else {
 		memblock_merge_regions(type, start_rgn, end_rgn);
-		return 0;
 	}
+done:
+	if (new_size == size)
+		memblock_memsize_record_add(type, obase, size);
+	return 0;
 }
 
 /**
@@ -858,6 +877,7 @@ static int __init_memblock memblock_remove_range(struct memblock_type *type,
 
 	for (i = end_rgn - 1; i >= start_rgn; i--)
 		memblock_remove_region(type, i);
+	memblock_memsize_record_remove(type, base, size);
 	return 0;
 }
 
@@ -2039,6 +2059,7 @@ struct memsize_rgn_struct {
 
 static struct memsize_rgn_struct memsize_rgn[CONFIG_MAX_MEMBLOCK_MEMSIZE] __initdata_memblock;
 static int memsize_rgn_count __initdata_memblock;
+static const char *memblock_memsize_name __initdata_memblock;
 
 static void __init_memblock memsize_get_valid_name(char *valid_name, const char *name)
 {
@@ -2237,6 +2258,75 @@ void __init memblock_memsize_detect_hole(void)
 		}
 	}
 }
+
+/* assume that freeing region is NOT bigger than the previous region */
+static void __init_memblock memblock_memsize_free(phys_addr_t free_base,
+						  phys_addr_t free_size)
+{
+	int i;
+	struct memsize_rgn_struct *rgn;
+	phys_addr_t free_end, end;
+
+	free_end = free_base + free_size - 1;
+	memblock_dbg("%s %pa..%pa\n",
+		     __func__, &free_base, &free_end);
+
+	for (i = 0; i < memsize_rgn_count; i++) {
+		rgn = &memsize_rgn[i];
+
+		end = rgn->base + rgn->size;
+		if (free_base < rgn->base ||
+		    free_base >= end)
+			continue;
+
+		free_end = free_base + free_size;
+		if (free_base == rgn->base) {
+			rgn->size -= free_size;
+			if (rgn->size != 0)
+				rgn->base += free_size;
+		} else if (free_end == end) {
+			rgn->size -= free_size;
+		} else {
+			memblock_memsize_record(rgn->name, free_end,
+				end - free_end, rgn->nomap, rgn->reusable);
+			rgn->size = free_base - rgn->base;
+		}
+	}
+}
+
+void __init memblock_memsize_set_name(const char *name)
+{
+	memblock_memsize_name = name;
+}
+
+void __init memblock_memsize_unset_name(void)
+{
+	memblock_memsize_name = NULL;
+}
+
+static void __init_memblock memblock_memsize_record_add(struct memblock_type *type,
+				phys_addr_t base, phys_addr_t size)
+{
+	if (memblock_memsize_name) {
+		if (type == &memblock.reserved)
+			memblock_memsize_record(memblock_memsize_name,
+						base, size, false, false);
+		else if (type == &memblock.memory)
+			memblock_memsize_free(base, size);
+	}
+}
+
+static void __init_memblock memblock_memsize_record_remove(struct memblock_type *type,
+				phys_addr_t base, phys_addr_t size)
+{
+	if (memblock_memsize_name) {
+		if (type == &memblock.reserved)
+			memblock_memsize_free(base, size);
+		else if (type == &memblock.memory)
+			memblock_memsize_record(memblock_memsize_name,
+						base, size, true, false);
+	}
+}
 #endif /* MEMBLOCK_MEMSIZE */
 
 static void __init free_memmap(unsigned long start_pfn, unsigned long end_pfn)
-- 
2.25.1


