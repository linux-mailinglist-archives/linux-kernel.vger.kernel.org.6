Return-Path: <linux-kernel+bounces-265864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE393F6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B228D1C21B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA3815534D;
	Mon, 29 Jul 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="rNoMVBIV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRfRQM55"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0161514F8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260802; cv=none; b=Fmz0hABqwy7Gatp4NbbwJUGJL204ujjf6cEWFU3UFoYI855tHyxr5GsK9ecuwH9Z4/UFc9EBjvbaoTRp35C0G/9wtYUxjgQvNFDcHCNTeh+uCUGfZCEL7hKPGA/SkjzlzNxUznCCuOiFRy99fTMIE36fRvEpU9Bhf5CL+uo8LAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260802; c=relaxed/simple;
	bh=CypZyBAmur8jk1dMIRMI/JD+8QpCn7AnNr+0wvRzl8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4dob6xstZO04j4/+iq5o5iA1qZotFmZSpOfutcWWuzzHHreLTKJ9NtAUkUT8afGM2JCoCuPEtSk9E87v85MkCJzy0z1yLAuBfwKrRRrSkl/mP6N6BOT+89VkaV3fUdccRQecPpOmYV1vWDBX1eKrriDeCKy2l/SLbTd5warwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=rNoMVBIV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRfRQM55; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9635F13801DC;
	Mon, 29 Jul 2024 09:46:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Jul 2024 09:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722260799; x=
	1722347199; bh=U5rod4RFqqD1jbS5LRRa2T3sPIulvkc5tgqY5IiVoIQ=; b=r
	NoMVBIVIN9jiii48x1LG/QTqho54xKGnlT2/NCByyNPQLNm+hXllHuHW1pgniabU
	3ST42kxzKnp3jDdwRhZOdUHgUuzAGiQI7J201XV5+lQQo/d3K40PAmlLlS71wuMO
	H8JMuY0ZfTFL7YCIYwThKuNKbdnzVTryYcQ0BDB/LG6u9Jcib6Sr9xb/Uw4To5pj
	QOcVPltJScrvAG48w63NGAX9Lny+C0n29DAOf2zRsmNoeyCH7jFrg77QevwkkndP
	s9kbNs7zUn7YtOHN4epkcjrzNPap0OJLcmSAvPWel/KUb2YylijCe2uZcEIezrXT
	F35QA2n7MUziAvi1DUtog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722260799; x=
	1722347199; bh=U5rod4RFqqD1jbS5LRRa2T3sPIulvkc5tgqY5IiVoIQ=; b=K
	RfRQM55xCLgw5MYHyDzB9vbRQx9qUi2z1+P6/md8EBK1AEA4A6y8tHzVT5ikgU6/
	LXtnSoUKycysmI/E+pQec/I8cgGEEhEKrwENPbZ+e9x953L0T8t+rZBF4ZH9jTyh
	02uLsVv6xfn3+gC3ABT0wfYI9B7/GzANqA0M6/y3u4yLz9u2bnfgvOcql7s8j8e7
	tPcanwizvT5wzwhtMFDhfdf1QXgBKynLGCm1U/Mj81nGqvto8X2txmOkIVyhUxyt
	K9OjMF5zpwrEjnLArCaLH2/JR3h7OwWvTudc3MV+FlrK7N8NZahRm5Q4KsIe1WtJ
	79SsuefXKEnUNzRLDiUuQ==
X-ME-Sender: <xms:P52nZuaWVWt3LzaTcuKi9lWce78zuQwk1s6gyMmG2YBqZ4m6ddZFxw>
    <xme:P52nZhYAAnHRxTfCsLvwGhzsM4xh1IR4_el-CgkqrBUqK_7H_rdXJ3a2iXHS6DmV3
    DRKGhBfG9jFMUWBVY8>
X-ME-Received: <xmr:P52nZo8llgk6eirBR1sifIZ007IJgg-RnJjbg2Q7OwYBe3OpK8H4tTWlzlCbM7BU_AJTBzJYjow-lsgNwFGHoM94oNHXlfJ-mkE9jNAIsBbZZuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:P52nZgrkY-HryAyZE8Fn6aFVBBLqHQMMNl4cpIIKHoBIc6X97NDImw>
    <xmx:P52nZprY5Nfp4yc_WoPX1TU9UP64kD1wAq1kSBnwUBETD_IUgTaTcw>
    <xmx:P52nZuQx6UGwTpiueD3VXDN4QZBfDXzCd7QdbnTW0d6A9-4-PqIBrQ>
    <xmx:P52nZpqn6rsdvZYMlWU3eu7i-JEo1gTOWaV_BZqaz5We_mPHDtC9_w>
    <xmx:P52nZg2fFKgW-ls48ZQp-msFato5uLNag07d0MzKgoox38Mu8_vXwzG_>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 09:46:37 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] firewire: ohci: minor code refactoring to localize text table
Date: Mon, 29 Jul 2024 22:46:30 +0900
Message-ID: <20240729134631.127189-3-o-takashi@sakamocchi.jp>
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

The string table for tcode is just used by log_ar_at_event(). In the case,
it is suitable to move the table inner the function definition.

This commit is for the purpose. Additionally, the hard-coded value for
tcode is replaced with defined macros as many as possible.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index c3fff94b13e5..a0bb0e87e18a 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -531,20 +531,28 @@ static const char *evts[] = {
 	[0x1e] = "ack_type_error",	[0x1f] = "-reserved-",
 	[0x20] = "pending/cancelled",
 };
-static const char *tcodes[] = {
-	[0x0] = "QW req",		[0x1] = "BW req",
-	[0x2] = "W resp",		[0x3] = "-reserved-",
-	[0x4] = "QR req",		[0x5] = "BR req",
-	[0x6] = "QR resp",		[0x7] = "BR resp",
-	[0x8] = "cycle start",		[0x9] = "Lk req",
-	[0xa] = "async stream packet",	[0xb] = "Lk resp",
-	[0xc] = "-reserved-",		[0xd] = "-reserved-",
-	[0xe] = "link internal",	[0xf] = "-reserved-",
-};
 
 static void log_ar_at_event(struct fw_ohci *ohci,
 			    char dir, int speed, u32 *header, int evt)
 {
+	static const char *const tcodes[] = {
+		[TCODE_WRITE_QUADLET_REQUEST]	= "QW req",
+		[TCODE_WRITE_BLOCK_REQUEST]	= "BW req",
+		[TCODE_WRITE_RESPONSE]		= "W resp",
+		[0x3]				= "-reserved-",
+		[TCODE_READ_QUADLET_REQUEST]	= "QR req",
+		[TCODE_READ_BLOCK_REQUEST]	= "BR req",
+		[TCODE_READ_QUADLET_RESPONSE]	= "QR resp",
+		[TCODE_READ_BLOCK_RESPONSE]	= "BR resp",
+		[TCODE_CYCLE_START]		= "cycle start",
+		[TCODE_LOCK_REQUEST]		= "Lk req",
+		[TCODE_STREAM_DATA]		= "async stream packet",
+		[TCODE_LOCK_RESPONSE]		= "Lk resp",
+		[0xc]				= "-reserved-",
+		[0xd]				= "-reserved-",
+		[TCODE_LINK_INTERNAL]		= "link internal",
+		[0xf]				= "-reserved-",
+	};
 	int tcode = async_header_get_tcode(header);
 	char specific[12];
 
-- 
2.43.0


