Return-Path: <linux-kernel+bounces-529536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A4A42780
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3CA16A537
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ED3263C86;
	Mon, 24 Feb 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="B/tQ5FMM"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736B2627F2;
	Mon, 24 Feb 2025 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413434; cv=none; b=n10+cWWWYedZAo/gLD3+HVtCcxCANW6eJibySIRfTb57U2Xr9ma3zAt2jf/sFJUFz9XNOZtAoD09G+ZJI0N9yVZAONoJCoiB6OIX8C5bYJZr0Dkq3dN92+DrTMkM0N1rbM1eVPvLbqHyPRx4CnMz+1VVAHqWAw70vsWUIydARUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413434; c=relaxed/simple;
	bh=omq3AxXNMCipEI5+ZF3SZBQDE7bZiLpnnJN0jCpNReM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs2ygfJjQwaiwsmoGTyvAzEdO3FcajBUls7LebZ/XDjl+dmZzPcWQGXiMwEfitD+8NQ9PuTqvViIh+nU/IOTaFYmjMLbg2kuRQxBz5W3b2Qi1qhz3f7LzNYEvEkQbcThrC/R7Ch/qqc+aKnWOtK0/9W/pd+RTgpqHk49nqRwLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=B/tQ5FMM; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 32AAC2E08D20;
	Mon, 24 Feb 2025 18:10:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740413423;
	bh=5L/XOZMYlZob+xPcqvE8cYqF7PSXRDKMf4KdN9NN7cY=; h=From:To:Subject;
	b=B/tQ5FMMLi/YH5+DBbMuWVVii5tsSPoX6BlrVaZVzIg177VoKTGgU7l5ZvvQ2n5p4
	 WcjeWaiHLI8g4rb3ieAEmzjVmaK5wMYh6viLir0u8rHtUl4a5HFqC5sl00+LqctdXA
	 KZtI2r5oI9nBfjVINGomMJRVLHysUzA3aYzMUdV0=
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
	Antheas Kapenekakis <lkml@antheas.dev>,
	Kyle Gospodnetich <me@kylegospodneti.ch>
Subject: [PATCH 2/2] ALSA: hda/realtek: Fix Asus Z13 2025 audio
Date: Mon, 24 Feb 2025 17:10:16 +0100
Message-ID: <20250224161016.439696-3-lkml@antheas.dev>
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
 <174041342317.22594.9963417988902466998@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

dsdt entry is the same as the original Ally, so borrow its quirks.
Sound works in both speakers, headphones, and microphone. Whereas
none worked before.

Tested-by: Kyle Gospodnetich <me@kylegospodneti.ch>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1771e3b5618d..62c77db73df9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10699,6 +10699,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1f1f, "ASUS H7604JI/JV/J3D", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1fb3, "ASUS ROG Flow Z13 GZ302EA", ALC294_FIXUP_ASUS_ALLY),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x31d0, "ASUS Zen AIO 27 Z272SD_A272SD", ALC274_FIXUP_ASUS_ZEN_AIO_27),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
-- 
2.48.1


