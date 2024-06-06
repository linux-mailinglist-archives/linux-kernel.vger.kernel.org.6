Return-Path: <linux-kernel+bounces-205170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8342A8FF853
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83DAB2192E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A791411F1;
	Thu,  6 Jun 2024 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fXI0rXUH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qwsTcpzn"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35B13E05C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717904; cv=none; b=h6GNOkU3PplIqC4SvIUDm/cJC6jEO2eoF/9kYwZ/Qps4q1jwunpa9G13gws9iovAWRtoRh9Q7EZdvO5H03L00s7vVK86l+mqRkZRtq4uWZ3jOmrVSf5bZWRVSsZggliyspHuMfKsV/FYBsFeD2EQSep0QN2dPcjMFB9symS2wAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717904; c=relaxed/simple;
	bh=Kmj+i0v+DFwKiujBpyuW7KQ0Fg35R84W8KNYnly7maw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiPUNYhP8oZRQl3nVsEd54DlaxyW78jNymSRWRTQhOtZZXfGG8vBxRkP4PtrGNZBOq/EBDDRMNbJU8Ffvj0SZPeBZEuFdcaFWvnbP48VOmFIDsOFnrzYTJpdLwZ270/NgG+shDnKo7vh8QdZuHU0dsHpN1aC2zA0x30fIB2E3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=fXI0rXUH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qwsTcpzn; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5AE0118000BA;
	Thu,  6 Jun 2024 19:51:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 19:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717717901; x=
	1717804301; bh=hgIseeRWLwrqaDf1AxemlHyL2UEM6IH/z/P6IZmSF1k=; b=f
	XI0rXUHUHazDHTPrgaB3xJ8mqp52t2aR3/wRZ4YQjLAfr1gIlPOAxxGaDqqPDr4t
	dIU6rHKnBa/b9CDVzkC/ZpZwMk4RXj7zidJvSzY45T++l5TkYTvtRVQDZtYKqiOB
	CxFIJR/AmqwfMpd1R9Ue6uWoqgmr66sZ5qrXl9XFyO/Va1T3+BrozV8PTJ4pSzQD
	lC9RG3J5mLpIwQ5gbz2ibyCUaunVlWZqHPlnNdGyxAUKr5nV4hJ8P033fYDGzWZs
	kftG/rZiCGaPm/NsjDLh1rJmi/+uZ4Wzxm9CFuLRP8w9ctGVhnlvs3CRdqiWRzJw
	tZr7YyUe8Wy80FsywWHLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717717901; x=
	1717804301; bh=hgIseeRWLwrqaDf1AxemlHyL2UEM6IH/z/P6IZmSF1k=; b=q
	wsTcpznBs+woSy2dl1UTr1YDYgDDwDCoRiDa5vmXcmQf//DhrNREzsfKCttmm4Gl
	CKNuN1oMGx1F7TvlES3fqGdZJAeOdSrTi6ZONHBRDNOwPFqO5HNtTgenyCn0WdA3
	QI2ROKm92gUH9Fq/HgWtKPJtT6isJTtS4PrcOh49WE6SF4UMHC/RSDaunb1mVGvq
	lBTNeALsuPfjRZNbo9HZsfOsPQphqrKDvDdtmQ4ojc7agRQaxpk+rKf7uEO5pZKb
	u/DvAwi9k6d+KuaAhRxgIbPtZFczfO0I4lFkjjI1NHEh2kyF2ERE8lFuR6RK915N
	u12tLR39gMyzXjUbSraTA==
X-ME-Sender: <xms:jEtiZvE7Vbk-LpBeTtlLNn6mD1E1gmwBxjZPHr3LXMG6rNI9iYPc9A>
    <xme:jEtiZsUnRwVlUT1CuzntcKfx8F5JcV5Je2GXCOi0HDQ4JnGihdtVPXYGf2V-RKR6r
    8TDpntSFxydywgluZw>
X-ME-Received: <xmr:jEtiZhJFA6T-RvHyAOdMIoVxlXn_ZAHySNGZf19gLKiC3SS5hyDMpObgX-7cILZFNJNdhvnBqRrMED9NKcUwQ3hH5KAF50SbG5NL6kX9MI5NWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:jEtiZtEA7lJDsty-izziuzXuUJUly3LeLwSpOFxj8M8vIbmBCHUCTQ>
    <xmx:jEtiZlXjAV8C3SypwupLCZFsTRozB0EODYijePVyztKiVOgRQo20Cg>
    <xmx:jEtiZoPFTu9ojK56vcL2r0oND1TpLlNpubj9HqPqZmjiozPvJaXKWw>
    <xmx:jEtiZk1cX8tg3GtzONb1KTe-L4UA76_cEW47T0_ovet1WVPpWO1BBg>
    <xmx:jEtiZigmhM59OplMt9jrmDmzUCxLp0CSr2oKUNbv_7LTFWxI9weE04Nb>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 19:51:39 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firewire: core: add tests for serialization/deserialization of phy config packet
