Return-Path: <linux-kernel+bounces-203426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 293DD8FDAF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AF71F26F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535216DEB6;
	Wed,  5 Jun 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KobBh3wM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cdmgG+Ct"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B516D4C0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631533; cv=none; b=ee1wjZ699AqtcdlYfAKMxjqu+cJfuhBmhKDMW2OrSgtd9hJ72a4DXx7vopQcTEmKBnGbOhSSJEG3LlT/izBZxgdd1CsYPXVQoB0u4eAB/vBf7QdKQ61/h8AYYcZ4ATjmXgO+ty3zh5kOuN6XcI8xAIW7vC1/nzQRteFBrZMYgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631533; c=relaxed/simple;
	bh=/5xshN40U+7I8IHbkcf+CZCJ0n9pk0XHPKGSe2YUy5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXRqWg12CCqsG9UrkKYIAaPmy2RaJmEWfRPVagW3qmWtvAx4uGpoVoKle5Yvc/dm2H2efjVPJWGzH2OjDgMZiFrlkzFUnH6utlEDVz3Pw7YF2fB4LmrVTkHK5zGPngRlxiWFJT0dMojFgAUMFEJP53OsQylqC1rwsWHnXHEFKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KobBh3wM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cdmgG+Ct; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 2040F1C000F9;
	Wed,  5 Jun 2024 19:52:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 19:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631530; x=
	1717717930; bh=H+eY1/AV2QPj0CXHcejIiaTss5Dil3imgP/c8kjn9RY=; b=K
	obBh3wMy/aNAP5mRghBPI5f7n+8W93AW7I6MlXz3Cco9POoNrO52gOJPZwRLnUi7
	FFANvRZEAhMWF9ODZUBODUm6euBB1TkYWmXXoM89BqCbwqmz/8UfrMfCyMHaNTx7
	7iwYTJ+OX+9f4K/+J61z8owLrlTs+7VSTmzSnWUCw46d0yFwOmy4b2c7rwYWy7rl
	5Z+vtFl22WpZKhkkGuRCJQM+Li8PkzplGDS+mEOiYO4nwM6ODcIgMk/fp/nxPkLU
	dicZgBuA650OBS7bNXZ+sarIG4W4zxqFs8NlcpVugr1FWo+Rv5rugZxprbMEk9Gk
	DJE+YGZvwlxDjzeSDJs5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631530; x=
	1717717930; bh=H+eY1/AV2QPj0CXHcejIiaTss5Dil3imgP/c8kjn9RY=; b=c
	dmgG+Ct4uI1ox70rhZ+fD0OQSOhYFdFD8/36tT+noXmIC/9Du9wjqOveTcEwyYoa
	Dl8ls/4/uZoAZsI/E6AprzOWGUM+2fFPoYv7EA4/OPa0t2mCDlcuRWnfKCE+pjNl
	3I3JNWdkwDg1bUNoTv/ohIl+TRoMy1n6G8CjrX//x+9EUfd5yluBxZ1tYYV6eehl
	zf/YAj2R0euqWZWB9Wi3oeBPzZxdzK+d5jTVswIwtd5+ovPEKKAIi9i+QyOL6Gqy
	lwY1I59+8HTGZXk8xrw1GwBS3GhBlPZd2vAB6PXLfzBBpUszHJKx06HUTS08STDu
	wrRHnrvwTCtefBnoyLUoA==
X-ME-Sender: <xms:KvpgZgoI-rnnDYv6Af8TloBaaJOw_KMzHlC2Yorf3KgmLdEO6USPww>
    <xme:KvpgZmqE3C-Ttk5zQRhCXTVIqWGJ50Ir16l-1kVao9U4TfOUtXoQoR688UUwYaBKj
    055id_6G92G7twX2Is>
X-ME-Received: <xmr:KvpgZlP183S0iVejb6Nnh-MXM1f7yiTQ5-jpJtD71tCIm5SVA8Pam-jMSz7CcgjAG0EwsedXgkX_E_jy2sM7Io8S25JFxFas79ioWRptPS5zTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:KvpgZn5yr2HrC3VsJqq-TDEUcQ-qoAnlgRmQp9ENUsS88_FFgG-Hlg>
    <xmx:KvpgZv63_EQBHePy2ro-NsjzJ8UQzzSgqoWXh4b23kstgQ3XeO4psg>
    <xmx:KvpgZngn989WE2VwqHCJ9wcfglbKhNNRdlCTMZmoS78meEfjw1c69g>
    <xmx:KvpgZp4v735TMUT4iAT-3mp17aV-bBt5eZk_cHYqg0LDRM3pRSe3uQ>
    <xmx:KvpgZvGGW_Ew6ctYNxn-oNRVX5QP9-KXNgob9XRJ0i0zjj2gwvyoCxeI>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:09 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] firewire: core: use helper functions for self ID sequence
Date: Thu,  6 Jun 2024 08:51:49 +0900
Message-ID: <20240605235155.116468-6-o-takashi@sakamocchi.jp>
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
functions for self ID sequence.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 189 +++++++++++--------------------
 1 file changed, 69 insertions(+), 120 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 6a039293ee63..999ba2b121cd 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -20,80 +20,15 @@
 #include <asm/byteorder.h>
 
 #include "core.h"
