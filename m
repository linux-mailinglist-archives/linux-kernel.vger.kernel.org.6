Return-Path: <linux-kernel+bounces-317214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8653396DB03
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3172B1F27044
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDDC19DF53;
	Thu,  5 Sep 2024 14:02:32 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03CB19CCEC;
	Thu,  5 Sep 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544952; cv=none; b=S9eZQgHf+b5ldp7F60z4UlSIkHof5xck6vZcBTBu3f6m+QODXKAnyRu4z2qI+VcGLxmApUorvfuMXp4Sd0BXS88xEmrljauJ0GAlURTfYkS2aIcFs5j6sP+t/2B6m64Usbq+CKRCayn7PvZVocb8gdsEB26OTxuzMqT9k7vaG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544952; c=relaxed/simple;
	bh=LIo61ugMm3QmgQMjwt6oAPygXJvbWWH2y0x7nZZ8UV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iAjN4czSnuMhoo4/+uIWlkJUSF3JnFzazxKxrWXamV5IqlNyvEcIl5HEQw4xvwLkOTC/IMYlIAowE56XToxLpC8e2cqzg3iekslK69lsK77H5MIoDFhq4zAVincwb64xWod90NAsyhRF/8Ca879lfsHHZzWJXCI2sXDtalSJ2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id F24E82F202A4; Thu,  5 Sep 2024 14:02:18 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id BFB9B2F20295;
	Thu,  5 Sep 2024 14:02:18 +0000 (UTC)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kovalev@altlinux.org
Subject: [PATCH] ALSA: hda/realtek - Fix inactive headset mic jack for ASUS Vivobook 15 X1504VAP
Date: Thu,  5 Sep 2024 17:02:11 +0300
Message-Id: <20240905140211.937385-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the headset is connected, there is no automatic switching of the
capture source - you can only manually select the headset microphone
in pavucontrol.

This patch fixes/activates the inactive microphone of the headset.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8377b12228642b..2e90c713b4a2c2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10435,6 +10435,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1e1f, "ASUS Vivobook 15 X1504VAP", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
-- 
2.33.8


