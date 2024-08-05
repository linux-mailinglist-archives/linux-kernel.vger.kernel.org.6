Return-Path: <linux-kernel+bounces-274397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B00079477B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD15DB2253D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D5156F5D;
	Mon,  5 Aug 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="h1hbO/m3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="scOuyjtz"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903B156971
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848071; cv=none; b=p+wHZD5SfSrqFm7M8A8K2uX6c7SE+hSlIYC3I5FT0upLge8SYl6V63ssNRbI82JbQZsLrjBCO96BmrgDFx4VOd0TPwlnRRLC6X2ob33rDjQUtXl78bSYCV8IX09te3/ZN3XoZr0pW/07D8uq2M3VRCK/XvMG2Rm/GqZMJpE1NX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848071; c=relaxed/simple;
	bh=49GxbGlyfanU/y+/2A/yh+GRQDGyrxQpzb/j493tJX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULFFr3pmPFf7FA0Vt66NAX3FG5AYNqjj/H811iiE+r3h65R1vPtzO9xRPRqp2BVo9mIqksnagHXJ93v5XuT8TwinxXletXtv+f+G21Fe/WjnInzp79giVT/g+3dN2X2M/J0YYqLwtfKNmKqYC0riH7xsjJeXNtvQmZe3PyA2UEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=h1hbO/m3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=scOuyjtz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 716101151C98;
	Mon,  5 Aug 2024 04:54:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Mon, 05 Aug 2024 04:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848069; x=
	1722934469; bh=g2ZYQpdmVR2Qgn3ioWPYVE8uCIbn3OBt2eoIeM+wq4M=; b=h
	1hbO/m3dTERfIpcXjMaQnrRa4ZAijkqeHGIvBIahQ77+RT4ycp37OOQyTgNNLh9u
	7Y4n35YNpf9D+eN5wAkVn0bWee2HNLnna9UFRL1ZayizPeI+tcM2GmFbfxTs/vte
	NG5EIkYTKnQNC01xDD9djFlL8H6Ajl8++aPuoHiIxloTzcI2KgBYA9mgGPo9kosW
	KGuQmm1jyCtxP5Uj0X5vClCj3pE0KL96gbSMAMa+rYcl6EvBWHjzZt5a0v9+X2va
	ITC0o0U7bTht+oHuv+8ZqzV+KP4OyQpihg5rUyPXTmRbuAASO9MyZlmzfK83c1+I
	9uij5B9FfRDImnvBjglFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848069; x=
	1722934469; bh=g2ZYQpdmVR2Qgn3ioWPYVE8uCIbn3OBt2eoIeM+wq4M=; b=s
	cOuyjtzQypE19EU8ClqxsFqRaZCEDEYeKKMiPXC5e8tcnCehi2I8TXXD6AfQY4Fc
	VKh2AQSaARYal9xeBxzF2TdgyBkcnK/58e+haqWbrJ41cccUzC6zl7C3SgURY3yB
	0VHOUwN8lX53MSrradxBHZfp4O9upSrH2hhN6o37KYxQGgsruD5DmzApn2iistvA
	W4ZgRT0+YoQi1FEUxhpu/J+Wj7zRjxBpn63rsM3r4shsR+Xehv2s/h5eUF9bs/pC
	HxPKWvrYIGcbxjScqkNa43Fx2tWMpqqXIMoyJK+LfOSsUD85ztSibvRyVE+YcFou
	J+7n/nWFPCTydA+x4Lg2w==
X-ME-Sender: <xms:RZOwZn1pMvV_dZcySsrsi-pXRmSew8kNrje7GeXVfNg_Vkic-hDqAg>
    <xme:RZOwZmFUb57HSM0iM-cFRDD2I4WBuGLX3MmLXNocMXzvyZzQFGSsQvA33jsIjolw1
    RWHHOc-4ROORxXdplM>
X-ME-Received: <xmr:RZOwZn5rAlqmsPtTWtGCud2FlhaU5qxgvjELBAypSZgkw9k5iCpyeGmLGwkqOfy6FE7wE4ka8A8lVsjsy-1PjjLIgd4827aQ8p7J6J4NBuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:RZOwZs1kpiDTp7Q9iovp-JRgyEJ_10ztHWJsK-KdTqgz8UvnNaPCIQ>
    <xmx:RZOwZqHdqFQ7Wac9TOK2F4Gzo95lThE7Wb-xkTjWMYhc7ZkTlPqZRw>
    <xmx:RZOwZt-fVzIqu05Et73H3bFJ_SNSj-vxvcmFcDVyQ33VHzuGsi9rXA>
    <xmx:RZOwZnn9Il8HaD9dxO1ZUnCBZG6CTGYKVc0AfbezObgsGPN-0-Jnkw>
    <xmx:RZOwZvSde49nHs8tq1SgjCcA7V7wO_t4am3nUNcukWuwzUm35Hca3qF_>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:28 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/17] firewire: core: use guard macro to maintain list of asynchronous transaction
Date: Mon,  5 Aug 2024 17:54:04 +0900
Message-ID: <20240805085408.251763-14-o-takashi@sakamocchi.jp>
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

The core function maintains pending asynchronous transactions by list in
the instance of fw_card. The concurrent access to the list is protected
by spinlock in the instance.

