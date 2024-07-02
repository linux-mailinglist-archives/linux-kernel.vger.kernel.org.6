Return-Path: <linux-kernel+bounces-238522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD43924B84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 589C9B272D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33B17A59F;
	Tue,  2 Jul 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="WpbYje2d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YoCUocon"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2A1DA30B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958844; cv=none; b=Teil/YGOmdoPl2LS4Bj/ICqaEXCmRX1dReN5GifII/LlZZhczObpoTlSicjj57QreeTT78n/272Vz5zXJ8Rn5jFaoih58Hxa501tAxVJ/0neoPoWpazufX9aNsatmg42qfWDVtqnpQsgc3766BMB50DvvkqAXYg3HUNhH32PfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958844; c=relaxed/simple;
	bh=igV8auFnypklRCHzN9sXLhaA8n/nhB5hXwLqbpBrO/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifur5leXhv7+rU0VN7Bi6cKv8lcf86YJyco938OsMlPsXL4/A0LqKtIaEWQOS9kp76VyHXISXYou5JASTpMFx0vBgPInhAWnduXwL1KwEUh6UGIBu7G8a00uMYCB0Ej3kV3Ez03P+lvgrLqZyUl4dV922bFdCRCFDPjv+t2ft7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=WpbYje2d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YoCUocon; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id EF282138029E;
	Tue,  2 Jul 2024 18:20:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Jul 2024 18:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719958841; x=
	1720045241; bh=etDpKLQEG9p50XNu4SoX4u7Bb/CdovZOaSYuiOBy3+I=; b=W
	pbYje2dXayXePLYb8bBbUOX1tFV5QSEYRDUuXKTFfCRFhf6msYQldwzN/b73dATJ
	O2DaZ0V0k9iKJytVwpXNESW48Rv1sxeBhxHM3fBJ6PWdQxa1N1Tj0JJkZ7+wzEC0
	1VTX5CHV4TTDTjHZfH/5SpxoU2J+Of8vi2cOipWZRlkGREdYm7LI9Ok6gh0y8+qX
	9Oki0j8F5rEWIw21a57xiJO4q83V7rdUhINwvU12GrTevo2VNcdY99dek7Cbc7dH
	y8jEYeBNZohZZsTbfpjayyJR1DOkQnDqkb6EdjIe9Hw/Kv6W5F1ypeejFp7fV/7f
	YG6becVhIxq6tQMMWOWMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719958841; x=
	1720045241; bh=etDpKLQEG9p50XNu4SoX4u7Bb/CdovZOaSYuiOBy3+I=; b=Y
	oCUoconE5n1sy1F2V7k3/L5fV7cPd68p3kBJJN3HGkX4Hheo943yY4hWzzJyifLl
	rLxkwZDEnRHzNRlsEZycXvjCVE9NJvggMy0Bakr9VXTNxZ4XeNObw9Nx758reuY4
	OXGp3Rr0/vEA45DKuRLkJFTk1WQilSNIWfEaqKNDt5IuOHI8XiaiWmmTVCpoNMle
	J1f+kjKUavmTYmZXTkLEiTFQpRzhkeOyDypz3IKKDOFfO8Y6v1yXdfC0lUjH+lLX
	zWGhvNpsT+iaQUV8iLkUg8J8VPxJ8qIek8rIg6F04sntDc8ZzOYqlO4t3SE2t0jZ
	v/sKoOtfMmriheuVQoMaw==
X-ME-Sender: <xms:OX2EZgbZI7qQmwaICFr3kGu-LSfZwO9XMeiVqk1HLPnfNbKcbYJ2Cg>
    <xme:OX2EZrbnvAMZ5Sb-8mW4P48tFitRWfxX3WPlmFI0yHjMF0LYIL-QO6gq4jyjjzWIm
    uNCzatxnEKOjdzoVog>
X-ME-Received: <xmr:OX2EZq-ExLY3oLykeCRywqy3PLMk3mRQraD0ZRyfeSjmGo9V7vHEsus5sno1EV-k6gQtZUnpjKrXTweBK0ZksTQyZ726hJ1JGZyxPUQeN1P1nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:OX2EZqokGbkkDTQYGjUpDaArh8nw51eFnAjDkSl6XNY3RwDzfkPAPQ>
    <xmx:OX2EZrocodv-2kP735u9sOpC7Hrlzlstd9NL87PHZDJ7JkaGo3dgpw>
    <xmx:OX2EZoTzxouYMvbDuZZmd5vrLnPkPZLnKgHBjOXSdxBsabNXDoWX_A>
    <xmx:OX2EZrrYy6pYrI2TFhZyZ6yY54HGCehB7In9yg6LT8NDWq1QEdE8BA>
    <xmx:OX2EZi1HScrfGDEDfKjzjImIu2j5NEGrQ8e2XBGC894lyfW1vpLpypV->
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 18:20:40 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] firewire: ohci: use static function to handle endian issue on PowerPC platform
Date: Wed,  3 Jul 2024 07:20:31 +0900
Message-ID: <20240702222034.1378764-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
References: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is preferable to use static function instead of functional macro in
some points. It checks type of argument, but would be optimized to
embedded code instead of function calls.

