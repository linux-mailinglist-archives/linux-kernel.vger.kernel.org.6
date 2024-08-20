Return-Path: <linux-kernel+bounces-294013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672199587C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD89283D52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2CA190462;
	Tue, 20 Aug 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kQMJc1ql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGBRh76U"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502A18E35F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160100; cv=none; b=PIkYoEwh5Pp5w9HM99gFKnizc2ysvhApgRBQ+4mFPrHH+3mRFZpCOFdmGU9uNDNXIGmhwJoMaFvl7WGNqK1pbBL6PZpsOp9oU7jG3gXoqv56nCJWmuclT4vAiOOA4JNiY7MOXTy8h50KHJwDA1/ssVt1P9q+sSiU7RrYQ7mGBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160100; c=relaxed/simple;
	bh=KrNZhFutFrDL6QpEW/1zP/gws6BSXNiPICop2vLw/yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5SEepWjrNB2Wn7iK+54Nr6oeI/R9znhqITp/Otijtgtukbzg5ru9aqqUW66YVojXaHnLktOoXkzu7bmENqLYVf9dkKdzWqslpaxBm5lbQfyyve3XhMfA2ePwVhKRfDPNmTUP38xvS/j+UCxOiV9C0CdgEL3M3X6AQn/0Kvfxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=kQMJc1ql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGBRh76U; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id E493F1387F0B;
	Tue, 20 Aug 2024 09:21:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 09:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1724160096; x=1724246496; bh=86ZeZfYeaT
	cmskdnAJqMjm66d9ypJErFKQtgdhkPtkA=; b=kQMJc1ql09vhVCoBlYb6uVIzNM
	mzs/TFSb1GlJ8PmiNT3TOL4Kax3w4oSNSYYLvzcf2AdZMqJzMMa1e+ASUB1N6467
	vM/OwY/vHhuqH6UQqWh4fzYU9/sjSutyzeuo24x7qkWVHE1nMbq4Vlz/NXvxssDE
	3637mz1/SpkIty8Le83U6jzz6FBAN3AGViLORoslUrEhgBHXNWu6pw+TtwQAnIB5
	NgqMwKQsE8lscndT0t2UxEH6RdN0fNL6aEUDxSB2AkDbe+qTP1XEal+HsaDq+Ivq
	bszKi30VKKbZa6oMh29lDk8YXIS/grqAMOxn0aadZVWHFxsK/vNExnBP2REw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724160096; x=1724246496; bh=86ZeZfYeaTcmskdnAJqMjm66d9yp
	JErFKQtgdhkPtkA=; b=CGBRh76UrL3li2ptaFZOD4vHODcQXcjZfKu9A0WWLx3P
	O2x2STIlgndzzXfMr7xqLodVfvu6i1TdlrFDSzYBdtKO0U1AWDZSEz33kRk8cawU
	t4USy0+VV3e46Cgs2le/70gAs+LUw5WP1MEFmEbVlHKMMY/WyR0OVcNLbU+jObQ2
	tpjPWCjsrP8WkI3iqD+oM7PGdv9qN214iqP6GjFXwnUFMyf1oNwvaL8NKPMwPw+f
	UkZJaNkJrVdsNuhVCdxRsoub00koRzjgNzjz6s1aE8RVwcy91sqHMhNcfusY8o0k
	et6VsgJ/nLmbD6fQGKTQxhpYsiqIQP5pGD28sQ3S5A==
X-ME-Sender: <xms:YJjEZjjWnlJD1qmHnPcVpz2uy3vVfA206SJA3hA8BJeTOx9HgEcvgg>
    <xme:YJjEZgCirTXiguYql9LdyDJqvAaIINWpfgbArm6y-5-ajbwCOajq7cd6xKxu4kmNL
    9WJcg2C3ZcWr-3keIM>
X-ME-Received: <xmr:YJjEZjFS2ikou5G-vj7lWByLX4BSpvXv16jRjv1-ABgd_2haTpYRxBNxW8uUVEa8HvIXJ7K_cYbmjls7IHoDOJLsGCkT-90PEfH4aPq8QbsWRnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevkeduhfetjedu
    ffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggt
    hhhirdhjphdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhg
    vgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopeiiihhjuhhnpghhuhesihgtlhhouhgurdgtohhm
X-ME-Proxy: <xmx:YJjEZgRx3H-KrvJu0zDBbaR7naGFIEJv5eZIA6Fi3qPVgKJvdxZTGg>
    <xmx:YJjEZgx7WWL4kMvZkasT73n03BZH3rqQfBcKeXJNXz7GEOCM_h-ubQ>
    <xmx:YJjEZm7InJyAn3M1CDIbCdGFPrWsy1cTWvHOveL7itFHx08kN0IdcQ>
    <xmx:YJjEZly82SZ8a7wl3Oiqc8YQVFT9e2Cbeks9QI18hl7V_pggTY7yPA>
    <xmx:YJjEZs-NQMAPfFPX5jEn3jpXeMoHfQZhX3uwXO-UQfXqIP23Xkw2ermF>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 09:21:35 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH] firewire: core: update fw_device outside of device_find_child()
Date: Tue, 20 Aug 2024 22:21:32 +0900
Message-ID: <20240820132132.28839-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When detecting updates of bus topology, the data of fw_device is newly
allocated and caches the content of configuration ROM from the
corresponding node. Then, the tree of device is sought to find the
previous data of fw_device corresponding to the node. If found, the
previous data is updated and reused and the data of fw_device newly
allocated is going to be released.

