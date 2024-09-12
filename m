Return-Path: <linux-kernel+bounces-326605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF16976AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 650DEB23686
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E41B12F1;
	Thu, 12 Sep 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fC8rdqIE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t0RtQf1x"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4701AD3F6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147852; cv=none; b=C1WkQ1lxjlEwtd/YcblKOQw22kVohSACE1/EXp7d0fQlEsFMJ9PnrTREBb9aU6cJqc6GtGFItwFu54q8J5KWHnmey9rHaNjALK7v0h3KazkuUZ+JRfOyfR0SbflH2sLe36FIUf7ga18ZZaX2zDfz8P7pitHBevdQaigYiY2Y374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147852; c=relaxed/simple;
	bh=UJWYuSjdTApRtaGUCFlq4cdJf6XqCD1vNFrTTn4rvqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDAsBM1tojDgF7g+9o4DxGkj33qUVW1cBblR3d3D/WY+kQMbRBO2s4Ypq5nicP+ruZAcky0EjTQpj06RWrXYfcOlFQYdJY0SnympasHikM03vlhwf01UJMPYXJzQJramAoazixRxwMqe5bao0FSQu8cpzuNoTwtAKYyJws50504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=fC8rdqIE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t0RtQf1x; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34E7D11404E6;
	Thu, 12 Sep 2024 09:30:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Sep 2024 09:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1726147850; x=
	1726234250; bh=8k4VDzvRIm/u8Ga1uxFz+W+U5caXLxKxCncN23o4gsw=; b=f
	C8rdqIE7Yjsl1oWxSn2pj2EzbbvZeh9D0j1pXCe5P6EibFgPb0JSRgg8WyJjQJtm
	IuzxS6HItAOiTk0HxLZ2hXzXpo9JgkyVq5cVEhhS8ThQxNcDTHT1CXAlXyxg60Nf
	h85pC1OZ0pB0T0+70pes679DL7zadBd26elv+23ze7YDjRCMnoVDtLstNL4w3WZw
	NT5tXljKuJ/UZe93S6xBplWZSg8b1ETqYjy83pPelDWaR4PThZhxbEQex3RHeKvL
	1w2G08N1G0eIdx1q4Tr09yEipWaDGOJT7Zyj99sLhhLxeFg1vYjR0nOTlL9syLkv
	1IxoDVLfHUfbI65eqpIiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726147850; x=
	1726234250; bh=8k4VDzvRIm/u8Ga1uxFz+W+U5caXLxKxCncN23o4gsw=; b=t
	0RtQf1x7Q7BjHJopAg0IUJtr9Ty/av1aAvJvaGWWeOAF5BMQpuCc3EXW191KUztv
	YSF6szbKh42Witdyg2fibc7q9tXoX0jzBepYwQlX9fLvVbWjuxYmcQVjtQG1Jgl5
	K40BoS2ZxXCIWOYXufExFhnKoyw6KQOimsfcOkZeV3ORUs/Kf92NMfQYdan218gB
	/fI6Xc4UC68+3S2dnyt/wQSUfBhsBwT6yMVpKHeiS6haLK4eMfJVaqo8ue1GFN/6
	hkGFH2QVrNGVhj9o/+C9HYHXSbNiZu5HVa2EfS4pfl9uwoq1NAK9zQE4fU05Rt5O
	utf2JALPIzwfPzJQ7ypPQ==
X-ME-Sender: <xms:Cu3iZt52ssVbz_GSiftXKoo52KwkRq8XSOYWsGCdKk2mdsXMaeARXQ>
    <xme:Cu3iZq4sZuRzQkGnhjOigafeVlo6Bbe8UU4fmlcwv6j9PNYsJ-QVfkEp3HgV1CKJ1
    KCLBzhZOEFK1F1svSE>
X-ME-Received: <xmr:Cu3iZkeybRf9SOQjDfpd_RNnIMVXh2C9FSRiZtW1DSHvy8zYV3_5O9Ty2jjL7kGvHCwVdwQ4e-sitiv43qrO9WRiuyORAjTX2tjU9m8HtpfgNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Cu3iZmIeOLhLR3PZ2G4BvOIl0KGZz-tNNYAymk3IxOrwcsaSaOumDg>
    <xmx:Cu3iZhLAzBVEuPbp3sALEuJ0JCXcEc4CtYsa-5cYnhXXwdCZUSfvYA>
    <xmx:Cu3iZvyPPGoxeLgvKj97sCXacFxRgvqn_zWhc8n-moNWlb9XD5o5Lw>
    <xmx:Cu3iZtJHE1x1e0WAFla7PanKvSPNHqhzSKL5PFP7cW1lvIZUThvtWw>
    <xmx:Cu3iZoX9FKhOCLdWo42efN_wM_YJrdqCfCJ6PJO1HvHemvUVvzINwkFN>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 09:30:48 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] firewire: core: update documentation of kernel APIs for flushing completions
Date: Thu, 12 Sep 2024 22:30:37 +0900
Message-ID: <20240912133038.238786-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912133038.238786-1-o-takashi@sakamocchi.jp>
References: <20240912133038.238786-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a slight difference between fw_iso_context_flush_completions() and
fw_iso_context_schedule_flush_completions().

This commit updates the documentations for them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-iso.c | 9 ++++++---
 include/linux/firewire.h    | 8 +++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index f2394f3ed194..a67493862c85 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -214,9 +214,12 @@ EXPORT_SYMBOL(fw_iso_context_queue_flush);
  * @ctx: the isochronous context
  *
  * Process the isochronous context in the current process context. The registered callback function
- * is called if some packets have been already transferred since the last time. If it is required
- * to process the context asynchronously, fw_iso_context_schedule_flush_completions() is available
- * instead.
+ * is called when a queued packet buffer with the interrupt flag is completed, either after
+ * transmission in the IT context or after being filled in the IR context. Additionally, the
+ * callback function is also called for the packet buffer completed at last. Furthermore, the
+ * callback function is called as well when the header buffer in the context becomes full. If it is
+ * required to process the context asynchronously, fw_iso_context_schedule_flush_completions() is
+ * available instead.
  *
  * Context: Process context. May sleep due to disable_work_sync().
  */
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index f815d12deda0..b632eec3ab52 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -537,9 +537,11 @@ int fw_iso_context_flush_completions(struct fw_iso_context *ctx);
  * @ctx: the isochronous context
  *
  * Schedule a work item on workqueue to process the isochronous context. The registered callback
- * function is called in the worker if some packets have been already transferred since the last
- * time. If it is required to process the context in the current context,
- * fw_iso_context_flush_completions() is available instead.
+ * function is called by the worker when a queued packet buffer with the interrupt flag is
+ * completed, either after transmission in the IT context or after being filled in the IR context.
+ * The callback function is also called when the header buffer in the context becomes full, If it
+ * is required to process the context in the current context, fw_iso_context_flush_completions() is
+ * available instead.
  *
  * Context: Any context.
  */
-- 
2.43.0


