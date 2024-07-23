Return-Path: <linux-kernel+bounces-259648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE22939A94
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3931F216EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1926814C587;
	Tue, 23 Jul 2024 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="oQxElb5c"
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61214C585
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717098; cv=none; b=DYlpvVP1Vwfp35Ormo07M49l33xqW62eUiMOoz+Hq5DPE6HfUgKXpMvJxACmsFAnWycNyqBUM7MibpfyTslZa7m6hIa+aD+NzSoD/SHQZOco5PS+GZfdWQH/2Cb4ev5nKfk9Uyv2kiA9qsHl7ilm89rsqbkpALhtA9oceHawZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717098; c=relaxed/simple;
	bh=Wj9f5tB2mEdbYVYaWt84WmCS/rsQK08PH2985ou0wZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jOtsylNz51OLydKrdGNJg76rO0we7NhujWR3snPxUheRrwLX7qVdxxxv8VVALusRG0gX8MFSklY6YeK/FU7o6U8Of2OGjJgPVWp6WZpAsJcSpNn4PkZdX8PsiiUHh+c9U8yx/Ocv25iE8Lk4xhb0Z2kyDRnqWy2SfhpPxDDdyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=oQxElb5c; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1721717095; x=1753253095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wj9f5tB2mEdbYVYaWt84WmCS/rsQK08PH2985ou0wZc=;
  b=oQxElb5cb8qqvQsCFFQL+lAkBnBxNF7spaWCMbEAJHfczxk3F+rAIb61
   QhTsA6QPK+6XAEhxc6FpZgYUIaps0XdYEIqr2VfjkTTsw2+TPcABcUK2Y
   2ZeGQ9+Su7XCNr/Y0kjP4J+lcEsh3Okb7sOYBE2L+LVGkAAK8aQfkaw1u
   frmwGU65f9u2lb6zdoR6IBo02nDchqhn2ZXb1yMRsyPiVL0y8/LZCosGV
   6bfUjUqM/SKJA+QfXUKwpSo8xURAbYJGYlq7CY02lSzdCIqCi9yPDTY74
   bQJBmXCxqzzH14QkWsHgMfJr53yaK0Q2B5mtBVl/u8abpJ7gCHyuxaOt7
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="167438707"
X-IronPort-AV: E=Sophos;i="6.09,230,1716217200"; 
   d="scan'208";a="167438707"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 15:44:46 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A0A59C68E9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:44:43 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id EC5EAD9730
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:44:42 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7A3542007CDDA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:44:42 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 856DF1A000A;
	Tue, 23 Jul 2024 14:44:40 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Yasunori Gotou <y-goto@fujitsu.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v3] mm/page_alloc: Fix pcp->count race between drain_pages_zone() vs __rmqueue_pcplist()
Date: Tue, 23 Jul 2024 14:44:28 +0800
Message-Id: <20240723064428.1179519-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28546.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28546.005
X-TMASE-Result: 10--5.765100-10.000000
X-TMASE-MatchedRID: WyUGENwRfafoSitJVour/QuB7zdAMUjAl9q75JzWJRMarX6LchMkVuBw
	lzWEEXt2fatVQLA534yNMkq6FfSn6lnGEjlsas2yFDuTLTe6zcNMkOX0UoduuV7V7de6UnlgmKb
	hu5KaCkf9F5gpB/8TUo2MogdbmQhJWSEm/dnndoSdVNZaI2n6//SzAdIVxUno2vch1fMqmI8mIm
	l+ywrqvklEFjVj/aAsbncztPPsTqsv+0FNnM7lDRVqL8+WwS7muhv94WF6cmlQWIO4YO+fPSsoE
	Tq1uNbxoa8IWqgpLBOAMuqetGVetnyef22ep6XYOwBXM346/+yq6ihSMQjFT/u99Mh5IiWaer/4
	kvMjwQ8/NgRatoZopQ8W4Xlk8M63
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
V3:
    Read pcp->count in the loop with lock held to prevent unnecessary spin_lock() wasteful
V2:
    - Narrow down the scope of the spin_lock() to limit the draining latency. # Vlastimil and David
    - In above scenario, it's sufficient to read pcp->count once with lock held, and it fully fixed
      my issue[1] in thounds runs(It happened in more than 5% before).
RFC:
    https://lore.kernel.org/linux-mm/20240716073929.843277-1-lizhijian@fujitsu.com/
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 mm/page_alloc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecf99190ea2..a32289ec4768 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2323,16 +2323,20 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	int count = READ_ONCE(pcp->count);
-
-	while (count) {
-		int to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
-		count -= to_drain;
+	int count;
 
+	do {
 		spin_lock(&pcp->lock);
-		free_pcppages_bulk(zone, to_drain, pcp, 0);
+		count = pcp->count;
+		if (count) {
+			int to_drain = min(count,
+				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
+
+			free_pcppages_bulk(zone, to_drain, pcp, 0);
+			count -= to_drain;
+		}
 		spin_unlock(&pcp->lock);
-	}
+	} while (count);
 }
 
 /*
-- 
2.29.2


