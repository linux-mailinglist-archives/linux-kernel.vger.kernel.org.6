Return-Path: <linux-kernel+bounces-320010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CE970503
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321A71C2142F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6F74594A;
	Sun,  8 Sep 2024 04:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kr6K13Q/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZ7trhaz"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC031C6A3;
	Sun,  8 Sep 2024 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725768358; cv=none; b=FHpv84cCGDFvngwdf1Od3MYFC5LDzq5LNRcvtDH+VXV1ugshfD1K9FHbCY5MPjapGYG0xmrIi5hQXzXIoT3H8VDAeghgMwqXncXrUSGgh3sGOkeqr0nTekqiAVVrfVanFNTaKklPg1Ubxhfjuy9DN4aJ41pyc/821rjB0Hn4Hsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725768358; c=relaxed/simple;
	bh=J1c3/nOGUYXW5uEzGGBsX0YXh6C+4ObMNDeGZYE5sy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmsCEwwA9mk4BSOr+LIwAiVlfBlWmAiq0Pcudi6KVvgBdsgKPVyvsao6TGjriEVSU8HXalPzF6vhwsAvE1IHYF5zHHLtZMx8J3vUxFDgFo4eI6yvEEKUBXgCHCvw+LWe0SJ+IqJVxr/RaDUjRO0uLG0DyqWeFfQ6ufbOc3CYCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=kr6K13Q/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZ7trhaz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5870E13802A3;
	Sun,  8 Sep 2024 00:05:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 08 Sep 2024 00:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1725768355; x=
	1725854755; bh=mJwi+7OIrvSrvVQo9tdtMjx8ghAQaQmxWlk/p3qeXeM=; b=k
	r6K13Q/lId0bkyeHz9WsNagIQgNOyBbaGBD1s7nYQiyQfnGkFzo5ERgwDBkQvMzF
	Bub++Qq1ZNOPZVmxpcZBjHqK9/iVaBbVA9LRtS7JMrTIdfHFnZyJXF6/nrrbYqYp
	qdkXu/HDERNC6mST0kFm3EB8qzA61B0/KmdS3fRKqIwZNfM7TaJ19tYTQVbn75H8
	1dbfNKnro4+3H9Cb86SD31L6qcQ/UEYaw2/EIDekCTYSJAb/7rfkmpTwohnBSGnV
	n0dOYocArf713wrzkltmgtgJtvlWnIyqHxmpVmE2KsR3SADnVtbodDvUwCEqPPpy
	1jLcjrPxOcbYkvvXiOSuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725768355; x=
	1725854755; bh=mJwi+7OIrvSrvVQo9tdtMjx8ghAQaQmxWlk/p3qeXeM=; b=O
	Z7trhazK5ERy8eRvIPAmRu+o+wJcvZF+bNV4spz8aX3NQaB14W/llVJMIkq0YY/U
	ip6EwXBLEfudGGXBeJiVXSZpPsVR/llmXq3HHDDCFecLv7PfJrtLJyogbi5Umcuu
	t2K+5dPjKXb+zQSZjhztetw7SWM/2xszvA28v8jfmuUAWOoFaJOIAvFvELNjHYoY
	AIYRYx+AnuUyCGboLZld0O3fp5za9Z82dJk3mrbFcnyikSds+Bilxx+aUdpSVK3d
	ulrprQ4tXIqom8MpLblXoSh45SP4WVwFZNwkGZtcc5a51PQ1//z1mDRLrKTI1XkN
	xQbNJKMHKPmaUg+0nl8ng==
X-ME-Sender: <xms:oyLdZju4gp4KwRLHn0kkChkAxVJhmCCNPIzuUpBbatZC2jsNtpanXg>
    <xme:oyLdZkePhzfqGIa0uCj1_SVnGGjAGwaIxteC7jEgKmbrBJoGysFRKDjqjyvOVKyMK
    3CIsTsn4L9qz5Vbv3Q>
X-ME-Received: <xmr:oyLdZmwjRg65BpXTmVd6-_GtuEZi33H7mbvDCip62ZWCxopTqE-qfNYHtVWELRXQOc08bGMZs_tE2BOEhVxIYHpbck8Axua2VIn6EAw1FCYyVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshhouhhnugesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oyLdZiOJI6wbaYnjRjJMd_kId9Jtb01DAA7OfQ8kHjJqovLGpS6AlA>
    <xmx:oyLdZj-a3jrSFfvF_Kyw0c0yVfSRt1jo90iQdM-XNVCHavUQHNNmkg>
    <xmx:oyLdZiXjVmQ4uhtXcoWJpBcaCkvG0XcNgspdqmMPy_v0QqmjX8rEfw>
    <xmx:oyLdZkeGy7fsdJPx9ZJEz1wn6fS14jDR7eAGD0Hh0F-mRkz8Hv4kgA>
    <xmx:oyLdZmaoSJtAHWGMfXVoNmEAMcUd-hXfDwNeXhenE5MV8guvLKaxaMCK>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Sep 2024 00:05:54 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 1/2] firewire: core: expose kernel API to schedule work item to process isochronous context
