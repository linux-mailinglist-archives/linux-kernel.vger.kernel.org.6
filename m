Return-Path: <linux-kernel+bounces-203424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93758FDAEA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DFC283CAE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3689F16C6AB;
	Wed,  5 Jun 2024 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XvrMfI6y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ef9PfqWb"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0416ABCE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631529; cv=none; b=kqNcXYehAC60vowE74sgiRmSOA37pbtPs0nqhta/wp10N6cfdkFDKiZ0XppIe8Yh/69XUDU/+H8WrbAJ40dnp3GIxS73TSN3al+1yAAXolSPvgX01+Quk10gN4bksY83YpG5weg7rNGdv30JxkgFFzLgIi5EvL4gwG608sDaqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631529; c=relaxed/simple;
	bh=NgEEf4d684CncBM/JTi6jXqL40cqTGcloTccTf3mAb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkDfqWqWBZaMAuwsxF4acAM4KMBdxaNSX3tEBzWoypRCpLBk26G3oooW1XheBrA9UIQ1uKfwerJCm/QwYjUMqi9n/j63CNigi9eKFL5F8PfHS5+Zf7C22yroHCei0RXb/AZvYkaH8bILEziIZR86Ho6IPECabQVknhV7tx3MO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=XvrMfI6y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ef9PfqWb; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id E8CC91800124;
	Wed,  5 Jun 2024 19:52:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jun 2024 19:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631526; x=
	1717717926; bh=V1TVjKe7dwYJE6Q/S0G6qvmCcYsfTJyJOHYYPXE4GI4=; b=X
	vrMfI6ysLPMQFljgayKpbPcIch6zg5Z8ksfXRxK64JCxZ//Zh52K6iWLQmgrGoUb
	XstwWrhhfRqEgGwEIEYtLMZskNup7Ocmo9SVlsdgihwY6WxyLuIUBTg3OUxh395b
	/nw57UGAHKhzori+igEYOt4sBrYc8VOI1Q47x/fMlBbZH/g6SX5Y0Ced7P6sllzR
	GQM5pltvxNw6260GHjfKcIH6f4/2UnKQyxcxypw1qPPgxh3MJfrfpYdp13aAexnT
	Fydj2fcdKPshYl9UMBLXYD/iXMYZJgtNpI5deAS57pkkQ5ib77glnnkAvjMpTAOv
	qedUTe3nYxypH48i7UjTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631526; x=
	1717717926; bh=V1TVjKe7dwYJE6Q/S0G6qvmCcYsfTJyJOHYYPXE4GI4=; b=E
	f9PfqWbTK3+sOYwRfk00w0CBqy+SMZHTvLBVYqNQ4W06//vgi/6sFig9CZ43092N
	agT2iE259sXNWMWXaqVwK/IS+mOXw1wUQWmRlEDtvnNl1J+01e/C/w3dVLj459EJ
	Efo3vBxcnom6EcvWGasPnEL9eJzvEEmhID8mNj0mn7wAsILFRFna8WoLfqJm6eRn
	LsaxsOHGrzA5y/OjHCQhBRiInRnkvrZJnPzHC1qBXbnKuXq34XPpGBEV5PCDHK76
	x15yKQsXOVly0fDWKZTRoSj794NEfDeInjl28qQRp4d5jIauHh7Dx96qULM0CNTI
	9M6jOksqerRflWfTbwj1A==
X-ME-Sender: <xms:JvpgZndZ0mtyuQzTyt43Hw-57GxA_ux9rA4JcWgviMk1qLHiBBb9Yw>
    <xme:JvpgZtMdm9iiam5K8je3z07BpREJlSYQFrUFLGUrwGzffcUCxCsGKamaDbbo6TJ2g
    k8_PkThqt5xFTmnEYU>
X-ME-Received: <xmr:JvpgZgiduwaKlZdzbrbEgfMJ6xG624Zxq7x2tVhzAFicKmhy9NdVeuavgHMW25cEXhAEmaDYFOOk3_9osSjcBT_1ArhZ9V-K7c8NZhMVs2HgOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:JvpgZo94OmXhI0zQW3QaAb1vgBy4SA5QV2Dv1rZuy10Oxc8mzfg3EA>
    <xmx:JvpgZjuTTQR52ZO2fjlPWUTH00WDydWdUCmSgkYOA5tdfnwlzTfeag>
    <xmx:JvpgZnFOmeyfMz_z_ln4EvDBioH2oguCT7SzCM1sUHAAIF4pWiqgqQ>
    <xmx:JvpgZqN9iTrUQWD2xnc5pLOHtrZb8tsAU4Bc25n6hZJvWfPVGhWcsQ>
    <xmx:JvpgZs6sw2XOLw9DYuSvCf-tO6eM4yJQOoNTFzG1RInkSsih1LcDtpi1>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:05 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] firewire: core: minor code refactoring for topology builder
Date: Thu,  6 Jun 2024 08:51:47 +0900
Message-ID: <20240605235155.116468-4-o-takashi@sakamocchi.jp>
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

Current implementation to build tree according to self ID sequences has
the rest to be refactored; e.g. putting local variables into block.

This commit is for the purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 837cc44d8d9f..6a039293ee63 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -38,14 +38,11 @@
 #define SELFID_PORT_NCONN	0x1
 #define SELFID_PORT_NONE	0x0
 
-static u32 *count_ports(u32 *sid, int *total_port_count, int *child_port_count)
+static const u32 *count_ports(const u32 *sid, int *total_port_count, int *child_port_count)
 {
 	u32 q;
 	int port_type, shift, seq;
 
-	*total_port_count = 0;
-	*child_port_count = 0;
-
 	shift = 6;
 	q = *sid;
 	seq = 0;
@@ -89,7 +86,7 @@ static u32 *count_ports(u32 *sid, int *total_port_count, int *child_port_count)
 	}
 }
 
-static int get_port_type(u32 *sid, int port_index)
+static int get_port_type(const u32 *sid, int port_index)
 {
 	int index, shift;
 
@@ -169,13 +166,12 @@ static inline struct fw_node *fw_node(struct list_head *l)
  * internally consistent.  On success this function returns the
  * fw_node corresponding to the local card otherwise NULL.
  */
-static struct fw_node *build_tree(struct fw_card *card,
-				  u32 *sid, int self_id_count)
+static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self_id_count)
 {
 	struct fw_node *node, *child, *local_node, *irm_node;
-	struct list_head stack, *h;
-	u32 *next_sid, *end, q;
-	int i, port_count, child_port_count, phy_id, parent_count, stack_depth;
+	struct list_head stack;
+	const u32 *end;
+	int phy_id, stack_depth;
 	int gap_count;
 	bool beta_repeaters_present;
 
@@ -190,8 +186,15 @@ static struct fw_node *build_tree(struct fw_card *card,
 	beta_repeaters_present = false;
 
 	while (sid < end) {
-		next_sid = count_ports(sid, &port_count, &child_port_count);
+		int port_count = 0;
+		int child_port_count = 0;
+		int parent_count = 0;
+		const u32 *next_sid;
+		u32 q;
+		struct list_head *h;
+		int i;
 
+		next_sid = count_ports(sid, &port_count, &child_port_count);
 		if (next_sid == NULL) {
 			fw_err(card, "inconsistent extended self IDs\n");
 			return NULL;
-- 
2.43.0


