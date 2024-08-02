Return-Path: <linux-kernel+bounces-271973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0943F94558A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833EF1F231CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E30381C7;
	Fri,  2 Aug 2024 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="RfIupct2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VShKTIX8"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACF21C687
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558977; cv=none; b=W2xOBeouIOFbn4ihTCoLJ3y/e20YA76TkwZJ+4qnC+TZY0EC+0qfx2FullpmFg8v0K8vwI5gS+fUpzGQ+R//+0IMe+zjJFtqlJg3WBArRWzG9Q2NdTeR1vsoadqGoSKXigCvxl3uLGnkNC0pWGWoQWmPwWtLKcIS0+aWdcwurjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558977; c=relaxed/simple;
	bh=Ws0jqyGuxNdGowY7r95dbj9LEJAccp/E1kA/TtLOx8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ot6FsMi+ExnBDBqamMgBDQ553DwEVuUtYIOftSD3QOgUInEFyUKFhNDUbFuW6bNR/Gw2vzSC7eaIz3j7zpqRBG+Ig0ILbLogP5qTwtEm5lbamT18OXinQPBNsLbxwkSfpfTqnlPsJTXYo+r3mMMnW2N5ndZEOOlGocR4vVyjD7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=RfIupct2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VShKTIX8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6FFBD138FC7A;
	Thu,  1 Aug 2024 20:36:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 20:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722558974; x=
	1722645374; bh=hld0IfkYJX3gAwEL6QqzZl+AfhUDccknia9yFzpMOfQ=; b=R
	fIupct2UTNS2EQJMKmkJAUgeVl1z9WBA/qIE7dJ5pQ3Ge/n2MCA8bxeIQGRGbIRS
	ybvF4qn5AEBpyIDnne8yblxxBmooV8IbjChZA8x7fCZGf9RjmppVY7elgn586BVL
	tSS5DgASzcgpfgN6Afmdjg5u4gUZZpqxh8MYvW/UtdtETjmdLHHbo6jLcJXbtZPF
	Ce8wTPdCdD5uwtcUvkrg6xbS23nUg83WZuhMsuUkVh+4fHhhpjIryc6QhIuhhg8F
	l0Jlm3zzscoQYtmwlNZk0FD4rX7bb0wtHt09almVmcyflQTbYPIlI+gw8wAH6dSR
	vFAF6jMLDgeIZiOACVMcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722558974; x=
	1722645374; bh=hld0IfkYJX3gAwEL6QqzZl+AfhUDccknia9yFzpMOfQ=; b=V
	ShKTIX8TfqHWoH2DJu1iQC8nzjBS4a5GVZDNCgIGfxjrLXTiudpWc1rz1HtEdurz
	1IkPHuSsC1rO1HkVdStzmEpYkNVPa7p3SbC1aA/d+pvcIre8ZOKDnzedUZ8DghIP
	KejW3o3wwyRh6v0ss/Svk9CgoewFXFvDihhj0IPv7YbNIVkzLHRh+BBjvuJ/Gwkd
	aUjne3RQdrS924aattGuRYQAsAfVDiGaAXor9spFLKtZsaxxWVi37/B/+08gnROX
	wZSQIL4cfJK94gNyzcIhlqGjraxJZID52+dSRguwdoQv+1TpdTN6pVLOoy+GgOQD
	2AOg/WZ68j2dnM+2jAaRg==
X-ME-Sender: <xms:_imsZrgT3tR77yOn2Pe9AqmRh5uD8noQXtVsztzyv74fXSTCEeqcaQ>
    <xme:_imsZoDR2y3hmBccZj6mY0MQsSlaGa2QGKlGvvqiCI6g3vzThPIbjPIDambnU8gWs
    P1Qk91MTE_5yXTBPa4>
X-ME-Received: <xmr:_imsZrGLMR7lDbwp7tkd2-5xtKJOO2G_XaLnU2ARAEhY-T8O4Lt592e0c9tQ9c2c7joi7UzC6RVCUwR3G-tThbEUNu7kq-pESaWrg8TXTqLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeelgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:_imsZoTsqOg4V6dZnBOXDdfFKyjUl2Rh0LWFt7-46e9pZI1NSpitfw>
    <xmx:_imsZowQX5L3sBfXI4rDXHOKZg3MkjrVaL5NMdN84VJxWzmQlrg8Cw>
    <xmx:_imsZu5vTuVGrRg197pBrhbPuj7gHPhxLZqc8F-pqfiFIngPpx1yLw>
    <xmx:_imsZtwN-yBXbI1E6NRx4QCkgnhNFa6xUO6yDl-n-8ifD5t5e67Vbg>
    <xmx:_imsZj8jj_635hqTh2-ElKAyxMiPpfV-Xrez9fOj2Os4FQ7X7j5q_UIp>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 20:36:13 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] firewire: ohci: add static inline functions to serialize/deserialize data of IT DMA
