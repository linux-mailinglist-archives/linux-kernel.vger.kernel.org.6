Return-Path: <linux-kernel+bounces-203428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B13C68FDAF4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1731AB23096
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB2C16F90A;
	Wed,  5 Jun 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="R7M5gYwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSxvLFpG"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4D16EBE4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631538; cv=none; b=kMD3N1Jn6Bcz32T7z1XvqCrJ3RxTDzGIaOx2bwnlPNssvjA3u3uN/4acyWp48XQGS1oalCOt2UKU9sLvJ0nZmP+r1B06fQbnEoGjMwUTebhIdYMCJV947/956RfZ/QJ8X7DIfa0bo++igwO2O85JoYaHZCs5VWkYNnKK5CY7pM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631538; c=relaxed/simple;
	bh=NTRt9E+C5xRQqaC/Uvbn6Ytg1QV2WuULGzLYg+a1XAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVHomjkP92Oc9BeMTLKeRucABOPQmcbnZfSz1mNZiaxOkeRctdb7GOgRFKnzjBn5+4CYnzztgitb4O8DldtL4BqJvxrZ6fyEygkFnG1HLlN7bnfV9xa+nld0Wwflh37IXU6wpbEkjDOjhUhiOb/7W9ewGLhwqhfoyO5HKYAdj+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=R7M5gYwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSxvLFpG; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 7E6F61C000A2;
	Wed,  5 Jun 2024 19:52:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jun 2024 19:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631535; x=
	1717717935; bh=vHlq0ZKzEwlpJxFJg/r2e4RZVzz0LGqjE3vNcaSDf6M=; b=R
	7M5gYwqjghTO2SeAknk+HjnMK3FvZ/UqBGEALdYLdGJwxVpCHDhCP0KTAo668244
	HBt4XdLRtb/vZ02F37TYel0xrzzBXLLLcoSQPoSv2Ipe4EYnBL+4CGPKTNFgJ22g
	sB6Ekyk0PAXj5jiNAiSZuMSXk+tpss7tQENC6q8IjWXte8iAH2ei89FQ3Uv5TsEM
	shlcL06P79TfMvaTvshGGzbL87x3/59BLR0Va6vYCuyDs8kKbQyisWItPxxLEt0P
	YyXApzfLyJ4vsQPbMMKkHPoIglmAfGpiAQGS6aXHcoR4D5eVKENCC0BOn7TyeO5z
	jIlscl83gHYFEmhfesYzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631535; x=
	1717717935; bh=vHlq0ZKzEwlpJxFJg/r2e4RZVzz0LGqjE3vNcaSDf6M=; b=b
	SxvLFpGHZOfnrDrwnLcjexBQsHHkOhInBLKG1ghAa2D2ZriPeODKE2zawm8dURMy
	JbhWoicUNMRtyObK3q7evyIdIk6J4hYajo+cAeG3lQq/YEjzYuttnywksk+3AoOn
	nJe7pqKBVwCSLnj8RpP/n2DFPftH8sFHLQ9ikVfUI3HlXhki4Z3KNttSKYZ7ZhEq
	9r823wm2G1k/t1vjnq7YmHblpXiaNimUN5iEY5FUBNOifGBhiwt4N4frMKrn9ZHo
	GCZTdw4nZZEr0drnio18K/JFskTsQmygKlE6EhJRxypICEkPmuynAu8IZmNeL9sx
	hmLwchuw0vOTOrRxIKFQQ==
X-ME-Sender: <xms:LvpgZiyhHJbX2c0TFti40hM8eRX3CynECO3PfTmzT8oGZIG91HR-Sg>
    <xme:LvpgZuRDhKeh0AhBjzIrXIGe48rF_8Xoz6f0WziidPBfsnN_C7ZzYxpGrkQcgiRho
    L_viWzpBCY9LItVDUQ>
