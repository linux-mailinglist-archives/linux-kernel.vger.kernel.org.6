Return-Path: <linux-kernel+bounces-184376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0448CA640
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C621F2221C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0791CD11;
	Tue, 21 May 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tgCjMnuA"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B222182DB
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259219; cv=none; b=pPCCq0fIZTwziRs9uPxb0SOMycQH7NHAB5x52MEuHyDH1WuUjeuNmtlqhjdJuF5MHfHNhCE8BJmVxZRvqfmm7CTzyKGucQasL4Jo3IOVdI5TPX3bc5WiRbo70sI8aCNKxGptHv3tQnakoNvyUl8PM0l4289JP0jONSxgC1emqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259219; c=relaxed/simple;
	bh=dQ2dDL5gdr4GIpMicvA3R+ZshvyNuY0C91A+ycmRHxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=tik6TgxyBxRdKMfFt8X4i9LjhPBj0zIN7L7uAmzKGwBVDtIxEL2LuJmNO628j3oImGvUsAxFlgM/GTNhWkohzZEfNtPjTelpWjR4pkhZ+ZjAkTyME+3e660Mdb8XwlqZJ+r/Zr6qESCe5+IXUYeSC3bTV2ljVCD5Ed+aDkAFKA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tgCjMnuA; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp019ebe7310bc59b9f71b7b3fdfad415c2e~RYKiSasyG1201212012epoutp01r
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240521024010epoutp019ebe7310bc59b9f71b7b3fdfad415c2e~RYKiSasyG1201212012epoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=A4wbeCsOJjEbvL1QOmk6MW3+h+xr7FchNPjqmD26Xjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgCjMnuAZjF6xEE1YpyFfNZ57s0LIuwdl/Bl+kW5QlJTbYw6ISctx9xhqp5e2OUj+
	 ter/YId6f94yGfXpbBpWPLmu3GYib10KClcw1Xrz5OIMSSCr7ZvBKGcuM/JkAzRBSA
	 LzAd2Oi6Nsxgmno6DkWWZDyvdy3V2UpCdVDcKjZk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epcas1p15e3498c3017f00d8fc80ebf9ec9411a9~RYKh2fr7q2309423094epcas1p11;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.227]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VjzDn450Sz4x9Q4; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.B2.10076.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p40d0ea59e8ae93f6cc89846626fea4207~RYKhhxWVN1450914509epcas1p4_;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp168b48ce8e5c6dc6ea18e32ddca44728f~RYKhg98Km2362723627epsmtrp1J;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
X-AuditID: b6c32a39-59dff7000000275c-c7-664c09892610
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1C.75.08924.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epsmtip2267c0f75b4a24d70569e3cd70009b889~RYKhY20pf1232612326epsmtip2H;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 06/10] memblock: recognize late freed size by
 checking PageReserved
