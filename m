Return-Path: <linux-kernel+bounces-271975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7864194558C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3B01F23C66
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8C347781;
	Fri,  2 Aug 2024 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Flw2OSOW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSZQP/qf"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71DB1CD02
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558978; cv=none; b=TqIGDkCAU6kZLlHsm84xjT9Z/ymqd3/Ap4UfKMn6J9yT3SzwUjspylkSI5et2l9xgDhdH2vXFID52GumbyXJX3PurbDVmBNkpXVAGu9RPJlhLAIMdu7uAuFPD//eDozoAFZbwl1Ckxv+Uhfuu3HCcRqKwTBH/rMqjyqeG6VhOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558978; c=relaxed/simple;
	bh=DXTPSNKwLvYFn0h0UZcju4Oht9hG6hNSZmZ7KDbEpJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtbjHiuwlwUw8Hz2wF4qMY+3bbXQkvqhGtPYb0x72M0v70eWNCh4lQzm7u9HhtjkE0XXgFFfOdCxMSSK7xfCYgto5+gInLYSS6Z80IzCOQTR0G5abI5TUDG0vEvpYeupYcprPHez1Y+iXIfm4LSYv19xbH/YEKPY1VAFGjw1E5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Flw2OSOW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSZQP/qf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id B86F0138FC81;
	Thu,  1 Aug 2024 20:36:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 01 Aug 2024 20:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722558975; x=
	1722645375; bh=fGBvKcMjmz7YqvhXrQlAHy53rzEKiDR9wJlFL73blRo=; b=F
	lw2OSOW1QK10C2bl0w9ZFxr2XfYatOWF+7w4K00F6ofZy0duLvr6DkZFeYjip9TE
	b+jv/JMbpu6XHcdzumyp5I/RnQMBuRhBE613c+ca8xKjLFORJOb5Kzzv4i+cTAUX
	GT2YLAm330XLN7TEsFQ1C2FZ89tXtK7d5f+HS81GXPchzzE40mIU3QTQcFP8/bYw
	nGGXlV0VayTe/0xeiZQPoK3Rij2AnEyMqFITB1wDFXXAtBv/EGn1itriJ6azQKji
	kAstMQkzaCiKVv5OVSBx0qhHWGkrXyVtE1ydX9/P0MGhYk+d2qsPB2oiUPEgftfL
	1vY35EZ5tSMA2kHjXMeow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722558975; x=
	1722645375; bh=fGBvKcMjmz7YqvhXrQlAHy53rzEKiDR9wJlFL73blRo=; b=C
	SZQP/qfwVa0GHG+b9igDv78psRwnahxhWPoWuUbIURN/FJ20V3xrbftqN3urrYk6
	r8zXebGxKVptSWqVLfKnndiIX4KeDh/KxOx9zu/rTzcO2nM7E4o/2eBBBrfiOzLE
	E2XjceGaRSlMrJXhzTBZXI8qD2p0yqrfvTPFGf31pWAFzyqxgpXzntE/FzQGygGs
	BMjRJLu2irhH0hFVayEs2SDlbP6Q2pOQjl+cuuLjbmcZq1BbC8odSf48yrRA+5bM
	GOd0u+ptbuQF/94V+3nrUFHI04R/JR8YFgP956c1Wz10pasuFFPWfdSNZX4Iv5Qm
	gDluMLvEZm3zMKqYlrGwA==
X-ME-Sender: <xms:_ymsZsO22v2jDBI682-zQzbPOVzdXd4UAcqmMNjuTZwzU2Vu6xtdqQ>
    <xme:_ymsZi8fDXSH53n_06L1fQftPFnJv5sQCqr9HNyRzSmuE19Xxk8qAIM23sCR1PCAe
    BucqhGymhhlwW-MqEM>
