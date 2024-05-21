Return-Path: <linux-kernel+bounces-184378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E08CA642
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABFC1C20FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D91CD1B;
	Tue, 21 May 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GmWAPwUP"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858C1804E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259219; cv=none; b=jp4KNRxAzEq5axbqXXOlGJbLsMeVQw6zTnbA3FPZoQlhE0xPeRmqU7UzHwDq9zK4CYosWPtZWDel91SyS4mWEspgAGdzFikrFJq+vdq4zqo4hzW7ZLh7x2DV58JwqBjPiQU+R2Q5MrmzluKgkd9Gg6HjwK6GI6G6kdNKcavCV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259219; c=relaxed/simple;
	bh=J9ZU6uAMAQr4GiB6kIVgJAYCWN7pEacD/537CsbUQZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=nDOX+GwG9zS770JPp8T7N+YOIA7KPy1L/G2TJg6oEnH5zggLutqWxUt/Fl/JFs7NDnSby2WstA4Uj+iRZRUim6Ll0OzTd34jj//qchtxZWm+9l3wmhYgZ3KXGL7ANyu1zxopXk+yQlHH2x0a7FU0UXe1QoCtumJZvjm3YJX54/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GmWAPwUP; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp03c01d9fc5ea1d9b04d74cf2e0b0184f15~RYKiXMgTg0915109151epoutp03K
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240521024010epoutp03c01d9fc5ea1d9b04d74cf2e0b0184f15~RYKiXMgTg0915109151epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=nc9ytWVtzu00a7dgwLwPEFskmN2vz5dkqC+Zm4IulfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GmWAPwUPJUumyIommwOd368ltzs6tEpcbknX9PM8XQAOHVWnJkt6n3/awC1sZxKBa
	 uGIaHt3eL9jlpIWjc6TSETkoLd7hclQ6Dg8YZGcjFIon6PKX0EQE4AFBJAVEKG5jiw
	 ULJWvMF7TcBLXhF/SoCUZfbXqqCmXcehj5Ly0Mgk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epcas1p4ae0afa00bd066e0581c51603cd14c1c5~RYKiDy1mA1450914509epcas1p4D;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.250]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VjzDn3Btwz4x9Q0; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BE.4F.09662.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p152671a613e86fa83d840962ee3db50fb~RYKhZLuN42349123491epcas1p1a;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp2ab32c1df17e1b63fac42592843b39454~RYKhYk-MV2496124961epsmtrp2p;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
X-AuditID: b6c32a35-2b3fa700000025be-a8-664c0989734b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.D3.19234.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epsmtip23fed4a67c5d9cdc27984091a265bcdeb~RYKhPg7O11233912339epsmtip2C;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 03/10] memblock: handle overlapped reserved memory
 region
