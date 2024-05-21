Return-Path: <linux-kernel+bounces-184379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C348CA643
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB3FB220EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF6A208DA;
	Tue, 21 May 2024 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AIUR1WPc"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468CF1BC46
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259220; cv=none; b=SeTcukgX1ddiUqnFwJntj80tJ+isY9ulQxTBCCtHo8Al68t/yeJALGAutQmO/xIy7Lnqv9VK4Ud1svMtAeQX8qvTyd/ptZBbAFYLRaFcG99FHnve2gSTtteESLsTVtZMXCKDglaAGYHfh65eFwT3EaIykzYDU1oC3iPZEpEbazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259220; c=relaxed/simple;
	bh=0y7TU7zTgAwawU3slZDhFZl+/pWY3tjCyYCRVxmknWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=nIrQHR784Btfh7EMp8kCt18iQEDpw9cmcJ17iQztrM7KhLsLCwI/v7L21W1SLFbBHC2XYBUfyuhlcScNvlr2k+skmYut5MPebAcoh/82pbopLHIdj2n6iCI3XN3ki9y/c27M6X1GMYi0dfYw7msHIX7FAA2PJf375i4LRezJbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AIUR1WPc; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp01f53078ed7f15ce9b29ec93240571d226~RYKips9Bs1192611926epoutp01s
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240521024010epoutp01f53078ed7f15ce9b29ec93240571d226~RYKips9Bs1192611926epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=3CfHcPoy4LZXqF1JfuCe7exgO9FOdW12+9aW417X+QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIUR1WPc/vUs4bOffPOm5oSZU1OsaPGBqgVt0bmib7J75/fHxavdA4WMIfdmNzeDu
	 p6B03zN9aWEcmwz1BcfFcG16UOfTtY6IHwFvCh94Vl2AIn84zcE36rL4dUWuRvQlIO
	 QDzQrOEQlaRYgKxq/oo1wTISnF7WUCavpNnZtCts=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epcas1p35a6821f1ae02a131f8d71e39773e8fd3~RYKiAz8Bn0314503145epcas1p3d;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.242]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VjzDn39p7z4x9QB; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.4F.09662.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p3e80e90863a453053d5aac901ef644070~RYKhVkSAh0309203092epcas1p3t;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp276a000fb3675b0aa18a6053708976075~RYKhU_TN-2496124961epsmtrp2o;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
X-AuditID: b6c32a35-053ff700000025be-a7-664c09892ffc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.D3.19234.8890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024008epsmtip279bc42a8e8f3048a6ffbd81990fd292b~RYKhMbR9s1233912339epsmtip2B;
	Tue, 21 May 2024 02:40:08 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 02/10] memblock: detect hidden memory hole size
Date: Tue, 21 May 2024 11:39:49 +0900
Message-Id: <20240521023957.2587005-3-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTX7eT0yfN4PMccYs569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
	ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fL
	Sy2xMjQwMDIFKkzIzph37hZTwV7Zin8vt7A2MJ4X72Lk4JAQMJFovOfexcjFISSwg1Fi28y5
	zBDOJ0aJvtd3mOCci3PWMHYxcoJ19G88xAaR2MkoMftoM5TzmVHi+eszYFVsAtoS7xdMYgWx
	RQTsJL7NPgBmMwuUSrx9c4IZxBYWcJO492sumM0ioCpx9PRisBpeAXuJ5zsWsEBsk5eYeek7
	O4jNKeAgMX/KYnaIGkGJkzOfsEDMlJdo3job7G4JgY/sErvm9bFBNLtIzNqyggnCFpZ4dXwL
	O4QtJfH53V6omnyJCxdfMUECo0Zi4URDiLC9xK6vM1hBwswCmhLrd+lDrOKTePe1hxWimlei
	o00IolpNouXZV1YIW0bi779nULaHxKdTR1ghwTOZUaKn6z/jBEb5WUg+mIXkg1kI2xYwMq9i
	FEstKM5NTy02LDCER2pyfu4mRnCa1DLdwTjx7Qe9Q4xMHIyHGCU4mJVEeDdt8UwT4k1JrKxK
	LcqPLyrNSS0+xGgKDN+JzFKiyfnARJ1XEm9oYmlgYmZkYmFsaWymJM575kpZqpBAemJJanZq
	akFqEUwfEwenVAPTeactofcaL6eUWc95v2dCS8zJw19jrJcsuGlx48HlG/vsT2hxPdJtucOc
	Y8rbNe8Lw8nqMPNV7ee2WnzffeOvQOlbsdz+pYWpH/3WVc9x9mD851y9c075e7b3G+Qjcrw9
	72ZPWcT/7khHrNiKhu2VZnaKnxm60+9VzM9Q6trKEZ8TP4V5vlfvOevFMkyv8/IVI65OedS6
	7AuvdHrcySfVrII6W1i9dLM6VjjsmFbwXmKO2o6e/sSkwBOffTwidihPiDnez//w462jstn2
	djax5zm0ffqYbzXd+KKj66+h6zbrwX0+F7eLp6T+v5EvXx64ZNrf6d+iud02axhs3hQSO5vn
	xuv41JpOA9e93MlKLMUZiYZazEXFiQCTNZcPHAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvG4np0+awb1pzBZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgd2D12zrrL7rFpVSebx6ZPk9g9Tsz4zeLRt2UV
	o8eZBUfYPT5vkgtgj+KySUnNySxLLdK3S+DKmHfuFlPBXtmKfy+3sDYwnhfvYuTkkBAwkejf
	eIiti5GLQ0hgO6PEvR+PmSASMhJvzj9l6WLkALKFJQ4fLoao+cgoMXPjD2aQGjYBbYn3Cyax
	gtgiAk4SG66sZgGxmQUqJf7dvgUWFxZwk7j3ay5YPYuAqsTR04vB4rwC9hLPdyxggdglLzHz
	0nd2EJtTwEFi/pTFYLYQUM2ZS+eh6gUlTs58AjVfXqJ562zmCYwCs5CkZiFJLWBkWsUomlpQ
	nJuem1xgqFecmFtcmpeul5yfu4kRHOBaQTsYl63/q3eIkYmD8RCjBAezkgjvpi2eaUK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTBycUg1MUze+fncvd/YxZe/y
	889sLr9h5AxM91gpzrL5+fVy54UZ6w21rddsDVyl9VT/Ua7juqtcRUKCN7OYb3Itf9qnHP7u
	8ddr4TvDd/+cwDNnw3EtqznbMnZX7j8lYnJh+ZzGddq7HR/9zODwq/R61bGL43DyTsOyvayb
	NO+pJrOZNWRIvapQ+6V+TZpNK9OhbXutT0pUV/vL9SIfWYtmnDOQvOM5yeeuin6IV7t/64zW
	DdejRZbG3RB93Dr/7McNe9+Wyah5PK4IfhXeKzcp+sh075QIw4yHR2bEm9+ZlC20bqfOv3C3
	CvnkCHse782tWs0uQsHcnBXrH5z7oCrsvJRLMKD3glOyf2XAGQHTeU1KLMUZiYZazEXFiQBz
	NwUD3wIAAA==
