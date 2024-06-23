Return-Path: <linux-kernel+bounces-226467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9F1913ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673C3B21A55
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07225186286;
	Sun, 23 Jun 2024 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="POKsJ8Hz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AvIQiElL"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1BE1850B9
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180551; cv=none; b=RRjMlDtakhFGCAjo6gSESU9iLwW6vhJjTcv+TJ7N2B1GIHA177SagM2COiXlXswIxOeBS0y5cqKfiTMtAKVO0+3P97Y4CyH++UBIN3bk5S1ep3ZW9KVl3qC1K2J2P6+XCOWs/kGat3BMvA9czw/hG4XTmatPNKG5b4zKmHhUhGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180551; c=relaxed/simple;
	bh=HXrtdMUXU39wpFP+4ZpRUgY7DK+YqaxnrygaUGqq2k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUjKP9YwXfFIHwFNDAUQ1Z2AAb8lJhOzOS6PLDnEgbPqqSqvGglZC5A13hl2YI0Fe2de1gqPggxV9JzFAVa0sgz52MVa8OE8yZ+CDmXP8CoX/p/+mVgwKAt1LAbX3PNfkvgcglJwoayvvKWVduCJKPq9MbzxIt/tIfrY/Nq59Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=POKsJ8Hz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AvIQiElL; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 77EF8138022D;
	Sun, 23 Jun 2024 18:09:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 23 Jun 2024 18:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719180548; x=
	1719266948; bh=WCYv0QpMzYje5FW2V+N1G/dKlMR0j9LxZBRZVImqLBc=; b=P
	OKsJ8HzyQF7U8fIh+Npa1z131vIyr9so5aJRtWSmp+4dCJFD0pVbo76G6I6KP1qb
	Zzgyzim6XI9Z68oFEF2LzNO4JGWVoFLEopJYJcJnQXk9jUysjuaJ2SkhC+khoug3
	OKWvuB0MMTSFgpJSvRdOaYCXwx7iQGRKQyV8r6yHHXJxBbHGBEb5modsQ9ehYqQb
	6Qw2xI9unUgWwjftK4noyqTGKXsJMaIIfS6jBKZ5Rx3D8bPKy7ChUwII7V3JSgBR
	Tgm9PiZqBc1mv8jh+5dG5UI58qqPXWUEWHEilWToxCiDc3nw5B7nxwmWiLgXEOGh
	iE/0TAZXfw6LG7RRhsy/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719180548; x=
	1719266948; bh=WCYv0QpMzYje5FW2V+N1G/dKlMR0j9LxZBRZVImqLBc=; b=A
	vIQiElLcy5LFYPIePEummmHGY8n+b894HsXt4RL62lcH9kVV55sS/DMd60ibaRg9
	m93if47vKqeD9BSnAk923JhIekeLHWUk8mFsZhLhNPNEdUCWkpfOpOE0y/1DyX1b
	cNVOsFeHFl/O8NNJxKPdEur980Y7k6tq5JUA9282bQzDjl/4y7xC2CCPjY8f2XvI
	k58ySyW8AauSpAX+6SNkbpbXcUZbpq/Kc5m2zxP6+HIcLU+Ra99+JP98c8rdBDKh
	ZJ1xm3nU5Tr/jm/cp4R/pC+IE0Yrlg/8aVi6YF3caF08iLR5B+/DCD1P/HUexCNR
	XmeIL2imyNZrKUJvbC+6Q==
X-ME-Sender: <xms:A514Zo3b1BEGfAbCQdvHZxDw2p56N3Cu3uarbbQCeJ_OsR77KxKpLw>
    <xme:A514ZjFF1MidnzAXEnDcGcFxAJuHoRSqylV8eM9IujJ-u7BTqkSIMyggSsgAYecu8
    wdsaayGOv6jVqRbBkw>
X-ME-Received: <xmr:A514Zg7UF3drzRWwgC6p9yGi_LdjydL6aIIVIyMLscJWmiV967AGp0DgLlDziDzLkBVfOezH3AQiVZTE9UzzlweJZYR8UwdLqCqdNIkbE04_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegtddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:A514Zh1KdQPB6l_QZWqtOmEB4n3HztADhC0CLQ_wbkMO7IuVM1v6fw>
    <xmx:A514ZrFgho64Jx2SOkCtw1LFqZjDPEBKnTNfCxQG1ykYYjxgDn_BLg>
    <xmx:A514Zq_NKIx4rzirKdq-ZZv4-VNelVttSBBJIB_jzpzLxIqyVeFIzQ>
    <xmx:A514ZglfHCharB5y0fdLJvI4KJu7UXV76EWwcyS8q01N6b7fUOL15w>
    <xmx:BJ14ZgRzwHqfnFft1TMgnOOOtyreOvAJ5jkJwOBs8Xq6kxiW2TqLZOdS>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jun 2024 18:09:06 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] firewire: core: add tracepoints events for setting channels of multichannel context
Date: Mon, 24 Jun 2024 07:08:53 +0900
Message-ID: <20240623220859.851685-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623220859.851685-1-o-takashi@sakamocchi.jp>
References: <20240623220859.851685-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is helpful to trace the channel setting for the multichannel isochronous
context when the core function is requested it by both in-kernel unit
drivers and userspace applications.

This commit adds some tracepoints events for the aim.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-iso.c     |  2 ++
 include/trace/events/firewire.h | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index ddb999297c72..7ec84de846e6 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -177,6 +177,8 @@ EXPORT_SYMBOL(fw_iso_context_start);
 
 int fw_iso_context_set_channels(struct fw_iso_context *ctx, u64 *channels)
 {
+	trace_isoc_inbound_multiple_channels(ctx, *channels);
+
 	return ctx->card->driver->set_iso_channels(ctx, channels);
 }
 
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 0cca1ef841f3..0334e02f9d94 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -541,6 +541,27 @@ DEFINE_EVENT_CONDITION(isoc_destroy_template, isoc_inbound_multiple_destroy,
 	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL)
 );
 
+TRACE_EVENT(isoc_inbound_multiple_channels,
+	TP_PROTO(const struct fw_iso_context *ctx, u64 channels),
+	TP_ARGS(ctx, channels),
+	TP_STRUCT__entry(
+		__field(u64, context)
+		__field(u8, card_index)
+		__field(u64, channels)
+	),
+	TP_fast_assign(
+		__entry->context = (uintptr_t)ctx;
+		__entry->card_index = ctx->card->index;
+		__entry->channels = channels;
+	),
+	TP_printk(
+		"context=0x%llx card_index=%u channels=0x%016llx",
+		__entry->context,
+		__entry->card_index,
+		__entry->channels
+	)
+);
+
 #undef QUADLET_SIZE
 
 #endif // _FIREWIRE_TRACE_EVENT_H
-- 
2.43.0


