Return-Path: <linux-kernel+bounces-273852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DFF946EE8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBAF2826AB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFA213B29F;
	Sun,  4 Aug 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Tnd5eC+R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PkR2XVIF"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BD1386D8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776569; cv=none; b=nHg7AdHD/jNhbPsc8G9rPHbEezii7C78QfzvYPNx8TFjLAYOTT7kdMPdEgs8W7RJ5FkQtiuTXTNFZ4IOUrkJMCLrJI9iHwDajQlfku25FnQ/M2SJfjfSUFG8hUMU36A0vBsz5vCeAHdMjdFTGapNcOqDFtHf3rP4DihNMPFOHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776569; c=relaxed/simple;
	bh=49GxbGlyfanU/y+/2A/yh+GRQDGyrxQpzb/j493tJX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nd9MjmZzwFW9VTYwOTltKcAI7JqqGps6gZt0eEkbcMh9YnKqoElqSlyYh3Ry+G+GlCSNhr5Jl7TuOzmuzJDX0dxGTI6mgTRhYHQOdALzf8/Vy++QegJuoH8aLzotJr6zMrLZY1MeOw13kSwngPY2T82fcwwoR0zHUD7yVw3zlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Tnd5eC+R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PkR2XVIF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EEB471147EEC;
	Sun,  4 Aug 2024 09:02:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 04 Aug 2024 09:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776566; x=
	1722862966; bh=g2ZYQpdmVR2Qgn3ioWPYVE8uCIbn3OBt2eoIeM+wq4M=; b=T
	nd5eC+Rb8fuBOlh0O1ynU4gSoXL7iS0VicHZjA4YzmPCbEAO/YAKPgnrpyzvK93H
	bzPTF/j57xKacc4vn/RdlFDbf+jG1U8QEh9VGr4Yi/B9sW2bhkeiqHfluiNFfaw8
	Yh89EHJvUWHYhGXYrmzinrVMefk11OBuG2Gw7lcrhEWd/KmIbBWneM+gDIGB18WK
	CjbJNbPVzeQ19rEw/XzGEkzroMj5BljaqrPuIOQMeeRPNB4uJ9gYXdA24Ls+EjAV
	wmiHmwqxu+PTI8F6io0dTMK6OSyBIl6cyH6RJ12JQAnqsJJIWrDslV5xrJd1nPEy
	92c87GJdwAuk+8lVSIKqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776566; x=
	1722862966; bh=g2ZYQpdmVR2Qgn3ioWPYVE8uCIbn3OBt2eoIeM+wq4M=; b=P
	kR2XVIFBD5HNS1hL3MB0ROi2Ylab6TbrXzWpMDyhZN1Xo5i6KIk4vqQd7MelGpuO
	x3mUcs5VYvBoElsLJLI1MK1NyZliisSYtF5vKfnzJxdIQicUIWHOluSHPdnPeCzM
	mPclUg6+NM4EPtf7RurLHpMkM9OVUocUTybzKvZ1884/DOi0PG4LPE7gWqiLKS+Q
	4JEeQNq8TVKUswcDtGUDT6vUifjM3Ek1OUxfquFti21mtBw03P1Px3WMbL+1zmUK
	fjkTvSOvwKopV4GXxg1M+lk1W597zFtUEY8Obwg6bAw22P+EOWclSWqU45rSJZq6
	+wUoqEU0tARQXgUurwjvQ==
X-ME-Sender: <xms:9nuvZll6tEhLQc8NFmfqlPXOmap8evesyDcxhMDqpFHKxwTZ6cTC3Q>
    <xme:9nuvZg0qxlqxkE3uFfHge1MxL4EbNlU-Abvqs2idAJbcyMzNc1pehRh70jzfa_BIx
    hKWcYIa0s1DaUZ0Kso>
X-ME-Received: <xmr:9nuvZrrtg7GYrf2wvSnLlWMbl6-VMmf8nLp_3j7owWlkh9in0lzexGUtcQAnaUhSqR144klp3uRUWs1s2WTu_b20Q8RsuBOcS0nSbTBfyfjuXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:9nuvZlnAHNXU66YdiO9W8e92mvuXR-qYEoEKfdzpxu6j265Vc3uw6g>
    <xmx:9nuvZj2gXU5jIsE9ZGkao1he_ki6TU2cHAaqjfZS6byf3bmzLGQyVQ>
    <xmx:9nuvZkuk9potHbI59YbDmzdUvTbYPyUomx3JbLYT0Jp_O4LdKUl5nQ>
    <xmx:9nuvZnXnYISdTzevUESXUxwtvPgVjmdS0boHLoYT3ogyVGuuzVB13Q>
    <xmx:9nuvZhCYMwliekyFm__nQlDbG6UGG0oAqtVsHtVKk94xdFVEc8U94m59>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:45 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] firewire: core: use guard macro to maintain list of asynchronous transaction
Date: Sun,  4 Aug 2024 22:02:20 +0900
Message-ID: <20240804130225.243496-14-o-takashi@sakamocchi.jp>
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


