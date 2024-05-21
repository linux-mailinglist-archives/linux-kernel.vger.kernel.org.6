Return-Path: <linux-kernel+bounces-184382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C25D8CA645
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0394C28106E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B450241C93;
	Tue, 21 May 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qCQFDudw"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39721C2AD
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259220; cv=none; b=riOAzgquKTWHgsZYp8r8MDXpywP5i/m/PjIlnTv3WvQ4ifNVdwrvopRJcF3YvWuMnSkHQac+7n8CXQKh3hlVgSxCN+Exvs5YVdN4W6WCKvkd6ykaHiKUR8gKUKc+e1aJWvMUqWWyGKBjHonMnoDFnf0//CbPV3aZJhTsXkgxohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259220; c=relaxed/simple;
	bh=ibZDDkqoE3b6dPcDt0RXYpO2L0g0Ja3RlyRNa23jMEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=FZvDPeF2wxqiX9yHvAvu7eSbFPa6+NrJekZyE+JYmlTKYWMDBjEZTyVRmwzfmqLw+Gmw5dvGMS0B7k9CwsgqNjguKt+PGvvQ5GfQ7nrW8ttousgBFAB0KqXuA6BfSHPgoRWS2tdD/xg3/yPoTSy8ImnPfflFOj5USaNhFUG/s10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qCQFDudw; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp04ce7250935fff03a8d3473691f1dade65~RYKi2eCoF1839318393epoutp04z
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240521024010epoutp04ce7250935fff03a8d3473691f1dade65~RYKi2eCoF1839318393epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=IzdCz5v5Q5xEqtPrJCRP7MpeWiihFzW0vfPNWZ8gj+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCQFDudwnYicldDAVbNAk4mpz+/2NOUsDw2QtTNmdMiW6DkQJpUZoHvEdXMJGjQ0M
	 gkzP8YxG5E9Urbdwu1v6JNImzuoyFrTr7F5ezVSZO9bDL+lufYcsRaAyNHKrZBPqCm
	 x+jDUaGnGZVrA/m0jUqzUcWXkCYmDvURZzOw6qZw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240521024010epcas1p4bd4b067f9fdf176020dc0e36398edee0~RYKiaScxj1520715207epcas1p4C;
	Tue, 21 May 2024 02:40:10 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.242]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VjzDn6G3Hz4x9Q2; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.40.09663.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p441a4c458d251eec7bb6e63e671c25b4e~RYKhroupz2938729387epcas1p4Z;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp10e6704301994088e82ffff0fff8d83bc~RYKhqvsNS2362723627epsmtrp1O;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