X-ME-Received: <xmr:_ymsZjTZTqyff4mpwi1lmEqIkH_KSVZ0h4TmqHP9jbeScT3Wtb2fqK84XqOAfZViJI3cb6oC9EbC0H2fjyDqhA2VviuycEhfrcywY_LQuOua>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeelgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:_ymsZkufis3O7eYyffmAe7tKTi_OSbfL5ih4n6FKtSH67ZH8HJCieQ>
    <xmx:_ymsZkf5ii6sVUhLIwga1L0aYQNpQKNw2y1RuBnXqGgZ6S2thzEZIQ>
    <xmx:_ymsZo2JfI31vjQ8n9VYiGdVgU-3IPYsPSCQzgdPlrKjCqrKyR3WTA>
    <xmx:_ymsZo_QNKip_-bZ5Wi9EhHRDwCxGW8AMT_EPHFRXw7O3TYWAIQbmQ>
    <xmx:_ymsZlpIyy2fowIJxfJcH919MBWSIb8uRiwKOTc8xz2aWWGcWXMzj4Gp>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 20:36:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] firewire: ohci: use static inline functions to serialize data of IT DMA
Date: Fri,  2 Aug 2024 09:36:06 +0900
Message-ID: <20240802003606.109402-5-o-takashi@sakamocchi.jp>
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

THis commit replaces current implementation with the helper functions added
in the former commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index e8429dbbc60d..8f2bbd0569fb 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -162,13 +162,6 @@ struct context {
 	struct tasklet_struct tasklet;
 };
 
-#define IT_HEADER_SY(v)          ((v) <<  0)
-#define IT_HEADER_TCODE(v)       ((v) <<  4)
-#define IT_HEADER_CHANNEL(v)     ((v) <<  8)
-#define IT_HEADER_TAG(v)         ((v) << 14)
-#define IT_HEADER_SPEED(v)       ((v) << 16)
-#define IT_HEADER_DATA_LENGTH(v) ((v) << 16)
-
 struct iso_context {
 	struct fw_iso_context base;
 	struct context context;
@@ -1457,9 +1450,14 @@ static int at_context_queue_packet(struct context *ctx,
 		break;
 
 	case TCODE_STREAM_DATA:
-		header[0] = cpu_to_le32((packet->header[0] & 0xffff) |
-					(packet->speed << 16));
-		header[1] = cpu_to_le32(packet->header[0] & 0xffff0000);
+		ohci1394_it_data_set_speed(header, packet->speed);
+		ohci1394_it_data_set_tag(header, isoc_header_get_tag(packet->header[0]));
+		ohci1394_it_data_set_channel(header, isoc_header_get_channel(packet->header[0]));
+		ohci1394_it_data_set_tcode(header, TCODE_STREAM_DATA);
+		ohci1394_it_data_set_sync(header, isoc_header_get_sy(packet->header[0]));
+
+		ohci1394_it_data_set_data_length(header, isoc_header_get_data_length(packet->header[0]));
+
 		d[0].req_count = cpu_to_le16(8);
 		break;
 
@@ -3403,14 +3401,14 @@ static int queue_iso_transmit(struct iso_context *ctx,
 		d[0].branch_address = cpu_to_le32(d_bus | z);
 
 		header = (__le32 *) &d[1];
-		header[0] = cpu_to_le32(IT_HEADER_SY(p->sy) |
-					IT_HEADER_TAG(p->tag) |
-					IT_HEADER_TCODE(TCODE_STREAM_DATA) |
-					IT_HEADER_CHANNEL(ctx->base.channel) |
-					IT_HEADER_SPEED(ctx->base.speed));
-		header[1] =
-			cpu_to_le32(IT_HEADER_DATA_LENGTH(p->header_length +
-							  p->payload_length));
+
+		ohci1394_it_data_set_speed(header, ctx->base.speed);
+		ohci1394_it_data_set_tag(header, p->tag);
+		ohci1394_it_data_set_channel(header, ctx->base.channel);
+		ohci1394_it_data_set_tcode(header, TCODE_STREAM_DATA);
+		ohci1394_it_data_set_sync(header, p->sy);
+
+		ohci1394_it_data_set_data_length(header, p->header_length + p->payload_length);
 	}
 
 	if (p->header_length > 0) {
-- 
2.43.0


