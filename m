Return-Path: <linux-kernel+bounces-273855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CB946EEB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AA61C21005
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CD769DFF;
	Sun,  4 Aug 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="sWfOarf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uL3z1km6"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDCD13B787
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776573; cv=none; b=PD+rgWYge/923UjeqyVOTbI9X8fZpFCH3Brl1pEUYMWCcRWQuhYHYDJyzEXza82i8SZV7q3Xt0CxJrsoQezlgJ6ZWBDXVvEYpOI4fwH+a60GQxqxfK/c9va1t2RKl8nsMuSPUGWSH2o6I2x6R0G9u4b0yW/+MvOzhe+IvvQs9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776573; c=relaxed/simple;
	bh=RQbpBuuhcdVRrS45TXow3FvE3qGBFt8WbWvDlTvxDVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyDVPxH5GzIlw7cjhWOBTuG/ZurCt2N9KtjqCQAk9DZwOFCBqoS5qIw94SJP0R0Izbu4hqgiRGwBUd+h1NN789OWsvHJ6EpZ6PHSvxtTuW9mrR8+ZF6WdpK5U/AsYMvmShhWgdDFjtcntkSvzl4aUx+lBNDvx3sCz0QC6aOHwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=sWfOarf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uL3z1km6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 024DE138801E;
	Sun,  4 Aug 2024 09:02:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 04 Aug 2024 09:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776570; x=
	1722862970; bh=oi4YF8S7QF5qtDuzwiUeYwReqaCDQcNumgOf6dEv5Us=; b=s
	WfOarf8pTTKkWEaVKu9pBTPICmfeNPNQnHPFPAPxY59lVmI7drnRcn3xXWqROPOy
	Twjb2bZaA2ID1VT7mgY7KLivKERvAEfryrJEN6pC9LCbRrUog8j9Jz9HfoOaL8EB
	/iL0i3bBwfJhFrbpGARPzIWj46NOw+cEl3BFWOssGXEVjkZ+/Lm93cjgj56HF+go
	VdV3GTNAwxMz1eogwPpp5kyqpTy1+iquS+zzAPb7L630JLJVI6EqeK0fWeSRpjv/
	5S6s/lsxJwLOCv3ABTHtkjOugoKtfSpv9dzkqbNXUrNu4CfdHBr6vxOMHIun34ri
	9EZlzpRThpP0XjOhRg62A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776570; x=
	1722862970; bh=oi4YF8S7QF5qtDuzwiUeYwReqaCDQcNumgOf6dEv5Us=; b=u
	L3z1km6hJFFOgL1MWoUp39QyfdlPr9Z7RiOmeVd/b7bFrzJGD1AeGSfLWExezhg8
	iiS4BwtMKwooNKvVJ1o4aSpeBRwJNmYXtX+GObrkWchGMi7rQrgBc1zJFBUZYOIH
	PlfSqd3YI+Cn8gryxZ8LpYtkHfweTvHe2ow/FVOYPuldgQQJHGzj4/AGoRfMvU41
	hSIZDYsJEeevYAnyo9wxSN3Yk1oN6ypmlPtkznRVOtwFFIVmBX7DpU9lbYQKmm8f
	1ZGcynn2cUl5T0M1L8CzHXfV6NIU7xNfYWkq1C1SBKIYOJ4OPmYMHYMeeEEZwAZE
	WZcxo6qfKfYHUYmna2h/A==
X-ME-Sender: <xms:-nuvZg-KCvQFCBuk7_j_GENY7O4mM--XO2xnfIdbI6DEW-LE9f_aKQ>
    <xme:-nuvZoteUPDrbGmqdVwM80I98tKU916O1IfxV3vzOgyfAK5shflz1f93Dr9f93mby
    1Yd3gAoHtTOcng-szs>
X-ME-Received: <xmr:-nuvZmB7rTCu248H5D7Ji4Nd32A5jmZYMnHdCNLFtqKa3bUwbOpyRubZ_MaW1PSfBTllBz4x7VqZ_GLbAHueRTZW4hpv6nGeRoOdsLm7bVBEug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:-nuvZgc0GdhwngxEI4p0FoUYwqAGKacUnWfTP3twCVuTqF56AAMMQg>
    <xmx:-nuvZlM1Mey8s51QfDDoaWMn1mcOHx-P_L4pannrzPrWGdF2CjpkgQ>
    <xmx:-nuvZqniRmpqnhWmP2c3bDZw08XdLO6-CiAFXmZ3PGSU0ZusQccYtA>
    <xmx:-nuvZnvpO-Rv-m313FCClLHXGpz8r_hqtnq86HItNPGUteYf3GCCig>
    <xmx:-nuvZuZ5QAGXW2C_k3UwUxkds0SEoWvEp7VSVNAKn4TCXFS0zuJehKcH>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:49 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] firewire: ohci: use guard macro to maintain image of configuration ROM
Date: Sun,  4 Aug 2024 22:02:23 +0900
Message-ID: <20240804130225.243496-17-o-takashi@sakamocchi.jp>
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

The 1394 OHCI driver uses spinlock for the process to update local
configuration ROM.

This commit uses guard macro to maintain the spinlock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 116 +++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 67 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 5cb7c7603c2c..368420e4b414 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2139,53 +2139,42 @@ static void bus_reset_work(struct work_struct *work)
 	at_context_flush(&ohci->at_request_ctx);
 	at_context_flush(&ohci->at_response_ctx);
 
