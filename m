Return-Path: <linux-kernel+bounces-274394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D56B9477B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF7D281DB1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACA15688D;
	Mon,  5 Aug 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Xh6g7ejx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIMnte++"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B43155744
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848068; cv=none; b=OOCR5AfjsVcozfMzaopdfwmsNKUV+UVHl4zDxlgIBhzAZur/RCpMVWcNJQtCWBDEt4opgo3FRB4pb8gkusRZ6nWSOGmaYfaxFg8FiHxDdCL6cQGywEsBLzllL+YxruQaWkgzlAD/KYEFMwlXs1dGdnSBtoZo42i9wojwf5GNvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848068; c=relaxed/simple;
	bh=uzVMeTX0BbvAA/TdPM5pqNjVCufYr9cCNWLDVrjaoUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqu90K6rJv0m0TKVt1oosrvCVOSh79PGWQXYK8PZUpGIrXX7vj4UJs0lgJZ1icIgLnfraSICWOGeZzbmM3KC+S2JSst5a2ZLJaaFE5sPgGlxdUw6E7WkDKYJHdiZ2R0fBK0B5p3HQBbNrBj6mC4XEhn5bm+FVzU5Z2GAYpS09pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Xh6g7ejx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIMnte++; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 62370138FDB9;
	Mon,  5 Aug 2024 04:54:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 04:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848065; x=
	1722934465; bh=z5mX0VvBucVVAQ3hVsBzbK3EagpAINO+dbqWRzZbXyg=; b=X
	h6g7ejxo2MhzpEfm9xxoolJvrRH8FOjMP0H4ElIzP1rq/ei13Rqcl1sfdUvB7O59
	yiXIlPwT698FehcvZ5+k+RWdu4mDz1w6Ler5EwNbjRypOq6OGcSnknqRXU8FwgdG
	LON8sIZxgB1Xj1ymh51+pi45DoNwL11esSfZOuDNJZsO69ucSIeUq70yM3iFPfvg
	k2/goSiMqKHE8pJfscwbThbpd+fZf7YVwpox8Yg5C6wigj0rjDi4PpTWSTeQ0XH2
	Cm3AYjiwAeODAqzyqnW1gwWZmrhWmDXn3mXWeHsS1SRUi5NuPwpFaqpN7LAStkMT
	TzMl/7xc9psNXwXX68UpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848065; x=
	1722934465; bh=z5mX0VvBucVVAQ3hVsBzbK3EagpAINO+dbqWRzZbXyg=; b=E
	IMnte++qSGMUsH4kPyDQq6ah0C1GhMeOYpergolJKTwyBsfdb9UpCOipm0Ltu6LX
	pbutu1cgMdg/pTRHqTPMGJ2jTYJvj6tYr4Lb45r6vBMCKRNqX5DNfrjdtOzRA8Dd
	Z3a5+xBfbMvdj4midD7XYYtCzdrdYUK8PFzLCmHVXfolpTPfKOgZSad1OhlGBcfR
	fbEVy/cX+tnsuk+kLeX/g6M8eRbPCQpihAkEpxCMIrsdnqqBwqGRWDIXOxhst3k4
	KEE96wbR5/PyvZ4TqYkB+x+KHOg9WG2TyHItUsUe25NBivwqRiyMUGClFk5p8zHJ
	LPQOCra2NCmrgFFfu4Dpg==
X-ME-Sender: <xms:QZOwZpFzlANOeG2L3-Ta7TVVBjYt9gsVxKaYFeE1d3GfTnlq4E-MhQ>
    <xme:QZOwZuWWq3UCVZXmbQ-ELVaLouoPDhlITfP-6gL71xoyaV8p_Ryz0okYKvzUFH1UX
    GhffEKHyfU1ayec1gY>
X-ME-Received: <xmr:QZOwZrJVHey3iFrnDiJruis5HWm_d8RbGvHA5EBJTm06UQIVVlYnUw5_HbiqgItXaje87iJ7GpSZ2rxyKEkgCUBMILiizOZgoxaiHj-nWsk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:QZOwZvHUdoR3381lKctwcA7sjGaqQHRsLi_TwPmZLnkRNeXyDJi6vQ>
    <xmx:QZOwZvX0WLKJSQ9OmfaEgfBu2BaT5EMsHb98kkF3L6SVoWGSKc7K9Q>
    <xmx:QZOwZqMGt6T-zMo5wlKMWllGMHhI_-wYunQNcbJuuoEcHsi3D79oxA>
    <xmx:QZOwZu3WxXxH4AbEHE5OU-pNbNvVyCugHpJPOxJKXt_N-K3A2pMSEQ>
    <xmx:QZOwZsjLz4wdaaJ815LGZjWGj2XOoFq3Y1xd-TD9nnWCIeKDosTHdmml>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:24 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/17] firewire: core: use guard macro to maintain IDR of isochronous resources for userspace clients
Date: Mon,  5 Aug 2024 17:54:01 +0900
Message-ID: <20240805085408.251763-11-o-takashi@sakamocchi.jp>
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


