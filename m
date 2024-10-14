Return-Path: <linux-kernel+bounces-363791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1158099C719
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8751F2153F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E6D15C122;
	Mon, 14 Oct 2024 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ncJFOlwf"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF915B143
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901501; cv=none; b=MrAavD4KGMlID2MTN18IUJ+xk0qJukccdqQUn89ONgOlzl+ZXK9Hf/BtwODOgj4F1OJF815z6XKDSxlRWG9ltEB08sM0QD2XeeJFzMXKuaM3W0AFAyN/qRrhDzQGX8ssunudGP7UXj6VTQuO+zRoghZ0KJjDAx+1tLPevb7AvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901501; c=relaxed/simple;
	bh=886Ka45TGLxbH08eLTl5Am64EOaZZyYSqCWo1VsDiaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JSFxiRBW20DImHX77JgQn1tU1XV64JF9QDbmONqnJkJDAiTICb2O4F7QGWHQfY/8LqX5vMt69Q8IcNpL1vrmxK8EDF4mx9q4rcmlDQWqGOimEaCT3YWns38PAnDyQj6+XmIKhD0I3qb5mJe74EU5PyJjC/d1rwhUQDZ2q4MWPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ncJFOlwf; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728901496; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RfYIKH4GciTHGtaGZLfxiERKrYeVVndHxoup3ZNPKks=;
	b=ncJFOlwfvaFIygl4SrtYW1bBesazL0uPxWFUDyVMyM5ox2meRS3fV2/Bc/zjUqu4hXIKbi32fO3skh67HOGTeuqZUd1qwaWDNzjUca+pgs/51DeAJXl0oYrimmj/3xXV2UyqzfaAyQxeMvTqLhKBR8qH+ouxm6hSCviyJA4JvqU=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WH4yvy8_1728901495 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 18:24:56 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: khugepaged: fix the incorrect statistics when collapsing large file folios
Date: Mon, 14 Oct 2024 18:24:44 +0800
Message-Id: <c76305d96d12d030a1a346b50503d148364246d2.1728901391.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Khugepaged already supports collapsing file large folios (including shmem mTHP)
by commit 7de856ffd007 ("mm: khugepaged: support shmem mTHP collapse"), and the
control parameters in khugepaged: 'khugepaged_max_ptes_swap' and 'khugepaged_max_ptes_none',
still compare based on PTE granularity to determine whether a file collapse is
needed. However, the statistics for 'present' and 'swap' in hpage_collapse_scan_file()
do not take into account the large folios, which may lead to incorrect judgments
regarding the khugepaged_max_ptes_swap/none parameters, resulting in unnecessary
file collapses.

To fix this issue, take into account the large folios' statistics for 'present'
and 'swap' variables in the hpage_collapse_scan_file().

Fixes: 7de856ffd007 ("mm: khugepaged: support shmem mTHP collapse")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ba28ba09fe89..6f8d46d107b4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2267,7 +2267,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 			continue;
 
 		if (xa_is_value(folio)) {
-			++swap;
+			swap += 1 << xas_get_order(&xas);
 			if (cc->is_khugepaged &&
 			    swap > khugepaged_max_ptes_swap) {
 				result = SCAN_EXCEED_SWAP_PTE;
@@ -2314,7 +2314,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		 * is just too costly...
 		 */
 
-		present++;
+		present += folio_nr_pages(folio);
 
 		if (need_resched()) {
 			xas_pause(&xas);
-- 
2.39.3


