Return-Path: <linux-kernel+bounces-184384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E488CA646
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F71F22223
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BBF42071;
	Tue, 21 May 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bP52x+/A"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499481BF31
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259222; cv=none; b=smC3yJhlpM/c30yUh4ryvecduRwsZ/vkLY3kObhjTmSQas8tZUna7PD+//eUbrT0rnrXOgkf2QjYkRjXtd//XHKb3KzxDTdoVG/Kbx+1cB31VkuPJUWfE5pGyc6sp0sN7rwQmpjHAN0G9tyRTCOtfRmkW4P7e7zO31UFQv00EuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259222; c=relaxed/simple;
	bh=GxZiu9W2BHAsmvfw5Uzy8jR4QCk3bK6pa0zHWCgGO9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=I+/XQpNI3Ubls0c7hxRBswnqo2s5P1HPUmZ9YUAnxY+jHFuR+XHBfiPQGY1Q39U+202+UoZZa2vzgMLD00iviFTp7zobOWvCuu36UsQGRtxwcb2y17+aKPAMtTzWy7Itq2S80qLOJJSOSiKXFjwQQQpGYF2xAEh8nwIqV5ubF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bP52x+/A; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp032e0f783e794c226ae3ebea83818a34d2~RYKi3z_QS0914709147epoutp03H
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240521024010epoutp032e0f783e794c226ae3ebea83818a34d2~RYKi3z_QS0914709147epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=yVf68Cj1nmtMbTxmkx6CIgy96BRosJN2TQP/FPuQu/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bP52x+/ApNVHBIzFM/4oYwo//UvPFD67XoOXBDj31FTLgcP111sQ/RlcWu9Fkgyam
	 W9WMEnnmdph6iZBCEI0t1tEnA6mabO7o9BBdeeLew/1v/dSIjx07amZdjIlN/FXUQv
	 ZbFtnW6NTHxOJtXyygLGARqqE3L9NVbhm6hM/BKM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240521024010epcas1p495284369abe490f8d94fdd6adcef2e70~RYKiZSNF71520715207epcas1p4A;
	Tue, 21 May 2024 02:40:10 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.240]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VjzDn6DFBz4x9Q7; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B1.13.09696.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p15a3290b675ee66339033c185a5a8c00b~RYKhv5DeV2349123491epcas1p1d;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp29f58dea47f5a6d9d50601a9ccaf99022~RYKhvKn8k2496224962epsmtrp2m;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
X-AuditID: b6c32a36-7a9f9700000025e0-4b-664c09895e29
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.54.08390.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epsmtip29f70c066144ebfba9efa858ec7c443e2~RYKhlFy_t1233912339epsmtip2F;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 10/10] memblock: support memsize reusable to consider
 as reusable
Date: Tue, 21 May 2024 11:39:57 +0900
Message-Id: <20240521023957.2587005-11-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTT7eT0yfN4OR9PYs569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
	ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fL
	Sy2xMjQwMDIFKkzIzvi0YCZ7QZdURc/uC2wNjG9Euxg5OSQETCSmL5/N0sXIxSEksINRYtrt
	24wQzidGiSOn5rJBON8YJQ7un88O03LxWTMrRGIvUGLlNqiqz4wSB6Y+B6tiE9CWeL9gEiuI
	LSJgJ/Ft9gEwm1mgVOLtmxPMXYwcHMICURKn95uAhFkEVCXeXD7CCGLzCjhIdH+5wAaxTF5i
	5qXvYCM5geLzpyxmh6gRlDg58wkLxEh5ieats5lBbpAQ+MkusfrYRUaIZheJS2+7oa4Wlnh1
	fAuULSXx+d1eqAX5EhcuvmICuUdCoEZi4URDiLC9xK6vM1hBwswCmhLrd+lDrOKTePe1hxWi
	mleio00IolpNouXZV1YIW0bi779nUCUeElNXJ0ECZzKjxPxJv5knMMrPQvLALCQPzEJYtoCR
	eRWjWGpBcW56arFhgRE8TpPzczcxgpOkltkOxklvP+gdYmTiYDzEKMHBrCTCu2mLZ5oQb0pi
	ZVVqUX58UWlOavEhRlNg8E5klhJNzgem6bySeEMTSwMTMyMTC2NLYzMlcd4zV8pShQTSE0tS
	s1NTC1KLYPqYODilGpiyXid0FS/8yMKXGpXhGrjzy5WMqfI+xne2Jfg8WCJ0+bNMx7JJNzQ0
	L7Fa7rn2aIHJpPQtSpceqPMvyzyuHdW4LSvCzUphgfHZj5uefrpiYrfw9l8Z54PRr5WUFooE
	LXJ+90jg9t207VIJLXb2zmL3k6vzLpVe2jSrc2W+hPJF5RSHRuM0Tt/P1V4lrtqP8htuH763
	Tc0/fp2jMvuztSGbFrReE5I3PpE9RaDFfS0Tn1/BlJR/b35dve94W1LkZsJFhYff69mvKDe2
	L2X1Xfyh97T7VMP/f/h2PPy0OqCdb9+E/gf9rnXMIdyh3g9Cd+1M/VJWz/002WXSNAEzk1DR
	49a74qV3ic+N8fMymqvEUpyRaKjFXFScCAAQPK3jGwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvG4np0+awaWPMhZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgd2D12zrrL7rFpVSebx6ZPk9g9Tsz4zeLRt2UV
	o8eZBUfYPT5vkgtgj+KySUnNySxLLdK3S+DK+LRgJntBl1RFz+4LbA2Mb0S7GDk5JARMJC4+
	a2btYuTiEBLYzSgx/fJ7ZoiEjMSb809Zuhg5gGxhicOHiyFqPjJKLH74AqyGTUBb4v2CSawg
	toiAk8SGK6tZQGxmgUqJf7dvsYL0CgtESGz9kAMSZhFQlXhz+QgjiM0r4CDR/eUCG8QqeYmZ
	l76zg9icQPH5UxaD2UIC9hJnLp1nhagXlDg58wnUeHmJ5q2zmScwCsxCkpqFJLWAkWkVo2Rq
	QXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwmGtp7WDcs+qD3iFGJg7GQ4wSHMxKIrybtnim
	CfGmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1CCbLxMEp1cC068Zstxnt
	/dPPHGq8XygSeP7PjQN/898d+JK5y/6v1Kk2Dqk7Ofs2vmz6VhW5eCuHhXaNnUne7K6eso2V
	0xudXj7cUb5vbdqkWZKbH6mLL74kMHPTScH9h/98yVih2ibEJh33dSVfxjLxhJ8yd95oNn1h
	jXG51v/4v+gn2Vn1E26eipm0sofLYNHSxV8f5BTLOVvPe7Ox9M7EhMgHxQtcbrYx7kpzndD5
	zOlbEpP45Jc8MYFq0+o3rmNK6zP2Kti5ckdV6z4d0cfF7sYR22zXZQiw5Uw4VHTkodwi8W3J
	p17IGvi1bfz84qZTcVRL2t8pHZO/C6RduL/9VN7tj9w/5EpKHhbXXLj2YIKMw+KZhUosxRmJ
	hlrMRcWJAAbDn7PiAgAA
