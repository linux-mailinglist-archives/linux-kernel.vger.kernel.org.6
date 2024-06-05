Return-Path: <linux-kernel+bounces-203422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6048B8FDADF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D04284007
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E988169AE9;
	Wed,  5 Jun 2024 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="IbaCDoD/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N8LOSN+f"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FFB1607B9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631525; cv=none; b=iSOxgHD6GhBBzl4M7pyLXE1rvaAyumt5otbwVA9l6VKSGkXNZ2u/w6T+TNntDgK2pwUQJDgoxlnaFIH7DBupuMwSlXgwBQcEEcXhcg7goIaCZnYxm3hOMfwPF8mKAlzeV05sv6KN1MpQ27e2fYcnaBRRBLPRkTlNOgxJXqht9Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631525; c=relaxed/simple;
	bh=j+hFn2QjRtNbQi2JXNDC2xNSexaHta7Qh5NFU0AsFDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvmDn0UwurClvysttSdCR9Vycs1xpU61xIdjKOMbbAhoisv48hblIuYEUvTiarumgbyJrIy9uo9JG5P/i+5I6mJ9GaolYn1pYkSQ1Hdw9WMk6pSx2WwlMrQDw+/LMuHuiUKYie/sLsCHozwUpterEvnAiyuY8BWeTVZZt5oCNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=IbaCDoD/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N8LOSN+f; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id D2EE11800113;
	Wed,  5 Jun 2024 19:52:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 05 Jun 2024 19:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631522; x=
	1717717922; bh=RyBiXfJ2B/10rFRCmtbmj2xM5yya0ZOnplKlH9vtagY=; b=I
	baCDoD/Tob1RlvGLAY4nbRB4goGZSe9pGPX4FIUH+bAbbHGf0B77XUZ/T1tsUvSP
	fsnLWwsXz0dAutl3oP71JU4sbjf7mPRnvMMwg8RffR6483aL1kXJ3FgNsFDu3LQl
	MiDnbvW2MErfUhqXXqTmPyH/iEPQWgCxdfx0nuXgNAKFMk0hyAmT8qMKYLoyPo8P
	pNDBhK9/Of4GWRPPv0c62+oR5MRoaeQCyqHOgDJ4O3gtuxD6+hE5iXkTZqOecrdE
	hUnqYFxvcmTy39DH1b7weGakUNwZsq7Y4A4qG4QsDtbf5x0WAQSugUm9QTH6el/7
	afGERkWPcfMmhET6hfJCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631522; x=
	1717717922; bh=RyBiXfJ2B/10rFRCmtbmj2xM5yya0ZOnplKlH9vtagY=; b=N
	8LOSN+fV8lFXRvLfvp9P12GkZx/s3Km7TOR4S6CRHFR+Uq4XBGwUesZMv3vg4hav
	Z7+RakzPbPL3glV7BBJGua6aJe//mV6OFktKLNNKNsuAAVeDUBBWD6bc80joZ6g/
	oVGd6rpBz4U6ylvIvcjJaKrciLIGBsDes8dRK7mEEJdFdDS2FfBMLrj4UX/F88KR
	Y2/KMq2fzvfYr9bn7vS1tF7R7KKoym7tb/fFFmlK0O36WHTc3uU+mv0406CfwRTr
	j+AWNYlNi8JBVu8CGO79OAX56op3wy/OjH/rP4feJZ0xdgZX+okKz4Fk/t3QNOvi
	YRYgnATeUGWuIwguU13UQ==
X-ME-Sender: <xms:IvpgZn6FVDb948TvR1CRXpFQB_eA--wwrVLpnu16By8RyaPyQelfrg>
    <xme:IvpgZs4mCq5A6-usZNRDEU7pbYd1FyqtgMBhlTrwwbXiUd7VL_kEmY85MfKaYAivt
    5htwtSDNgUVwfsZX4g>
