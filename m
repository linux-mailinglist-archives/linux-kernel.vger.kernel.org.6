Return-Path: <linux-kernel+bounces-282570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C53394E5E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01DE1F2231D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1514A612;
	Mon, 12 Aug 2024 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAFX+O+m"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BA1DFFD;
	Mon, 12 Aug 2024 04:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723438449; cv=none; b=aLtFkM6YeEenbvH7FV5VObEUik9DrQu4wZbizENzeTyKTY4I3tlmu5DxzIoPYme0A04pEGPS/9ehi6oiKrZfG43bchsXa3mccTYjlUxIbEeFKF4XzdP+qYwSWqz0XKbZolK/TeJAG4+zhwRGcUq0wbrkzRtk4P05zj6j9pPoO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723438449; c=relaxed/simple;
	bh=7+jVABBsNbizGOQnYnTrHTlhtmzfjykh6P6vndW5SQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLTH+ougcODKK582UnBfVNh5HN/w057u0AQUJsuGwdOW0ZE0ruk02qbxImOeATTFKXpAnkuCEu1UkM1erdI0ghmHzo3at+4wyB2byZxmd83DVh/FuNB1keUmM8HdyrooI8jYJK/A3gN5Q8WT6zPjOJe/DaIJqHOpZJKwdFuT+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAFX+O+m; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso2769525b3a.0;
        Sun, 11 Aug 2024 21:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723438447; x=1724043247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySHO6O2H5qje2VBKy2Synv/wXJFARS3WfeCV+1C16pQ=;
        b=nAFX+O+mFO6i480R29KKChOK6CheB2OQMvp30ZTEvIJIpET9tYrW67l1smMphWi1L0
         0n5l4YlvN0AUGxbjHmJLGw03fyUdvWhNB/jX695ipnXZAtug5Rk4pGHLtkKj1iJtj75u
         tODF6yatJHpevbTRgspCOEhWj48hTnolE9BGPcKUargfmbSUOqJsvI8vbzkj32xyrHAr
         2y5iPT23HDMUCm6A7cmARmBPTjvmxMMokwlXjZmF9p0YWAm75Ov7rnJHpy0YHrzqhDq9
         8qXog9uo2v5Z5UVA8G+LVXkroD+yqi1fGkMIu98fOiIBJM2JXMALaQ3aMXWjUjKbjem9
         leIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723438447; x=1724043247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySHO6O2H5qje2VBKy2Synv/wXJFARS3WfeCV+1C16pQ=;
        b=v4YSofFGvrl4pDJouoB4unwXXsXqFn0wfef3HSKE6k08xmj3lV2/kFm5lS5uXQ8149
         hHNQ5lD5HHG0JRPS8rMHKdRCqkXOC12VXOTtMmnWL0yJ7A6r6Sz/L1sA35FlLBX55/wf
         DC/+Lw72sENqIv1YkzYxXWOce2IMOhc+9qbhPKnDhHsdDP2yOt1XQB30dLK4Jw4NiVOG
         klQ7L6232ep1FY/GrlEptun03WJhZd6f4tShP0Sw3Od1ZaeZ+6oLjwQYoj4B34W1tSTN
         rPVYDCKHURAytQjz5xol5SXq/XJygr8rzmp4UUk2jgsJmpEUSIc4rIRCOjOKWvf6Lj5D
         Aifw==
X-Forwarded-Encrypted: i=1; AJvYcCV22dGFcZYzcTD1WVkRbG1Tgw9UVVgMstCY8WeNXorUzJ7sOyFpdQlWjMuDt4mCWlul20CO3xsf/ozd5ubeEk6hBLvWbodWa0MASioq/DjQ8BItEi3qmTkalhLiVDgNwyc0uRL5TUr2e8g=
X-Gm-Message-State: AOJu0YwSDWC+AUquhkkNsqKOs0XeUass5Mfhc/jVXCOIKp+Iw7hPZlHz
	NrGLZwCKUmkafsCTCP7LUok6Dpsgq+xfTGDgq+rYND2iuYgw5KRt
