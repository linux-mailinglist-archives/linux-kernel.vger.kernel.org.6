Return-Path: <linux-kernel+bounces-213270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62921907356
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5A81F21B84
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020B0145331;
	Thu, 13 Jun 2024 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="O9yOsORe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ff3SvrhY"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416BD1448FA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284495; cv=none; b=qpljetwhl5q9cKGUpt/wMa5ACDkfrqH5S3aoERr9uTpL4yhbKErmkFM+y1XZuV+Q/PeJecK/21gynG2g2MkkEX4XjBGTlLq518EGyDD926GxjBHXcezQYIpGovx0bjUnDL293rXZMvcBloLAaz3DLZqIfvRqJjjDZEFZTt65FBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284495; c=relaxed/simple;
	bh=KLoB45JYegx+ffrktyofSNuiWiItZsJpgRcg101okEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFBc1eWNiEaBcVno96snZoZ54hLDUxmNG2RiFqhXP+YUAgvg5KK/avbsuE1N0XRJssB7G0lgPe6i36WLyATO1wS5Cmvfuin4QdrwD4sAevG6MXIJ1SHTLv78RuSyEthXK/aVXsGVD3TjRv4wtM7j2rXPkQHk83GxfrBRz71eKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=O9yOsORe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ff3SvrhY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 57AF7138008A;
	Thu, 13 Jun 2024 09:14:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 09:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718284490; x=
	1718370890; bh=pKmgdIHnHnIlspZLPXht7lfKdMoxfoyma3rtoghKko0=; b=O
	9yOsOReifzDzgytpBnqKGj5OtTE3Uc7FWY5pdSmDsaM9WnPKYnyM/GhrLdjbDX72
	eBM/qy83wOlS/HWyTm4n9U6V/XtoDrWDRFh3vTSv2PiAj1LA/+YAYxw/5k8pb9tn
	PvppA51zA+Au+4OvC/4l73pCaV0WeEoLRDEzQP7/eldSzvyEZWQnZGlELlk3XXX4
	Ms1EIGk9/A8TEohkY0BpOjOHbhIlRqJDpEFlTUe5OFXg+IgZ/BWOT1yMwp8hUs8a
	CjjdOmUQaOr6UYaBuZy2MS8VkbSVFSRzM2i6/tggsQplswqrjjtJ2f0t4pTFkSyb
	gDmk28KTQB2Moq7uiGBzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718284490; x=
	1718370890; bh=pKmgdIHnHnIlspZLPXht7lfKdMoxfoyma3rtoghKko0=; b=f
	f3SvrhYlXQ9Gk85BhEda40+k7gViWQFssF2zVC6nnc2fcEx/yk+wzWuJxYoHERg9
	jpOwzWw4FAq6JG9O8AnHiKINGdRa1X0GG2O/C2O6tvh01SzXMBy3R6oDOGcX4/N6
	kYbhVmeunOo1BHwqrp6ChyKbF0l352JWU33gpp+4H5aEsa5XOHHa4oS4M/cmYqAA
	idpYLKI5YMcS0HINa77A/o1Edx9t18vrlqb+bbKbYlX1TADfXGsK6Y87SFJSggO/
	jvbgy8p1+GTyiUoKoqv6pl7vDYofdATGfGbgXgvbyrXj7mJBNV5YtodEoHeD0i3W
	p1480UxkJeDiNBv5x0w2A==
X-ME-Sender: <xms:yvBqZm-096AauJuCHFlZwZ5_RwhgZ_gySiVZp8xZxuoUrh987fAbZw>
    <xme:yvBqZmup3fW7ydQOlUDN8RCDN0LiqRIFLFzT7FTQXZU11D-LLWHMr6Q71QqthT9_K
    kASsC2TOgKe0ivwWz8>
