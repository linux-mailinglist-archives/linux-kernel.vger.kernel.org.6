Return-Path: <linux-kernel+bounces-238523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C03E924B85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BD1291FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2FF17DA05;
	Tue,  2 Jul 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jAa5HVXD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pzyee007"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1EE17A580
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958846; cv=none; b=ZXDLnMa53n1Lmlfp89DinkTMPa4XYm8cJ3gPrY+FkEOd+JPHN1b6NL2Q+jWH4vtQcuRB6nhncZJ0KC6HT/dmjD6+dz80wiPxC7ZiOiiLKbBh5QZaif996qCd5Dn2DxPdwp4qfT2ayMhFbiuVkT68p3VIpVo4w2BSdwxs1iorDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958846; c=relaxed/simple;
	bh=cW1PaWPoUro0FwYsinK+HNJjsOZpL+zet4AFH0rZ11s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioLyPK3tmS2N1J6ImxfjnYOcFSELcAHhwiEox75qUA6ihzhwvSM2c1lSoQtoHCEcNtjClCEqNGtf47PP6q2N7UCNwmk4Z1Gg5eNDftc4I++OTx7mtf9zuu3/hFcnHxMk4atHpIrrNeCA1Q7v8szF+7voJDdL/KrZ7k8I/ivOSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=jAa5HVXD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pzyee007; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7EF221380297;
	Tue,  2 Jul 2024 18:20:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 Jul 2024 18:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719958843; x=
	1720045243; bh=NtOsPI/vL3wkycVVvPccbjCj69PvW3xTQTZrO5lK/Gg=; b=j
	Aa5HVXDC1BrRBAqox3y0ZJ2XsqGqXFPVVZ66cuHpQXFRjVJffTpaOfcZ5Get8xJ8
	VP3upThf+DFciHW409tuOU1toSaLbBFon8/DVpbX55erGnToYcNyHgXLv7N9CF9R
	zfR/HT3pV3fqbO6I7598S0NdHOvviWmXysiblWyJAERkvXRwiu/9dITVhU0LgjYw
	SC/kZSi/ZqNNyt40xS0HZ/QeCQY/2duGVX0rm1xYP88fPDSDVkwG+yGvZDrPlpV1
	E03ALQcIjhyhRDwh9wzimVauMWtQwDWE3nsK4GGHRNrkuqgYsg0pj1mmhvhOtDWr
	Ml8M+fTCayJqYtesNseRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719958843; x=
	1720045243; bh=NtOsPI/vL3wkycVVvPccbjCj69PvW3xTQTZrO5lK/Gg=; b=P
	zyee007aju4PWEd3f6jXMz2jWty6G2u/MWM6b8EEI+XuWTHKF4J3zLVhVXkCJxCg
	R65D5leqasqyV59xt0WiwEaJnTcRA0RMJ1wy12zeXpFD0vvEHHo0x2g+b2Tpzu1O
	C38RHo55L7zkEsSJE9sOp8a96SktWDKq9NnY8j7C8nr6ML4iSBt5GIeA+4UhMnuO
	Z63wLcWNm2YsELwp7rxvTXiUmjs956nZlcmVpDqM9pSd+QXBrpuZ3gtDLln4s9FD
	7mwF3sYTndc19LBhzLbMyyusBvx5SQ2qfzwSzoa/UgLLY9W0djVkcmamh95oytBP
	fQJMBzGYPZbsiEO6wAYGw==
X-ME-Sender: <xms:O32EZitr-cOgzvbUL6MC2kw0Kukh6o5QS45QRXZndLtyWMTDqCYrfQ>
    <xme:O32EZndfFeXz32hOZsvMdk6MZNOGH9qMuOC_hlmO9mmVL6jOBqAGvR-duSaLCGC2p
    CkX4RYW2O0JjvctnB8>
X-ME-Received: <xmr:O32EZtzn8ujU4e18OIc35YTEhVLTs0rBd2JgNNyHir95jLZXS1LSqx_D05ey7XEWs2nyl1JAhC4ynwOO6bjjYXk4FiS5WGIyofzej0fd8mqnUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepuefgvedtfe
    fhfeefueduudfhkefhgfevjeefieeiffdttefhudduveejkeevffelnecuffhomhgrihhn
    pehtvghsthgrnhihthhhihhnghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdr
    jhhp
