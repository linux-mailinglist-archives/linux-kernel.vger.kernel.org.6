Return-Path: <linux-kernel+bounces-265863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B793093F6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379511F228E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BF21552F5;
	Mon, 29 Jul 2024 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="y99smwt9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACKdFaWw"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A3147C86
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260800; cv=none; b=D/bAeaNwrLWni0879QPgwoIrpOhBDf4q6m+eNGlxBYaIkreZWW5HMmF16VqGqbE/BO2FZsTdsYkA/nRDrk/1UYCxRpTb2rAUM3JNaASrlcZRzqYDsm3YUV3ZykqRbGfsITswuTq+emnUPhiI0zHOaJr9c1zv9Hg1e/qz+WrL9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260800; c=relaxed/simple;
	bh=cS5Sym8Z9j+OJ0ThHcA+a8pykzx1OoGFIjcQvngS5NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI8xOA2gDB8iTGhloFTJIn0/EbsjQyHrdASntgLaG+mj/iGV6YKYq96xQzIpm7g/ybmq0UG7teD417v0oh30MFa2kHkp2/5vVp5uIhX0FDK+PDq1rJHF/uvThJ8cYprhC5Plu1S2KJCkEMWtior8ycBw/KQYybet7QyxbBBLqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=y99smwt9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ACKdFaWw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id BE7F4138024B;
	Mon, 29 Jul 2024 09:46:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Jul 2024 09:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722260797; x=
	1722347197; bh=0tCtpGDits0Hy6LBmFMD6VZ1iHyJ5l1QnaLH/UD29/k=; b=y
	99smwt9JmjhgMnlVL0mX3UavIs0EqLsO8Ir4I8v6HMWqSVidXnumw0ElbvxU9uDy
	OmY+8Y2dLf9GUQtK4hczBlcz/9cKAVKQl/+d3nYs+B3emXtMxLSUjIfIDzRbh0J7
	aof9Bgh3kTvf6iR2H2aWb1HTqVEgq+vg2x5nTpooxC6X9aHtP4v+XTksobe45Qps
	4IET+D25FfPmzbQQRkBAd0XE/JW11kK1zxngIB/OJwGuc6fV37wjA8b+c9jMS1s7
	ERqYScB58KPoyGqSg2JLP1M8qNu74RqOhzw6oPBEBtx3WYj3nF6eLGfoyPkp+DBj
	r4ARu2tF5ECgDjII0Z/pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722260797; x=
	1722347197; bh=0tCtpGDits0Hy6LBmFMD6VZ1iHyJ5l1QnaLH/UD29/k=; b=A
	CKdFaWwi9mt+gPufPW0fj9/kIF+HwjSTqqFvhT7NnlQxlFt8wSJAy39b11QzWcno
	W8D9vZHz+qtJkZs1E76KjqEOgxEuZAl4AcePtY9ivzMy6kugPWnR9EfgIh/xxmTJ
	wEjrVVzDBM47rIPqc4zm8l8tXrOE0zzXeQkF0QlufvX5tqM6UVKeZFDBcYvzSWi2
	C74dHwXI07a9ZobttKa65w6ooHrHLB+QeYu0fICDCv3HdIlWcrGJAV5suREOZrhQ
	Ry0+7/eaTVAmrKHnrpbuEu+yNTe2KI+Dcj+aAm+hDCvK7kLeI5uG20o0d8RBMUZp
	dLxItVWlIvGsvVSQEjBQQ==
X-ME-Sender: <xms:PZ2nZk-i5moP1RPA8OdFPtJ3qNbRZ8-VrZeNb398fhD6QP4V5Puj7Q>
    <xme:PZ2nZssx0CRE9WsuTS7Kq5VPaY2u6gqaw75yHvgOVqr2q29Wii90TIiQ4FsB-59uH
    nKrhicGy_o1u357Gaw>
