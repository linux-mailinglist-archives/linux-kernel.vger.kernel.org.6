Return-Path: <linux-kernel+bounces-273854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531A9946EEA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93F81F21F37
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C413C3E4;
	Sun,  4 Aug 2024 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KtvtMoTc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEOTm/Uh"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BF513B2A9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776572; cv=none; b=R1upaQ8uv5HzA0AEGRcZd/RR3bBHnkAoPW5HhKMb9LbWtNn2zSvxeiLvc11MDxIMfM27zqPKdvKvErrbWx3g83zBH7mHUIjw78f48Lf8tupzCRvej0QdYRx0rGkYHIKGWYyt9Ra20FTXvHP1vZ8nywZ2DdEgx0VHR0CEziomTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776572; c=relaxed/simple;
	bh=SYjPXH2iD1U1cMCRf7nypmxIm+fUZop8Ce0hqIrOg30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYrJJXoKD3EgoSjUt5wdfKHLe+UzPjUreVatioi0/uDSHd/EUcZ4tQWjcQ7hVk78ula8yJWmXREfRIJoX0TYGmDW4uCLQMuu7GbyTPU+PO+LGBr98TdAEkGgJ+GQur5wsZl8tXHfKruPnnEs+94CUjy86NC9IsaaRtmjhlVvPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KtvtMoTc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kEOTm/Uh; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A6259114814F;
	Sun,  4 Aug 2024 09:02:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 04 Aug 2024 09:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776569; x=
	1722862969; bh=bU5KUiELPtrWttit1O/f/6nD4P98n+MP8Do0wq0HKos=; b=K
	tvtMoTcmx5jSUiz10zOZ0vgMH/H0UGOgxo/4kx8kArjArkdqZDjuDjVyxFK5AuM0
	bt4uKKg08zH1uGCcPFAyEedGtnKV1ZIk4YPQMtzHdYnODuzAxUSk8+f7ZCDp0Ey2
	RoMpZFb6jej80tpRpUWWVnB3XP7YAhiyHtosqnkF6mYL7YbCgutPbdKKkwelfuY+
	G0g9wfmjhN9DTAsgQuRYA18Td+fpVeiz8jNctJ+Fc1jbTrLXPtFvopk/za/R42G5
	nEstd4Vfol7UM7Q071PIcCQW0rCCf2R/Iyg1/ipDbWY2sjDbqaI+sad8UaoY26JJ
	dmZ+r86P6IluKyf2xU3NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776569; x=
	1722862969; bh=bU5KUiELPtrWttit1O/f/6nD4P98n+MP8Do0wq0HKos=; b=k
	EOTm/UhtajSp8x0G807qlS6XiRnrqervBMh0oBatOketmDqjYfQHhnipGGabLbT+
	/g1w+f6d3wZTgt0aV7q8FPRxE3qBOQpiR9J1eknZbNcx0hxCN47gpZ6VnlaMoFqL
	5FFY3i7YwAxnKzyQWAcLKovG0Go9XnSG42O/GxWAqKE1UktW+JyIJPjVZorO1nul
	cu6W6uukLfUgK6pZaoGqM7pm0iqoj1p+LklgXaSwpPCnndt9KcvxHub3jqZ1q+p1
	AvrdGr3kZ6+b4m+E09QjfpnH+5e9gslaQ5Xs/kex0UdHaQbDpJmapJIULLmmJ1C7
	KLwEWtNGV+lufLtDY+Teg==
X-ME-Sender: <xms:-XuvZs08JTgKAfxAab0qCCMSiO4uWfhN88CNwW4yvA1yJMttpVsAtg>
    <xme:-XuvZnEtbXcyzIWo36J73C8QrrDxF1ztDqiX2ZJCuvKQsK0wPAtauTM2gLt955krS
    ypU9E8eE3qdvQPcuXw>
X-ME-Received: <xmr:-XuvZk433MnL4-HcMdna_ulZvpfACPlcwj7XPoX8tGWmCmvGX--we527AKcKMst0jIoF9w4Oy58m-1-4wOkfpcF_b9EuHMYFSZXYHI-PxtONEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:-XuvZl0MP7HHXqDVnxgY2w6YLRc7TyVfLY-OWtg44vYQcoPRnuZmdA>
    <xmx:-XuvZvGV82TQ-5tlns0LheZTAg2UT8DGnnJohVQGDUJ26ZhO5C1gqw>
    <xmx:-XuvZu_5f41x0RQW31OuAhcOdYkQU7GUZB9QxhlcywOaj1Cxuiht2A>
    <xmx:-XuvZkm2-1ZxGHL6AGiDkwPymaqaU86-xbCFnNAq1MVsw9KPJnAWSQ>
    <xmx:-XuvZkQQJ2VuWpJmGDSBdh5isnKEE7Z1_fDojs7eSgwnaSY6-li11B2A>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:48 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] firewire: ohci: use guard macro to maintain bus time
Date: Sun,  4 Aug 2024 22:02:22 +0900
Message-ID: <20240804130225.243496-16-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
References: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
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


