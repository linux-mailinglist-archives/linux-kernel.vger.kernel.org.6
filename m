Return-Path: <linux-kernel+bounces-274399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24BB9477B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EC51C20BCA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00E51586C1;
	Mon,  5 Aug 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="An7FRkSW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GjpwNPR8"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE748156F55
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848075; cv=none; b=l9z15XJtYUA1WeUnpXg2NG7W/rY4nRIK2zeZ3ttbJM+BSwXYiJyWDm5lOp85j6cuZ6HVNq5If3LagQRCCYET5pO3ZXwyFvx6pY9pLQeJkUgBm/4uvE4lcdVNnU+uxfeNsqTEews+N6fZzUEI03W4b4X2qV59AF0S0ltDMO9RlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848075; c=relaxed/simple;
	bh=VkOGpKEZJl+vIZAQe3yTz+MuuquZjfY8NHLB4zRcw+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kz/JVh7NUB2fV5exdwjkii9r3I8O7wRdtO3k7xixMlcmzYfqxBjZ4uNrdV1cZ+SIuoRgSBs66gfMWjiWRTbinDdReaQ1c/RNMRMp6y6QC5Qo/czOfvOHv5QmjT85vqpZdhF1CkOe4kMmyRVTtRG/KKOo5Wcb9Qgwovqbdu5U97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=An7FRkSW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GjpwNPR8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id C6C8C138FD80;
	Mon,  5 Aug 2024 04:54:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Mon, 05 Aug 2024 04:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848070; x=
	1722934470; bh=2M63XuIcnOs2zgB0Of1R5tPvEt2hh1y3Apg8Rw8WgRE=; b=A
	n7FRkSW9KgNiVhNUUszlClnB7Un7ljhFcoJdogiGGBD+And06BBvDvURHYVtkJWf
	ywD3qKMyqDpjaLol7UM1HDoyZ71o+y5T5VlcwSNiZ+s3LqkSyhHQV2YbBwFbzk2C
	Vc3XhLK1gRDjFnKFt3g1qcmw3X5YLADCxfF9+FQZVJ/tZ2fkXTJUGni8dE1k+VyZ
	I3OSGtz5dAWoj9rCE3MMNSZRV6LF98Tjp1Y/6YcH7y5sH3E36V3lOWMjtQBR07X2
	25ggVRKpnk5JL951RFyOHJOCGAUNzRlCywX7eezCz+cPVGvweY6QLqYXIqrrAHoL
	xXso4S6esRxBS52bwyB+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848070; x=
	1722934470; bh=2M63XuIcnOs2zgB0Of1R5tPvEt2hh1y3Apg8Rw8WgRE=; b=G
	jpwNPR8DwgmcddZy2/en9D0T7bmnElNS/qdMMffJoq8lQwgYRKm/KehiRvWWdahL
	NMJmgoh6AoocD4lByVupQsWadlrsGJZDirJYuypAu/S0KpLDNvOcv0KxUYvBEorZ
	7T+Pg4XzwdGDNzjXQU4Xdc3n6m965/g9U9HqwGo97sEgBJ/QA4eRqi6S7Sl1PDq6
	9VPHI9rup6g+MVQ0wbVKHNZWKbmWtnJY4HO695pjZqAAh+v6ZzAaPkNaslmyzLis
	r0hdBU6gSsPI13KpKWfLZQWUdoxChMfOvePKzSmz+5pc2AS67JIJdRAxHWd8Uiiw
	XzTEi9bGTWZcv+u19Y6Fg==
X-ME-Sender: <xms:RpOwZkzD98OI3SxWQSbuGWclNDdpynbzNc-KGYrW857AfzSxSmPXtA>
    <xme:RpOwZoSL-kN8tX9GRxt3sE2-mfF6PashrZ3OH-8uMUA1hr1IV8ash3Kcjkg7P0X5b
    YYN8BORCKUwr-yaFIo>
