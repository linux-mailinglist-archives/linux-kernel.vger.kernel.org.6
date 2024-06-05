Return-Path: <linux-kernel+bounces-203430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B408FDAF8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601BA1C20AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DCB1761B3;
	Wed,  5 Jun 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="eOSSw3/R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z2L7dX6F"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2DD17167B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631542; cv=none; b=dIVcMGgCKUKJdobgmMLiazd7Q3CAggdPDucFJSSKFdLdoZIf/mbqUFlEMZdOVHzpe0w4QmsjMhCaj36ijNTdbormRfiJxRbvX6eplGDAXhLqXFSV1eSLT+XTZwQt8aFfK4UQ/McyEdERt3BUN08+NqbrpcnuF3z6iMM9dTVJjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631542; c=relaxed/simple;
	bh=uk9h3Wx0jSORRrHDHQSRvVeuJxvNL1Zwsnc30WAZZ4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6ZdftETMsWX+AlYmPpsBIVmi6cw2ziEsEc8n34s0iPGL8kQj20KQJGapW6TKACqthd9WkHN9xM0x1OkmijCxox2RfVuujs/TJfJaOuZYYFw/iZyFcGsiK5rvap7VAXGqcWO+WZ0VnLlQ95c9BN5pKv95v54NHY+5SJFRu6wkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=eOSSw3/R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z2L7dX6F; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 9731C1C000FB;
	Wed,  5 Jun 2024 19:52:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 05 Jun 2024 19:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631539; x=
	1717717939; bh=AB80wdRifDotWyffJuTSQTTcEEsAJXA4WZpWq0bUy8E=; b=e
	OSSw3/RpFGMk4leo2UEieIUx2A3danNKIDOUPtq8OSI4N2pGkTAw7WXRtS0isezo
	bpTixwOo1VuF1Iv/mXn9MfcLT5ke3lAVCvGrZFB06m85BFFbLwh7JBJ6hspIay/7
	L1Jgy1AMVkVIeVf0B+9Cj8rq3nxFdFga/5GicrfK/rxs+2Nzj9Z/4xczpjA3LV4y
	zX8Be6ZlBXgdf1+hFqorhYnCeBTvihgwBlMR0mTQRURDrK5TozZQBJps1LdKV+hO
	yOigwBQHFIOQZwaEmGTyjas85JMcJPvQbC048M4Wk9Mqq4MYwDI4YG6hIkdlmmw6
	JX9tBzOL2MT7UdywLYRdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631539; x=
	1717717939; bh=AB80wdRifDotWyffJuTSQTTcEEsAJXA4WZpWq0bUy8E=; b=Z
	2L7dX6F732FA7CZWTNDbwSkFoEQXYHgYnPHhLP8VvfjUxzVrbLbs9ctWM7rtFtnu
	tmN85I4A46F5yiwmj+qM/fa9IYlq/ndvPL2WTFzy3IUrCloLaazWylMqNAyQ9NeE
	+IwFpydXfqZnqnaYQtessBsycjW5tHtSNPVTYJQL6kh33+LxgUNzwA4NHT+eX6qC
	ZcXlMN6cdHRMCeh6NC/6RfzLHJRvZezuGvCiUi/ZRw8d3yQM4fzPP7i3e+UW6Ska
	LBVpmgUhmtREEzrdi27Zqux+cfzxuUcTq7MP13JmV512MCJq3O7FqA1u8qT7hCCP
	VGcEpj+GuJa0GPJV6rCtg==
X-ME-Sender: <xms:M_pgZl7X8HfI1dvjGtlmdg0U-4Yai-t1i7tMcHOml9sY3g1txRE1zw>
    <xme:M_pgZi5DqMlRyx-KAh-IkA3CnCXI-oPlyJxXwowgLxdv2pa1v1iMtqrUb9WBlhjqK
    80zQ5adebBHavTNhvo>