X-ME-Received: <xmr:IvpgZufxd5pqdLVr_XTiiE980lb4ztMRZfzPzFFIrlrym5xucII4gNxS-LYO7Pfse94M8WcuNjlOrVvYzSDreDEVXQMVaHFKjW0J9YVTiPay6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeugfevtd
    efhfeffeeuudduhfekhffgveejfeeiiefftdethfduudevjeekveffleenucffohhmrghi
    nhepthgvshhtrghnhihthhhinhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
    rdhjph
X-ME-Proxy: <xmx:IvpgZoL1PiDEZ80W1um0FbXuP8RAlZYFpBAKt3XscX-71RJkyr8zPQ>
    <xmx:IvpgZrIYfZfTLZH7uPdqPyehbKDZLFm0NkU1YcfOOnPWwamUsY7qfA>
    <xmx:IvpgZhwMcoWp3kUuS4qzg0qZEaKhaODQYsClRgiFavfEAaWkU7IPkQ>
    <xmx:IvpgZnLh3SyCMZbr0KGfR9QgNjSNSKprp7rfrSHUvml6JmyKLLKDXg>
    <xmx:IvpgZiXK-xVWpfpYYL9S48Dc4XC_9CuiIgLYDRYD-1Z8_75SnHW-8MR5>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:01 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] firewire: core: add enumerator of self ID sequences and its KUnit test
Date: Thu,  6 Jun 2024 08:51:45 +0900
Message-ID: <20240605235155.116468-2-o-takashi@sakamocchi.jp>
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

When the state of bus reset finishes, 1394 OHCI driver constructs self ID
sequences, then it calls fw_core_handle_bus_reset() in core function. The
core function enumerates the self ID sequences to build bus topology.

This commit adds a structure and some helper functions for the enumeration,
and adds a KUnit test suite to ensure its expected behaviour.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/.kunitconfig                 |  1 +
 drivers/firewire/Kconfig                      | 15 ++++
 drivers/firewire/Makefile                     |  1 +
 drivers/firewire/phy-packet-definitions.h     | 78 ++++++++++++++++++
 .../firewire/self-id-sequence-helper-test.c   | 79 +++++++++++++++++++
 5 files changed, 174 insertions(+)
 create mode 100644 drivers/firewire/phy-packet-definitions.h
 create mode 100644 drivers/firewire/self-id-sequence-helper-test.c

diff --git a/drivers/firewire/.kunitconfig b/drivers/firewire/.kunitconfig
index 60d9e7c35417..74259204fcdd 100644
--- a/drivers/firewire/.kunitconfig
+++ b/drivers/firewire/.kunitconfig
@@ -4,3 +4,4 @@ CONFIG_FIREWIRE=y
 CONFIG_FIREWIRE_KUNIT_UAPI_TEST=y
 CONFIG_FIREWIRE_KUNIT_DEVICE_ATTRIBUTE_TEST=y
 CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST=y
+CONFIG_FIREWIRE_KUNIT_SELF_ID_SEQUENCE_HELPER_TEST=y
diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
index 869598b20e3a..49ba692d17d8 100644
--- a/drivers/firewire/Kconfig
+++ b/drivers/firewire/Kconfig
@@ -66,6 +66,21 @@ config FIREWIRE_KUNIT_PACKET_SERDES_TEST
 	  For more information on KUnit and unit tests in general, refer
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
+config FIREWIRE_KUNIT_SELF_ID_SEQUENCE_HELPER_TEST
+	tristate "KUnit tests for helpers of self ID sequence" if !KUNIT_ALL_TESTS
+	depends on FIREWIRE && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit tests for helpers of self ID sequence.
+
+	  KUnit tests run during boot and output the results to the debug
+	  log in TAP format (https://testanything.org/). Only useful for
+	  kernel devs running KUnit test harness and are not for inclusion
+	  into a production build.
+
+	  For more information on KUnit and unit tests in general, refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
 config FIREWIRE_OHCI
 	tristate "OHCI-1394 controllers"
 	depends on PCI && FIREWIRE && MMU
diff --git a/drivers/firewire/Makefile b/drivers/firewire/Makefile
index 75c47d046925..21b975e0a387 100644
--- a/drivers/firewire/Makefile
+++ b/drivers/firewire/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_PROVIDE_OHCI1394_DMA_INIT) += init_ohci1394_dma.o
 
 obj-$(CONFIG_FIREWIRE_KUNIT_UAPI_TEST) += uapi-test.o
 obj-$(CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST) += packet-serdes-test.o
