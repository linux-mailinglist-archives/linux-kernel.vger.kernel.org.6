Return-Path: <linux-kernel+bounces-203432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD68FDAFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C495284AC9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A38517D88B;
	Wed,  5 Jun 2024 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="FCOyQRTQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DJ4yzf2m"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC417A906
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631545; cv=none; b=KjQAGbFaQAXgs2ujBCjvFVz1uuruDbWGTX9T3PtQbp9Bj+CxrjUnzuJNHKPgTswB5ujb7YhWwkKzogcK4Au8MOyIBdBFIozI8E47qXnJn3ss4KZrkHjnv8ceb7ck1I3y9tRZpFXZaLEtSEhfkTOZG4LbIKqjhOO3T0yFbML7GCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631545; c=relaxed/simple;
	bh=puOjsXCpTLLDHFN23XdWATe1c+0fFNhQUGaNsCJYEfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKMp4+Pp0JkwakPixhT2wvBDxClVfvG5utVgHPVarpD3ygGwEYbsPAWktAg7EEl+skUvPl4V4iCwYchSFVQP8k7XA16vNSKj5ETC9tKajXTVg2tZK7SL6hPKmpA0wSr0hHAC/WVWM3Aq2E7pm2SxRKTQHB2WfZxuYh7FsLklOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=FCOyQRTQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DJ4yzf2m; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id A96771800124;
	Wed,  5 Jun 2024 19:52:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jun 2024 19:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631543; x=
	1717717943; bh=mFLRPY8Emv7QgVYkbWBjf7n/0RQSBEsg8Su4xKUqlzM=; b=F
	COyQRTQp65TYKhNrarr04rO868DSMZRojvdmk8bPb6Yc7YlxjXWax4ndmBay0bKE
	gnoVq8qc3kdICfT1cwpFnMQ7JZF3eIySf2Qyd1OL99/73dFBGDLYxWbddsfHCnJn
	Tj5ukmzEpWg0vSl3qAW3XyN2hyWPJD8KZUhXb7hEvs+wFaOkh4RbRt+gIgm6YY0I
	zMyYVXMzKeP8dZxifVrCpn3q5oDfcHT97jnXAjA/M2EDnjwcR0DOy+McvPmEFWYN
	J5jqqSsav9z+jvcM+AlPb9+6ldjvq9r+Qu4JQ3PGzYzoagBO1nm5gyQ4a3JMFdr6
	G8cuBOq1B1vaVox1E3H7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631543; x=
	1717717943; bh=mFLRPY8Emv7QgVYkbWBjf7n/0RQSBEsg8Su4xKUqlzM=; b=D
	J4yzf2mCGdKbb46ZDM3jvxOZ63Fhljlm5j75BWzgmy92ALE+dy90hhvXt5HzdNTF
	Dg/OPYwsH7F7akZofd6YTLOuHAnGHCWQ9UAtPTsAYlU3+dXwO2lmOOKfQQ9MNmsQ
	Tm3VMu+/F5em76wgXyJQI8pmnlvOGUb+Wn9dJaeTWUQ0WnxVXljdwe+XRAH3v3Qs
	AkoVi4Idw77wIiDMSE4Oq1O/v96ZFa6zYAbj9QjTc88JmUmV4gWUjwg8WIK4rn2z
	7TaYZOhcShX1JHmQKuZ52upXJLrJLAZ/1UyhHTqXLut7v5UXqbf4k2VmYuDmYeH+
	NyvoJIpgqPhJ4Y7lhe9EQ==
X-ME-Sender: <xms:N_pgZpFCdhIAvjkEidkOlGslsNZ9K4PDYvcuaNuFlVHSWT0FiXpvrQ>
    <xme:N_pgZuW5yn-o3NpY6FbZbdv75YsNDdnKLmDBJTgnTHCpadDzwfh9lI2_TzIJpvZt6
    BB22yvZsaaZG4lIriw>
