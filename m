Return-Path: <linux-kernel+bounces-274392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69339477B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBC71F224D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E668E15573B;
	Mon,  5 Aug 2024 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="iqKRgPbw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M2UwNJvp"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90878154C07
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848065; cv=none; b=NrUNX6ID4DVnJ02N76VQ40uDVnmCFYQepa2Eyuw9PM8PrzP3Lw99XMHjwndY/QmgOwvnDBAo5EgbUoQozYwsO2ygiqx1Zz8vlvtYdLI4X4rgn1HLh/HqZ0/dOk8cPWRU98NS/FqJIZqtWxSJxS8juG5Ap1PmapXRAO+EV06Vitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848065; c=relaxed/simple;
	bh=0zT4ELUdypbLDPtYPoNIq0nN4q+2KRKcNt9sf1SBc84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtLaPGbKFGmbQLwY1MqhhlVSoZz8ZVvxQ1gBt8w6KB8KBbHoqzy1bxY9fssSy3ynz/1lE2SFpY9rVy1FSdU5MPN2eyDwPBUvRlgiRQjI1zBwFNX4YOv5zsXy7FBj0x9bhPZ6+ojmepqBp9HYqAezUllapzinYz+IKiAD88dlmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=iqKRgPbw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M2UwNJvp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B07D01151CA4;
	Mon,  5 Aug 2024 04:54:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 05 Aug 2024 04:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848062; x=
	1722934462; bh=riXT/ZPaI3yITLXofYuDWzvYYTW64WraJqRL8dIk1u8=; b=i
	qKRgPbw0F/BGTICG2Ydurr0ShavqcHfeJhR7ZjMxVKBf6gw+QoFrRqfhS7CrDdYE
	2H4tq3lZYvfKFgylGT2OwE38yKynX9Q69O27YS/zmu3CK/LzgJubF1j/9MKSwOIM
	MCck80POWvGWTNcXmjGxEqx9OdwyMFuKLMsr1lskIWQSEtQdE+HumKPllnkD2U1C
	tr45Q9l/zNMhXb/krF3mFzAMBdWqM2c86Sjg8a+byxtnMf9eH7rjWPVuN6ltFgDA
	OUGoWcF3QjhWal3tJRvmYZgUCyFepqy3ftR4V8QYMIFyWxGlLYCXryFbnOlec6br
	xrc1yo7dSgXWzIpZRFXWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848062; x=
	1722934462; bh=riXT/ZPaI3yITLXofYuDWzvYYTW64WraJqRL8dIk1u8=; b=M
	2UwNJvpWAS6JyvrfRUSaNDXXT7sWnp8tL2ndCoLvlURB32kJd+5DfJEmMZTd1/AZ
	zhTUDb0ku4+LEK342LbFWY9ImyYKnfjoPjPFMefjKDuvgXJu5K8yViy68LKQeINa
	ttUfy08jspUSiYjRCPAk0ax667aiRPyhnZGmzpcL95ohXYiNjq20s2l8k6fOSRdg
	7rc8bVVVtVotfyXc2tEKOvK6M9PLKBcVxly5FFrNkkSEpIrOGFzWxswEcgWQBUXn
	YSYb1jNTbFOiuQrPMpnGEI5hCWx/krGObHSwPKdoxl/0Cyi3mRm2Q1//iOTQYA6c
	a17wm5qn8L3TTWmiZbYMQ==
X-ME-Sender: <xms:PpOwZvpKo-85IZv1ecGcopExfG0oVD4xxeEOq5rQ5N3_4EVQnEHzug>
    <xme:PpOwZpqkUfDsHj922ubSazcQiWYhe3CCnEpTJBEa-qxWmTcaI6MDMkxkI2gBuHhs8
    jF8fSIwspLJhqxrt28>
X-ME-Received: <xmr:PpOwZsPJ_e2mzGZmf0N0EGzKZrt7cTkFJxR3nABk2AEiS37e70O9kII_77QEbJTnRv_lDj_O1UlUomFSZdRvc0alJdQt3F9BoDnhwsM5Bg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:PpOwZi6G-7YD_CpuvkQw5Sc3Lvp6OzxATgnYR6K9qT_TCtVz_HsrnA>
    <xmx:PpOwZu45Ubbu386tRSSvGNif5pMLvTLq2sFF8ASJf2CsUZxj0eyb0Q>
    <xmx:PpOwZqga8ObosvEraYX_NYLfNCRI9tuPxuvMhTGG6vEF1W49x7N9mg>
    <xmx:PpOwZg7bq8HAMqlL13TqYHXSugrNz8FHgflBxJdn0iqdToLGgHapgQ>
    <xmx:PpOwZuFWpOGr3Chu4_ujtAS9WBjh6SDO1tn5EVwoPv1Me0DvEKPSgUxU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:21 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/17] firewire: core: use guard macro to disable local IRQ
Date: Mon,  5 Aug 2024 17:53:59 +0900
Message-ID: <20240805085408.251763-9-o-takashi@sakamocchi.jp>
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

The core function provides an operation for userspace application to
retrieve current value of CYCLE_TIMER register with several types of
system time. In the operation, local interrupt is disables so that the
access of the register and ktime are done atomically.

This commit uses guard macro to disable/enable local interrupts.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index c3baf688bb70..90e9dfed8681 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1263,29 +1263,27 @@ static int ioctl_get_cycle_timer2(struct client *client, union ioctl_arg *arg)
 	struct fw_card *card = client->device->card;
 	struct timespec64 ts = {0, 0};
 	u32 cycle_time = 0;
-	int ret = 0;
+	int ret;
 
-	local_irq_disable();
+	guard(irq)();
 
 	ret = fw_card_read_cycle_time(card, &cycle_time);
 	if (ret < 0)
-		goto end;
+		return ret;
 
 	switch (a->clk_id) {
 	case CLOCK_REALTIME:      ktime_get_real_ts64(&ts);	break;
 	case CLOCK_MONOTONIC:     ktime_get_ts64(&ts);		break;
 	case CLOCK_MONOTONIC_RAW: ktime_get_raw_ts64(&ts);	break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-end:
-	local_irq_enable();
 
 	a->tv_sec      = ts.tv_sec;
 	a->tv_nsec     = ts.tv_nsec;
 	a->cycle_timer = cycle_time;
 
-	return ret;
+	return 0;
 }
 
 static int ioctl_get_cycle_timer(struct client *client, union ioctl_arg *arg)
-- 
2.43.0


