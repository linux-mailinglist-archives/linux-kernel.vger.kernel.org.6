Return-Path: <linux-kernel+bounces-273841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459E0946ECB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70EE1F21723
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA53BBF7;
	Sun,  4 Aug 2024 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BorCRmev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTceX0f7"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468EE210FB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776555; cv=none; b=O4FCQRd5ww35gX5Orsk+SterYxcGgFaB7VmOAJSTRhAeVZLkwJ4AHyme/ZjIDzaSH8stRuxzc+BQRlz/OWtbOc/VGn0JE1qoE2mSXp/2K7sgxl0RAGnsCVZx2FUsyujHQtnz7P8HSlicqGZkVEheK+4ia7o6KW7/rEdAKfm5s5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776555; c=relaxed/simple;
	bh=w7k0vH2F9MOx4njtAUYL+RMBDZfz4ElgK8jF9a0p6F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=en6nvkdGTnhsRW/6gnPv7babepZAhWjuj7xjfBixFsvvLK0l6nvb8hVwIVLBj8IY2KSkIZZ0ds3mftpruJ0AOLHwaI7/vgLuEqd2DlmHcilAHvxZSU3xNmfyksykLIKLqO7lq01Rx2XYYx2f6vHf/6CmSLZ1+cu2sA8iRVemOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=BorCRmev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTceX0f7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5665B1147EEC;
	Sun,  4 Aug 2024 09:02:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 04 Aug 2024 09:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776552; x=
	1722862952; bh=o9vF7u9NUcybsaqu9wuw/REBguJhypKXIzx9986qq3g=; b=B
	orCRmevl0USxohGWZC6o+oUYLxDUBHC+U/w0EW+ZZTc+PGA4KD6cXRyrCK3xHFCj
	PoeD34bVBynRNpME3TZNlfyMe1X24oF1wuh4pgBLU8mYVdbh4fXpS2v2ug7auJqB
	wQeXtnuiLvnvUu4/nERA6LT8IDtXaBvnIXpp5+Y1UA08Nccel5gXwGHDgAiVU21y
	X+5qLRJv5S5OLlnoCNecvJ1kzcg04tKOwBbSRVL7hV6zNeZZ1KBag7jmYnWzRInw
	Wmq5WjY4OALxav0IZzWeuSBdbbH6mJd9RHQFouTNx5BYrjaibyArWmu7MKwLtxiK
	k8p5RCOZgYDRh17TLiOqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776552; x=
	1722862952; bh=o9vF7u9NUcybsaqu9wuw/REBguJhypKXIzx9986qq3g=; b=o
	TceX0f7cxa1lc9Q7eNYtm/mUGHTDnyDBylI75xUvvXwm3/Wz6EowHxFBWQTC4ZB3
	0AWp93GavKUzNvLcv9DjJgYlUnnIYxku1L3jruziLeoJXPCjul564CU8mbJwaNHF
	ypPfRnNSlHnMZAbFBLQcGs7x1LQRbX94YQDeOwXnR2I4m4iV0Btbe/u3Zldwc0u4
	xyQPAOHYrW3HsXKaOLuZdn36KM8iH+/7YaiJiB6jcL4cpoA6X+2OcY7/VBOz/V/g
	eZpGnfMMW6svGyO3LhnSmxM+Ddj7q8h4nAM27Pd0U/K5COPxkm0mQLtgfz+RYVBo
	UQmL+ZW2L2UvtNXcVSapQ==
X-ME-Sender: <xms:6HuvZjNJXfW4p2hwhW5ToZQHn5ldmU4Mz16A0lTjzG3D0xI2DBZFtg>
    <xme:6HuvZt8YdkVeFfSi8qa3KMzAovTJzLnnj1cn21SPNGviO-ijuVleUQQF5mjjU6QPl
    uMTI6XeGCorv0BCd38>