-	spin_lock_irq(&ohci->lock);
-
-	ohci->generation = generation;
-	reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
-	reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
-
-	if (ohci->quirks & QUIRK_RESET_PACKET)
-		ohci->request_generation = generation;
-
-	/*
-	 * This next bit is unrelated to the AT context stuff but we
-	 * have to do it under the spinlock also.  If a new config rom
-	 * was set up before this reset, the old one is now no longer
-	 * in use and we can free it. Update the config rom pointers
-	 * to point to the current config rom and clear the
-	 * next_config_rom pointer so a new update can take place.
-	 */
-
-	if (ohci->next_config_rom != NULL) {
-		if (ohci->next_config_rom != ohci->config_rom) {
-			free_rom      = ohci->config_rom;
-			free_rom_bus  = ohci->config_rom_bus;
+	scoped_guard(spinlock_irq, &ohci->lock) {
+		ohci->generation = generation;
+		reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
+		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
+
+		if (ohci->quirks & QUIRK_RESET_PACKET)
+			ohci->request_generation = generation;
+
+		// This next bit is unrelated to the AT context stuff but we have to do it under the
+		// spinlock also. If a new config rom was set up before this reset, the old one is
+		// now no longer in use and we can free it. Update the config rom pointers to point
+		// to the current config rom and clear the next_config_rom pointer so a new update
+		// can take place.
+		if (ohci->next_config_rom != NULL) {
+			if (ohci->next_config_rom != ohci->config_rom) {
+				free_rom      = ohci->config_rom;
+				free_rom_bus  = ohci->config_rom_bus;
+			}
+			ohci->config_rom      = ohci->next_config_rom;
+			ohci->config_rom_bus  = ohci->next_config_rom_bus;
+			ohci->next_config_rom = NULL;
+
+			// Restore config_rom image and manually update config_rom registers.
+			// Writing the header quadlet will indicate that the config rom is ready,
+			// so we do that last.
+			reg_write(ohci, OHCI1394_BusOptions, be32_to_cpu(ohci->config_rom[2]));
+			ohci->config_rom[0] = ohci->next_header;
+			reg_write(ohci, OHCI1394_ConfigROMhdr, be32_to_cpu(ohci->next_header));
 		}
-		ohci->config_rom      = ohci->next_config_rom;
-		ohci->config_rom_bus  = ohci->next_config_rom_bus;
-		ohci->next_config_rom = NULL;
 
-		/*
-		 * Restore config_rom image and manually update
-		 * config_rom registers.  Writing the header quadlet
-		 * will indicate that the config rom is ready, so we
-		 * do that last.
-		 */
-		reg_write(ohci, OHCI1394_BusOptions,
-			  be32_to_cpu(ohci->config_rom[2]));
-		ohci->config_rom[0] = ohci->next_header;
-		reg_write(ohci, OHCI1394_ConfigROMhdr,
-			  be32_to_cpu(ohci->next_header));
-	}
-
-	if (param_remote_dma) {
-		reg_write(ohci, OHCI1394_PhyReqFilterHiSet, ~0);
-		reg_write(ohci, OHCI1394_PhyReqFilterLoSet, ~0);
+		if (param_remote_dma) {
+			reg_write(ohci, OHCI1394_PhyReqFilterHiSet, ~0);
+			reg_write(ohci, OHCI1394_PhyReqFilterLoSet, ~0);
+		}
 	}
 
-	spin_unlock_irq(&ohci->lock);
-
 	if (free_rom)
 		dmam_free_coherent(ohci->card.device, CONFIG_ROM_SIZE, free_rom, free_rom_bus);
 
@@ -2626,33 +2615,26 @@ static int ohci_set_config_rom(struct fw_card *card,
 	if (next_config_rom == NULL)
 		return -ENOMEM;
 
-	spin_lock_irq(&ohci->lock);
-
-	/*
-	 * If there is not an already pending config_rom update,
-	 * push our new allocation into the ohci->next_config_rom
-	 * and then mark the local variable as null so that we
-	 * won't deallocate the new buffer.
-	 *
-	 * OTOH, if there is a pending config_rom update, just
-	 * use that buffer with the new config_rom data, and
-	 * let this routine free the unused DMA allocation.
-	 */
-
-	if (ohci->next_config_rom == NULL) {
-		ohci->next_config_rom = next_config_rom;
-		ohci->next_config_rom_bus = next_config_rom_bus;
-		next_config_rom = NULL;
-	}
+	scoped_guard(spinlock_irq, &ohci->lock) {
+		// If there is not an already pending config_rom update, push our new allocation
+		// into the ohci->next_config_rom and then mark the local variable as null so that
+		// we won't deallocate the new buffer.
+		//
+		// OTOH, if there is a pending config_rom update, just use that buffer with the new
+		// config_rom data, and let this routine free the unused DMA allocation.
+		if (ohci->next_config_rom == NULL) {
+			ohci->next_config_rom = next_config_rom;
+			ohci->next_config_rom_bus = next_config_rom_bus;
+			next_config_rom = NULL;
+		}
 
-	copy_config_rom(ohci->next_config_rom, config_rom, length);
+		copy_config_rom(ohci->next_config_rom, config_rom, length);
 
-	ohci->next_header = config_rom[0];
-	ohci->next_config_rom[0] = 0;
+		ohci->next_header = config_rom[0];
+		ohci->next_config_rom[0] = 0;
 
-	reg_write(ohci, OHCI1394_ConfigROMmap, ohci->next_config_rom_bus);
-
-	spin_unlock_irq(&ohci->lock);
+		reg_write(ohci, OHCI1394_ConfigROMmap, ohci->next_config_rom_bus);
+	}
 
 	/* If we didn't use the DMA allocation, delete it. */
 	if (next_config_rom != NULL) {
-- 
2.43.0


