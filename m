Return-Path: <linux-kernel+bounces-570778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A550A6B45A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA5046216F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297E1E2307;
	Fri, 21 Mar 2025 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ppn/qS4Y"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21E23A0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538068; cv=none; b=Yp2qZErKK6L4C3AlOiaEYxvHPbx12BCtUtCCCVK7z/OyuuAVq/GYUYk+EeNKSiieL7Qsks8KHkODij4jXVcew91YplWwryVv2757piYSi68Y8dKO/7jmzll3A3nauZa3UvPjW8d+0K6Up13LtsS/1/VtlwCfmOFm/QzVIvpAb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538068; c=relaxed/simple;
	bh=K5gl9UEwBz8KBotYmXKwq8cJnI2gxHaAreSHxx75Muw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=am3O0r8aYePOzHSUoUYnqQSYmx632RIwQEwJ/BXKziqyFFcxPKbCw9HeHrWU5v6b/cCllIpxVjk+Z8/Q71/ERevBZ6oD3z6blNH23Nt/Fzw+Mpu/m7c+bgiLVjvXwRb4CW6bSlVOGzJIfpHe++MFtrAnhCOpcji69Hvqcez89rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ppn/qS4Y; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742538062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zJ1YRoLIf8zcf/wFjPAu7C/iYpkw+xRSPmSNbI9AVrU=;
	b=ppn/qS4YvC6HMSANOytO0WDCaqJ2t0l33N6ToAA8roA99vMs5rIFM7lRqHPx/AgRswBJqY
	RJSwZcehVE6gsXeHaHSFiksG92OR6140GtZqr28xH5S3lQVCd/YT5BbC0jxu21t45L7Ah/
	w6ATagwIStlwx+KFlZoi78RWkjSjLyQ=
From: Ye Liu <ye.liu@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH v2] mm/page_alloc: Consolidate unlikely handling in page_expected_state
Date: Fri, 21 Mar 2025 14:20:53 +0800
Message-Id: <20250321062053.607044-1-ye.liu@linux.dev>
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
V2: return true instead of false in the PageHWPoison branch.
---
---
 mm/page_alloc.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2842da893eea..e8b95c6a96c2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -903,6 +903,12 @@ static inline bool page_expected_state(struct page *page,
 			(page->flags & check_flags)))
 		return false;
 
+	if (unlikely(PageHWPoison(page))) {
+		/* Don't complain about hwpoisoned pages */
+		if (PageBuddy(page))
+			__ClearPageBuddy(page);
+	}
+
 	return true;
 }
 
@@ -1586,29 +1592,15 @@ static __always_inline void page_del_and_expand(struct zone *zone,
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
+	bad_page(page, page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
 	return true;
 }
 
-- 
2.25.1


