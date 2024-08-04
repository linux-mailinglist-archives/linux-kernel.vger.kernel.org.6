Return-Path: <linux-kernel+bounces-273844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4B9946EE0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1591C210D7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB5456766;
	Sun,  4 Aug 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="v4dlk2Cg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ahxdGVbH"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95147773
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776558; cv=none; b=XsDyJPxywOhyukW885tXxhszqf2GgkoKW1j+Nw9vF9W12WNwic876ty+n6wBKnI6StdZBVZEmdvrEKdGQuGTNkBiozU8An8gDNz+vBHb6I75zI4woBalcNepEwQjM8ZW89J476E+LHFlVzSq+4rubGjk+zE6Y9HaOSXUo1LlULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776558; c=relaxed/simple;
	bh=cscKU5uPCciyY7dYw/8esZBE005/LOUY76gf8+d1Fko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkfvbU0GUrnhkVAYqCFCkkoe+zRG5l2uYRfs/rOzTzTIBZjcPZnHvaerv97t1TcKWmSKA5bYwtilm+GBZzEOWi7uCNpRpNWO/hOdQ6NBvZQ7iBt4EEzCNguumrc2+81P3J+sv9j0YuASjuc5rE3/mZiuRq9pQ0g7O7xgdV2vogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=v4dlk2Cg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ahxdGVbH; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4B17B11481EB;
	Sun,  4 Aug 2024 09:02:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 04 Aug 2024 09:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776556; x=
	1722862956; bh=Qc/S6YXZ+4o3poTVbyilyGCeWi9HX+4N+cgNY9BibBI=; b=v
	4dlk2CgeNhcL7Ly2ue62WFXDjfMN/Bu806IMPBop8oqOYineurANx4G5ddPG6m4S
	+qT3tU3xv64Lo3wjYA+Kb3knaCGOIprhSv/n9iM/9i3nXp45lftExODrKZahcBXk
	cjlg+ZFSzbj/W5ea0AnrB39SquPVF+MlC+fZkqP3D6GYcRNz4T+mNKMv/5cHkmuX
	YizP6AFMn4Ay5o2z87S/5/wSR/8wkTbpJpiyY3614TwQ6bGB9BxOyFQ3yG6/H65h
	8h7V2MMT3ks9qeBlulO5wiCG+X67Iqda64aVGG8MTnkr0qhO5FPXgb0EwU8BleqH
	B5ryVKxuU9qruQ1aq320g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776556; x=
	1722862956; bh=Qc/S6YXZ+4o3poTVbyilyGCeWi9HX+4N+cgNY9BibBI=; b=a
	hxdGVbH5i/BdKRRvPn6D+pfzOPcEREtFwXJslIsJhLm4/r6Cw3BT2OD7aF11rOKf
	m8sEUseNk8iIOK1mKHhcDWfyouZfxuXcR1hqssnLtYX/oq2I0Dupq2YjrIuMEfrl
	3YloQ0abnE4GpvvXaORFSTxJdlohZZdwpyTKnS+WVjbcnFz8/1R0xIQrN9n5w0r0
	qxEl6Z68k4dRebt5RQVL0aanQYuxpea16mmmGKNCyiuVKQ3bj2BV/s1Edpm9ZJfY
	9o1FAiSSEDJYoNYeU1uAO3gFp2yz0aRS32z5weydfOiz0sn2QSzXoPSEF8FHivda
	hYj8ZACP++3iwFMu4T6MQ==
X-ME-Sender: <xms:7HuvZgd8-bbR5SoBxsDtxNxLhMhbtGoIN1gp6aynoPgSKm9qMDRm8w>
    <xme:7HuvZiM1Er7aXYw3_BRMR7VuYXSJWWyxmNB8_rx1lBGrIrPcyu8mJ55RPHjkumtQo
    _doY71gach-PTL4shI>
X-ME-Received: <xmr:7HuvZhhqIpf11NoZQN5WHBb0cypo7pQXQ3kiqIpim1bNtKWUc8JK-rI_o9oIX2bRUltGdD9MXP6ATHb2dPXpK6bK7aNw5JAXM-o4sSgCMFFM8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:7HuvZl8o_CeAf8cT6PMMlhlQZz5tEs6eDA1FUKVx5lf0fRAF6DRMxg>
    <xmx:7HuvZstOemiNmSnJxcgC63ReJNeSTnDmdK7BHsyz4bWxWzhrO299Eg>
    <xmx:7HuvZsGK6IxyEYKGHLA86SY5N6vV5hLAaPEsaHH76L3X7-nzGsn84g>
    <xmx:7HuvZrMLNqYaAxJ_Vi-5zZrBSqeytuQ8z4ytyGVqYyhFMa41SBec3w>
    <xmx:7HuvZl5K1qP2XYeUxM8_pByw_mf95kf90xmCSETj0CIdyhFTEp2fCh3C>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:35 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] firewire: core: use guard macro to maintain RCU scope for transaction address handler
Date: Sun,  4 Aug 2024 22:02:12 +0900
Message-ID: <20240804130225.243496-6-o-takashi@sakamocchi.jp>
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

The core function maintains address handlers by list. RCU is utilized
for efficient read access to any entries in the list.

This commit uses guard macro to maintain RCU locking and releasing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 35 +++++++++++++----------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 2a2cbd6e2f9b..a0224d4d8e11 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -925,16 +925,14 @@ static void handle_exclusive_region_request(struct fw_card *card,
 	if (tcode == TCODE_LOCK_REQUEST)
 		tcode = 0x10 + async_header_get_extended_tcode(p->header);
 
-	rcu_read_lock();
-	handler = lookup_enclosing_address_handler(&address_handler_list,
-						   offset, request->length);
-	if (handler)
-		handler->address_callback(card, request,
-					  tcode, destination, source,
-					  p->generation, offset,
-					  request->data, request->length,
-					  handler->callback_data);
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		handler = lookup_enclosing_address_handler(&address_handler_list, offset,
+							   request->length);
+		if (handler)
+			handler->address_callback(card, request, tcode, destination, source,
+						  p->generation, offset, request->data,
+						  request->length, handler->callback_data);
+	}
 
 	if (!handler)
 		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
@@ -967,17 +965,14 @@ static void handle_fcp_region_request(struct fw_card *card,
 		return;
 	}
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(handler, &address_handler_list, link) {
-		if (is_enclosing_handler(handler, offset, request->length))
-			handler->address_callback(card, request, tcode,
-						  destination, source,
-						  p->generation, offset,
-						  request->data,
-						  request->length,
-						  handler->callback_data);
+	scoped_guard(rcu) {
+		list_for_each_entry_rcu(handler, &address_handler_list, link) {
+			if (is_enclosing_handler(handler, offset, request->length))
+				handler->address_callback(card, request, tcode, destination, source,
+							  p->generation, offset, request->data,
+							  request->length, handler->callback_data);
+		}
 	}
-	rcu_read_unlock();
 
 	fw_send_response(card, request, RCODE_COMPLETE);
 }
-- 
2.43.0