X-ME-Received: <xmr:RpOwZmVXFhgoOJkzKBAlV676Pxjqe5jvzNIsZu4lZLZ9Q1y9Is0yYyV48ktRzFr24IaHjWH--FOtKP2_M5DhiKtAgHnkEi76ZGUMv1CalPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:RpOwZihgB8C6H5x-_OSuQnS_isB5V6KM30G1YtsQVhf91wB0q6xcMQ>
    <xmx:RpOwZmClq_QPZ9wjLleDsa3cF4dLkCN7U3EvA3bzNB4zgADzs-xUgA>
    <xmx:RpOwZjJGEJkwy3dFna7Z53vYc8UYednz7lfK5yDF8VCtAYipD6o3cg>
    <xmx:RpOwZtBgtE9zIDAXBIHxTVb99Jg6TL3s3MAdq4EsCNpHqoSWWqUKLw>
    <xmx:RpOwZpP-gWn9sawOlRK7LSUkoU_-I6Hp6zOksYjjn7O_k3F7Oh9aBxNG>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:29 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/17] firewire: core: use guard macro to maintain properties of fw_card
Date: Mon,  5 Aug 2024 17:54:05 +0900
Message-ID: <20240805085408.251763-15-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
References: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core functions uses spinlock in instance of fw_card structure to
protect concurrent access to properties in the instance.

This commit uses guard macro to maintain the spinlock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c        | 16 +++++++---------
 drivers/firewire/core-cdev.c        |  4 +---
 drivers/firewire/core-device.c      | 10 +++-------
 drivers/firewire/core-iso.c         |  5 ++---
 drivers/firewire/core-topology.c    |  5 +----
 drivers/firewire/core-transaction.c | 12 +++++-------
 6 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 79a5b19e9d18..e80b762888fa 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -374,11 +374,11 @@ static void bm_work(struct work_struct *work)
 
 		bm_id = be32_to_cpu(transaction_data[0]);
 