+#include "phy-packet-definitions.h"
 #include <trace/events/firewire.h>
 
 #define SELF_ID_PHY_ID(q)		(((q) >> 24) & 0x3f)
-#define SELF_ID_EXTENDED(q)		(((q) >> 23) & 0x01)
 #define SELF_ID_LINK_ON(q)		(((q) >> 22) & 0x01)
 #define SELF_ID_GAP_COUNT(q)		(((q) >> 16) & 0x3f)
 #define SELF_ID_PHY_SPEED(q)		(((q) >> 14) & 0x03)
 #define SELF_ID_CONTENDER(q)		(((q) >> 11) & 0x01)
 #define SELF_ID_PHY_INITIATOR(q)	(((q) >>  1) & 0x01)
-#define SELF_ID_MORE_PACKETS(q)		(((q) >>  0) & 0x01)
-
-#define SELF_ID_EXT_SEQUENCE(q)		(((q) >> 20) & 0x07)
-
-#define SELFID_PORT_CHILD	0x3
-#define SELFID_PORT_PARENT	0x2
-#define SELFID_PORT_NCONN	0x1
-#define SELFID_PORT_NONE	0x0
-
-static const u32 *count_ports(const u32 *sid, int *total_port_count, int *child_port_count)
-{
-	u32 q;
-	int port_type, shift, seq;
-
-	shift = 6;
-	q = *sid;
-	seq = 0;
-
-	while (1) {
-		port_type = (q >> shift) & 0x03;
-		switch (port_type) {
-		case SELFID_PORT_CHILD:
-			(*child_port_count)++;
-			fallthrough;
-		case SELFID_PORT_PARENT:
-		case SELFID_PORT_NCONN:
-			(*total_port_count)++;
-			fallthrough;
-		case SELFID_PORT_NONE:
-			break;
-		}
-
-		shift -= 2;
-		if (shift == 0) {
-			if (!SELF_ID_MORE_PACKETS(q))
-				return sid + 1;
-
-			shift = 16;
-			sid++;
-			q = *sid;
-
-			/*
-			 * Check that the extra packets actually are
-			 * extended self ID packets and that the
-			 * sequence numbers in the extended self ID
-			 * packets increase as expected.
-			 */
-
-			if (!SELF_ID_EXTENDED(q) ||
-			    seq != SELF_ID_EXT_SEQUENCE(q))
-				return NULL;
-
-			seq++;
-		}
-	}
-}
-
-static int get_port_type(const u32 *sid, int port_index)
-{
-	int index, shift;
-
-	index = (port_index + 5) / 8;
-	shift = 16 - ((port_index + 5) & 7) * 2;
-	return (sid[index] >> shift) & 0x03;
-}
 
 static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
 {
@@ -168,9 +103,12 @@ static inline struct fw_node *fw_node(struct list_head *l)
  */
 static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self_id_count)
 {
+	struct self_id_sequence_enumerator enumerator = {
+		.cursor = sid,
+		.quadlet_count = self_id_count,
+	};
 	struct fw_node *node, *child, *local_node, *irm_node;
 	struct list_head stack;
-	const u32 *end;
 	int phy_id, stack_depth;
 	int gap_count;
 	bool beta_repeaters_present;
@@ -179,31 +117,54 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 	node = NULL;
 	INIT_LIST_HEAD(&stack);
 	stack_depth = 0;
-	end = sid + self_id_count;
 	phy_id = 0;
 	irm_node = NULL;
 	gap_count = SELF_ID_GAP_COUNT(*sid);
 	beta_repeaters_present = false;
 
-	while (sid < end) {
-		int port_count = 0;
-		int child_port_count = 0;
-		int parent_count = 0;
-		const u32 *next_sid;
-		u32 q;
+	while (enumerator.quadlet_count > 0) {
+		unsigned int child_port_count = 0;
+		unsigned int total_port_count = 0;
+		unsigned int parent_count = 0;
+		unsigned int quadlet_count;
+		const u32 *self_id_sequence;
+		unsigned int port_capacity;
+		enum phy_packet_self_id_port_status port_status;
+		unsigned int port_index;
 		struct list_head *h;
 		int i;
 
-		next_sid = count_ports(sid, &port_count, &child_port_count);
-		if (next_sid == NULL) {
-			fw_err(card, "inconsistent extended self IDs\n");
-			return NULL;
+		self_id_sequence = self_id_sequence_enumerator_next(&enumerator, &quadlet_count);
+		if (IS_ERR(self_id_sequence)) {
+			if (PTR_ERR(self_id_sequence) != -ENODATA) {
+				fw_err(card, "inconsistent extended self IDs: %ld\n",
+				       PTR_ERR(self_id_sequence));
+				return NULL;
+			}
+			break;
 		}
 
-		q = *sid;
-		if (phy_id != SELF_ID_PHY_ID(q)) {
+		port_capacity = self_id_sequence_get_port_capacity(quadlet_count);
+		for (port_index = 0; port_index < port_capacity; ++port_index) {
+			port_status = self_id_sequence_get_port_status(self_id_sequence, quadlet_count,
+								       port_index);
+			switch (port_status) {
+			case PHY_PACKET_SELF_ID_PORT_STATUS_CHILD:
+				++child_port_count;
+				fallthrough;
+			case PHY_PACKET_SELF_ID_PORT_STATUS_PARENT:
+			case PHY_PACKET_SELF_ID_PORT_STATUS_NCONN:
+				++total_port_count;
+				fallthrough;
+			case PHY_PACKET_SELF_ID_PORT_STATUS_NONE:
+			default:
+				break;
+			}
+		}
+
+		if (phy_id != SELF_ID_PHY_ID(self_id_sequence[0])) {
 			fw_err(card, "PHY ID mismatch in self ID: %d != %d\n",
-			       phy_id, SELF_ID_PHY_ID(q));
+			       phy_id, SELF_ID_PHY_ID(self_id_sequence[0]));
 			return NULL;
 		}
 
@@ -224,7 +185,7 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 		 */
 		child = fw_node(h);
 
-		node = fw_node_create(q, port_count, card->color);
+		node = fw_node_create(self_id_sequence[0], total_port_count, card->color);
 		if (node == NULL) {
 			fw_err(card, "out of memory while building topology\n");
 			return NULL;
@@ -233,48 +194,40 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 		if (phy_id == (card->node_id & 0x3f))
 			local_node = node;
 
-		if (SELF_ID_CONTENDER(q))
+		if (SELF_ID_CONTENDER(self_id_sequence[0]))
 			irm_node = node;
 
-		parent_count = 0;
-
-		for (i = 0; i < port_count; i++) {
-			switch (get_port_type(sid, i)) {
-			case SELFID_PORT_PARENT:
-				/*
-				 * Who's your daddy?  We dont know the
-				 * parent node at this time, so we
-				 * temporarily abuse node->color for
-				 * remembering the entry in the
-				 * node->ports array where the parent
-				 * node should be.  Later, when we
-				 * handle the parent node, we fix up
-				 * the reference.
-				 */
-				parent_count++;
+		for (port_index = 0; port_index < total_port_count; ++port_index) {
+			port_status = self_id_sequence_get_port_status(self_id_sequence, quadlet_count,
+								       port_index);
+			switch (port_status) {
+			case PHY_PACKET_SELF_ID_PORT_STATUS_PARENT:
+				// Who's your daddy?  We dont know the parent node at this time, so
+				// we temporarily abuse node->color for remembering the entry in
+				// the node->ports array where the parent node should be.  Later,
+				// when we handle the parent node, we fix up the reference.
+				++parent_count;
 				node->color = i;
 				break;
 
-			case SELFID_PORT_CHILD:
-				node->ports[i] = child;
-				/*
-				 * Fix up parent reference for this
-				 * child node.
-				 */
+			case PHY_PACKET_SELF_ID_PORT_STATUS_CHILD:
+				node->ports[port_index] = child;
+				// Fix up parent reference for this child node.
 				child->ports[child->color] = node;
 				child->color = card->color;
 				child = fw_node(child->link.next);
 				break;
+			case PHY_PACKET_SELF_ID_PORT_STATUS_NCONN:
+			case PHY_PACKET_SELF_ID_PORT_STATUS_NONE:
+			default:
+				break;
 			}
 		}
 
-		/*
-		 * Check that the node reports exactly one parent
-		 * port, except for the root, which of course should
-		 * have no parents.
-		 */
-		if ((next_sid == end && parent_count != 0) ||
-		    (next_sid < end && parent_count != 1)) {
+		// Check that the node reports exactly one parent port, except for the root, which
+		// of course should have no parents.
+		if ((enumerator.quadlet_count == 0 && parent_count != 0) ||
+		    (enumerator.quadlet_count > 0 && parent_count != 1)) {
 			fw_err(card, "parent port inconsistency for node %d: "
 			       "parent_count=%d\n", phy_id, parent_count);
 			return NULL;
@@ -285,20 +238,16 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 		list_add_tail(&node->link, &stack);
 		stack_depth += 1 - child_port_count;
 
-		if (node->phy_speed == SCODE_BETA &&
-		    parent_count + child_port_count > 1)
+		if (node->phy_speed == SCODE_BETA && parent_count + child_port_count > 1)
 			beta_repeaters_present = true;
 
-		/*
-		 * If PHYs report different gap counts, set an invalid count
-		 * which will force a gap count reconfiguration and a reset.
-		 */
-		if (SELF_ID_GAP_COUNT(q) != gap_count)
+		// If PHYs report different gap counts, set an invalid count which will force a gap
+		// count reconfiguration and a reset.
+		if (SELF_ID_GAP_COUNT(self_id_sequence[0]) != gap_count)
 			gap_count = 0;
 
 		update_hop_count(node);
 
-		sid = next_sid;
 		phy_id++;
 	}
 
-- 
2.43.0


