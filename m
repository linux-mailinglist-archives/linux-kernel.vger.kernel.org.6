Return-Path: <linux-kernel+bounces-213271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F39D907357
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F981C20F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907EC145A02;
	Thu, 13 Jun 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="hiJJOTKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jAMC1sPR"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962F144D15
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284497; cv=none; b=HC99hXWnaN6ucMfu703RL98+cHMIKQrKkYDo0FWsALoS3qA6kUy+K3zLs9Nk03nkANmEFWOVnZcm/6TmaXrpH/1kvxhrvrs13ueU3grN8/s1bRH5NJF8wSpT0BJdoYPCHvOVghTzlLuc8jsfwV54xjgljby0cfbvCr/i2gvjegg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284497; c=relaxed/simple;
	bh=zj6JtbVTTviJo7WTtMwH2lictg2VkxG4N+wyZkqqFEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSWBRzXd2fMzdwDOIDNvhxSDipXVOXPrx25A+t56LYy7WC69JAFA6jlpqRK5I1H5DmaBOR2StrB3XdP4sUF4FciozrczzBiorl6fHowRbmVjiRcIjBTY6maeMNvsXWmF5CJpCAAoqCyusNQzy13MYwKNjfk3HtYmEzR8/E0FqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=hiJJOTKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jAMC1sPR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id D656E13800ED;
	Thu, 13 Jun 2024 09:14:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 09:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718284494; x=
	1718370894; bh=rCStrtW4Fkq1R+S/nsCfskDATiiOElcsAJ727pxmbL8=; b=h
	iJJOTKa2tZ1Cwbrg/PQHqLF5kjBr5bkzpp4/pvc6YSox9/nqp2CLfqEJZ/WiY1GQ
	rLmSNxsno4EZCMcB8NDFHmFPXV26LA2qmC1RCeF5O4C/jYezt84Qdytf+9rggTab
	nTNWvBxY42hdofgIzn+iPokkQC1kFzZKTCygDg8WrwvPTvsaUdEr7ncgce/JFb2g
	95V79AKut7GsOOaeql82shKoX1An0DsQ9ExTUHujeCn5r5R/pCfzpF3ABmdJ4yIG
	394U+8ad1Ol1sfS+8fUN6WGxIuSPQLH8iTqXHPO5b5vPdU4TutKb+Sl9RdsAqYWI
	Elh2j8fVDr7nCQLmyQi9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718284494; x=
	1718370894; bh=rCStrtW4Fkq1R+S/nsCfskDATiiOElcsAJ727pxmbL8=; b=j
	AMC1sPRhsp7OfSe23FR/2d5Ifjf20WGjG+J3a6UKLd32/Ix/DPeSSrcpnn0RoQdN
	q7EuedSAGUA3CXKym2Dnk5Ybryz0kzI8N2hAyvwwOSwWlD2CH3tIiGgurZ8tVcA6
	bk+dWVeZM1Ja3BsnM0wIFdJAbgLcVs1/kbl9WT498Vgw6VESMb0+Eo2lR0dPbG5M
	rVbhexA1DoUko/xbvmgMs7vxe2C/Qgq02oS159sJfKCknrM9knVc042/d2jVC07h
	oTUPoFpe2/+Cbgt4tZaoUAs49BJD0icOB9S+lg281szE+oOhxhiRVUrnGYA103hf
	J8rlrh02XjiGGVv1NdioQ==
X-ME-Sender: <xms:zvBqZrgGp2uJG1DaChBAEG7zqdZIYFwaLcrHGPNhsCUbF4b4_q4uhg>
    <xme:zvBqZoBIve-NX3_WYWneP_aycdeb6zfMv_hN6GPmeGe4OlrCd_b2t_IeheUs3x6yf
    arLqVD7XQNN4wOMZ94>
X-ME-Received: <xmr:zvBqZrE2G_DWCgnzGIu310pEJBFlpT6TcLt9UmdnLn7Lwl6xJhbLrboILLFNhbfKtbigOl4iUKxrRb7aGezO6EIWzeB4daE7nOF7eCSKvm3Khw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:zvBqZoS7yNxCFbh9eNpRDTz7jbQzixRTMXMaQ1CWUz2zA1WkBfq-3Q>
    <xmx:zvBqZowz5OvWkZvu69cB65liFjZ9JDSZQmMez7IsJiCh6XG92ioi4g>
    <xmx:zvBqZu5WcOT5IflqjEzGQPmpYBaGUwVCMhKXlCnuW7BXEj18wn-xuw>
    <xmx:zvBqZtxo9CtxjOs5zE0e4jESUfITZCS8f3Jw4i0MtAkXU7E-3-h9jA>
    <xmx:zvBqZj-mdUjf8tlf2CiKhc589n1YxsBFf8jfWtTefsQvEFmGgOHH2IGQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 09:14:53 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] firewire: core: record card index in tracepoinrts events derived from bus_reset_arrange_template
