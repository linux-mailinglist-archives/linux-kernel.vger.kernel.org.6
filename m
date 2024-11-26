Return-Path: <linux-kernel+bounces-422482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD99D9D9A29
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F572832D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F061D63C1;
	Tue, 26 Nov 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4SVtbVO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C361D61BB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633586; cv=none; b=s6td+4tGoSom+VdIU81pTqrthwag/9o5hFuUw3NfGcqRMklxoBXzQZGjNRK00quKr8pX3dxW3EeEYMqkhq50jMKmD6M1Z42b54NiV/Nif3dY/TvdU5pqyiy7LBjMI41Y/dYqd2N9RiTnpTnFC7sD437qgx9/aYER6aJRt2IIN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633586; c=relaxed/simple;
	bh=ehLuUdS4SLOrCgvmAb9TDza9lD6vN7Opo54S0M6wZ+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGv1MKIcHTkotTsV8FVArrds8D/kmjbYOHD2Qxg4tu0izr0q/EDJNR9YrKqQgfRkW39xMimQFWN+M3O6Ywo+Bd126y+/lPUed7M94ZLvuODU0R2fz7zk4mhvSrAKQ5uOahkJc3htxSa+zF3wJuk24LHPaD+DryxL2l7bzkJLGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4SVtbVO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732633583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aWtzZaH0bLct3rhvon/rPVAtnCGovq5FTEt4jgcwO18=;
	b=J4SVtbVOMWqOG0m+t6zr8CGHco5sLIOF6FgkMWXynb9fOtdEwX/V9ip4Dd7PdukAe1HOCZ
	4xUPERe6+PeELptGYzvfXCPuDdF/SqNpoLR5Lfhh5wEPzxIK3K0pkPmu/hpBl401krcpOr
	wTAJSLmtjBD1yrWpUETyWkpj4JM+2DU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-igZIsYMENM6pU3lOFbNPrg-1; Tue,
 26 Nov 2024 10:06:19 -0500
X-MC-Unique: igZIsYMENM6pU3lOFbNPrg-1
X-Mimecast-MFC-AGG-ID: igZIsYMENM6pU3lOFbNPrg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3F471955F45;
	Tue, 26 Nov 2024 15:06:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEFA7196BC05;
	Tue, 26 Nov 2024 15:06:16 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	snishika@redhat.com
Subject: [PATCH] mm: vmscan: ensure kswapd is woken up if the wait queue is active
Date: Wed, 27 Nov 2024 00:06:12 +0900
Message-ID: <20241126150612.114561-1-snishika@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Even after commit 501b26510ae3 ("vmstat: allow_direct_reclaim should use
zone_page_state_snapshot"), a task may remain indefinitely stuck in
throttle_direct_reclaim() while holding mm->rwsem.

__alloc_pages_nodemask
 try_to_free_pages
  throttle_direct_reclaim

This can cause numerous other tasks to wait on the same rwsem, leading
to severe system hangups:

[1088963.358712] INFO: task python3:1670971 blocked for more than 120 seconds.
[1088963.365653]       Tainted: G           OE     -------- -  - 4.18.0-553.el8_10.aarch64 #1
[1088963.373887] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1088963.381862] task:python3         state:D stack:0     pid:1670971 ppid:1667117 flags:0x00800080
[1088963.381869] Call trace:
[1088963.381872]  __switch_to+0xd0/0x120
[1088963.381877]  __schedule+0x340/0xac8
[1088963.381881]  schedule+0x68/0x118
[1088963.381886]  rwsem_down_read_slowpath+0x2d4/0x4b8

The issue arises when allow_direct_reclaim(pgdat) returns false,
preventing progress even when the pgdat->pfmemalloc_wait wait queue is
empty. Despite the wait queue being empty, the condition,
allow_direct_reclaim(pgdat), may still be returning false, causing it to
continue looping.

In some cases, reclaimable pages exist (zone_reclaimable_pages() returns
 > 0), but calculations of pfmemalloc_reserve and free_pages result in
wmark_ok being false.

And then, despite the pgdat->kswapd_wait queue being non-empty, kswapd
is not woken up, further exacerbating the problem:

crash> px ((struct pglist_data *) 0xffff00817fffe540)->kswapd_highest_zoneidx
$775 = __MAX_NR_ZONES

This patch modifies allow_direct_reclaim() to wake kswapd if the
pgdat->kswapd_wait queue is active, regardless of whether wmark_ok is
true or false. This change ensures kswapd does not miss wake-ups under
high memory pressure, reducing the risk of task stalls in the throttled
reclaim path.

Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76378bc257e3..b1b3e5a116a8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6389,8 +6389,8 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
 
 	wmark_ok = free_pages > pfmemalloc_reserve / 2;
 
-	/* kswapd must be awake if processes are being throttled */
-	if (!wmark_ok && waitqueue_active(&pgdat->kswapd_wait)) {
+	/* Always wake up kswapd if the wait queue is not empty */
+	if (waitqueue_active(&pgdat->kswapd_wait)) {
 		if (READ_ONCE(pgdat->kswapd_highest_zoneidx) > ZONE_NORMAL)
 			WRITE_ONCE(pgdat->kswapd_highest_zoneidx, ZONE_NORMAL);
 
-- 
2.47.0


