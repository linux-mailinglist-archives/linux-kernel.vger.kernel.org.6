Return-Path: <linux-kernel+bounces-268539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AC89425F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5F31F24F39
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BA4AEF2;
	Wed, 31 Jul 2024 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cQp/DjBP"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80009946F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404798; cv=none; b=mqKzu43st91PCa2bBt88U4+8rRV1LGnH5x1vEbaSO/FAzXhK31WCeQunxfKvnMWzKYXEcnLmSD1I1HwjX8SwPdYzR4YJY3qWMDlJQM7odaTFRgS4fi2O9dUY1IhmRhlluVM8Hvc6Kw9FWD0dlFfObkP61ynrmuwzoRm83366s4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404798; c=relaxed/simple;
	bh=FwkX38mXVmILmfP8iUwslb6aUkBdj5+2csrZOpDJKUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f57QZEr3tkqqIuKqtqNEBp5RE62er23yxmw6izbLjR/FIDkXz4yYAa1OqEnunyggYj5lZQrFZi1PCIRj7AeBWMBCIulvA6G4WqExCZsHhqFyQXZttZvskURWw2xQh35JaYFrPgnv8p+K8nyFzQkTc1iMsF02o5emSD3XkM+ZIV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cQp/DjBP; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722404793; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=w2Q2qCZXQEBR41lpW2VH/vq7C6rQUymGzd3eTc4T0Kk=;
	b=cQp/DjBPrEnib6PjjiZKrLzpelHJMjMmW86WTVB784P0IzfzBKQSra+MWAFr/uHB93ykRNeWRG8WmoDlvu10qQqXioJqabBd+f9+H/0Oq8z/qJgVEmJJcpBZ5nnLBgwIo52r63LXPuFQuYSP8/lG8q4n2939y2VdOpu3Gf73r14=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WBi1RC6_1722404792;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBi1RC6_1722404792)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 13:46:32 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	gshan@redhat.com,
	ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: shmem: fix incorrect aligned index when checking conflicts
Date: Wed, 31 Jul 2024 13:46:20 +0800
Message-Id: <07433b0f16a152bffb8cee34934a5c040e8e2ad6.1722404078.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the shmem_suitable_orders() function, xa_find() is used to check for
conflicts in the pagecache to select suitable huge orders. However, when
checking each huge order in every loop, the aligned index is calculated
from the previous iteration, which may cause suitable huge orders to be
missed.

We should use the original index each time in the loop to calculate a
new aligned index for checking conflicts to avoid this issue.

Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a4332a97558c..6e9836b1bd1d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1686,6 +1686,7 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
 					   unsigned long orders)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	pgoff_t aligned_index;
 	unsigned long pages;
 	int order;
 
@@ -1697,9 +1698,9 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
 	order = highest_order(orders);
 	while (orders) {
 		pages = 1UL << order;
-		index = round_down(index, pages);
-		if (!xa_find(&mapping->i_pages, &index,
-			     index + pages - 1, XA_PRESENT))
+		aligned_index = round_down(index, pages);
+		if (!xa_find(&mapping->i_pages, &aligned_index,
+			     aligned_index + pages - 1, XA_PRESENT))
 			break;
 		order = next_order(&orders, order);
 	}
-- 
2.39.3


