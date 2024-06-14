Return-Path: <linux-kernel+bounces-214147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7A9908032
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C3E283CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260281C3D;
	Fri, 14 Jun 2024 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kR+KrhHv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctZsseJ9"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E8863D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718325780; cv=none; b=aJuPMjXbSkvj8o4Vsej+g8mNmBU+neU6v7z5+/yWE9QGTlv1d0hH//+rf2AtwqfqGdfYgTcVG7oclKkuRMmxt885NGkWTJX8rDOULlPsKL5m4rnSZi4gURCiEfuGcYG5ZZN5DNc0DxPjIhqDrj8ipPunvIdAATjq82rNAoR+3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718325780; c=relaxed/simple;
	bh=ZxsxtwhDTqjyrGcY+zZDbr5jCj+Eo8gZ1D5oTvV7aGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjNlD40k+wANn2iNozcWdQFpvw0faf9kniHMJWZnotBHuhuI2FsqEtfSIA/FmYUCNBzp4HXBRt0FIm0EDqbWWM1LqmjBwG/Cd9FYo/UitkUq6MUZZTS62m8FgttGXBlVlSCwEgzSimW43Y2xe08Mz47pu1PpkvgZMZvjCHgsTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=kR+KrhHv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ctZsseJ9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6F3621380195;
	Thu, 13 Jun 2024 20:42:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 13 Jun 2024 20:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1718325776; x=1718412176; bh=eyJmLqrBgL
	DDwAvjEwuA/NvV1Y5fbUSGVnmBpGBEbyk=; b=kR+KrhHvmDo1HwMizK7kaSU2to
	D/prFuSW+6nDPYPvuEy7xckCXsDOYynow81nyA530OSw6OX1ZJWYzi4H1+EUxCcL
	45SgnMo+2Gn87s/Iq3IQLO/LIBMN0aCR0BQJ+7oc7aZv3Iqj5CQk05IXb3gH+MwF
	fhyVn57iDapmm30losZdkMr9mkELnZedPow/T+VUL1kvNLcpHFH61D71bFRiI4R0
	/rFrBVa+7vOEwz5e0eLjm0KTCBhy5Is91rr/UEBnC2hJFQRqbLCwUt5JZeHnzqCz
	R4Ot8Cc2nUvqt+te/p8w1/yUkeZZ6JwE9wt9yj6Lap+NBP2bvQY1Wf2FH5GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718325776; x=1718412176; bh=eyJmLqrBgLDDwAvjEwuA/NvV1Y5f
	bUSGVnmBpGBEbyk=; b=ctZsseJ9+AuMhi5mC7zyMJ2N1Ouj1YUNNMfVg/O42t7i
	RWF7rsh/w4xRGdYSW0lMAnbhZmVxi82nnXbgZ/dYkTZq2J1B23tzEX5nZRGOU9Ds
	C+E5agbAEqng8jlxDPf/Eu+cycSuhwX+61yvQwzocUfElY7WK8KRpwQwBiusCPKG
	/OYM9vc847xAwaIcs4x38S5TrzpT0JAgvGf+37EKaJ/o47WQbOGIbanbC1q7pmYQ
	wzIaQYyKynLbaLXEAyRPzbQMYrWoof2JROrJzImzGL0BluYmTRtE7zeq6KVdaZl7
	S6Mjjr+0VEUm9zOg6tYhFNH5mkLpKisDEdz+3DtFuQ==
X-ME-Sender: <xms:EJJrZnmWORhmWb1jICbjRkSn7NfIbyYNotm7WAmnqNAUW8wEAFXoTg>
    <xme:EJJrZq3jN_uqJWDC_8nwYO5Cg55yPkMXOYUVlr81FemN8UuPdXmh8MDYwEz7GA_t5
    lqCHfB0kPjoEUSNr2Q>