X-ME-Received: <xmr:M_pgZsdGyNLYb_LlyFM-27FBhw5ssVzT4bDFVZjN_wPncMV3bCOiWHnjj0dJqhPb5zz6aZZmiamgzG-MeDwOFWiAEp4gJoDE6cl0p6u0C8v8cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:M_pgZuJYNMWm1xw6mOjOSjA8bsiwKGB8IKIdfLcsTpBAZQx9o1bLdg>
    <xmx:M_pgZpKowCdfyQFGlmb9oH_1nR4IIhRcqO2LfIkMpuuX3c2PBjrALg>
    <xmx:M_pgZnyO-YfnJN9TLwK4sfRLd0J4_Uc6NG5nD6bTe2Hsh1rGImCXZg>
    <xmx:M_pgZlKkMnDtMkMaCRwN7npgNdUo2-4joitMLk85Y0GK9ieqShdwnw>
    <xmx:M_pgZgV2bZAynlzrTUYn8tNCuZMS_GxFkTcg1vF7xzzM5MNNkVOJa_gB>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:18 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] firewire: ohci: use helper inline functions to serialize/deserialize self ID packet
Date: Thu,  6 Jun 2024 08:51:53 +0900
Message-ID: <20240605235155.116468-10-o-takashi@sakamocchi.jp>
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
 drivers/firewire/ohci.c | 69 +++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 342407d8bc9b..1f6097a6366c 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -477,7 +477,7 @@ static void log_selfids(struct fw_ohci *ohci, int generation, int self_id_count)
 		ohci_notice(ohci,
 		    "selfID 0: %08x, phy %d [%c%c%c] %s gc=%d %s %s%s%s\n",
 		    *s,
-		    *s >> 24 & 63,
+		    phy_packet_self_id_get_phy_id(*s),
 		    port[self_id_sequence_get_port_status(s, quadlet_count, 0)],
 		    port[self_id_sequence_get_port_status(s, quadlet_count, 1)],
 		    port[self_id_sequence_get_port_status(s, quadlet_count, 2)],
@@ -490,7 +490,7 @@ static void log_selfids(struct fw_ohci *ohci, int generation, int self_id_count)
 			ohci_notice(ohci,
 			    "selfID n: %08x, phy %d [%c%c%c%c%c%c%c%c]\n",
 			    s[i],
-			    s[i] >> 24 & 63,
+			    phy_packet_self_id_get_phy_id(s[i]),
 			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index)],
 			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 1)],
 			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 2)],
@@ -1846,7 +1846,8 @@ static u32 update_bus_time(struct fw_ohci *ohci)
 	return ohci->bus_time | cycle_time_seconds;
 }
 
-static int get_status_for_port(struct fw_ohci *ohci, int port_index)
+static int get_status_for_port(struct fw_ohci *ohci, int port_index,
+			       enum phy_packet_self_id_port_status *status)
 {
 	int reg;
 
@@ -1860,33 +1861,44 @@ static int get_status_for_port(struct fw_ohci *ohci, int port_index)
 
 	switch (reg & 0x0f) {
 	case 0x06:
-		return 2;	/* is child node (connected to parent node) */
+		// is child node (connected to parent node)
+		*status = PHY_PACKET_SELF_ID_PORT_STATUS_PARENT;
+		break;
 	case 0x0e:
-		return 3;	/* is parent node (connected to child node) */
+		// is parent node (connected to child node)
+		*status = PHY_PACKET_SELF_ID_PORT_STATUS_CHILD;
+		break;
+	default:
+		// not connected
+		*status = PHY_PACKET_SELF_ID_PORT_STATUS_NCONN;
+		break;
 	}
-	return 1;		/* not connected */
+
+	return 0;
 }
 
 static int get_self_id_pos(struct fw_ohci *ohci, u32 self_id,
 	int self_id_count)
 {
+	unsigned int left_phy_id = phy_packet_self_id_get_phy_id(self_id);
 	int i;
-	u32 entry;
 
 	for (i = 0; i < self_id_count; i++) {
-		entry = ohci->self_id_buffer[i];
-		if ((self_id & 0xff000000) == (entry & 0xff000000))
+		u32 entry = ohci->self_id_buffer[i];
+		unsigned int right_phy_id = phy_packet_self_id_get_phy_id(entry);
+
+		if (left_phy_id == right_phy_id)
 			return -1;
-		if ((self_id & 0xff000000) < (entry & 0xff000000))
+		if (left_phy_id < right_phy_id)
 			return i;
 	}
 	return i;
 }
 