Date: Fri,  2 Aug 2024 09:36:05 +0900
Message-ID: <20240802003606.109402-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802003606.109402-1-o-takashi@sakamocchi.jp>
References: <20240802003606.109402-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 1394 OHCI specification, the format of data for IT DMA is different from
the format of isochronous packet in IEEE 1394 specification, in its spd and
srcBusID fields.

This commit adds some static inline functions to serialize/deserialize the
data of IT DMA.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci-serdes-test.c | 32 +++++++++++
 drivers/firewire/ohci.h             | 84 +++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/firewire/ohci-serdes-test.c b/drivers/firewire/ohci-serdes-test.c
index c6820f4f7ec1..ab25ec28aeb5 100644
--- a/drivers/firewire/ohci-serdes-test.c
+++ b/drivers/firewire/ohci-serdes-test.c
@@ -73,10 +73,42 @@ static void test_at_data_serdes(struct kunit *test)
 	KUNIT_EXPECT_MEMEQ(test, quadlets, expected, sizeof(expected));
 }
 
+static void test_it_data_serdes(struct kunit *test)
+{
+	static const __le32 expected[] = {
+		cpu_to_le32(0x000349a7),
+		cpu_to_le32(0x02300000),
+	};
+	__le32 quadlets[] = {0, 0};
+	unsigned int scode = ohci1394_it_data_get_speed(expected);
+	unsigned int tag = ohci1394_it_data_get_tag(expected);
+	unsigned int channel = ohci1394_it_data_get_channel(expected);
+	unsigned int tcode = ohci1394_it_data_get_tcode(expected);
+	unsigned int sync = ohci1394_it_data_get_sync(expected);
+	unsigned int data_length = ohci1394_it_data_get_data_length(expected);
+
+	KUNIT_EXPECT_EQ(test, 0x03, scode);
+	KUNIT_EXPECT_EQ(test, 0x01, tag);
+	KUNIT_EXPECT_EQ(test, 0x09, channel);
+	KUNIT_EXPECT_EQ(test, 0x0a, tcode);
+	KUNIT_EXPECT_EQ(test, 0x7, sync);
+	KUNIT_EXPECT_EQ(test, 0x0230, data_length);
+
+	ohci1394_it_data_set_speed(quadlets, scode);
+	ohci1394_it_data_set_tag(quadlets, tag);
+	ohci1394_it_data_set_channel(quadlets, channel);
+	ohci1394_it_data_set_tcode(quadlets, tcode);
+	ohci1394_it_data_set_sync(quadlets, sync);
+	ohci1394_it_data_set_data_length(quadlets, data_length);
+
+	KUNIT_EXPECT_MEMEQ(test, quadlets, expected, sizeof(expected));
+}
+
 static struct kunit_case ohci_serdes_test_cases[] = {
 	KUNIT_CASE(test_self_id_count_register_deserialization),
 	KUNIT_CASE(test_self_id_receive_buffer_deserialization),
 	KUNIT_CASE(test_at_data_serdes),
+	KUNIT_CASE(test_it_data_serdes),
 	{}
 };
 
diff --git a/drivers/firewire/ohci.h b/drivers/firewire/ohci.h
index a5501996137c..218666cfe14a 100644
--- a/drivers/firewire/ohci.h
+++ b/drivers/firewire/ohci.h
@@ -269,6 +269,90 @@ static inline void ohci1394_at_data_set_rcode(__le32 *data, unsigned int rcode)
 	data[1] |= cpu_to_le32((rcode << OHCI1394_AT_DATA_Q1_rCode_SHIFT) & OHCI1394_AT_DATA_Q1_rCode_MASK);
 }
 
