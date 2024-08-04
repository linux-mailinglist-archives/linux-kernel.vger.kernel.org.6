Return-Path: <linux-kernel+bounces-273853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEA6946EE9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2935281183
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902313B7BC;
	Sun,  4 Aug 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="vr4QYuo/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mr9ObnPK"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF313AA2E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776570; cv=none; b=f7rrey2iJkKv1WRzSjMBB6dzCvdtFbxQLIpV/VT9fTjnYrBsCsEvFNkLVeOcAuzDWC0wAocGWKzHoFXrT25NqkWc6D3ux4H+BqT/Ai8bvYdXLFT9oSS4fhT0il1lqAAMAex8IeAnFEb5nO1Ihq/pLfj2iAU3R5+fIDIGn73mlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776570; c=relaxed/simple;
	bh=VkOGpKEZJl+vIZAQe3yTz+MuuquZjfY8NHLB4zRcw+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoN5UqNrJWCnM7odGvs3b9Dl2WRa9wr28moTU1YGEw+eUfoM9wUcbEnELg9OXKHt7e+Va+XbTEWcOpH13GwY33JRUArUxtqQ/oKz+ey3iEFhTV08dk/NP2AV0noUmUVZUDm+VDIkK2HtKCLDJkJO5f0XlSb4vS+i7gfAJ72CPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=vr4QYuo/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mr9ObnPK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 57F7E1388026;
	Sun,  4 Aug 2024 09:02:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 04 Aug 2024 09:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776568; x=
	1722862968; bh=2M63XuIcnOs2zgB0Of1R5tPvEt2hh1y3Apg8Rw8WgRE=; b=v
	r4QYuo/mZW3tKT4BcN5A0rRhyi3MD7iAXgq5bhzO0h3l5AGZRFk0paDaLM2ys7l7
	ptwNLntIsSKfrqAh1POu/EhrqHeaYQB24tu/Ls8Ny8kSGz6O2xh+rV30qk36Bj/G
	JcP3O+vCiiuaK9W5pQv5uXjVb7mvrzN02t7lr4xuug/L3Ff8ZqmKsjyegg1kBVZ4
	nAYpABlRXFolZuAIzrQFKelb+g3s5CXiVWYTvdVAzFnlPmLGYYA8b2RM5uQ4BOgl
	4SchO/ni5a61FTopW2iWFTYRymlTOkfeOFfra1UdBtJpe9GBwhJae1dvMOslJXDt
	JWSXuALv5fCHVfTbwjSBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776568; x=
	1722862968; bh=2M63XuIcnOs2zgB0Of1R5tPvEt2hh1y3Apg8Rw8WgRE=; b=M
	r9ObnPKEzJvA2JW/frTYrRHKYohvNxw4iwKIrbQkV4Jc4W8yXimxPnE52/i5iLor
	HP6Oi6HyWmW18owp2SeCtlNpIxB2eGtekagkkqd+eIi4WOpuHsC3WXIAQa0luTp7
	GtOTT7x+aN2irVX++KJBmbg8znR31o0IRlC3NfX5KHJ7PYHqeR9e6ca9BhEurnYj
	xvNJBdhpajXG4yrfZSEx2J0f5TWxKw/rYhwNnTPYVaGYVC/fVXumxIF9AAFWCLcS
	hZuvdtA2L26tnHd2QM6XBJN4HksVtn4ISpJjoyh/LkJjYLuVFWAtlT2oDX05OSzO
	JSIQo+1TO0E+w58C57n8A==
X-ME-Sender: <xms:-HuvZhFpbUDf24q7guL1Q3KemZsBzC9HJ5AdxnLyUSs8AYiHrJI82A>
    <xme:-HuvZmUenZwaIFBrION2IInvQmIT5tNtHs4MIBgLij8KQa3M-gSt-h4MY2ZJP8ijK
    S1LfGqpQODMPqw6DHo>
X-ME-Received: <xmr:-HuvZjIHsWpw2diAFFIXmp6zet7AhDOEXI9Ij2bqkgaWUcr5K6s4quRMMEnP_NDx42Q0TzB3mYM8LbRY-tQ6MBF4aGP6ZRPnwmKhOWRK0WD9XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:-HuvZnFo0rwOR_hFKG9scIAipxEOl8xUpgHJYUQdackje34mE6fG9A>
    <xmx:-HuvZnXC2_EwXiXQ4GoRdAv6rHuA68sE2eZLvMLJB-Kki2hOFO9JEA>
    <xmx:-HuvZiOGCabNnyDkNimf-XKMASBIvVevAC40uWUSn-kjrtD6b8pyJg>
    <xmx:-HuvZm0gc7VKWCMT-LmizcUKTiZWwuPY7U7EVtVvjVZeNPjwg68nfw>
    <xmx:-HuvZkjJzi2t1tNublgVwxx62Roi43TXCQOpv2SsE7Pk9gtPJQ6akryS>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:47 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] firewire: core: use guard macro to maintain properties of fw_card
Date: Sun,  4 Aug 2024 22:02:21 +0900
Message-ID: <20240804130225.243496-15-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
References: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
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


