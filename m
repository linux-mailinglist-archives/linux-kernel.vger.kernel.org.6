Return-Path: <linux-kernel+bounces-300159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AC895DFAB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAF3282196
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD601757F8;
	Sat, 24 Aug 2024 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYhFA6/v"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6D40849;
	Sat, 24 Aug 2024 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724524546; cv=none; b=EFY2/SfbQEUFRiU8SX6CR7bTaYUVCGR0CGFN8vV7AcR0dfSCyj7mTy/9gmPnQerSsWRa/Qhpsjzjdsn2Fa8ooy1OO54ganExpftqSsl8s2Orfw8cWbKrjFf/zNxzNTYcJVLS7FOYEH9tdb+o6C0wkuhkAMA5USV+BIWuFo8Sn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724524546; c=relaxed/simple;
	bh=o/G9uX8ZzFaGDP70JdewsO9SVUO4yfPh85HVv/owmrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzumOFX7GEA6bYvruO4DjlHQCVkCW43AonsFSYKD+45XSAEGfJ42Aid5oETv7H4+gk/n+F3RrdMbDFdd+1o+gMn3tJPVAWdFG2QKxmY0k4qabs8NDv1HwgSxsmboVX6e90bh3HCyxHNtZL89O47HJvMBmwYlZ4WSzbfGlPPNDSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYhFA6/v; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428243f928fso32795555e9.0;
        Sat, 24 Aug 2024 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724524543; x=1725129343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+QxWKMmBLZbhDpE3FhoqFTvA4vPQhbIutQFryBliiNI=;
        b=RYhFA6/vaqfhYIL2ImK1sSuGSaJ0EK+T9RGqTyk7fCAR+ouBd80bn34JTa82LuobkP
         VTlU61enGyOYly2QG+9C5fgUbUiCAF8+wCT+lPvMHKBtwOf59Et34dqyx2Xt0OBVjUlv
         fIEB8izUB7sfWwHXTIbxSJA9OCOZ1FWw+sybQ7XeEViHp+6ZONS1hrGNwTHg4BbvY8nL
         EuSg6kBb1aeEwpjZ+HnnTpsE3CTdRqj/Lsy1yjXBzSPqRmTP3QwR1roVIm9x85YD8Cr8
         jEslW15INzzwYWn9yKHLt2OT/CLLTLilQUGWsNRE3s2DrkBK4PjzbYdbl7wLchNOFT+J
         ghAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724524543; x=1725129343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QxWKMmBLZbhDpE3FhoqFTvA4vPQhbIutQFryBliiNI=;
        b=NpfqJUNFhp9yuf4UxjH6/Csd9HpEsOQX6LvHTWh6tbC/w8toqgQ1IousTtOKKOTQNA
         89G5g8epwyMAwsL1AxhHkndvwKHk/V/ZP0wpOk3vvEFbzONyeoAGlPyKsY3Yt3bG0fNv
         HIt2N3ZTfkuSV5G8o/JYDuDYQ5WS1+nROo4nxaEWKhzqMVbTFQEikpcFG2Mj1nUcLWxC
         S6vE2yc3iBijJpzqM5oWVAJEr0lhH9kc/NZax+sQlWagfVw5L4TAWpS1hZysGAkMKzkW
         LRqLOiabMpUuPP2IYmcVcz6vRN8LXZ/ga+oG1SiU1ZNPPpb9aGbjo0OHfmRdsoeUXHMm
         gYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK3X+J9wKVpUQeAwV6DoYMKqb7fXHgTz9svoPsae1gm5FnXOymMvKxgo4vDFaF42IkRBAHZ3vXj0pFM38=@vger.kernel.org, AJvYcCWiHBwBm2P74KQxYjuIwQfXJEeZkyWgVN/FlL9VoyW2IaU3ZVaRfX27rCnIpdETf3CAJKV6VtTVFSgFPaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxaMGrl/5Bh4XM1i1j3VVVhOxFTY40a/h1jQAmY296Cs4+QbD6
	9HnxDzjI1qhVHs0GdXLtvozpK5lsbg0BR8+uqdT12Uq/iAmYTSv5
X-Google-Smtp-Source: AGHT+IH7GPpOsCXpYAmsJZfXhp1LKgdhpp/TafszS9a4tHrhwNcnFVvNFDqM/gmMqBa9JTSAT0avHg==
X-Received: by 2002:a05:600c:154e:b0:428:e820:37b6 with SMTP id 5b1f17b1804b1-42acd5e689emr46671215e9.31.1724524542625;
        Sat, 24 Aug 2024 11:35:42 -0700 (PDT)
Received: from hendrik-laptop.borghorst.space.borghorst.space (p200300ed771342104eaf2a6a78487f8e.dip0.t-ipconnect.de. [2003:ed:7713:4210:4eaf:2a6a:7848:7f8e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ac5159450sm101058845e9.17.2024.08.24.11.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 11:35:42 -0700 (PDT)
From: Hendrik Borghorst <hendrikborghorst@gmail.com>
To: 
Cc: Hendrik Borghorst <hendrikborghorst@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alsa: support HP Pavilion Aero 13-bg0xxx Mute LED
Date: Sat, 24 Aug 2024 20:34:38 +0200
Message-ID: <20240824183445.6610-1-hendrikborghorst@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the HP Pavilion Aero 13 (13-bg0xxx) (year 2024) to list of
quirks for keyboard LED mute indication.

The laptop has two LEDs (one for speaker and one for mic mute). The
pre-existing quirk ALC245_FIXUP_HP_X360_MUTE_LEDS chains both the quirk for
mic and speaker mute.

Tested on 6.11.0-rc4 with the aforementioned laptop.

Signed-off-by: Hendrik Borghorst <hendrikborghorst@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d022a25635f9..a45062c9ed6d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10217,6 +10217,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x890e, "HP 255 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8cbd, "HP Pavilion Aero Laptop 13-bg0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x896d, "HP ZBook Firefly 16 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x896e, "HP EliteBook x360 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8971, "HP EliteBook 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
-- 
2.44.2


