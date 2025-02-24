Return-Path: <linux-kernel+bounces-529535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E99A4277D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F97A1889212
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F5725A656;
	Mon, 24 Feb 2025 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="y/zuye+k"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393F26388A;
	Mon, 24 Feb 2025 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413432; cv=none; b=OM2Bb2Q3YrHiBPCL8LD0WjBYuhCKzA0/LFyBHOqWT3hrFOXnAkT73xutSaCxIPjYEF/+/LPQJO82jrYwT2/jVnLJzUz/zr1kPErX/enxstMb32NKIh4Jvylm3Dk5QHvDCYkV1arCfj2b0NIaWppgj2dXsb40QevWxbQp4wpXf5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413432; c=relaxed/simple;
	bh=1C1mV5NoJ9/APEzjMdEwYz6//IQ1AVs8sUwLCQuPzec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMZdRgmlco7+MH62WG4iug1XBYvHzpEP8Bsi3ERk3K/M5IfZj///4SOTTSQ/0j806n+Q3MFASbKl0TexBXHbUiGJnEnnDklmFDGCAQ1Tyo9FeCDZR3bpwAWA0TOVvMtL68rreZpjdW31rz/TAYT1K2Yuwb63E4tI47eUHXoaOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=y/zuye+k; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 970222E08CF4;
	Mon, 24 Feb 2025 18:10:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740413421;
	bh=PRIfVgFL9/uJVr65Vu/SG5hdaGKmuol0jcfyj2Kdy3g=; h=From:To:Subject;
	b=y/zuye+k4i6R4+s1/mrsiwTVy0grxWrx0B23jovS4JCQuG2WjIBDwX7rCrJD1O0iZ
	 l1jyY5OcoIwVQR55+7RJFDSblrEEPV1xdvS4SQgG9TBcBGK/3NhUSapDXLvA+xZTFX
	 N1h4VcS3N2HM/XG8SzCFaumYV3cMgACXIEpRUmKs=
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
Subject: [PATCH 1/2] ALSA: hda/realtek: Remove dup Ally X config
Date: Mon, 24 Feb 2025 17:10:15 +0100
Message-ID: <20250224161016.439696-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224161016.439696-1-lkml@antheas.dev>
References: <20250224161016.439696-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174041342154.22531.6034533734687839179@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

In commit 1e9c708dc3ae ("ALSA: hda/tas2781: Add new quirk for Lenovo,
ASUS, Dell projects") Baojun adds a bunch of projects to the file,
including for the Ally X. Turns out the initial Ally X was not sorted
properly, so the kernel had 2 quirks for it.

The previous quirk overrode the new one due to being earlier and they
are different. When AB testing, it was found that the Ally X makes a
popping sound during boot when using the (new) Lenovo quirk.

Therefore, keep using the previous custom quirk for the Ally X and sort
it properly, replacing the one added by Baojun.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 sound/pci/hda/patch_realtek.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 224616fbec4f..1771e3b5618d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10644,7 +10644,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x17f3, "ROG Ally NR2301L/X", ALC294_FIXUP_ASUS_ALLY),
-	SND_PCI_QUIRK(0x1043, 0x1eb3, "ROG Ally X RC72LA", ALC294_FIXUP_ASUS_ALLY_X),
 	SND_PCI_QUIRK(0x1043, 0x1863, "ASUS UX6404VI/VV", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
@@ -10691,7 +10690,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W", ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1),
 	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W", ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
-	SND_PCI_QUIRK(0x1043, 0x1eb3, "ASUS Ally RCLA72", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x1043, 0x1eb3, "ROG Ally X RC72LA", ALC294_FIXUP_ASUS_ALLY_X),
 	SND_PCI_QUIRK(0x1043, 0x1ed3, "ASUS HN7306W", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022", ALC289_FIXUP_ASUS_GA401),
-- 
2.48.1


