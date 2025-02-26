Return-Path: <linux-kernel+bounces-532869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA6A45334
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DDDF17C6D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAE521C9E4;
	Wed, 26 Feb 2025 02:41:43 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9CEAFA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537703; cv=none; b=tFCVqiDn24hIM9x5aVVvqt3LVHItiJ5QwrEyDpAu9Hruewa9s65DsfHeKmXV/XOMKsNPfSzO2hWH5IpBn/bGuWl86nYMDEEMuDAFjD4Q3cqXfJJs5ox280Ui/DOxSdqfdIqZ+Q0pg13o180f5lEqLPkbyS+hcq9WyDZ0ws9JIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537703; c=relaxed/simple;
	bh=o0e2OcaUwM01j9OEyv1ZvdlVzLDYk+wE5jg1VR4e0Ro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T6VibBKcxPpKdPRfrUiNhlEmwvvPWzfHBkTuoEv6TEdccoLNudHtVW2Ao97PN+Cdz1mmPNu0hHNEh+50bH5XM+MCh5gzyhsP+3e1Sijqx/wBQBEDK9s6R73JNGyweHCW1REWkX5sB2q1jplwr23HWq3RocWvQ5GiZ2xTTwRTJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Z2dxb2qzKzYlxGh;
	Wed, 26 Feb 2025 10:40:35 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Feb
 2025 10:41:32 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Feb
 2025 10:41:32 +0800
From: <zhongjinji@honor.com>
To: <akpm@linux-foundation.org>
CC: <yuzhao@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<rientjes@google.com>, <vbabka@suse.cz>, <zhongjinji@honor.com>,
	<yipengxiang@honor.com>, <liulu.liu@honor.com>, <feng.han@honor.com>
Subject: [PATCH] mm/page_alloc: make the maximum number of highatomic pageblocks resizable
Date: Wed, 26 Feb 2025 10:41:25 +0800
Message-ID: <20250226024126.3718-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

From: zhongjinji <zhongjinji@honor.com>

In the past, nr_reserved_highatomic was considered to be part of
unusable_free when there was no ALLOC_RESERVES flag. To prevent
unusable_free from being too large, it is reasonable to set a
fixed maximum highatomic value.

Even if the maximum number of highatomic pageblocks is set to be larger,
unusable_free may not increase, since Yu Zhao provided the modification
about nr_free_highatomic in
https://lore.kernel.org/all/20241028182653.3420139-1-yuzhao@google.com/T/#u

More highatomic pageblocks are beneficial for the successful allocation
of high-order page, which is helpful in some devices. Therefore, use
highatomic_reserve_ratio to adjust the maximum number of highatomic
pageblocks.

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/page_alloc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 579789600a3c..dbdce6a0f694 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -273,6 +273,7 @@ int min_free_kbytes = 1024;
 int user_min_free_kbytes = -1;
 static int watermark_boost_factor __read_mostly = 15000;
 static int watermark_scale_factor = 10;
+static int highatomic_reserve_ratio = 10;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
 int movable_zone;
@@ -2046,7 +2047,8 @@ static void reserve_highatomic_pageblock(struct page *page, int order,
 	 */
 	if ((zone_managed_pages(zone) / 100) < pageblock_nr_pages)
 		return;
-	max_managed = ALIGN((zone_managed_pages(zone) / 100), pageblock_nr_pages);
+	max_managed = ALIGN((zone_managed_pages(zone) * highatomic_reserve_ratio / 1000),
+		      pageblock_nr_pages);
 	if (zone->nr_reserved_highatomic >= max_managed)
 		return;
 
@@ -6199,6 +6201,13 @@ static const struct ctl_table page_alloc_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= percpu_pagelist_high_fraction_sysctl_handler,
 		.extra1		= SYSCTL_ZERO,
+	},
+		.procname	= "highatomic_reserve_ratio",
+		.data		= &highatomic_reserve_ratio,
+		.maxlen		= sizeof(highatomic_reserve_ratio),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "lowmem_reserve_ratio",
-- 
2.17.1