X-CMS-MailID: 20240521024009epcas1p15a3290b675ee66339033c185a5a8c00b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p15a3290b675ee66339033c185a5a8c00b
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p15a3290b675ee66339033c185a5a8c00b@epcas1p1.samsung.com>

Sometimes we'd like to include some memory region as reusable even
though it is actually not CMA type. In that case, add reusable in its
device tree description, then memsize will consider it is reusuable and
add its size to the system total memory size.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/of/of_reserved_mem.c | 3 +++
 include/linux/memblock.h     | 2 ++
 mm/memblock.c                | 7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index ece678e07304..7aedac213995 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -468,6 +468,9 @@ void __init fdt_init_reserved_mem(void)
 				memblock_memsize_record(rmem->name, rmem->base,
 							rmem->size, nomap,
 							reusable);
+				if (reusable &&
+				    !of_flat_dt_is_compatible(node, "shared-dma-pool"))
+					memblock_memsize_mod_reusable_size(rmem->size);
 			}
 		}
 	}
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 7ab8b59bfbc1..0aa6202a7a6a 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -626,6 +626,7 @@ extern void memblock_memsize_mod_kernel_size(long size);
 extern void memblock_memsize_mod_memmap_size(long size);
 extern void memblock_memsize_kernel_code_data(unsigned long code,
 		unsigned long data, unsigned long ro, unsigned long bss);
+extern void memblock_memsize_mod_reusable_size(long size);
 #else
 static inline void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
@@ -639,6 +640,7 @@ static inline void memblock_memsize_mod_kernel_size(long size) { }
 static inline void memblock_memsize_mod_memmap_size(long size) { }
 static inline void memblock_memsize_kernel_code_data(unsigned long code,
 		unsigned long data, unsigned long ro, unsigned long bss) { }
+static inline void memblock_memsize_mod_reusable_size(long size) { }
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index 2fe0dc2575c5..a20d60d3bb40 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2066,6 +2066,7 @@ static unsigned long memsize_code __initdata_memblock;
 static unsigned long memsize_data __initdata_memblock;
 static unsigned long memsize_ro __initdata_memblock;
 static unsigned long memsize_bss __initdata_memblock;
+static long memsize_reusable_size __initdata_memblock;
 static bool memblock_memsize_tracking __initdata_memblock = true;
 
 void __init memblock_memsize_enable_tracking(void)
@@ -2117,6 +2118,11 @@ static void __init_memblock memsize_get_valid_name(char *valid_name, const char
 	valid_name[val_size] = '\0';
 }
 
+void memblock_memsize_mod_reusable_size(long size)
+{
+	memsize_reusable_size += size;
+}
+
 static inline struct memsize_rgn_struct * __init_memblock memsize_get_new_rgn(void)
 {
 	if (memsize_rgn_count == ARRAY_SIZE(memsize_rgn)) {
@@ -2716,6 +2722,7 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 	etc -= memsize_code + memsize_data + memsize_ro + memsize_bss +
 		memsize_memap;
 
+	system += memsize_reusable_size;
 	sort(memsize_rgn, memsize_rgn_count,
 	     sizeof(memsize_rgn[0]), memsize_rgn_cmp, NULL);
 	for (i = 0; i < memsize_rgn_count; i++) {
-- 
2.25.1


