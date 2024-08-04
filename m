Return-Path: <linux-kernel+bounces-273843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26AB946EDE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8771C2822A9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7490C14277;
	Sun,  4 Aug 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="hcTiCBRM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TgLILsy2"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47283BBE9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776557; cv=none; b=UzZsq+1d6kEXxRC/P2E0vCHJc+CrQ/TE17mfAAJo3WwfmeStuvxFTMOBHERdGjjQOKclwUaaMW4pPFA8uspqZG6mC9E/orJ7NzPw3gtMHfdjY23SyjTqI50xF48l6daUszWazcZZl/D1CDEPM49QR2nBGQlYhQkqT+7wBfJ248c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776557; c=relaxed/simple;
	bh=vA0kDygfFj7ZpFqinqieUC76/4F6R76Vd+hTvrPc/oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiK+m5YD7RqupgnlVY2MPXbpxSRgmaOJYgiUWqfUt5NtmDtrVFZ8kkXK7G/if5OH736JqdrDZFHH6p1caIJEJSHZp/lqgwCql++Zs1MzSvR4wykqEr1fIaXOI6ez0PXsFcQax4HoGhPijMbvfg4UgsyoYy1qNdFP7dlVBSBPf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=hcTiCBRM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TgLILsy2; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EACC413807E7;
	Sun,  4 Aug 2024 09:02:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 04 Aug 2024 09:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776554; x=
	1722862954; bh=umV/dIhWSMe39OeV812KLlWHxNO+f3xTH4ZsEWLWI7U=; b=h
	cTiCBRMHcnfZcrEhwQIemboRFgT4OhvxPVVIuUd0kiYkF/vy/IlXXVeveEAb2szV
	kXuXhbWDhRN3P8+8KkMScvxKf854rBUNVjEpepAj32Y7T1OUhzbu9Xw8V8OG4pjG
	vCz9Q8kpNzyuEnOPQ1r8c8p9dAIu1ZCdOmo/8CEzhXP/DqVTWxVzR7scigNnNi64
	38WBCz4JqEMKB2rjwF9N4sOh3wPjbEtqqfo89CqXVlCWBoPxi01qJm+65kxae7Iu
	0PuGHAll/sWn0m9HM5RpZExKHBUbjse6rw+f5pow9FeVF2Ou+VoQWncQueVk2kqe
	pZ+XedhDE0EkopN/fiulg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776554; x=
	1722862954; bh=umV/dIhWSMe39OeV812KLlWHxNO+f3xTH4ZsEWLWI7U=; b=T
	gLILsy23ycuxII2aVp9gPz8CbzA7O7MHV5dIwDQeOchKOQnXIow7lsl5UBObO3Ij
	xtZcBG9tfQHJDmXerFiNsknfjFkWRD0p7RXkTLKqVSA+veuxdwR/c3nL7a3iyPA5
	62SnIY03plDbQsFqS/Q7Q26uZgSiESpsvF31jSJBnxGxs+koViENMdKVx6xwiCVW
	hgbafr0aVSysqRrob4e2NkzZ6Kf/lF3aV2N61fG8UdSjrlW17wu9Iw7yq+U1v2Zn
	T8Q0ZAbg3G9UgG/EHoNy4nrRrdLZCi7/Otj8U+UyVdlPdaXRnzZ4I0c5SoIOL9hq
	e8Hp2xaQccyLwhCOpI0BA==
X-ME-Sender: <xms:6nuvZvgpjWESoyt_ELMGRaiuD4nzodpBit02Hq0sFKwqTX_sFOvBzQ>
    <xme:6nuvZsDKZWUCOL6yrVDBp809S_a_5JO0wuh9XwXssb9y03ziroI3ExwZIkIIWZVaC
    saWAH51vsu25cF22cE>
X-ME-Received: <xmr:6nuvZvEr4ABNBfRdvjha5ojza9eOU4FmlgOvBmPu1crU2Otvf03H6BD1oUvInayUeaHomfSujxd8mo47a72FBoIv5TF95Cm0oSImtIYy7YQ-pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:6nuvZsSn_IvbPFgGyV4Dg84kRLF8BsZFcNB5YqisWxyfAIwcOT20Tg>
    <xmx:6nuvZsxKQXaePv4-3wX6GqoXaswKsXEQFebH4bH9-KOQQuCLH9a_9w>
    <xmx:6nuvZi699l9f6HRwGuCC2VmOKDxJsI4NK7qqzxIdhZDl5-rjYb3wcw>
    <xmx:6nuvZhxyC0feluFLQS3LdiQtaUk83vQapzDP8LM-Cnaytk5sDdi5xQ>
    <xmx:6nuvZn9lJgyAWv6ktOU8UKBP3Qgv9DtooDRIO3Rh7lkKBWYpYFPpbvWM>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:33 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] firewire: ohci: use guard macro to serialize accesses to phy registers