Date: Fri,  7 Jun 2024 08:51:32 +0900
Message-ID: <20240606235133.231543-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606235133.231543-1-o-takashi@sakamocchi.jp>
References: <20240606235133.231543-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the protocol of IEEE 1394, phy configuration packet is broadcasted to
the bus to configure all PHYs residing on the bus. It includes two
purposes; selecting root node and optimizing gap count.

This commit adds some helper function to serialize/deserialize the
content of phy configuration packet, as well as some KUnit tests for it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/packet-serdes-test.c     | 79 +++++++++++++++++++++++
 drivers/firewire/phy-packet-definitions.h | 55 ++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/firewire/packet-serdes-test.c b/drivers/firewire/packet-serdes-test.c
index 65cfbf1baee7..35b966eec8a5 100644
--- a/drivers/firewire/packet-serdes-test.c
+++ b/drivers/firewire/packet-serdes-test.c
@@ -248,6 +248,29 @@ static void deserialize_phy_packet_self_id_extended(u32 quadlet, unsigned int *p
 	*has_more_packets = phy_packet_self_id_get_more_packets(quadlet);
 }
 
+static void serialize_phy_packet_phy_config(u32 *quadlet, unsigned int packet_identifier,
+					    unsigned int root_id, bool has_force_root_node,
+					    bool has_gap_count_optimization, unsigned int gap_count)
+{
+	phy_packet_set_packet_identifier(quadlet, packet_identifier);
+	phy_packet_phy_config_set_root_id(quadlet, root_id);
+	phy_packet_phy_config_set_force_root_node(quadlet, has_force_root_node);
+	phy_packet_phy_config_set_gap_count_optimization(quadlet, has_gap_count_optimization);
+	phy_packet_phy_config_set_gap_count(quadlet, gap_count);
+}
+
+static void deserialize_phy_packet_phy_config(u32 quadlet, unsigned int *packet_identifier,
+					      unsigned int *root_id, bool *has_force_root_node,
+					      bool *has_gap_count_optimization,
+					      unsigned int *gap_count)
+{
+	*packet_identifier = phy_packet_get_packet_identifier(quadlet);
+	*root_id = phy_packet_phy_config_get_root_id(quadlet);
+	*has_force_root_node = phy_packet_phy_config_get_force_root_node(quadlet);
+	*has_gap_count_optimization = phy_packet_phy_config_get_gap_count_optimization(quadlet);
+	*gap_count = phy_packet_phy_config_get_gap_count(quadlet);
+}
+
 static void test_async_header_write_quadlet_request(struct kunit *test)
 {
 	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
@@ -811,6 +834,60 @@ static void test_phy_packet_self_id_zero_and_one(struct kunit *test)
 	KUNIT_EXPECT_MEMEQ(test, quadlets, expected, sizeof(expected));
 }
 
