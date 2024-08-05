Return-Path: <linux-kernel+bounces-274395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95009477B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80021281617
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EDD14F9F1;
	Mon,  5 Aug 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="i4C8WxQh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nWfhaVPR"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0A155C83
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848069; cv=none; b=Xd2qQb3XYy+fDJ5xGcRbStJddp1i1dlT18GKeMLoX+XAxlZsedQG/l4QpuJExldYadQo6+4Jzzm+reZXLW9GfkJrop3/uvqUJ7MP/U7S77MVqUkS/c+uLyO+4VrTmhHI+CzoZYnFcBMF0arPAwNqCaGNUyUQWgt46CzZaqifl6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848069; c=relaxed/simple;
	bh=50aZcCKLJeunfclbsZ1zlynb/h3MqzlmknN/YhwoRVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRyJ8548fCvCIEUitzA51AUIfRMzxbLsGluNmdoAe7Y2UcmcvRJSEdhJfuUencoWkXWCxzzPf10Y8t4ZHp6KC4PnFZyTOfA3cbmy/fx/fNJc9IxIkQkL40JdRjb9ncNfOi1TF/4svy0m0ZqgOlJfrDPVxTBvUvwJBZIjaIdC9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=i4C8WxQh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nWfhaVPR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id B24A3138FCF9;
	Mon,  5 Aug 2024 04:54:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 04:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848066; x=
	1722934466; bh=CAposS/X5iD+uiuVXyMO8x9mAy4UkjQlQ0BVV7Nspq0=; b=i
	4C8WxQhDARDG+3LiYI4k8O/8nA9xmrjicpvWvTszzuH7q3VVQZQ7930fPHTN8Aaq
	JZh9sfxmMNtG/Ek6kS2Ig+l7hcf9VZ2yA5g8mtGiFV2UI+WMnr8mef4I0Ro/c3KP
	b6BnkfyuT2rGAlfbSheB0VOwK/ME5X4jWERfoFlDU8hTCsteCXnn8Y3YqWqpNzo7
	mM/zy3/VXpXyodQNBqRTHz92cxZI8FISjrRSf5gxG9A8NDRkS1l1/kndVhOSnWGW
	3WeapqNmtMmrtaXo4v4GmO8irzvIiOM9Qs09hnJYmR8yWo7mxHJpjku8cvXbyBWk
	4Rs7aA7ojLWBZ/LMX8jOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848066; x=
	1722934466; bh=CAposS/X5iD+uiuVXyMO8x9mAy4UkjQlQ0BVV7Nspq0=; b=n
	WfhaVPRGPMQEvJk48/CneWh/PRAuCf1zhXs+smnQhUGWUU5ZnLxk8Iez8jscf+ub
	Kh8g/CQyLfY03DqbhWRzCVSQA7VuHve+jCqnnhOcb2actrbwNN145rKab3hXG07c
	bCkv554Vl6IauRScGMjHSJbMqMr7ObxJOAMbnkvHRE0iSclL9ONsnpbXfipPbzmt
	dVomF2TsWIaW8K4p9Aq9XPEYcKj7EhteLKXBqURYfCbp9IC2hcgq0lRvYckwCvTD
	xCb36WCH88dh5oPrtWiAEcqCZ9OlEtnFZDnB6JT41s7Q78mG7KdbD0qpaFWAH74w
	3aHlOvSseLV0tWaMHZPMg==
X-ME-Sender: <xms:QpOwZtMxxfkoByKLNNW7zyeksrUGwIhKV4PmVNaNJwfVWjtFx2FQJw>
    <xme:QpOwZv_kM7TQwRRqbonQsCC2VvMM4Ksxo2D9FUwgz-cdQ-KpdOobNaiXUSGbj-dj_
    m63O3wi7GLR9xzBM9Q>
X-ME-Received: <xmr:QpOwZsTySY75ZZmVeVabCr8oZ1LMxz0tSbqoniAmoSVAVdqCPgsD2pVtxLICI4ub88nUSD-HX9vbr2UPhiVrfjpcT4LOsPq-e-L0U0g6Ghk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:QpOwZpvhKw9xPmZc9T6E_49ehV4RyKeX3z4HTYfc1L_7WsxNVIHnRw>
    <xmx:QpOwZlcViINVR9iN9jLEqq-MxWnyzIiXD3O4fWxz8d0fmB82FUGgCg>
    <xmx:QpOwZl3cN-NWMERGVWqnfKdiLM0kBG3-vacXuRw5oSNa5TlNMj9uRw>
    <xmx:QpOwZh_zHS1F7MbLHy-64FsM8kV4r-8MS63iShJ_mfWieNKKr6gPaQ>
    <xmx:QpOwZmrWKVWJA6h2myXYk_iAozrOEOdaSe-ZUYG7y7s7vmsSs2yS3eK9>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:25 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/17] firewire: core: use guard macro to maintain isochronous context for userspace client
Date: Mon,  5 Aug 2024 17:54:02 +0900
Message-ID: <20240805085408.251763-12-o-takashi@sakamocchi.jp>
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


