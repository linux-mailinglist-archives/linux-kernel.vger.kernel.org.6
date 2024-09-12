Return-Path: <linux-kernel+bounces-326606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C7E976AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C9E2838BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18721B1D5E;
	Thu, 12 Sep 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="g6Y8Jv8t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JjALnz9H"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E981B12C4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147854; cv=none; b=lJMOPxMadzPAePSx/3/asQLfF66eGTicpBpairnW7blvqtaUTC1uORY4QNA+sDkp/8VOHDQX6bdEla3EZ4Y5mfuFBfiH4AXjRO8pS4ls5/RviW9stVU6LZzoAtTF+DYqPYO7CaMLbjYax9+mtHd2zHJr17N7VCzIg4kscyOrh2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147854; c=relaxed/simple;
	bh=HeNBqimDw6W5SWh98mdMsY8h40xjwFnDwyEONhgvAbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZPMzDHZ9TvTqwgrOSrL7iR2dJJqWJ53nQCHXEzB7lmWmnio0cM9A5f5Lh9fV8Xqp48BOTFZU63E3Zj5XJItMlx30eC5lbAuSSo2L86PdUPN5dh95/Baf8eRfMTedH6tyv0qU4pxD1D33uxIiymFuEQm4jcyKzS63+tltqFNk1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=g6Y8Jv8t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JjALnz9H; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id A4EF91380547;
	Thu, 12 Sep 2024 09:30:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 12 Sep 2024 09:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1726147851; x=
	1726234251; bh=YLAUq3NUe155VrLSf5ng8mFVHvyTPYxEL/05VRMpxfs=; b=g
	6Y8Jv8tGA3BehRIpjeAXyiVadHrE0CPW40p8N/wmJ4MxnJzwLfvivR9BGktR6ovE
	fDrm7fdv3rKj0G+D8ZqEvcO1bpDeHJrR8lZz/Ql9yJ4X0t9SPiPT/SmzI+vdJnPp
	F/PbcJkZMSoniQ0WO+S1zt8ukw6oXnoIk+t1GmTc9qRI9jh+Istve89IPlqtbO1w
	5+/Ir/gjP9HuBGz3yY8RIYSycMaLtiHFsZu0NhndTj+OcEOZDvDMmNqvG15r9wp4
	N2rQr2e64Ym7riSxeWT4RaZHQ858F4bgbpMOHV44bgzxDp+J3pEu77FLI9sFfaGH
	+coweylEhqlnsvseff9fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726147851; x=
	1726234251; bh=YLAUq3NUe155VrLSf5ng8mFVHvyTPYxEL/05VRMpxfs=; b=J
	jALnz9HRr9yxjKa19LP/ecZBmxa3mQhDxN/TgQwnnQjdxNCJcQNxNsOW/ZnpP2QA
	lwUIx6ZX5oQKMPBsMF1tZfxTikzpzBh9KWxqOOAEOLQWXDh9ciM7gRtZ+LGiRGJZ
	FmMz06x2qICFfh3FMSPebnM8IKXVA223WCZRWxPiIPIJDrSwFu6hwSIhYLo21z9N
	fZdl+yJ5YfDyAwK9sprPM9CxxAG9UtnDVKXNBCbIrlFdD39Bdyml4yI+4IAzopx8
	WXGXDoDGIVGJnTbnhoKjKFph3lA8xGo5BVRFNOnAO4V8OEdgi1cgGGsIJvmZcXNa
	Pj+6FqjYnEKUImqA7YCsQ==
X-ME-Sender: <xms:C-3iZiLZikZzTqlZ-KoeTnGTi6kj44TYjpuVifvjmGPyQ4UgcWRaoA>
    <xme:C-3iZqIbgbd1bgqwX2zx2pwCUGWLcjAy5HajrIWLkqL7mMimg1oWI3afrYmf8u9I7
    ZKxiy6mOG4b-jk7egA>
