Return-Path: <linux-kernel+bounces-238525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C824924B88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19201C2266A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161741DA30B;
	Tue,  2 Jul 2024 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="hBajqO7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CmvlRRE1"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884D17A5BF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958848; cv=none; b=Wmiy46jAJtAY7B11+fM8xataIeriw5YXpLg56MA0yQZU8TSbcduntz59hXTvV5Guv9gurCjr/PlRVt+BUa6eQZ9L8kS8IMwD4tt0AyzJy4UoaFvdgWfB+VKDJjFFIF2YWewakY6sr2fsLaLRhemLITgvM6r0zp/3KdCuYTahV/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958848; c=relaxed/simple;
	bh=jbcMa376uObBTkouPaJPfroBY9kEJbXMkW0Yopmlbb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEMR8lS1P96LxT/OqJ6dPHsBQboxZM5YDbd67G//DU4fjdPEavYnFWKaq3MKdEJoJwlfDRILqQWsl86hk9kGatGsHnVV/qdkfkQK5FUV7EgdF5pswQpat3FewN1SZdvAIAwh0Fg5iWBqtNV6hbu5lTIFHP+jvJV6YD5wZFXhhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=hBajqO7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CmvlRRE1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 80E1E114023D;
	Tue,  2 Jul 2024 18:20:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Jul 2024 18:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719958846; x=
	1720045246; bh=IPVHX16LbTeOoMwyZ1FrhOHGKcwF2+L0k84yqEHpcRo=; b=h
	BajqO7k8Kdl2+Nvvn0KZYIm4FuG3GIk8aFoXaZtuyVzoCuv2ainunQ3ysZF453vQ
	jIdw7Nms7oJfjYFACUcUEQdenPtCqOn1zCPE6oqwQdOjhecjs8bj7hSdMWE/81bO
	5xrfnr4mzCcugPn59scMxRS4a18Gkya7bWJrLU7gO56nCLvTAQ0r8ieoiac+618S
	XClmfWsGIKklfXPWx4n8SOTX1bJ7yhO8gicPWi854Y4WzRYg653bDAKGvyN40D8d
	DJTVkgadVtMQjuOxLGSv3BCJWEaoij0UW6qjvzBKuKTiWKc6lXcyq738yKH6otGY
	SzHSvWdS+8ZYEt/K1FQKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719958846; x=
	1720045246; bh=IPVHX16LbTeOoMwyZ1FrhOHGKcwF2+L0k84yqEHpcRo=; b=C
	mvlRRE1v9QEud7/88ydddrViWfl1+NGTyrNwKWfNvVEXAlp8wfiAGgERzWHnZQr0
	VKzL7B2DFNYDUKHEp6rAhmKUcVliyag8KRW1iQzaYxjvclNDjaNguXCDEJOBrT0U
	Rm3MH0qEGx9OoV1RN8PR59wG3XXjx4NwGR3V00IZ+tpEvNvf5rZAIQ6y4AJNiClJ
	lUmtNIeBQLUU8EmTT8GT92Lsf0ktUzNBpjwhYD+6mfnV+AA7e86uam18e3rXzOfS
	+6xSPYZfRioJhZE526oUNVNOwl/jSTwx8m2dYJkQa/FasESMgyl3gNEz9OXVFk7t
	3mt9j6qkAlV08QKz1/5EA==
X-ME-Sender: <xms:Pn2EZtoHNBSvLUAD4O7DJ6eo87DN70i-ydxYEB7ahe8S6PB4kZ3O1g>
    <xme:Pn2EZvpPI-pt8Jx6pfFe_e4wNmUAuIrQ3zvEmYBmilpTytwbk4rhUzc_3v8FJ6BlR
    d5k-We-lXWucyN-dTI>
X-ME-Received: <xmr:Pn2EZqMBvOiA6g8MxmyPKFJew9Khi_WvXGRqp0MRbzpYYxOL64FM6dt6alQMceisH7TdNmYKAt0H_H08WaycjZv37bRiejWsusQWmic-Sak-Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepjedvteetud
    fhiedvheegiedvkefgkedtleeftdetleejkedvueekheekvdfggfevnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Pn2EZo6QrCLRC4rk4L3GYq2MV9KMzMc82g4EDCnYonHlu3DK5tOQHw>
    <xmx:Pn2EZs7khHBin9iYfNrpko56Usn1enY_gQQxU3Sr098gb_cJB5vjfg>
    <xmx:Pn2EZggc9WCSMAq7baZnuyFUYMIlAqr4aDwHHRr-cPSAYhjVLWCsPg>
    <xmx:Pn2EZu6wibnUc3SG3p8owSAaZhkCTTdc2bPmhGckuwVYyYJQ7cH8mw>
    <xmx:Pn2EZsF9zsuPPsLYwZZUyeQTMWjBjZwQDYSWx_fLs4FiDCSywAA86aAq>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 18:20:45 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] firewire: ohci: add tracepoints event for data of Self-ID DMA
Date: Wed,  3 Jul 2024 07:20:34 +0900
Message-ID: <20240702222034.1378764-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
References: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 1394 OHCI, the SelfIDComplete event occurs when the hardware has
finished transmitting all of the self ID packets received during the bus
initialization process to the host memory by DMA.

