Return-Path: <linux-kernel+bounces-291664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D4956555
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11E71F22B48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FCE15B0EC;
	Mon, 19 Aug 2024 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Acp9cb/D"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A59B15820F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055293; cv=none; b=qJM7ZWnJI+IeSkaJD8RK+jorH6dopBU6xvcNgAiZiV9zE+L++Q4yuUIdZA3EFOUYjuj4a4nJR5nuJEWAo649WTfdkWP+MaUAlrzQG4fouYlwZNFROl1wZlvKnVule4SzLe9EwGPaxLvdKBZdqEM9zg68t7foiMUE56l0Z0hrppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055293; c=relaxed/simple;
	bh=Jk5paYBWA74YJEdDoc1w57dR5QTa0m1FG+hogFp6Jp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qgCvJW8vLLzX1FzkdqEwppSYpSVU49w7+gfGQozJd0YQl9qx3Pl3SCNwOXGQM5rNLWnx3Sdbv776HGMtJX76TeF8zL26Pw5VPsB2l76bnC53Bs5job0DeDk5LEGC4RVZCN5d2Wp6vNajWPN4YRZ32O1Lzyfb/yWMoo7oWOSspu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Acp9cb/D; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724055286; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wXFLqHbVSHxFKCZqqifJmzb9vdz6whYXmBhNU0imZD0=;
	b=Acp9cb/DupVdSrhmtniMMNOLRLSPf+tSK5diilQexTp3OG0WHtJP4plCBcbvWXNNrM3oZCgEsPEzHUvZJU5Q309IXP02+C7IO0sKc/Vd70KZtfipB86kabQGLmtesDMvceYXA8tjZKoJp9VXFu/H5+f+C8S7/+7qlvGUJttNaxc=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WD8W7Ls_1724055285)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 16:14:46 +0800
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
Subject: [PATCH 1/5] mm: khugepaged: expand the is_refcount_suitable() to support file folios
Date: Mon, 19 Aug 2024 16:14:02 +0800
Message-Id: <d6f8e4451910da1de0420eb82724dd85c368741c.1724054125.git.baolin.wang@linux.alibaba.com>
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

Expand the is_refcount_suitable() to support reference checks for file folios,
as preparation for supporting shmem mTHP collapse.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cdd1d8655a76..f11b4f172e61 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -549,8 +549,14 @@ static bool is_refcount_suitable(struct folio *folio)
 	int expected_refcount;
 
 	expected_refcount = folio_mapcount(folio);
-	if (folio_test_swapcache(folio))
+	if (folio_test_anon(folio)) {
+		expected_refcount += folio_test_swapcache(folio) ?
+					folio_nr_pages(folio) : 0;
+	} else {
 		expected_refcount += folio_nr_pages(folio);
+		if (folio_test_private(folio))
+			expected_refcount++;
+	}
 
 	return folio_ref_count(folio) == expected_refcount;
 }
@@ -2285,8 +2291,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 			break;
 		}
 
-		if (folio_ref_count(folio) !=
-		    1 + folio_mapcount(folio) + folio_test_private(folio)) {
+		if (!is_refcount_suitable(folio)) {
 			result = SCAN_PAGE_COUNT;
 			break;
 		}
-- 
2.39.3


