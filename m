Return-Path: <linux-kernel+bounces-203429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 749188FDAF6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD022B23057
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A64172BCD;
	Wed,  5 Jun 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ROQGTVMo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="agncoT60"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB116FF2E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631539; cv=none; b=AKtzdZLAU3ctC6F/1nqXR6eCaWSdA/dSLvMmSfWeHSrjtz5CgL1ELHr6fkPjYuI21QlWzVNncOfSOpNCWHBZPFNRwXdXJOLTxrJrl68HK6b2zCOa8qCYdok1RRTFZrr7yhWE4ZYxVo8ed9v8S3oZl+INMCU1AHBShMtPrs5OJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631539; c=relaxed/simple;
	bh=ebmLsfA0LlsB0ePd7GOHkiCsMBiHmH04Q7vyI11vts8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivRs96+swNZ0rgz3IJ64Ulodf423jgQebIQ4tipmvTdjGi/KxC5XgVOMKN2JMoeN6ea7b3XZwET5GABaWf3zbqVj7+H4+fxFbAwfXJhIWxUGi3P2Mgo14+XoAXzRi6Ls7iBomTtcXa0wa44hheqGj/HbcX3urPjfyc8xn7LK6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ROQGTVMo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=agncoT60; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 8B2F71C0005B;
	Wed,  5 Jun 2024 19:52:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 19:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631537; x=
	1717717937; bh=qWFO7zoF+O3PVNs52gcGbFCEy0eI0C7UgJjzmWKpW4M=; b=R
	OQGTVMomLqSTv3VH+Y59El3gBqQUuTxNqEUZqFZt8r3U5walYP4RCrLkqootNYnp
	PNVYugQ1pWbA1WSiq2ml2GfOmo0Y8knR3zmyuHmA1adJnKL4OXtNdNedEpXKaeI2
	MjjIvZIuwAWNlugm/J8eMAy+ObwkUTF9Tey6iG0LgX3Eb+IHsnmsmekl78Y+C97R
	qKV8JJNe7OPQowfnXyEVyuCu/PI6JApWY3HQWPeuXAUwDJj+2MGWG8weIZBKXiw1
	SGwzr4mnGFsb3Z8iTxDOfjSxvsZLmuWI5MBHUhX0iTe23WeEKtiMcyfqdprpHosF
	QUXPfIh4Vu2t1spSa+T1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631537; x=
	1717717937; bh=qWFO7zoF+O3PVNs52gcGbFCEy0eI0C7UgJjzmWKpW4M=; b=a
	gncoT60BiYOu5cWM92bVrwh4BRGZxTDcKYnWBXC9k+zN02UnbNbKEcwG/U/mwBwe
	eTsKXZdYCxvlaIbz746po+mlzdmhyLy2iaAxNhdGOWhkBAK8VceiacW1uF24NECZ
	JY1TH6R1xL5W6nMeIQMnkGlMvSHZ7PVvAKjaKROeFB0FpVx9iVHM++SQBM5XjH/d
	MrEEVRyNascOw+qOyJgdKf4BBOSwlhm1/rHkQPP3a7QeJl0DLMXQ82ad7tGLkkiL
	94enZpBNqeK/59hIG3opkoPe0tRURRv948MDphGdwHSREjxWMV4MBVN0M+qFApij
	ZIrNHce04mGk9T7v5VvNQ==
X-ME-Sender: <xms:MfpgZghmbpUdOIg5m0M6BTvy2BIKGOCZtjaaSp3La5uIjr0nPE8duQ>
    <xme:MfpgZpC9AheCCUcXK6D9VI-WL8triDVp05t6AtXewE87qgQcvti3MiuHQoKOfhuW6
    DwhCZmnJK0n6g0ra6A>
X-ME-Received: <xmr:MfpgZoFumtr_vTgww4J95cPlwBrfox7_LKVYOPgJw94yBxk61RsPjhF83NiC6HoeRhFH0OzTZIEbVyAs24ciRbGDSTrejASh7DVd26_fJlTOIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:MfpgZhRf2NRKe0kzME3kRQh6q6zIODFK2afOb2XqfzubMg4HSCCWtQ>
    <xmx:MfpgZtw3QEDDHpgygMKyuzWzaSacSCzPsIWNUiwYZ5syK4g5XLOgvA>
    <xmx:MfpgZv4MPtUmQe_pMdI24DjeNxcG0XVvLfv2uWMx0zQ-aZM9hMN61g>
    <xmx:MfpgZqxN3TtQhjx0Bs1d0bDOOX3QrkTApvnpKUVDNr5NmE7ZqfOVBg>
    <xmx:MfpgZo_kj573oFlJygdVJOJA-MAFhonie7LD5DY95qeSUba6DMlcHVrv>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:15 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] firewire: core: use helper inline functions to deserialize self ID packet
