Return-Path: <linux-kernel+bounces-202090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F3F8FC7B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1321F226D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539718FC8F;
	Wed,  5 Jun 2024 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qUBfzewL"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6314B969;
	Wed,  5 Jun 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579397; cv=none; b=UV4Rfmc8/fw17jmLje+rtgj5cyS81XVrCTawuGQjtAWFQ0ZuZGj39v7q5Sw0EROyAflS65dInAry/p48YmbVSP+XEiyU/MOFQEN0e7tHwyoZeRUUGlY0gTsjW0A5aMNAEZa86JDW/4//ijb3wY7BsRDphunM68E+ivFRMDSqAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579397; c=relaxed/simple;
	bh=gYRpS6AJVn0saE/j2zAxZAxiQL6Pvv593DFWC+x/8wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPY2+v/VGo40JKuHsYEd591rF5TQRMy2lb5qGz6KeCbMcj/nmexv9rFeIt7lM1NMi6rmJ+qjpVZOHl9bqYkaHLBY15Fn0qNOOpQZY/Hw3dH1z74LpvXDUJS31r/nNtXy2ls9r4kyLrKINTVTyDuUOHgPavdKECXqW5GIZXL/U8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qUBfzewL; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.197.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A68F83F2E7;
	Wed,  5 Jun 2024 09:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717579390;
	bh=KJPLcT8mgLC51ILSluTI+5lWS48z3CE5xZ0HbgAA4gE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=qUBfzewLNI8OuPaLrya6uhyGODdvNv0/ub/0x7m8KwO84i8v3f0p5BS/BB85XXGaA
	 ith9OgvK29EwmF1VRtJ9Au05JKE2URp1eDMfnlhJGMPLe5Thkr5obWUHnu2KO+AoQe
	 yTU1UFU2iIA6M5uYVrAMaBiSrvkljUZIfvS/pVXVFoXcruteL8cSi0fiOFvUznZWQD
	 LkvyfKXlC17PoPkcYU3IWoZ/Lrd32p5cD4/mwWBLtZCdgmuuB6jTtJRj9E6d2hWhXn
	 6Ikf30a9VwIE/Ilk0lv8aV0cb+qCeoDUV29B1e/fldKFGIK0SlGLRzIJEKByK9G3wC
	 WiiEKshmGRZDg==
From: Andy Chi <andy.chi@canonical.com>
To: 
Cc: andy.chi@canonical.com,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook 445/465 G11.
Date: Wed,  5 Jun 2024 17:22:41 +0800
Message-Id: <20240605092243.41963-1-andy.chi@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HP ProBook 445/465 G11 needs ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to
make mic-mute/audio-mute working.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index aa76d1c88589..54a52c148070 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10194,6 +10194,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c7b, "HP ProBook 445 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c7c, "HP ProBook 445 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c7d, "HP ProBook 465 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c7e, "HP ProBook 465 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c89, "HP ProBook 460 G11", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8a, "HP EliteBook 630", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8c, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.34.1


