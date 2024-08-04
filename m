Return-Path: <linux-kernel+bounces-273850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC5A946EE6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B511F212A9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968E13A3FD;
	Sun,  4 Aug 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="m1VxmdCp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCRizvaM"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EEF137750
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776566; cv=none; b=H1bdkeB8Pr8xMMrSNNg7SJrut2IZbFFUBimidUO+7CDKIkxZyAH3RGvG5E0sVLYvFBVCidnPWcZsABWz8LcaFR67C6FA9cefUhtywCJDqcs15X0KH2NLRwQ1DBCeeuOIbn3q8m4gRrPn+VzaZA/Zb3vySoz1vAHmqnwDHUGTt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776566; c=relaxed/simple;
	bh=50aZcCKLJeunfclbsZ1zlynb/h3MqzlmknN/YhwoRVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iknv/SE72vUPL1O4gPaXCl3o5YXqy2yzWk4C5/oY4D3whQfWfONW9x5LDZF6KFIIJsR1tZCcHYwsDsRps1vUfoaglZjNWzTWY04DMvFzx/JZHkJng8n4czqGO+kcnKGmaTNavEJ2rtaC3dFm/6o983PiAFJu4ZdSopWluY4REgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=m1VxmdCp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCRizvaM; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5A54C1388033;
	Sun,  4 Aug 2024 09:02:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 04 Aug 2024 09:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776564; x=
	1722862964; bh=CAposS/X5iD+uiuVXyMO8x9mAy4UkjQlQ0BVV7Nspq0=; b=m
	1VxmdCpR5B92ufIdj30S9Vp5Vp1uDmMXYuxzOQGsq2nPpcscHeRjmJ6ull63MvwY
	q+j/wgCU263ClEi+B/Y13eSrAIeq4vO/1bUBjt8/bL32T8BTF+U1/9eN0NGPeaZi
	lov3HfIuU2Fh4AkDkhIJWvI/ic1M6oeM1F4Q9pZAApW/nmbi5kGlF1zmxJPqS0Jw
	GF3twUGPao7pUqJ9eH0tAMCHzwWtlLTd3IZK+Jdy3NkjrSB/WWExMlUJK3mtnp9J
	VXJEh0D3u49VS4xcJZQemHzSqH6ZFkTyjDxkl8zY28/MDE+1bNjnpadtqhGBL4sS
	GXa/ERDhxdeIqS6YjyXYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776564; x=
	1722862964; bh=CAposS/X5iD+uiuVXyMO8x9mAy4UkjQlQ0BVV7Nspq0=; b=R
	CRizvaMLeFGcShVXHNZWTW+0DXkUQbKv/tkOnZL7mLYx9lE/3zyR+hHzbsK6tVv0
	P9dhJOLXFkAaKg3Yct512qbMvrJD59GL5cR+gkGiVuopTRqflJTeKBOmOO8c0th0
	PvhJ5kai5haN3CeH71cBW/ootmLYT7SMFgHzQQprRz9bofGTkbutqaN/TcMgaw5V
	eIRg4yU4Sbma+HlYyExRrEVwJm/As0NG0p+awti8MP0X+DCls0NYdZgPU4Y/vl+n
	tZMTD0eEzcEUnL8GJ8JQS30poNs59iPlc/swOfTnXO9NPTK7yjPdB7JDBzqxQmVe
	XRXF4p3Li1UG74n4qUtLw==
X-ME-Sender: <xms:9HuvZnMSGjecfLQIPPeT1uzJuV9xDZ1HczQoWCbXAWHQq1QluDHvnQ>
    <xme:9HuvZh9Jp-Ykv2xq-bLN0fe4vE1kNZczJtWkSVIJ5j6Yvbb0xa4cMFQI7V0fXjQYu
    bOCRxmttOTcBeejK-4>
X-ME-Received: <xmr:9HuvZmRU4MJLfaRL_a18URWHCgYH5YLRkh94B23tlBuASQ5aZLF2k6uaeEAYAByPTGHagE7DF6iwQ5rvRMVQL8Csfklib_enFRIijQc80Fipzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:9HuvZrsyaU5vYcf10I_FgxJ_KZAtwaSG-KSjlO8ro96KWcJJJVpdkA>
    <xmx:9HuvZvdfBhFEt3tIi6ZQa9nDgHOI_sC_rrdVhzDd0MbjZXUZW_PzVw>
    <xmx:9HuvZn1iiSQNB1Q0ydFBCq4BCqjaqRZ8NOb_8TbefNs6CJNRkRHtEQ>
    <xmx:9HuvZr_O1KCdupup_ARpKg3fBQagaROWrdoCqnfItajL9CLoktOy2Q>
    <xmx:9HuvZgrV6isEDddZL_jnuq9SZoao2VKnhG71fKcaB54vq_qUBgFz3uEx>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:43 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] firewire: core: use guard macro to maintain isochronous context for userspace client
Date: Sun,  4 Aug 2024 22:02:18 +0900
Message-ID: <20240804130225.243496-12-o-takashi@sakamocchi.jp>
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

The core function allows one isochronous contexts per userspace client.
The concurrent access to the context is protected by spinlock in the
instance of client.

This commit uses guard macro to maintain the spinlock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index c2d24cc5c1f1..ac6f9ad9e88e 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1062,10 +1062,10 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 	if (client->version < FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW)
 		context->drop_overflow_headers = true;
 
-	/* We only support one context at this time. */
-	spin_lock_irq(&client->lock);
+	// We only support one context at this time.
+	guard(spinlock_irq)(&client->lock);
+
 	if (client->iso_context != NULL) {
-		spin_unlock_irq(&client->lock);
 		fw_iso_context_destroy(context);
 
 		return -EBUSY;
@@ -1075,7 +1075,6 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 					    client->device->card,
 					    iso_dma_direction(context));
 		if (ret < 0) {
-			spin_unlock_irq(&client->lock);
 			fw_iso_context_destroy(context);
 
 			return ret;
@@ -1084,7 +1083,6 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 	}
 	client->iso_closure = a->closure;
 	client->iso_context = context;
-	spin_unlock_irq(&client->lock);
 
 	a->handle = 0;
 
@@ -1806,16 +1804,15 @@ static int fw_device_op_mmap(struct file *file, struct vm_area_struct *vma)
 	if (ret < 0)
 		return ret;
 
-	spin_lock_irq(&client->lock);
-	if (client->iso_context) {
-		ret = fw_iso_buffer_map_dma(&client->buffer,
-				client->device->card,
-				iso_dma_direction(client->iso_context));
-		client->buffer_is_mapped = (ret == 0);
+	scoped_guard(spinlock_irq, &client->lock) {
+		if (client->iso_context) {
+			ret = fw_iso_buffer_map_dma(&client->buffer, client->device->card,
+						    iso_dma_direction(client->iso_context));
+			if (ret < 0)
+				goto fail;
+			client->buffer_is_mapped = true;
+		}
 	}
-	spin_unlock_irq(&client->lock);
-	if (ret < 0)
-		goto fail;
 
 	ret = vm_map_pages_zero(vma, client->buffer.pages,
 				client->buffer.page_count);
-- 
2.43.0