Date: Tue, 21 May 2024 11:39:50 +0900
Message-Id: <20240521023957.2587005-4-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTV7eT0yfN4HmvhMWc9WvYLLo3z2S0
	6H3/isni8q45bBb31vxntTiyfjuTxezGPkYHdo+ds+6ye2xa1cnmsenTJHaPEzN+s3j0bVnF
	6HFmwRF2j8+b5ALYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
	XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBXoFSfmFpfmpevl
	pZZYGRoYGJkCFSZkZzyY84WpoFeh4sW2sAbG55JdjJwcEgImEjN3HGHtYuTiEBLYwSjx4sl/
	NgjnE6PEo+NtCM7rMysZYVomNd9lB7GFBHYyStx+zd3FyAFkf2aUWGoMEmYT0JZ4v2ASK4gt
	ImAn8W32ATCbWaBU4u2bE8wg5cICQRKH9oBNYRFQlfi+8T4TiM0rYC9xtfcuG8QmeYmZl76D
	1XAKOEjMn7KYHaJGUOLkzCcsECPlJZq3zmaGqP/ILrF9nhTIeAkBF4l1280hwsISr45vYYew
	pSQ+v9sLNT5f4sLFV0wQ5TUSCycaQoTtJXZ9ncEKEmYW0JRYv0sfYhGfxLuvPawQ1bwSHW1C
	ENVqEi3PvrJC2DISf/89g7I9JI509TJDgm8yo8THdd1sExjlZyG5fxaS+2chbFvAyLyKUSy1
	oDg3PbXYsMAQHp3J+bmbGMGpUct0B+PEtx/0DjEycTAeYpTgYFYS4d20xTNNiDclsbIqtSg/
	vqg0J7X4EKMpMHQnMkuJJucDk3NeSbyhiaWBiZmRiYWxpbGZkjjvmStlqUIC6YklqdmpqQWp
	RTB9TBycUg1Me7Xq5DwTk8V/OltsnSazcOu8qcn87N8eLtxSLswt6RPhu/BnfKXuFdcmv1sL
	5Hh9d81PlupoCF41YbngBddVmtsfqbzNUpm7fKL/gqPcoqXqDX+Nn11YJ2T8sup9xqOS18cm
	nE200xRyMjHbkJVa6x6ecvbGsQ+p/3RKM/bVNjw/cKYn/cQpE06rF8G92xbkrND9kJ3i8P/r
	dx4OX47wO7NmltpUTXzmbBZYr1WkdVrqZXnHdsnoha4HZn/dumn+CsXMn4lvRD8unHt3/UbW
	b/pzqxdtXHMgWqr/yqmgC+Hhd5UMVf69uSjjqDSNi//5/ZNfLm9cOm+f0ueYcrODTUtOP3y7
	4p71x03tqvN63yixFGckGmoxFxUnAgAmduORFgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvG4np0+aweSpbBZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgd2D12zrrL7rFpVSebx6ZPk9g9Tsz4zeLRt2UV
	o8eZBUfYPT5vkgtgj+KySUnNySxLLdK3S+DKeDDnC1NBr0LFi21hDYzPJbsYOTkkBEwkJjXf
	Ze9i5OIQEtjOKDFh8Xc2iISMxJvzT1m6GDmAbGGJw4eLIWo+MkoseXGcBaSGTUBb4v2CSawg
	toiAk8SGK6vB4swClRL/bt8CiwsLBEiceXaMEcRmEVCV+L7xPhOIzStgL3G19y7ULnmJmZe+
	s4PYnAIOEvOnLAazhYBqzlw6zwpRLyhxcuYTqPnyEs1bZzNPYBSYhSQ1C0lqASPTKkbR1ILi
	3PTc5AJDveLE3OLSvHS95PzcTYzg8NYK2sG4bP1fvUOMTByMhxglOJiVRHg3bfFME+JNSays
	Si3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamAKePXBZLr5XaOJP65O
	DdVXCF/E0SCz/NK9Jf4Oxxmu3p5cJvUy6C2n4+G8qnlXWttbJm3cGsUsUVaTYbDwqZ5Q+qSc
	OSLzWOqi5PPyivt+e9op3dyn9Fi/ek/z19cmVtM+ZK5pX83Gruev3mArt9yp9lFq+PzXzwyL
	TxnfXfpWTe7t5ofFdue/n5zxyOftyuK6NzyTXU+sd0p6tnt1qcrnBXOFlnBHHznIvGKxnrq9
	Hpf4lb6nKaZfSyLFppVN+X09nlc9YcbBp43HXG9u0og2DGbleNDHZZ9/90vtGc9/OXZ2bLXq
	zE38G5n3cakrc4lEblo549YGl99KewJ/um/sZz2lecen5qaT+LWVNvFKLMUZiYZazEXFiQA4
	nBKK3gIAAA==
X-CMS-MailID: 20240521024009epcas1p152671a613e86fa83d840962ee3db50fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p152671a613e86fa83d840962ee3db50fb
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p152671a613e86fa83d840962ee3db50fb@epcas1p1.samsung.com>

It is not common, but defining an overlapped region is possible.
Actually memblock_add_range allows to overlap with existing ones.

The memsize currently does not handle this overlapped case. But this
patch tries to handle one overlapped case.

Here's the case.

There is an unknown memsize region, which means the region was removed
and not passed at bootloader stage. And there is a reserved memory
region defined in device tree which is overlapped with the unknown
region.

