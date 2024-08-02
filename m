Return-Path: <linux-kernel+bounces-271972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F1E945588
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA86E1C22EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C115E89;
	Fri,  2 Aug 2024 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="G0Nb6Q+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lSFjAwK+"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238EA168DA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558976; cv=none; b=tq8mc/m2oFgmSEhPvtXgDGoJQZt9tcU7XI9uUDpzYdHER14gQCa9XMA9FxsbIUenGSR9nJzoUZdNGMiSfB8ueLIb5B4QUNFMvfT7Es94noLmChkMwpa9cjmvB6zQh9r31b38mdK+1zW+VNAIqFIy2BvmolmcNjCktyTjzqDwbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558976; c=relaxed/simple;
	bh=EERZiA9OBqbUfzX6dWcV+onSZFgy6NmEDzi43tPwCic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwUstl8YMEV+qyWCxcSR1QT+x2q5HT6kz1AjF49CRBE7n4vN3XQLGk9dlgeTLIrbZUyNzedO4umOo607MrArO12/vDDR8TdOwBDeFNx4SCKsTJDYMD16q0kiwASiYTj3xwQy1the3RzYGD3pqhUO91wT0PxdqMd9MtcBkLpNCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=G0Nb6Q+I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lSFjAwK+; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 24EFB1151AC1;
	Thu,  1 Aug 2024 20:36:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Aug 2024 20:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722558973; x=
	1722645373; bh=nSQLw0DtRLTyTefcQ0WywR98+UooHN8NN3gIiWDsTAA=; b=G
	0Nb6Q+IflDVfMokeGzEMjwv7GyKWzPBeyK3nZ9eXcz1obdELlkFQPt04K+4bnjfH
	wfwQeMYmRxJiaZwDkbW1cuPkPcC/ctgHUgjMYpKlOxkadZjprplFvMKJLssTvkP5
	VbOgnnli9G6jUoTIFzAzrVRDiesoLGBuORa4Lx3FFSUguUSuIaWlifsNKU+4fgSu
	BfkFaBP9Jgt98ZgYQTMyPkJYImfdKDdwyOJGuoiGRGng3x3ra5zpXdkxCXg6k1rk
	1m/NnJwz+c+BVCHyINbGU4AQpLAfzDjoBSutiqXmkCWzrV67Toz1DxC5rH7HnyEL
	gxAPJujLScMqfh0xVf9+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722558973; x=
	1722645373; bh=nSQLw0DtRLTyTefcQ0WywR98+UooHN8NN3gIiWDsTAA=; b=l
	SFjAwK+NTcVH14EpSeybqDzDb4AiZYE9goAsKSNKWZj7GQO2mK3BNUUNAx/KUgMP
	8Aoe9OxuCMnm1OUAyR+XkCl8cqS8tWMlNVf98m5AkTy2KY64MgCjllpaykAM53Jt
	DeTi2eSj4RMlnGJ389MMT8yN6eb+lcJWhR8hYqkF1ksTFiFVddf8DkDhTkfDD3Hp
	rSujmjZ8KjMyTZLn6r0tzLLx9LapVWiYTdgEwFtBlscbl9Tp+lz+0xvH+anV0/np
	A5zdJHVJdspfTUiJGsLdHk8m+IX2uMPBwATR+SJTMPqF7s0xtEg7soEZD75MaH1u
	hdgDLLsMI5/9U8CLeJV3Q==
X-ME-Sender: <xms:_SmsZu0z9LGfwTn0uOkf8XUdhOlfuqMAlfGc8hQhR5MH2EFeO1TuAQ>
    <xme:_SmsZhEmE9ioAfzQxNQ7v8vnKwXUIq3m9wGSy6Qd7zUtFBTwOUK1qS0AmUDtto6Sl
    POXc-fYSWIjnqU8AE8>