X-ME-Received: <xmr:N_pgZrI80Xikrixo0MtUfND6ftL3q3PqSAiFCGGoMyNSXAyP7i9a50KUcWsoXvHtHrlq3uDlNwFB-NgKjd08X4TKFOyk0XjyAlh2aAduxwFIwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:N_pgZvEvmgJFGvuBpx9z-Duxl5XUxWilyC4MtMFWdQHK8GsjkDvGHQ>
    <xmx:N_pgZvWzKA_grUhUj7eSlo7-IwMlr4EACANSYUSSyyWMFqUPQCkPnw>
    <xmx:N_pgZqNZxeKUC56pC31wez4XnfKKrYrg5Rt_KfIivN361UEIo7xKRQ>
    <xmx:N_pgZu0tcUv3hBZU0JdjAnkdMmV7ARkHkqQ7iZLA9KfHmv6__86OeA>
    <xmx:N_pgZshqOCYj-lewRkxhiKmogX9UF2oniuBFk_T80tEbcKeI3goHnzHo>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:22 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] firewire: core: add tracepoints event for self_id_sequence
Date: Thu,  6 Jun 2024 08:51:55 +0900
Message-ID: <20240605235155.116468-12-o-takashi@sakamocchi.jp>
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

It is helpful to trace the content of self ID sequence when the core
function building bus topology.

This commit adds a tracepoints event fot the purpose. It seems not to
achieve printing variable length of array in print time without any
storage, thus the structure of event includes a superfluous array to store
the state of port. Additionally, there is no helper function to print
symbol array, thus the state of port is printed as raw value.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c |  7 ++--
 drivers/firewire/core-trace.c    | 15 ++++++++
 include/trace/events/firewire.h  | 59 ++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 6ec100e17500..4a0b273392ab 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -95,7 +95,8 @@ static inline struct fw_node *fw_node(struct list_head *l)
  * internally consistent.  On success this function returns the
  * fw_node corresponding to the local card otherwise NULL.
  */