The above procedure is done in the call of device_find_child(), however it
is a bit abusing against the intention of the helper function, since it is
preferable to find only without updating.

This commit splits the update outside of the call.

Cc: Zijun Hu <zijun_hu@icloud.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 116 +++++++++++++++++----------------
 1 file changed, 59 insertions(+), 57 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index f71e118ef60a..a99fe35f1f0d 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -928,56 +928,6 @@ static void fw_device_update(struct work_struct *work)
 	device_for_each_child(&device->device, NULL, update_unit);
 }
 
-/*
- * If a device was pending for deletion because its node went away but its
- * bus info block and root directory header matches that of a newly discovered
- * device, revive the existing fw_device.
- * The newly allocated fw_device becomes obsolete instead.
- */
-static int lookup_existing_device(struct device *dev, void *data)
-{
-	struct fw_device *old = fw_device(dev);
-	struct fw_device *new = data;
-	struct fw_card *card = new->card;
-	int match = 0;
-
-	if (!is_fw_device(dev))
-		return 0;
-
-	guard(rwsem_read)(&fw_device_rwsem); // serialize config_rom access
-	guard(spinlock_irq)(&card->lock); // serialize node access
-
-	if (memcmp(old->config_rom, new->config_rom, 6 * 4) == 0 &&
-	    atomic_cmpxchg(&old->state,
-			   FW_DEVICE_GONE,
-			   FW_DEVICE_RUNNING) == FW_DEVICE_GONE) {
-		struct fw_node *current_node = new->node;
-		struct fw_node *obsolete_node = old->node;
-
-		new->node = obsolete_node;
-		new->node->data = new;
-		old->node = current_node;
-		old->node->data = old;
-
-		old->max_speed = new->max_speed;
-		old->node_id = current_node->node_id;
-		smp_wmb();  /* update node_id before generation */
-		old->generation = card->generation;
-		old->config_rom_retries = 0;
-		fw_notice(card, "rediscovered device %s\n", dev_name(dev));
-
-		old->workfn = fw_device_update;
-		fw_schedule_device_work(old, 0);
-
-		if (current_node == card->root_node)
-			fw_schedule_bm_work(card, 0);
-
-		match = 1;
-	}
-
-	return match;
-}
-
 enum { BC_UNKNOWN = 0, BC_UNIMPLEMENTED, BC_IMPLEMENTED, };
 
 static void set_broadcast_channel(struct fw_device *device, int generation)
@@ -1038,12 +988,24 @@ int fw_device_set_broadcast_channel(struct device *dev, void *gen)
 	return 0;
 }
 
+static int compare_configuration_rom(struct device *dev, void *data)
+{
+	const struct fw_device *old = fw_device(dev);
+	const u32 *config_rom = data;
+
+	if (!is_fw_device(dev))
+		return 0;
+
+	// Compare the bus information block and root_length/root_crc.
+	return !memcmp(old->config_rom, config_rom, 6 * 4);
+}
+
 static void fw_device_init(struct work_struct *work)
 {
 	struct fw_device *device =
 		container_of(work, struct fw_device, work.work);
 	struct fw_card *card = device->card;
-	struct device *revived_dev;
+	struct device *found;
 	u32 minor;
 	int ret;
 
@@ -1071,13 +1033,53 @@ static void fw_device_init(struct work_struct *work)
 		return;
 	}
 
-	revived_dev = device_find_child(card->device,
-					device, lookup_existing_device);
-	if (revived_dev) {
-		put_device(revived_dev);
-		fw_device_release(&device->device);
+	// If a device was pending for deletion because its node went away but its bus info block
+	// and root directory header matches that of a newly discovered device, revive the
+	// existing fw_device. The newly allocated fw_device becomes obsolete instead.
+	//
+	// serialize config_rom access.
+	scoped_guard(rwsem_read, &fw_device_rwsem) {
+		found = device_find_child(card->device, (void *)device->config_rom,
+					  compare_configuration_rom);
+	}
+	if (found) {
+		struct fw_device *reused = fw_device(found);
+
+		if (atomic_cmpxchg(&reused->state,
+				   FW_DEVICE_GONE,
+				   FW_DEVICE_RUNNING) == FW_DEVICE_GONE) {
+			// serialize node access
+			scoped_guard(spinlock_irq, &card->lock) {
+				struct fw_node *current_node = device->node;
+				struct fw_node *obsolete_node = reused->node;
+
+				device->node = obsolete_node;
+				device->node->data = device;
+				reused->node = current_node;
+				reused->node->data = reused;
+
+				reused->max_speed = device->max_speed;
+				reused->node_id = current_node->node_id;
+				smp_wmb();  /* update node_id before generation */
+				reused->generation = card->generation;
+				reused->config_rom_retries = 0;
+				fw_notice(card, "rediscovered device %s\n",
+					  dev_name(found));
+
+				reused->workfn = fw_device_update;
+				fw_schedule_device_work(reused, 0);
+
+				if (current_node == card->root_node)
+					fw_schedule_bm_work(card, 0);
+			}
 
-		return;
+			put_device(found);
+			fw_device_release(&device->device);
+
+			return;
+		}
+
+		put_device(found);
 	}
 
 	device_initialize(&device->device);
-- 
2.43.0