X-Google-Smtp-Source: AGHT+IEIkhd5ULm8pjy0oWMQmysodM2aF4d/rg/YAnViabCyPKOCQwwX1ciUj9E5aL49vpuif3TNlA==
X-Received: by 2002:a05:6a00:21c9:b0:706:6bf8:bd2 with SMTP id d2e1a72fcca58-710dc899ea3mr7338886b3a.21.1723438446505;
        Sun, 11 Aug 2024 21:54:06 -0700 (PDT)
Received: from nobara-Desktop-pc.. (syn-076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5873b06sm3227939b3a.10.2024.08.11.21.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 21:54:06 -0700 (PDT)
From: Jonathan LoBue <jlobue10@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: shenghao-ding@ti.com,
	kailang@realtek.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	derekjohn.clark@gmail.com,
	luke@ljones.dev,
	benato.denis96@gmail.com,
	Jonathan LoBue <jlobue10@gmail.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Jan Drogehoff <sentrycraft123@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Richard Alvarez <alvarez.richard@gmail.com>,
	Miles Montierth <cyber_dopamine@intheblackmedia.com>
Subject: [PATCH] ALSA: hda/realtek: tas2781: Fix ROG ALLY X audio
Date: Sun, 11 Aug 2024 21:53:25 -0700
Message-ID: <20240812045325.47736-1-jlobue10@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables the TI TAS2781 amplifier SoC for the ASUS ROG ALLY X.
This is a design change from the original ASUS ROG ALLY, creating the need
for this patch. All other Realtek Codec settings seem to be re-used from
the original ROG ALLY design (on the ROG ALLY X). This patch maintains the
previous settings for the Realtek codec portion, but enables the I2C
binding for the TI TAS2781 amplifier (instead of the Cirrus CS35L41 amp
used on the original ASUS ROG ALLY).

One other requirement must be met for audio to work on the ASUS ROG ALLY X.
A proper firmware file in the correct location with a proper symlink. We
had reached out to TI engineers and confirmed that the firmware found in
the Windows' driver package has a GPL license. Bazzite Github is hosting
this firmware file for now until proper linux-firmware upstreaming can
occur. https://github.com/ublue-os/bazzite

This firmware file should be placed in
/usr/lib/firmware/ti/tas2781/TAS2XXX1EB3.bin with a symlink to it from
/usr/lib/firmware/TAS2XXX1EB3.bin

Co-developed by: Kyle Gospodnetich <me@kylegospodneti.ch>
Signed-off-by: Kyle Gospodnetich <me@kylegospodneti.ch>
Co-developed by: Jan Drogehoff <sentrycraft123@gmail.com>
Signed-off-by: Jan Drogehoff <sentrycraft123@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Tested-by: Richard Alvarez <alvarez.richard@gmail.com>
Tested-by: Miles Montierth <cyber_dopamine@intheblackmedia.com>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 480e82df7a4c..9bc39c2ee6b9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7410,6 +7410,7 @@ enum {
 	ALC285_FIXUP_THINKPAD_X1_GEN7,
 	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	ALC294_FIXUP_ASUS_ALLY,
+	ALC294_FIXUP_ASUS_ALLY_X,
 	ALC294_FIXUP_ASUS_ALLY_PINS,
 	ALC294_FIXUP_ASUS_ALLY_VERBS,
 	ALC294_FIXUP_ASUS_ALLY_SPEAKER,
@@ -8877,6 +8878,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_ALLY_PINS
 	},
+	[ALC294_FIXUP_ASUS_ALLY_X] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = tas2781_fixup_i2c,
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_ALLY_PINS
+	},
 	[ALC294_FIXUP_ASUS_ALLY_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -10313,6 +10320,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x17f3, "ROG Ally NR2301L/X", ALC294_FIXUP_ASUS_ALLY),
+	SND_PCI_QUIRK(0x1043, 0x1eb3, "ROG Ally X RC72LA", ALC294_FIXUP_ASUS_ALLY_X),
 	SND_PCI_QUIRK(0x1043, 0x1863, "ASUS UX6404VI/VV", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
-- 
2.46.0


