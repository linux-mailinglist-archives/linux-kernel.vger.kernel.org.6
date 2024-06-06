Return-Path: <linux-kernel+bounces-204218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6CA8FE5F2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271791F24F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0DA195F10;
	Thu,  6 Jun 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xM+MAmJZ"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923E19597D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675160; cv=none; b=jbs91EqszfVMepWiFl7bR86xbWSCsT4x/ZaqR+oiQlzI8RIXxmQjJMCBWJePdzcvVyAlZbQfKNiKrEsA1nxyvNKGd38cGOUNYm1qoitac5G6zwpzpab1MPMC/qNSODaAdD7KwQWHKl8AWke657Gtq8CvZE/vRoVtXEWfuy8qLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675160; c=relaxed/simple;
	bh=mqoKQ1GfEhJx0cp42B5Os63IdbIrLevXHR83MBqrQO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+ihKo+amiV4zlRxrq/95W1qN7ZqViOKfOdPBbQHai2gYewQD4TSK6n4FJcsGjc6Sra5XOp2Z/dpOoUrRZm+2fwZqjXkAB6ChdmBs0StUBsjHvSVCtdQrB8m7CPNipCXBDEpUyPdqVqjKngh0/bF2IG6RXCwIVB+CMhcYC6wOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xM+MAmJZ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717675156; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Hca3mk3oMk8MShvCe5e0YS4gCuYYhtWQR6R7w3SOo+g=;
	b=xM+MAmJZd/2MaO81nJ5EfVwaYed064+ao9HZyGpPISym6h0Qh+J8hEaUYpqteCDhE5D6IKq7cCxVz6Ip8aKzQVbcBu21NJIYqVcsGAxd9iMr6L19vE06garvORzou1fR2y5O757O5r0sOOHqiDsqYdhM7bKMp1PFvE7ULlH6ZJg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W7y5mvU_1717675154;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7y5mvU_1717675154)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 19:59:15 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	chrisl@kernel.org,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mm: shmem: extend shmem_partial_swap_usage() to support large folio swap
Date: Thu,  6 Jun 2024 19:58:54 +0800
Message-Id: <358924679107339e6b17a5d8b1b2e10ae6306227.1717673614.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support shmem large folio swapout in the following patches, using
xa_get_order() to get the order of the swap entry to calculate the swap
usage of shmem.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index eefdf5c61c04..0ac71580decb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -865,13 +865,16 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 	struct page *page;
 	unsigned long swapped = 0;
 	unsigned long max = end - 1;
+	int order;
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, max) {
 		if (xas_retry(&xas, page))
 			continue;
-		if (xa_is_value(page))
-			swapped++;
+		if (xa_is_value(page)) {
+			order = xa_get_order(xas.xa, xas.xa_index);
+			swapped += 1 << order;
+		}
 		if (xas.xa_index == max)
 			break;
 		if (need_resched()) {
-- 
2.39.3