This commit obsoletes the functional macro with the static function.
Additionally this commit refactors quirk detection to ease the later work.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index a2d6d1d1ec2b..5b90ca72fa64 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -875,10 +875,25 @@ static void ar_sync_buffers_for_cpu(struct ar_context *ctx,
 }
 
 #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_PPC32)
-#define cond_le32_to_cpu(v) \
-	(ohci->quirks & QUIRK_BE_HEADERS ? be32_to_cpu(v) : le32_to_cpu(v))
+static u32 cond_le32_to_cpu(__le32 value, bool has_be_header_quirk)
+{
+	return has_be_header_quirk ? be32_to_cpu(value) : le32_to_cpu(value);
+}
+
+static bool has_be_header_quirk(const struct fw_ohci *ohci)
+{
+	return !!(ohci->quirks & QUIRK_BE_HEADERS);
+}
 #else
-#define cond_le32_to_cpu(v) le32_to_cpu(v)
+static u32 cond_le32_to_cpu(__le32 value, bool has_be_header_quirk __maybe_unused)
+{
+	return le32_to_cpu(value);
+}
+
+static bool has_be_header_quirk(const struct fw_ohci *ohci)
+{
+	return false;
+}
 #endif
 
 static __le32 *handle_ar_packet(struct ar_context *ctx, __le32 *buffer)
@@ -888,9 +903,9 @@ static __le32 *handle_ar_packet(struct ar_context *ctx, __le32 *buffer)
 	u32 status, length, tcode;
 	int evt;
 
-	p.header[0] = cond_le32_to_cpu(buffer[0]);
-	p.header[1] = cond_le32_to_cpu(buffer[1]);
-	p.header[2] = cond_le32_to_cpu(buffer[2]);
+	p.header[0] = cond_le32_to_cpu(buffer[0], has_be_header_quirk(ohci));
+	p.header[1] = cond_le32_to_cpu(buffer[1], has_be_header_quirk(ohci));
+	p.header[2] = cond_le32_to_cpu(buffer[2], has_be_header_quirk(ohci));
 
 	tcode = async_header_get_tcode(p.header);
 	switch (tcode) {
@@ -902,7 +917,7 @@ static __le32 *handle_ar_packet(struct ar_context *ctx, __le32 *buffer)
 		break;
 
 	case TCODE_READ_BLOCK_REQUEST :
-		p.header[3] = cond_le32_to_cpu(buffer[3]);
+		p.header[3] = cond_le32_to_cpu(buffer[3], has_be_header_quirk(ohci));
 		p.header_length = 16;
 		p.payload_length = 0;
 		break;
@@ -911,7 +926,7 @@ static __le32 *handle_ar_packet(struct ar_context *ctx, __le32 *buffer)
 	case TCODE_READ_BLOCK_RESPONSE:
 	case TCODE_LOCK_REQUEST:
 	case TCODE_LOCK_RESPONSE:
-		p.header[3] = cond_le32_to_cpu(buffer[3]);
+		p.header[3] = cond_le32_to_cpu(buffer[3], has_be_header_quirk(ohci));
 		p.header_length = 16;
 		p.payload_length = async_header_get_data_length(p.header);
 		if (p.payload_length > MAX_ASYNC_PAYLOAD) {
@@ -936,7 +951,7 @@ static __le32 *handle_ar_packet(struct ar_context *ctx, __le32 *buffer)
 
 	/* FIXME: What to do about evt_* errors? */
 	length = (p.header_length + p.payload_length + 3) / 4;
-	status = cond_le32_to_cpu(buffer[length]);
+	status = cond_le32_to_cpu(buffer[length], has_be_header_quirk(ohci));
 	evt    = (status >> 16) & 0x1f;
 
 	p.ack        = evt - 16;
@@ -2030,12 +2045,12 @@ static void bus_reset_work(struct work_struct *work)
 		return;
 	}
 
-	generation = (cond_le32_to_cpu(ohci->self_id[0]) >> 16) & 0xff;
+	generation = (cond_le32_to_cpu(ohci->self_id[0], has_be_header_quirk(ohci)) >> 16) & 0xff;
 	rmb();
 
 	for (i = 1, j = 0; j < self_id_count; i += 2, j++) {
-		u32 id  = cond_le32_to_cpu(ohci->self_id[i]);
-		u32 id2 = cond_le32_to_cpu(ohci->self_id[i + 1]);
+		u32 id  = cond_le32_to_cpu(ohci->self_id[i], has_be_header_quirk(ohci));
+		u32 id2 = cond_le32_to_cpu(ohci->self_id[i + 1], has_be_header_quirk(ohci));
 
 		if (id != ~id2) {
 			/*
-- 
2.43.0


