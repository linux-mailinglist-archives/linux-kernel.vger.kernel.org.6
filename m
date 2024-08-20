Return-Path: <linux-kernel+bounces-293693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 178DB95832F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EC71C2411B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F353518C93D;
	Tue, 20 Aug 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sPsGyMCq"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E218E364
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147393; cv=none; b=t/418rQD7m7FcwPH2K9sM73eMvzCN4Ek2D7tNsMiAbVNcs4tuqrDvStQ/na6X0PMgIrnJo2qBch1pNy51SB9bCZCzVgA5NTH5xzXv+aeeg5Smp8IeEV7YWhBOtbxLtdZdrBmnnDe/4sI6VPUer9sRfDnogYh4CJs+Zam94EJM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147393; c=relaxed/simple;
	bh=tlEn4MoCMLXKUBkfGYFDl4wTKxqWTr+e3qXdF/cStn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uztX+EfuJusSvC14zBvoZt04uW6/Br240bP/V9qrhsgUJVBqBAv8waxP8ZaforWVhszrgmqN+5P7ZeKF9wR0vDk4jbsjKoi0t+gV2Y/SriDqjWEPqjdm6KCteZiMVhuBOY4TzOk2GfO9SYvDXgiymyACHPKjD6iIPBsoAzZwI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sPsGyMCq; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724147382; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BdoRq8oN4jMPChy+X0I/pW/sjGhNsrwJxvZFVW1ygPQ=;
	b=sPsGyMCqgR0Ot6D70+V+k9rXsJ3UFsAhX3+FRJr7Pebn8hCfJ3KF+FRGJ2IF6ZPvI8CpzHQYfPEqB+qYLQe8kf6X0+Q0jDlYIlrW9RWWqAGD/bMO+/NKVK8iYTasnZNEmJUKvoZqgqpnlX07wsqPd6MT5wx0z0vWEX5tW20ME20=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDIChL0_1724147381)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 17:49:42 +0800
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
Subject: [PATCH v2 2/5] mm: khugepaged: use the number of pages in the folio to check the reference count
Date: Tue, 20 Aug 2024 17:49:14 +0800
Message-Id: <9ea49262308de28957596cc6e8edc2d3a4f54659.1724140601.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1724140601.git.baolin.wang@linux.alibaba.com>
References: <cover.1724140601.git.baolin.wang@linux.alibaba.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/khugepaged.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 76f05215ee87..e015c94eba09 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1988,9 +1988,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		VM_BUG_ON_FOLIO(folio != xa_load(xas.xa, index), folio);
 
 		/*
-		 * We control three references to the folio:
+		 * We control 2 + nr_pages references to the folio:
 		 *  - we hold a pin on it;
-		 *  - one reference from page cache;
+		 *  - nr_pages reference from page cache;
 		 *  - one from lru_isolate_folio;
 		 * If those are the only references, then any new usage
 		 * of the folio will have to fetch it from the page
@@ -1998,7 +1998,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		 * truncate, so any new usage will be blocked until we
 		 * unlock folio after collapse/during rollback.
 		 */
-		if (folio_ref_count(folio) != 3) {
+		if (folio_ref_count(folio) != 2 + folio_nr_pages(folio)) {
 			result = SCAN_PAGE_COUNT;
 			xas_unlock_irq(&xas);
 			folio_putback_lru(folio);
@@ -2181,7 +2181,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		folio_clear_active(folio);
 		folio_clear_unevictable(folio);
 		folio_unlock(folio);
-		folio_put_refs(folio, 3);
+		folio_put_refs(folio, 2 + folio_nr_pages(folio));
 	}
 
 	goto out;
-- 
2.39.3


