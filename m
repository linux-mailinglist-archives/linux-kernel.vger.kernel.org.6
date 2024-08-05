Return-Path: <linux-kernel+bounces-274400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13E59477B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5332E1F22234
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE732158547;
	Mon,  5 Aug 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kl9oVQ4V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nOORla6/"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19827157499
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848075; cv=none; b=RZoq23SHyJGItgk9lLstVdtuadvyhGypWf4Wv4i9dkSPeFZFtZ897XnAuQleKWgQ7dt8P09IpbpFIYy/PB5NBJqewPMwAPaORtbxbqv9Ey3WsgZkzcwL4CvLvZF7YswAqHxBI62I+f+2K0iYhBZDRdyjr7aCnvmLEl5QVCDYaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848075; c=relaxed/simple;
	bh=RQbpBuuhcdVRrS45TXow3FvE3qGBFt8WbWvDlTvxDVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCuASfazn6P3UAlRSKj8UxolNTFU0nDW/yTm/EU7SjGbWccOMjrqGjOwpVJGQlwVigFns9zI4cYueDv4KZYF67qxoyIEENY5PhfqT3wAAx1WGErA0xIVw7KcvSTuyfqgMzS+AesTlCmLxgDyQviXRgH1l/0vQVBBpuQKquiHqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=kl9oVQ4V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nOORla6/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7053D1146CF3;
	Mon,  5 Aug 2024 04:54:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Mon, 05 Aug 2024 04:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848073; x=
	1722934473; bh=oi4YF8S7QF5qtDuzwiUeYwReqaCDQcNumgOf6dEv5Us=; b=k
	l9oVQ4VWf1ZHKtR0U7bspOKPvUuIK3Ja/mN0JRyMimU+xEtseMtDqLXY8BbFd+tK
	Iuth4xSawSPSYlR4nXtcSme4jxpsCqsh/47Gc3aJS3jQQYyNyTD2btRnm9QpBbaI
	djfD7Phe1EPN7o/cXG4xvKW+M23RaE3bh//lCLu6t6v++ft/b0Vzl4xosbk9jCFI
	ehTrCh44rbKQVehwfBu1mY+ZM+Nh++GpSIq9FEHaheZ0PcJA8H0jG80YklIas63A
	Qy4EDw7X83he71SpUB7cYNz/IJvUG6URnKrgp0B32LlQ13KRDhtIqKkswnFdXpmN
	hwpL8+qbm2YbAqr3TUDvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848073; x=
	1722934473; bh=oi4YF8S7QF5qtDuzwiUeYwReqaCDQcNumgOf6dEv5Us=; b=n
	OORla6/K40B/DPuFMbzSUFrvxuUZEX/hpNaRLwU2Kj1qBWGWxtpozzj28rvhWrIS
	L85NuDNt0nnOXb7hcTU4PRksfvPm504psELLvv0lGoYcGXnlNmaKvfMcrEMUIQyX
	Fkae2nYJa94XtzK3Q9c9EpoSbMcTgNJId9TG0BxuhKip7Wh+JHIvxS+IJV6WqYwC
	dPMeQGvDdbHTk6pI7Db+rzgkrhGykP3pEfhmU1TcjRVPnRBNDWtfgOAGspX/nqTc
	34FCYYeSYfSmgDEgp7VJTjaJJLqT3Am5hmEUfpFJ2x80/SpYXt1Z69g6QNoFZIXi
	vw++aPf+T9crzrcRXLvmw==
X-ME-Sender: <xms:SZOwZgSRh32jV5jmV3G65TWRYCVVBTg87q-Gp1TX1KqRwyyxMjj_rg>
    <xme:SZOwZtxyqK6GAfBQAPzISESwKMSQdshB8A_-3vOZBGxU6-1rG-npY8yUBQATV77Cx
    3i6GkG2vu1P-11XvDE>
X-ME-Received: <xmr:SZOwZt3nGlc2MESmh6F-TEtza5R6s2knDm5-NA4CwlJApCHoaYhShheCXAo2UMJIiQyfNH6OwomOzqMqawGY8pwS6hJdOwCN1wGe2G3exUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:SZOwZkCzZO1jqNz9SmIq4MJryD2_zEq4O5Z6ZPSpe_9RLTBgwsd24g>
    <xmx:SZOwZpiWL4g5soeK0gGUvk7fGemU_4w4m25i9YZDkhVbzYBLdJoDkg>
    <xmx:SZOwZgpLluL4opqURMd3mjpnr5SFXCUkgEI8hTN0frMuCi-XovSNtA>
    <xmx:SZOwZsiAPs1foZZpn357cQpvYQ8CfeDIHUAayryukGZx8gXlvUM7Eg>
    <xmx:SZOwZsvebQWGXATkMG3z0cYNg8IGUXg9tchGlmvW3xW2IeWVYmxRpEy_>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:32 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/17] firewire: ohci: use guard macro to maintain image of configuration ROM
Date: Mon,  5 Aug 2024 17:54:07 +0900
Message-ID: <20240805085408.251763-17-o-takashi@sakamocchi.jp>
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


