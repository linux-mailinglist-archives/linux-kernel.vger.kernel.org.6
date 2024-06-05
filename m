Return-Path: <linux-kernel+bounces-203427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC628FDAF2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B5E284056
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32B16EBFE;
	Wed,  5 Jun 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="OZ+9m358";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QvEdmz6X"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66E168C2E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631535; cv=none; b=FIOHGBDTEDZSKPp8lkgP4clB4vgOJMCGMRx0fjwEsaFowq9RnBHU7hjUl1aq+vfOt79VqyDPNR+WxaHU20bAn7jVjyT7iP8lUGf1Jcl9Tfh4Ezxg7dkgHQFuXtFm3BuGJDo3zNK2+aDrj+H9xe2rj8i8opiL5qNDahRXWj4h7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631535; c=relaxed/simple;
	bh=j7AYul+E3SNchcFdpNyT4iDK9RXRnUgJ1OtxzdywbSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEv0MAZPCgTNqLG+wEiW85IVrai+ICki0IQGiDGDa/5gDjPHrIgjMNGkLzhTT77xYBd3crIGdaySsW1tR3SiS35KQFPOyiZogi28LhyRrLQOrG/1gc7ajL6wKRU81KnCD6Zff7H7yNsKCVw6QrmpN8iXfiVguBcHFilx/xHmXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=OZ+9m358; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QvEdmz6X; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 44DD01C000F6;
	Wed,  5 Jun 2024 19:52:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 05 Jun 2024 19:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631532; x=
	1717717932; bh=/hGv3vJEc747DzmJ/9VfAfyTUxjs3kdRF01FRUOE/pw=; b=O
	Z+9m358aGLTCduScfSN048PZa99HfCZyObOKRTIm6bTsz5tqCKkCprwsWt92n0AR
	jLzoKHDz9AemtWHL/yOZW1mXwu1KFK8Jm6fXIIWDsj7awY5OhKuCHfsTbiKB2CRZ
	vEx4kufoLuXxkM+EMhq2KsYR0nf8Qd/VExLSCU8jAY/10JQFctQPj8AienUWiaTn
	6fsz2AXEFRvmukubJicnvdOL2glvlbJMdSK/Lr6kOad3vuPt4nCbO8Qh6488Tz7l
	tXVhSAUux5rdM6oNGnW+v9AAhY+YbmMpyGXF5v+eS2Yq1/FayJyoUakkWzQPn01p
	vzwamJr2olNffZCN7Z52A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631532; x=
	1717717932; bh=/hGv3vJEc747DzmJ/9VfAfyTUxjs3kdRF01FRUOE/pw=; b=Q
	vEdmz6X+LcTYjqIsPVViaVBO7b4pvuydIcoggOLl6ZhdsWKTK06FlJ9NU9r2ojIO
	kvd+yMIOsyofVwv80xTWnawc2+NUr9TUgRDWDfx5JN04qnK4Z7PeOyr+4Na9q+x9
	fhtKu0L2tnxHumMAufVoWcryamFqFnW3ZBqBF6wINKz8R6i59CndYwPbIoI9nU6M
	5qJtFTFWrC8OC9jjb/g0kmhKYB9rcoXxC4O1gffBEhFmmVp9x8ctgAV/DXgwudTr
	sOXyHq1NHR5LTljUeKPoqOfRFJCPdlbfwV6XygRukbt3HqfLe/bttV33e4EaC36d
	lJKMTCiI0KCfoYZITgTxQ==
X-ME-Sender: <xms:LPpgZmlrNaGnkmnZJ2tYBXcFYfYhQ-TGiPQQ4pjA-GWo35rB-RdUYg>
    <xme:LPpgZt0tAf1XDkRyHHpj6XE8mnqtovEfuls8DzBVotCXLIQNXa68CQoEmevvkHWC3
    Kw2AzqqNoWCzCMK82Y>
X-ME-Received: <xmr:LPpgZkpt0a2fJt978hHlf6ReZEXzTs7F65yHZrhHLX2SN4zHZ1ZBv-zLyUZEhb-PNO3xTaNiekJ1jbz8Bz2YEebsRWwHZKD0rOnRzI01qYZ7JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:LPpgZqlwd1td5nDgFlBJrfLSNRyQDnW1MAUNCH80nfICdRUKpCVtSg>
    <xmx:LPpgZk2SIudKWyP0YWWVAeaQ18KoClSUXU8c0cVaxsq-jdFcUqUBDQ>
    <xmx:LPpgZhsVDJ-IuwHwn10NfZeCnrO0MhlE8t3QaXMd2rvKqi85duK2fQ>
    <xmx:LPpgZgXQnOR61lIAmNddxTIUAZqRK0zK12Zrqynf_WAjtQDuwphHiA>
    <xmx:LPpgZiC8PvmkuwMgQXq9uw6nzS2-4nUM_Zf4TeSlg0JdzhquZ8OthEI->
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:11 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] firewire: ohci: use helper functions for self ID sequence
Date: Thu,  6 Jun 2024 08:51:50 +0900
Message-ID: <20240605235155.116468-7-o-takashi@sakamocchi.jp>
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