-static int initiated_reset(struct fw_ohci *ohci)
+static bool initiated_reset(struct fw_ohci *ohci)
 {
 	int reg;
-	int ret = 0;
+	int ret = false;
 
 	mutex_lock(&ohci->phy_reg_mutex);
 	reg = write_phy_reg(ohci, 7, 0xe0); /* Select page 7 */
@@ -1899,7 +1911,7 @@ static int initiated_reset(struct fw_ohci *ohci)
 			if (reg >= 0) {
 				if ((reg & 0x08) == 0x08) {
 					/* bit 3 indicates "initiated reset" */
-					ret = 0x2;
+					ret = true;
 				}
 			}
 		}
@@ -1915,9 +1927,14 @@ static int initiated_reset(struct fw_ohci *ohci)
  */
 static int find_and_insert_self_id(struct fw_ohci *ohci, int self_id_count)
 {
-	int reg, i, pos, status;
-	/* link active 1, speed 3, bridge 0, contender 1, more packets 0 */
-	u32 self_id = 0x8040c800;
+	int reg, i, pos;
+	u32 self_id = 0;
+
+	// link active 1, speed 3, bridge 0, contender 1, more packets 0.
+	phy_packet_set_packet_identifier(&self_id, PHY_PACKET_PACKET_IDENTIFIER_SELF_ID);
+	phy_packet_self_id_zero_set_link_active(&self_id, true);
+	phy_packet_self_id_zero_set_scode(&self_id, SCODE_800);
+	phy_packet_self_id_zero_set_contender(&self_id, true);
 
 	reg = reg_read(ohci, OHCI1394_NodeID);
 	if (!(reg & OHCI1394_NodeID_idValid)) {
@@ -1925,26 +1942,30 @@ static int find_and_insert_self_id(struct fw_ohci *ohci, int self_id_count)
 			    "node ID not valid, new bus reset in progress\n");
 		return -EBUSY;
 	}
-	self_id |= ((reg & 0x3f) << 24); /* phy ID */
+	phy_packet_self_id_set_phy_id(&self_id, reg & 0x3f);
 
 	reg = ohci_read_phy_reg(&ohci->card, 4);
 	if (reg < 0)
 		return reg;
-	self_id |= ((reg & 0x07) << 8); /* power class */
+	phy_packet_self_id_zero_set_power_class(&self_id, reg & 0x07);
 
 	reg = ohci_read_phy_reg(&ohci->card, 1);
 	if (reg < 0)
 		return reg;
-	self_id |= ((reg & 0x3f) << 16); /* gap count */
+	phy_packet_self_id_zero_set_gap_count(&self_id, reg & 0x3f);
 
 	for (i = 0; i < 3; i++) {
-		status = get_status_for_port(ohci, i);
-		if (status < 0)
-			return status;
-		self_id |= ((status & 0x3) << (6 - (i * 2)));
+		enum phy_packet_self_id_port_status status;
+		int err;
+
+		err = get_status_for_port(ohci, i, &status);
+		if (err < 0)
+			return err;
+
+		self_id_sequence_set_port_status(&self_id, 1, i, status);
 	}
 
-	self_id |= initiated_reset(ohci);
+	phy_packet_self_id_zero_set_initiated_reset(&self_id, initiated_reset(ohci));
 
 	pos = get_self_id_pos(ohci, self_id, self_id_count);
 	if (pos >= 0) {
-- 
2.43.0