Date: Thu,  6 Jun 2024 08:51:52 +0900
Message-ID: <20240605235155.116468-9-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605235155.116468-1-o-takashi@sakamocchi.jp>
References: <20240605235155.116468-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit replaces the existing implementation with the helper
functions for self ID packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 999ba2b121cd..6ec100e17500 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -23,13 +23,6 @@
 #include "phy-packet-definitions.h"
 #include <trace/events/firewire.h>
 
-#define SELF_ID_PHY_ID(q)		(((q) >> 24) & 0x3f)
-#define SELF_ID_LINK_ON(q)		(((q) >> 22) & 0x01)
-#define SELF_ID_GAP_COUNT(q)		(((q) >> 16) & 0x3f)
-#define SELF_ID_PHY_SPEED(q)		(((q) >> 14) & 0x03)
-#define SELF_ID_CONTENDER(q)		(((q) >> 11) & 0x01)
-#define SELF_ID_PHY_INITIATOR(q)	(((q) >>  1) & 0x01)
-
 static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
 {
 	struct fw_node *node;
@@ -39,10 +32,11 @@ static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
 		return NULL;
 
 	node->color = color;
-	node->node_id = LOCAL_BUS | SELF_ID_PHY_ID(sid);
-	node->link_on = SELF_ID_LINK_ON(sid);
-	node->phy_speed = SELF_ID_PHY_SPEED(sid);
-	node->initiated_reset = SELF_ID_PHY_INITIATOR(sid);
+	node->node_id = LOCAL_BUS | phy_packet_self_id_get_phy_id(sid);
+	node->link_on = phy_packet_self_id_zero_get_link_active(sid);
+	// NOTE: Only two bits, thus only for SCODE_100, SCODE_200, SCODE_400, and SCODE_BETA.
+	node->phy_speed = phy_packet_self_id_zero_get_scode(sid);
+	node->initiated_reset = phy_packet_self_id_zero_get_initiated_reset(sid);
 	node->port_count = port_count;
 
 	refcount_set(&node->ref_count, 1);
@@ -119,7 +113,7 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 	stack_depth = 0;
 	phy_id = 0;
 	irm_node = NULL;
-	gap_count = SELF_ID_GAP_COUNT(*sid);
+	gap_count = phy_packet_self_id_zero_get_gap_count(*sid);
 	beta_repeaters_present = false;
 
 	while (enumerator.quadlet_count > 0) {
@@ -162,9 +156,9 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 			}
 		}
 
-		if (phy_id != SELF_ID_PHY_ID(self_id_sequence[0])) {
+		if (phy_id != phy_packet_self_id_get_phy_id(self_id_sequence[0])) {
 			fw_err(card, "PHY ID mismatch in self ID: %d != %d\n",
-			       phy_id, SELF_ID_PHY_ID(self_id_sequence[0]));
+			       phy_id, phy_packet_self_id_get_phy_id(self_id_sequence[0]));
 			return NULL;
 		}
 
@@ -194,7 +188,7 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 		if (phy_id == (card->node_id & 0x3f))
 			local_node = node;
 
-		if (SELF_ID_CONTENDER(self_id_sequence[0]))
+		if (phy_packet_self_id_zero_get_contender(self_id_sequence[0]))
 			irm_node = node;
 
 		for (port_index = 0; port_index < total_port_count; ++port_index) {
@@ -243,7 +237,7 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 
 		// If PHYs report different gap counts, set an invalid count which will force a gap
 		// count reconfiguration and a reset.
-		if (SELF_ID_GAP_COUNT(self_id_sequence[0]) != gap_count)
+		if (phy_packet_self_id_zero_get_gap_count(self_id_sequence[0]) != gap_count)
 			gap_count = 0;
 
 		update_hop_count(node);
-- 
2.43.0


