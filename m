Return-Path: <linux-kernel+bounces-576369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F54A70E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308DE3BE13B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6B620328;
	Wed, 26 Mar 2025 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L1t8UzKi"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D66634EC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742951910; cv=none; b=c9SXDEKDeyjKwA3g8pb19oO9QJwzWMmdFd0lse4+glmtfi8vkUjWQgCHbvPxOaUHo1SETSqi92M2lGSvsukZm+aAhnlQp7bDGC1j0Hl70e9muw03iPEpQHCGze5z1mpwB//M+6Rlaj2NIKKwAVWw3Seb2P4hrIoLsX9HL0M3R0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742951910; c=relaxed/simple;
	bh=5RYvswtWE+GnIh/JiB8nfYa6DgGi/wCVV0OmMHC4jqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XTyvt5l556MzlBVqnNeI3GL/KU10Uz7fq+WTPElIaiOl3p+i/DocuznxZfS7lZZfhJqF4pAkY5uKlDljCSqcpW7AnrGMKbVKdRhnlEAgOPv/zazWLwUFMX1rQDFeKVShrx4yuxE5LIzUdQhwdFkVZOG3bYaIpYmMdWT9ElPVqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L1t8UzKi; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742951905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AXpKOR2GMxCoVvpFxRv1qPlHNVEaxgMDCeiLw9aKmNw=;
	b=L1t8UzKiFURd0xqLT3QXXuGuqIW0pYLoPfoPUoCTF7pjeBI6FV2Zvjfot9sLBQDZapeNHq
	CZEUDxZyhC52alJ7j5ogV51f722vhuD3PzfsUjx7k9M1QWdrvNcEQAriiCCLu/SYeH+LsX
	+tejpPVrXQCLQfRuOnUXsjnt1gw4gbg=
From: Ye Liu <ye.liu@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	sidhartha.kumar@oracle.com,
	anshuman.khandual@arm.com,
	Markus.Elfring@web.de,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH v3] mm/page_alloc: Consolidate unlikely handling in page_expected_state
Date: Wed, 26 Mar 2025 09:17:52 +0800
Message-Id: <20250326011752.917564-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Consolidates the handling of unlikely conditions in the
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
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

---
V3: Delete 'This patch'.
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