This commit replaces the existing implementation with the helper
functions for self ID sequence.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 77 ++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 0ef76cf7b328..342407d8bc9b 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -41,6 +41,7 @@
 #include "core.h"
 #include "ohci.h"
 #include "packet-header-definitions.h"
+#include "phy-packet-definitions.h"
 
 #define ohci_info(ohci, f, args...)	dev_info(ohci->card.device, f, ##args)
 #define ohci_notice(ohci, f, args...)	dev_notice(ohci->card.device, f, ##args)
@@ -437,11 +438,6 @@ static void log_irqs(struct fw_ohci *ohci, u32 evt)
 						? " ?"			: "");
 }
 
-static unsigned int _p(u32 *s, int shift)
-{
-	return *s >> shift & 3;
-}
-
 static void log_selfids(struct fw_ohci *ohci, int generation, int self_id_count)
 {
 	static const char *const speed[] = {
@@ -451,8 +447,16 @@ static void log_selfids(struct fw_ohci *ohci, int generation, int self_id_count)
 		[0] = "+0W",  [1] = "+15W", [2] = "+30W",    [3] = "+45W",
 		[4] = "-3W",  [5] = " ?W",  [6] = "-3..-6W", [7] = "-3..-10W",
 	};
-	static const char port[] = { '.', '-', 'p', 'c', };
-	u32 *s;
+	static const char port[] = {
+		[PHY_PACKET_SELF_ID_PORT_STATUS_NONE] = '.',
+		[PHY_PACKET_SELF_ID_PORT_STATUS_NCONN] = '-',
+		[PHY_PACKET_SELF_ID_PORT_STATUS_PARENT] = 'p',
+		[PHY_PACKET_SELF_ID_PORT_STATUS_CHILD] = 'c',
+	};
+	struct self_id_sequence_enumerator enumerator = {
+		.cursor = ohci->self_id_buffer,
+		.quadlet_count = self_id_count,
+	};
 
 	if (likely(!(param_debug & OHCI_PARAM_DEBUG_SELFIDS)))
 		return;
@@ -460,29 +464,46 @@ static void log_selfids(struct fw_ohci *ohci, int generation, int self_id_count)
 	ohci_notice(ohci, "%d selfIDs, generation %d, local node ID %04x\n",
 		    self_id_count, generation, ohci->node_id);
 
-	for (s = ohci->self_id_buffer; self_id_count--; ++s)
-		if ((*s & 1 << 23) == 0)
-			ohci_notice(ohci,
-			    "selfID 0: %08x, phy %d [%c%c%c] %s gc=%d %s %s%s%s\n",
-			    *s, *s >> 24 & 63,
-			    port[_p(s, 6)],
-			    port[_p(s, 4)],
-			    port[_p(s, 2)],
-			    speed[*s >> 14 & 3], *s >> 16 & 63,
-			    power[*s >> 8 & 7], *s >> 22 & 1 ? "L" : "",
-			    *s >> 11 & 1 ? "c" : "", *s & 2 ? "i" : "");
-		else
+	while (enumerator.quadlet_count > 0) {
+		unsigned int quadlet_count;
+		unsigned int port_index;
+		const u32 *s;
+		int i;
+
+		s = self_id_sequence_enumerator_next(&enumerator, &quadlet_count);
+		if (IS_ERR(s))
+			break;
+
+		ohci_notice(ohci,
+		    "selfID 0: %08x, phy %d [%c%c%c] %s gc=%d %s %s%s%s\n",
+		    *s,
+		    *s >> 24 & 63,
+		    port[self_id_sequence_get_port_status(s, quadlet_count, 0)],
+		    port[self_id_sequence_get_port_status(s, quadlet_count, 1)],
+		    port[self_id_sequence_get_port_status(s, quadlet_count, 2)],
+		    speed[*s >> 14 & 3], *s >> 16 & 63,
+		    power[*s >> 8 & 7], *s >> 22 & 1 ? "L" : "",
+		    *s >> 11 & 1 ? "c" : "", *s & 2 ? "i" : "");
+
+		port_index = 3;
+		for (i = 1; i < quadlet_count; ++i) {
 			ohci_notice(ohci,
 			    "selfID n: %08x, phy %d [%c%c%c%c%c%c%c%c]\n",
-			    *s, *s >> 24 & 63,
-			    port[_p(s, 16)],
-			    port[_p(s, 14)],
-			    port[_p(s, 12)],
-			    port[_p(s, 10)],
-			    port[_p(s,  8)],
-			    port[_p(s,  6)],
-			    port[_p(s,  4)],
-			    port[_p(s,  2)]);
+			    s[i],
+			    s[i] >> 24 & 63,
+			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index)],
+			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 1)],
+			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 2)],
+			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 3)],
+			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 4)],
+			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 5)],
+			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 6)],
+			    port[self_id_sequence_get_port_status(s, quadlet_count, port_index + 7)]
+			);
+
+			port_index += 8;
+		}
+	}
 }
 
 static const char *evts[] = {
-- 
2.43.0