Date: Sun,  4 Aug 2024 22:02:11 +0900
Message-ID: <20240804130225.243496-5-o-takashi@sakamocchi.jp>
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

The 1394 OHCI driver protects concurrent accesses to phy registers by
mutex object in fw_ohci structure.

This commit uses guard macro to maintain the mutex.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 71 +++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 8f2bbd0569fb..1461e008d265 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -713,26 +713,20 @@ static int read_paged_phy_reg(struct fw_ohci *ohci, int page, int addr)
 static int ohci_read_phy_reg(struct fw_card *card, int addr)
 {
 	struct fw_ohci *ohci = fw_ohci(card);
-	int ret;
 
-	mutex_lock(&ohci->phy_reg_mutex);
-	ret = read_phy_reg(ohci, addr);
-	mutex_unlock(&ohci->phy_reg_mutex);
+	guard(mutex)(&ohci->phy_reg_mutex);
 
-	return ret;
+	return read_phy_reg(ohci, addr);
 }
 
 static int ohci_update_phy_reg(struct fw_card *card, int addr,
 			       int clear_bits, int set_bits)
 {
 	struct fw_ohci *ohci = fw_ohci(card);
-	int ret;
 
-	mutex_lock(&ohci->phy_reg_mutex);
-	ret = update_phy_reg(ohci, addr, clear_bits, set_bits);
-	mutex_unlock(&ohci->phy_reg_mutex);
+	guard(mutex)(&ohci->phy_reg_mutex);
 
-	return ret;
+	return update_phy_reg(ohci, addr, clear_bits, set_bits);
 }
 
 static inline dma_addr_t ar_buffer_bus(struct ar_context *ctx, unsigned int i)
@@ -1882,13 +1876,15 @@ static int get_status_for_port(struct fw_ohci *ohci, int port_index,
 {
 	int reg;
 
-	mutex_lock(&ohci->phy_reg_mutex);
-	reg = write_phy_reg(ohci, 7, port_index);
-	if (reg >= 0)
+	scoped_guard(mutex, &ohci->phy_reg_mutex) {
+		reg = write_phy_reg(ohci, 7, port_index);
+		if (reg < 0)
+			return reg;
+
 		reg = read_phy_reg(ohci, 8);
-	mutex_unlock(&ohci->phy_reg_mutex);
-	if (reg < 0)
-		return reg;
+		if (reg < 0)
+			return reg;
+	}
 
 	switch (reg & 0x0f) {
 	case 0x06:
@@ -1929,26 +1925,31 @@ static int get_self_id_pos(struct fw_ohci *ohci, u32 self_id,
 static bool initiated_reset(struct fw_ohci *ohci)
 {
 	int reg;
-	int ret = false;
 
-	mutex_lock(&ohci->phy_reg_mutex);
-	reg = write_phy_reg(ohci, 7, 0xe0); /* Select page 7 */
-	if (reg >= 0) {
-		reg = read_phy_reg(ohci, 8);
-		reg |= 0x40;
-		reg = write_phy_reg(ohci, 8, reg); /* set PMODE bit */
-		if (reg >= 0) {
-			reg = read_phy_reg(ohci, 12); /* read register 12 */
-			if (reg >= 0) {
-				if ((reg & 0x08) == 0x08) {
-					/* bit 3 indicates "initiated reset" */
-					ret = true;
-				}
-			}
-		}
-	}
-	mutex_unlock(&ohci->phy_reg_mutex);
-	return ret;
+	guard(mutex)(&ohci->phy_reg_mutex);
+
+	// Select page 7
+	reg = write_phy_reg(ohci, 7, 0xe0);
+	if (reg < 0)
+		return reg;
+
+	reg = read_phy_reg(ohci, 8);
+	if (reg < 0)
+		return reg;
+
+	// set PMODE bit
+	reg |= 0x40;
+	reg = write_phy_reg(ohci, 8, reg);
+	if (reg < 0)
+		return reg;
+
+	// read register 12
+	reg = read_phy_reg(ohci, 12);
+	if (reg < 0)
+		return reg;
+
+	// bit 3 indicates "initiated reset"
+	return !!((reg & 0x08) == 0x08);
 }
 
 /*
-- 
2.43.0