X-ME-Received: <xmr:6HuvZiRJlfTCzitcJxvhH94sPioJ80Mw4VZ_l7mhX3PLxeA14riVhE4tuu8Ub0mgo4EZLqZpJFDaTDnAHnSyTs2LLe_m9Uz0X019oqISOoRl8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:6HuvZnvoWS0x-QOYiGlAQgMZ3ABRBtPH68oEmPxnwMqVdCcFS-5p8g>
    <xmx:6HuvZrdCzk10puB9rwRdyw4Qf9BUIHCEUMKpIoonnaGNZutcSE23ag>
    <xmx:6HuvZj1uXSSZqIyDsxDzKJDumN2-Mhpyiih2WDctDl0P64UANybWjg>
    <xmx:6HuvZn9PrGVubAJvnQ-wPnnBIJTns3WtMd8jxdwUhKj08m0G6zNHLw>
    <xmx:6HuvZspPRC2VfbycT3iph9dV3I00iYPd-GKXWsCeEcgZUvpi0epMaCRb>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:31 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] firewire: core: use guard macro to maintain the list of card
Date: Sun,  4 Aug 2024 22:02:09 +0900
Message-ID: <20240804130225.243496-3-o-takashi@sakamocchi.jp>
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

The core function maintains registered cards by list. The concurrent
access to the list is protected by static mutex.

This commit uses guard macro to maintain the mutex.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 44 +++++++++++++++---------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index f8b99dd6cd82..79a5b19e9d18 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -168,7 +168,6 @@ static size_t required_space(struct fw_descriptor *desc)
 int fw_core_add_descriptor(struct fw_descriptor *desc)
 {
 	size_t i;
-	int ret;
 
 	/*
 	 * Check descriptor is valid; the length of all blocks in the
@@ -182,29 +181,25 @@ int fw_core_add_descriptor(struct fw_descriptor *desc)
 	if (i != desc->length)
 		return -EINVAL;
 
-	mutex_lock(&card_mutex);
+	guard(mutex)(&card_mutex);
 
-	if (config_rom_length + required_space(desc) > 256) {
-		ret = -EBUSY;
-	} else {
-		list_add_tail(&desc->link, &descriptor_list);
-		config_rom_length += required_space(desc);
-		descriptor_count++;
-		if (desc->immediate > 0)
-			descriptor_count++;
-		update_config_roms();
-		ret = 0;
-	}
+	if (config_rom_length + required_space(desc) > 256)
+		return -EBUSY;
 
-	mutex_unlock(&card_mutex);
+	list_add_tail(&desc->link, &descriptor_list);
+	config_rom_length += required_space(desc);
+	descriptor_count++;
+	if (desc->immediate > 0)
+		descriptor_count++;
+	update_config_roms();
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(fw_core_add_descriptor);
 
 void fw_core_remove_descriptor(struct fw_descriptor *desc)
 {
-	mutex_lock(&card_mutex);
+	guard(mutex)(&card_mutex);
 
 	list_del(&desc->link);
 	config_rom_length -= required_space(desc);
@@ -212,8 +207,6 @@ void fw_core_remove_descriptor(struct fw_descriptor *desc)
 	if (desc->immediate > 0)
 		descriptor_count--;
 	update_config_roms();
-
-	mutex_unlock(&card_mutex);
 }
 EXPORT_SYMBOL(fw_core_remove_descriptor);
 
@@ -587,16 +580,16 @@ int fw_card_add(struct fw_card *card,
 	card->link_speed = link_speed;
 	card->guid = guid;
 
-	mutex_lock(&card_mutex);
+	guard(mutex)(&card_mutex);
 
 	generate_config_rom(card, tmp_config_rom);
 	ret = card->driver->enable(card, tmp_config_rom, config_rom_length);
-	if (ret == 0)
-		list_add_tail(&card->link, &card_list);
+	if (ret < 0)
+		return ret;
 
-	mutex_unlock(&card_mutex);
+	list_add_tail(&card->link, &card_list);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(fw_card_add);
 
@@ -720,9 +713,8 @@ void fw_core_remove_card(struct fw_card *card)
 				     PHY_LINK_ACTIVE | PHY_CONTENDER, 0);
 	fw_schedule_bus_reset(card, false, true);
 
-	mutex_lock(&card_mutex);
-	list_del_init(&card->link);
-	mutex_unlock(&card_mutex);
+	scoped_guard(mutex, &card_mutex)
+		list_del_init(&card->link);
 
 	/* Switch off most of the card driver interface. */
 	dummy_driver.free_iso_context	= card->driver->free_iso_context;
-- 
2.43.0