X-ME-Received: <xmr:LvpgZkUY4G0g9zBzgyOogUpg3Km3Kom0P7aAe7t-JEsVy9u3PdjEx07IFikAGJLOpOBTdix-01SLn2ou-LfpgPssbugMyBQqnCb1aKZvHcOjxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:LvpgZoi_t5hPSGRweuHwlthrScAIR3ROkWDsa6-jIBRvvlXa1TVmuA>
    <xmx:L_pgZkCB9NktWuifyr-FQzQZnpk_hgJvnpiwRhbSrXuxk2zTEU6_sg>
    <xmx:L_pgZpIkIaEOlTaAYc8fS-hPq5ECb8QF5K7JrCQy-6AlZA7xhjV0zw>
    <xmx:L_pgZrBPLSf0ibUCXjA_jLMflFV0Vb-Q4oPCY7iBn7iPVzikEjLzfQ>
    <xmx:L_pgZnN21h9RlZfQpHpTjPONT6jQWvRDESRzMKY45HzHzgPxF7ycoUuS>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:13 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] firewire: core: add common inline functions to serialize/deserialize self ID packet
Date: Thu,  6 Jun 2024 08:51:51 +0900
Message-ID: <20240605235155.116468-8-o-takashi@sakamocchi.jp>
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

Within FireWire subsystem, the serializations and deserializations of phy
packet are implemented in several parts. They includes some redundancies.

This commit adds a series of helper functions for the serializations and
deserializations of self ID packet with a Kunit test suite.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/packet-serdes-test.c     | 255 ++++++++++++++++++++++
 drivers/firewire/phy-packet-definitions.h | 126 +++++++++++
 2 files changed, 381 insertions(+)

diff --git a/drivers/firewire/packet-serdes-test.c b/drivers/firewire/packet-serdes-test.c
index e83b1fece780..c56199e84f91 100644
--- a/drivers/firewire/packet-serdes-test.c
+++ b/drivers/firewire/packet-serdes-test.c
@@ -10,6 +10,7 @@
 #include <linux/firewire-constants.h>
 
 #include "packet-header-definitions.h"