X-ME-Received: <xmr:yvBqZsCcm8VTiGtRDvH9uQFkEA-mkVm44aZMy1KT70CIeE7zQiyl87YPugxXXnZaMuBvxhRYL-1GIalGGQm50L2xILGyxBh6ml1Gk6byN4JDHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:yvBqZuep-Tc7zwP4Zw-vX457nFvm85m-OsZl8FFp5Ciztw_Wv9p5Ug>
    <xmx:yvBqZrOlKlP5WFFI8E1bGIicTLG3gMfVwBaroPcD86Oq1H_yP6qMww>
    <xmx:yvBqZon78TVkNgm1VjVT5qduCsM9HcObQl8kr-ckEChue0_0Y47Sag>
    <xmx:yvBqZtvA7oLtRB10ssWMXdLjyeGk3mkFZGs7k5mSHB28phu-Q5h0Xw>
    <xmx:yvBqZkaWExIJXfiAsDXgLylEm250QPAr217yy1izotl-S3x4DTNNetke>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 09:14:49 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] firewire: core: record card index in async_phy_outbound_initiate tracepoints event
Date: Thu, 13 Jun 2024 22:14:36 +0900
Message-ID: <20240613131440.431766-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613131440.431766-1-o-takashi@sakamocchi.jp>
References: <20240613131440.431766-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The asynchronous transaction is initiated on one of 1394 OHCI
controller, however the existing tracepoints events has the lack of data
about it.

This commit adds card_index member into event structure to store the index
of host controller in use, and prints it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c        | 4 ++--
 drivers/firewire/core-transaction.c | 2 +-
 include/trace/events/firewire.h     | 9 ++++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 55993c9e0b90..ff8739f96af5 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1659,8 +1659,8 @@ static int ioctl_send_phy_packet(struct client *client, union ioctl_arg *arg)
 		memcpy(pp->data, a->data, sizeof(a->data));
 	}
 
-	trace_async_phy_outbound_initiate((uintptr_t)&e->p, e->p.generation, e->p.header[1],
-					  e->p.header[2]);
+	trace_async_phy_outbound_initiate((uintptr_t)&e->p, card->index, e->p.generation,
+					  e->p.header[1], e->p.header[2]);
 
 	card->driver->send_request(card, &e->p);
 
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 3503c238f8ae..e522dc3d9897 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -504,7 +504,7 @@ void fw_send_phy_config(struct fw_card *card,
 	phy_config_packet.generation = generation;
 	reinit_completion(&phy_config_done);
 
-	trace_async_phy_outbound_initiate((uintptr_t)&phy_config_packet,
+	trace_async_phy_outbound_initiate((uintptr_t)&phy_config_packet, card->index,
 					  phy_config_packet.generation, phy_config_packet.header[1],
 					  phy_config_packet.header[2]);
 
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index b72f613cfa02..a59dc26b2a53 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -217,23 +217,26 @@ DEFINE_EVENT(async_outbound_complete_template, async_response_outbound_complete,
 #undef ASYNC_HEADER_GET_RCODE
 
 TRACE_EVENT(async_phy_outbound_initiate,
-	TP_PROTO(u64 packet, unsigned int generation, u32 first_quadlet, u32 second_quadlet),
-	TP_ARGS(packet, generation, first_quadlet, second_quadlet),
+	TP_PROTO(u64 packet, unsigned int card_index, unsigned int generation, u32 first_quadlet, u32 second_quadlet),
+	TP_ARGS(packet, card_index, generation, first_quadlet, second_quadlet),
 	TP_STRUCT__entry(
 		__field(u64, packet)
+		__field(u8, card_index)
 		__field(u8, generation)
 		__field(u32, first_quadlet)
 		__field(u32, second_quadlet)
 	),
 	TP_fast_assign(
 		__entry->packet = packet;
+		__entry->card_index = card_index;
 		__entry->generation = generation;
 		__entry->first_quadlet = first_quadlet;
 		__entry->second_quadlet = second_quadlet
 	),
 	TP_printk(
-		"packet=0x%llx generation=%u first_quadlet=0x%08x second_quadlet=0x%08x",
+		"packet=0x%llx card_index=%u generation=%u first_quadlet=0x%08x second_quadlet=0x%08x",
 		__entry->packet,
+		__entry->card_index,
 		__entry->generation,
 		__entry->first_quadlet,
 		__entry->second_quadlet
-- 
2.43.0


