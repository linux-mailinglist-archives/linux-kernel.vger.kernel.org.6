Return-Path: <linux-kernel+bounces-250009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 132A892F2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F159B20A86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8551F635;
	Fri, 12 Jul 2024 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="P38/OpVc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="brorJJFM"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86798391
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742673; cv=none; b=t7O03Z8oWBOcWl1opbz2OXEsfBuZ3wGHIHBcIgZJxIDnhfHHHZ+tRrSylifW+X17/KYKu8WdLNLNRIol4dBK7HaoVTueGUZCUdtsfFoSO4cQcZoeK5504ywSknyCRTntZiSiclNqhCNQR4jC7oyQa1RlF89TmpBXHAQIYO+l6Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742673; c=relaxed/simple;
	bh=Nk+FEdSOxQUcuHz2BHOGp8ieYkS1RZBCDmhuxjJ8pOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4h2fnRGhTFjQj1WNLAbBZOeW+nWK8OaHwZcv19Rj+NvZygV2B/JC6/VGblcR96YeSfQuGdrUd85V4c78Loq9VNVcwcMu8q7TStp5YntNX6qF/UNjx9YIUTTECtuzJSR9FX44xtzElDsfmMW3b04AXMZahOr0jyFSbHlxWZ4H48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=P38/OpVc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=brorJJFM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 893671140169;
	Thu, 11 Jul 2024 20:04:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Jul 2024 20:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1720742669; x=1720829069; bh=xLxh5fWh3u
	mw8MBN4tpMO44IVzkrPOPO3jPeJID3dU8=; b=P38/OpVc1Kt6iPQsvqYnevq5uE
	U2m7Rh0Y0v6Zp2zQEwaDnw+CCvr/o/Rz0Tf16fcfoUP/cfypr2oG8JBfCdrZsD8X
	tsayBz2mykKLfZXKUI5g8V15SxNXSSj7MPIyIzRjuM0cjmL/31bM1eHBABPvd9Sz
	/IfuV+nqQWqMHmU4p+X5efbl9O4uLPzauLBLHgmSWux5V2eiqGkP3CcU+VjrVB9B
	gCy4Iqq8lwflTC5/KshyW2qJLGePqmsk6Yi401oamyVwWZAqGKSEq7P5oIC3L+o0
	s5ELSMqk3p25XRRymoAzCUON4FCoWRQS1Nj8hmQaXMXs7PuiXFndAyLHExXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720742669; x=1720829069; bh=xLxh5fWh3umw8MBN4tpMO44IVzkr
	POPO3jPeJID3dU8=; b=brorJJFM9N4SMawCACEyWH5N56SVnqmjTDwn3qx8gDnb
	qKGlGAQFhpNqQYhcqrYmPuw9P7DiF0KjoniXqxvihhDAPK87aakkLXWlRHlweBLy
	eCC8KqoTRwHWUFhcqtTvYhXDPyH2BGhodVVGUEl/u/elzqCM1wlXXQ6SxPg6pAbv
	UXh27z3iXUWTBJKFlqnqJXh6ILFX6mwa4z5uPVMXTcpw8Z77Kvud1gUbtM78zO8g
	FnlZIpESPTKqxK7cSgZ6uVujw5CGq2PGVJp/VFqLezUWYyPxh3UIBZF9hEAsfvEf
	zifYIIE+hCt2XlCuqNGRcqoz/XLx2yoe6EmCGMxr5Q==
X-ME-Sender: <xms:DHOQZh4XPJBj--18bYyHqcn4jbTiIjHROv8akxoeYIfgAxurS-q0pQ>
    <xme:DHOQZu7n-AF6WO5WxZ0b6Ql3CU7vsMlCoAJcYwrCZ0fmL1aunQ6OojqEWA-C8Wob-
    vWt0BLRDyPigKn8ZqY>
X-ME-Received: <xmr:DHOQZofsIqLiK5qNW4ekWwiqlxTjfulSyyhUoD8HKzdGvK02VSDsISG8-uuXzJqp99XuriVsW5KJUMySL7pKl9fMLONJbcrM8J9_feGduJBlh08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevke
    duhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjph
X-ME-Proxy: <xmx:DHOQZqJrt8xxINXCk5HRE4LZA9nmLWfnYBZkA2RPTxqVVzyXWDiswA>
    <xmx:DHOQZlIkaOY_5NghuP08w6Amx10ixVZRSTqE7jVT3gZleaqgIXaV4Q>
    <xmx:DHOQZjy_d8NjabJABpWW88rn5Q3Nfyi_iHOsO-fOPpKH_c_YdFx4Yg>
    <xmx:DHOQZhLmuZXOpfqjRWFn8AhZ2t9Ou-nuS0n-oF-gnqobYPOwdGWF3w>
    <xmx:DXOQZsWpoEx9A19WoSuzxGDhv7PwLnlpjrA_DvZFwN5znWWlym2SP0Ik>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 20:04:27 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: move copy_port_status() helper function to TP_fast_assign() block
Date: Fri, 12 Jul 2024 09:04:24 +0900
Message-ID: <20240712000424.85124-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It would be possible to put any statement in TP_fast_assign().

This commit obsoletes the helper function and put its statements to
TP_fast_assign() for the code simplicity.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-trace.c   | 11 -----------
 include/trace/events/firewire.h | 12 ++++++++++--
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-trace.c b/drivers/firewire/core-trace.c
index 5acb02c18a47..b70947fc7b8d 100644
--- a/drivers/firewire/core-trace.c
+++ b/drivers/firewire/core-trace.c
@@ -10,17 +10,6 @@
 #include <trace/events/firewire.h>
 
 #ifdef TRACEPOINTS_ENABLED
-void copy_port_status(u8 *port_status, unsigned int port_capacity,
-		      const u32 *self_id_sequence, unsigned int quadlet_count)
-{
-	unsigned int port_index;
-
-	for (port_index = 0; port_index < port_capacity; ++port_index) {
-		port_status[port_index] =
-			self_id_sequence_get_port_status(self_id_sequence, quadlet_count, port_index);
-	}
-}
-
 EXPORT_TRACEPOINT_SYMBOL_GPL(isoc_inbound_single_completions);
 EXPORT_TRACEPOINT_SYMBOL_GPL(isoc_inbound_multiple_completions);
 EXPORT_TRACEPOINT_SYMBOL_GPL(isoc_outbound_completions);
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index bac9d98e88e5..57a2be01d31a 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -407,8 +407,16 @@ TRACE_EVENT(self_id_sequence,
 	TP_fast_assign(
 		__entry->card_index = card_index;
 		__entry->generation = generation;
-		copy_port_status(__get_dynamic_array(port_status), __get_dynamic_array_len(port_status),
-				 self_id_sequence, quadlet_count);
+		{
+			u8 *port_status = __get_dynamic_array(port_status);
+			unsigned int port_index;
+
+			for (port_index = 0; port_index < __get_dynamic_array_len(port_status); ++port_index) {
+				port_status[port_index] =
+					self_id_sequence_get_port_status(self_id_sequence,
+									 quadlet_count, port_index);
+			}
+		}
 		memcpy(__get_dynamic_array(self_id_sequence), self_id_sequence,
 					   __get_dynamic_array_len(self_id_sequence));
 	),
-- 
2.43.0


