Return-Path: <linux-kernel+bounces-537011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43792A48709
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824C6166CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF591EB5F7;
	Thu, 27 Feb 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="wyJPtQDc"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910B1DDC22;
	Thu, 27 Feb 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678679; cv=none; b=czKHzwz6Y8EdsXDzhQrz6v2zmAYXSuEGIUt8Sqw89/s5cxd27ybHxI5nmZlJuRSG/zzJpQGkkdyL1jxjnKWUUWIEul5qDjuKozC9EwibZZQgns3LvFKaI48UYhGcZWD7Q1b+TQCf9DO06mq+yj4XS7gI+Gp9RGmooeb04mt0SCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678679; c=relaxed/simple;
	bh=ve1tn5m1IfcbDWyao/yi2LQcvxXCT0Ws+PInmLNUOac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Myk9X9/95ZrlOXYaDhsPXXUZ8Qy7C/vlxwbsELwR0hz2PX287jtnpfdqltphZ7ZFmzIjDPdiAjIjMAbublXC55y4Dgl0MqWePbJQfJ+jjGN0MbIruwuoBHYBlx54HlOH4ZzDS9DpH4HD4AEWmDdm5oPQPX5XZFXmGQ87PLXqERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=wyJPtQDc; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id E0C882E0904D;
	Thu, 27 Feb 2025 19:51:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740678675;
	bh=klaMGTWuBptyqX/z1km+OwOQwMv+T6B+Vl6r4qUbBYo=; h=From:To:Subject;
	b=wyJPtQDcv7RaO7zCrvd7sU44rdTmdHPQ5fBXWm2RuaWROzyez/lreaFsxLFws0Pzb
	 rRqbp4bFpoLxQWcsHJq2tNykV5SvO3RD8p0l1QacvSdlCG9UTofjtrXuyJn1A3Ld+Z
	 yNsp1dDBLy0M731Cywr0jMeKpxs4dDcUIC7R0V9g=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-sound@vger.kernel.org,
	kailang@realtek.com
Cc: linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	baojun.xu@ti.com,
	simont@opensource.cirrus.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 1/2] ALSA: hda/realtek: Remove (revert) duplicate Ally X
 config
Date: Thu, 27 Feb 2025 18:51:06 +0100
Message-ID: <20250227175107.33432-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227175107.33432-1-lkml@antheas.dev>
References: <20250227175107.33432-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174067867491.23226.12527222830439990859@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

In commit 1e9c708dc3ae ("ALSA: hda/tas2781: Add new quirk for Lenovo,
ASUS, Dell projects") Baojun adds a bunch of projects to the file,
including for the Ally X. Turns out the initial Ally X was not sorted
properly, so the kernel had 2 quirks for it.

The previous quirk overrode the new one due to being earlier and they
are different. When AB testing, the normal pin fixup seems to work ok
but causes a bit of a minor popping. Given the other config is more
complicated and may cause undefined behavior, revert it.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 sound/pci/hda/patch_realtek.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 224616fbec4f..84e60c50cdb4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7690,7 +7690,6 @@ enum {
 	ALC285_FIXUP_THINKPAD_X1_GEN7,
 	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	ALC294_FIXUP_ASUS_ALLY,
-	ALC294_FIXUP_ASUS_ALLY_X,
 	ALC294_FIXUP_ASUS_ALLY_PINS,
 	ALC294_FIXUP_ASUS_ALLY_VERBS,
 	ALC294_FIXUP_ASUS_ALLY_SPEAKER,
@@ -9138,12 +9137,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_ALLY_PINS
 	},
-	[ALC294_FIXUP_ASUS_ALLY_X] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = tas2781_fixup_i2c,
-		.chained = true,
-		.chain_id = ALC294_FIXUP_ASUS_ALLY_PINS
-	},
 	[ALC294_FIXUP_ASUS_ALLY_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -10644,7 +10637,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x17f3, "ROG Ally NR2301L/X", ALC294_FIXUP_ASUS_ALLY),
-	SND_PCI_QUIRK(0x1043, 0x1eb3, "ROG Ally X RC72LA", ALC294_FIXUP_ASUS_ALLY_X),
 	SND_PCI_QUIRK(0x1043, 0x1863, "ASUS UX6404VI/VV", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
-- 
2.48.1


