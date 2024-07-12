Return-Path: <linux-kernel+bounces-250018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6330A92F304
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB471C21E65
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C569139D;
	Fri, 12 Jul 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kwfka5r+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2rKlP/u"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041A6376
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744217; cv=none; b=tNslxCZdnAAmE6gGOTwcbYzqLrNnu/1auTKvlkTfw8ogua+CnSZT8/Sqf3EjbSJplLZg70tKnn8jUM237rR3OEPQS+ZkiOImV7aIBeMLwiQKkZOg3stRw/oh7CEMMXquzs6dEDNYhA57X6SRsyHAFzohMHqP3SrVsbjem3jhF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744217; c=relaxed/simple;
	bh=Nepnpr4Pe+Bngok0OOQWwl5YjpVRYz8R1ziSDrRxV+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4gIDq3416xcVER19wJPeK8yAbiddh7A8oKcQZbOJmtxT0ldKbnzwx9clkondsOAZaOJgpH72S06y9dUXaqhHMhL0kvjYXTNAiBFOHhe2aHbpFhLa2QoC6Ub0kg1+3za8Y41J+3Vwq28fmiYcObuAi76QYD4vKhh8alhuzkFMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=kwfka5r+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2rKlP/u; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 141CB11411A3;
	Thu, 11 Jul 2024 20:30:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jul 2024 20:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1720744215; x=1720830615; bh=R0S5CXN0MM
	8JyTerS230tI71Dv3Ebmcsqj7VGFBlIio=; b=kwfka5r+wDxi6ryPJrdslI5zL2
	v83P8EOdyrzvvuPbPMXrJWPz1+Po3dskWhaJbO1ySosileioMBawgk0N1H6mr7sD
	7Dodvyjtu13gVrmCdoioPSl/GjVOMg/2CIfXIAywsgJG2Z93VQCmIcxRIo2J4tqE
	75Rwl8DlX7LP5pAoIZPtrDa6OehgvqX+7SdqAkbSWiImNK3PMiZvu+lwcD4+IMqn
	GZCVFuB2jzy8OALfp04zM/G1Zuod4j5riPP0er+/jXPD5D/ibVaVr77ChNub/n9C
	Mcz8AqAlhlCHF4BltVbQLVeZOsIjbdbdlNLescyrdKW4ZE9UIe5qnC9PoX6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720744215; x=1720830615; bh=R0S5CXN0MM8JyTerS230tI71Dv3E
	bmcsqj7VGFBlIio=; b=T2rKlP/u+VXEyMVgtzCd5sNgEs5i7R7lSuqdm/CEKjV2
	Z7moY1n4w2U6mFmHzQedgZCS6ftsBk7RKS6sQhd+NfjLsEx9ZUIm1BLMU+Uovm44
	um3h4+p3ClHqYIYbqX/Oe6nps09jPPyzlOurmhulqd4AHaXsHOmVaTjgwXnxV/dj
	I3SYTgptaCNCt1s0S7VX16NGVVyyshH7CsMQ56w/BDYl67z+Ae9ikqGA4ucyxe+/
	v+TaRxNKkmezA0CevihXa0tSt6jQXuwYKG+LF3hcAdCMT8xN5/bqgrlPL8FKtwrj
	AjnxYLuYP0uyCUfgz4OeC4uxzzvu45Gp9XbEtVFVlA==
X-ME-Sender: <xms:FXmQZgAV4jDEpdTFCSI1MNoaYMOLKr-N6o3mmWQJug3GpHQ03u_9_A>
    <xme:FXmQZigNF5NO3lT01AiRl6eTuHYBVVPvHlwXSPaU5lj_fgP8fmg3gKqplrMZVqJVd
    tzkshTC0qCm-BuL2qM>
X-ME-Received: <xmr:FXmQZjni4h4Mabt7f47Hm5bIZ0VR1g9nnP73kKCm2Dv70KKaOicpzCHDDQoNyMeLx-_kx-8uCI1Li150P-L26W4RIK7gNAEPo_DbAlAWD_7zP9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevke
    duhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjph
X-ME-Proxy: <xmx:FXmQZmz0SD1tY7LBCglKeb2NT-jfBtFvpwsk5iiIa-lKHp8vrh2MUA>
    <xmx:FXmQZlTefNtnmBl2pcghgUQD3XJtgXjjlI8_IMhRy9tEH6W5yubevw>
    <xmx:FXmQZha-QPIjFlYir89QKV0OUCvhLr-MJWrQQpjcM0UDzV9QzP3v8w>
    <xmx:FXmQZuREPhMnAlLiAuhpA-W8z8lrE7BaAfie3PwlbFyQy_UQt_HDTA>
    <xmx:F3mQZgfiHeRY8CQj2FD50f65lLkhqTvGMpMXIIF1y0JnwNSJVkmAJ22Q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 20:30:12 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] firewire: core: move copy_port_status() helper function to TP_fast_assign() block
Date: Fri, 12 Jul 2024 09:30:10 +0900
Message-ID: <20240712003010.87341-1-o-takashi@sakamocchi.jp>
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
 include/trace/events/firewire.h | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 16 deletions(-)

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
index bac9d98e88e5..b108176deb22 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -392,9 +392,6 @@ TRACE_EVENT(bus_reset_handle,
 #define PHY_PACKET_SELF_ID_GET_INITIATED_RESET(quads)	\
 	((((const u32 *)quads)[0] & SELF_ID_ZERO_INITIATED_RESET_MASK) >> SELF_ID_ZERO_INITIATED_RESET_SHIFT)
 
-void copy_port_status(u8 *port_status, unsigned int port_capacity, const u32 *self_id_sequence,
-		      unsigned int quadlet_count);
-
 TRACE_EVENT(self_id_sequence,
 	TP_PROTO(unsigned int card_index, const u32 *self_id_sequence, unsigned int quadlet_count, unsigned int generation),
 	TP_ARGS(card_index, self_id_sequence, quadlet_count, generation),
@@ -407,8 +404,16 @@ TRACE_EVENT(self_id_sequence,
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


