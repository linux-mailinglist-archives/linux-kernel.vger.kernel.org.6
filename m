Return-Path: <linux-kernel+bounces-273849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0622946EE5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E661B21A57
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60ED139D1A;
	Sun,  4 Aug 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KwAn0Dmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBCyvJZA"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAAA12E1DB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776565; cv=none; b=KZm4UlIyXjT6+xXUCw61DVZJ2ZpgSS5Lmf9xe8iYmiz+h+4IM9wNFCYUKGAytDAG7NIxOqesGU3RYUYuybUhQyjgQJ5xECIAZsKCMzjJSaJkPLwRPSx7XRFoCzXjzyhrE98TlIQPmGEnRTprAKDK/XK8kLhQVKJHew0UMFdJhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776565; c=relaxed/simple;
	bh=uzVMeTX0BbvAA/TdPM5pqNjVCufYr9cCNWLDVrjaoUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOmPi6NQgh77EXw+yw0vO9VEFKlIiU64/UPU+HaeR6Jm3uANSOdldQ1ebjLytgUwgB3iP+RXQlRxxYK92UWoeHoyNfjXYd3/9I3iC2Q4eIPMS50oLlQAjV1PSH9KPDwKYKgWGRUcLr9EkGEWuZP3zv8a2JuwrXT0At/H0vXUahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KwAn0Dmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cBCyvJZA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 08BC21146FED;
	Sun,  4 Aug 2024 09:02:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 04 Aug 2024 09:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776563; x=
	1722862963; bh=z5mX0VvBucVVAQ3hVsBzbK3EagpAINO+dbqWRzZbXyg=; b=K
	wAn0Dmm8EP66ftwA1UfXu/YuaeSi/ekZ5wS6rJBuTodqkgxOdo3UfY/y378K5KKx
	hY54sGBPcaau/hzyKNNEmHs3Vu2eoxY/S//bwv6oRGRUxiLy2EubkyaI0w9U6cdK
	Xkks8ZGBJFOxKi6Kxs7dA+s5EtJBnUdMoIh+LxtxwKZ+S8BvOZmI7Gl+a3fVxa60
	N0QY8Y7+s4HNRqQYBMFvkRUTiIbmgFQi7ZX8iRkIY5kYxNgp8z5RTbTUUlUJ6ZdX
	KZMXDn8oyTKE7sZwgb7a7r9Iv9n9eQT0i70BJb/a74DmG6LRfPGqiKWJpzb3zl+p
	WA5S6W8uycZh0wksWBP0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776563; x=
	1722862963; bh=z5mX0VvBucVVAQ3hVsBzbK3EagpAINO+dbqWRzZbXyg=; b=c
	BCyvJZA1pMufc0/Jft9+oMbPFJiaDgj1G+36aCVefN20VVI7u1eeZDc3CiB/vbXE
	SWCVMaiBw6vKA6A8FGuKePt8tEQBXReJHwy+hRoHv2ru5dDn5Qc1PPnQOH1GWxUy
	mB6VCpIy5nwMAcp6jyXgfDs6bk/vuEEMybhI3iCpGYwimrvDdCjoZJscY9649d5x
	X1jFGwhYYIFw2ZmgQsE1ZuH/SeJ1t/EaxxSdolXL/9bMe+4bclnNvZL8z4F1Pjfz
	RfB7ljEi7GBprJ+mZslb4cyvkRBNl4mEWpa6VQJ4N/1zcJexZxZF+yHAfcC0sRoC
	IGeItAShRoingxjQ9fRPQ==
X-ME-Sender: <xms:8nuvZiJ6Dz5l9aEyRJh29R348vxvxPcwQL1ZrNRv5x4xYMjYwC8X3g>
    <xme:8nuvZqKon6_y8ReK6WUIA9Jih7HyzNxVNtLPGzSfUaUgq7TubKyTLJP-1WWXtnA7S
    8fEXFXfEFlfER6rBPs>
X-ME-Received: <xmr:8nuvZiuxNCGwScpH0yeF-MaMbB3XchS6dzsTIm-3WsfPnVlSHax7PeC_tvJGMhj0mmtPNs7k7ixGAxDfIr-f11lbPOrjiSk8I1Pdh3kiNknoHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:8nuvZnZ9I11JcE3wVCIFkQOlYYKetRikz24m0Nl_RPuME-Rvzs8H-Q>
    <xmx:8nuvZpYz4MOtm1_WbdTrD-6-HuTY-RygC2uzJS9dp1HicUCEguNjuA>
    <xmx:8nuvZjBX_fcAZCY5lHnamnGqkuj780dG5KruNhnW8Agq3LZ0UdecdA>
    <xmx:8nuvZvbQEKZCjlsn7-hCa3JDu0OE9RYXeo-_DRvdAHp35OWrcIzmhQ>
    <xmx:83uvZondadvXHqumLmvotdujaRDnVY1JabWyRMYveXHB7MCrwrm3_gr6>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:41 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] firewire: core: use guard macro to maintain IDR of isochronous resources for userspace clients
