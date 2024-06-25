Return-Path: <linux-kernel+bounces-228250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A54915D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC3D1F21B84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7054F52F6D;
	Tue, 25 Jun 2024 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="TYiX2QH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NPCpq3Ea"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C94433CB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285496; cv=none; b=JdOWbetOPzOdnZvqHmEPFIHhT6JOkqFDRUuxy+thGpP7OOMDOCcYnypQKg8ndn3N/K4sZd6bTqxSGbGHlgyKQN5LndPl49WuBs5BZYJBVOOXL2mFwCeHTqb3gfD+j5r3ABiozSqxpOVRE44/wVC5K5DNSSxEUQB+t+rd4eKe+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285496; c=relaxed/simple;
	bh=TEIzI4v54LpbFPztuwFa8Mu6aoSZxY7d7Q3K+lgY9us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nr/PoRsSA/xa8PgSXVYdSsSfdzpx0WP2V9Gt0BBczPwMLXhJZOy41xu33zPjBpoIljjMYEoxrY0VAEN5glhhl23OklPU/fMc/9H4ddkwZ+yoN2CxDSknutAcNizbdy2OE02m0Ps4TjWJA2DCeidCrSsOhkS7EHZQUH/7FBPJ0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=TYiX2QH8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NPCpq3Ea; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id E8FAC13800F0;
	Mon, 24 Jun 2024 23:18:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 24 Jun 2024 23:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719285493; x=
	1719371893; bh=mSPkcXLIXHxec9tFgIIwhVMkJhD9BeYdevEsnZ7PZ/o=; b=T
	YiX2QH8Kz4C3qWWd/SVcj8XJqiQxjMOWQGHbIb3zeyP5MUtvTBENQG88UommJIKC
	4mJbIYcIKsrkg/MTCySdpDBXv7yDIbfLNA6iosughbGPk7/ZlY0yfokNYnq6Dt9i
	EwpfitJJ2ZtL+xHDBJ1J0K0VVqMje+vZ5Urpiu94so/YNVw/RRZjg5dslRnOyFNH
	MoPJ4Tc9+7jR1Q8rDEDWn2yN9Yn9jEoXm6PMw/ZY/nDtNygcoBSOf1b8HG+1qRz9
	sr4cArnVbr5PiADZviRtiykGQmjziFylYIG/tIQQy6FbpKbtxFxSpfW8DR7QvGEt
	RdDsguMtZAYeZ4TG6F2MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719285493; x=
	1719371893; bh=mSPkcXLIXHxec9tFgIIwhVMkJhD9BeYdevEsnZ7PZ/o=; b=N
	PCpq3EahVlcRjdX/gxyy0xfINKTn1Q99ymb/s6F0J7nno0YHBA6Dw3Q4gKYinfgy
	XjB58sVAeqp9h0wizEujcLzEnaYgX8QeWDR9nqpR/3/pcAh9d2EbhDW5UJyHeGp3
	0V9Z4dWbkYBAEtwXU0Jt51ikx/iVdwyO1U47A5kC/tPZK+F6JVaWv2uqSxd2/WRp
	L9AvXtTpejFbzBpp8kCrIVZdEmn+03raDjhVuCEzpE6lk7dk0+V8POUQSr9ZSbD4
	einRzgAM1H444qNnY0a8RjngWrWpakJJtH9t2eorPk2dylJyXVpznIrOVLdZgUPj
	hYvvcjsgQnjJtL1MLFQWw==
X-ME-Sender: <xms:9TZ6ZiZbCUdOhBXEA4l0st7YXdJG1HzoPWIifjAI89Uu-Ey4TZAszQ>
    <xme:9TZ6ZlYP3ulJmrDrlDOD1bAIHwH6Vkir6WHwVPMxklSigCudPYkV_jEaWKRUWPsw3
    eQIgLKSeGWrkT_RAZs>
