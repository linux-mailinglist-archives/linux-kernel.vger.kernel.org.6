Return-Path: <linux-kernel+bounces-522996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2CAA3D0E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8716A17BD37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F631EBFFC;
	Thu, 20 Feb 2025 05:36:11 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991FD1E8345
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029769; cv=none; b=WKmWhMcRv6aqYLPIgN4+MNLEFxs5N28bc/O6zX+SEo6hBVndpumdcH61Fulikg6sM/l8R+a9GaX9vqABEwmKXXXH1uUzs2rtTSuBr2gbUEhp8cyIRwWGhSd051U3ZA04KWEHXuPu7o9k6spRJu2ANfXcXn7vsLVPxY3hPQX0oUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029769; c=relaxed/simple;
	bh=ibhtPcxsan2ORPeRajX4nLWvkXK8XgQ6EXtn+fJovlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m610iB0JRmJ4UFyisG6/ucIzliGHZijfJWMeLpXHVQEhP4ygtcVBs5Af3BvmOMzTJyptSuxA2GIEs5Kz7ndT3GXCDutllvue/duXygROXjalSjDoGM6maAQ1NALi0ysedJRXaNbLDlXNrIl9yUC2/4HeUOKg4gmwZPqRJ0oxk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-08-67b6bba767e5
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 18/26] mm/page_alloc: retry 3 times to take pcp pages on luf check failure
Date: Thu, 20 Feb 2025 14:20:19 +0900
Message-Id: <20250220052027.58847-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXC9ZZnke7y3dvSDVpesVnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	XV9+MhU84ao4/HITcwPjFo4uRg4OCQETiS13hGDM010uXYycHGwC6hI3bvxkBrFFBMwkDrb+
	YQexmQXuMkkc6GcDsYUFkiROz3vPCmKzCKhK/H3ezAgyhheofntzGEhYQkBeYvWGA2BjOIHC
	P2b0grUKCZhKvFtwiamLkQuo5jObxKSnS1kgGiQlDq64wTKBkXcBI8MqRqHMvLLcxMwcE72M
	yrzMCr3k/NxNjMCgX1b7J3oH46cLwYcYBTgYlXh4Z7RuSxdiTSwrrsw9xCjBwawkwttWvyVd
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA+PSYMcWnQkq
	7Eafp5ns4pp3XCGXu9bNfsrEWeuPl4YzZ9k4K92Iv+lY9+hlytktKwxude141fXmy+2qJIFv
	69zWvJ0a8ff0S4sPt+skprOLHdzm43bid3Db+hs2a/5qpu3geLvm7iPxdae2svjqPnaY1XFi
	WdZfma1VBjdWzvvBrmO4cNPuj18SlViKMxINtZiLihMB+JLdZ3YCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g6lTrC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlbHry0+mgidcFYdfbmJuYNzC0cXIwSEhYCJxusuli5GTg01AXeLGjZ/MILaI
	gJnEwdY/7CA2s8BdJokD/WwgtrBAksTpee9ZQWwWAVWJv8+bGUHG8ALVb28OAwlLCMhLrN5w
	AGwMJ1D4x4xesFYhAVOJdwsuMU1g5FrAyLCKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMIiX
	1f6ZuIPxy2X3Q4wCHIxKPLwPHm9NF2JNLCuuzD3EKMHBrCTC21a/JV2INyWxsiq1KD++qDQn
	tfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qBMTvRs3+fScG/3O+HxW8ZCC/efUyM
	/ZMf/63QKu5Io7NbK9s1ii00Lu30ktBIKT43yfWpspkrS8+nnFspUZH+mv2f/ZZsn3WbcdHu
	nrVrtUV/mrbsPtWb96pmXlXEjdXG7TMdUn1SUua6aX8q8wpMORdo4daxhWOHEqP83cTvtUci
	tG+bTK5TYinOSDTUYi4qTgQA9wFB2l4CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/page_alloc.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3032fedd8392b..0b6e7f235c4a1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3339,6 +3339,12 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 {
 	struct page *page;
 
+	/*
+	 * give up taking page from pcp if it fails to take pcp page
+	 * 3 times due to the tlb shootdownable issue.
+	 */
+	int try_luf_pages = 3;
+
 	do {
 		if (list_empty(list)) {
 			int batch = nr_pcp_alloc(pcp, zone, order);
@@ -3353,11 +3359,21 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 				return NULL;
 		}
 
-		page = list_first_entry(list, struct page, pcp_list);
-		if (!luf_takeoff_check_and_fold(page))
+		list_for_each_entry(page, list, pcp_list) {
+			if (luf_takeoff_check_and_fold(page)) {
+				list_del(&page->pcp_list);
+				pcp->count -= 1 << order;
+				break;
+			}
+			if (!--try_luf_pages)
+				return NULL;
+		}
+
+		/*
+		 * If all the pages in the list fails...
+		 */
+		if (list_entry_is_head(page, list, pcp_list))
 			return NULL;
-		list_del(&page->pcp_list);
-		pcp->count -= 1 << order;
 	} while (check_new_pages(page, order));
 
 	return page;
-- 
2.17.1


