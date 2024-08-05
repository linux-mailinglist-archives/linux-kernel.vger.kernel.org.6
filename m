Return-Path: <linux-kernel+bounces-274386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0BD94779A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119E1281373
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF861527AF;
	Mon,  5 Aug 2024 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="0ZnoUAWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VGTmbNPQ"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE214B965
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848057; cv=none; b=YCLgIg88sLNhYeQ9do3q8ng9btnU68XVim+y5EpSYv6uWndEM+4I5bKNlgvN0HWp67mE+DULSZcBDXdVn1JpnCL4SmVkGpSQCQtfsXk3WtnOopI3ElRMP7tcXcVJvSTttfL9dRQjl8SIEuhFKQGgqoxOexjUI4vel38fZPbg5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848057; c=relaxed/simple;
	bh=w7k0vH2F9MOx4njtAUYL+RMBDZfz4ElgK8jF9a0p6F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqahygqdS7O9D/HnsXPoAMXNmIpFB+vb/Jq5N0RavZ/KMXI7aj9NEbGPJ3KONY+BAESfvJieAv0JsSMi8PT9zf24/coeqXZc/FdoOgZ+cjbIcuI3CemizC1V41ditcq6vCCJVinUSGYUIEWSBTYn8BM1Zmw+6nXYgAYanzRHKiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=0ZnoUAWc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VGTmbNPQ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A76671151C9F;
	Mon,  5 Aug 2024 04:54:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 05 Aug 2024 04:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848054; x=
	1722934454; bh=o9vF7u9NUcybsaqu9wuw/REBguJhypKXIzx9986qq3g=; b=0
	ZnoUAWcDrufjuLmbIgf26SSnB7pufxe1TDruZR/ybJtFEpNgQv+ET/qydg/a6ruc
	WGQ6m2dFz8CyjaDJZeWWWY3WYUjekT28PZLz5h/Ys0cR1W/ENyf0+IJUoom4r+wP
	J5pBSUjkPr4uWnEVESaALmYDX7Hdgnx+k7RuTF4i9U3FzlpdNfOR28DPt7TwKF8a
	w6/OitrJRQCT7fsDEU0xRiO6FqgiI1ikB9M+s+ChCPH4h1JNiIl1ltSzPdNuy1e2
	aJSShpqXyRsCl6NmDPU15uixf/FibiuXcJiF3h0AR+3hhkpnGH5//EKAMyZTe9dH
	o1AOz049c+jrPM3RsqJNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848054; x=
	1722934454; bh=o9vF7u9NUcybsaqu9wuw/REBguJhypKXIzx9986qq3g=; b=V
	GTmbNPQufO/mBa1N3vctZHfkH96XmOFcRLmRooWHfPgPPDXoxwPmIdKJx8i3R4Ze
	SMl0Yy416lREBRVQzeOoMCePudfCEyTeyW7O5MmiGCJ9wtvdaRlMgM2KwwWlWf8H
	K/BcI89Mt35474kxpv9IoeBWn85eqd5rzeSXAvHkiWvXr9fILvNU7nWgfZQlUQAH
	NY/WVRvWTPnmPnknsYy1yuN9LlTlXNLYrlEEi/ctajs31zG4EFPwOPh9tZyjunvc
	KuUYz9NNdYWCKTZ6oCrQDVlSB4Ao55eb6DtveNvCZmvaNq5+9K0UrOQHH9B3CYni
	KOfjANQfiAI/4F5Db349w==
X-ME-Sender: <xms:NpOwZjP84OSOfJGxLpsTXSJLy9_rf7blX1yWkIQ6jRH8dSAuNAMm1A>
    <xme:NpOwZt9PW5fwG4InyYFm3Z89jqQJMJiRV4WpyC2wn68zgrbn7cnFTOZjK9KUu8uK_
    M_8CqZMIAIwqz2cVS4>
X-ME-Received: <xmr:NpOwZiS0l3ZM94PCAtVVRIaXRoZabJgHYJZ3WkJqiPQWIhKWNF725cpdZc-RNa_fJqqXiiA4FEqp6z7GNGYmZAI8qUFFsMmMSqJvg-nPraE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:NpOwZnt3g1jVINCR65uXQ8FFdSzFnkyIRF8mQiSm0ZFW9eaJjKDmYQ>
    <xmx:NpOwZrcl-thJUyH5knjLadmjK-uopekH4x3e4PcQ3TqpiEegn2d_gg>
    <xmx:NpOwZj0V_xdo0IAcLWVvcyQf8T3zxq2HNpRo6qpcVsTy17Olj0dNKg>
    <xmx:NpOwZn9qilGflrUKMsdasH0bGWPaf-hHpdSVp_F79KvaYUYSU8schA>
    <xmx:NpOwZsqS6S7npCAME9f37HypwpslI4wcoRCm7eMQkUK3Kx6He7WPFlAY>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:13 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/17] firewire: core: use guard macro to maintain the list of card
Date: Mon,  5 Aug 2024 17:53:53 +0900
Message-ID: <20240805085408.251763-3-o-takashi@sakamocchi.jp>
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


