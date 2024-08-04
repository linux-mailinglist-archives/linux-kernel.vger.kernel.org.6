Return-Path: <linux-kernel+bounces-273851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37729946EE7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DA22825FA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87C13AA27;
	Sun,  4 Aug 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="z5gvarZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bVxsJfQV"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A1139D00
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776567; cv=none; b=ADnEC+wrLNOVbonai02OdDYMhXbMqfKw5zmIuhihpdogtQpq4zCOzVgm6KCGF8YJWhdNe3AcmywYY2N5c9xXZ5nfzvBzJJU+s43jkRLgJWstyBElor6DG0eJMHr8uBoEVRg2g1b4G+jX30/NMcf2k+/yegZxsTjxRRAaHSbAKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776567; c=relaxed/simple;
	bh=byjeyaU0KCacHc1trU6Nd+xN8T9yKFSqZfE68WM9laI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgy1QYFXKLcegXQMeQtNyABGz7oStpVCDX68Xz6w189VxN8ycREBUkdZ4k73ni9QeCw68SA+CvfBTiLv4foIuhvZQmrUkib8XfDD2drjMTmNIukS6pOPchlE1IT+9NK+4HuS5RzLQlEmvLIcjjE4JWQg5b5QMaXh/wC1hqju+U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=z5gvarZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bVxsJfQV; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9FE011388027;
	Sun,  4 Aug 2024 09:02:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 04 Aug 2024 09:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776565; x=
	1722862965; bh=p2/8Uhv2yJT1ffx5iSM4w272zr0fR0S1Kk6bKcSHexE=; b=z
	5gvarZWqQrNiNMIo/CN1xbPcW5e+Nof6TdwEmjGNaGubH+PBYOfGMupzl/wkhUPz
	FbOGdR99Xa+oHlU2ht9dCkubTBZUTwoKR0qUpNfE86qSAPN5rLhqek7VPhlvOYeV
	ggdXepP04nnJ5FKgGBB4rE7U3gCeujoVXEOiI2WyI6F7k5z3s4nUrKoGtWZRtfJu
	lx86VSQO4GKtM8zhFvk35kaKZGAsVkaP6yX1J+X4B1MSS8T5ybVmRJnO7erkbf0z
	d5iF84buqWABw6ZIz8CZb8L/yDFQACtl6KrglcJ3M6e0IuADm9keIdJZ2gA7nfN7
	9C0kLOhEvtgS5m8TgCirw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776565; x=
	1722862965; bh=p2/8Uhv2yJT1ffx5iSM4w272zr0fR0S1Kk6bKcSHexE=; b=b
	VxsJfQV5eZWeCL+YAhRC6p3WLoJx8ca8F/n/HSlFbrDmazLpKA6pb/Smsxt0SZ+l
	J5JsR2+F4fBegC/ZWpEjU0hW7BXGUVj0iidjPlu/ljLeubTXiRgzPP5XsMnVvFOZ
	3vLNurdKW+1HBP68TA34C3dFJ1wHKHSDLeONjKOPdSPI15U4o1N8d/GSSxmZnCzM
	VUPIW1UhlHtx3+3F942rcgIJY4wXTKPIm/HoaA/OAk0Oq3k0YQbewah4HuB7QVhG
	auuGweGuCcOjfeIcoXVom+Q/XJFhLegkkUIfe0h3kI/NZRAjwBuSebHR6UKlam9G
	e/z61NRnnYhW7ePBCARMQ==
X-ME-Sender: <xms:9XuvZi07DOjLFoeVhgni1Vqp1H7Qnlyt4Fh-b7k1mNRVpMTMsSdPPg>
    <xme:9XuvZlG80aXxLLu4y5vZxJO_e1skgg9Xb1hfrCQpc3D-lv3xmbPyEOr6M9wK_1Av8
    84Q4977zyJIENlpuB4>
X-ME-Received: <xmr:9XuvZq5MitkA2FLApNuhy1ocFnebq3uBq44sDQWlr3Y1MBrRBgBJqmdwt6bu0jeJYaYvvx1tlvHMWnCx0Y_jU1KDWKJT5_KbKJRlkJ_La8G_7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:9XuvZj1mErpqrhVRQQmMekHORShOeJgmrHP188xMCxLH15w422lnEg>
    <xmx:9XuvZlEaMCRfXwCKoytHdESd0KcvaRNFAUq9K5o9qfnK4CX6S6pAoA>
    <xmx:9XuvZs-WsqFKB_HPI01NCQNKB1fo6YSnMj9SwJ_aM1zAv74_tU0BjQ>
    <xmx:9XuvZqnB-Ueh8htH-g2h6HVJYRP5Wfo0DPmhwLYLPu7Up0BfnqeQ0w>
    <xmx:9XuvZqTAC2TYn5OKEcroyHzk_puqXOT60A1C1_XOjToPg4SLSQvYJqZF>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:44 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] firewire: core: use guard macro to maintain list of receivers for phy configuration packets
Date: Sun,  4 Aug 2024 22:02:19 +0900
Message-ID: <20240804130225.243496-13-o-takashi@sakamocchi.jp>
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

The core function maintains clients to receive phy configuration packets
by list in the instance of fw_card. The concurrent access to the list is
protected by spinlock in the instance.

This commit uses guard macro to maintain the list.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index ac6f9ad9e88e..f32f8667ef2c 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1659,26 +1659,22 @@ static int ioctl_receive_phy_packets(struct client *client, union ioctl_arg *arg
 	if (!client->device->is_local)
 		return -ENOSYS;
 
-	spin_lock_irq(&card->lock);
+	guard(spinlock_irq)(&card->lock);
 
 	list_move_tail(&client->phy_receiver_link, &card->phy_receiver_list);
 	client->phy_receiver_closure = a->closure;
 
-	spin_unlock_irq(&card->lock);
-
 	return 0;
 }
 
 void fw_cdev_handle_phy_packet(struct fw_card *card, struct fw_packet *p)
 {
 	struct client *client;
-	struct inbound_phy_packet_event *e;
-	unsigned long flags;
 
-	spin_lock_irqsave(&card->lock, flags);
+	guard(spinlock_irqsave)(&card->lock);
 
 	list_for_each_entry(client, &card->phy_receiver_list, phy_receiver_link) {
-		e = kmalloc(sizeof(*e) + 8, GFP_ATOMIC);
+		struct inbound_phy_packet_event *e = kmalloc(sizeof(*e) + 8, GFP_ATOMIC);
 		if (e == NULL)
 			break;
 
@@ -1706,8 +1702,6 @@ void fw_cdev_handle_phy_packet(struct fw_card *card, struct fw_packet *p)
 			queue_event(client, &e->event, &e->phy_packet, sizeof(*pp) + 8, NULL, 0);
 		}
 	}
-
-	spin_unlock_irqrestore(&card->lock, flags);
 }
 
 static int (* const ioctl_handlers[])(struct client *, union ioctl_arg *) = {
@@ -1855,9 +1849,8 @@ static int fw_device_op_release(struct inode *inode, struct file *file)
 	struct client *client = file->private_data;
 	struct event *event, *next_event;
 
-	spin_lock_irq(&client->device->card->lock);
-	list_del(&client->phy_receiver_link);
-	spin_unlock_irq(&client->device->card->lock);
+	scoped_guard(spinlock_irq, &client->device->card->lock)
+		list_del(&client->phy_receiver_link);
 
 	scoped_guard(mutex, &client->device->client_list_mutex)
 		list_del(&client->link);
-- 
2.43.0


