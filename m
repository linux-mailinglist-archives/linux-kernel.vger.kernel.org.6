Return-Path: <linux-kernel+bounces-203425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5FE8FDAF0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25417283D76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD72168C21;
	Wed,  5 Jun 2024 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ZchT7BhK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OsebbhZq"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955516C864
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631532; cv=none; b=BnPJsC80s2xWEcKWmgZ4zGxo8cAwkrern2CrOkbzJoMFTNT6knzg8UCneVwGc8Z9kC0Y1BolJONTTlnvzIB/fy7zf4DFzGWDRzIdNMgooFg0Wc8rTG2ya+aiEDZKG0kcmy1oGCMZlQDQp4PXap4L6Lf+FOAHU23m5uYeGypO/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631532; c=relaxed/simple;
	bh=CcTJ2hXsAQcrYr0T8FwNXmr1zWjQFOatTtsGZ7PucoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVCLY//zUSTykIgTiOlrOMr2kF+7iE/Rd5KQRWYYDNjLf3zawv0fGSIzYxGHXKNpNqxo/DTkw7xInKUXkA2/DEpmfyXCx3UkTtteUgZWrdOVq69nRvvgtWGH0kVIK1dkHcphJQR3fmXu7pK3eVmuB6TpA5ON7gsph2Yd01B9Z+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ZchT7BhK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OsebbhZq; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id EF056180012C;
	Wed,  5 Jun 2024 19:52:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 19:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631528; x=
	1717717928; bh=bWof0tvW+gB1Bs1dWeYtyZYYo8ZfFi7RpvNi77t2sIw=; b=Z
	chT7BhKOt27y3TKOHYIUMg0hooTAw2Uyqkf3nlGn3wTe8Bv60tQSC4rr7gIwMYX6
	b3WoYDZPzQTRh9wTbBFNZ3fbPuRWA8WygjlcXGCnIear2oA5PwYsNQuY3Aqbjwg0
	IZsZziYRrzNCzOMbyndGchTuiHGML6UsslxfP7tLuPe7DB/vgeJixmJHNT+J49t2
	YP9Nl95hRFEwigziM/nJqwrYrVnYTBC05FlGyMpZ5cmd+i99KrGBJkGTvnH6g6xN
	W7MS1TqLn87jKQTTmRAL6mpVqdba6GgR7Dh7TMJ4kVq0ciIb0FZjZ78pRj7/te0N
	OvxEkjmBxKuJZds/V5WJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631528; x=
	1717717928; bh=bWof0tvW+gB1Bs1dWeYtyZYYo8ZfFi7RpvNi77t2sIw=; b=O
	sebbhZqZXNcq3iVeTaH+nChpBD1mTI8Sq7uOOv10+bxDC1DJYKlfDwqVoqrx1pjK
	p7z2uBCnUUERHbAbjN5nmidcaCjAgSRGO8N5UWp1oZHD/cr6k6+JpdQ/6pVWrASN
	3g/suDQ49X7Gem5COz0EIRxYRmT8w05wgg5dzEU+dFMqHdmR+VDb4ux6Ktee8/DQ
	CkLTRoHCOLuD9YejUHaf+3tD19MCCD5Xfn9kqt5DLY1SqWfaBDeaUpLnHIa1d7Io
	W28sFtxQNf08SQj9T6ZeUB/G4XBghqEGEWIxhC933DadP2ldrcWacOEqAXkrrv3U
	nslMoR+enev1SuJqGZAQQ==
X-ME-Sender: <xms:KPpgZm11hEVDyisCC7b6bC4GMOjY5usPAK2fpYc1AtzIqngI4A_nFg>
    <xme:KPpgZpEJWKm-7RIJDEnRn4OLvQhCQ2s6Lzuh_H4lAUOHMjXhhb4rS4J6abPBA3YeO
    kMk1fWF7jHx61kk5QQ>
