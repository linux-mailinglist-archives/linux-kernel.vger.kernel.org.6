Return-Path: <linux-kernel+bounces-273846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D650946EE2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C981C20EFC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E117757F3;
	Sun,  4 Aug 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="gnaPNysJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lMw4/ZLx"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE256B7C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776561; cv=none; b=HbZH/mnknSxQl9u/AgeFYj8DhnwhJ0/fiZMed6If5y4mCh6n3yC51GhKHluyqKwS2o26RIWUo56hrt36s7+hkwAOw8+Gawu+zpjZGJnTfopea1NuckMV+fRKxSpGGwT9bxoBCL06TfFTRjgXbmrLpKpZFrfMfH/VqkrKLsgsXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776561; c=relaxed/simple;
	bh=cWH7ne9vlR3TeVR1Q85Yfp2ze/ZNy4hqU1VPnNmO3sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZaE3ZYHCpHGDDz9ZOnTtFinl2FQNP6TUxssEM/QroHYJkknTOzPiKa9jPx0TYVDjTQ8lAX/0ZPpndqhFeQUvf+qc9mBv28OD08bodg3ugOEg87AUwUljG6QSnzH6WgA+Xm1m7GV8TUITTQDaJB1Ain3ltXRCum0wBgWyrcXrP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=gnaPNysJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lMw4/ZLx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0163B138801E;
	Sun,  4 Aug 2024 09:02:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 04 Aug 2024 09:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776558; x=
	1722862958; bh=ylV0FAWwnqnELWHfpdHvBmEJyKerlndDqM/PUzAtIHU=; b=g
	naPNysJyaGopYZ5fgjSO4g90gA8Q1rKmpj0nji9jgMnXGnts3fIwdaS4GQ0F/aZD
	wFqAxOjZ9mWZIfN58KPjXZYtyc27GpWJMhybpJO3WqBRuxmMsawXX2pLezpibeXV
	aVXr9BO7dOxeNp84XHJArMGKMSjpRj/H3UvNO7T3gkAvmF798dVDHcGBi8y6Jscs
	BGgf1+5e+iPeQEkXkwuf1rIeVQ1AdmzkUA7HVQyvdYO4wnRtKtbZqDWbcxKxfPxq
	8tZGMP7j25jD9/n2721LxGp6WHn68awCW0MjUhwT6xN3l7WeNS8KLGr1XsMSfQoU
	R7daiFsQz/tQ7zjWcNVEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776558; x=
	1722862958; bh=ylV0FAWwnqnELWHfpdHvBmEJyKerlndDqM/PUzAtIHU=; b=l
	Mw4/ZLxSlRnbV2W9QRAbxs0ef+oIcTyYz5oup64YrPLF4cajYFbgm0lxRNygjE92
	/45rBUihM9XK8HkGOjR47Y1JmucpFNs8rVnJuF2tzJJhOncW6rQuIWxhcgwwUkHT
	OMxrpF3IlsPIUEoUZKM45bNDEgVcCzTYt3hz376qNFGd4jUcAJrY3gL5q1q/bkY+
	V0zDRM6csZQASWzcyBtAvHzWsiaB6TCefACi5s8Jlrpif5GQockNT/HDZNY51bld
	BOIViJW1a78dACzS16/tkTVgwJCzYEGq34gSr8Ovl2iuQmAxXo6EvSrgsgNTQDZx
	39ZklYxmCDRqlOPmoqN5Q==
X-ME-Sender: <xms:7nuvZr3Qls3DI7D-wQgQ0mX4y3zXe5L7K9VbqhGV6RjOGHD_jUxR5g>
    <xme:7nuvZqHK8qQGWYTBtc67PwpImFPk496wiv42TDncmdRobQG15LCu6ZAso1WtkSR-B
    ev7OVvU6q8EMgq9DZo>
X-ME-Received: <xmr:7nuvZr5EOb9w7kShflXu0cxOf0UA0AVnJjszr-1a-OUilvRxvJLltfO4beXMeBWsGUDrsoGaz8lTXJmPdoCUb_gRabpA1BWjQN8jjDf9FHeoNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:7nuvZg1lMEcLrhRY-yNvicWERs5Piw0ZMDtVUNv5iw4RQm8JYhcE6w>
    <xmx:7nuvZuF4pHTKDDVR7UbuI0rBAOUxENMxVY9KZ_3nNCbkNTd-_nXbRg>
    <xmx:7nuvZh869HxUzrV-EljkP0qUMK_4J7AhGZVQlrUk31l7UIbFYBoLuA>
    <xmx:7nuvZrkqZolV037ldm50LsfH3vJ6C_eSFbS3s-D9z7yok-UeWiE_ww>
    <xmx:7nuvZjRhlyQjE0YW3vzc7NohxUVn8270ZEgCCOCfdFoC-SOJdIyC957k>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:37 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] firewire: core: use guard macro to maintain the list of address handler for transaction
Date: Sun,  4 Aug 2024 22:02:14 +0900
Message-ID: <20240804130225.243496-8-o-takashi@sakamocchi.jp>
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

The core function maintains address handlers by list. It is protected by
spinlock to insert and remove entry to the list.

This commit uses guard macro to maintain the spinlock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a0224d4d8e11..a006daf385e9 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -596,7 +596,7 @@ int fw_core_add_address_handler(struct fw_address_handler *handler,
 	    handler->length == 0)
 		return -EINVAL;
 
-	spin_lock(&address_handler_list_lock);
+	guard(spinlock)(&address_handler_list_lock);
 
 	handler->offset = region->start;
 	while (handler->offset + handler->length <= region->end) {
@@ -615,8 +615,6 @@ int fw_core_add_address_handler(struct fw_address_handler *handler,
 		}
 	}
 
-	spin_unlock(&address_handler_list_lock);
-
 	return ret;
 }
 EXPORT_SYMBOL(fw_core_add_address_handler);
@@ -632,9 +630,9 @@ EXPORT_SYMBOL(fw_core_add_address_handler);
  */
 void fw_core_remove_address_handler(struct fw_address_handler *handler)
 {
-	spin_lock(&address_handler_list_lock);
-	list_del_rcu(&handler->link);
-	spin_unlock(&address_handler_list_lock);
+	scoped_guard(spinlock, &address_handler_list_lock)
+		list_del_rcu(&handler->link);
+
 	synchronize_rcu();
 }
 EXPORT_SYMBOL(fw_core_remove_address_handler);
-- 
2.43.0


