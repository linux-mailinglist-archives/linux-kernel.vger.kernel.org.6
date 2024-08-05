Return-Path: <linux-kernel+bounces-274398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3CE9477B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C481F2247A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E914F9D7;
	Mon,  5 Aug 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="UUWVPq4R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6KwmugR"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00BF1509B3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848074; cv=none; b=YACdE4d3WCEQ0hmMqhWFf6bfWIIIVjha8bJNlr58brNqFxw388K2RkC795VI7Je+f0wAx+TtHQpFxAXf8xJE87xzM6xsrS2fdvGgrYrOPzVkWPALyXbugP9siPpxcflW6YKb15wbogesyrJXTbwX3DrgN0I+Hf4VlCRRF13oNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848074; c=relaxed/simple;
	bh=SYjPXH2iD1U1cMCRf7nypmxIm+fUZop8Ce0hqIrOg30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djoerRjEG0PEycau6ns6OvpSuGIyyXfh8NSyBTTUwzf1J38sXH1na5+Q5ZbPxdWM0EUU5BZ1JzkhH8On311qYSuFZkKEP5e7Nk+2x43bMw2bvTeu+vebewAAlmj90srU6sJroS751DL47ICnDYv2GL2r9O/FisugcOCxOmR1Zk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=UUWVPq4R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T6KwmugR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2050E1151C9F;
	Mon,  5 Aug 2024 04:54:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 04:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848072; x=
	1722934472; bh=bU5KUiELPtrWttit1O/f/6nD4P98n+MP8Do0wq0HKos=; b=U
	UWVPq4RhDGuoy+6iLlfbjECLslTp4D+cpXH4gh+uzXBd3sd49MXiYresZR2rAt7U
	Ua3M8mTVJTcEI57T4VRNkKBBK4EY4ECo+1A9AjZwsTDbZT+9hUjD/XkWq4Howa+7
	JAs9HVr4G8Ai2YYtkuLaYuWI5HMsCea/WAoTucRZm5WSGxgNtb4WnK+oyYI0qveK
	8I1f9aXqX1m2j/fZ6ClDLqYcdlMT84FwpNaunzOfO05kmkHkpB5OKd8lNSj1REQl
	kSG+Y6MiuaLPYQF7yQmHydzAwBGyDFx7MLO7An8Ey3z1tKY3bcP1u0ve3hQfc2Mj
	EiZlZ1x4EPCHBtFUh59KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848072; x=
	1722934472; bh=bU5KUiELPtrWttit1O/f/6nD4P98n+MP8Do0wq0HKos=; b=T
	6KwmugROEJoY7e7AddtH/VGvfrbtzCCMq338ggrDLwfQhQarRNzF1L28vTBeqmBS
	Z6juhpiLZt34+ZAovOPVi1L4rHyfNP76kpDUlrqEcoksILCt6dB9sq0vpyWtaqwt
	QlAaH9mktITsDjkuwaseVz6XvMCBkszJYEUh42vL/rdhIQKDUmjTdXouoeW6hvSA
	MZvyr5nv4/OE7rZ6/o5K9Qw+Q6BXr9JmG8r8VAqP6pSrKNJROmZg0B2nZ+MDEt9l
	/ekEDb2N+j/o+lOqA8jKTpPUq0PGprta0sYOPWJGZwJs8ITEpiPYYHPpMiW2zfly
	w78D8PL58q8HaAMDAWq2Q==
X-ME-Sender: <xms:SJOwZhhTPWqmgw2qomngcYpYnjzlnFeYKV-5tzuEvhszLirS8gv_TA>
    <xme:SJOwZmAN2gb0Pj34OvK7ZV6ORK1Fb0Tc1OGJ-RLtwysctK98EmzaJkq3Ml4uKYkwc
    wtRZmWYTEr4t_bp328>
