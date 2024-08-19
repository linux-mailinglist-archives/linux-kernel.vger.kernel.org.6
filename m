Return-Path: <linux-kernel+bounces-291667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A681956558
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401D11F228C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A115ADA4;
	Mon, 19 Aug 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qVbW7OTO"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427715B560
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055300; cv=none; b=mdDArIKzB2zzbZyGc7bSDWysGqzoXxdJE4MoJAZ6zsNdvGRYs79u3UVIkO2jDJwlYJhQP+G/xU2NnK4j+r9A0/tzdiiy8FQylL1q7TsaDOWnRV/iPPIDiAKle2PpJFj52dGxM48ohaP3XDJqVivp4f1vMdTFE1FzyV/YMfy+9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055300; c=relaxed/simple;
	bh=D4D96CGvyIdDn9IdkVMBDqkPKSa5YgZh94Mj5skAncA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPF9gG7RwfcOanaTqIzY0c00ijpZYw8J1YoaQjzXp9DDkJEMBzDTrG6YdzsQQcwmlXK4xPcWs3/ocVaO9zwr1YThLsAmcbQELhd1v1PSLn7wrP3xaboIkaojgAPoq5+CmkmKgaZDbJUbOw9iQQlY2RNlC/gpTwbSp32iYwNVguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qVbW7OTO; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724055288; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xzFqhooDuGLHWOHvpjrYWo9DgZTyuxAAfwMQUt6kp8M=;
	b=qVbW7OTOmn2qGCUgqsHihyb8RKG3K3ipQjiTJ+Ao3uBuKP0An+MGd6d12a7ru68F7nDhhcDPqLEs5TSfaRv6sXVU/nplHBBmbpbBMfAf9BmSZQ4+oKLJmoNFu71zMtGr2PfU9AiF26GBl8B3Br3DcnnglBwukeCxRVoPG6cnekc=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WD9CrIU_1724055287)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 16:14:48 +0800
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
Subject: [PATCH 3/5] mm: khugepaged: support shmem mTHP copy
Date: Mon, 19 Aug 2024 16:14:04 +0800
Message-Id: <938e8cc5a15f841fdd343d324d8a6dd989cd52e0.1724054125.git.baolin.wang@linux.alibaba.com>
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

Iterate each subpage in the large folio to copy, as preparation for supporting
shmem mTHP collapse.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 60d95f08610c..91ee672db202 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2060,17 +2060,22 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	index = start;
 	dst = folio_page(new_folio, 0);
 	list_for_each_entry(folio, &pagelist, lru) {
+		int i, nr_pages = folio_nr_pages(folio);
+
 		while (index < folio->index) {
 			clear_highpage(dst);
 			index++;
 			dst++;
 		}
-		if (copy_mc_highpage(dst, folio_page(folio, 0)) > 0) {
-			result = SCAN_COPY_MC;
-			goto rollback;
+
+		for (i = 0; i < nr_pages; i++) {
+			if (copy_mc_highpage(dst, folio_page(folio, i)) > 0) {
+				result = SCAN_COPY_MC;
+				goto rollback;
+			}
+			index++;
+			dst++;
 		}
-		index++;
-		dst++;
 	}
 	while (index < end) {
 		clear_highpage(dst);
-- 
2.39.3