X-ME-Received: <xmr:9TZ6Zs8j_MO7mK0CNaa0KL3vTFUD5eEjaS3asm3UlD-KsIXDEIlFgaFXuAU0eZpw5INweWpxfOCEMWWMYnfkS4_osi27qWzzD7XhmQH83v8sbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:9TZ6ZkqlPsT9KrBmCQ_0GLEHyB6zAb4NPnEoNxaq8SrNMtghAamGow>
    <xmx:9TZ6ZtqgqJ_yBhFP8UETHzy2Pi-t9GBiXXPrhthURHSx10DmXN0JeA>
    <xmx:9TZ6ZiT1LlFiwzuCEslaFg_ab5jVj7anfKaSnVTRvYWLzjzm7x1IUA>
    <xmx:9TZ6ZtpJCmnlc8uWSOpY2hHVAllzcJAbAGtlGrZ_q2VVVqpReiQnGA>
    <xmx:9TZ6Zk0v8bK0sL4aNRqJJGdDl7AmVVrijMs4AWPh6oJr8QXPYqKAxwOW>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 23:18:12 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firewire: ohci: add tracepoints event for hardIRQ event
Date: Tue, 25 Jun 2024 12:18:06 +0900
Message-ID: <20240625031806.956650-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625031806.956650-1-o-takashi@sakamocchi.jp>
References: <20240625031806.956650-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1394 OHCI hardware triggers PCI interrupts to notify any events to
software. Current driver for the hardware is programmed by the typical
way to utilize top- and bottom- halves, thus it has a timing gap to handle
the notification in softIRQ (tasklet).

This commit adds a tracepoint event for the hardIRQ event. The comparison
of the tracepoint event to tracepoints events in firewire subsystem is
helpful to diagnose the timing gap.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c              |  1 +
 include/trace/events/firewire_ohci.h | 33 +++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 07adb4ddd444..df16a8f4ee7f 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2185,6 +2185,7 @@ static irqreturn_t irq_handler(int irq, void *data)
 	 */
 	reg_write(ohci, OHCI1394_IntEventClear,
 		  event & ~(OHCI1394_busReset | OHCI1394_postedWriteErr));
+	trace_irqs(ohci->card.index, event);
 	log_irqs(ohci, event);
 	// The flag is masked again at bus_reset_work() scheduled by selfID event.
 	if (event & OHCI1394_busReset)
diff --git a/include/trace/events/firewire_ohci.h b/include/trace/events/firewire_ohci.h
index 67fa3c1c8f6d..483aeeb033af 100644
--- a/include/trace/events/firewire_ohci.h
+++ b/include/trace/events/firewire_ohci.h
@@ -9,7 +9,38 @@
 
 #include <linux/tracepoint.h>
 
-// Placeholder for future use.
+TRACE_EVENT(irqs,
+	TP_PROTO(unsigned int card_index, u32 events),
+	TP_ARGS(card_index, events),
+	TP_STRUCT__entry(
+		__field(u8, card_index)
+		__field(u32, events)
+	),
+	TP_fast_assign(
+		__entry->card_index = card_index;
+		__entry->events = events;
+	),
+	TP_printk(
+		"card_index=%u events=%s",
+		__entry->card_index,
+		__print_flags(__entry->events, "|",
+			{ OHCI1394_selfIDComplete,	"selfIDComplete" },
+			{ OHCI1394_RQPkt,		"RQPkt" },
+			{ OHCI1394_RSPkt,		"RSPkt" },
+			{ OHCI1394_reqTxComplete,	"reqTxComplete" },
+			{ OHCI1394_respTxComplete,	"respTxComplete" },
+			{ OHCI1394_isochRx,		"isochRx" },
+			{ OHCI1394_isochTx,		"isochTx" },
+			{ OHCI1394_postedWriteErr,	"postedWriteErr" },
+			{ OHCI1394_cycleTooLong,	"cycleTooLong" },
+			{ OHCI1394_cycle64Seconds,	"cycle64Seconds" },
+			{ OHCI1394_cycleInconsistent,	"cycleInconsistent" },
+			{ OHCI1394_regAccessFail,	"regAccessFail" },
+			{ OHCI1394_unrecoverableError,	"unrecoverableError" },
+			{ OHCI1394_busReset,		"busReset" }
+		)
+	)
+);
 
 #endif // _FIREWIRE_OHCI_TRACE_EVENT_H
 
-- 
2.43.0