+// Isochronous Transmit DMA.
+//
+// The content of first two quadlets of data for IT DMA is different from the header for IEEE 1394
+// isochronous packet.
+
+#define OHCI1394_IT_DATA_Q0_spd_MASK		0x00070000
+#define OHCI1394_IT_DATA_Q0_spd_SHIFT		16
+#define OHCI1394_IT_DATA_Q0_tag_MASK		0x0000c000
+#define OHCI1394_IT_DATA_Q0_tag_SHIFT		14
+#define OHCI1394_IT_DATA_Q0_chanNum_MASK	0x00003f00
+#define OHCI1394_IT_DATA_Q0_chanNum_SHIFT	8
+#define OHCI1394_IT_DATA_Q0_tcode_MASK		0x000000f0
+#define OHCI1394_IT_DATA_Q0_tcode_SHIFT		4
+#define OHCI1394_IT_DATA_Q0_sy_MASK		0x0000000f
+#define OHCI1394_IT_DATA_Q0_sy_SHIFT		0
+#define OHCI1394_IT_DATA_Q1_dataLength_MASK	0xffff0000
+#define OHCI1394_IT_DATA_Q1_dataLength_SHIFT	16
+
+static inline unsigned int ohci1394_it_data_get_speed(const __le32 *data)
+{
+	return (le32_to_cpu(data[0]) & OHCI1394_IT_DATA_Q0_spd_MASK) >> OHCI1394_IT_DATA_Q0_spd_SHIFT;
+}
+
+static inline void ohci1394_it_data_set_speed(__le32 *data, unsigned int scode)
+{
+	data[0] &= cpu_to_le32(~OHCI1394_IT_DATA_Q0_spd_MASK);
+	data[0] |= cpu_to_le32((scode << OHCI1394_IT_DATA_Q0_spd_SHIFT) & OHCI1394_IT_DATA_Q0_spd_MASK);
+}
+
+static inline unsigned int ohci1394_it_data_get_tag(const __le32 *data)
+{
+	return (le32_to_cpu(data[0]) & OHCI1394_IT_DATA_Q0_tag_MASK) >> OHCI1394_IT_DATA_Q0_tag_SHIFT;
+}
+
+static inline void ohci1394_it_data_set_tag(__le32 *data, unsigned int tag)
+{
+	data[0] &= cpu_to_le32(~OHCI1394_IT_DATA_Q0_tag_MASK);
+	data[0] |= cpu_to_le32((tag << OHCI1394_IT_DATA_Q0_tag_SHIFT) & OHCI1394_IT_DATA_Q0_tag_MASK);
+}
+
+static inline unsigned int ohci1394_it_data_get_channel(const __le32 *data)
+{
+	return (le32_to_cpu(data[0]) & OHCI1394_IT_DATA_Q0_chanNum_MASK) >> OHCI1394_IT_DATA_Q0_chanNum_SHIFT;
+}
+
+static inline void ohci1394_it_data_set_channel(__le32 *data, unsigned int channel)
+{
+	data[0] &= cpu_to_le32(~OHCI1394_IT_DATA_Q0_chanNum_MASK);
+	data[0] |= cpu_to_le32((channel << OHCI1394_IT_DATA_Q0_chanNum_SHIFT) & OHCI1394_IT_DATA_Q0_chanNum_MASK);
+}
+
+static inline unsigned int ohci1394_it_data_get_tcode(const __le32 *data)
+{
+	return (le32_to_cpu(data[0]) & OHCI1394_IT_DATA_Q0_tcode_MASK) >> OHCI1394_IT_DATA_Q0_tcode_SHIFT;
+}
+
+static inline void ohci1394_it_data_set_tcode(__le32 *data, unsigned int tcode)
+{
+	data[0] &= cpu_to_le32(~OHCI1394_IT_DATA_Q0_tcode_MASK);
+	data[0] |= cpu_to_le32((tcode << OHCI1394_IT_DATA_Q0_tcode_SHIFT) & OHCI1394_IT_DATA_Q0_tcode_MASK);
+}
+
+static inline unsigned int ohci1394_it_data_get_sync(const __le32 *data)
+{
+	return (le32_to_cpu(data[0]) & OHCI1394_IT_DATA_Q0_sy_MASK) >> OHCI1394_IT_DATA_Q0_sy_SHIFT;
+}
+
+static inline void ohci1394_it_data_set_sync(__le32 *data, unsigned int sync)
+{
+	data[0] &= cpu_to_le32(~OHCI1394_IT_DATA_Q0_sy_MASK);
+	data[0] |= cpu_to_le32((sync << OHCI1394_IT_DATA_Q0_sy_SHIFT) & OHCI1394_IT_DATA_Q0_sy_MASK);
+}
+
+static inline unsigned int ohci1394_it_data_get_data_length(const __le32 *data)
+{
+	return (le32_to_cpu(data[1]) & OHCI1394_IT_DATA_Q1_dataLength_MASK) >> OHCI1394_IT_DATA_Q1_dataLength_SHIFT;
+}
+
+static inline void ohci1394_it_data_set_data_length(__le32 *data, unsigned int data_length)
+{
+	data[1] &= cpu_to_le32(~OHCI1394_IT_DATA_Q1_dataLength_MASK);
+	data[1] |= cpu_to_le32((data_length << OHCI1394_IT_DATA_Q1_dataLength_SHIFT) & OHCI1394_IT_DATA_Q1_dataLength_MASK);
+}
+
 // Self-ID DMA.
 
 #define OHCI1394_SelfIDCount_selfIDError_MASK		0x80000000
-- 
2.43.0


