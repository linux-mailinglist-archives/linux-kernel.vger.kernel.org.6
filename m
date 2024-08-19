Return-Path: <linux-kernel+bounces-291665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF3A956556
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22871F22F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377EA15B10D;
	Mon, 19 Aug 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oWJLyi4k"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6215AAD6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055294; cv=none; b=nC4CO57UWgBWJJFI+cEOg8ie3hUBfDnfW1k+R76EVqFERbmuxu8FjqSp3YGCjO8drYyH7Nn6hSXVMyjjWke0pJxxoIwV71NlyuiOrupgQ6CoBvXjEFwWJMHEIqb0zibL5K/k1+NrjEQ+93MOgklAnCBkYZfZ/8vzpXwsheM2TNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055294; c=relaxed/simple;
	bh=5fN542VEOuMC7wUi304QfjRXCRFt5ylwMXY6d3EVch8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p65nQW8cpOyv0I4mzLIVYqHL94z1gsll9b1mN0JbEunAdLwVLkFrvsqfAvpAQC4bmLSGKmSzqyf6thl9ZzBxVaZiIjBVI/qSY/DPbZpJ8yESUmczu/Yi9Cd5zQ2IYlk9k8HLgIafhI1iHwLkzJ4vopCBEBbyoB+bWWDMSvm0RIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oWJLyi4k; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724055287; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mYH71MdwFDoWK+6jyn77RluPuidTuLdZqV2Iscl7EWk=;
	b=oWJLyi4kdNFu4Y6qRIIp6cKqAjksxETGpuOvAvvPneIQ371Swvaw5BNDXbqqqzYT5IxxjH/Wg1aVfcJAlEW4JLgeuloqhTIeVXk7TAEoL9+tsw1RM2GsXnsA2m9lxPR6Nk8QSsUo+SqLb/h4akeJix8jfJ/Glj/3Nk5umxTwsNQ=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WD8W7MM_1724055286)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 16:14:47 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mm: khugepaged: use the number of pages in the folio to check the reference count
Date: Mon, 19 Aug 2024 16:14:03 +0800
Message-Id: <c6038c7e823d4162f745147628616f7876585a97.1724054125.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1724054125.git.baolin.wang@linux.alibaba.com>
References: <cover.1724054125.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the number of pages in the folio to check the reference count as
preparation for supporting shmem mTHP collapse.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f11b4f172e61..60d95f08610c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1994,7 +1994,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		/*
 		 * We control three references to the folio:
 		 *  - we hold a pin on it;
-		 *  - one reference from page cache;
+		 *  - nr_pages reference from page cache;
 		 *  - one from lru_isolate_folio;
 		 * If those are the only references, then any new usage
 		 * of the folio will have to fetch it from the page
@@ -2002,7 +2002,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		 * truncate, so any new usage will be blocked until we
 		 * unlock folio after collapse/during rollback.
 		 */
-		if (folio_ref_count(folio) != 3) {
+		if (folio_ref_count(folio) != 2 + folio_nr_pages(folio)) {
 			result = SCAN_PAGE_COUNT;
 			xas_unlock_irq(&xas);
 			folio_putback_lru(folio);
@@ -2185,7 +2185,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		folio_clear_active(folio);
 		folio_clear_unevictable(folio);
 		folio_unlock(folio);
-		folio_put_refs(folio, 3);
+		folio_put_refs(folio, 2 + folio_nr_pages(folio));
 	}
 
 	goto out;
-- 
2.39.3