X-ME-Received: <xmr:PZ2nZqDt5aHRgxA3SkBPAO3kl54Jv0VKwDOQDb9pm1zK__nsID_RJ0IZsr50TFmeIAKf_gjw8SfKGxvw56ElprLrhO6KkDssngfwGUGrRpR2iVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:PZ2nZkdZx5bPoipxvtnP0Gs8tG3awXQZgRMFZpIdHG6WpX0tT6I8xw>
    <xmx:PZ2nZpORzmjkKZZ-CsSy1SferDZRwG7OQWmJeFyeA2dC65I-Rq1P8Q>
    <xmx:PZ2nZumpKGXVmZ24NZn-1b2cqL0Sz80fRwB84fhqxCpsBPdNhSNvnA>
    <xmx:PZ2nZrs_Yb52jh7gg4GeVR75CDQXR2_JQ4O6SizkWndUcU1NAr-h0g>
    <xmx:PZ2nZiYeFeMK1f429uSTtjoPZne4N27cUOfqGiiEXCM-59FrawgEJAy8>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 09:46:36 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] firewire: ohci: use TCODE_LINK_INTERNAL consistently
Date: Mon, 29 Jul 2024 22:46:29 +0900
Message-ID: <20240729134631.127189-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729134631.127189-1-o-takashi@sakamocchi.jp>
References: <20240729134631.127189-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In IEEE 1394 specification, 0x0e in tcode field is reserved for internal
purpose depending on link layer. In 1394 OHCI specification, it is used to
express phy packet in AT/AR contexts.

Current implementation of 1394 OHCI driver has several macros for the code.
They can be simply replaced with a macro in core code.

This commit obsoletes the macros.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 9 ++++-----
 drivers/firewire/ohci.h | 1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 314a29c0fd3e..c3fff94b13e5 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -264,7 +264,6 @@ static inline struct fw_ohci *fw_ohci(struct fw_card *card)
 #define OHCI1394_REGISTER_SIZE		0x800
 #define OHCI1394_PCI_HCI_Control	0x40
 #define SELF_ID_BUF_SIZE		0x800
-#define OHCI_TCODE_PHY_PACKET		0x0e
 #define OHCI_VERSION_1_1		0x010010
 
 static char ohci_driver_name[] = KBUILD_MODNAME;
@@ -586,7 +585,7 @@ static void log_ar_at_event(struct fw_ohci *ohci,
 		ohci_notice(ohci, "A%c %s, %s\n",
 			    dir, evts[evt], tcodes[tcode]);
 		break;
-	case 0xe:
+	case TCODE_LINK_INTERNAL:
 		ohci_notice(ohci, "A%c %s, PHY %08x %08x\n",
 			    dir, evts[evt], header[1], header[2]);
 		break;
@@ -939,7 +938,7 @@ static __le32 *handle_ar_packet(struct ar_context *ctx, __le32 *buffer)
 
 	case TCODE_WRITE_RESPONSE:
 	case TCODE_READ_QUADLET_REQUEST:
-	case OHCI_TCODE_PHY_PACKET:
+	case TCODE_LINK_INTERNAL:
 		p.header_length = 12;
 		p.payload_length = 0;
 		break;
@@ -967,7 +966,7 @@ static __le32 *handle_ar_packet(struct ar_context *ctx, __le32 *buffer)
 	 * Several controllers, notably from NEC and VIA, forget to
 	 * write ack_complete status at PHY packet reception.
 	 */
-	if (evt == OHCI1394_evt_no_status && tcode == OHCI1394_phy_tcode)
+	if (evt == OHCI1394_evt_no_status && tcode == TCODE_LINK_INTERNAL)
 		p.ack = ACK_COMPLETE;
 
 	/*
@@ -1435,7 +1434,7 @@ static int at_context_queue_packet(struct context *ctx,
 		break;
 
 	case TCODE_LINK_INTERNAL:
-		header[0] = cpu_to_le32((OHCI1394_phy_tcode << 4) |
+		header[0] = cpu_to_le32((TCODE_LINK_INTERNAL << 4) |
 					(packet->speed << 16));
 		header[1] = cpu_to_le32(packet->header[1]);
 		header[2] = cpu_to_le32(packet->header[2]);
diff --git a/drivers/firewire/ohci.h b/drivers/firewire/ohci.h
index 71c2ed84cafb..9ed36cfc6cae 100644
--- a/drivers/firewire/ohci.h
+++ b/drivers/firewire/ohci.h
@@ -153,7 +153,6 @@
 #define OHCI1394_evt_unknown		0xe
 #define OHCI1394_evt_flushed		0xf
 
-#define OHCI1394_phy_tcode		0xe
 
 // Self-ID DMA.
 
-- 
2.43.0


