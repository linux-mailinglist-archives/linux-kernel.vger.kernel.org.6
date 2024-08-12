Return-Path: <linux-kernel+bounces-283926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728C794FA75
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E391C22208
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380C019CCED;
	Mon, 12 Aug 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Yj+NBlbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tgMS1M/1"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392819ADBB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506743; cv=none; b=bwflAse7SfkMFQHHO3k2yqDqygO1OKTSAnm8fFe8soyKCYrIF6J4G1a/gztDSa55zn9lYSAcJ6MIma0wM9xsM3HEyOKI1w66bwZwTYrZt7UFSx9hioTrefD3XQLIK1t18yw7aMqq7cMhf0ONNno/i8cd+2+IfWamb8eqkaEBPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506743; c=relaxed/simple;
	bh=kohYd9tWqkktZ/r6GCVdidIRPztYnRzPFgJogqa383E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2QN6HxUrWEkTfc9k6vNDTN9Bb4QrfjqhHD3IGVsTp93z6AbNC0b5W3nPojYYZ5RdmjpTK1wBgfx3ymt57TFUIkCgqWsOgKwBQVpP4eOrhMbmbnWhrfFKCdX6pBWEhv5A5OjVyHr6onTSAasXZYsniL2YGA5/Zks30Sq41h1b54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Yj+NBlbM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tgMS1M/1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1BE981151B66;
	Mon, 12 Aug 2024 19:52:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 12 Aug 2024 19:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723506740; x=
	1723593140; bh=AGCPcXuZ+EA8kPdWP5AdSF60xmqg9P1trpkWAYoUGEs=; b=Y
	j+NBlbMicM5yraVen81NvyprMxGoB2u/JKxxtxNOoHzRjXV9h1Mr4OvjHyH3qma0
	V+TmeOMeJ4VrTyfk0H736ioGrWIlwrCjwkaKYMlu2sdrlRVRsCWRQ+NRYEa15uNb
	x49iWoKdgOgpftVkrMc9IHLxSOD0NDbbRCQwK9VY5NQWtKHUxGac1wkG2k5zgWdd
	kKvHKWkUg1LiS/P67b6rPG3lLe7Taz83ys513En5lr1UvdP/Gag3O47+no1mvFF3
	a5Hogz9jeRlCykTz3NdG6J9bldnhE4acBktxsQ6YDiHEnYs7Na83rDwoaBTfcX0g
	O2tWxuPdw26afeKQ9oM8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723506740; x=
	1723593140; bh=AGCPcXuZ+EA8kPdWP5AdSF60xmqg9P1trpkWAYoUGEs=; b=t
	gMS1M/1oZ3c+jAsRYbMdyJmoWXICDdDpneYCYRVOTgHspDK7D8RNq+hBvgmgNOoA
	Y00Nm1mlmWYSHcshavfR+xLbJWVbh3nkHNzy/nrFvHNxkHYKQarC0Rclau5alegQ
	KKWKwzKo4zgHpyh+DThHX6fV7jYqjrYcRswYcvOYvFu2KaK+uIKftcyJAuXM3OJK
	LhtPo72IRE/NWIiAgaVITF1yDCC8X9xneZCH+Par/+BIbP4NdAjWArMLk8pETytV
	0VhEhuLNRU1ErizdKieHYgkwIR7uKyeE3L8TwDdwVCLOnm3T1gxQULtIuLKNc5wS
	wuTBimEve7o1o6I8CUnOA==
X-ME-Sender: <xms:M6C6Zo1bIR9ck1-rQ50PNCQeg27NlpYtGHLDb0t1fDAIyXjDvlxUgQ>
    <xme:M6C6ZjHFZi2qZfDHRy_E1yCOFI8XjPXoGXxzD2FqMeR_CWMv8G7NzJ1GUeQqEpqYe
    p8EmR-Bf3bSZXv8sGw>
X-ME-Received: <xmr:M6C6Zg5UeOhYdgp9kRzip65oCFfjRhAbljMPoDbDxtFUSFN3N5qUKwWCzz1GD2-M7jXOvYR2xAPbQS_r-7bfG37oMyDYS2HSXxY3hs9Y8e94pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NKC6Zh3Ki_zL_PxCazAGYAchrZpvRPEsaA667VeM5QUEVryHryjteQ>
    <xmx:NKC6ZrHgGtQDI7IMUf-rmyrj9Dg7avvb7Bhnjb45xC5hwgHkurTDpA>
    <xmx:NKC6Zq9NY5fH0FqDByw2BLdQBDrAR1OQpCdpQp4i22erdy_SahzUjw>
    <xmx:NKC6ZgnfBH_wJkLynyifj6-ulRepNivM4Ucf3zSV7JXWZOQO6P6dbA>
    <xmx:NKC6ZgTzZC4nhjZ2TDTFIUPc7SSCwVKjjfULqkp4pR0SVZ0YWL_l8Q6u>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 19:52:18 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] firewire: core: use xarray instead of idr to maintain client resource
