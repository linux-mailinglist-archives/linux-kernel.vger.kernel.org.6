Return-Path: <linux-kernel+bounces-213269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943A2907353
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE726287583
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA7145320;
	Thu, 13 Jun 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="h/BaPTUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MfT/OxSD"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4036E143C46
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284495; cv=none; b=gDOQ1/RRDiNQ6QV6jwjEjodcA4kgY9bIrAl1KT6u+Uylzkjc59E7hs4+PAo0QWdqGcYulCxXKGbObgPN69h1Z/+Mvi4rjwLM8XC6+Qidth6+pCetPLDc7KlOyMudSuvjz51A2JpRI3DjyAwU6Onz7xTvnYK8MWaiJugRohE+g4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284495; c=relaxed/simple;
	bh=Wcfvjsc31U61Lz2J2HCCtjnjbOjubcBE6IHU4lEMHFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDpUwlZ57RWysAqWZNgGfwlIyq2aqfpG+MM9/tmjWhdrIaZlsGiVZjzcLujOziO6IqZTGJlPoH1O9C6y2uV/rAZsPmThRZCpLBAC33u5TW3CEheLcCFhpRS8w7xtl+nFy/L36eiIhwyQ9VTfsJv+PBBjo7IBXCFNM5LF3GiJAJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=h/BaPTUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MfT/OxSD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5FCC613800AF;
	Thu, 13 Jun 2024 09:14:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 09:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718284493; x=
	1718370893; bh=AGsv0aysTD3ZzDyuMSeXNAH/CM0Cg2AP7pJ8uuAcP8M=; b=h
	/BaPTUw2CLEZtN94+3IrZ7aXazkU/pdR/IUfy/HSUR0uRLiUPVIKMZjx16O96FGB
	EHt9Zs87ia1b97ClzUyDJNRgOzVRERDEcziWDuCpbu8h7+zkPNRFitugUok4Dx3K
	SNnGlskUPQbq1NQOY9XUXtTi5/Hgi1zrOPyFEcQ1l+KOcuW02IMLakVoAshsN4pG
	jHT3b2jqkyPonjsOOD9+S60EFWZqtYJKQRht97RUdKkW4o9Abtux8ztzd6bphKDB
	uRQdk82rQARF7V4PGY8uXOsQPkchzUHpeD7KYAofnUse18NGkpA1N+dqVa5Z7pkp
	EIdduoDdogYPHzHQVpupA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718284493; x=
	1718370893; bh=AGsv0aysTD3ZzDyuMSeXNAH/CM0Cg2AP7pJ8uuAcP8M=; b=M
	fT/OxSDC69y6iphM7EprcDjh5vlo9SqaefE7d0MICAQwlkKDh5Ma44YWNZaQ+8Jj
	ga1+P8SNLclcxo0uGlmNFzDCnBUSunZstXlvzJ27FiC5ltguMylvb4HPX3zYQISs
	MMdTg2SX88StPEJ/NlRYw51DxC92P40TUb7PdlcNcsw+5D5wRsurFPcpceur52c1
	RVfpS62zKkGOJFDiJcD1KlweJaPSlW5EFC5tInUdKNOYcjl2q9e8LfW1c7JuwYoH
	oUR8bVZzdPHFEAmNOt98MqIu83eLGppSdeYAI4wVq1hCqumJQFq9uBJQExcKXRHO
	ADJd3AxfxzSuc4bWONnVQ==
X-ME-Sender: <xms:zfBqZm3jALAEP27JUEdmXCLB9HYZMcbjDiUfyrQSnzrjXz_aXclQxg>
    <xme:zfBqZpHfJjOz81B0uTIoKSgDxQ3sZuSpApixZrFP2Wv5YbRa7J-iYkoMM1wSuJKYu
    A3YfaSt9paUGSLK43M>
X-ME-Received: <xmr:zfBqZu7OdYMVsjKIAGyET1HedcCxHmjR3euVAn0_Obf6GXz1Gzi-I10KfX838o44fRdun4mLFUFtvt-JJDxZ0Xd7-ZwRsvy4zZjJ4cWBNPUvGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:zfBqZn1bXj1Yl1u3OU716NxgfZtyrMVeAEaYxdKnDtM8CZ9cqtL9Yg>
    <xmx:zfBqZpEG3-CzVpPq98jA9IqzrLCZcGm9jRGTddXfRqtxbFtj6AMi0A>
    <xmx:zfBqZg-ubmsf8UoUii_o_HOZY-fVUeCk03nvX9KfoWfjrpqxA96veA>
    <xmx:zfBqZukn8xiBcC5aAoU9XAGu1-sFfPDXp3KUfYbZ0RZMYOgYfuu79A>
    <xmx:zfBqZuT0k0BimhAtdmjmg0S1V30xp_AqgsFpMcasV5AXokBsegdDyxQe>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 09:14:52 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] firewire: core: record card index in async_phy_inbound tracepoints event
Date: Thu, 13 Jun 2024 22:14:38 +0900
Message-ID: <20240613131440.431766-7-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613131440.431766-1-o-takashi@sakamocchi.jp>
References: <20240613131440.431766-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The asynchronous transmission of phy packet is initiated on one of 1394
OHCI controller, however the existing tracepoints events has the lack of
data about it.

This commit adds card_index member into event structure to store the index
of host controller in use, and prints it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 2 +-
 include/trace/events/firewire.h     | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index bd5a467cfd60..76ab6a209768 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -997,7 +997,7 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
 
 	tcode = async_header_get_tcode(p->header);
 	if (tcode_is_link_internal(tcode)) {
-		trace_async_phy_inbound((uintptr_t)p, p->generation, p->ack, p->timestamp,
+		trace_async_phy_inbound((uintptr_t)p, card->index, p->generation, p->ack, p->timestamp,
 					 p->header[1], p->header[2]);
 		fw_cdev_handle_phy_packet(card, p);
 		return;
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 61c7a2461fbc..e5524fc71880 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -271,10 +271,11 @@ TRACE_EVENT(async_phy_outbound_complete,
 );
 
 TRACE_EVENT(async_phy_inbound,
-	TP_PROTO(u64 packet, unsigned int generation, unsigned int status, unsigned int timestamp, u32 first_quadlet, u32 second_quadlet),
-	TP_ARGS(packet, generation, status, timestamp, first_quadlet, second_quadlet),
+	TP_PROTO(u64 packet, unsigned int card_index, unsigned int generation, unsigned int status, unsigned int timestamp, u32 first_quadlet, u32 second_quadlet),
+	TP_ARGS(packet, card_index, generation, status, timestamp, first_quadlet, second_quadlet),
 	TP_STRUCT__entry(
 		__field(u64, packet)
+		__field(u8, card_index)
 		__field(u8, generation)
 		__field(u8, status)
 		__field(u16, timestamp)
@@ -290,8 +291,9 @@ TRACE_EVENT(async_phy_inbound,
 		__entry->second_quadlet = second_quadlet
 	),
 	TP_printk(
-		"packet=0x%llx generation=%u status=%u timestamp=0x%04x first_quadlet=0x%08x second_quadlet=0x%08x",
+		"packet=0x%llx card_index=%u generation=%u status=%u timestamp=0x%04x first_quadlet=0x%08x second_quadlet=0x%08x",
 		__entry->packet,
+		__entry->card_index,
 		__entry->generation,
 		__entry->status,
 		__entry->timestamp,
-- 
2.43.0