We expect that information in device tree make the unknown region clear.
This patch handle the overlapped region with following conditions.

1) The already existing overlapped region should be unknown and no-map.
2) The newly added region should have a name, and its region should be
same with or part of the existing one.

Here is an example.

Before this patch, memsize shows both overlapped region.

0x0ea000000-0x0ed900000 0x03900000 (   58368 KB ) nomap unusable overlapped
0x0ea000000-0x0f1400000 0x07400000 (  118784 KB ) nomap unusable unknown

After this patch, the overlapped region is named.

0x0ea000000-0x0ed900000 0x03900000 (   58368 KB ) nomap unusable overlapped
0x0e9b00000-0x0ea000000 0x00500000 (    5120 KB ) nomap unusable unknown

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/memblock.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5204ee71ae29..4a0506e14025 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2060,6 +2060,73 @@ static void __init_memblock memsize_get_valid_name(char *valid_name, const char
 	valid_name[val_size] = '\0';
 }
 
+static inline struct memsize_rgn_struct * __init_memblock memsize_get_new_rgn(void)
+{
+	if (memsize_rgn_count == ARRAY_SIZE(memsize_rgn)) {
+		pr_err("not enough space on memsize_rgn\n");
+		return NULL;
+	}
+	return &memsize_rgn[memsize_rgn_count++];
+}
+
+static bool __init_memblock memsize_update_nomap_region(const char *name, phys_addr_t base,
+					phys_addr_t size, bool nomap)
+{
+	int i;
+	struct memsize_rgn_struct *rmem_rgn, *new_rgn;
+
+	if (!name)
+		return false;
+
+	for (i = 0; i < memsize_rgn_count; i++)	{
+		rmem_rgn = &memsize_rgn[i];
+
+		if (!rmem_rgn->nomap)
+			continue;
+		if (strcmp(rmem_rgn->name, "unknown"))
+			continue;
+		if (base < rmem_rgn->base)
+			continue;
+		if (base + size > rmem_rgn->base + rmem_rgn->size)
+			continue;
+
+		if (base == rmem_rgn->base && size == rmem_rgn->size) {
+			memsize_get_valid_name(rmem_rgn->name, name);
+			return true;
+		}
+
+		new_rgn = memsize_get_new_rgn();
+		if (!new_rgn)
+			return true;
+		new_rgn->base = base;
+		new_rgn->size = size;
+		new_rgn->nomap = nomap;
+		new_rgn->reusable = false;
+		memsize_get_valid_name(new_rgn->name, name);
+
+		if (base == rmem_rgn->base && size < rmem_rgn->size) {
+			rmem_rgn->base = base + size;
+			rmem_rgn->size -= size;
+		} else if (base + size == rmem_rgn->base + rmem_rgn->size) {
+			rmem_rgn->size -= size;
+		} else {
+			new_rgn = memsize_get_new_rgn();
+			if (!new_rgn)
+				return true;
+			new_rgn->base = base + size;
+			new_rgn->size = (rmem_rgn->base + rmem_rgn->size)
+					- (base + size);
+			new_rgn->nomap = nomap;
+			new_rgn->reusable = false;
+			strscpy(new_rgn->name, "unknown", sizeof(new_rgn->name));
+			rmem_rgn->size = base - rmem_rgn->base;
+		}
+		return true;
+	}
+
+	return false;
+}
+
 void __init_memblock memblock_memsize_record(const char *name, phys_addr_t base,
 			     phys_addr_t size, bool nomap, bool reusable)
 {
@@ -2070,7 +2137,14 @@ void __init_memblock memblock_memsize_record(const char *name, phys_addr_t base,
 		pr_err("not enough space on memsize_rgn\n");
 		return;
 	}
-	rgn = &memsize_rgn[memsize_rgn_count++];
+
+	if (memsize_update_nomap_region(name, base, size, nomap))
+		return;
+
+	rgn = memsize_get_new_rgn();
+	if (!rgn)
+		return;
+
 	rgn->base = base;
 	rgn->size = size;
 	rgn->nomap = nomap;
-- 
2.25.1


