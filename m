Return-Path: <linux-kernel+bounces-537012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAF4A4870A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84954188CB89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4801DDC22;
	Thu, 27 Feb 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="o28bQWrv"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94681D5CD3;
	Thu, 27 Feb 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678682; cv=none; b=LDPzPuldqV5JQG9kNAi3JE+/aM/zzvZtDJZt0xh4GIglAFCImz0qBKzr5jU3ARezDjUP349TbCuyOXKcDfJe+/pjjn6Y+7OryiezADLGDIolsMAjLmfjlQjMCqg7IUzu/vVX2Ns5GZ4qiyh9VHogKP55fycWvrrI0IZyLzvewYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678682; c=relaxed/simple;
	bh=5HJSoQYB/GNMpDTh++aUhKd+mAn9BqMW5mqV2UA3wT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puaBG4qmYR6uxjhbpXHhJYs0iQEqbJihgrHqloUAp05SL6FVo5qbC3s1f1TOqdDU3ovq2SH1qxg3bjgvS33byx9a6+6IjEAXo+qI9V4LoAmeKkcnL7KyERRxPfycQPulZVRSzlPJ1nlgTFMouftkbYh9hHd6nByny4oqlJDwXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=o28bQWrv; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 610B22E000C0;
	Thu, 27 Feb 2025 19:51:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740678676;
	bh=UCsnlrVcfEZ9dmEDvjRCrlbNeiteXx7Fw8k3nqnief8=; h=From:To:Subject;
	b=o28bQWrvdkExkpGVCug4p1Us/oekTqZ1XE4y1fSmQEe7XH9MPyAiQ5rdnt9aN6VEu
	 WU/VTpzYvRP+7z4cc6gpcg6w95CYast294IYRpI6kf6sjGQ+RkeY8aa6KMkLdPxbWz
	 9EKNRVrwc0ofVtxbPhRoyPJ41GefZfXehLBM+KyA=
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
Subject: [PATCH v2 2/2] ALSA: hda/realtek: Fix Asus Z13 2025 audio
Date: Thu, 27 Feb 2025 18:51:07 +0100
Message-ID: <20250227175107.33432-3-lkml@antheas.dev>
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
 <174067867642.23360.17289059988517600062@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Use the basic quirk for this type of amplifier. Sound works in speakers,
headphones, and microphone. Whereas none worked before.

Tested-by: Kyle Gospodnetich <me@kylegospodneti.ch>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 84e60c50cdb4..67c06ee9e332 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10692,6 +10692,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1f1f, "ASUS H7604JI/JV/J3D", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1fb3, "ASUS ROG Flow Z13 GZ302EA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x31d0, "ASUS Zen AIO 27 Z272SD_A272SD", ALC274_FIXUP_ASUS_ZEN_AIO_27),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
-- 
2.48.1


