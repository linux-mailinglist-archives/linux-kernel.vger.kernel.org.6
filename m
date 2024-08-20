Return-Path: <linux-kernel+bounces-293692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FACC95832E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FB01C233AC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F45014A0A8;
	Tue, 20 Aug 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j/7sbZR3"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04C18E364
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147387; cv=none; b=YsSzsjbr0MsuTeGh7soSnavvq7Il4gvHL67uKs28ne7GD3G5HYMGRVprgm4dYsgrnTngsGkg5Q60mO3k7IJfW3OOCcDbLtD3fC9KSeJSSUpatLdsqheQ+hwicTTNFEXC8ymmbmWfoTOhVB3vJLvBrgjRINFwRHxToHILQTESnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147387; c=relaxed/simple;
	bh=d0njfA85QrmA5pF6QKTksNDKH1pAKNYNW+bwDhYQxT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t43OEHDPgvT5jedGJRt6CHVF2DAUkFG0tCKYutEmnfVlzfKfaX4Qzsw/UqmgP3sYmNuXTx1T7XjGfa0nc/Mtuasa5OU/qqZhCXYepydIA2tudfPq9vuhqKbZcERLvbcAVg2QCbNL4d+vUU8dOy0rwDYt34cusWF9o8KgUNqyyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j/7sbZR3; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724147381; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NJsMChbPBN7mMZhuJpQhE2p+c0ZuMVKGW4qyVg+x7+o=;
	b=j/7sbZR3D1si/vXFCeKxCoVSLFVfvBNA97eqhUGrqTpLJbqnHSBYjA8UwUgr7qMuTTq7BwNlP8lnKjgNTnEDMPiOW9rGgE9/34z5aaLIEvuJ8LXWegFpcCBwQgAbaWJuV8VQmkGThdLlLeWzHqBtbeWZdAECKZU6QAV14xni/54=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDILeC9_1724147380)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 17:49:41 +0800
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
Subject: [PATCH v2 1/5] mm: khugepaged: expand the is_refcount_suitable() to support file folios
Date: Tue, 20 Aug 2024 17:49:13 +0800
Message-Id: <eae4cb3195ebbb654bfb7967cb7261d4e4e7c7fa.1724140601.git.baolin.wang@linux.alibaba.com>
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

Expand the is_refcount_suitable() to support reference checks for file folios,
as preparation for supporting shmem mTHP collapse.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cdd1d8655a76..76f05215ee87 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -546,12 +546,14 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 
 static bool is_refcount_suitable(struct folio *folio)
 {
-	int expected_refcount;
+	int expected_refcount = folio_mapcount(folio);
 
-	expected_refcount = folio_mapcount(folio);
-	if (folio_test_swapcache(folio))
+	if (!folio_test_anon(folio) || folio_test_swapcache(folio))
 		expected_refcount += folio_nr_pages(folio);
 
+	if (folio_test_private(folio))
+		expected_refcount++;
+
 	return folio_ref_count(folio) == expected_refcount;
 }
 
@@ -2285,8 +2287,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
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