+#include "phy-packet-definitions.h"
 
 static void serialize_async_header_common(u32 header[ASYNC_HEADER_QUADLET_COUNT],
 					  unsigned int dst_id, unsigned int tlabel,
@@ -187,6 +188,66 @@ static void deserialize_isoc_header(u32 header, unsigned int *data_length, unsig
 	*sy = isoc_header_get_sy(header);
 }
 
+static void serialize_phy_packet_self_id_zero(u32 *quadlet, unsigned int packet_identifier,
+					      unsigned int phy_id, bool extended,
+					      bool link_is_active, unsigned int gap_count,
+					      unsigned int scode, bool is_contender,
+					      unsigned int power_class, bool is_initiated_reset,
+					      bool has_more_packets)
+{
+	phy_packet_set_packet_identifier(quadlet, packet_identifier);
+	phy_packet_self_id_set_phy_id(quadlet, phy_id);
+	phy_packet_self_id_set_extended(quadlet, extended);
+	phy_packet_self_id_zero_set_link_active(quadlet, link_is_active);
+	phy_packet_self_id_zero_set_gap_count(quadlet, gap_count);
+	phy_packet_self_id_zero_set_scode(quadlet, scode);
+	phy_packet_self_id_zero_set_contender(quadlet, is_contender);
+	phy_packet_self_id_zero_set_power_class(quadlet, power_class);
+	phy_packet_self_id_zero_set_initiated_reset(quadlet, is_initiated_reset);
+	phy_packet_self_id_set_more_packets(quadlet, has_more_packets);
+}
+
+static void deserialize_phy_packet_self_id_zero(u32 quadlet, unsigned int *packet_identifier,
+						unsigned int *phy_id, bool *extended,
+						bool *link_is_active, unsigned int *gap_count,
+						unsigned int *scode, bool *is_contender,
+						unsigned int *power_class,
+						bool *is_initiated_reset, bool *has_more_packets)
+{
+	*packet_identifier = phy_packet_get_packet_identifier(quadlet);
+	*phy_id = phy_packet_self_id_get_phy_id(quadlet);
+	*extended = phy_packet_self_id_get_extended(quadlet);
+	*link_is_active = phy_packet_self_id_zero_get_link_active(quadlet);
+	*gap_count = phy_packet_self_id_zero_get_gap_count(quadlet);
+	*scode = phy_packet_self_id_zero_get_scode(quadlet);
+	*is_contender = phy_packet_self_id_zero_get_contender(quadlet);
+	*power_class = phy_packet_self_id_zero_get_power_class(quadlet);
+	*is_initiated_reset = phy_packet_self_id_zero_get_initiated_reset(quadlet);
+	*has_more_packets = phy_packet_self_id_get_more_packets(quadlet);
+}
+
+static void serialize_phy_packet_self_id_extended(u32 *quadlet, unsigned int packet_identifier,
+						  unsigned int phy_id, bool extended,
+						  unsigned int sequence, bool has_more_packets)
+{
+	phy_packet_set_packet_identifier(quadlet, packet_identifier);
+	phy_packet_self_id_set_phy_id(quadlet, phy_id);
+	phy_packet_self_id_set_extended(quadlet, extended);
+	phy_packet_self_id_extended_set_sequence(quadlet, sequence);
+	phy_packet_self_id_set_more_packets(quadlet, has_more_packets);
+}
+
+static void deserialize_phy_packet_self_id_extended(u32 quadlet, unsigned int *packet_identifier,
+						    unsigned int *phy_id, bool *extended,
+						    unsigned int *sequence, bool *has_more_packets)
+{
+	*packet_identifier = phy_packet_get_packet_identifier(quadlet);
+	*phy_id = phy_packet_self_id_get_phy_id(quadlet);
+	*extended = phy_packet_self_id_get_extended(quadlet);
+	*sequence = phy_packet_self_id_extended_get_sequence(quadlet);
+	*has_more_packets = phy_packet_self_id_get_more_packets(quadlet);
+}
+
 static void test_async_header_write_quadlet_request(struct kunit *test)
 {
 	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
@@ -559,6 +620,197 @@ static void test_isoc_header(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, header, expected);
 }
 
+static void test_phy_packet_self_id_zero_case0(struct kunit *test)
+{
+	// TSB41AB1/2 with 1 port.
+	const u32 expected[] = {0x80458c80};
+	u32 quadlets[] = {0};
+
+	unsigned int packet_identifier;
+	unsigned int phy_id;
+	bool extended;
+	bool link_is_active;
+	unsigned int gap_count;
+	unsigned int scode;
+	bool is_contender;
+	unsigned int power_class;
+	enum phy_packet_self_id_port_status port_status[3];
+	bool is_initiated_reset;
+	bool has_more_packets;
+	unsigned int port_index;
+
+	deserialize_phy_packet_self_id_zero(expected[0], &packet_identifier, &phy_id, &extended,
+					    &link_is_active, &gap_count, &scode, &is_contender,
+					    &power_class, &is_initiated_reset, &has_more_packets);
+
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_PACKET_IDENTIFIER_SELF_ID, packet_identifier);
+	KUNIT_EXPECT_EQ(test, 0, phy_id);
+	KUNIT_EXPECT_FALSE(test, extended);
+	KUNIT_EXPECT_TRUE(test, link_is_active);
+	KUNIT_EXPECT_EQ(test, 0x05, gap_count);
+	KUNIT_EXPECT_EQ(test, SCODE_400, scode);
+	KUNIT_EXPECT_TRUE(test, is_contender);
+	KUNIT_EXPECT_EQ(test, 0x4, power_class);
+	KUNIT_EXPECT_FALSE(test, is_initiated_reset);
+	KUNIT_EXPECT_FALSE(test, has_more_packets);
+
+	serialize_phy_packet_self_id_zero(quadlets, packet_identifier, phy_id, extended,
+					  link_is_active, gap_count, scode, is_contender,
+					  power_class, is_initiated_reset, has_more_packets);
+
+	for (port_index = 0; port_index < ARRAY_SIZE(port_status); ++port_index) {
+		port_status[port_index] =
+			self_id_sequence_get_port_status(expected, ARRAY_SIZE(expected), port_index);
+	}
+
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[0]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NONE, port_status[1]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NONE, port_status[2]);
+
+	for (port_index = 0; port_index < ARRAY_SIZE(port_status); ++port_index) {
+		self_id_sequence_set_port_status(quadlets, ARRAY_SIZE(quadlets), port_index,
+						 port_status[port_index]);
+	}
+
+	KUNIT_EXPECT_MEMEQ(test, quadlets, expected, sizeof(expected));
+}
+
+static void test_phy_packet_self_id_zero_case1(struct kunit *test)
+{
+	// XIO2213 and TSB81BA3E with 3 ports.
+	const u32 expected[] = {0x817fcc5e};
+	u32 quadlets[] = {0};
+
+	unsigned int packet_identifier;
+	unsigned int phy_id;
+	bool extended;
+	bool link_is_active;
+	unsigned int gap_count;
+	unsigned int scode;
+	bool is_contender;
+	unsigned int power_class;
+	enum phy_packet_self_id_port_status port_status[3];
+	bool is_initiated_reset;
+	bool has_more_packets;
+	unsigned int port_index;
+
+	deserialize_phy_packet_self_id_zero(expected[0], &packet_identifier, &phy_id, &extended,
+					    &link_is_active, &gap_count, &scode, &is_contender,
+					    &power_class, &is_initiated_reset, &has_more_packets);
+
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_PACKET_IDENTIFIER_SELF_ID, packet_identifier);
+	KUNIT_EXPECT_EQ(test, 1, phy_id);
+	KUNIT_EXPECT_FALSE(test, extended);
+	KUNIT_EXPECT_TRUE(test, link_is_active);
+	KUNIT_EXPECT_EQ(test, 0x3f, gap_count);
+	KUNIT_EXPECT_EQ(test, SCODE_800, scode);
+	KUNIT_EXPECT_TRUE(test, is_contender);
+	KUNIT_EXPECT_EQ(test, 0x4, power_class);
+	KUNIT_EXPECT_TRUE(test, is_initiated_reset);
+	KUNIT_EXPECT_FALSE(test, has_more_packets);
+
+	serialize_phy_packet_self_id_zero(quadlets, packet_identifier, phy_id, extended,
+					  link_is_active, gap_count, scode, is_contender,
+					  power_class, is_initiated_reset, has_more_packets);
+
+	for (port_index = 0; port_index < ARRAY_SIZE(port_status); ++port_index) {
+		port_status[port_index] =
+			self_id_sequence_get_port_status(expected, ARRAY_SIZE(expected), port_index);
+	}
+
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[0]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[1]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_CHILD, port_status[2]);
+
+	for (port_index = 0; port_index < ARRAY_SIZE(port_status); ++port_index) {
+		self_id_sequence_set_port_status(quadlets, ARRAY_SIZE(quadlets), port_index,
+						 port_status[port_index]);
+	}
+
+	KUNIT_EXPECT_MEMEQ(test, quadlets, expected, sizeof(expected));
+}
+
+static void test_phy_packet_self_id_zero_and_one(struct kunit *test)
+{
+	// TSB41LV06A with 6 ports.
+	const u32 expected[] = {
+		0x803f8459,
+		0x80815000,
+	};
+	u32 quadlets[] = {0, 0};
+
+	unsigned int packet_identifier;
+	unsigned int phy_id;
+	bool extended;
+	bool link_is_active;
+	unsigned int gap_count;
+	unsigned int scode;
+	bool is_contender;
+	unsigned int power_class;
+	enum phy_packet_self_id_port_status port_status[11];
+	bool is_initiated_reset;
+	bool has_more_packets;
+
+	unsigned int sequence;
+	unsigned int port_index;
+
+	deserialize_phy_packet_self_id_zero(expected[0], &packet_identifier, &phy_id, &extended,
+					    &link_is_active, &gap_count, &scode, &is_contender,
+					    &power_class, &is_initiated_reset, &has_more_packets);
+
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_PACKET_IDENTIFIER_SELF_ID, packet_identifier);
+	KUNIT_EXPECT_EQ(test, 0, phy_id);
+	KUNIT_EXPECT_FALSE(test, extended);
+	KUNIT_EXPECT_FALSE(test, link_is_active);
+	KUNIT_EXPECT_EQ(test, 0x3f, gap_count);
+	KUNIT_EXPECT_EQ(test, SCODE_400, scode);
+	KUNIT_EXPECT_FALSE(test, is_contender);
+	KUNIT_EXPECT_EQ(test, 0x4, power_class);
+	KUNIT_EXPECT_FALSE(test, is_initiated_reset);
+	KUNIT_EXPECT_TRUE(test, has_more_packets);
+
+	serialize_phy_packet_self_id_zero(quadlets, packet_identifier, phy_id, extended,
+					  link_is_active, gap_count, scode, is_contender,
+					  power_class, is_initiated_reset, has_more_packets);
+
+	deserialize_phy_packet_self_id_extended(expected[1], &packet_identifier, &phy_id, &extended,
+						&sequence, &has_more_packets);
+
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_PACKET_IDENTIFIER_SELF_ID, packet_identifier);
+	KUNIT_EXPECT_EQ(test, 0, phy_id);
+	KUNIT_EXPECT_TRUE(test, extended);
+	KUNIT_EXPECT_EQ(test, 0, sequence);
+	KUNIT_EXPECT_FALSE(test, has_more_packets);
+
+	serialize_phy_packet_self_id_extended(&quadlets[1], packet_identifier, phy_id, extended,
+					      sequence, has_more_packets);
+
+
+	for (port_index = 0; port_index < ARRAY_SIZE(port_status); ++port_index) {
+		port_status[port_index] =
+			self_id_sequence_get_port_status(expected, ARRAY_SIZE(expected), port_index);
+	}
+
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[0]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[1]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_PARENT, port_status[2]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[3]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[4]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NCONN, port_status[5]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NONE, port_status[6]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NONE, port_status[7]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NONE, port_status[8]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NONE, port_status[9]);
+	KUNIT_EXPECT_EQ(test, PHY_PACKET_SELF_ID_PORT_STATUS_NONE, port_status[10]);
+
+	for (port_index = 0; port_index < ARRAY_SIZE(port_status); ++port_index) {
+		self_id_sequence_set_port_status(quadlets, ARRAY_SIZE(quadlets), port_index,
+						 port_status[port_index]);
+	}
+
+	KUNIT_EXPECT_MEMEQ(test, quadlets, expected, sizeof(expected));
+}
+
 static struct kunit_case packet_serdes_test_cases[] = {
 	KUNIT_CASE(test_async_header_write_quadlet_request),
 	KUNIT_CASE(test_async_header_write_block_request),
@@ -570,6 +822,9 @@ static struct kunit_case packet_serdes_test_cases[] = {
 	KUNIT_CASE(test_async_header_lock_request),
 	KUNIT_CASE(test_async_header_lock_response),
 	KUNIT_CASE(test_isoc_header),
+	KUNIT_CASE(test_phy_packet_self_id_zero_case0),
+	KUNIT_CASE(test_phy_packet_self_id_zero_case1),
+	KUNIT_CASE(test_phy_packet_self_id_zero_and_one),
 	{}
 };
 
diff --git a/drivers/firewire/phy-packet-definitions.h b/drivers/firewire/phy-packet-definitions.h
index 4ba8b18aa993..8f78494ad371 100644
--- a/drivers/firewire/phy-packet-definitions.h
+++ b/drivers/firewire/phy-packet-definitions.h
@@ -7,11 +7,42 @@
 #ifndef _FIREWIRE_PHY_PACKET_DEFINITIONS_H
 #define _FIREWIRE_PHY_PACKET_DEFINITIONS_H
 
+#define PACKET_IDENTIFIER_MASK				0xc0000000
+#define PACKET_IDENTIFIER_SHIFT				30
+
+static inline unsigned int phy_packet_get_packet_identifier(u32 quadlet)
+{
+	return (quadlet & PACKET_IDENTIFIER_MASK) >> PACKET_IDENTIFIER_SHIFT;
+}
+
+static inline void phy_packet_set_packet_identifier(u32 *quadlet, unsigned int packet_identifier)
+{
+	*quadlet &= ~PACKET_IDENTIFIER_MASK;
+	*quadlet |= (packet_identifier << PACKET_IDENTIFIER_SHIFT) & PACKET_IDENTIFIER_MASK;
+}
+
+#define PHY_PACKET_PACKET_IDENTIFIER_SELF_ID		2
+
+#define SELF_ID_PHY_ID_MASK				0x3f000000
+#define SELF_ID_PHY_ID_SHIFT				24
 #define SELF_ID_EXTENDED_MASK				0x00800000
 #define SELF_ID_EXTENDED_SHIFT				23
 #define SELF_ID_MORE_PACKETS_MASK			0x00000001
 #define SELF_ID_MORE_PACKETS_SHIFT			0
 
+#define SELF_ID_ZERO_LINK_ACTIVE_MASK			0x00400000
+#define SELF_ID_ZERO_LINK_ACTIVE_SHIFT			22
+#define SELF_ID_ZERO_GAP_COUNT_MASK			0x003f0000
+#define SELF_ID_ZERO_GAP_COUNT_SHIFT			16
+#define SELF_ID_ZERO_SCODE_MASK				0x0000c000
+#define SELF_ID_ZERO_SCODE_SHIFT			14
+#define SELF_ID_ZERO_CONTENDER_MASK			0x00000800
+#define SELF_ID_ZERO_CONTENDER_SHIFT			11
+#define SELF_ID_ZERO_POWER_CLASS_MASK			0x00000700
+#define SELF_ID_ZERO_POWER_CLASS_SHIFT			8
+#define SELF_ID_ZERO_INITIATED_RESET_MASK		0x00000002
+#define SELF_ID_ZERO_INITIATED_RESET_SHIFT		1
+
 #define SELF_ID_EXTENDED_SEQUENCE_MASK			0x00700000
 #define SELF_ID_EXTENDED_SEQUENCE_SHIFT			20
 
@@ -19,21 +50,116 @@
 
 #define SELF_ID_SEQUENCE_MAXIMUM_QUADLET_COUNT		4
 
+static inline unsigned int phy_packet_self_id_get_phy_id(u32 quadlet)
+{
+	return (quadlet & SELF_ID_PHY_ID_MASK)  >> SELF_ID_PHY_ID_SHIFT;
+}
+
+static inline void phy_packet_self_id_set_phy_id(u32 *quadlet, unsigned int phy_id)
+{
+	*quadlet &= ~SELF_ID_PHY_ID_MASK;
+	*quadlet |= (phy_id << SELF_ID_PHY_ID_SHIFT) & SELF_ID_PHY_ID_MASK;
+}
+
 static inline bool phy_packet_self_id_get_extended(u32 quadlet)
 {
 	return (quadlet & SELF_ID_EXTENDED_MASK) >> SELF_ID_EXTENDED_SHIFT;
 }
 
+static inline void phy_packet_self_id_set_extended(u32 *quadlet, bool extended)
+{
+	*quadlet &= ~SELF_ID_EXTENDED_MASK;
+	*quadlet |= (extended << SELF_ID_EXTENDED_SHIFT) & SELF_ID_EXTENDED_MASK;
+}
+
+static inline bool phy_packet_self_id_zero_get_link_active(u32 quadlet)
+{
+	return (quadlet & SELF_ID_ZERO_LINK_ACTIVE_MASK) >> SELF_ID_ZERO_LINK_ACTIVE_SHIFT;
+}
+
+static inline void phy_packet_self_id_zero_set_link_active(u32 *quadlet, bool is_active)
+{
+	*quadlet &= ~SELF_ID_ZERO_LINK_ACTIVE_MASK;
+	*quadlet |= (is_active << SELF_ID_ZERO_LINK_ACTIVE_SHIFT) & SELF_ID_ZERO_LINK_ACTIVE_MASK;
+}
+
+static inline unsigned int phy_packet_self_id_zero_get_gap_count(u32 quadlet)
+{
+	return (quadlet & SELF_ID_ZERO_GAP_COUNT_MASK) >> SELF_ID_ZERO_GAP_COUNT_SHIFT;
+}
+
+static inline void phy_packet_self_id_zero_set_gap_count(u32 *quadlet, unsigned int gap_count)
+{
+	*quadlet &= ~SELF_ID_ZERO_GAP_COUNT_MASK;
+	*quadlet |= (gap_count << SELF_ID_ZERO_GAP_COUNT_SHIFT) & SELF_ID_ZERO_GAP_COUNT_MASK;
+}
+
+static inline unsigned int phy_packet_self_id_zero_get_scode(u32 quadlet)
+{
+	return (quadlet & SELF_ID_ZERO_SCODE_MASK) >> SELF_ID_ZERO_SCODE_SHIFT;
+}
+
+static inline void phy_packet_self_id_zero_set_scode(u32 *quadlet, unsigned int speed)
+{
+	*quadlet &= ~SELF_ID_ZERO_SCODE_MASK;
+	*quadlet |= (speed << SELF_ID_ZERO_SCODE_SHIFT) & SELF_ID_ZERO_SCODE_MASK;
+}
+
+static inline bool phy_packet_self_id_zero_get_contender(u32 quadlet)
+{
+	return (quadlet & SELF_ID_ZERO_CONTENDER_MASK) >> SELF_ID_ZERO_CONTENDER_SHIFT;
+}
+
+static inline void phy_packet_self_id_zero_set_contender(u32 *quadlet, bool is_contender)
+{
+	*quadlet &= ~SELF_ID_ZERO_CONTENDER_MASK;
+	*quadlet |= (is_contender << SELF_ID_ZERO_CONTENDER_SHIFT) & SELF_ID_ZERO_CONTENDER_MASK;
+}
+
+static inline unsigned int phy_packet_self_id_zero_get_power_class(u32 quadlet)
+{
+	return (quadlet & SELF_ID_ZERO_POWER_CLASS_MASK) >> SELF_ID_ZERO_POWER_CLASS_SHIFT;
+}
+
+static inline void phy_packet_self_id_zero_set_power_class(u32 *quadlet, unsigned int power_class)
+{
+	*quadlet &= ~SELF_ID_ZERO_POWER_CLASS_MASK;
+	*quadlet |= (power_class << SELF_ID_ZERO_POWER_CLASS_SHIFT) & SELF_ID_ZERO_POWER_CLASS_MASK;
+}
+
+static inline bool phy_packet_self_id_zero_get_initiated_reset(u32 quadlet)
+{
+	return (quadlet & SELF_ID_ZERO_INITIATED_RESET_MASK) >> SELF_ID_ZERO_INITIATED_RESET_SHIFT;
+}
+
+static inline void phy_packet_self_id_zero_set_initiated_reset(u32 *quadlet, bool is_initiated_reset)
+{
+	*quadlet &= ~SELF_ID_ZERO_INITIATED_RESET_MASK;
+	*quadlet |= (is_initiated_reset << SELF_ID_ZERO_INITIATED_RESET_SHIFT) & SELF_ID_ZERO_INITIATED_RESET_MASK;
+}
+
 static inline bool phy_packet_self_id_get_more_packets(u32 quadlet)
 {
 	return (quadlet & SELF_ID_MORE_PACKETS_MASK) >> SELF_ID_MORE_PACKETS_SHIFT;
 }
 
+static inline void phy_packet_self_id_set_more_packets(u32 *quadlet, bool is_more_packets)
+{
+	*quadlet &= ~SELF_ID_MORE_PACKETS_MASK;
+	*quadlet |= (is_more_packets << SELF_ID_MORE_PACKETS_SHIFT) & SELF_ID_MORE_PACKETS_MASK;
+}
+
 static inline unsigned int phy_packet_self_id_extended_get_sequence(u32 quadlet)
 {
 	return (quadlet & SELF_ID_EXTENDED_SEQUENCE_MASK) >> SELF_ID_EXTENDED_SEQUENCE_SHIFT;
 }
 
+static inline void phy_packet_self_id_extended_set_sequence(u32 *quadlet, unsigned int sequence)
+{
+	*quadlet &= ~SELF_ID_EXTENDED_SEQUENCE_MASK;
+	*quadlet |= (sequence << SELF_ID_EXTENDED_SHIFT) & SELF_ID_EXTENDED_SEQUENCE_MASK;
+}
+
 struct self_id_sequence_enumerator {
 	const u32 *cursor;
 	unsigned int quadlet_count;
-- 
2.43.0