X-ME-Received: <xmr:SJOwZhFKvF7z9UR-aIzFT5T5keqMkGEmY9h_m1J5fp3xEjm8PLveSmtVvRTocY8IP1iq740G8ryxab0yZRVU9GVNrA5naiMQNrz8TkKCu90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:SJOwZmQ7RssWEX5a1s0Ra5g2ua_u3pPv0h89QhfAXl0PFm7842nwVw>
    <xmx:SJOwZuzltloc_SMtO-WUn9fsqQoaO4ftUbTcxyVwyKnzdvsvtmfIdQ>
    <xmx:SJOwZs6J6BD8qGduYwE0qNnke3IXq19gngeI4fL7hozPmdXi298oXQ>
    <xmx:SJOwZjxSVz8mj1qYoXU1H0Nkhg_bUnD6VoUa_UfxnAxTUK8gTmG1RA>
    <xmx:SJOwZp9ESNZwdNOydLdVL8QCymaRaEYUddpn4poT1YARl61Oj7j14Iv1>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:31 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/17] firewire: ohci: use guard macro to maintain bus time
Date: Mon,  5 Aug 2024 17:54:06 +0900
Message-ID: <20240805085408.251763-16-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
References: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 1394 OHCI driver maintains bus time to respond to querying request.
The concurrent access to the bus time is protected by spinlock.

This commit uses guard macro to maintain the spinlock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 1461e008d265..5cb7c7603c2c 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2300,9 +2300,8 @@ static irqreturn_t irq_handler(int irq, void *data)
 		handle_dead_contexts(ohci);
 
 	if (event & OHCI1394_cycle64Seconds) {
-		spin_lock(&ohci->lock);
+		guard(spinlock)(&ohci->lock);
 		update_bus_time(ohci);
-		spin_unlock(&ohci->lock);
 	} else
 		flush_writes(ohci);
 
@@ -2762,7 +2761,6 @@ static int ohci_enable_phys_dma(struct fw_card *card,
 static u32 ohci_read_csr(struct fw_card *card, int csr_offset)
 {
 	struct fw_ohci *ohci = fw_ohci(card);
-	unsigned long flags;
 	u32 value;
 
 	switch (csr_offset) {
@@ -2786,16 +2784,14 @@ static u32 ohci_read_csr(struct fw_card *card, int csr_offset)
 		return get_cycle_time(ohci);
 
 	case CSR_BUS_TIME:
-		/*
-		 * We might be called just after the cycle timer has wrapped
-		 * around but just before the cycle64Seconds handler, so we
-		 * better check here, too, if the bus time needs to be updated.
-		 */
-		spin_lock_irqsave(&ohci->lock, flags);
-		value = update_bus_time(ohci);
-		spin_unlock_irqrestore(&ohci->lock, flags);
-		return value;
+	{
+		// We might be called just after the cycle timer has wrapped around but just before
+		// the cycle64Seconds handler, so we better check here, too, if the bus time needs
+		// to be updated.
 
+		guard(spinlock_irqsave)(&ohci->lock);
+		return update_bus_time(ohci);
+	}
 	case CSR_BUSY_TIMEOUT:
 		value = reg_read(ohci, OHCI1394_ATRetries);
 		return (value >> 4) & 0x0ffff00f;
@@ -2813,7 +2809,6 @@ static u32 ohci_read_csr(struct fw_card *card, int csr_offset)
 static void ohci_write_csr(struct fw_card *card, int csr_offset, u32 value)
 {
 	struct fw_ohci *ohci = fw_ohci(card);
-	unsigned long flags;
 
 	switch (csr_offset) {
 	case CSR_STATE_CLEAR:
@@ -2849,12 +2844,11 @@ static void ohci_write_csr(struct fw_card *card, int csr_offset, u32 value)
 		break;
 
 	case CSR_BUS_TIME:
-		spin_lock_irqsave(&ohci->lock, flags);
-		ohci->bus_time = (update_bus_time(ohci) & 0x40) |
-		                 (value & ~0x7f);
-		spin_unlock_irqrestore(&ohci->lock, flags);
+	{
+		guard(spinlock_irqsave)(&ohci->lock);
+		ohci->bus_time = (update_bus_time(ohci) & 0x40) | (value & ~0x7f);
 		break;
-
+	}
 	case CSR_BUSY_TIMEOUT:
 		value = (value & 0xf) | ((value & 0xf) << 4) |
 			((value & 0xf) << 8) | ((value & 0x0ffff000) << 4);
-- 
2.43.0


