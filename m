Return-Path: <linux-kernel+bounces-258398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFEC938779
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4124E280CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 02:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2681C8FE;
	Mon, 22 Jul 2024 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="rUugE5tP"
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0239D8BFC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721614373; cv=none; b=BpZMfiQMzXnxLPrZJYu5+7PNM6b7jQ25gW/XatH4GMe2F+1xEnfG5LxM3GFsciLizHzVNSZ/4bOlOSDHQ34rb6blkwh9APTv6JiYOHr4Ua49nhPMzY/9m0sZUgBysCzlin6jx4z+wySq/20WFztV7JRz/MGgOwM8vibrpcwSMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721614373; c=relaxed/simple;
	bh=I5DMe3EnS7G1j/NeL0/4/YwmynXJRTUqok3lFtFxT7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=retlI/JX10J7AqKZ5+eEPRwBc8xejrpspyululqnLZosK/5hVCjYeaHrara+PrOnGYxssINxXYfzYGQZs0HHb44qp1ltaMQBP6XntyPB6ywd7rZtngbeDWJG/Ff9cLsbDYs6i/wcnyiJJw95zQdVZ+TOHv2zF8fcI1fIplkZa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=rUugE5tP; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1721614369; x=1753150369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I5DMe3EnS7G1j/NeL0/4/YwmynXJRTUqok3lFtFxT7s=;
  b=rUugE5tPPdI7x0RZzx7dwnOgU4cNA+KcHHX3E9iwPRTf8h2eyC2pyxIF
   H/ECRBk1CdhqnB8HS9PepVj6/LoyhNiwuUwiC+Ic8ZRic9jN9HltLyV5L
   9t64/iAWThb/r8uqSnONRUFd8xQb8vZ0RNdKUgJLQ94Q63bfkarHVfSSw
   cWxGWG1Vf4SJMp1+duP/2wo6Q0zAUIRU2UFmPJ/LPaEkZjdxquOs1CKks
   pneSgGWt8OmPBWthScXv7TVtDdLAA2Xk6DA06QkA1oZN2xrJEILQ252ZS
   OK9juKICFJPEfDcN5JPAD10lUwFH3DX7853CLOf9raUL5PEqj4dVm5Ejv
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="168168824"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; 
   d="scan'208";a="168168824"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 11:11:21 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 46DD3D800F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:11:19 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8E4C3D7494
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:11:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2F28A2007CAB2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:11:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 57B821A000B;
	Mon, 22 Jul 2024 10:11:17 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Yasunori Gotou <y-goto@fujitsu.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2] mm/page_alloc: Fix pcp->count race between drain_pages_zone() vs __rmqueue_pcplist()
Date: Mon, 22 Jul 2024 10:10:59 +0800
Message-Id: <20240722021059.1076399-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.004
X-TMASE-Result: 10--5.996900-10.000000
X-TMASE-MatchedRID: +R0/YEDHEDjoSitJVour/QuB7zdAMUjAl9q75JzWJRMarX6LchMkVuBw
	lzWEEXt2fatVQLA534yNMkq6FfSn6lnGEjlsas2yFDuTLTe6zcNMkOX0UoduuV7V7de6UnlgmKb
	hu5KaCkf9F5gpB/8TUo2MogdbmQhJWSEm/dnndoSdVNZaI2n6//SzAdIVxUno2vch1fMqmI8mIm
	l+ywrqvklEFjVj/aAsbncztPPsTqsv+0FNnM7lDRVqL8+WwS7muhv94WF6cmmm04TWLzKiuBhBv
	WgZlX+84vM1YF6AJbbCCfuIMF6xLSAHAopEd76vdp8SlsBStysjUE3BmlSs165ZdugdSt2/9b4c
	9nQDp+sRP1XlvFsUag==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

It's expected that no page should be left in pcp_list after calling
zone_pcp_disable() in offline_pages(). Previously, it's observed that
offline_pages() gets stuck [1] due to some pages remaining in pcp_list.

Cause:
There is a race condition between drain_pages_zone() and __rmqueue_pcplist()
involving the pcp->count variable. See below scenario:

         CPU0                              CPU1
    ----------------                    ---------------
                                      spin_lock(&pcp->lock);
                                      __rmqueue_pcplist() {
zone_pcp_disable() {
                                        /* list is empty */
                                        if (list_empty(list)) {
                                          /* add pages to pcp_list */
                                          alloced = rmqueue_bulk()
  mutex_lock(&pcp_batch_high_lock)
  ...
  __drain_all_pages() {
    drain_pages_zone() {
      /* read pcp->count, it's 0 here */
      count = READ_ONCE(pcp->count)
      /* 0 means nothing to drain */
                                          /* update pcp->count */
                                          pcp->count += alloced << order;
      ...
                                      ...
                                      spin_unlock(&pcp->lock);

In this case, after calling zone_pcp_disable() though, there are still some
pages in pcp_list. And these pages in pcp_list are neither movable nor
isolated, offline_pages() gets stuck as a result.

Solution:
Expand the scope of the pcp->lock to also protect pcp->count in
drain_pages_zone(), to ensure no pages are left in the pcp list after
zone_pcp_disable()

[1] https://lore.kernel.org/linux-mm/6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com/

Cc: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reported-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
    - Narrow down the scope of the spin_lock() to limit the draining latency. # Vlastimil and David
    - In above scenario, it's sufficient to read pcp->count once with lock held, and it fully fixed
      my issue[1] in thounds runs(It happened in more than 5% before).
RFC:
    https://lore.kernel.org/linux-mm/20240716073929.843277-1-lizhijian@fujitsu.com/
---
 mm/page_alloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecf99190ea2..5388a35c4e9c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2323,8 +2323,11 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	int count = READ_ONCE(pcp->count);
+	int count;
 
+	spin_lock(&pcp->lock);
+	count = pcp->count;
+	spin_unlock(&pcp->lock);
 	while (count) {
 		int to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
 		count -= to_drain;
-- 
2.29.2