Date: Sun,  8 Sep 2024 13:05:48 +0900
Message-ID: <20240908040549.75304-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908040549.75304-1-o-takashi@sakamocchi.jp>
References: <20240908040549.75304-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In packet-per-buffer mode for isochronous context of 1394 OHCI, software
can schedule hardIRQ to the buffer in which the content of isochronous
packet is processed. The actual behaviour is different between isochronous
receive (IR) and transmit (IT) contexts in respect to isochronous cycle in
which the hardIRQ occurs.

In IR context, the hardIRQ occurs when the buffer is filled actually by
the content of received packet. If there are any isochronous cycles in
which the packet transmission is skipped, it is postponed to generate
the hardIRQ in respect to the isochronous cycle. In IT context, software
can schedule the content of packet every isochronous cycle including
skipping, therefore the hardIRQ occurs in the isochronous cycle to which
the software scheduled.

ALSA firewire stack uses the packet-per-buffer mode for both IR/IT
contexts. To process time stamp per packet (or per sample in some cases)
steadily for media clock recovery against unexpected transmission skips,
it uses an IT context to operate all of isochronous contexts by calls of
fw_iso_context_flush_completions() in the bottom-half of hardIRQ for the
IT context.

Although it looks well to handle all of isochronous contexts in a single
bottom-half context, it relatively takes longer time. In the future code
integration (not yet), it is possible to apply parallelism method to
process these context. In the case, it is useful to allow unit drivers to
schedule work items to process these isochronous contexts.

As a preparation, this commit exposes
fw_iso_context_schedule_flush_completions() as a kernel API available by
unit drivers. It is renamed from fw_iso_context_queue_work() since it is
a counter part of fw_iso_context_flush_completions().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 Documentation/driver-api/firewire.rst |  2 ++
 drivers/firewire/core.h               |  5 -----
 drivers/firewire/ohci.c               |  4 ++--
 include/linux/firewire.h              | 17 +++++++++++++++++
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/driver-api/firewire.rst b/Documentation/driver-api/firewire.rst
index d3cfa73cbb2b..28a32410f7d2 100644
--- a/Documentation/driver-api/firewire.rst
+++ b/Documentation/driver-api/firewire.rst
@@ -43,6 +43,8 @@ Firewire core transaction interfaces
 Firewire Isochronous I/O interfaces
 ===================================
 
+.. kernel-doc:: include/linux/firewire.h
+   :functions: fw_iso_context_schedule_flush_completions
 .. kernel-doc:: drivers/firewire/core-iso.c
    :export:
 
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 2874f316156a..0ae2c84ecafe 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -164,11 +164,6 @@ static inline void fw_iso_context_init_work(struct fw_iso_context *ctx, work_fun
 	INIT_WORK(&ctx->work, func);
 }
 
-static inline void fw_iso_context_queue_work(struct fw_iso_context *ctx)
-{
-	queue_work(ctx->card->isoc_wq, &ctx->work);
-}
-
 
 /* -topology */
 
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index d0b1fccc450f..3a911cfb5ff3 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2283,7 +2283,7 @@ static irqreturn_t irq_handler(int irq, void *data)
 
 		while (iso_event) {
 			i = ffs(iso_event) - 1;
-			fw_iso_context_queue_work(&ohci->ir_context_list[i].base);
+			fw_iso_context_schedule_flush_completions(&ohci->ir_context_list[i].base);
 			iso_event &= ~(1 << i);
 		}
 	}
@@ -2294,7 +2294,7 @@ static irqreturn_t irq_handler(int irq, void *data)
 
 		while (iso_event) {
 			i = ffs(iso_event) - 1;
-			fw_iso_context_queue_work(&ohci->it_context_list[i].base);
+			fw_iso_context_schedule_flush_completions(&ohci->it_context_list[i].base);
 			iso_event &= ~(1 << i);
 		}
 	}
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index 72f497b61739..f815d12deda0 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -531,6 +531,23 @@ int fw_iso_context_queue(struct fw_iso_context *ctx,
 			 unsigned long payload);
 void fw_iso_context_queue_flush(struct fw_iso_context *ctx);
 int fw_iso_context_flush_completions(struct fw_iso_context *ctx);
+
+/**
+ * fw_iso_context_schedule_flush_completions() - schedule work item to process isochronous context.
+ * @ctx: the isochronous context
+ *
+ * Schedule a work item on workqueue to process the isochronous context. The registered callback
+ * function is called in the worker if some packets have been already transferred since the last
+ * time. If it is required to process the context in the current context,
+ * fw_iso_context_flush_completions() is available instead.
+ *
+ * Context: Any context.
+ */
+static inline void fw_iso_context_schedule_flush_completions(struct fw_iso_context *ctx)
+{
+	queue_work(ctx->card->isoc_wq, &ctx->work);
+}
+
 int fw_iso_context_start(struct fw_iso_context *ctx,
 			 int cycle, int sync, int tags);
 int fw_iso_context_stop(struct fw_iso_context *ctx);
-- 
2.43.0


