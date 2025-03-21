Return-Path: <linux-kernel+bounces-570612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC86A6B28D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B37189EBD5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B982F29405;
	Fri, 21 Mar 2025 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jLmr8YWD"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096523BE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742519604; cv=none; b=MFl61JU6rBuPFouA/ax7rvzIagMiiztnl62hPEy/DS9V4X1Vsvl5QaXmepzALbulLY1sRDBtmfMnkEzLJIgtzhHU/NPjzIk4hz4w+qHXFmwki3HN+fBNDuCxhgdPAJeMrh4lG71OOtH7moUXPLF5KY6hBFEhap4rzDfpFTZjTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742519604; c=relaxed/simple;
	bh=i+QcUSTngAIqnWh6wyFn+z/B6VGWkQnDGRG/pCcvuMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LVBz2I28er87Wx/4+QkeGPcuMm2MXVWqogOwXozyJ79eU29XcBADIh5Y7nhThd2252IlQHMjjOF0lJq27bHo4lnjg4kqTfJDre9OUKmwkUnmyotDvJBhaENtttDRqH4SRhnREshl3FW0D8M8Y2VGdSOLKkiEd6OEFaCFgocZATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jLmr8YWD; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742519598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KbGMpgFUHUPbIp1VN0J4iVKPUjd5vasZbJUy7LDt1cs=;
	b=jLmr8YWDNLmYeL1LOdLCsAn76LkpMSCCwveHYn87nMTiPL/GRgWzch+MIoWGFmeDSP32lh
	9KumBFQY6VeWtX9ODPo9OJnprWYPCSmUs7/2sLj69WGHK0h/5mULfk0dZ+i2wGSXP3t6uI
	/1qC7jk42GGRGiQiK40smHMY/muUShQ=
From: Ye Liu <ye.liu@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH] mm/page_alloc: Consolidate unlikely handling in page_expected_state
Date: Fri, 21 Mar 2025 09:13:04 +0800
Message-Id: <20250321011304.549908-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

This patch consolidates the handling of unlikely conditions in the
page_expected_state function, reducing code duplication and improving
readability.

Previously, the check_new_page_bad function contained logic to handle
__PG_HWPOISON flags, which was called from check_new_page. This patch
moves the handling of __PG_HWPOISON flags into the page_expected_state
function and removes the check_new_page_bad function. The check_new_page
function now directly calls bad_page if the page has unexpected flags.

This change simplifies the code by reducing the number of functions and
centralizing the unlikely condition handling in one place.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 mm/page_alloc.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2842da893eea..d8d04ac1d709 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -892,6 +892,13 @@ static inline bool page_expected_state(struct page *page,
 	if (unlikely(atomic_read(&page->_mapcount) != -1))
 		return false;
 
+	if (unlikely(PageHWPoison(page))) {
+		/* Don't complain about hwpoisoned pages */
+		if (PageBuddy(page))
+			__ClearPageBuddy(page);
+		return false;
+	}
+
 	if (unlikely((unsigned long)page->mapping |
 			page_ref_count(page) |
 #ifdef CONFIG_MEMCG
@@ -1586,29 +1593,16 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 	account_freepages(zone, -nr_pages, migratetype);
 }
 
-static void check_new_page_bad(struct page *page)
-{
-	if (unlikely(PageHWPoison(page))) {
-		/* Don't complain about hwpoisoned pages */
-		if (PageBuddy(page))
-			__ClearPageBuddy(page);
-		return;
-	}
-
-	bad_page(page,
-		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
-}
-
 /*
  * This page is about to be returned from the page allocator
  */
 static bool check_new_page(struct page *page)
 {
-	if (likely(page_expected_state(page,
-				PAGE_FLAGS_CHECK_AT_PREP|__PG_HWPOISON)))
+	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_PREP)))
 		return false;
 
-	check_new_page_bad(page);
+	bad_page(page,
+		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
 	return true;
 }
 
-- 
2.25.1


