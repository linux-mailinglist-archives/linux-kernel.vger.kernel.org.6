Return-Path: <linux-kernel+bounces-203809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977DA8FE0B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B08B282F29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0C13A27D;
	Thu,  6 Jun 2024 08:15:17 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56574424
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661717; cv=none; b=mpLyWIG76wlA1d+PlkDeT1uogj78Xr0WKWdBuK5lo8UO09AjH4RWhKHsXAWj/eVkxt2BYSNRHKZ3HsqLHLWC40jhhuLit6pLC2/kAKX/5yGwirJFv6VQbA6X6kVrL3g+XnJS8ZvNtacn9PTdjYT6KqBWKDKR46Tk5VCUJsDgrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661717; c=relaxed/simple;
	bh=DPpCf9RW0VfwdioRV0pbbI3X3jYT9zFCLkJylGWE0XE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rgChHN1Wg+ZP5xCFnEORwqBlk2N6YiBttLQV/jgfsUqQuNC4eS29q22EohOwDHkW7lFKugU6cJSBLPfzVSdmi32N6Sf6tpJqxyf4d8AuWArf6pMdpbnh4RQtwGjeoJNHMJcWkfICb7c5FTxNBKxer/WfsQnpI2G02s0GTfNfb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4VvxlW5FDSzqSZl;
	Thu,  6 Jun 2024 11:07:51 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: David Hildenbrand <david@redhat.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] mm/memory_hotplug: prevent accessing by index=-1
Date: Thu,  6 Jun 2024 11:06:59 +0300
Message-Id: <20240606080659.18525-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <01d90f6c-64a1-4d25-a760-0d8865f6de95@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgrshhtrghsihgruceuvghlohhvrgcuoegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeevhfduuefhueektdefkedvgfekgfekffegvdetffehfefhffejhfehveevudeigfenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvddtrdehkeenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdquddtiedtiedvrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrddujeejrddvtddrheekmeeggeegtddtpdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepjedprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepohhsrghlvhgrughorhesshhushgvrdguvgdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorh
 hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12729421, Updated: 2024-Jun-06 06:22:42 UTC]

nid may be equal to NUMA_NO_NODE=-1. Prevent accessing node_data
array by invalid index with check for nid.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online policy")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 mm/memory_hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 431b1f6753c0..db78d1b725fc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -846,7 +846,6 @@ static bool auto_movable_can_online_movable(int nid, struct memory_group *group,
 	unsigned long kernel_early_pages, movable_pages;
 	struct auto_movable_group_stats group_stats = {};
 	struct auto_movable_stats stats = {};
-	pg_data_t *pgdat = NODE_DATA(nid);
 	struct zone *zone;
 	int i;
 
@@ -857,6 +856,8 @@ static bool auto_movable_can_online_movable(int nid, struct memory_group *group,
 			auto_movable_stats_account_zone(&stats, zone);
 	} else {
 		for (i = 0; i < MAX_NR_ZONES; i++) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+
 			zone = pgdat->node_zones + i;
 			if (populated_zone(zone))
 				auto_movable_stats_account_zone(&stats, zone);
-- 
2.30.2


