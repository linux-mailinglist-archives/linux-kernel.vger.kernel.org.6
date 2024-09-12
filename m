Return-Path: <linux-kernel+bounces-326604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F5976AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A591C239BC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ACC1B011C;
	Thu, 12 Sep 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="VcXEnawU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klM+J1Ju"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703A1AB6F9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147851; cv=none; b=n3WriQdGmgPZasRSARbI6iTYZIxsRP6Dj2qc9/9bNU6Giwg+UExqSGXXODkB6zsHXLQ4XZYERk56AfvkT4l9LX+i1KaTkpfM8dhArsaBhirZdbN3vBYnI4vV+QzOq9qe2+AWF+HSzlcehV0/GXeDZ5ojaXASzcPclt2+PouyvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147851; c=relaxed/simple;
	bh=VyCnF/sIxypxemRm/VZAiK93JGvif7eplvK5dBrfKOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiGXN31gM6WUTXSS9R3XbrOGkI5aMASqT3mT1/5lpd3WXLs8MAT+whMZwaWOW9h58+DpHvLvwoSx6a7lJhrvYYyz1xk6mUlwYuRawHed4k2Y2FskrVmPzi2bga+khDimLqh91Ayr11pQJCIHlbictRi24+czh1Kr6TfdbLz8v+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=VcXEnawU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klM+J1Ju; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C29661140502;
	Thu, 12 Sep 2024 09:30:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 12 Sep 2024 09:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1726147848; x=
	1726234248; bh=rglo+/zDD6Nc+U+Znu+G2W2jETHltYG2U4iySeRHtms=; b=V
	cXEnawU6hWxOCfg2MeJrzYLGRwY4mHObAOt4NW9QiUJ9CY8G51aB/iAhQJpFGpC3
	Jb7kQTyp48A0NhOuFP6UcMDHmPNNPRk9tvvq/hBz5iXh5KpAKvtDU25tVYzOLajv
	q+t03gTwscWaX05L4yW03CDlS53XB/x3nEkhv3lnuuqo8vr3DKzDLrDL8+UXNtFC
	pz8YXXFxxSKPykjknpS8bEQI+vGiGDJ0Irk0SnrRoY5V4ykm/7cnLmXX+TkymGz8
	J1YzpKJlDtuPjTZA7PrJTNviEQLC/+Vr7ptNf2lH4PEER3LRcMclSccwHgd5jcBa
	LNAQZVpLuLzlThe/Y1hyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726147848; x=
	1726234248; bh=rglo+/zDD6Nc+U+Znu+G2W2jETHltYG2U4iySeRHtms=; b=k
	lM+J1JuGWMvqMOt17zEf3Uf+HighWYqbfzHT/swfZEUflUmY4Vuci+HORf9OIW8O
	xNqz6piQFR8SXgRC51Wu9sz/d7riTzqGI2JBx1sHEznC3cZiamZ7KOrMhlc1C/ul
	x+mXIsgLjK/OKi7M7ULWka/1ahYeClZi8NEjJJSJ8U0yr+oA9dWYVpALjPUK2D53
	LP4Z6Jx/nZTz7c7IdWeHP3oqCreAk7gi8HjIhnTCl9LGzJU3aM0F9DyFqsHhiim2
	b/7RKhEQpBRIZKA15XYPNP2cFineOGzymUPpZb51J+9nGch6mybuFbJU+1jgeAjN
	SyAcNuYjGNLCSexpGGHEw==
X-ME-Sender: <xms:CO3iZtTjWLOWDQ2nAOTccjlukJD415ee209KmOzya7oH7wXCoGyq6A>
    <xme:CO3iZmyV72DR4YGo0qrqq1cCc2kVcZi4V-y_AcchumXL0V7V23kG4QEFNMm-kkrDo
    e2aSXG9X_WZsXpnbC8>
X-ME-Received: <xmr:CO3iZi3_MeVe-lZ-qMV0an9qR5FG_rGuy3rxHiFqHa2kt-l8W5dPlComkXwg-jjm4LcNqUHGxeM-Soby5SvFqSzAJ38-IzCxFmGjuxiFlm_SnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgieeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:CO3iZlCA6wnmIeN_dd_3MTwyi4V1ldzsddN8m7g6CalxITYgjsqQVA>
    <xmx:CO3iZmhGkbSbG1fopeYTnzDMehGKBw-JXun4ob-y4kOUlZHxu1yFvg>
    <xmx:CO3iZpoG4_9zuliVWlkfrLGU_aVF6BEK9kZEPZikDLfYga2qB5jJEw>
    <xmx:CO3iZhi9LQDW3kSo2YYq2rCFCYjk8ALaOEZ0O0RNIMYMyYnCMAIVKA>
    <xmx:CO3iZpu4RwOZzMOJJAXCwJ5z9KEr-iIfMhb5WhaXyGj2EF-zhNjthDpW>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 09:30:47 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] firewire: core: add helper function to retire descriptors
Date: Thu, 12 Sep 2024 22:30:36 +0900
Message-ID: <20240912133038.238786-4-o-takashi@sakamocchi.jp>
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

Both IR/IT contexts use the same code to retire completed descriptors
as AT context uses.

This commit adds a helper function to reduce the duplicated codes.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 45 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 3a911cfb5ff3..4af4c9af4fe4 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1141,9 +1141,8 @@ static struct descriptor *find_branch_descriptor(struct descriptor *d, int z)
 		return d + z - 1;
 }
 
-static void context_tasklet(unsigned long data)
+static void context_retire_descriptors(struct context *ctx)
 {
-	struct context *ctx = (struct context *) data;
 	struct descriptor *d, *last;
 	u32 address;
 	int z;
@@ -1182,45 +1181,19 @@ static void context_tasklet(unsigned long data)
 	}
 }
 
+static void context_tasklet(unsigned long data)
+{
+	struct context *ctx = (struct context *) data;
+
+	context_retire_descriptors(ctx);
+}
+
 static void ohci_isoc_context_work(struct work_struct *work)
 {
 	struct fw_iso_context *base = container_of(work, struct fw_iso_context, work);
 	struct iso_context *isoc_ctx = container_of(base, struct iso_context, base);
-	struct context *ctx = &isoc_ctx->context;
-	struct descriptor *d, *last;
-	u32 address;
-	int z;
-	struct descriptor_buffer *desc;
-
-	desc = list_entry(ctx->buffer_list.next, struct descriptor_buffer, list);
-	last = ctx->last;
-	while (last->branch_address != 0) {
-		struct descriptor_buffer *old_desc = desc;
-
-		address = le32_to_cpu(last->branch_address);
-		z = address & 0xf;
-		address &= ~0xf;
-		ctx->current_bus = address;
-
-		// If the branch address points to a buffer outside of the current buffer, advance
-		// to the next buffer.
-		if (address < desc->buffer_bus || address >= desc->buffer_bus + desc->used)
-			desc = list_entry(desc->list.next, struct descriptor_buffer, list);
-		d = desc->buffer + (address - desc->buffer_bus) / sizeof(*d);
-		last = find_branch_descriptor(d, z);
-
-		if (!ctx->callback(ctx, d, last))
-			break;
 
-		if (old_desc != desc) {
-			// If we've advanced to the next buffer, move the previous buffer to the
-			// free list.
-			old_desc->used = 0;
-			guard(spinlock_irqsave)(&ctx->ohci->lock);
-			list_move_tail(&old_desc->list, &ctx->buffer_list);
-		}
-		ctx->last = last;
-	}
+	context_retire_descriptors(&isoc_ctx->context);
 }
 
 /*
-- 
2.43.0


