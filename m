Return-Path: <linux-kernel+bounces-421899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525739D91B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1076E164442
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF4F187FE0;
	Tue, 26 Nov 2024 06:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="r4DWmtKr"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01141885A5;
	Tue, 26 Nov 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732601706; cv=none; b=RcTfMiaRyAOw+M+CtMDidTcRM9K/orNI7XnI080FmiaucgtbgILOZieBWfAUZNzAJ5Bh8DrH+HR7Nylg2MiXQpY7KaW1+DhhUE45cYFcp/kcTTkIBUZGm5cIVMCICe8DqoZ7bMxNn7iSpCbAEItOje2ypmf84SnsBBRJ5qu4qX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732601706; c=relaxed/simple;
	bh=4XbqV31OPGftT8IxLHnIsqNA+uKfAt7UAn9oXqq5FWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewtXQV5LpxelwcaJyUXeFMFmMK/rVyuCm2opx5uj7czzC5SRGUIHup3xIlQRZdU0Lx/MZecrwbwR/OstmmLhtZXFFGks5cO2hlkxkdDkwu3GcBNvaWG6fS8VJ4enYGMSQjFC39OemjTgHumXJx0VDV2WF0YTWNgXnQE8iLUyKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=r4DWmtKr; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.197.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 827EE3F18A;
	Tue, 26 Nov 2024 06:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732601159;
	bh=HDPw2OCPc8l2LrpPCiCl3FFtQBb2/GnhjP/3mVlswE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=r4DWmtKrNAQvSc3sUFqIDRmVSKhlbOGE4J/NKJCntOs8rwUjj9DlPof5Wl4R9vx6C
	 ZPIg/Xcl38BFoCv1jf3QFmUj/buJAKO/H48VklZ3sXyaC6GKHk/YlVQCXD4RQSd4jP
	 LThwZWPaeJ7Rs9ymOE+DNk89e7a1wKv2b53pW8cTtKg3lvnDp0lxu6weENfL53hRf4
	 AdoaMApD/0zQ0YpfIveQZEXqLnAJ+XRfyhoRw5M1oHREHlPTJ6pM58mn35w9O3jrZ4
	 Tw9OcAPV5YlhcbjoF/fjfS9BN5RxqOJD6AZ9nkZx6DuovFI7wWlhzpmeYp/G4qevqZ
	 YpjFqVOf8cvwA==
From: Dirk Su <dirk.su@canonical.com>
To: 
Cc: dirk.su@canonical.com,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook X G1i
Date: Tue, 26 Nov 2024 14:05:24 +0800
Message-ID: <20241126060531.22759-1-dirk.su@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HP EliteBook X G1i needs ALC285_FIXUP_HP_GPIO_LED quirk to
make mic-mute/audio-mute working.

Signed-off-by: Dirk Su <dirk.su@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2831f056984e..f486a0042e50 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10505,6 +10505,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8cdf, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ce0, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d84, "HP EliteBook X G1i", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.43.0


