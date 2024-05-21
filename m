Return-Path: <linux-kernel+bounces-184850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A928CAD05
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8525CB226B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA5E762F7;
	Tue, 21 May 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oVY+upUy"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB62612EB
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289423; cv=none; b=Wzb9fNTbJHeK1q3fsP5/mh6V7ioi8AJi/yJtSWslJM48px9BjOL/Il3dqEaCuKcRE7ds6X9DEjzbNeo2KRLGM5ffPfjyCEnG8txOJfsUNf/LkHI+jFpdojAvBqzGIZhCUinHce3EsgwBCAFyGU6ONtCJkWofdqi6sVoQ88YlCn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289423; c=relaxed/simple;
	bh=QktWnmZza0+8gvOpDIgJiQ9JxnbnzLBik8mUH7+XnKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRl3RX6E0KvV8m5l3/gWwYrGw6ERdxaxqMsducs3IMsuI3ywj+Qeu5ieJQvInOSuaMm4vV0+IcO/fHkH3W9/HjEyG4KZLy+v93w+BbLKJUkXuKkUrX4wsPKHjz+t4LA6K6m0VBU+MMgGRI1uhTnxmtOBgOqbZAs7BkfKglsnIzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oVY+upUy; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716289419; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eLWM5LDYn4qmAcvClqJJz7Ry6ODVE2l8ecGnrwuiQN0=;
	b=oVY+upUyau3AQlXbvwgwJy9gBbrTKIB2NAPxsZlcumizQeO0ndU8eaqP9jB7AlXnTaLq8n1TFWXbA0y4ezsBb0BnZw0xAat0wdSTXX5eHwWeGlQGzdBxehKlA2v0SRDpqZhLOG93CSVGys6ziT/166ghuf8Z6WcD3acwgLqVjFU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W6xeTDd_1716289416;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6xeTDd_1716289416)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 19:03:37 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	hrisl@kernel.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/8] mm: shmem: extend shmem_partial_swap_usage() to support large folio swap
Date: Tue, 21 May 2024 19:03:15 +0800
Message-Id: <e0009cd7362f64da08aea5883e753192e137da39.1716285099.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
References: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
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
index 74821a7031b8..bc099e8b9952 100644
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


