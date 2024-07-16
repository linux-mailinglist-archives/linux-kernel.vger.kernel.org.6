Return-Path: <linux-kernel+bounces-253439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC293215B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC6B281988
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A63535894;
	Tue, 16 Jul 2024 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="rIix81oQ"
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684EE2C87A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115596; cv=none; b=TbDK/RjK38ZWDebDobKmCoLWIoWzWSB3y2PU3uGMg4bFwJCOcLsxis9adZMLYEv2Xd58c12XQV4W1kGE4kGJ1H47ZyuAGqNiP0N+jxyD2qZCs5ONwx5L4DQ3V+OZH8nGHGvjMU3pFgX9YYtZmXA7Uu/BrhAD+THKxuLR/NI+AWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115596; c=relaxed/simple;
	bh=s+9Rl57a7W4/9RlX3hiG87VGeDH/NTrRc8NssiUoEwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cIKuENeMJLrAAtLbMwFYyiwsH96B1OwnKaO2Jobr9VMcZQtzlCyQAWN7NDunyctDyj6P0aDBRysvN3tQYTLmItpSNwm66eIukOr9DD98crgA80B3tjXUQkQiqXOIXStF88/VE5p9QcyAerw2lgzEkJJj/Wxhdq9mRtBKkmiEGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=rIix81oQ; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1721115593; x=1752651593;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s+9Rl57a7W4/9RlX3hiG87VGeDH/NTrRc8NssiUoEwg=;
  b=rIix81oQ4yw9tDc6th9tHy8IR/rnuJqGiCL1d6tD6NePa1lJ7Cx+I7CC
   RR0rMN6C/rfAyeLTjzcztorjj9m5OsOn1dkQhT0cckND8gV4fTRPTgKyA
   OdrsrebKu9KlWovW5532svULdviD5vNUHXSbtybVqButa6DFZZLYd1UOx
   0H399adgrYtwXmVRCB5FOtG/qHdPh3mAdN6Q6yCEWZu5UdRH9f5ak9PZs
   Bf02r99a+TWM7uTx/nXcEGEEmFvjO7Uehm6fO2W2Wrz8vj7aMxn1ltKwJ
   4dehooE+nAENDTpGIfKfjAgFg9wNcbRf3N+tgtdnPgFJKPfKq7rTNmZxd
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="166580228"
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="166580228"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 16:39:50 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 28F17C68E9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:39:48 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5BFDCCF7C9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:39:47 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C30282007955A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:39:46 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1AD4C1A000A;
	Tue, 16 Jul 2024 15:39:46 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Yasunori Gotou <y-goto@fujitsu.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	David Hildenbrand <david@redhat.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH RFC] mm/page_alloc: Fix pcp->count race between drain_pages_zone() vs __rmqueue_pcplist()
Date: Tue, 16 Jul 2024 15:39:29 +0800
Message-Id: <20240716073929.843277-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28532.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28532.005
X-TMASE-Result: 10--4.198100-10.000000
X-TMASE-MatchedRID: B4VcMIpPJ83oSitJVour/QuB7zdAMUjAl9q75JzWJRMarX6LchMkVuBw
	lzWEEXt2fatVQLA534yNMkq6FfSn6lnGEjlsas2yFDuTLTe6zcNMkOX0UoduuV7V7de6UnlgmKb
	hu5KaCkf9F5gpB/8TUo2MogdbmQhJWSEm/dnndoSdVNZaI2n6//SzAdIVxUnokMdDYxplfPi/BR
	68O365bhgeO7R/+wS3W8g/f7Yw4FCHx1sV2zgpgc36paW7ZnForzl8sNiWClKbKItl61J/yZ+in
	TK0bC9eKrauXd3MZDX9avo0zESw3V6aooxRi5dzqF0CXPWkCBugC5BwAq72xrV3O7TAoGSkLz9R
	mHSjoMlpgPDAjKIRuK/vz2MGbG5zjnaxM7NpKpE1f8nIp20B8BXFEH92Kf64nTtPxlIuIBW9Hzj
	86YHXBCnifx5AGfCL
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
drain_pages_zone(), ensuring no pages are left in the pcp list.

[1] https://lore.kernel.org/linux-mm/6a07125f-e720-404c-b2f9-e55f3f166e85@fujitsu.com/

Cc: David Hildenbrand <david@redhat.com>
Reported-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 mm/page_alloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecf99190ea2..1780df31d5f5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2323,16 +2323,17 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	int count = READ_ONCE(pcp->count);
+	int count;
 
+	spin_lock(&pcp->lock);
+	count = pcp->count;
 	while (count) {
 		int to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
 		count -= to_drain;
 
-		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-		spin_unlock(&pcp->lock);
 	}
+	spin_unlock(&pcp->lock);
 }
 
 /*
-- 
2.29.2