Date: Thu, 13 Jun 2024 22:14:39 +0900
Message-ID: <20240613131440.431766-8-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613131440.431766-1-o-takashi@sakamocchi.jp>
References: <20240613131440.431766-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The asynchronous transmission of phy packet is initiated on one of 1394
OHCI controller, however the existing tracepoints events has the lack of
data about it.

This commit adds card_index member into event structure to store the index
of host controller in use, and prints it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c    |  6 +++---
 include/trace/events/firewire.h | 21 ++++++++++++---------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 127d87e3a153..f8b99dd6cd82 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -222,14 +222,14 @@ static int reset_bus(struct fw_card *card, bool short_reset)
 	int reg = short_reset ? 5 : 1;
 	int bit = short_reset ? PHY_BUS_SHORT_RESET : PHY_BUS_RESET;
 
-	trace_bus_reset_initiate(card->generation, short_reset);
+	trace_bus_reset_initiate(card->index, card->generation, short_reset);
 
 	return card->driver->update_phy_reg(card, reg, 0, bit);
 }
 
 void fw_schedule_bus_reset(struct fw_card *card, bool delayed, bool short_reset)
 {
-	trace_bus_reset_schedule(card->generation, short_reset);
+	trace_bus_reset_schedule(card->index, card->generation, short_reset);
 
 	/* We don't try hard to sort out requests of long vs. short resets. */
 	card->br_short = short_reset;
@@ -249,7 +249,7 @@ static void br_work(struct work_struct *work)
 	/* Delay for 2s after last reset per IEEE 1394 clause 8.2.1. */
 	if (card->reset_jiffies != 0 &&
 	    time_before64(get_jiffies_64(), card->reset_jiffies + 2 * HZ)) {
-		trace_bus_reset_postpone(card->generation, card->br_short);
+		trace_bus_reset_postpone(card->index, card->generation, card->br_short);
 
 		if (!queue_delayed_work(fw_workqueue, &card->br_work, 2 * HZ))
 			fw_card_put(card);
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index e5524fc71880..e6485051f546 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -303,36 +303,39 @@ TRACE_EVENT(async_phy_inbound,
 );
 
 DECLARE_EVENT_CLASS(bus_reset_arrange_template,
-	TP_PROTO(unsigned int generation, bool short_reset),
-	TP_ARGS(generation, short_reset),
+	TP_PROTO(unsigned int card_index, unsigned int generation, bool short_reset),
+	TP_ARGS(card_index, generation, short_reset),
 	TP_STRUCT__entry(
+		__field(u8, card_index)
 		__field(u8, generation)
 		__field(bool, short_reset)
 	),
 	TP_fast_assign(
+		__entry->card_index = card_index;
 		__entry->generation = generation;
 		__entry->short_reset = short_reset;
 	),
 	TP_printk(
-		"generation=%u short_reset=%s",
+		"card_index=%u generation=%u short_reset=%s",
+		__entry->card_index,
 		__entry->generation,
 		__entry->short_reset ? "true" : "false"
 	)
 );
 
 DEFINE_EVENT(bus_reset_arrange_template, bus_reset_initiate,
-	TP_PROTO(unsigned int generation, bool short_reset),
-	TP_ARGS(generation, short_reset)
+	TP_PROTO(unsigned int card_index, unsigned int generation, bool short_reset),
+	TP_ARGS(card_index, generation, short_reset)
 );
 
 DEFINE_EVENT(bus_reset_arrange_template, bus_reset_schedule,
-	TP_PROTO(unsigned int generation, bool short_reset),
-	TP_ARGS(generation, short_reset)
+	TP_PROTO(unsigned int card_index, unsigned int generation, bool short_reset),
+	TP_ARGS(card_index, generation, short_reset)
 );
 
 DEFINE_EVENT(bus_reset_arrange_template, bus_reset_postpone,
-	TP_PROTO(unsigned int generation, bool short_reset),
-	TP_ARGS(generation, short_reset)
+	TP_PROTO(unsigned int card_index, unsigned int generation, bool short_reset),
+	TP_ARGS(card_index, generation, short_reset)
 );
 
 TRACE_EVENT(bus_reset_handle,
-- 
2.43.0


