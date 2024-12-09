Return-Path: <linux-kernel+bounces-436681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36DB9E8950
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7DC1885F89
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74313AD20;
	Mon,  9 Dec 2024 02:43:36 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6D1369B4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712216; cv=none; b=PWe+5yTrAkEGR8Ap+02oUGHRQF3yZjx4WaHst7+NGrUB0Man+kfa/b62ZY3kV56NW8zU/A2JsSePK2MtF7gPYi0+pKPLBGcieSZU77uqk6DSzjj8Z2zS5wXx5VPaWmGIgFbYCf0FZvg1lxdYYzLFsd4blhunYybkoaqdkPRY4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712216; c=relaxed/simple;
	bh=4plY1k7DxAQok3kx7AmXfPwhj4PD1tQeMuuTH7Ogh3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4pjc03CifZReojBUn4IcmW6JKCLyCX+8TsbF7A6MDpBUBa4Z9SmKN+3V/X3rH1UjItp4ufoVjN+L6lB0ftiIJyu0O9Ln7jGAeb/ybEuvwXmiCT52ZzsxfAKsTi5XdZ2kHAqua4dsk/h4dDmCbrDsftA0E2wpjGCFhhJ+yGwS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y65jL32dzzRj4G;
	Mon,  9 Dec 2024 10:41:42 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id F0128180102;
	Mon,  9 Dec 2024 10:43:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Dec 2024 10:43:22 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron
	<Jonathan.Cameron@Huawei.com>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, James
 Morse <james.morse@arm.com>, Robin Murphy <robin.murphy@arm.com>, Andrey
 Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Andrey Ryabinin
	<ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Madhavan Srinivasan
	<maddy@linux.ibm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<kasan-dev@googlegroups.com>, Tong Tiangen <tongtiangen@huawei.com>,
	<wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [PATCH v13 3/5] mm/hwpoison: return -EFAULT when copy fail in copy_mc_[user]_highpage()
Date: Mon, 9 Dec 2024 10:42:55 +0800
Message-ID: <20241209024257.3618492-4-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209024257.3618492-1-tongtiangen@huawei.com>
References: <20241209024257.3618492-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500005.china.huawei.com (7.202.194.90)

Currently, copy_mc_[user]_highpage() returns zero on success, or in case
of failures, the number of bytes that weren't copied.

While tracking the number of not copied works fine for x86 and PPC, There
are some difficulties in doing the same thing on ARM64 because there is no
available caller-saved register in copy_page()(lib/copy_page.S) to save
"bytes not copied", and the following copy_mc_page() will also encounter
the same problem.

Consider the caller of copy_mc_[user]_highpage() cannot do any processing
on the remaining data(The page has hardware errors), they only check if
copy was succeeded or not, make the interface more generic by using an
error code when copy fails (-EFAULT) or return zero on success.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/highmem.h | 8 ++++----
 mm/khugepaged.c         | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6e452bd8e7e3..0eb4b9b06837 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -329,8 +329,8 @@ static inline void copy_highpage(struct page *to, struct page *from)
 /*
  * If architecture supports machine check exception handling, define the
  * #MC versions of copy_user_highpage and copy_highpage. They copy a memory
- * page with #MC in source page (@from) handled, and return the number
- * of bytes not copied if there was a #MC, otherwise 0 for success.
+ * page with #MC in source page (@from) handled, and return -EFAULT if there
+ * was a #MC, otherwise 0 for success.
  */
 static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 					unsigned long vaddr, struct vm_area_struct *vma)
@@ -349,7 +349,7 @@ static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 	if (ret)
 		memory_failure_queue(page_to_pfn(from), 0);
 
-	return ret;
+	return ret ? -EFAULT : 0;
 }
 
 static inline int copy_mc_highpage(struct page *to, struct page *from)
@@ -368,7 +368,7 @@ static inline int copy_mc_highpage(struct page *to, struct page *from)
 	if (ret)
 		memory_failure_queue(page_to_pfn(from), 0);
 
-	return ret;
+	return ret ? -EFAULT : 0;
 }
 #else
 static inline int copy_mc_user_highpage(struct page *to, struct page *from,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6f8d46d107b4..c3cdc0155dcd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -820,7 +820,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 			continue;
 		}
 		src_page = pte_page(pteval);
-		if (copy_mc_user_highpage(page, src_page, src_addr, vma) > 0) {
+		if (copy_mc_user_highpage(page, src_page, src_addr, vma)) {
 			result = SCAN_COPY_MC;
 			break;
 		}
@@ -2081,7 +2081,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 
 		for (i = 0; i < nr_pages; i++) {
-			if (copy_mc_highpage(dst, folio_page(folio, i)) > 0) {
+			if (copy_mc_highpage(dst, folio_page(folio, i))) {
 				result = SCAN_COPY_MC;
 				goto rollback;
 			}
-- 
2.25.1