-		spin_lock_irq(&card->lock);
-		if (rcode == RCODE_COMPLETE && generation == card->generation)
-			card->bm_node_id =
-			    bm_id == 0x3f ? local_id : 0xffc0 | bm_id;
-		spin_unlock_irq(&card->lock);
+		scoped_guard(spinlock_irq, &card->lock) {
+			if (rcode == RCODE_COMPLETE && generation == card->generation)
+				card->bm_node_id =
+				    bm_id == 0x3f ? local_id : 0xffc0 | bm_id;
+		}
 
 		if (rcode == RCODE_COMPLETE && bm_id != 0x3f) {
 			/* Somebody else is BM.  Only act as IRM. */
@@ -707,7 +707,6 @@ EXPORT_SYMBOL_GPL(fw_card_release);
 void fw_core_remove_card(struct fw_card *card)
 {
 	struct fw_card_driver dummy_driver = dummy_driver_template;
-	unsigned long flags;
 
 	card->driver->update_phy_reg(card, 4,
 				     PHY_LINK_ACTIVE | PHY_CONTENDER, 0);
@@ -721,9 +720,8 @@ void fw_core_remove_card(struct fw_card *card)
 	dummy_driver.stop_iso		= card->driver->stop_iso;
 	card->driver = &dummy_driver;
 
-	spin_lock_irqsave(&card->lock, flags);
-	fw_destroy_nodes(card);
-	spin_unlock_irqrestore(&card->lock, flags);
+	scoped_guard(spinlock_irqsave, &card->lock)
+		fw_destroy_nodes(card);
 
 	/* Wait for all users, especially device workqueue jobs, to finish. */
 	fw_card_put(card);
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index f32f8667ef2c..672a37fa8343 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -354,7 +354,7 @@ static void fill_bus_reset_event(struct fw_cdev_event_bus_reset *event,
 {
 	struct fw_card *card = client->device->card;
 
-	spin_lock_irq(&card->lock);
+	guard(spinlock_irq)(&card->lock);
 
 	event->closure	     = client->bus_reset_closure;
 	event->type          = FW_CDEV_EVENT_BUS_RESET;
@@ -364,8 +364,6 @@ static void fill_bus_reset_event(struct fw_cdev_event_bus_reset *event,
 	event->bm_node_id    = card->bm_node_id;
 	event->irm_node_id   = card->irm_node->node_id;
 	event->root_node_id  = card->root_node->node_id;
-
-	spin_unlock_irq(&card->lock);
 }
 
 static void for_each_client(struct fw_device *device,
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index d695ec2f1efe..bec7e05f6ab8 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -886,16 +886,14 @@ static void fw_device_release(struct device *dev)
 {
 	struct fw_device *device = fw_device(dev);
 	struct fw_card *card = device->card;
-	unsigned long flags;
 
 	/*
 	 * Take the card lock so we don't set this to NULL while a
 	 * FW_NODE_UPDATED callback is being handled or while the
 	 * bus manager work looks at this node.
 	 */
-	spin_lock_irqsave(&card->lock, flags);
-	device->node->data = NULL;
-	spin_unlock_irqrestore(&card->lock, flags);
+	scoped_guard(spinlock_irqsave, &card->lock)
+		device->node->data = NULL;
 
 	fw_node_put(device->node);
 	kfree(device->config_rom);
@@ -952,7 +950,7 @@ static int lookup_existing_device(struct device *dev, void *data)
 		return 0;
 
 	guard(rwsem_read)(&fw_device_rwsem); // serialize config_rom access
-	spin_lock_irq(&card->lock);  /* serialize node access */
+	guard(spinlock_irq)(&card->lock); // serialize node access
 
 	if (memcmp(old->config_rom, new->config_rom, 6 * 4) == 0 &&
 	    atomic_cmpxchg(&old->state,
@@ -982,8 +980,6 @@ static int lookup_existing_device(struct device *dev, void *data)
 		match = 1;
 	}
 
-	spin_unlock_irq(&card->lock);
-
 	return match;
 }
 
diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index b3eda38a36f3..101433b8bb51 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -375,9 +375,8 @@ void fw_iso_resource_manage(struct fw_card *card, int generation,
 	u32 channels_lo = channels_mask >> 32;	/* channels 63...32 */
 	int irm_id, ret, c = -EINVAL;
 
-	spin_lock_irq(&card->lock);
-	irm_id = card->irm_node->node_id;
-	spin_unlock_irq(&card->lock);
+	scoped_guard(spinlock_irq, &card->lock)
+		irm_id = card->irm_node->node_id;
 
 	if (channels_hi)
 		c = manage_channel(card, irm_id, generation, channels_hi,
diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 46e6eb287d24..6adadb11962e 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -455,11 +455,10 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 			      int self_id_count, u32 *self_ids, bool bm_abdicate)
 {
 	struct fw_node *local_node;
-	unsigned long flags;
 
 	trace_bus_reset_handle(card->index, generation, node_id, bm_abdicate, self_ids, self_id_count);
 
-	spin_lock_irqsave(&card->lock, flags);
+	guard(spinlock_irqsave)(&card->lock);
 
 	/*
 	 * If the selfID buffer is not the immediate successor of the
@@ -500,7 +499,5 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 	} else {
 		update_tree(card, local_node);
 	}
-
-	spin_unlock_irqrestore(&card->lock, flags);
 }
 EXPORT_SYMBOL(fw_core_handle_bus_reset);
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 0f58a5d13d28..14af84541e83 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -1160,7 +1160,6 @@ static void handle_registers(struct fw_card *card, struct fw_request *request,
 	int reg = offset & ~CSR_REGISTER_BASE;
 	__be32 *data = payload;
 	int rcode = RCODE_COMPLETE;
-	unsigned long flags;
 
 	switch (reg) {
 	case CSR_PRIORITY_BUDGET:
@@ -1202,10 +1201,10 @@ static void handle_registers(struct fw_card *card, struct fw_request *request,
 		if (tcode == TCODE_READ_QUADLET_REQUEST) {
 			*data = cpu_to_be32(card->split_timeout_hi);
 		} else if (tcode == TCODE_WRITE_QUADLET_REQUEST) {
-			spin_lock_irqsave(&card->lock, flags);
+			guard(spinlock_irqsave)(&card->lock);
+
 			card->split_timeout_hi = be32_to_cpu(*data) & 7;
 			update_split_timeout(card);
-			spin_unlock_irqrestore(&card->lock, flags);
 		} else {
 			rcode = RCODE_TYPE_ERROR;
 		}
@@ -1215,11 +1214,10 @@ static void handle_registers(struct fw_card *card, struct fw_request *request,
 		if (tcode == TCODE_READ_QUADLET_REQUEST) {
 			*data = cpu_to_be32(card->split_timeout_lo);
 		} else if (tcode == TCODE_WRITE_QUADLET_REQUEST) {
-			spin_lock_irqsave(&card->lock, flags);
-			card->split_timeout_lo =
-					be32_to_cpu(*data) & 0xfff80000;
+			guard(spinlock_irqsave)(&card->lock);
+
+			card->split_timeout_lo = be32_to_cpu(*data) & 0xfff80000;
 			update_split_timeout(card);
-			spin_unlock_irqrestore(&card->lock, flags);
 		} else {
 			rcode = RCODE_TYPE_ERROR;
 		}
-- 
2.43.0


