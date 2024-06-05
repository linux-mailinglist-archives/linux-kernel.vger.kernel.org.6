Return-Path: <linux-kernel+bounces-203423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7462A8FDAE0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D280C1F24916
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A806C16C423;
	Wed,  5 Jun 2024 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GCm0nEee";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQxoqwk5"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C1168C21
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631527; cv=none; b=COOfVfDBb26tfCrrUuoqaRy3+U7MfTbd+h1qE+LYxvRLGeZehGwi+w6F2Btr5hdU3mtEhOtQUB4lLGtMH0JVqkkjVv+Yfa8Q/nBbEi57+vAQWqNoXqBJOPTmWd6v9mNGUFsN6xPH1foip0O4bzrjEfNn2qPfao/1AvOtccBKnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631527; c=relaxed/simple;
	bh=9QOTyVMAdy8uCsXMMw3kF6ZJlcRvN7TSTx4DhNKqy1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3e5u6N0nDWwlyvW9lOcuM2j9lcyiQmaAHwixQf9znLqeP7cwu0AoOuya/YIDTphvSVH2kfX2jeF1NsosZrf1UwK8eVVQqk04d/pq+ynregGlNtwJZyc8pk5Gf1e0XenS40HpmWVgWJigrskBQIquK7XYrWgHOroUJDC7hgj+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GCm0nEee; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQxoqwk5; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id DCA641C0005B;
	Wed,  5 Jun 2024 19:52:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 19:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631524; x=
	1717717924; bh=1mJaF1de45yn5OE6CI3ft4NIkPoDExHyNENgh8KNRtk=; b=G
	Cm0nEeeWOPVJJJarcYIdirZhBgmJOooYl5l++ptVObMeO+nG8NaFmhY0vNH0ocHA
	Cjv5GEcNAXXQy4jID/B5kxNAc0DE9Z7axk8xgamfHjurv0kH/yAwTHiHeXc2GTcX
	GHRqnXJ7B+L2Q0F4jdcv1J6rGEem45aUfINNH1leVkKB6hjVtmxVBeSwinUod23R
	IfM/cP42W2E4Y07+2rJXLP04HMFZ8KfKBgTW9s5/Tu/RWOJcUl1JmRs8gtwYSQ/K
	bwfrZjYuJKeqsW6GTkX1eUfcNnaP/dXlqYMZYbUER0zPRveacTDuXkjT5jNrYLKb
	nJtXoQZZ9MfhLi46yw8uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631524; x=
	1717717924; bh=1mJaF1de45yn5OE6CI3ft4NIkPoDExHyNENgh8KNRtk=; b=W
	Qxoqwk5y22n8p8hlDt4gEp3GsFNpNQNZxxqtZcCo9rmNeTQ7lfK0odLRAmrIZcr8
	0CMZo7mJZ7eqXjrwqk2LF4gzKPkDe//O6IDoMRH8nwtRufhaNdXO26odTVoiZUyA
	+NBy769xfHzpYnbJ0d7ig7AxVUKJKOm/RqZHwJDRX/oofFGqZv1Fol5GCShn9sYQ
	apT5sdLeXK3NVYzQ3ILsqeFVxsko6YrjcjKDnTUh0+0uQk6VTHgkPT96on5DsZ9W
	KImOaIJNaKzZkROXbmC16qyZqNzDXjO7EJJCN9ZiNgSPZRzgMEZ3od8/lvtC5Nyx
	OtihRMZjy5mxGJAqdxQlQ==
X-ME-Sender: <xms:JPpgZvWLC_0RVFjbyd6s5qBzS8JDgQhrETXCFLxRD_Epc-oqYK2AFQ>
    <xme:JPpgZnnReuFCebseZZiiSvsOBnn2Q5lMSl8jUVUH-5LPNcbQBQ-eFUH0jBBr3dzGY
    mTb1DfSAN7ELRGhjg0>
X-ME-Received: <xmr:JPpgZrY-alrQIZtzjgiscpVg775RS3ET4PAdjm-JX55G5sabKXZGY35-nc0DW0vBdmIt8YROQZN2QmJYmlkSpn3yD4CWLeBuWwJzpATYXNqyLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:JPpgZqWjP9yh_T1m2RixB8J-m6HffDPA6mKm72RfpVUxPKhD-UP1_A>
    <xmx:JPpgZpmvfiI8R_bjp8mwJG5SOmwBj5n8LMpc4Bu12erQ3JNGMUsQxw>
    <xmx:JPpgZnfWppFsbQJRAw1l1O3QB-D8WmNb-c8f-1zJG2AujdTdO2KwOA>
    <xmx:JPpgZjHMCUNoG0AFuMNLf-05EvTUHPZSehlndahGR0mwwZ0v0h216w>
    <xmx:JPpgZuy2TEbM9-Yn_wU_U0UcKLU2lS471hCos_jAmoPoslPU_9L5Nw4G>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:03 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] firewire: core: add helper function to handle port status from self ID sequence and its KUnit test
Date: Thu,  6 Jun 2024 08:51:46 +0900
Message-ID: <20240605235155.116468-3-o-takashi@sakamocchi.jp>
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

The self ID sequence delivers the information about the state of port.

This commit adds some enumerations to express the state of port, and
some helper functions to handle the state. It adds a KUnit test for them,
too.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/phy-packet-definitions.h     | 43 +++++++++++
 .../firewire/self-id-sequence-helper-test.c   | 73 +++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/firewire/phy-packet-definitions.h b/drivers/firewire/phy-packet-definitions.h
