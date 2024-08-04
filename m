Return-Path: <linux-kernel+bounces-273848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE9946EE4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C280F1C206A5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE80F13635F;
	Sun,  4 Aug 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="IhSBqh1g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFki4GMw"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7876048
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776563; cv=none; b=Rqn6bq8GiY4L4mDYJ58r65w6OlkooU5RfGaQVChzLtuCohXvmSNIpVW6M9dcvxNFQ44zDjtCcmcQeUvLc2mX9CnMgFl76ODAsklGjx1L2VFLK9YtQay9QDcPSxrKm5ylBGvOYzrL0388bOfwnAc5ts406x0MfBlFs4EarPdSWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776563; c=relaxed/simple;
	bh=3M4QOIj5f1Z1b9G9IJV0Sp/2cF6cD0jloZp0mRO2NP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQvwy08PWJg4uctSmGm7ZgngMu2r1Gh1EVebNqAhwAzQ4nrhYOnwz6hqjOi7iM6j4caL9VrTThh08hIcsXCOsmQ5CgjJR00aM+FIJyj1Zfk6yNThfF6KIO6oWfFBL3fS0a06vkDbtX/VST5TEXkYl3QNpyygsE9eZ28qXTfV4wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=IhSBqh1g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFki4GMw; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id A388F138817A;
	Sun,  4 Aug 2024 09:02:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 04 Aug 2024 09:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776561; x=
	1722862961; bh=cnExW14OrezM7AAY2ZcP4bF1stBaSNMPihuGoMDdgLg=; b=I
	hSBqh1gvrjtcsEc0nKOcGMM5dpTiQtMkhlsnKMX/GrX748Mwsxc99mAOuSCoRAdH
	W+QoaDEg4pCiOVqk4jF2EdNjX0R0XTc55c9+jkq3fz1jJLpScfsiIT7bL8+bcRO8
	TTC4ybgMzEhQpG1zRrXDpU7aOJb9mY5aMBw9dSifXONmfY6RNYOeu1T3gTT8ZCJ3
	mH+VgTfkHufa4KXNmroiSuPJhSigHPeB/4W825hL4HPuE1m2V1GBXuI2aOD4xHa2
	rnBNn90kz3RDfO4bmzUdmvDBjb/6a16fBO8wefeC+SO79RVj0dx+E29QE+X1u2Ng
	1W9b2hskRPQenduOZfwrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776561; x=
	1722862961; bh=cnExW14OrezM7AAY2ZcP4bF1stBaSNMPihuGoMDdgLg=; b=S
	Fki4GMwOEDoZK8ctjVyZ3LgSQvwT+4TaR8tQcI8KUVK92bw3C3ODJvQgNoicwyo4
	aboA8yb0tYl4Ekbb00KkphIZSb8NP7A0r/ykQOIA4UOSETXqNRfLAowERfS2oamU
	vUA7PtJ2AlCXhr+beIgxhpvFQzvxtEF9edtdatCBuD3iubjPze75AHkbq0Z1UTty
	OYDn7n+v/GX+LuV208ESMPIa3HX1xpznXVUrfSDaBu7uMp3vr91oPyjWOwKh4ojV
	E+LlKpSvaEq0sfwyD+JW8Kh0pa4YRTQt/nwKDZLzOlBlVvUq1FLHFjJyotUCv53z
	aR4ToR4EwREGRHTM6euxw==
X-ME-Sender: <xms:8XuvZn3D8FSh53nYrPNrteV-Yug4vUQJhWXwl1kiCYg44ODzRO7r8A>
    <xme:8XuvZmGmV18mt356_7ncmLmaU2HPbF_qOw-oOzoRCpEgeacC_MWsFmxbgg3OIMG1x
    3hsXP0Qt_dTDARiJxw>
X-ME-Received: <xmr:8XuvZn5Vmc72em-U_r2VKncAe7OW1XPj8iH0qO_dwHsJJxV5wEV8xeVYmrC2-PPRs0PTTCCY56xQEawXFsOZNXI_iIA6DgiRJ1rIx-2LUUOZtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:8XuvZs0GJBNThAt_fkNbaupspV0VxrhnLx2zcgc0TgLbWz3IdmM0xw>
    <xmx:8XuvZqHXssuQniB9MlIDCp7OllbiUProQkgqqaiXYwIEE7Jst71zmA>
    <xmx:8XuvZt8RM1AUKovIejb62x0H-YkK5fJ1WhjKx9Z0M1efU6V_XyCuWA>
    <xmx:8XuvZnmH_lWuYm5lH3FUg_-21GYY_wy-0HoBkWKtChK77lZVBvf6Rg>
    <xmx:8XuvZvTXCjwV-wtF9E3muvzK4WKUDN5f0nfguULuKUokt9dcxO-J6jku>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:40 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] firewire: core: use guard macro to maintain list of events for userspace clients
Date: Sun,  4 Aug 2024 22:02:16 +0900
Message-ID: <20240804130225.243496-10-o-takashi@sakamocchi.jp>
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

The core function maintains events to userspace by list in the instance of
client. The concurrent access to the list is protected by spinlock in
the instance.

This commit uses guard macro to maintain the spinlock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 90e9dfed8681..2e2199eaa05b 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -287,19 +287,17 @@ static int fw_device_op_open(struct inode *inode, struct file *file)
 static void queue_event(struct client *client, struct event *event,
 			void *data0, size_t size0, void *data1, size_t size1)
 {
-	unsigned long flags;
-
 	event->v[0].data = data0;
 	event->v[0].size = size0;
 	event->v[1].data = data1;
 	event->v[1].size = size1;
 
-	spin_lock_irqsave(&client->lock, flags);
-	if (client->in_shutdown)
-		kfree(event);
-	else
-		list_add_tail(&event->link, &client->event_list);
-	spin_unlock_irqrestore(&client->lock, flags);
+	scoped_guard(spinlock_irqsave, &client->lock) {
+		if (client->in_shutdown)
+			kfree(event);
+		else
+			list_add_tail(&event->link, &client->event_list);
+	}
 
 	wake_up_interruptible(&client->wait);
 }
@@ -321,10 +319,10 @@ static int dequeue_event(struct client *client,
 		       fw_device_is_shutdown(client->device))
 		return -ENODEV;
 
-	spin_lock_irq(&client->lock);
-	event = list_first_entry(&client->event_list, struct event, link);
-	list_del(&event->link);
-	spin_unlock_irq(&client->lock);
+	scoped_guard(spinlock_irq, &client->lock) {
+		event = list_first_entry(&client->event_list, struct event, link);
+		list_del(&event->link);
+	}
 
 	total = 0;
 	for (i = 0; i < ARRAY_SIZE(event->v) && total < count; i++) {
@@ -1887,9 +1885,8 @@ static int fw_device_op_release(struct inode *inode, struct file *file)
 		fw_iso_buffer_destroy(&client->buffer, client->device->card);
 
 	/* Freeze client->resource_idr and client->event_list */
-	spin_lock_irq(&client->lock);
-	client->in_shutdown = true;
-	spin_unlock_irq(&client->lock);
+	scoped_guard(spinlock_irq, &client->lock)
+		client->in_shutdown = true;
 
 	wait_event(client->tx_flush_wait, !has_outbound_transactions(client));
 
-- 
2.43.0


