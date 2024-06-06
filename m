Return-Path: <linux-kernel+bounces-205171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82738FF854
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9481F24B19
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790013DDA9;
	Thu,  6 Jun 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="YoTiKpUs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6Xot6D9"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7C140368
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717906; cv=none; b=VNH/G3+XTx1wQsIeih89ozooAlENLMZ2TWFiqenFzLKpeGFYcoM0USgqI6L0DCeW9m3lQhRAxH2S+RQ4Sg3Km0kB8GZT7ykVIOBCZEHi+joljSDrzILpq2dah80eIGv/5Q5RbvXVXVPMAWwTQVSUiSntTqmOxanRYdxwUprFiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717906; c=relaxed/simple;
	bh=6wRulUaHbNwcxXaYzornt+OKK480U+ChQB+7e/cV+Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPQ3Mo1OySU2v6jb/KY3Zb9VKq8lx0ejWaP72gU7W33o0Dc+3/4wLnfSTOV5u9KbO+JO52EUJRuuvHtebayHZbQEWwNfdX6GgSkx6W/v+CLa6VjsJDFUqOo+7fQ90JCw+rx2Npd6zikTpb0+eMVfNaIaui4k/hHmvsnOURJB2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=YoTiKpUs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A6Xot6D9; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id ACF691C000A6;
	Thu,  6 Jun 2024 19:51:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 19:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717717903; x=
	1717804303; bh=rc+1mBnu6UDgWW1vu+fZekW80szq7fBM/FdiSLXLXbw=; b=Y
	oTiKpUslqABHDtoTz3Q7VWHYR/RWX1/8kV21pLQu0MDy+BYc6dgVd2ACVvIVm79K
	rf2r2pgNEDpF5p6lDmlXSGxduFcDT+VniWM8fDwUG018dO1MPyIb8GcjqGa6HkNK
	tHiBMF4SwkTuiFK+Wkfw6YbP4Va2GbqLYWAxqxONRAJ60MBzBcrAqriem4c7FTVn
	ZjSK63jsJU+4YLdgN7vRx4XVlnEFyDQwyZXcsjPlubUoohIhT/BsEeccxOCo5MeA
	1QlGNE71Wg6PuIOnCMw87unz1qJSSSIPr33vF+IZuu1tyiRCtlygsOg3kj9I1CQA
	0js2ojOotK1LwHnlJhcOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717717903; x=
	1717804303; bh=rc+1mBnu6UDgWW1vu+fZekW80szq7fBM/FdiSLXLXbw=; b=A
	6Xot6D92xdN2RvVoe/JJR/8VnavaDrsL9u37RgPFjOf7zk+Hqce+gokzUdu57wrX
	x36yvGWGjCmMqh9NmZZiWneUOGJy2t7iBuc3CstjAmK0HJSiZI2rd3+hkE4FmG8n
	WaEfl7FgGFnFmNklHPuetiudRDnjHl1pbaCZlvcCWNgi+zstANPtWZXMawF1hnq1
	WSflNS5U57lhhRA95MzNOkCooQzFrSgl5zu3gM4teeCKAVbVQ4ZGcDL5Zixm/5eD
	SB3PRFnXAWd5l0sD84FIancKOmvdkQyrHTIxBSdURlHafABO8PUYq6o1897y8dPh
	l5oVBzPeYXFEqptNHM/EA==
X-ME-Sender: <xms:j0tiZsynmhPsj7kMD5vVe5Z7Xd6Nu-VUvpt5fij8CwyRt0xEaD387g>
    <xme:j0tiZgTWoCstio_ql6XSPOr_hKm_d00aN__9-Qad7Q2LCVnPSGk9VR4CFYudxpDRN
    RJrxpwxqN76R_0Hcsg>
X-ME-Received: <xmr:j0tiZuUP0876-GU_zged_0UIZdMl2m8ewIMeRqakPelxzvwSlf6rNZrNPYlBGImEi4c8o_aYBUfeyDOMpn0fkEdnXf4ponanZCJu4nIzcYt38Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:j0tiZqjuJDJ7cWhrshjseTLr0GuYVOGLFKPGG_cW-vxM0531Ml1K5A>
    <xmx:j0tiZuBRSHeozBM6qqyKfMTB_EN9EuZL1RxL2oPHSg-ddE0Jo-5iqA>
    <xmx:j0tiZrK4wP6HBhBfdPT7ngeV6rKB-6S_hCGlIvKvrSTksMh6d-1vIQ>
    <xmx:j0tiZlAhtLCLiMPYS2VaZYydYMjC85xRed0KxUc0Gqg3dCaxUrP2aA>
    <xmx:j0tiZhO7V_2Mv7mjSstDDfTP8hYCR_MlZ3Cyw5D3tCeqxrk86_aJqJrq>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 19:51:41 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firewire: core: use inline helper functions to serialize phy config packet
Date: Fri,  7 Jun 2024 08:51:33 +0900
Message-ID: <20240606235133.231543-3-o-takashi@sakamocchi.jp>
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

This commit uses the added helper functions to obsolete the existing
implementation for phy configuration packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 6868ff17dc10..5b80ca9d6230 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -30,19 +30,12 @@
 
 #include "core.h"
 #include "packet-header-definitions.h"
+#include "phy-packet-definitions.h"
 #include <trace/events/firewire.h>
 
 #define HEADER_DESTINATION_IS_BROADCAST(header) \
 	((async_header_get_destination(header) & 0x3f) == 0x3f)
 
-#define PHY_PACKET_CONFIG	0x0
-#define PHY_PACKET_LINK_ON	0x1
-#define PHY_PACKET_SELF_ID	0x2
-
-#define PHY_CONFIG_GAP_COUNT(gap_count)	(((gap_count) << 16) | (1 << 22))
-#define PHY_CONFIG_ROOT_ID(node_id)	((((node_id) & 0x3f) << 24) | (1 << 23))
-#define PHY_IDENTIFIER(id)		((id) << 30)
-
 /* returns 0 if the split timeout handler is already running */
 static int try_cancel_split_timeout(struct fw_transaction *t)
 {
@@ -480,10 +473,14 @@ void fw_send_phy_config(struct fw_card *card,
 			int node_id, int generation, int gap_count)
 {
 	long timeout = DIV_ROUND_UP(HZ, 10);
-	u32 data = PHY_IDENTIFIER(PHY_PACKET_CONFIG);
+	u32 data = 0;
 
-	if (node_id != FW_PHY_CONFIG_NO_NODE_ID)
-		data |= PHY_CONFIG_ROOT_ID(node_id);
+	phy_packet_set_packet_identifier(&data, PHY_PACKET_PACKET_IDENTIFIER_PHY_CONFIG);
+
+	if (node_id != FW_PHY_CONFIG_NO_NODE_ID) {
+		phy_packet_phy_config_set_root_id(&data, node_id);
+		phy_packet_phy_config_set_force_root_node(&data, true);
+	}
 
 	if (gap_count == FW_PHY_CONFIG_CURRENT_GAP_COUNT) {
 		gap_count = card->driver->read_phy_reg(card, 1);
@@ -494,7 +491,8 @@ void fw_send_phy_config(struct fw_card *card,
 		if (gap_count == 63)
 			return;
 	}
-	data |= PHY_CONFIG_GAP_COUNT(gap_count);
+	phy_packet_phy_config_set_gap_count(&data, gap_count);
+	phy_packet_phy_config_set_gap_count_optimization(&data, true);
 
 	mutex_lock(&phy_config_mutex);
 
-- 
2.43.0


