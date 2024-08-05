Return-Path: <linux-kernel+bounces-274393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E569477B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62DCB229FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AAB155A53;
	Mon,  5 Aug 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="orDCVfoT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SE/CGVgO"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED54B155389
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848066; cv=none; b=Z48Y1qpQijljBYWUIlb3IwxLnzOA4mhe60KR+c+HvZW7izDYfsOvgQfnPterarjVBpIREH+l3gXrOqqbKozgpSGTqwGu9pGHlNdrP+PuZIFW6VjH1RcRR+Ph9PiJKTeNP0YInRMlacog/Iye/0rKkBYoYUA7OnCw4gsBLdiSp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848066; c=relaxed/simple;
	bh=3M4QOIj5f1Z1b9G9IJV0Sp/2cF6cD0jloZp0mRO2NP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSLuD3WgpH8wl8w7vkUOgkFKZD2pf9WS0rkT7vhhasz1iuBUQBNprV0MGRnXOM+fzyla+GdWZ3EVFRJLOmFDXkGGBuuS7dHIOmCHuM2aAP3E+Xa4PoEuJBhumA/F/Hi6sk4oQ5l8GLNVoJui2Q1Bx+vtR0CHQFMSkyefOsk7nHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=orDCVfoT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SE/CGVgO; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 081151151CA1;
	Mon,  5 Aug 2024 04:54:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 05 Aug 2024 04:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848064; x=
	1722934464; bh=cnExW14OrezM7AAY2ZcP4bF1stBaSNMPihuGoMDdgLg=; b=o
	rDCVfoTtUc/UYhoAS6nscznEnCaUXU0brCBRTBpaFIHOZLi/oqE20jibt3t+ybgq
	ajHzY9r9z7yXJ+XPYLcLsJZmkYw3sulBL3ShSdqyZHwJjMDHVcUcREG6kNT85+Xl
	bBA+9UhJqu6LAZ3nxIK2Nlm72iw7qP3zrCf4/V/QroTza5G4mGKEob0B2OsRGWim
	oB4KoQ4+JWldFTHEl7H89n8d5vWMSPhVbPsQfz0TYuceYnfPiwQlCVGT6LYKwUZh
	PSFgiUsRnzqGrbmg7TnOWXPDUjKmeYmF8YhQsYXmhqkchnYGntdzirp5exOyqeOQ
	0VFTavG9XZj7omK8QlaOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848064; x=
	1722934464; bh=cnExW14OrezM7AAY2ZcP4bF1stBaSNMPihuGoMDdgLg=; b=S
	E/CGVgOWXPN3sF+d1kh3rpplEhvb9tDX6vqnP4eB9OqJtqR7tKYwlQVAq7n1v1k8
	1bbysimWOi5HMCHX7U46jLiYxdv54jYma5u72akT8Ic4Isar4Ticrl6g3xpcYjpo
	tDZVf+P0Oh6wRU65SpwLeFiCcdQ5ymw+/WAWaPFtMzZgwnL2P+WMiNJz0W6yP97U
	XM3tjbVVW/ZXu+w/3vhio+91lwp9y04itFY+OYobeKrd1+J0ixRrcOSteol45zZF
	4b6kqCp2skXPs2mQkuDwL7ipI0L1okh1YpixvlnQzcb06HkIud2Lc5M4flTKgyD4
	daPa3WnH1/zJOitvUftsQ==
X-ME-Sender: <xms:P5OwZs_07PksEf_ubNVJoKUkOpG6qF3waqgn-8L7m8r5s9R7bRlWGQ>
    <xme:P5OwZktSoMYg16UCer16zz1fUC-tyhh5p54psk_cvkmzlE0MMQU5TG2dti2bJXSLU
    3PDzwjRhOxW5Yid6BY>
X-ME-Received: <xmr:P5OwZiDEtnqyKjQAyvhvNEok8HDUadyqMh7UgoO4kkzc6HtlrR9py_SsHVIb6GdT-YzrzNTshm8i1IfAY2DmHJBIeRc5yWpxjUtC93givs4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:P5OwZsetaUbUQonv8WrlQwW12aMJw9XYpH00tXCI-e1Ema3_vvY5LQ>
    <xmx:P5OwZhOM1-5b-VtuA6CMt_kVegqRIYb1fqG86xMPFv44IS15rfDT4Q>
    <xmx:P5OwZmlSCnY049FvBoL-p62oWMqzM21sIoMmIXzyO0T5Q3V0gxvl_w>
    <xmx:P5OwZjv-2AE1oE7Y5HxHqMelVHEgiMONCl0TO-xfwgjiic3MXiS3Qg>
    <xmx:QJOwZqboUnLo1TBNtzWRGP86SLhVMSXCJ4QmBiKVXmJ4M2aoEopvqy_n>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:22 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/17] firewire: core: use guard macro to maintain list of events for userspace clients
Date: Mon,  5 Aug 2024 17:54:00 +0900
Message-ID: <20240805085408.251763-10-o-takashi@sakamocchi.jp>
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