X-CMS-MailID: 20240521024009epcas1p3e80e90863a453053d5aac901ef644070
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p3e80e90863a453053d5aac901ef644070
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p3e80e90863a453053d5aac901ef644070@epcas1p3.samsung.com>

Bootloader knows the actual memory size, but bootloader may reserve some
memory for a specific purpose and pass the only remaining memory region
to kernel.

Even though kernel does not know what it is, we need to detect those
regions to sum up all reserved memory. Let me call it memory hole. To
expect the hole size, this patch assume two things. One is that each
physical memory has 1GB aligned size and address. And the hole is less
than 1GB. For the hole, let it be shown as unknown in memsize logic.

This is an example.
0x0bf000000-0x0c0000000 0x01000000 (   16384 KB ) nomap unusable unknown

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/of/fdt.c         |  2 ++
 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 45 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 605c7f471908..da82e5afed01 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1194,6 +1194,8 @@ void __init early_init_dt_scan_nodes(void)
 
 	/* Handle linux,usable-memory-range property */
 	early_init_dt_check_for_usable_mem_range();
+
+	memblock_memsize_detect_hole();
 }
 
 bool __init early_init_dt_scan(void *params)
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 9ccba9bb20cb..049313871059 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -617,10 +617,12 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
 extern void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
 				    bool reusable);
+extern void memblock_memsize_detect_hole(void);
 #else
 static inline void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
 				    bool reusable) { }
+static inline void memblock_memsize_detect_hole(void) { }
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index f05e7df2f8e1..5204ee71ae29 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2084,6 +2084,51 @@ void __init_memblock memblock_memsize_record(const char *name, phys_addr_t base,
 	memblock_dbg("%s %pa..%pa nomap:%d reusable:%d\n",
 		     __func__, &base, &end, nomap, reusable);
 }
+
+/* This function will be called to by early_init_dt_scan_nodes */
+void __init memblock_memsize_detect_hole(void)
+{
+	phys_addr_t base, end;
+	phys_addr_t prev_end, hole_sz;
+	int idx;
+	struct memblock_region *rgn;
+	int memblock_cnt = (int)memblock.memory.cnt;
+
+	/* assume that the hole size is less than 1 GB */
+	for_each_memblock_type(idx, (&memblock.memory), rgn) {
+		prev_end = (idx == 0) ? round_down(rgn->base, SZ_1G) : end;
+		base = rgn->base;
+		end = rgn->base + rgn->size;
+
+		/* only for the last region, check a hole after the region */
+		if (idx + 1 == memblock_cnt) {
+			hole_sz = round_up(end, SZ_1G) - end;
+			if (hole_sz)
+				memblock_memsize_record(NULL, end, hole_sz,
+							true, false);
+		}
+
+		/* for each region, check a hole prior to the region */
+		hole_sz = base - prev_end;
+		if (!hole_sz)
+			continue;
+		if (hole_sz < SZ_1G) {
+			memblock_memsize_record(NULL, prev_end, hole_sz, true,
+						false);
+		} else {
+			phys_addr_t hole_sz1, hole_sz2;
+
+			hole_sz1 = round_up(prev_end, SZ_1G) - prev_end;
+			if (hole_sz1)
+				memblock_memsize_record(NULL, prev_end,
+							hole_sz1, true, false);
+			hole_sz2 = base % SZ_1G;
+			if (hole_sz2)
+				memblock_memsize_record(NULL, base - hole_sz2,
+							hole_sz2, true, false);
+		}
+	}
+}
 #endif /* MEMBLOCK_MEMSIZE */
 
 static void __init free_memmap(unsigned long start_pfn, unsigned long end_pfn)
-- 
2.25.1


