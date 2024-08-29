Return-Path: <linux-kernel+bounces-307623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02D965084
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B162D1C21E64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB2B1BA883;
	Thu, 29 Aug 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixiFMVt8"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B71B8E80
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962322; cv=none; b=oBGhlysABFBp6yqQWt1mySlrT3z8UmWstOnJYtQwm+8IS1abvjlXv7fXO9mmxyvyZJZvHgGeABSbRX+vtuwwqJ8S4H1svMSlWWlVf8kTHyioAfNKPx2LzBCHOKEZIcusomsLyTxmvYHg4bRCUvl4Yeu4el8rcuuVblc/m4fmYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962322; c=relaxed/simple;
	bh=bg3niV7bz5Zl9USpbgTTH3hyFvXVp5gg0sizqQaLu6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OjjaNOfyn0OpYPaigHNyylWxKzZCZM0YUQeKCVV8CBo1osyLnzy6/4Wj1b4SYRRl/JlG6+uq/d0jHRa5MQG4dtNmP8g8cQPUHj1Pt/oLEQWbS1ngUW8Zq4dVdI27d11GnR0ZD3v9UAHYBDlPLceXBVLG+XkVAu33GJ/qXFrL6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ixiFMVt8; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-715e3e03831so1016257b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724962320; x=1725567120; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x24EhIgNe8xtya4+W0q16hyJ5+Ru2f7HMLYEbdNojMQ=;
        b=ixiFMVt8/rRkS01jplzBcjd6M/mMo4v3mLZjCFhVRt4vq46v3xQJl4Ouv0jnUvqixS
         kJLizVcOCqe/RWga93lyMgb4ip3D5mv+s6qmAuryBVV3V9JamzBaYwXJjhMd4QhNIw3c
         U/Mwc1F5xwAAQD+IJeUz6422HjhF0wsECflA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962320; x=1725567120;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x24EhIgNe8xtya4+W0q16hyJ5+Ru2f7HMLYEbdNojMQ=;
        b=qjRLmUC/G+hzprFczFgt2lqkDzPoYSLvtynF4pXLlDkrUu76Up6PC5q83dM76dp8jh
         rlgHTayA7eMAKqHvfUS7xuAWID1zCSOHWp8JA98wBrlXHLmUOCHKxQH8COIVSxyIDSX6
         b2uiVLrDitRQbdjTXzYvGeZV6+jHeze8MOciQu9ZnVhM47nRd3eTIwzJCg/oirzfFFjI
         YqeVZWmfvQ/+y7PoeQhtgfAlpDqiO/QYSg3QJzTOhhagY9MrT3AAReioYHv+nfVfaJov
         DPzm21qsPWO5buyqeCH60Ol4HrKX1Ne54LXlIFH9H7b6c+46gq0ddePJcYdJbfn35ZoP
         CAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3d9kGYukMtruTN+aCHb8/eSDNrRV+dSSRH0clQM+LvaE2MkxLXxBORPFuueCg2svjHD7PavAE8LQLvOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa0u4rHqNpwbPYCeUNClm9770tJjUswHlLqGAYyCs866vFU5AV
	4t6XBE4GmYVeQQHmxfCXr5XHqMalN4IZm6AdFoyz8hvaWnZVJtFA+SbPVlIr0xQ42VHB6HpYeOT
	U/ROEmrw=
X-Google-Smtp-Source: AGHT+IFTL/qrxW22ZvcQ3tu3WutlO2t4RvbRVlSo2L9vJfLPpFPQttIOYpZLFTyT8+teTTJnwS97Jg==
X-Received: by 2002:a05:6a21:9218:b0:1c4:8da5:c665 with SMTP id adf61e73a8af0-1cce0feabb6mr4004249637.11.1724962319911;
        Thu, 29 Aug 2024 13:11:59 -0700 (PDT)
Received: from htcheong-p620.tpe.corp.google.com ([2401:fa00:1:17:8388:bd61:f13b:7b88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5577263sm1525694b3a.21.2024.08.29.13.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:11:59 -0700 (PDT)
From: Terry Cheong <htcheong@chromium.org>
Date: Fri, 30 Aug 2024 04:11:53 +0800
Subject: [PATCH v3] ALSA: hda/realtek: add patch for internal mic in Lenovo
 V145
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-lenovo-v145-fixes-v3-1-f7b7265068fa@chromium.org>
X-B4-Tracking: v=1; b=H4sIAAjW0GYC/4WNQQ6CMBBFr0JmbU3bAQVX3sO4oO0ITYSSVhsN4
 e4OLF1oZvX+z38zQ6LoKcGpmCFS9smHkQF3Bdi+HTsS3jGDlrqUtW7EncaQg8iqrMTNvyiJRlo
 l29IZ21TAuynSVvDscmXufXqE+N5eZLWmv2xZCT5Ep+hQKzR4tn0Mg38O+xA7WIVZ/5VolhwVt
 rayxqB2X5JlWT69BDnG+gAAAA==
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Steve Kendall <skend@chromium.org>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Terry Cheong <htcheong@chromium.org>
X-Mailer: b4 0.13.0

Lenovo V145 is having phase inverted dmic but simply applying inverted
dmic fixups does not work. Chaining up verb fixes for ALC283 enables
inverting dmic fixup to work properly.

Signed-off-by: Terry Cheong <htcheong@chromium.org>
---
Changes in v3:
- Place PCI quirk in order in the quirk table.
- Fixed a typo in the model name for the patch.
- Link to v2: https://lore.kernel.org/r/20240829-lenovo-v145-fixes-v2-1-713ac5cbb32d@chromium.org

Changes in v2:
- Corrected description for the patch.
- Link to v1: https://lore.kernel.org/r/20240829-lenovo-v145-fixes-v1-1-133d1e6813b3@chromium.org
---
 sound/pci/hda/patch_realtek.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 588738ce7380..ff62702a8226 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7538,6 +7538,7 @@ enum {
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
+	ALC236_FIXUP_LENOVO_INV_DMIC,
 	ALC298_FIXUP_SAMSUNG_AMP,
 	ALC298_FIXUP_SAMSUNG_AMP2,
 	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
@@ -9161,6 +9162,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_mute_led_micmute_vref,
 	},
+	[ALC236_FIXUP_LENOVO_INV_DMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_inv_dmic,
+		.chained = true,
+		.chain_id = ALC283_FIXUP_INT_MIC,
+	},
 	[ALC298_FIXUP_SAMSUNG_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_samsung_amp,
@@ -10742,6 +10749,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38f9, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38fa, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
@@ -10994,6 +11002,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
+	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
 	{}
 };
 #define ALC225_STANDARD_PINS \

---
base-commit: 86987d84b968b69a610fd00ab9006c13db193b4e
change-id: 20240829-lenovo-v145-fixes-90c10a4dbc95

Best regards,
-- 
Terry Cheong <htcheong@chromium.org>


