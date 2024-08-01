Return-Path: <linux-kernel+bounces-270542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D588F94412A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139A61C230C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0D7E574;
	Thu,  1 Aug 2024 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fAe3eAHL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IRx12KAb"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843512DD95
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722479196; cv=none; b=PTqNSzkTSR1jv5qT0S/ZNUTYgQpFYNwGznlegne4mNQgLKBy/9zYuu8EIB1hNXRXQ1g7xCxt9tyAtEJi3xpTxXI8dJgfRQp/BtzI+DqzYt8khRFauDM2eDm8vpuqvEek2qaTY/03bLexxUJBD4ZT7JUFPlHwK3YYy2ybCE/A/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722479196; c=relaxed/simple;
	bh=jY+SeGMwyBpNmE3iBFvhyoQLcGovdl2KLaIBzojQdAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFY0AO+1SOBeHmpNrvA0pgdrEu32V+5XhTX7ACZSsLMvphLAd0TUknSU0gcUedtRV89MlZmqA//lHr0TE/8091Y9o6jC4TpOLEOSYmePcvAR5ZYIxlxPt2P4TyG55yJYAw8vhvq3HBA4M6volFBMijJc7mJ4QDgeTVawmBp9j0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=fAe3eAHL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IRx12KAb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8ED091147B6A;
	Wed, 31 Jul 2024 22:26:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 31 Jul 2024 22:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1722479193; x=1722565593; bh=/eeK0enPou
	wqRh3ub6FMhUqsaktHD2IwdZMpOOh5Krc=; b=fAe3eAHLmgtLqLp6ADpXEuZyhL
	vdiM/u3/cM2QoenO0prhqioSBxLOAo5VA2BJp0pRsf1AVjb+DLyd5Vm8rAEQV3kJ
	LS4Gl1/4yiMew57o4b8Ph9XXsPIW3XLNWWU6NnJl253zbi+ClT8RdDQGVmzcB8RC
	8TyOe8STbDmSpxkrsG31RCLH0CujlFKislB06ysCbnjSP4e7PkgskoEogpDCGhq3
	yLE0sex3JEb7tVCapZZkon4AbpxJFcXFb2Dnxg49muVzmWmCEglFdKVnE35KKCjd
	p37volMIUMqNtCKWizRhE8JzKcgIWt+PywLX3C7nzg9350/LEnTtTKfOTvzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722479193; x=1722565593; bh=/eeK0enPouwqRh3ub6FMhUqsaktH
	D2IwdZMpOOh5Krc=; b=IRx12KAb4qrqaIRQIR+jnGqqcfaACEueEm9VySVDrtwv
	B3+ERRsaKb75fh4Ki7UjDLpLRLvS56tKbsxK0ng1+YMDbgvQegHObz7uDAQzgNmV
	ehEJeRwkqmjc2z04ETbJoBCFFacdmzUm7862lJ5FJIsVGqDjFlFroxN99mmeN5fI
	l3HHtCp4hPaQi68pbhYchntxc0BhBZuVqdeP9FiXWO9M4oF4Xa9LSN7PiosuL9Of
	++hIown30U+AG8Oc/vSy1gDhSXAVMdrTEXWqv08a0q2fbmCkFy0Wx9WO3Q58fhVn
	jwkRBBhEF4HetqHipWU2DKjsK2M18OyLKgWctDIhiA==
X-ME-Sender: <xms:WfKqZkl6ZCOzuMIBh8J26jfQoOCge50u-5GyGgdlEkOisDHe9L7M5Q>
    <xme:WfKqZj3D56jfMRqgE4wTUJtObY4Ve-iqyHr_l5RIF9YovC2djNfIxEGj8xL5AMWj2
    CHukzrINvVCeXEXLgs>
X-ME-Received: <xmr:WfKqZipHs_3BOwQEFh9s0EcuEBs-jIN78GBuUogZmb9w-Iq9lHHSkCvojH4AW_3P02SgnceYS_-Dih2bzBoIlPRUBaTMKMCCC2lyj3s9OLe71AE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeejgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevke
    duhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:WfKqZgl14GKQ1CCKh6u9p4uDp2UNBxj0KDiBPJayCO58-VOVhLnWCg>
    <xmx:WfKqZi2vR7H7Nbd6uMPthwTPdNKUfYFoEtNa3LN-lmJJyMeBpL4UJA>
    <xmx:WfKqZnugSufcw1kC7yuRGQiB1O6R8EdQTkJulPy7-6UdoanvZuJ-Cw>
    <xmx:WfKqZuVn9pTyBdlg0oE7WoYB_rUaNN2gLiZDdXYac20rojqBTe6EMg>
    <xmx:WfKqZgCVVmH_zjslXUuaYwPQIYbe06esJ1RJUVSu-uB-ZkTJ-GKlWOeI>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 22:26:32 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: utilize kref to maintain fw_node with reference counting
Date: Thu,  1 Aug 2024 11:26:29 +0900
Message-ID: <20240801022629.31857-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation directly uses refcount_t to maintain the life time
of fw_node, while kref is available for the same purpose.

This commit replaces the implementation with kref.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c |  2 +-
 drivers/firewire/core.h          | 15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index b4e637aa6932..46e6eb287d24 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -39,7 +39,7 @@ static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
 	node->initiated_reset = phy_packet_self_id_zero_get_initiated_reset(sid);
 	node->port_count = port_count;
 
-	refcount_set(&node->ref_count, 1);
+	kref_init(&node->kref);
 	INIT_LIST_HEAD(&node->link);
 
 	return node;
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 7c36d2628e37..189e15e6ba82 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -183,7 +183,8 @@ struct fw_node {
 			 * local node to this node. */
 	u8 max_depth:4;	/* Maximum depth to any leaf node */
 	u8 max_hops:4;	/* Max hops in this sub tree */
-	refcount_t ref_count;
+
+	struct kref kref;
 
 	/* For serializing node topology into a list. */
 	struct list_head link;
@@ -196,15 +197,21 @@ struct fw_node {
 
 static inline struct fw_node *fw_node_get(struct fw_node *node)
 {
-	refcount_inc(&node->ref_count);
+	kref_get(&node->kref);
 
 	return node;
 }
 
+static void release_node(struct kref *kref)
+{
+	struct fw_node *node = container_of(kref, struct fw_node, kref);
+
+	kfree(node);
+}
+
 static inline void fw_node_put(struct fw_node *node)
 {
-	if (refcount_dec_and_test(&node->ref_count))
-		kfree(node);
+	kref_put(&node->kref, release_node);
 }
 
 void fw_core_handle_bus_reset(struct fw_card *card, int node_id,
-- 
2.43.0