Date: Tue, 13 Aug 2024 08:52:10 +0900
Message-ID: <20240812235210.28458-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812235210.28458-1-o-takashi@sakamocchi.jp>
References: <20240812235210.28458-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In core function, the instances of some client resource structures are
maintained by IDR. As of kernel v6.0, IDR has been superseded by XArray
and deprecated.

This commit replaces the usage of IDR with XArray to maintain the
resource instances. The instance of XArray is allocated per client with
XA_FLAGS_ALLOC1 so that the index of allocated entry is greater than zero
and returns to user space client as handle of the resource.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 66 +++++++++++++++++++-----------------
 drivers/firewire/core.h      |  1 -
 2 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 83d25327c1d3..3ea220d96c31 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -14,7 +14,6 @@
 #include <linux/errno.h>
 #include <linux/firewire.h>
 #include <linux/firewire-cdev.h>
-#include <linux/idr.h>
 #include <linux/irqflags.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
@@ -54,7 +53,7 @@ struct client {
 
 	spinlock_t lock;
 	bool in_shutdown;
-	struct idr resource_idr;
+	struct xarray resource_xa;
 	struct list_head event_list;
 	wait_queue_head_t wait;
 	wait_queue_head_t tx_flush_wait;
@@ -297,7 +296,7 @@ static int fw_device_op_open(struct inode *inode, struct file *file)
 
 	client->device = device;
 	spin_lock_init(&client->lock);
-	idr_init(&client->resource_idr);
+	xa_init_flags(&client->resource_xa, XA_FLAGS_ALLOC1 | XA_FLAGS_LOCK_BH);
 	INIT_LIST_HEAD(&client->event_list);
 	init_waitqueue_head(&client->wait);
 	init_waitqueue_head(&client->tx_flush_wait);
@@ -407,7 +406,7 @@ static void queue_bus_reset_event(struct client *client)
 {
 	struct bus_reset_event *e;
 	struct client_resource *resource;
-	int id;
+	unsigned long index;
 
 	e = kzalloc(sizeof(*e), GFP_KERNEL);
 	if (e == NULL)
@@ -420,7 +419,7 @@ static void queue_bus_reset_event(struct client *client)
 
 	guard(spinlock_irq)(&client->lock);
 
-	idr_for_each_entry(&client->resource_idr, resource, id) {
+	xa_for_each(&client->resource_xa, index, resource) {
 		if (is_iso_resource(resource))
 			schedule_iso_resource(to_iso_resource(resource), 0);
 	}
@@ -501,31 +500,33 @@ static int ioctl_get_info(struct client *client, union ioctl_arg *arg)
 	return ret ? -EFAULT : 0;
 }
 
-static int add_client_resource(struct client *client,
-			       struct client_resource *resource, gfp_t gfp_mask)
+static int add_client_resource(struct client *client, struct client_resource *resource,
+			       gfp_t gfp_mask)
 {
-	bool preload = gfpflags_allow_blocking(gfp_mask);
 	int ret;
 
-	if (preload)
-		idr_preload(gfp_mask);
-
 	scoped_guard(spinlock_irqsave, &client->lock) {
-		if (client->in_shutdown)
+		u32 index;
+
+		if (client->in_shutdown) {
 			ret = -ECANCELED;
-		else
-			ret = idr_alloc(&client->resource_idr, resource, 0, 0, GFP_NOWAIT);
+		} else {
+			if (gfpflags_allow_blocking(gfp_mask)) {
+				ret = xa_alloc(&client->resource_xa, &index, resource, xa_limit_32b,
+					       GFP_NOWAIT);
+			} else {
+				ret = xa_alloc_bh(&client->resource_xa, &index, resource,
+						  xa_limit_32b, GFP_NOWAIT);
+			}
+		}
 		if (ret >= 0) {
-			resource->handle = ret;
+			resource->handle = index;
 			client_get(client);
 			if (is_iso_resource(resource))
 				schedule_iso_resource(to_iso_resource(resource), 0);
 		}
 	}
 
-	if (preload)
-		idr_preload_end();
-
 	return ret < 0 ? ret : 0;
 }
 
@@ -533,17 +534,18 @@ static int release_client_resource(struct client *client, u32 handle,
 				   client_resource_release_fn_t release,
 				   struct client_resource **return_resource)
 {
+	unsigned long index = handle;
 	struct client_resource *resource;
 
 	scoped_guard(spinlock_irq, &client->lock) {
 		if (client->in_shutdown)
 			return -EINVAL;
 
-		resource = idr_find(&client->resource_idr, handle);
+		resource = xa_load(&client->resource_xa, index);
 		if (!resource || resource->release != release)
 			return -EINVAL;
 
-		idr_remove(&client->resource_idr, handle);
+		xa_erase(&client->resource_xa, handle);
 	}
 
 	if (return_resource)
@@ -566,9 +568,10 @@ static void complete_transaction(struct fw_card *card, int rcode, u32 request_ts
 {
 	struct outbound_transaction_event *e = data;
 	struct client *client = e->client;
+	unsigned long index = e->r.resource.handle;
 
 	scoped_guard(spinlock_irqsave, &client->lock) {
-		idr_remove(&client->resource_idr, e->r.resource.handle);
+		xa_erase(&client->resource_xa, index);
 		if (client->in_shutdown)
 			wake_up(&client->tx_flush_wait);
 	}
@@ -619,7 +622,7 @@ static void complete_transaction(struct fw_card *card, int rcode, u32 request_ts
 		break;
 	}
 
-	/* Drop the idr's reference */
+	// Drop the xarray's reference.
 	client_put(client);
 }
 
@@ -1317,6 +1320,7 @@ static void iso_resource_work(struct work_struct *work)
 	struct iso_resource *r =
 			container_of(work, struct iso_resource, work.work);
 	struct client *client = r->client;
+	unsigned long index = r->resource.handle;
 	int generation, channel, bandwidth, todo;
 	bool skip, free, success;
 
@@ -1351,7 +1355,7 @@ static void iso_resource_work(struct work_struct *work)
 			todo == ISO_RES_ALLOC_ONCE);
 	/*
 	 * Is this generation outdated already?  As long as this resource sticks
-	 * in the idr, it will be scheduled again for a newer generation or at
+	 * in the xarray, it will be scheduled again for a newer generation or at
 	 * shutdown.
 	 */
 	if (channel == -EAGAIN &&
@@ -1366,10 +1370,10 @@ static void iso_resource_work(struct work_struct *work)
 		if (r->todo == ISO_RES_ALLOC)
 			r->todo = ISO_RES_REALLOC;
 		// Allocation or reallocation failure?  Pull this resource out of the
-		// idr and prepare for deletion, unless the client is shutting down.
+		// xarray and prepare for deletion, unless the client is shutting down.
 		if (r->todo == ISO_RES_REALLOC && !success &&
 		    !client->in_shutdown &&
-		    idr_remove(&client->resource_idr, r->resource.handle)) {
+		    xa_erase(&client->resource_xa, index)) {
 			client_put(client);
 			free = true;
 		}
@@ -1839,11 +1843,11 @@ static int fw_device_op_mmap(struct file *file, struct vm_area_struct *vma)
 static bool has_outbound_transactions(struct client *client)
 {
 	struct client_resource *resource;
-	int id;
+	unsigned long index;
 
 	guard(spinlock_irq)(&client->lock);
 
-	idr_for_each_entry(&client->resource_idr, resource, id) {
+	xa_for_each(&client->resource_xa, index, resource) {
 		if (is_outbound_transaction_resource(resource))
 			return true;
 	}
@@ -1856,7 +1860,7 @@ static int fw_device_op_release(struct inode *inode, struct file *file)
 	struct client *client = file->private_data;
 	struct event *event, *next_event;
 	struct client_resource *resource;
-	int id;
+	unsigned long index;
 
 	scoped_guard(spinlock_irq, &client->device->card->lock)
 		list_del(&client->phy_receiver_link);
@@ -1870,17 +1874,17 @@ static int fw_device_op_release(struct inode *inode, struct file *file)
 	if (client->buffer.pages)
 		fw_iso_buffer_destroy(&client->buffer, client->device->card);
 
-	/* Freeze client->resource_idr and client->event_list */
+	// Freeze client->resource_xa and client->event_list.
 	scoped_guard(spinlock_irq, &client->lock)
 		client->in_shutdown = true;
 
 	wait_event(client->tx_flush_wait, !has_outbound_transactions(client));
 
-	idr_for_each_entry(&client->resource_idr, resource, id) {
+	xa_for_each(&client->resource_xa, index, resource) {
 		resource->release(client, resource);
 		client_put(client);
 	}
-	idr_destroy(&client->resource_idr);
+	xa_destroy(&client->resource_xa);
 
 	list_for_each_entry_safe(event, next_event, &client->event_list, link)
 		kfree(event);
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 8cace026090c..57d101c01e36 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -7,7 +7,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/fs.h>
 #include <linux/list.h>
-#include <linux/idr.h>
 #include <linux/xarray.h>
 #include <linux/mm_types.h>
 #include <linux/rwsem.h>
-- 
2.43.0