X-ME-Proxy: <xmx:O32EZtPMbzc66mbDDzyNMvjLkKydjuYCGEPkKzcRHoG9nrwQJXxylg>
    <xmx:O32EZi-MZxWA-0Krt9j8pEaOndRVXe_vpNcdLKor0vTCZDthNFRkoA>
    <xmx:O32EZlWGQ6O7x7K5XCnXpiR9FeQls2XL8qQUisc1B1bGtVua-ABbyw>
    <xmx:O32EZrchai1fDUXubNL8t1t2ZMCSALOOOASuJYC8EfbpAfW-9iEenw>
    <xmx:O32EZkJQAENm1n9hNgD2WIAYCicG90Lwm0927mpheh3E3t5nOOk0Zv85>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 18:20:42 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] firewire: ohci: add static inline functions to deserialize for Self-ID DMA operation
Date: Wed,  3 Jul 2024 07:20:32 +0900
Message-ID: <20240702222034.1378764-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
References: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SelfI-ID is one type of DMAs defined in 1394 OHCI specification. It is
operated by two registers, one interrupt, and has one format of buffer.

This commit adds some static inline functions to deserialize the data in
the buffer and registers. Some KUnit tests are also added to check their
reliability.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/.kunitconfig       |  1 +
 drivers/firewire/Kconfig            | 16 +++++++++
 drivers/firewire/Makefile           |  1 +
 drivers/firewire/ohci-serdes-test.c | 56 +++++++++++++++++++++++++++++
 drivers/firewire/ohci.h             | 42 ++++++++++++++++++++++
 5 files changed, 116 insertions(+)
 create mode 100644 drivers/firewire/ohci-serdes-test.c

diff --git a/drivers/firewire/.kunitconfig b/drivers/firewire/.kunitconfig
index 74259204fcdd..21b7e9eef63d 100644
--- a/drivers/firewire/.kunitconfig
+++ b/drivers/firewire/.kunitconfig
@@ -5,3 +5,4 @@ CONFIG_FIREWIRE_KUNIT_UAPI_TEST=y
 CONFIG_FIREWIRE_KUNIT_DEVICE_ATTRIBUTE_TEST=y
 CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST=y
 CONFIG_FIREWIRE_KUNIT_SELF_ID_SEQUENCE_HELPER_TEST=y
+CONFIG_FIREWIRE_KUNIT_OHCI_SERDES_TEST=y
diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
index 95e72e0b592b..905c82e26ce7 100644
--- a/drivers/firewire/Kconfig
+++ b/drivers/firewire/Kconfig
@@ -92,6 +92,22 @@ config FIREWIRE_OHCI
 	  To compile this driver as a module, say M here:  The module will be
 	  called firewire-ohci.
 
+config FIREWIRE_KUNIT_OHCI_SERDES_TEST
+	tristate "KUnit tests for serialization/deserialization of data in buffers/registers" if !KUNIT_ALL_TESTS
+	depends on FIREWIRE && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit tests to check serialization and deserialization
+	  of data in buffers and registers defined in 1394 OHCI specification.
+
+	  KUnit tests run during boot and output the results to the debug
+	  log in TAP format (https://testanything.org/). Only useful for
+	  kernel devs running KUnit test harness and are not for inclusion
+	  into a production build.
+
+	  For more information on KUnit and unit tests in general, refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
 config FIREWIRE_SBP2
 	tristate "Storage devices (SBP-2 protocol)"
 	depends on FIREWIRE && SCSI
diff --git a/drivers/firewire/Makefile b/drivers/firewire/Makefile
index 21b975e0a387..1ff550e93a8c 100644
--- a/drivers/firewire/Makefile
+++ b/drivers/firewire/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_PROVIDE_OHCI1394_DMA_INIT) += init_ohci1394_dma.o
 obj-$(CONFIG_FIREWIRE_KUNIT_UAPI_TEST) += uapi-test.o
 obj-$(CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST) += packet-serdes-test.o
 obj-$(CONFIG_FIREWIRE_KUNIT_SELF_ID_SEQUENCE_HELPER_TEST) += self-id-sequence-helper-test.o