+static void test_phy_packet_phy_config_force_root_node(struct kunit *test)
+{
+	const u32 expected = 0x02800000;
+	u32 quadlet = 0;
+
+	unsigned int packet_identifier;
+	unsigned int root_id;
+	bool has_force_root_node;
+	bool has_gap_count_optimization;
+	unsigned int gap_count;
+
+	deserialize_phy_packet_phy_config(expected, &packet_identifier, &root_id,
+					  &has_force_root_node, &has_gap_count_optimization,
+					  &gap_count);
+
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_PACKET_IDENTIFIER_PHY_CONFIG, packet_identifier);
+	KUNIT_EXPECT_EQ(test, 0x02, root_id);
+	KUNIT_EXPECT_TRUE(test, has_force_root_node);
+	KUNIT_EXPECT_FALSE(test, has_gap_count_optimization);
+	KUNIT_EXPECT_EQ(test, 0, gap_count);
+
+	serialize_phy_packet_phy_config(&quadlet, packet_identifier, root_id, has_force_root_node,
+					has_gap_count_optimization, gap_count);
+
+	KUNIT_EXPECT_EQ(test, quadlet, expected);
+}
+
+static void test_phy_packet_phy_config_gap_count_optimization(struct kunit *test)
+{
+	const u32 expected = 0x034f0000;
+	u32 quadlet = 0;
+
+	unsigned int packet_identifier;
+	unsigned int root_id;
+	bool has_force_root_node;
+	bool has_gap_count_optimization;
+	unsigned int gap_count;
+
+	deserialize_phy_packet_phy_config(expected, &packet_identifier, &root_id,
+					  &has_force_root_node, &has_gap_count_optimization,
+					  &gap_count);
+
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_PACKET_IDENTIFIER_PHY_CONFIG, packet_identifier);
+	KUNIT_EXPECT_EQ(test, 0x03, root_id);
+	KUNIT_EXPECT_FALSE(test, has_force_root_node);
+	KUNIT_EXPECT_TRUE(test, has_gap_count_optimization);
+	KUNIT_EXPECT_EQ(test, 0x0f, gap_count);
+
+	serialize_phy_packet_phy_config(&quadlet, packet_identifier, root_id, has_force_root_node,
+					has_gap_count_optimization, gap_count);
+
+	KUNIT_EXPECT_EQ(test, quadlet, expected);
+}
+
 static struct kunit_case packet_serdes_test_cases[] = {
 	KUNIT_CASE(test_async_header_write_quadlet_request),
 	KUNIT_CASE(test_async_header_write_block_request),
@@ -825,6 +902,8 @@ static struct kunit_case packet_serdes_test_cases[] = {
 	KUNIT_CASE(test_phy_packet_self_id_zero_case0),
 	KUNIT_CASE(test_phy_packet_self_id_zero_case1),
 	KUNIT_CASE(test_phy_packet_self_id_zero_and_one),
+	KUNIT_CASE(test_phy_packet_phy_config_force_root_node),
+	KUNIT_CASE(test_phy_packet_phy_config_gap_count_optimization),
 	{}
 };
 
diff --git a/drivers/firewire/phy-packet-definitions.h b/drivers/firewire/phy-packet-definitions.h
index 8f78494ad371..03c7c606759f 100644
--- a/drivers/firewire/phy-packet-definitions.h
+++ b/drivers/firewire/phy-packet-definitions.h
@@ -21,6 +21,61 @@ static inline void phy_packet_set_packet_identifier(u32 *quadlet, unsigned int p
 	*quadlet |= (packet_identifier << PACKET_IDENTIFIER_SHIFT) & PACKET_IDENTIFIER_MASK;
 }
 
+#define PHY_PACKET_PACKET_IDENTIFIER_PHY_CONFIG		0
+
+#define PHY_CONFIG_ROOT_ID_MASK				0x3f000000
+#define PHY_CONFIG_ROOT_ID_SHIFT			24
+#define PHY_CONFIG_FORCE_ROOT_NODE_MASK			0x00800000
+#define PHY_CONFIG_FORCE_ROOT_NODE_SHIFT		23
+#define PHY_CONFIG_GAP_COUNT_OPTIMIZATION_MASK		0x00400000
+#define PHY_CONFIG_GAP_COUNT_OPTIMIZATION_SHIFT		22
+#define PHY_CONFIG_GAP_COUNT_MASK			0x003f0000
+#define PHY_CONFIG_GAP_COUNT_SHIFT			16
+
+static inline unsigned int phy_packet_phy_config_get_root_id(u32 quadlet)
+{
+	return (quadlet & PHY_CONFIG_ROOT_ID_MASK) >> PHY_CONFIG_ROOT_ID_SHIFT;
+}
+
+static inline void phy_packet_phy_config_set_root_id(u32 *quadlet, unsigned int root_id)
+{
+	*quadlet &= ~PHY_CONFIG_ROOT_ID_MASK;
+	*quadlet |= (root_id << PHY_CONFIG_ROOT_ID_SHIFT) & PHY_CONFIG_ROOT_ID_MASK;
+}
+
+static inline bool phy_packet_phy_config_get_force_root_node(u32 quadlet)
+{
+	return (quadlet & PHY_CONFIG_FORCE_ROOT_NODE_MASK) >> PHY_CONFIG_FORCE_ROOT_NODE_SHIFT;
+}
+
+static inline void phy_packet_phy_config_set_force_root_node(u32 *quadlet, bool has_force_root_node)
+{
+	*quadlet &= ~PHY_CONFIG_FORCE_ROOT_NODE_MASK;
+	*quadlet |= (has_force_root_node << PHY_CONFIG_FORCE_ROOT_NODE_SHIFT) & PHY_CONFIG_FORCE_ROOT_NODE_MASK;
+}
+
+static inline bool phy_packet_phy_config_get_gap_count_optimization(u32 quadlet)
+{
+	return (quadlet & PHY_CONFIG_GAP_COUNT_OPTIMIZATION_MASK) >> PHY_CONFIG_GAP_COUNT_OPTIMIZATION_SHIFT;
+}
+
+static inline void phy_packet_phy_config_set_gap_count_optimization(u32 *quadlet, bool has_gap_count_optimization)
+{
+	*quadlet &= ~PHY_CONFIG_GAP_COUNT_OPTIMIZATION_MASK;
+	*quadlet |= (has_gap_count_optimization << PHY_CONFIG_GAP_COUNT_OPTIMIZATION_SHIFT) & PHY_CONFIG_GAP_COUNT_OPTIMIZATION_MASK;
+}
+
+static inline unsigned int phy_packet_phy_config_get_gap_count(u32 quadlet)
+{
+	return (quadlet & PHY_CONFIG_GAP_COUNT_MASK) >> PHY_CONFIG_GAP_COUNT_SHIFT;
+}
+
+static inline void phy_packet_phy_config_set_gap_count(u32 *quadlet, unsigned int gap_count)
+{
+	*quadlet &= ~PHY_CONFIG_GAP_COUNT_MASK;
+	*quadlet |= (gap_count << PHY_CONFIG_GAP_COUNT_SHIFT) & PHY_CONFIG_GAP_COUNT_MASK;
+}
+
 #define PHY_PACKET_PACKET_IDENTIFIER_SELF_ID		2
 
 #define SELF_ID_PHY_ID_MASK				0x3f000000
-- 
2.43.0