-static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self_id_count)
+static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self_id_count,
+				  unsigned int generation)
 {
 	struct self_id_sequence_enumerator enumerator = {
 		.cursor = sid,
@@ -139,6 +140,8 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
 		}
 
 		port_capacity = self_id_sequence_get_port_capacity(quadlet_count);
+		trace_self_id_sequence(self_id_sequence, quadlet_count, generation);
+
 		for (port_index = 0; port_index < port_capacity; ++port_index) {
 			port_status = self_id_sequence_get_port_status(self_id_sequence, quadlet_count,
 								       port_index);
@@ -482,7 +485,7 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 	card->bm_abdicate = bm_abdicate;
 	fw_schedule_bm_work(card, 0);
 
-	local_node = build_tree(card, self_ids, self_id_count);
+	local_node = build_tree(card, self_ids, self_id_count, generation);
 
 	update_topology_map(card, self_ids, self_id_count);
 
diff --git a/drivers/firewire/core-trace.c b/drivers/firewire/core-trace.c
index 7cbf850f3719..c9bc4990d66e 100644
--- a/drivers/firewire/core-trace.c
+++ b/drivers/firewire/core-trace.c
@@ -2,7 +2,22 @@
 // Copyright (c) 2024 Takashi Sakamoto
 
 #include <linux/types.h>
+#include <linux/err.h>
 #include "packet-header-definitions.h"
+#include "phy-packet-definitions.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/firewire.h>
+
+#ifdef TRACEPOINTS_ENABLED
+void copy_port_status(u8 *port_status, unsigned int port_capacity,
+		      const u32 *self_id_sequence, unsigned int quadlet_count)
+{
+	unsigned int port_index;
+
+	for (port_index = 0; port_index < port_capacity; ++port_index) {
+		port_status[port_index] =
+			self_id_sequence_get_port_status(self_id_sequence, quadlet_count, port_index);
+	}
+}
+#endif
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 1f4ef0ed65bc..4761b700ff84 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -341,6 +341,65 @@ TRACE_EVENT(bus_reset_handle,
 	)
 );
 
+// Some macros are defined in 'drivers/firewire/phy-packet-definitions.h'.
+
+// The content of TP_printk field is preprocessed, then put to the module binary.
+
+#define PHY_PACKET_SELF_ID_GET_PHY_ID(quads)		\
+	((((const u32 *)quads)[0] & SELF_ID_PHY_ID_MASK) >> SELF_ID_PHY_ID_SHIFT)
+
+#define PHY_PACKET_SELF_ID_GET_LINK_ACTIVE(quads)	\
+	((((const u32 *)quads)[0] & SELF_ID_ZERO_LINK_ACTIVE_MASK) >> SELF_ID_ZERO_LINK_ACTIVE_SHIFT)
+
+#define PHY_PACKET_SELF_ID_GET_GAP_COUNT(quads)		\
+	((((const u32 *)quads)[0] & SELF_ID_ZERO_GAP_COUNT_MASK) >> SELF_ID_ZERO_GAP_COUNT_SHIFT)
+
+#define PHY_PACKET_SELF_ID_GET_SCODE(quads)		\
+	((((const u32 *)quads)[0] & SELF_ID_ZERO_SCODE_MASK) >> SELF_ID_ZERO_SCODE_SHIFT)
+
+#define PHY_PACKET_SELF_ID_GET_CONTENDER(quads)		\
+	((((const u32 *)quads)[0] & SELF_ID_ZERO_CONTENDER_MASK) >> SELF_ID_ZERO_CONTENDER_SHIFT)
+
+#define PHY_PACKET_SELF_ID_GET_POWER_CLASS(quads)	\
+	((((const u32 *)quads)[0] & SELF_ID_ZERO_POWER_CLASS_MASK) >> SELF_ID_ZERO_POWER_CLASS_SHIFT)
+
+#define PHY_PACKET_SELF_ID_GET_INITIATED_RESET(quads)	\
+	((((const u32 *)quads)[0] & SELF_ID_ZERO_INITIATED_RESET_MASK) >> SELF_ID_ZERO_INITIATED_RESET_SHIFT)
+
+void copy_port_status(u8 *port_status, unsigned int port_capacity, const u32 *self_id_sequence,
+		      unsigned int quadlet_count);
+
+TRACE_EVENT(self_id_sequence,
+	TP_PROTO(const u32 *self_id_sequence, unsigned int quadlet_count, unsigned int generation),
+	TP_ARGS(self_id_sequence, quadlet_count, generation),
+	TP_STRUCT__entry(
+		__field(u8, generation)
+		__dynamic_array(u8, port_status, self_id_sequence_get_port_capacity(quadlet_count))
+		__dynamic_array(u32, self_id_sequence, quadlet_count)
+	),
+	TP_fast_assign(
+		__entry->generation = generation;
+		copy_port_status(__get_dynamic_array(port_status), __get_dynamic_array_len(port_status),
+				 self_id_sequence, quadlet_count);
+		memcpy(__get_dynamic_array(self_id_sequence), self_id_sequence,
+					   __get_dynamic_array_len(self_id_sequence));
+	),
+	TP_printk(
+		"generation=%u phy_id=0x%02x link_active=%s gap_count=%u scode=%u contender=%s power_class=%u initiated_reset=%s port_status=%s self_id_sequence=%s",
+		__entry->generation,
+		PHY_PACKET_SELF_ID_GET_PHY_ID(__get_dynamic_array(self_id_sequence)),
+		PHY_PACKET_SELF_ID_GET_LINK_ACTIVE(__get_dynamic_array(self_id_sequence)) ? "true" : "false",
+		PHY_PACKET_SELF_ID_GET_GAP_COUNT(__get_dynamic_array(self_id_sequence)),
+		PHY_PACKET_SELF_ID_GET_SCODE(__get_dynamic_array(self_id_sequence)),
+		PHY_PACKET_SELF_ID_GET_CONTENDER(__get_dynamic_array(self_id_sequence)) ? "true" : "false",
+		PHY_PACKET_SELF_ID_GET_POWER_CLASS(__get_dynamic_array(self_id_sequence)),
+		PHY_PACKET_SELF_ID_GET_INITIATED_RESET(__get_dynamic_array(self_id_sequence)) ? "true" : "false",
+		__print_array(__get_dynamic_array(port_status), __get_dynamic_array_len(port_status), 1),
+		__print_array(__get_dynamic_array(self_id_sequence),
+			      __get_dynamic_array_len(self_id_sequence) / QUADLET_SIZE, QUADLET_SIZE)
+	)
+);
+
 #undef QUADLET_SIZE
 
 #endif // _FIREWIRE_TRACE_EVENT_H
-- 
2.43.0


