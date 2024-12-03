Return-Path: <linux-kernel+bounces-428608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B839E1153
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A3EB23E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E452F9E;
	Tue,  3 Dec 2024 02:32:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3A538DDB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193143; cv=none; b=nTMVwxiCdP/aqzK794WVz3fD/MBt9gGaDEq9UlVcU/QC0LLh2DgkfTHXoBH0qPfynjS9BYtRwwK5e1OE8D3vaK6nmlX+iIL65dVpPgtiW4LUmEHUk97JmIAtYI4zS2PlX75wAObsZtaeGh+b4a4e+v23/SbaKFrnwl3LWXlraDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193143; c=relaxed/simple;
	bh=eir4lIbfKpbWRO9ZHD+STWyrYC0r1WzM1Sjaj8Mrx6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W5w2g6oarL1pKXcPdAtH1skBPfh/l3hdhbwqvd0j/ADqfk1SqZidonxdTNbmHGGyJY5lfM4QK2YEecMzIIzP0s4H7Mt8eI6b3OkwRHDK4PiHlXrWai1tuMdYtc/9ayTZi+ifdjNlT8vbKOIc7Zk0o6IQW/wzX7qm9omX2eYmq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63C1FFEC;
	Mon,  2 Dec 2024 18:32:46 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.48.101])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C1B13F71E;
	Mon,  2 Dec 2024 18:32:15 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/hugetlb: Make __NR_USED_SUBPAGE check conditional
Date: Tue,  3 Dec 2024 08:02:07 +0530
Message-Id: <20241203023207.123416-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HugeTLB order check against __NR_USED_SUBPAGE is required only when
HUGETLB_PAGE_OPTIMIZE_VMEMMAP is enabled. Hence BUG_ON() trigger should
happen only when applicable.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.13-rc1

Changes in V2:

- Fixed #ifdef with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP per Oscar

Changes in V1:

https://lore.kernel.org/all/20241202090728.78935-1-anshuman.khandual@arm.com/

 mm/hugetlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea2ed8e301ef..e6a5b21e3578 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4513,11 +4513,13 @@ void __init hugetlb_add_hstate(unsigned int order)
 	struct hstate *h;
 	unsigned long i;
 
-	if (size_to_hstate(PAGE_SIZE << order)) {
+	if (size_to_hstate(PAGE_SIZE << order))
 		return;
-	}
+
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
+#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
+#endif
 	h = &hstates[hugetlb_max_hstate++];
 	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
-- 
2.30.2