Date: Sun,  4 Aug 2024 22:02:17 +0900
Message-ID: <20240804130225.243496-11-o-takashi@sakamocchi.jp>
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

The core function provides UAPI to maintain isochronous resources allocated
by userspace clients across bus resets automatically. The resources are
maintained by IDR and the concurrent access to it is protected by spinlock
in the instance of client.

This commit uses guard macro to maintain the spinlock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 131 ++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 72 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 2e2199eaa05b..c2d24cc5c1f1 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -399,9 +399,9 @@ static void queue_bus_reset_event(struct client *client)
 	queue_event(client, &e->event,
 		    &e->reset, sizeof(e->reset), NULL, 0);
 
-	spin_lock_irq(&client->lock);
+	guard(spinlock_irq)(&client->lock);
+
 	idr_for_each(&client->resource_idr, schedule_reallocations, client);
-	spin_unlock_irq(&client->lock);
 }
 
 void fw_device_cdev_update(struct fw_device *device)
@@ -483,25 +483,23 @@ static int add_client_resource(struct client *client,
 			       struct client_resource *resource, gfp_t gfp_mask)
 {
 	bool preload = gfpflags_allow_blocking(gfp_mask);
-	unsigned long flags;
 	int ret;
 
 	if (preload)
 		idr_preload(gfp_mask);
-	spin_lock_irqsave(&client->lock, flags);
 
-	if (client->in_shutdown)
-		ret = -ECANCELED;
-	else
-		ret = idr_alloc(&client->resource_idr, resource, 0, 0,
-				GFP_NOWAIT);
-	if (ret >= 0) {
-		resource->handle = ret;
-		client_get(client);
-		schedule_if_iso_resource(resource);
+	scoped_guard(spinlock_irqsave, &client->lock) {
+		if (client->in_shutdown)
+			ret = -ECANCELED;
+		else
+			ret = idr_alloc(&client->resource_idr, resource, 0, 0, GFP_NOWAIT);
+		if (ret >= 0) {
+			resource->handle = ret;
+			client_get(client);
+			schedule_if_iso_resource(resource);
+		}
 	}
 
-	spin_unlock_irqrestore(&client->lock, flags);
 	if (preload)
 		idr_preload_end();
 
@@ -514,14 +512,14 @@ static int release_client_resource(struct client *client, u32 handle,
 {
 	struct client_resource *resource;
 
-	spin_lock_irq(&client->lock);
-	if (client->in_shutdown)
-		resource = NULL;
-	else
-		resource = idr_find(&client->resource_idr, handle);
-	if (resource && resource->release == release)
-		idr_remove(&client->resource_idr, handle);
-	spin_unlock_irq(&client->lock);
+	scoped_guard(spinlock_irq, &client->lock) {
+		if (client->in_shutdown)
+			resource = NULL;
+		else
+			resource = idr_find(&client->resource_idr, handle);
+		if (resource && resource->release == release)
+			idr_remove(&client->resource_idr, handle);
+	}
 
 	if (!(resource && resource->release == release))
 		return -EINVAL;
@@ -546,13 +544,12 @@ static void complete_transaction(struct fw_card *card, int rcode, u32 request_ts
 {
 	struct outbound_transaction_event *e = data;
 	struct client *client = e->client;
-	unsigned long flags;
 
-	spin_lock_irqsave(&client->lock, flags);
-	idr_remove(&client->resource_idr, e->r.resource.handle);
-	if (client->in_shutdown)
-		wake_up(&client->tx_flush_wait);
-	spin_unlock_irqrestore(&client->lock, flags);
+	scoped_guard(spinlock_irqsave, &client->lock) {
+		idr_remove(&client->resource_idr, e->r.resource.handle);
+		if (client->in_shutdown)
+			wake_up(&client->tx_flush_wait);
+	}
 
 	switch (e->rsp.without_tstamp.type) {
 	case FW_CDEV_EVENT_RESPONSE:
@@ -1307,25 +1304,24 @@ static void iso_resource_work(struct work_struct *work)
 	int generation, channel, bandwidth, todo;
 	bool skip, free, success;
 
-	spin_lock_irq(&client->lock);
-	generation = client->device->generation;
-	todo = r->todo;
-	/* Allow 1000ms grace period for other reallocations. */
-	if (todo == ISO_RES_ALLOC &&
-	    time_before64(get_jiffies_64(),
-			  client->device->card->reset_jiffies + HZ)) {
-		schedule_iso_resource(r, DIV_ROUND_UP(HZ, 3));
-		skip = true;
-	} else {
-		/* We could be called twice within the same generation. */
-		skip = todo == ISO_RES_REALLOC &&
-		       r->generation == generation;
+	scoped_guard(spinlock_irq, &client->lock) {
+		generation = client->device->generation;
+		todo = r->todo;
+		// Allow 1000ms grace period for other reallocations.
+		if (todo == ISO_RES_ALLOC &&
+		    time_before64(get_jiffies_64(), client->device->card->reset_jiffies + HZ)) {
+			schedule_iso_resource(r, DIV_ROUND_UP(HZ, 3));
+			skip = true;
+		} else {
+			// We could be called twice within the same generation.
+			skip = todo == ISO_RES_REALLOC &&
+			       r->generation == generation;
+		}
+		free = todo == ISO_RES_DEALLOC ||
+		       todo == ISO_RES_ALLOC_ONCE ||
+		       todo == ISO_RES_DEALLOC_ONCE;
+		r->generation = generation;
 	}
-	free = todo == ISO_RES_DEALLOC ||
-	       todo == ISO_RES_ALLOC_ONCE ||
-	       todo == ISO_RES_DEALLOC_ONCE;
-	r->generation = generation;
-	spin_unlock_irq(&client->lock);
 
 	if (skip)
 		goto out;
@@ -1348,24 +1344,20 @@ static void iso_resource_work(struct work_struct *work)
 
 	success = channel >= 0 || bandwidth > 0;
 
-	spin_lock_irq(&client->lock);
-	/*
-	 * Transit from allocation to reallocation, except if the client
-	 * requested deallocation in the meantime.
-	 */
-	if (r->todo == ISO_RES_ALLOC)
-		r->todo = ISO_RES_REALLOC;
-	/*
-	 * Allocation or reallocation failure?  Pull this resource out of the
-	 * idr and prepare for deletion, unless the client is shutting down.
-	 */
-	if (r->todo == ISO_RES_REALLOC && !success &&
-	    !client->in_shutdown &&
-	    idr_remove(&client->resource_idr, r->resource.handle)) {
-		client_put(client);
-		free = true;
+	scoped_guard(spinlock_irq, &client->lock) {
+		// Transit from allocation to reallocation, except if the client
+		// requested deallocation in the meantime.
+		if (r->todo == ISO_RES_ALLOC)
+			r->todo = ISO_RES_REALLOC;
+		// Allocation or reallocation failure?  Pull this resource out of the
+		// idr and prepare for deletion, unless the client is shutting down.
+		if (r->todo == ISO_RES_REALLOC && !success &&
+		    !client->in_shutdown &&
+		    idr_remove(&client->resource_idr, r->resource.handle)) {
+			client_put(client);
+			free = true;
+		}
 	}
-	spin_unlock_irq(&client->lock);
 
 	if (todo == ISO_RES_ALLOC && channel >= 0)
 		r->channels = 1ULL << channel;
@@ -1403,10 +1395,10 @@ static void release_iso_resource(struct client *client,
 	struct iso_resource *r =
 		container_of(resource, struct iso_resource, resource);
 
-	spin_lock_irq(&client->lock);
+	guard(spinlock_irq)(&client->lock);
+
 	r->todo = ISO_RES_DEALLOC;
 	schedule_iso_resource(r, 0);
-	spin_unlock_irq(&client->lock);
 }
 
 static int init_iso_resource(struct client *client,
@@ -1845,14 +1837,9 @@ static int is_outbound_transaction_resource(int id, void *p, void *data)
 
 static int has_outbound_transactions(struct client *client)
 {
-	int ret;
+	guard(spinlock_irq)(&client->lock);
 
-	spin_lock_irq(&client->lock);
-	ret = idr_for_each(&client->resource_idr,
-			   is_outbound_transaction_resource, NULL);
-	spin_unlock_irq(&client->lock);
-
-	return ret;
+	return idr_for_each(&client->resource_idr, is_outbound_transaction_resource, NULL);
 }
 
 static int shutdown_resource(int id, void *p, void *data)
-- 
2.43.0