X-ME-Received: <xmr:C-3iZiuohA3QW-bVoIyJsjoT7LeukHihYDGqPAyvrkDL4LPL4ILBYXU6yrX7ZI2hzNodgrWmQmRUE7HxG1oRL-IkTq4Ea6ah26jXSHd4RaOIhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpeeulefhkefghfekveevvdefgfekhfeftdduhfegheegffdtudeuvdekffdu
    hefgveenucffohhmrghinheptggrlhhlsggrtghkrdhmtgenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghm
    ohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghf
    ohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:C-3iZnaoGYcCmflLdIaIdeSXuFpopkyXX6Ygj6DX2PfzkUTRCThUtg>
    <xmx:C-3iZpaCUnBi3Q3TiGje97e9Kg1gS2M_SE_qr8k0ZC0dBSLa6GGM1w>
    <xmx:C-3iZjD6ouuSoQigRLK6SoZRFTqulKro-6WxgAoiD2IgbVOwHt7AkQ>
    <xmx:C-3iZvY3CXhUtAuZx6ckR5WybWIZmgLFbwA7Ust3cpPvMvAsrsgYzg>
    <xmx:C-3iZokMN4ByZN5IsWE6iCrvYYvF9q_wTPaIzuDgePAtLve4UOJTCqNq>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 09:30:50 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] firewire: core: rename cause flag of tracepoints event
Date: Thu, 12 Sep 2024 22:30:38 +0900
Message-ID: <20240912133038.238786-6-o-takashi@sakamocchi.jp>
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

The flag of FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ directly causes hardIRQ
request by 1394 OHCI hardware when the corresponding isochronous packet is
transferred, however it is not so directly associated to hardIRQ
processing itself.

This commit renames the flag so that it relates to interrupt parameter of
internal packet data.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c         | 6 +++---
 include/trace/events/firewire.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 4af4c9af4fe4..7ee55c2804de 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2927,7 +2927,7 @@ static int handle_ir_packet_per_buffer(struct context *context,
 	copy_iso_headers(ctx, (u32 *) (last + 1));
 
 	if (last->control & cpu_to_le16(DESCRIPTOR_IRQ_ALWAYS))
-		flush_iso_completions(ctx, FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ);
+		flush_iso_completions(ctx, FW_ISO_CONTEXT_COMPLETIONS_CAUSE_INTERRUPT);
 
 	return 1;
 }
@@ -2963,7 +2963,7 @@ static int handle_ir_buffer_fill(struct context *context,
 
 	if (last->control & cpu_to_le16(DESCRIPTOR_IRQ_ALWAYS)) {
 		trace_isoc_inbound_multiple_completions(&ctx->base, completed,
-							FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ);
+							FW_ISO_CONTEXT_COMPLETIONS_CAUSE_INTERRUPT);
 
 		ctx->base.callback.mc(&ctx->base,
 				      buffer_dma + completed,
@@ -3059,7 +3059,7 @@ static int handle_it_packet(struct context *context,
 	ctx->header_length += 4;
 
 	if (last->control & cpu_to_le16(DESCRIPTOR_IRQ_ALWAYS))
-		flush_iso_completions(ctx, FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ);
+		flush_iso_completions(ctx, FW_ISO_CONTEXT_COMPLETIONS_CAUSE_INTERRUPT);
 
 	return 1;
 }
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index b108176deb22..ad0e0cf82b9c 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -830,13 +830,13 @@ TRACE_EVENT_CONDITION(isoc_inbound_multiple_queue,
 #ifndef show_cause
 enum fw_iso_context_completions_cause {
 	FW_ISO_CONTEXT_COMPLETIONS_CAUSE_FLUSH = 0,
-	FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ,
+	FW_ISO_CONTEXT_COMPLETIONS_CAUSE_INTERRUPT,
 	FW_ISO_CONTEXT_COMPLETIONS_CAUSE_HEADER_OVERFLOW,
 };
 #define show_cause(cause) 								\
 	__print_symbolic(cause,								\
 		{ FW_ISO_CONTEXT_COMPLETIONS_CAUSE_FLUSH, "FLUSH" },			\
-		{ FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ, "IRQ" },			\
+		{ FW_ISO_CONTEXT_COMPLETIONS_CAUSE_INTERRUPT, "INTERRUPT" },		\
 		{ FW_ISO_CONTEXT_COMPLETIONS_CAUSE_HEADER_OVERFLOW, "HEADER_OVERFLOW" }	\
 	)
 #endif
-- 
2.43.0