index 479bb3431afb..4ba8b18aa993 100644
--- a/drivers/firewire/phy-packet-definitions.h
+++ b/drivers/firewire/phy-packet-definitions.h
@@ -15,6 +15,8 @@
 #define SELF_ID_EXTENDED_SEQUENCE_MASK			0x00700000
 #define SELF_ID_EXTENDED_SEQUENCE_SHIFT			20
 
+#define SELF_ID_PORT_STATUS_MASK			0x3
+
 #define SELF_ID_SEQUENCE_MAXIMUM_QUADLET_COUNT		4
 
 static inline bool phy_packet_self_id_get_extended(u32 quadlet)
@@ -75,4 +77,45 @@ static inline const u32 *self_id_sequence_enumerator_next(
 	return self_id_sequence;
 }
 
+enum phy_packet_self_id_port_status {
+	PHY_PACKET_SELF_ID_PORT_STATUS_NONE = 0,
+	PHY_PACKET_SELF_ID_PORT_STATUS_NCONN = 1,
+	PHY_PACKET_SELF_ID_PORT_STATUS_PARENT = 2,
+	PHY_PACKET_SELF_ID_PORT_STATUS_CHILD = 3,
+};
+
+static inline unsigned int self_id_sequence_get_port_capacity(unsigned int quadlet_count)
+{
+	return quadlet_count * 8 - 5;
+}
+
+static inline enum phy_packet_self_id_port_status self_id_sequence_get_port_status(
+		const u32 *self_id_sequence, unsigned int quadlet_count, unsigned int port_index)
+{
+	unsigned int index, shift;
+
+	index = (port_index + 5) / 8;
+	shift = 16 - ((port_index + 5) % 8) * 2;
+
+	if (index < quadlet_count && index < SELF_ID_SEQUENCE_MAXIMUM_QUADLET_COUNT)
+		return (self_id_sequence[index] >> shift) & SELF_ID_PORT_STATUS_MASK;
+
+	return PHY_PACKET_SELF_ID_PORT_STATUS_NONE;
+}
+
+static inline void self_id_sequence_set_port_status(u32 *self_id_sequence, unsigned int quadlet_count,
+						    unsigned int port_index,
+						    enum phy_packet_self_id_port_status status)
+{
+	unsigned int index, shift;
+
+	index = (port_index + 5) / 8;
+	shift = 16 - ((port_index + 5) % 8) * 2;
+
+	if (index < quadlet_count) {
+		self_id_sequence[index] &= ~(SELF_ID_PORT_STATUS_MASK << shift);
+		self_id_sequence[index] |= status << shift;
+	}
+}
+
 #endif // _FIREWIRE_PHY_PACKET_DEFINITIONS_H
diff --git a/drivers/firewire/self-id-sequence-helper-test.c b/drivers/firewire/self-id-sequence-helper-test.c
index e8a435e20241..eed7a2294e64 100644
--- a/drivers/firewire/self-id-sequence-helper-test.c
+++ b/drivers/firewire/self-id-sequence-helper-test.c
@@ -63,9 +63,82 @@ static void test_self_id_sequence_enumerator_invalid(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, PTR_ERR(entry), -EPROTO);
 }
 
+static void test_self_id_sequence_get_port_status(struct kunit *test)
+{
+	static const u32 expected[] = {
+		0x000000e5,
+		0x00839e79,
+		0x0091e79d,
+		0x00a279e4,
+	};
+	u32 quadlets [] = {
+		0x00000001,
+		0x00800001,
+		0x00900001,
+		0x00a00000,
+	};
+	enum phy_packet_self_id_port_status port_status[28];
+	unsigned int port_capacity;
+	unsigned int port_index;
+
+	KUNIT_ASSERT_EQ(test, ARRAY_SIZE(expected), ARRAY_SIZE(quadlets));
+
+	// With an extra port.
+	port_capacity = self_id_sequence_get_port_capacity(ARRAY_SIZE(expected)) + 1;
+	KUNIT_ASSERT_EQ(test, port_capacity, ARRAY_SIZE(port_status));
+
+	for (port_index = 0; port_index < port_capacity; ++port_index) {
+		port_status[port_index] =
+			self_id_sequence_get_port_status(expected, ARRAY_SIZE(expected), port_index);
+		self_id_sequence_set_port_status(quadlets, ARRAY_SIZE(quadlets), port_index,
+						 port_status[port_index]);
+	}
+
+	// Self ID zero.
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_CHILD, port_status[0]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[1]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[2]);
+
+	// Self ID one.
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_CHILD, port_status[3]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[4]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[5]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_CHILD, port_status[6]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[7]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[8]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_CHILD, port_status[9]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[10]);
+
+	// Self ID two.
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[11]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_CHILD, port_status[12]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[13]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[14]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_CHILD, port_status[15]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[16]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[17]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_CHILD, port_status[18]);
+
+	// Self ID three.
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[19]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[20]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_CHILD, port_status[21]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[22]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[23]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_CHILD, port_status[24]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[25]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[26]);
+
+	// Our of order.
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NONE, port_status[27]);
+
+	KUNIT_EXPECT_MEMEQ(test, quadlets, expected, sizeof(expected));
+}
+
 static struct kunit_case self_id_sequence_helper_test_cases[] = {
 	KUNIT_CASE(test_self_id_sequence_enumerator_valid),
 	KUNIT_CASE(test_self_id_sequence_enumerator_invalid),
+	KUNIT_CASE(test_self_id_sequence_get_port_status),
 	{}
 };
 
-- 
2.43.0