X-ME-Received: <xmr:KPpgZu6wILpLy9Q8W3sJoyYCIWIFaCYkDakaFSZ809D_Mgh_1OcJ8JzOiNWs194zY9vSeNLIXaQ5DFF3u89zoniM-ajxzhnCcVVifrRO5y4iiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:KPpgZn2VLGPYpNJNxpLMyZ8_9Lw3wjiJXCxkl9oU_NEhdlNtq2p3qw>
    <xmx:KPpgZpG4ybl3qwl9Y7-Gh3VpMJQlNuxnw6ZZSPpeDnaqJlO6XDnlHA>
    <xmx:KPpgZg94SLsCjYS7M0NKm88b83gm4MVF8aVE-kNBTCql91pxoq5rJA>
    <xmx:KPpgZukpKvwrYUra2NOvYMivCFDHFpqWw6X6yTQ4mZt2yvJssGe5YQ>
    <xmx:KPpgZuTmYrUVyURB23wdndp6P_K634jgWPoFaBTkVhINKRKhBntyqtuG>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:07 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] firewire: ohci: minor code refactoring for self ID logging
Date: Thu,  6 Jun 2024 08:51:48 +0900
Message-ID: <20240605235155.116468-5-o-takashi@sakamocchi.jp>
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

Current implementation to log self ID sequence has the rest to be
refactored; e.g. moving translation-unit level variables to the
dependent block.

This commit is for the purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index f6de0b3a9a55..0ef76cf7b328 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -437,22 +437,21 @@ static void log_irqs(struct fw_ohci *ohci, u32 evt)
 						? " ?"			: "");
 }
 
-static const char *speed[] = {
-	[0] = "S100", [1] = "S200", [2] = "S400",    [3] = "beta",
-};
-static const char *power[] = {
-	[0] = "+0W",  [1] = "+15W", [2] = "+30W",    [3] = "+45W",
-	[4] = "-3W",  [5] = " ?W",  [6] = "-3..-6W", [7] = "-3..-10W",
-};
-static const char port[] = { '.', '-', 'p', 'c', };
-
-static char _p(u32 *s, int shift)
+static unsigned int _p(u32 *s, int shift)
 {
-	return port[*s >> shift & 3];
+	return *s >> shift & 3;
 }
 
 static void log_selfids(struct fw_ohci *ohci, int generation, int self_id_count)
 {
+	static const char *const speed[] = {
+		[0] = "S100", [1] = "S200", [2] = "S400",    [3] = "beta",
+	};
+	static const char *const power[] = {
+		[0] = "+0W",  [1] = "+15W", [2] = "+30W",    [3] = "+45W",
+		[4] = "-3W",  [5] = " ?W",  [6] = "-3..-6W", [7] = "-3..-10W",
+	};
+	static const char port[] = { '.', '-', 'p', 'c', };
 	u32 *s;
 
 	if (likely(!(param_debug & OHCI_PARAM_DEBUG_SELFIDS)))
@@ -465,7 +464,10 @@ static void log_selfids(struct fw_ohci *ohci, int generation, int self_id_count)
 		if ((*s & 1 << 23) == 0)
 			ohci_notice(ohci,
 			    "selfID 0: %08x, phy %d [%c%c%c] %s gc=%d %s %s%s%s\n",
-			    *s, *s >> 24 & 63, _p(s, 6), _p(s, 4), _p(s, 2),
+			    *s, *s >> 24 & 63,
+			    port[_p(s, 6)],
+			    port[_p(s, 4)],
+			    port[_p(s, 2)],
 			    speed[*s >> 14 & 3], *s >> 16 & 63,
 			    power[*s >> 8 & 7], *s >> 22 & 1 ? "L" : "",
 			    *s >> 11 & 1 ? "c" : "", *s & 2 ? "i" : "");
@@ -473,8 +475,14 @@ static void log_selfids(struct fw_ohci *ohci, int generation, int self_id_count)
 			ohci_notice(ohci,
 			    "selfID n: %08x, phy %d [%c%c%c%c%c%c%c%c]\n",
 			    *s, *s >> 24 & 63,
-			    _p(s, 16), _p(s, 14), _p(s, 12), _p(s, 10),
-			    _p(s,  8), _p(s,  6), _p(s,  4), _p(s,  2));
+			    port[_p(s, 16)],
+			    port[_p(s, 14)],
+			    port[_p(s, 12)],
+			    port[_p(s, 10)],
+			    port[_p(s,  8)],
+			    port[_p(s,  6)],
+			    port[_p(s,  4)],
+			    port[_p(s,  2)]);
 }
 
 static const char *evts[] = {
-- 
2.43.0