This commit adds a tracepoints event for this event to trace the timing
and packet data of Self-ID DMA. It is the part of following tracepoints
events helpful to debug some events at bus reset; e.g. the issue addressed
at a commit d0b06dc48fb1 ("firewire: core: use long bus reset on gap count
error")[1]:

* firewire_ohci:irqs
* firewire_ohci:self_id_complete
* firewire:bus_reset_handle
* firewire:self_id_sequence

They would be also helpful in the problem about invocation timing of
hardIRQ/softIRQ contexts. We can often see this kind of problem with -rt
kernel[2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0b06dc48fb1
[2] https://lore.kernel.org/linux-rt-users/YAwPoaUZ1gTD5y+k@hmbx/

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c              | 11 +++++-
 include/trace/events/firewire_ohci.h | 54 ++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index c95f26c74e2b..f8d880574c19 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -45,6 +45,8 @@
 
 #include <trace/events/firewire.h>
 
+static u32 cond_le32_to_cpu(__le32 value, bool has_be_header_quirk);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/firewire_ohci.h>
 
@@ -2208,8 +2210,15 @@ static irqreturn_t irq_handler(int irq, void *data)
 	if (event & OHCI1394_busReset)
 		reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
 
-	if (event & OHCI1394_selfIDComplete)
+	if (event & OHCI1394_selfIDComplete) {
+		if (trace_self_id_complete_enabled()) {
+			u32 reg = reg_read(ohci, OHCI1394_SelfIDCount);
+
+			trace_self_id_complete(ohci->card.index, reg, ohci->self_id,
+					       has_be_header_quirk(ohci));
+		}
 		queue_work(selfid_workqueue, &ohci->bus_reset_work);
+	}
 
 	if (event & OHCI1394_RQPkt)
 		tasklet_schedule(&ohci->ar_request_ctx.tasklet);
diff --git a/include/trace/events/firewire_ohci.h b/include/trace/events/firewire_ohci.h
index 483aeeb033af..4f9a7f2577f3 100644
--- a/include/trace/events/firewire_ohci.h
+++ b/include/trace/events/firewire_ohci.h
@@ -9,6 +9,8 @@
 
 #include <linux/tracepoint.h>
 
+// Some macros and helper functions are defined in 'drivers/firewire/ohci.c'.
+
 TRACE_EVENT(irqs,
 	TP_PROTO(unsigned int card_index, u32 events),
 	TP_ARGS(card_index, events),
@@ -42,6 +44,58 @@ TRACE_EVENT(irqs,
 	)
 );
 
+#define QUADLET_SIZE	4
+
+#define SELF_ID_COUNT_IS_ERROR(reg)	\
+	(!!(((reg) & OHCI1394_SelfIDCount_selfIDError_MASK) >> OHCI1394_SelfIDCount_selfIDError_SHIFT))
+
+#define SELF_ID_COUNT_GET_GENERATION(reg)	\
+	(((reg) & OHCI1394_SelfIDCount_selfIDGeneration_MASK) >> OHCI1394_SelfIDCount_selfIDGeneration_SHIFT)
+
+#define SELF_ID_RECEIVE_Q0_GET_GENERATION(quadlet)	\
+	(((quadlet) & OHCI1394_SELF_ID_RECEIVE_Q0_GENERATION_MASK) >> OHCI1394_SELF_ID_RECEIVE_Q0_GENERATION_SHIFT)
+
+#define SELF_ID_RECEIVE_Q0_GET_TIMESTAMP(quadlet)	\
+	(((quadlet) & OHCI1394_SELF_ID_RECEIVE_Q0_TIMESTAMP_MASK) >> OHCI1394_SELF_ID_RECEIVE_Q0_TIMESTAMP_SHIFT)
+
+TRACE_EVENT(self_id_complete,
+	TP_PROTO(unsigned int card_index, u32 reg, const __le32 *self_id_receive, bool has_be_header_quirk),
+	TP_ARGS(card_index, reg, self_id_receive, has_be_header_quirk),
+	TP_STRUCT__entry(
+		__field(u8, card_index)
+		__field(u32, reg)
+		__dynamic_array(u32, self_id_receive, ohci1394_self_id_count_get_size(reg))
+	),
+	TP_fast_assign(
+		__entry->card_index = card_index;
+		__entry->reg = reg;
+		{
+			u32 *ptr = __get_dynamic_array(self_id_receive);
+			int i;
+
+			for (i = 0; i < __get_dynamic_array_len(self_id_receive) / QUADLET_SIZE; ++i)
+				ptr[i] = cond_le32_to_cpu(self_id_receive[i], has_be_header_quirk);
+		}
+	),
+	TP_printk(
+		"card_index=%u is_error=%s generation_at_bus_reset=%u generation_at_completion=%u timestamp=0x%04x packet_data=%s",
+		__entry->card_index,
+		SELF_ID_COUNT_IS_ERROR(__entry->reg) ? "true" : "false",
+		SELF_ID_COUNT_GET_GENERATION(__entry->reg),
+		SELF_ID_RECEIVE_Q0_GET_GENERATION(((const u32 *)__get_dynamic_array(self_id_receive))[0]),
+		SELF_ID_RECEIVE_Q0_GET_TIMESTAMP(((const u32 *)__get_dynamic_array(self_id_receive))[0]),
+		__print_array(((const u32 *)__get_dynamic_array(self_id_receive)) + 1,
+			      (__get_dynamic_array_len(self_id_receive) / QUADLET_SIZE) - 1, QUADLET_SIZE)
+	)
+);
+
+#undef SELF_ID_COUNT_IS_ERROR
+#undef SELF_ID_COUNT_GET_GENERATION
+#undef SELF_ID_RECEIVE_Q0_GET_GENERATION
+#undef SELF_ID_RECEIVE_Q0_GET_TIMESTAMP
+
+#undef QUADLET_SIZE
+
 #endif // _FIREWIRE_OHCI_TRACE_EVENT_H
 
 #include <trace/define_trace.h>
-- 
2.43.0


