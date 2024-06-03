Return-Path: <linux-kernel+bounces-199050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D78D813B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98321F22051
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5FE84A41;
	Mon,  3 Jun 2024 11:29:21 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD484039
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414160; cv=none; b=liCcrr3gYStgJgQCi9qazlKgoK1mhvi68+g3Kt2V1R99rOBEWRBscQOBzL0U1SeLJ43oRfQ5uKuqqm4rHABpFfsA22OH9Slo8BtvgWSDUflcF9Ko7Mnz+WdTfGvANaDQ77OZsdFGgexwb+39+Wtvi0jpB+lSGzhNoPpiE+AitdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414160; c=relaxed/simple;
	bh=sDb05zDbDJ3VczZK0QFfMzi1YM/ZIKErl9mjc1+LK4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fb2kfwZNsUPFaY8ICcMVB0g2kzphzEiSywYHQYUdO3ZwMQjbG88l/GYFutybjqImPv9jzW85jyeZIXEAvtziXvgiv7Z5606sxGmo/SyuLJjp3WD55MvtxnU7W73mB+ATpJ0rSPdHmGT/qGan+RzaWtbz3169gUOwDFdbwp7yR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4VtBMF2Ln0zyfG;
	Mon,  3 Jun 2024 14:29:13 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: David Hildenbrand <david@redhat.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] mm/memory_hotplug: prevent accessing by index=-1
Date: Mon,  3 Jun 2024 14:28:30 +0300
Message-Id: <20240603112830.7432-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhgrshhtrghsihgruceuvghlohhvrgcuoegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeffvddvueehvedvgfeivdeuvdduteeulefgfeehieffgfehtedutdfgveefvdeiheenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvddtrdehkeenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdquddtiedtiedvrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrddujeejrddvtddrheekmeefheejkeeipdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepjedprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepohhsrghlvhgrughorhesshhushgvrdguvgdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpd
 hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12717933, Updated: 2024-Jun-03 09:24:46 UTC]

nid may be equal to NUMA_NO_NODE=-1. Prevent accessing node_data
array by invalid index with check for nid.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online policy")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 431b1f6753c0..bb98ee8fe698 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -846,7 +846,7 @@ static bool auto_movable_can_online_movable(int nid, struct memory_group *group,
 	unsigned long kernel_early_pages, movable_pages;
 	struct auto_movable_group_stats group_stats = {};
 	struct auto_movable_stats stats = {};
-	pg_data_t *pgdat = NODE_DATA(nid);
+	pg_data_t *pgdat = (nid != NUMA_NO_NODE) ? NODE_DATA(nid) : NULL;
 	struct zone *zone;
 	int i;
 
-- 
2.30.2


