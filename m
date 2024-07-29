Return-Path: <linux-kernel+bounces-265865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0714193F6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B9B1F22A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B5A148FF5;
	Mon, 29 Jul 2024 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="m/8rkA9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0tWsoJ+"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200615530C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260803; cv=none; b=J9Ze3qZcKJM1/onag5SA5hCRrQqEiLWNf1R9MkFL8xWr/YKG5bgKfD01+PmsFSi0xCDk/JK4YGfTACv24flU5JTyTEF5X2VsCcTNQ5N2dg799v+6o6b0TNOX949jlmU0QdP9z2GZ8D96MQpw99jYSW0IY2xwEw5xL++EJPURltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260803; c=relaxed/simple;
	bh=6u4YK7HIh8qzxvNwOc536bUNAr0nGICv+grHBPnyhYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaYll5x8RrOwUUgFoqi+omkF8AKl/9e/3Y+j13b09JDyCh5DqepOlg/rKjzE0KlyOsxdE9s9xkNesl88zgaF0a1VVGfNi4c9vOWkjvJzFGaPso//XMJe1pY82D+044WGfr7A/KD8af0D2gXKPfiGBNm3GFftUkQ8eSm+NDmdocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=m/8rkA9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0tWsoJ+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 07F24114018D;
	Mon, 29 Jul 2024 09:46:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Jul 2024 09:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722260801; x=
	1722347201; bh=j6bWCSRv+RuSR+rObc2XVVpxBOoLwKSQSviTJPiNqUw=; b=m
	/8rkA9jZLDzEL2K0EEWBwCNxpzLlA74zT47+ZDjErKcPgHLrN45zHs8QQ5oB5/zd
	KTjlyzkReQPt1BIuFUWYvcSmfrlZ4ViFN7c5DfmrhXDYWEf/rBToqGIlsc0EaFRw
	OgYSOwoSgXL9Rcd1uZ9tSJfQxhWxfElwzoGjFWPHhlVVkOIocbG+q7064HJpiwxN
	KUsyfmfD0mt6taju7biOS+RglMpxh07cs0+NP/I/41OInCapyxZKckl5DPnNgoBe
	A4xQHIzYohHqwjs6llKsfGXKNb6PMy6nU5uniqq5UUiEVFFrIfyiBn6ja85gqJPM
	zc5exFH/yoJO9XOptaHew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722260801; x=
	1722347201; bh=j6bWCSRv+RuSR+rObc2XVVpxBOoLwKSQSviTJPiNqUw=; b=Y
	0tWsoJ+6jO0E5mjTVUOsKm8IrIO0SBhe0njhLT9CvMHCyYrRiMZ8R7pUKDDZPmuW
	6nCddeZxNi1Fa4c7of8zroREcTgIowzc8GF8r4vqbDiIMBYRuIvZ2xzaUWYLgEvx
	cPe1FUhlZnX1hPmh2LpGHwwlMFxc4RvTP3/xKrI1F3TPs514gIUhwXVc82PpxuqU
	vD/AQJVMAcFmy8VlQAVq3S/yEjZrzSUJkc3wjuolbqsR0cvlW2BUkuxI+/0huZkS
	Ve/8fREsnUctghU7OOJz3lqYSUHpT3k71pUbifzfFNjepNFE/CrKjckMJXGItQaf
	Q0o2S8zrbS7HwXgJfKN5g==
X-ME-Sender: <xms:QJ2nZjb8OrDvqfLASShup9wL-ZqcHcISTHhRgcfzxb-ZisCjMhuAAA>
    <xme:QJ2nZiYDdKUJPvfMdNQCEhJTEHHb0XWC89GbSAFWWDDDpHICqSQYuJ3VV7Pj23mn7
    KS7ioPp0_nvffNOEqE>
X-ME-Received: <xmr:QJ2nZl_ToX8hUmOGIGLK9VstK6K6ubsTnLAuyD9jj7CVKTSWagmi0f6tCvL5R452CqHZKwFsZ-csJ3z6Z_n9GgFBDH_tdDWGsnnYHBnnrzYbdAk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:QJ2nZprFRT4t_KJAYOz9fmER7sFt2s0D3tqIuGu_-5EeNKE9N9HYFw>
    <xmx:QJ2nZupCeSXb8sCkbENTWB4ekxKqbvCG8Uuug6Lj_hkxmp8w43018w>
    <xmx:QJ2nZvRVXgNcWEh2gyjwnF6nu5YbMoR8IVk9YfasNq0DsZmhYVhwbA>
    <xmx:QJ2nZmpi8Xffndplh9_exiDJob9e5kuYQ3hvwVMZKMFmTKQlnnodig>
    <xmx:QZ2nZl0DzuNnH3mfJLhm7kSX4hiD75Lk0VvMGRncncVKTzLawk2pG_Gz>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 09:46:39 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] firewire: core: use common helper function to serialize phy configuration packet
Date: Mon, 29 Jul 2024 22:46:31 +0900
Message-ID: <20240729134631.127189-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729134631.127189-1-o-takashi@sakamocchi.jp>
References: <20240729134631.127189-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common helper function is available to serialize the first quadlet of phy
configuration packet.

This commit is for the purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c        | 4 +++-
 drivers/firewire/core-transaction.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 9a7dc90330a3..619048dcfd72 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -37,6 +37,8 @@
 #include "core.h"
 #include <trace/events/firewire.h>
 
+#include "packet-header-definitions.h"
+
 /*
  * ABI version history is documented in linux/firewire-cdev.h.
  */
@@ -1635,7 +1637,7 @@ static int ioctl_send_phy_packet(struct client *client, union ioctl_arg *arg)
 	e->client		= client;
 	e->p.speed		= SCODE_100;
 	e->p.generation		= a->generation;
-	e->p.header[0]		= TCODE_LINK_INTERNAL << 4;
+	async_header_set_tcode(e->p.header, TCODE_LINK_INTERNAL);
 	e->p.header[1]		= a->data[0];
 	e->p.header[2]		= a->data[1];
 	e->p.header_length	= 12;
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 4d2fc1f31fec..a89c841a7dbe 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -464,7 +464,6 @@ static void transmit_phy_packet_callback(struct fw_packet *packet,
 
 static struct fw_packet phy_config_packet = {
 	.header_length	= 12,
-	.header[0]	= TCODE_LINK_INTERNAL << 4,
 	.payload_length	= 0,
 	.speed		= SCODE_100,
 	.callback	= transmit_phy_packet_callback,
@@ -497,6 +496,7 @@ void fw_send_phy_config(struct fw_card *card,
 
 	mutex_lock(&phy_config_mutex);
 
+	async_header_set_tcode(phy_config_packet.header, TCODE_LINK_INTERNAL);
 	phy_config_packet.header[1] = data;
 	phy_config_packet.header[2] = ~data;
 	phy_config_packet.generation = generation;
-- 
2.43.0