X-AuditID: b6c32a37-b863ba80000025bf-60-664c0989ee09
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	37.D3.19234.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epsmtip2b43a8fc85df3b4318a52e7f789e21f95~RYKhiIo8T1232612326epsmtip2J;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 09/10] memblock: print kernel internal size
Date: Tue, 21 May 2024 11:39:56 +0900
Message-Id: <20240521023957.2587005-10-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTX7eT0yfN4ModI4s569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
	ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fL
	Sy2xMjQwMDIFKkzIzpiy8BlzwRWtigs3lrE0MJ5U6mLk5JAQMJGYd7yXpYuRi0NIYAejxKeZ
	E6GcT4wSP2dOZgWpAnOmTfaE6Xi+awcTRHwno8TJ/UIQDZ8ZJSZuO8IIkmAT0JZ4v2ASWLOI
	gJ3Et9kHwGxmgVKJt29OMIPYwgJOErfnnWYHsVkEVCX+fPrJAmLzCjhI3Dzyhx1imbzEzEvf
	wWxOoPj8KYvZIWoEJU7OfMICMVNeonnrbGaQIyQEPrJLzFt0AWgZB5DjIjHjuDrEHGGJV8e3
	QM2UknjZ3wZl50tcuPiKCaK8RmLhREOIsL3Erq8zwKYwC2hKrN+lD7GJT+Ld1x6o4bwSHW1C
	ENVqEi3PvrJC2DISf/89gyrxkLg7gQUSUJMZJXZtjZvAKD8LyfmzkJw/C2HXAkbmVYxiqQXF
	uempxYYFxvAITc7P3cQITo9a5jsYp739oHeIkYmD8RCjBAezkgjvpi2eaUK8KYmVValF+fFF
	pTmpxYcYTYGBO5FZSjQ5H5ig80riDU0sDUzMjEwsjC2NzZTEec9cKUsVEkhPLEnNTk0tSC2C
	6WPi4JRqYEq++91KMyTkPVtygZ9TscWm2p1BIdslxZp32Ff8XeFiX5Kh1nyxYHvZwqpsq/On
	TNO3zyl2X/B/1WNv/eKOgqcHb+/7JdF19c6c56d1TNWD9287wZe8587pm0W6G8zjUpdtcduh
	LDAv8i5ryyTuzStrO62fX14bd2y3BwfzO5eo1XWqJtuTV3TdP9hccNOpzPmbcNo5sVATpu+H
	lNfH/e27ofm7Yx67Gqvzl+jLQu33zhvPYOH4v2+J6HOXlRwlaU7PrlfPPH4yfCmf/oc8Db3P
	z3rC+pNuxtaw7g0MtGQtXSo/9fsKo5zrF16cM1iQ5mdz3t/sQ+yjlP93jK5K7UnYerJmrjtf
	3nWDzGtTRZRYijMSDbWYi4oTATC/RngYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvG4np0+awa01khZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgd2D12zrrL7rFpVSebx6ZPk9g9Tsz4zeLRt2UV
	o8eZBUfYPT5vkgtgj+KySUnNySxLLdK3S+DKmLLwGXPBFa2KCzeWsTQwnlTqYuTkkBAwkXi+
	awcTiC0ksJ1RYvXrOoi4jMSb809Zuhg5gGxhicOHi7sYuYBKPjJKrLjawghSwyagLfF+wSRW
	EFtEwEliw5XVLCA2s0ClxL/bt8DiwkDx2/NOs4PYLAKqEn8+/QSr4RVwkLh55A87xC55iZmX
	voPZnEDx+VMWs0PcYy9x5tJ5Voh6QYmTM59AzZeXaN46m3kCo8AsJKlZSFILGJlWMYqmFhTn
	pucmFxjqFSfmFpfmpesl5+duYgSHt1bQDsZl6//qHWJk4mA8xCjBwawkwrtpi2eaEG9KYmVV
	alF+fFFpTmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA5Pv092/Xk/cvn7Zn+bg
	P71aLltsDu7eu/XP6hNpRqKfPnUuzHt1YO6OeMW2ZUYbIl+e3bh/VgOj0MTrZpdst617EPHv
	0n3j2haLps/XzNueGq21318bwdNmeP1TQ6WB0fpvVWIn98Xb/FczsIkxvdcVYV7+ftXHqpAw
	hr+/zI6/O/9NYmt4h+uv5ncy1z5VPpKPLFu9UffoFBfuRzx8l65LFEYLsk17LWN+fdGv2yUM
	936cmrHpSOzdOM9HDTd4DrXc+TnX9IzJJsZfWruepERm3bY79/hPGGv9Wbk8w+StPUxlG55O
	feH7u7616a9PjOiEtLi9bVqV5XMv8vieUvse5nu+qCuJz7R1vXNB2ZaZSizFGYmGWsxFxYkA
	4WIq4t4CAAA=
X-CMS-MailID: 20240521024009epcas1p441a4c458d251eec7bb6e63e671c25b4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p441a4c458d251eec7bb6e63e671c25b4e
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p441a4c458d251eec7bb6e63e671c25b4e@epcas1p4.samsung.com>

Kernel internal size information is also useful to compare with other
binary. This patch print kernel text, rwdata, rodata, bss, and others.

Here's an example.

Reserved    : 1181708 KB
 .kernel    :  296172 KB
  .text     :   16960 KB
  .rwdata   :    2299 KB
  .rodata   :   16464 KB
  .bss      :    7549 KB
  .memmap   :  196608 KB
  .etc      :   56293 KB
 .unusable  :  885536 KB

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 include/linux/memblock.h |  6 ++++++
 mm/memblock.c            | 36 ++++++++++++++++++++++++++++++++++++
 mm/mm_init.c             |  6 +++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index a83ad98ac252..7ab8b59bfbc1 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -623,6 +623,9 @@ extern void memblock_memsize_unset_name(void);
 extern void memblock_memsize_enable_tracking(void);
 extern void memblock_memsize_disable_tracking(void);
 extern void memblock_memsize_mod_kernel_size(long size);
+extern void memblock_memsize_mod_memmap_size(long size);
+extern void memblock_memsize_kernel_code_data(unsigned long code,
+		unsigned long data, unsigned long ro, unsigned long bss);
 #else
 static inline void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
@@ -633,6 +636,9 @@ static inline void memblock_memsize_unset_name(void) { }
 static inline void memblock_memsize_enable_tracking(void){ }
 static inline void memblock_memsize_disable_tracking(void){ }
 static inline void memblock_memsize_mod_kernel_size(long size) { }
