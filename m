Return-Path: <linux-kernel+bounces-293694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2F1958330
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99642B2398A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7E818CBF2;
	Tue, 20 Aug 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RWmL/4ZY"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D818991B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147394; cv=none; b=sG3GN4KYmu5lvhnLGq7mPCE9mJBTY7IWbUG9eyHRTIXkt2E88Ia6zVc6zaXVXeNoe+o3IV3EHJW2iPdKyORWElIxsTUscYXPfwlAyUJrfsbJNF/kiq3dlnjmD3GECmbmUiebO/h3DtBb4DQto9Dja/170WIi65IYIJsTZcl/n3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147394; c=relaxed/simple;
	bh=mYp6Nso68Hk+a6iQZU3RiFpMzs2dIZuukt7NzYfLRB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVi7ql5S+1yYOb2o1fjqAL7aqfgWEyuMEFjVmORi+fwj6Oq0B6zxBMhfotO567rEde83SL+ldvPuoiewncYzyDEyCsyjXeYMSMRaUsl0tMseyU+8R0fCmTFwBq7XLs9C9wMn9DaKmlBT/c3iT0UTqSxg8yTwXTxXrre8qr77b+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RWmL/4ZY; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724147384; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0UzIUq6FZARxgmMF/NPpanXZh/m/Lu7W5+1J/nDWXrI=;
	b=RWmL/4ZYqLu4isjVJqF065APyI1B4CaYn8dLMNrtRGAgX3aPdxj/78ecjeJxkd7hU8f9vAJq8oqDoMJ2AE7P5+uPFg6xqT0BTPaocAw3k+VK/1zfJPkHqKgAmUYPtfq8rSNO3EK0NZmwhHY6i1pehEI5xkVqoW62W4E4h7/lmoU=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDIEwjB_1724147382)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 17:49:43 +0800
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
Subject: [PATCH v2 3/5] mm: khugepaged: support shmem mTHP copy
Date: Tue, 20 Aug 2024 17:49:15 +0800
Message-Id: <222d615b7c837eabb47a238126c5fdeff8aa5283.1724140601.git.baolin.wang@linux.alibaba.com>
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

Iterate each subpage in the large folio to copy, as preparation for supporting
shmem mTHP collapse.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e015c94eba09..4996f7487c13 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2056,17 +2056,22 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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


