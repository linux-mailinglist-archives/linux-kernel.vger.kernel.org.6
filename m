Return-Path: <linux-kernel+bounces-262433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC3793C710
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C29428326A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7F19DF57;
	Thu, 25 Jul 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ph5E0sfA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="paVKY+PP"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481F21A04
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924217; cv=none; b=tlabydCdRvcFE5owIEx0qDVUpbqEmTNCs2yI8AwHrdR59eOQvzsq0n9a6zm8bInsn+AVO5UMifTOtK3RfhnJ6pcpZKenpV9Cie5mX7HL0L+1qwtMKUJyauknkzIeilYbHG+coGfqh3SsxymyhKBSWNFqLpVXmQyXKrWESQqfXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924217; c=relaxed/simple;
	bh=R9k0dHWXyNDFH67M0E8oKtFg5LOkl5bzUmszlooHKuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIrqAORADcyFET66yJUz6+vDrmwH0G34eoB0hYv5Y7ArQr0GQz4Vx5z+WgMNpxHGXzGFnvi1Y2JNoJQQN3rLVkokKXOZdLZ/uhHSSuTjX01RpK+y8m3r1/XKHT8a3UCB/A+M0SDWK6chv6cdMeoG9fVXE/MgJPFow68BoFKOSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ph5E0sfA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=paVKY+PP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2B77011401C8;
	Thu, 25 Jul 2024 12:16:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 Jul 2024 12:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1721924213; x=1722010613; bh=h+H2yEi8yb
	HeKFH2f2sjnPyfhN6u+CBYpHOx6Zj5E8M=; b=ph5E0sfAaao5oK42xaypo8WJuW
	JKBEIf5glHECYVUQfhLj5/83Cuuu8lpCNoXSNblDmesJSCdWTuRRIqgN61enWkNf
	yzZ7k5+ECdtPHfW8y21oD/QG21QOwghFDFqeDF3dGsc4OnB5Y7uOrVGTLce5Ud80
	SsfJbf/Ft52MYkjqeLJibiuDEaKfk1Gj/RNoYT5eGVW+mGtkHlcmlq5rC/UMQShW
	mYm7VmVNRzMk9oBz/WfNs0jjK2RhXY4iSlUWvInCDQ6CkIc4yU9bXI42dEpc/gE1
	A4DANtOJH8pgvn4kYxlwYyQ6u43RNqCPVOi9VvZzJUA3zekAulAp2JTD8qug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721924213; x=1722010613; bh=h+H2yEi8ybHeKFH2f2sjnPyfhN6u
	+CBYpHOx6Zj5E8M=; b=paVKY+PPOIf9XJJBEgh0KulvARNU0+AFTiQBbftVKhL2
	bI7XvkKUS0Ddv48Rs2v4WsEZF1u/M545RBUU38k5h6drok1b32pIBrNpwF8klBNC
	t7tfHmN9JPfCoIQb8Y7LAMiiJnw9EVOVXeVroFJVO547yAQe291X0FElu9km2/hD
	y0S/aD2VoTEUYgZ9iP5Fty0G9pdmrmU8DT+JAxG2UmdiwRHVuv59rXXYW4z96dr4
	BOiRatEUjcL4Xiz9yBfA/ucfT7UqTVkkhv/TojgP+7A0p8mNi/Rv9vptZ3UXUgHa
	kOxqHakpeGS4EooxOvuEbCzb0JICenik5YwnoI2yDg==
X-ME-Sender: <xms:dXqiZpGlapbyRVr2UpkUKea8WjZdeAF5Q4CZDKJC6DXi3eOUETnafA>
    <xme:dXqiZuXgyoO-5XR8B99uvfudBE2JlUdhmI_i3dDMoHQ46he-3bGM80-6iT7xi7shR
    cFvtFiHU4ppb4eWjjI>
X-ME-Received: <xmr:dXqiZrLX60P0D0y7IkTCNIXCFCeJyNoqbbey59c8mv8t9Ugwv7zzCxF-h3esi88M_WIyJav_MznLIEXMvs5CChq0Jb16y7Urjuvd-x4B5XSBZ28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieefgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevke
    duhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:dXqiZvEuMEgjbsAPaITWI8FKFJQb7tAB3ZkoAomgIE6t6DeJ0tcPQQ>
    <xmx:dXqiZvVGIIfhW89g8wH-lGrTfERCxkxMVz46YmtmEdCXu-PaBjUEzg>
    <xmx:dXqiZqPwQOn9zjYxUZOKml1lIqtkGXwwTNEwCK-rAdlM8uTrBfvQBA>
    <xmx:dXqiZu14uksIK11YK-jMXqfpp1RDWJblRy4W2lH6RqI4J057Kikidg>
    <xmx:dXqiZqSnC1E7BGTwf6stVF5VvLPQ5fvSqbd1ctzkJRWYfYy4DHEkkruB>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 12:16:51 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	gustavo@embeddedor.com
Subject: [PATCH] Revert "firewire: Annotate struct fw_iso_packet with __counted_by()"
Date: Fri, 26 Jul 2024 01:16:48 +0900
Message-ID: <20240725161648.130404-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d3155742db89df3b3c96da383c400e6ff4d23c25.

The header_length field is byte unit, thus it can not express the number of
elements in header field.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/linux/firewire.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index 00abe0e5d602..1cca14cf5652 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -462,9 +462,8 @@ struct fw_iso_packet {
 				/* rx: Sync bit, wait for matching sy	*/
 	u32 tag:2;		/* tx: Tag in packet header		*/
 	u32 sy:4;		/* tx: Sy in packet header		*/
-	u32 header_length:8;	/* Length of immediate header		*/
-				/* tx: Top of 1394 isoch. data_block    */
-	u32 header[] __counted_by(header_length);
+	u32 header_length:8;	/* Size of immediate header		*/
+	u32 header[];		/* tx: Top of 1394 isoch. data_block	*/
 };
 
 #define FW_ISO_CONTEXT_TRANSMIT			0
-- 
2.43.0