+static inline void memblock_memsize_mod_memmap_size(long size) { }
+static inline void memblock_memsize_kernel_code_data(unsigned long code,
+		unsigned long data, unsigned long ro, unsigned long bss) { }
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index 0906d81f66c2..2fe0dc2575c5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2061,6 +2061,11 @@ static struct memsize_rgn_struct memsize_rgn[CONFIG_MAX_MEMBLOCK_MEMSIZE] __init
 static int memsize_rgn_count __initdata_memblock;
 static const char *memblock_memsize_name __initdata_memblock;
 static long memsize_kinit __initdata_memblock;
+static long memsize_memap __initdata_memblock;
+static unsigned long memsize_code __initdata_memblock;
+static unsigned long memsize_data __initdata_memblock;
+static unsigned long memsize_ro __initdata_memblock;
+static unsigned long memsize_bss __initdata_memblock;
 static bool memblock_memsize_tracking __initdata_memblock = true;
 
 void __init memblock_memsize_enable_tracking(void)
@@ -2073,11 +2078,25 @@ void __init memblock_memsize_disable_tracking(void)
 	memblock_memsize_tracking = false;
 }
 
+void __init memblock_memsize_mod_memmap_size(long size)
+{
+	memsize_memap += size;
+}
+
 void memblock_memsize_mod_kernel_size(long size)
 {
 	memsize_kinit += size;
 }
 
+void __init memblock_memsize_kernel_code_data(unsigned long code, unsigned long data,
+		unsigned long ro, unsigned long bss)
+{
+	memsize_code = code;
+	memsize_data = data;
+	memsize_ro = ro;
+	memsize_bss = bss;
+}
+
 static void __init_memblock memsize_get_valid_name(char *valid_name, const char *name)
 {
 	char *head, *tail, *found;
@@ -2691,6 +2710,11 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 	struct memsize_rgn_struct *rgn;
 	unsigned long reserved = 0, reusable = 0, total;
 	unsigned long system = totalram_pages() << PAGE_SHIFT;
+	unsigned long etc;
+
+	etc = memsize_kinit;
+	etc -= memsize_code + memsize_data + memsize_ro + memsize_bss +
+		memsize_memap;
 
 	sort(memsize_rgn, memsize_rgn_count,
 	     sizeof(memsize_rgn[0]), memsize_rgn_cmp, NULL);
@@ -2723,6 +2747,18 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 		   DIV_ROUND_UP(memsize_kinit + reserved, SZ_1K));
 	seq_printf(m, " .kernel    : %7lu KB\n",
 		   DIV_ROUND_UP(memsize_kinit, SZ_1K));
+	seq_printf(m, "  .text     : %7lu KB\n"
+		      "  .rwdata   : %7lu KB\n"
+		      "  .rodata   : %7lu KB\n"
+		      "  .bss      : %7lu KB\n"
+		      "  .memmap   : %7lu KB\n"
+		      "  .etc      : %7lu KB\n",
+			DIV_ROUND_UP(memsize_code, SZ_1K),
+			DIV_ROUND_UP(memsize_data, SZ_1K),
+			DIV_ROUND_UP(memsize_ro, SZ_1K),
+			DIV_ROUND_UP(memsize_bss, SZ_1K),
+			DIV_ROUND_UP(memsize_memap, SZ_1K),
+			DIV_ROUND_UP(etc, SZ_1K));
 	seq_printf(m, " .unusable  : %7lu KB\n",
 		   DIV_ROUND_UP(reserved, SZ_1K));
 	seq_printf(m, "System      : %7lu KB\n",
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f72b852bd5b8..45187904db49 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1587,8 +1587,10 @@ void __init *memmap_alloc(phys_addr_t size, phys_addr_t align,
 						 MEMBLOCK_ALLOC_ACCESSIBLE,
 						 nid);
 
-	if (ptr && size > 0)
+	if (ptr && size > 0) {
 		page_init_poison(ptr, size);
+		memblock_memsize_mod_memmap_size((long)size);
+	}
 
 	return ptr;
 }
@@ -2679,6 +2681,8 @@ static void __init mem_init_print_info(void)
 	init_data_size = __init_end - __init_begin;
 	init_code_size = _einittext - _sinittext;
 
+	memblock_memsize_kernel_code_data(codesize, datasize, rosize, bss_size);
+
 	/*
 	 * Detect special cases and adjust section sizes accordingly:
 	 * 1) .init.* may be embedded into .data sections
-- 
2.25.1


