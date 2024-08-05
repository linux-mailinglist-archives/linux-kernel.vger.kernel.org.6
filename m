Return-Path: <linux-kernel+bounces-274388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72D59477AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D711F22401
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3051547CA;
	Mon,  5 Aug 2024 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="F6wgqHZX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SB9bGZBy"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCE15350D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848059; cv=none; b=uBGe2HAC3LT4Gyxn6J/P6vTJUHOMD5T9kNqYSuhDFNrWRBdUDTFWWPvIQMintsaOmaI6hixOa+ty9MJVx+3H0tlaOV+dvfwg4qF7hbgLXF0xz7BR0QxwZvvHZA0PY3/xdxOOGxBdYc+0dqKKgpqTVFgZeCd4HhwfVeJISkplt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848059; c=relaxed/simple;
	bh=vA0kDygfFj7ZpFqinqieUC76/4F6R76Vd+hTvrPc/oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk3RHLoluIakkHZKtRQWA+ku6nUp7RGczHsYl/zwXdyBeYlRyeMNrn/dHOmrr/GCGHDnDJTGpY4sCWVWd+MEIwqVjiU8glQVjPPC0HtU7HCysot7KLFeHjpyFY66Bwsjb/XyGnLQRtPASe25aUSLJtMQWSxB7EKIHpAsMreL5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=F6wgqHZX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SB9bGZBy; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 614531151CA6;
	Mon,  5 Aug 2024 04:54:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 04:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848057; x=
	1722934457; bh=umV/dIhWSMe39OeV812KLlWHxNO+f3xTH4ZsEWLWI7U=; b=F
	6wgqHZXg39kTnm3T8j5MRN6vGAeUXp2OzE8Y0e+DEq9klB7sl9hbs84ua+dbe9oS
	GXTJepztE2mFJsGLSZ6XMQUmdL//kkFt3C0xo4m8J1Y6//kIWCPcZGypuF7S8uy4
	tWS79sVwWi5C3+kG9R/QepEApYZjVWi9yyEIbvY3+LHXvgIuCNnM1FFPSYMCZzzN
	jlwIdcGkTbf1r/toTyXL1IMBDtwvP7UcOY+XpEIoqficDuYKjltm+nMjFj5ZZVVk
	c0iFPxJBawM1HsBunt+J7C7xUVYBw1jB4EcP0UoByplzWXY0IV7qg4L1V7MVLy0A
	OpBOA8SA6DuoGQbbrSOTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848057; x=
	1722934457; bh=umV/dIhWSMe39OeV812KLlWHxNO+f3xTH4ZsEWLWI7U=; b=S
	B9bGZByiULOj/sr3qcsKlDy78dwcDrYDB2EH4hcusTdb76Rfx8ldEpgTxRB/KV/O
	QVScxOp44U8K27FhsNqpBw5SAbZBHizuTG8H/g7vrfMoDoZSWd30O34pwz0xppTm
	qAABLlN0x9Aze7emnYBCjFWIDYxCYfnwY8H5PZfBmI0i3zIq3cM/NXqftEHjodWO
	X83HrIg4KiSkJE2NiCow1jYnTir+SEB3IjNFwWO0F9ACyfdKRIWQcZcc+PthwGFe
	sxTTzyaHgukJLpmuwjaBVFPIOULon9OEDdqCBHgO2JIVwyRKyv4lX26fcznpa8z/
	lEx7Xpp5CT8j5R//J93bA==
X-ME-Sender: <xms:OZOwZvNvko3_KwiN9GJFY29zskWLYi30wsXpORUr7hXGhf8f20Xq1Q>
    <xme:OZOwZp8Y6A0yN1Pvt6IKebyI7wcsctQTRTdjU18gFfxh8bpj3tCnafmC4dWQcu9LJ
    5tlQ6ILhjrImEG0Xl0>
X-ME-Received: <xmr:OZOwZuSt5f2PBz8O7GeTjKGTcRX_3VWE9K9rcd-4hu_UFLUfP13FBTECV78Kz6GjIQBSU_IB0W3WkuC-Uz4VEMAm_CTjPuFQF9429vlI7as>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:OZOwZjtOGcBxyTWeFldp-biqUVtD4qJYQOW3x4kERjRhbgs1Ig8GaA>
    <xmx:OZOwZncVtwtYAJR_xHE1gx44ME1UNPD1fKtBHA7R5CuCiBXU7-z9Zg>
    <xmx:OZOwZv2p1_aS0pT8jacpxEqKuJ6732tWG9zJJu2SSZuPCI3Fajgaqw>
    <xmx:OZOwZj9AZmohn-NLPUk9DmpAotr5XBEKUIx14DOWxz-BqlaUuP8LSw>
    <xmx:OZOwZoq67PjfYZFIrpb4UNypC1KeTI-drGyBXgKUKD2dMFjfdF990MEp>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:16 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/17] firewire: ohci: use guard macro to serialize accesses to phy registers
Date: Mon,  5 Aug 2024 17:53:55 +0900
Message-ID: <20240805085408.251763-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
References: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
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