Date: Tue, 21 May 2024 11:39:53 +0900
Message-Id: <20240521023957.2587005-7-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTT7eT0yfN4OEjeYs569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
	ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fL
	Sy2xMjQwMDIFKkzIzvg16SpLwX+hip7dF9gaGP/wdTFyckgImEi0PlnI2sXIxSEksINRYu+e
	ZewgCSGBT4wSJ/aYQiS+MUp8urqUCaZjf/cJqI69jBJzV22Acj4zSvy495URpIpNQFvi/YJJ
	rCC2iICdxLfZB8BsZoFSibdvTjCD2MICMRIXf51hAbFZBFQlurZNA7N5Bewljv/tYYHYJi8x
	89J3sJM4BRwk5k9ZzA5RIyhxcuYTFoiZ8hLNW2czgxwhIfCTXeLJ7v/sEM0uEqsXLGeFsIUl
	Xh3fAhWXknjZ3wZl50tcuPgK6DUOILtGYuFEQ4iwvcSurzNYQcLMApoS63fpQ6zik3j3tYcV
	oppXoqNNCKJaTaLl2VeoRTISf/89g7I9JN59uMQOCZ7JjBIT+t4zTWCUn4Xkg1lIPpiFsG0B
	I/MqRrHUguLc9NRiwwJTeKQm5+duYgSnSS3LHYzT337QO8TIxMF4iFGCg1lJhHfTFs80Id6U
	xMqq1KL8+KLSnNTiQ4ymwPCdyCwlmpwPTNR5JfGGJpYGJmZGJhbGlsZmSuK8Z66UpQoJpCeW
	pGanphakFsH0MXFwSjUwtbTE3bfpCslhjH50uifoqZ7efJaW+H2Tv6lyXH30R/r03V7RrB7j
	F78vX1/w0jZVwuD6XJ0Z624bOaw6++3Fi4UPdbcqpIervosvn62+u/ntqicKmyuu3Pp7R5C/
	145je8rkthyxPxoLGUL+idv8vv7G43HxgwV5d7OYNmYpHjnZa6i68oFbqInqpWW7pu3SceK+
	5ut3OZRpxTW9y7ylFYvZdHztLW8E6jd/XjTTqSnvX/nU/vhnTS3Bn/vaLyc+tFl3l08qJ6Hw
	8LoTjo0rFT/cX9Hk/SL820YXBvenWy1vqMke59B4bF/hFtQslxci38hwPt6JsWGndGrAscQL
	24wEPrpxvtf+tGfZqcf/lViKMxINtZiLihMBI/xHIRwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvG4np0+awZUv/BZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgd2D12zrrL7rFpVSebx6ZPk9g9Tsz4zeLRt2UV
	o8eZBUfYPT5vkgtgj+KySUnNySxLLdK3S+DK+DXpKkvBf6GKnt0X2BoY//B1MXJySAiYSOzv
	PsHaxcjFISSwm1Hi7a5TbBAJGYk355+ydDFyANnCEocPF4OEhQQ+Mkr86mQBsdkEtCXeL5jE
	CmKLCDhJbLiyGizOLFAp8e/2LbC4sECUxLKnixlBbBYBVYmubdPAangF7CWO/+1hgVglLzHz
	0nd2EJtTwEFi/pTF7BC77CXOXDrPClEvKHFy5hOo+fISzVtnM09gFJiFJDULSWoBI9MqRsnU
	guLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgMNfS3MG4fdUHvUOMTByMhxglOJiVRHg3bfFM
	E+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cCUJBd+7EjA
	9O6nLC4r3d/xP335y/kWQ8O0vjkxhydJvbsYxsPjXBgnuXL1Q2H2KzllXc/rZdmaL8rUrRM7
	57fk+x2xnVeeVl+vY5u445SApNisuXL7pf/lNJp1XzXuZdmYk/pBqMtcc9G2pmkHL99Y72Me
	9WB15aelnkVL0h/fP7O0QFR7auWsvNvP82YtXZN2fsfqtJXFZU8rDV5d+u0a/PBGhajUL9MJ
	KuzPKzuv8sXvasnMV/rZpMRyVSRCe8nGNZycNp5Pv6Q7x96YMenC+VX/VztN2BGsZfBief2n
	Fb2Kq3PqE433yylnb0wwUeJxDoi51nWQq+4jw51TE8KE5Rlkpq1Jnd8+1W320igOJZbijERD
	Leai4kQAy/7GsOICAAA=
X-CMS-MailID: 20240521024009epcas1p40d0ea59e8ae93f6cc89846626fea4207
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p40d0ea59e8ae93f6cc89846626fea4207
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p40d0ea59e8ae93f6cc89846626fea4207@epcas1p4.samsung.com>

There are some cases in which reserved pages are freed late after the
initial memblock_free_all of mem_init. We'd like to recognize this
late free pages, and update the memsize information.

Because additional job is needed to a no-map or reusable region, the
late free is usually done to a map and unusable region. So only for map
and unusable region, check if some pages within the region is freed. The
freed pages can be recoginzed by checking if PageReserved flag is clear.
To be fast, let's skip other pages within 64 KB range. And this check is
done when a user wants to see the memsize information.

This is an example. If all pages are freed the region size will be 0.

Before
0x0a2300000-0x0a2400000 0x00100000 (    1024 KB )   map unusable latefree

After
0x0a2300000-0x0a2300000 0x00000000 (       0 KB )   map unusable latefree

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/memblock.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index edb2575967ab..de49e7ce74f1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2608,6 +2608,39 @@ static int memsize_rgn_cmp(const void *a, const void *b)
 	return 0;
 }
 
+/* assume that freed size is always 64 KB aligned */
+static inline void memblock_memsize_check_size(struct memsize_rgn_struct *rgn)
+{
+	phys_addr_t phy, end, freed = 0;
+	bool has_freed = false;
+	struct page *page;
+
+	if (rgn->reusable || rgn->nomap)
+		return;
+
+	/* check the first page of each 1 MB */
+	phy = rgn->base;
+	end = rgn->base + rgn->size;
+	while (phy < end) {
+		unsigned long pfn = __phys_to_pfn(phy);
+
+		if (!pfn_valid(pfn))
+			return;
+		page = pfn_to_page(pfn);
+		if (!has_freed && !PageReserved(page)) {
+			has_freed = true;
+			freed = phy;
+		} else if (has_freed && PageReserved(page)) {
+			has_freed = false;
+			memblock_memsize_free(freed, phy - freed);
+		}
+
+		if (has_freed && (phy + SZ_64K >= end))
+			memblock_memsize_free(freed, end - freed);
+		phy += SZ_64K;
+	}
+}
+
 static int memblock_memsize_show(struct seq_file *m, void *private)
 {
 	int i;
@@ -2621,6 +2654,7 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 		long size;
 
 		rgn = &memsize_rgn[i];
+		memblock_memsize_check_size(rgn);
 		base = rgn->base;
 		size = rgn->size;
 		end = base + size;
-- 
2.25.1