+obj-$(CONFIG_FIREWIRE_KUNIT_SELF_ID_SEQUENCE_HELPER_TEST) += self-id-sequence-helper-test.o
diff --git a/drivers/firewire/phy-packet-definitions.h b/drivers/firewire/phy-packet-definitions.h
new file mode 100644
index 000000000000..479bb3431afb
--- /dev/null
+++ b/drivers/firewire/phy-packet-definitions.h
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// phy-packet-definitions.h - The definitions of phy packet for IEEE 1394.
+//
+// Copyright (c) 2024 Takashi Sakamoto
+
+#ifndef _FIREWIRE_PHY_PACKET_DEFINITIONS_H
+#define _FIREWIRE_PHY_PACKET_DEFINITIONS_H
+
+#define SELF_ID_EXTENDED_MASK				0x00800000
+#define SELF_ID_EXTENDED_SHIFT				23
+#define SELF_ID_MORE_PACKETS_MASK			0x00000001
+#define SELF_ID_MORE_PACKETS_SHIFT			0
+
+#define SELF_ID_EXTENDED_SEQUENCE_MASK			0x00700000
+#define SELF_ID_EXTENDED_SEQUENCE_SHIFT			20
+
+#define SELF_ID_SEQUENCE_MAXIMUM_QUADLET_COUNT		4
+
+static inline bool phy_packet_self_id_get_extended(u32 quadlet)
+{
+	return (quadlet & SELF_ID_EXTENDED_MASK) >> SELF_ID_EXTENDED_SHIFT;
+}
+
+static inline bool phy_packet_self_id_get_more_packets(u32 quadlet)
+{
+	return (quadlet & SELF_ID_MORE_PACKETS_MASK) >> SELF_ID_MORE_PACKETS_SHIFT;
+}
+
+static inline unsigned int phy_packet_self_id_extended_get_sequence(u32 quadlet)
+{
+	return (quadlet & SELF_ID_EXTENDED_SEQUENCE_MASK) >> SELF_ID_EXTENDED_SEQUENCE_SHIFT;
+}
+
+struct self_id_sequence_enumerator {
+	const u32 *cursor;
+	unsigned int quadlet_count;
+};
+
+static inline const u32 *self_id_sequence_enumerator_next(
+		struct self_id_sequence_enumerator *enumerator, unsigned int *quadlet_count)
+{
+	const u32 *self_id_sequence, *cursor;
+	u32 quadlet;
+	unsigned int count;
+	unsigned int sequence;
+
+	if (enumerator->cursor == NULL || enumerator->quadlet_count == 0)
+		return ERR_PTR(-ENODATA);
+	cursor = enumerator->cursor;
+	count = 1;
+
+	quadlet = *cursor;
+	sequence = 0;
+	while (phy_packet_self_id_get_more_packets(quadlet)) {
+		if (count >= enumerator->quadlet_count ||
+		    count >= SELF_ID_SEQUENCE_MAXIMUM_QUADLET_COUNT)
+			return ERR_PTR(-EPROTO);
+		++cursor;
+		++count;
+		quadlet = *cursor;
+
+		if (!phy_packet_self_id_get_extended(quadlet) ||
+		    sequence != phy_packet_self_id_extended_get_sequence(quadlet))
+			return ERR_PTR(-EPROTO);
+		++sequence;
+	}
+
+	*quadlet_count = count;
+	self_id_sequence = enumerator->cursor;
+
+	enumerator->cursor += count;
+	enumerator->quadlet_count -= count;
+
+	return self_id_sequence;
+}
+
+#endif // _FIREWIRE_PHY_PACKET_DEFINITIONS_H
diff --git a/drivers/firewire/self-id-sequence-helper-test.c b/drivers/firewire/self-id-sequence-helper-test.c
new file mode 100644
index 000000000000..e8a435e20241
--- /dev/null
+++ b/drivers/firewire/self-id-sequence-helper-test.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// self-id-sequence-helper-test.c - An application of Kunit to test helpers of self ID sequence.
+//
+// Copyright (c) 2024 Takashi Sakamoto
+
+#include <kunit/test.h>
+
+#include "phy-packet-definitions.h"
+
+static void test_self_id_sequence_enumerator_valid(struct kunit *test)
+{
+	static const u32 valid_sequences[] = {
+		0x00000000,
+		0x00000001, 0x00800000,
+		0x00000001, 0x00800001, 0x00900000,
+		0x00000000,
+	};
+	struct self_id_sequence_enumerator enumerator;
+	const u32 *entry;
+	unsigned int quadlet_count;
+
+	enumerator.cursor = valid_sequences;
+	enumerator.quadlet_count = ARRAY_SIZE(valid_sequences);
+
+	entry = self_id_sequence_enumerator_next(&enumerator, &quadlet_count);
+	KUNIT_EXPECT_PTR_EQ(test, entry, &valid_sequences[0]);
+	KUNIT_EXPECT_EQ(test, quadlet_count, 1);
+	KUNIT_EXPECT_EQ(test, enumerator.quadlet_count, 6);
+
+	entry = self_id_sequence_enumerator_next(&enumerator, &quadlet_count);
+	KUNIT_EXPECT_PTR_EQ(test, entry, &valid_sequences[1]);
+	KUNIT_EXPECT_EQ(test, quadlet_count, 2);
+	KUNIT_EXPECT_EQ(test, enumerator.quadlet_count, 4);
+
+	entry = self_id_sequence_enumerator_next(&enumerator, &quadlet_count);
+	KUNIT_EXPECT_PTR_EQ(test, entry, &valid_sequences[3]);
+	KUNIT_EXPECT_EQ(test, quadlet_count, 3);
+	KUNIT_EXPECT_EQ(test, enumerator.quadlet_count, 1);
+
+	entry = self_id_sequence_enumerator_next(&enumerator, &quadlet_count);
+	KUNIT_EXPECT_PTR_EQ(test, entry, &valid_sequences[6]);
+	KUNIT_EXPECT_EQ(test, quadlet_count, 1);
+	KUNIT_EXPECT_EQ(test, enumerator.quadlet_count, 0);
+
+	entry = self_id_sequence_enumerator_next(&enumerator, &quadlet_count);
+	KUNIT_EXPECT_EQ(test, PTR_ERR(entry), -ENODATA);
+}
+
+static void test_self_id_sequence_enumerator_invalid(struct kunit *test)
+{
+	static const u32 invalid_sequences[] = {
+		0x00000001,
+	};
+	struct self_id_sequence_enumerator enumerator;
+	const u32 *entry;
+	unsigned int count;
+
+	enumerator.cursor = invalid_sequences;
+	enumerator.quadlet_count = ARRAY_SIZE(invalid_sequences);
+
+	entry = self_id_sequence_enumerator_next(&enumerator, &count);
+	KUNIT_EXPECT_EQ(test, PTR_ERR(entry), -EPROTO);
+}
+
+static struct kunit_case self_id_sequence_helper_test_cases[] = {
+	KUNIT_CASE(test_self_id_sequence_enumerator_valid),
+	KUNIT_CASE(test_self_id_sequence_enumerator_invalid),
+	{}
+};
+
+static struct kunit_suite self_id_sequence_helper_test_suite = {
+	.name = "self-id-sequence-helper",
+	.test_cases = self_id_sequence_helper_test_cases,
+};
+kunit_test_suite(self_id_sequence_helper_test_suite);
+
+MODULE_DESCRIPTION("Unit test suite for helpers of self ID sequence");
+MODULE_LICENSE("GPL");
-- 
2.43.0