This commit uses guard macro to maintain the spinlock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 85 ++++++++++++-----------------
 1 file changed, 34 insertions(+), 51 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a006daf385e9..0f58a5d13d28 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -49,35 +49,31 @@ static int close_transaction(struct fw_transaction *transaction, struct fw_card
 			     u32 response_tstamp)
 {
 	struct fw_transaction *t = NULL, *iter;
-	unsigned long flags;
 
-	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(iter, &card->transaction_list, link) {
-		if (iter == transaction) {
-			if (!try_cancel_split_timeout(iter)) {
-				spin_unlock_irqrestore(&card->lock, flags);
-				goto timed_out;
+	scoped_guard(spinlock_irqsave, &card->lock) {
+		list_for_each_entry(iter, &card->transaction_list, link) {
+			if (iter == transaction) {
+				if (try_cancel_split_timeout(iter)) {
+					list_del_init(&iter->link);
+					card->tlabel_mask &= ~(1ULL << iter->tlabel);
+					t = iter;
+				}
+				break;
 			}
-			list_del_init(&iter->link);
-			card->tlabel_mask &= ~(1ULL << iter->tlabel);
-			t = iter;
-			break;
 		}
 	}
-	spin_unlock_irqrestore(&card->lock, flags);
 
-	if (t) {
-		if (!t->with_tstamp) {
-			t->callback.without_tstamp(card, rcode, NULL, 0, t->callback_data);
-		} else {
-			t->callback.with_tstamp(card, rcode, t->packet.timestamp, response_tstamp,
-						NULL, 0, t->callback_data);
-		}
-		return 0;
+	if (!t)
+		return -ENOENT;
+
+	if (!t->with_tstamp) {
+		t->callback.without_tstamp(card, rcode, NULL, 0, t->callback_data);
+	} else {
+		t->callback.with_tstamp(card, rcode, t->packet.timestamp, response_tstamp, NULL, 0,
+					t->callback_data);
 	}
 
- timed_out:
-	return -ENOENT;
+	return 0;
 }
 
 /*
@@ -121,16 +117,13 @@ static void split_transaction_timeout_callback(struct timer_list *timer)
 {
 	struct fw_transaction *t = from_timer(t, timer, split_timeout_timer);
 	struct fw_card *card = t->card;
-	unsigned long flags;
 
-	spin_lock_irqsave(&card->lock, flags);
-	if (list_empty(&t->link)) {
-		spin_unlock_irqrestore(&card->lock, flags);
-		return;
+	scoped_guard(spinlock_irqsave, &card->lock) {
+		if (list_empty(&t->link))
+			return;
+		list_del(&t->link);
+		card->tlabel_mask &= ~(1ULL << t->tlabel);
 	}
-	list_del(&t->link);
-	card->tlabel_mask &= ~(1ULL << t->tlabel);
-	spin_unlock_irqrestore(&card->lock, flags);
 
 	if (!t->with_tstamp) {
 		t->callback.without_tstamp(card, RCODE_CANCELLED, NULL, 0, t->callback_data);
@@ -143,20 +136,14 @@ static void split_transaction_timeout_callback(struct timer_list *timer)
 static void start_split_transaction_timeout(struct fw_transaction *t,
 					    struct fw_card *card)
 {
-	unsigned long flags;
+	guard(spinlock_irqsave)(&card->lock);
 
-	spin_lock_irqsave(&card->lock, flags);
-
-	if (list_empty(&t->link) || WARN_ON(t->is_split_transaction)) {
-		spin_unlock_irqrestore(&card->lock, flags);
+	if (list_empty(&t->link) || WARN_ON(t->is_split_transaction))
 		return;
-	}
 
 	t->is_split_transaction = true;
 	mod_timer(&t->split_timeout_timer,
 		  jiffies + card->split_timeout_jiffies);
-
-	spin_unlock_irqrestore(&card->lock, flags);
 }
 
 static u32 compute_split_timeout_timestamp(struct fw_card *card, u32 request_timestamp);
@@ -1015,7 +1002,6 @@ EXPORT_SYMBOL(fw_core_handle_request);
 void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 {
 	struct fw_transaction *t = NULL, *iter;
-	unsigned long flags;
 	u32 *data;
 	size_t data_length;
 	int tcode, tlabel, source, rcode;
@@ -1054,26 +1040,23 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 		break;
 	}
 
-	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry(iter, &card->transaction_list, link) {
-		if (iter->node_id == source && iter->tlabel == tlabel) {
-			if (!try_cancel_split_timeout(iter)) {
-				spin_unlock_irqrestore(&card->lock, flags);
-				goto timed_out;
+	scoped_guard(spinlock_irqsave, &card->lock) {
+		list_for_each_entry(iter, &card->transaction_list, link) {
+			if (iter->node_id == source && iter->tlabel == tlabel) {
+				if (try_cancel_split_timeout(iter)) {
+					list_del_init(&iter->link);
+					card->tlabel_mask &= ~(1ULL << iter->tlabel);
+					t = iter;
+				}
+				break;
 			}
-			list_del_init(&iter->link);
-			card->tlabel_mask &= ~(1ULL << iter->tlabel);
-			t = iter;
-			break;
 		}
 	}
-	spin_unlock_irqrestore(&card->lock, flags);
 
 	trace_async_response_inbound((uintptr_t)t, card->index, p->generation, p->speed, p->ack,
 				     p->timestamp, p->header, data, data_length / 4);
 
 	if (!t) {
- timed_out:
 		fw_notice(card, "unsolicited response (source %x, tlabel %x)\n",
 			  source, tlabel);
 		return;
-- 
2.43.0