X-ME-Received: <xmr:EJJrZtq2NQ7OSM8CPhnwO0saIkzbaNOHqI4_zK1moyyu7LbcKzpzsPEjYjXnNSTEPxEWcMi7hukcvMzw5Gz3-gwsrpYizv0C4Bwpnbd_lAOC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:EJJrZvkiAjGetpvWJSL-OR2dSspjgndlKnAkH6dT880CDs5nr9U1Pg>
    <xmx:EJJrZl1eJDEGlboc2SsekGGmY6gPBzu7VtWVxygwPsidbFgr8wLplA>
    <xmx:EJJrZutX5r1tjCUGYxM_dvRaKLcbABZcDszY-Z_lz6B_nHWxDvmCUQ>
    <xmx:EJJrZpUiUhdpjPOYjPPEywf_4F75-P0YtFyMRkQ5Q5LMgnE2TFkCMg>
    <xmx:EJJrZjD6hw_Hl9rySXNPX0un3DI8wGcXRKqth3TpzJHpzGgza1nb0RIv>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 20:42:55 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: record card index in tracepoints event for self ID sequence
Date: Fri, 14 Jun 2024 09:42:51 +0900
Message-ID: <20240614004251.460649-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is for for-next branch.

The selfIDComplete event occurs in the bus managed by one of 1394 OHCI
controller in Linux system, while the existing tracepoints events has
the lack of data about it to distinguish the issued hardware from the
others.

This commit adds card_index member into event structure to store the index
of host controller in use, and prints it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 2 +-
 include/trace/events/firewire.h  | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 4a0b273392ab..a347e2f5482c 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -140,7 +140,7 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 		}
 
 		port_capacity = self_id_sequence_get_port_capacity(quadlet_count);
-		trace_self_id_sequence(self_id_sequence, quadlet_count, generation);
+		trace_self_id_sequence(card->index, self_id_sequence, quadlet_count, generation);
 
 		for (port_index = 0; port_index < port_capacity; ++port_index) {
 			port_status = self_id_sequence_get_port_status(self_id_sequence, quadlet_count,
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 4761b700ff84..ace95d38c6ea 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -370,14 +370,16 @@ void copy_port_status(u8 *port_status, unsigned int port_capacity, const u32 *se
 		      unsigned int quadlet_count);
 
 TRACE_EVENT(self_id_sequence,
-	TP_PROTO(const u32 *self_id_sequence, unsigned int quadlet_count, unsigned int generation),
-	TP_ARGS(self_id_sequence, quadlet_count, generation),
+	TP_PROTO(unsigned int card_index, const u32 *self_id_sequence, unsigned int quadlet_count, unsigned int generation),
+	TP_ARGS(card_index, self_id_sequence, quadlet_count, generation),
 	TP_STRUCT__entry(
+		__field(u8, card_index)
 		__field(u8, generation)
 		__dynamic_array(u8, port_status, self_id_sequence_get_port_capacity(quadlet_count))
 		__dynamic_array(u32, self_id_sequence, quadlet_count)
 	),
 	TP_fast_assign(
+		__entry->card_index = card_index;
 		__entry->generation = generation;
 		copy_port_status(__get_dynamic_array(port_status), __get_dynamic_array_len(port_status),
 				 self_id_sequence, quadlet_count);
@@ -385,7 +387,8 @@ TRACE_EVENT(self_id_sequence,
 					   __get_dynamic_array_len(self_id_sequence));
 	),
 	TP_printk(
-		"generation=%u phy_id=0x%02x link_active=%s gap_count=%u scode=%u contender=%s power_class=%u initiated_reset=%s port_status=%s self_id_sequence=%s",
+		"card_index=%u generation=%u phy_id=0x%02x link_active=%s gap_count=%u scode=%u contender=%s power_class=%u initiated_reset=%s port_status=%s self_id_sequence=%s",
+		__entry->card_index,
 		__entry->generation,
 		PHY_PACKET_SELF_ID_GET_PHY_ID(__get_dynamic_array(self_id_sequence)),
 		PHY_PACKET_SELF_ID_GET_LINK_ACTIVE(__get_dynamic_array(self_id_sequence)) ? "true" : "false",
-- 
2.43.0