X-ME-Received: <xmr:_SmsZm7TZgGukiOF3wOpfZT3_cIqjWMIAJGPhuwjIwmMN5SBpRu5PTibAoHgux5w2W3t5tkvChwnokAHnJqIqkKCBTsXb4aLjEslRPzXUBxS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeelgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:_SmsZv1FCI3Jc9uds969yz3Ct_kHQK9yCCGYMLh21XpeCOZKY0lf8g>
    <xmx:_SmsZhHf5qK9J4q-ngKzKeAT5h_EprOhOtqamYMG7z7fUIE048VIRA>
    <xmx:_SmsZo_cSKsiQ7__GL_7c6S0iOEeTwTK7IcYV03wuenV3dPUi7mEWA>
    <xmx:_SmsZmn0nyyFgroRpf-S6T0VMq22E4oZTDtuCG_CCtJJ7TrZFrOERA>
    <xmx:_SmsZmRdju248NFZ2gmPwHfJot0gnwRr1pRUry7hAfviloqI9C4pC6Yi>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 20:36:12 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] firewire: ohci: use static inline functions to serialize data of AT DMA
Date: Fri,  2 Aug 2024 09:36:04 +0900
Message-ID: <20240802003606.109402-3-o-takashi@sakamocchi.jp>
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

This commit replaces current implementation with the helper functions added
in the former commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index a0bb0e87e18a..e8429dbbc60d 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1409,12 +1409,6 @@ static int at_context_queue_packet(struct context *ctx,
 	d[0].control   = cpu_to_le16(DESCRIPTOR_KEY_IMMEDIATE);
 	d[0].res_count = cpu_to_le16(packet->timestamp);
 
-	/*
-	 * The DMA format for asynchronous link packets is different
-	 * from the IEEE1394 layout, so shift the fields around
-	 * accordingly.
-	 */
-
 	tcode = async_header_get_tcode(packet->header);
 	header = (__le32 *) &d[1];
 	switch (tcode) {
@@ -1427,11 +1421,21 @@ static int at_context_queue_packet(struct context *ctx,
 	case TCODE_READ_BLOCK_RESPONSE:
 	case TCODE_LOCK_REQUEST:
 	case TCODE_LOCK_RESPONSE:
-		header[0] = cpu_to_le32((packet->header[0] & 0xffff) |
-					(packet->speed << 16));
-		header[1] = cpu_to_le32((packet->header[1] & 0xffff) |
-					(packet->header[0] & 0xffff0000));
-		header[2] = cpu_to_le32(packet->header[2]);
+		ohci1394_at_data_set_src_bus_id(header, false);
+		ohci1394_at_data_set_speed(header, packet->speed);
+		ohci1394_at_data_set_tlabel(header, async_header_get_tlabel(packet->header));
+		ohci1394_at_data_set_retry(header, async_header_get_retry(packet->header));
+		ohci1394_at_data_set_tcode(header, tcode);
+
+		ohci1394_at_data_set_destination_id(header,
+						    async_header_get_destination(packet->header));
+
+		if (ctx == &ctx->ohci->at_response_ctx) {
+			ohci1394_at_data_set_rcode(header, async_header_get_rcode(packet->header));
+		} else {
+			ohci1394_at_data_set_destination_offset(header,
+							async_header_get_offset(packet->header));
+		}
 
 		if (tcode_is_block_packet(tcode))
 			header[3] = cpu_to_le32(packet->header[3]);
@@ -1440,10 +1444,10 @@ static int at_context_queue_packet(struct context *ctx,
 
 		d[0].req_count = cpu_to_le16(packet->header_length);
 		break;
-
 	case TCODE_LINK_INTERNAL:
-		header[0] = cpu_to_le32((TCODE_LINK_INTERNAL << 4) |
-					(packet->speed << 16));
+		ohci1394_at_data_set_speed(header, packet->speed);
+		ohci1394_at_data_set_tcode(header, TCODE_LINK_INTERNAL);
+
 		header[1] = cpu_to_le32(packet->header[1]);
 		header[2] = cpu_to_le32(packet->header[2]);
 		d[0].req_count = cpu_to_le16(12);
-- 
2.43.0