+obj-$(CONFIG_FIREWIRE_KUNIT_OHCI_SERDES_TEST) += ohci-serdes-test.o
diff --git a/drivers/firewire/ohci-serdes-test.c b/drivers/firewire/ohci-serdes-test.c
new file mode 100644
index 000000000000..304a09ff528e
--- /dev/null
+++ b/drivers/firewire/ohci-serdes-test.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// ohci-serdes-test.c - An application of Kunit to check serialization/deserialization of data in
+//			buffers and registers defined in 1394 OHCI specification.
+//
+// Copyright (c) 2024 Takashi Sakamoto
+
+#include <kunit/test.h>
+
+#include "ohci.h"
+
+
+static void test_self_id_count_register_deserialization(struct kunit *test)
+{
+	const u32 expected = 0x803d0594;
+
+	bool is_error = ohci1394_self_id_count_is_error(expected);
+	u8 generation = ohci1394_self_id_count_get_generation(expected);
+	u32 size = ohci1394_self_id_count_get_size(expected);
+
+	KUNIT_EXPECT_TRUE(test, is_error);
+	KUNIT_EXPECT_EQ(test, 0x3d, generation);
+	KUNIT_EXPECT_EQ(test, 0x165, size);
+}
+
+static void test_self_id_receive_buffer_deserialization(struct kunit *test)
+{
+	const u32 buffer[] = {
+		0x0006f38b,
+		0x807fcc56,
+		0x7f8033a9,
+		0x8145cc5e,
+		0x7eba33a1,
+	};
+
+	u8 generation = ohci1394_self_id_receive_q0_get_generation(buffer[0]);
+	u16 timestamp = ohci1394_self_id_receive_q0_get_timestamp(buffer[0]);
+
+	KUNIT_EXPECT_EQ(test, 0x6, generation);
+	KUNIT_EXPECT_EQ(test, 0xf38b, timestamp);
+}
+
+static struct kunit_case ohci_serdes_test_cases[] = {
+	KUNIT_CASE(test_self_id_count_register_deserialization),
+	KUNIT_CASE(test_self_id_receive_buffer_deserialization),
+	{}
+};
+
+static struct kunit_suite ohci_serdes_test_suite = {
+	.name = "firewire-ohci-serdes",
+	.test_cases = ohci_serdes_test_cases,
+};
+kunit_test_suite(ohci_serdes_test_suite);
+
+MODULE_DESCRIPTION("FireWire buffers and registers serialization/deserialization unit test suite");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firewire/ohci.h b/drivers/firewire/ohci.h
index c4d005a9901a..d83fd4731d56 100644
--- a/drivers/firewire/ohci.h
+++ b/drivers/firewire/ohci.h
@@ -156,4 +156,46 @@
 
 #define OHCI1394_phy_tcode		0xe
 
+// Self-ID DMA.
+
+#define OHCI1394_SelfIDCount_selfIDError_MASK		0x80000000
+#define OHCI1394_SelfIDCount_selfIDError_SHIFT		31
+#define OHCI1394_SelfIDCount_selfIDGeneration_MASK	0x00ff0000
+#define OHCI1394_SelfIDCount_selfIDGeneration_SHIFT	16
+#define OHCI1394_SelfIDCount_selfIDSize_MASK		0x000007fc
+#define OHCI1394_SelfIDCount_selfIDSize_SHIFT		2
+
+static inline bool ohci1394_self_id_count_is_error(u32 value)
+{
+	return !!((value & OHCI1394_SelfIDCount_selfIDError_MASK) >> OHCI1394_SelfIDCount_selfIDError_SHIFT);
+}
+
+static inline u8 ohci1394_self_id_count_get_generation(u32 value)
+{
+	return (value & OHCI1394_SelfIDCount_selfIDGeneration_MASK) >> OHCI1394_SelfIDCount_selfIDGeneration_SHIFT;
+}
+
+// In 1394 OHCI specification, the maximum size of self ID stream is 504 quadlets
+// (= 63 devices * 4 self ID packets * 2 quadlets). The selfIDSize field accommodates it and its
+// additional first quadlet, since the field is 9 bits (0x1ff = 511).
+static inline u32 ohci1394_self_id_count_get_size(u32 value)
+{
+	return (value & OHCI1394_SelfIDCount_selfIDSize_MASK) >> OHCI1394_SelfIDCount_selfIDSize_SHIFT;
+}
+
+#define OHCI1394_SELF_ID_RECEIVE_Q0_GENERATION_MASK	0x00ff0000
+#define OHCI1394_SELF_ID_RECEIVE_Q0_GENERATION_SHIFT	16
+#define OHCI1394_SELF_ID_RECEIVE_Q0_TIMESTAMP_MASK	0x0000ffff
+#define OHCI1394_SELF_ID_RECEIVE_Q0_TIMESTAMP_SHIFT	0
+
+static inline u8 ohci1394_self_id_receive_q0_get_generation(u32 quadlet0)
+{
+	return (quadlet0 & OHCI1394_SELF_ID_RECEIVE_Q0_GENERATION_MASK) >> OHCI1394_SELF_ID_RECEIVE_Q0_GENERATION_SHIFT;
+}
+
+static inline u16 ohci1394_self_id_receive_q0_get_timestamp(u32 quadlet0)
+{
+	return (quadlet0 & OHCI1394_SELF_ID_RECEIVE_Q0_TIMESTAMP_MASK) >> OHCI1394_SELF_ID_RECEIVE_Q0_TIMESTAMP_SHIFT;
+}
+
 #endif /* _FIREWIRE_OHCI_H */
-- 
2.43.0


