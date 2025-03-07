Return-Path: <linux-kernel+bounces-551979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB9A573AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E313B0804
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE8523F438;
	Fri,  7 Mar 2025 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs3lMYc5"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A711AA1D9;
	Fri,  7 Mar 2025 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383250; cv=none; b=qSofLSfRXXBfdXkve6HfmNYMXunFIuYupY1nDXXLnA3WEd48dJ0D/rKC/7VvxHKf3ap/vemgxXMLoUD2AUfWLG7k3ILpW3I70GcAALFNfCFaXtW1+pU5m9Fvl3WbepKOSa/0720ARfu/DHCzpcymb86ajGVPZ78eDCWmRTfWMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383250; c=relaxed/simple;
	bh=iKD2hfqpK3i4DHA3EEG9DcONp3f7uz5jm6h+RrK8dZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdcrkzodutPvsY38CzdyK0Qbm7s/xcruk32TIsVAhXaNUF0YiTL2/n8ufj4FtNSvmfmhNWeOYifJE2vABCvVRifqzO+fiXE5T2fMJqw3ibkvtzDcdeL/9rYUqaaBZDVTIlqw9BnSxl9fKWSSoskA5qrHD5zZzYJPidIK5VtCr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs3lMYc5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216513f8104so4803735ad.2;
        Fri, 07 Mar 2025 13:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741383248; x=1741988048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kEgsNWjuBG1Rlp30GfVSxF9HcCJGvmeB0AXoL2Q2Fk=;
        b=bs3lMYc5efpmlKPqcOMoZl5VdZo61/iysOeQOpRNta9gmZNxQjs1nq9KrfalnKOg+Y
         3fcYH1VNft3j/4fXRBydF67Sk2OMT1LWA7O1Pk9FLP+lwUKd09OMC/N3aQ/X1zQjER8S
         93GY9QACSHMSJ5RchssyMv15qpCouuJvBN5Y4Z6Kwvg8hYPTr0osoll5WN277sOpGYuw
         2YSYiWtAVg+6TkjjRD2hUrByJkLoSTs4IE2VvXqYMuyHwOnO5Tx7IvOu1aXC0AWvO8HC
         RjxKHdl8u08JSGCa7KwveBxEXpit4gx2OnkG718t+i+/irlD1YLuLH8O7P9BWNO01HSr
         T9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741383248; x=1741988048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kEgsNWjuBG1Rlp30GfVSxF9HcCJGvmeB0AXoL2Q2Fk=;
        b=rfvxCM4iZwxM1SCuVvtB7te68RXMr/IaJeZMgtOGeUhktymYJXRVbq1/KgjIe1lTwP
         k+qEJdjcoJqrlOg+Ko2OHOF/kDEAZq2MZlPrjh58V2964ba7jk+BNvBTUuwOPLcuFwjr
         m7C645CvNVayoaRk2zhRZ6f26XFXHEWrR4o4i+XyPfen0IzCOcCtXxlSXSbc5TdSylYT
         JVQe9dFuoSj9u0q9dpYSAvjLJjsFvMby1UH4nGFUcV61JFvVPgG3pBtkso0o5S8Bu7bq
         9A4ShJXYSRIrUGr0i7tU/3p+RXKckh8eV6K7P6hlG8bKCPb2pb0vnngB0zWWjOAFXZuZ
         4WZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVMI4zx3SlVNeWdTTqv3IGt1v0ijGMivkMPFw8bnrOLQWxh3aHImSrmYnuga5jd3Lj2ExB+evRWEq6gKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHINYFji13zoi8Kn70wvRqEdXgi7tRIvuvGKXmTRQSgX65CcFD
	IeG5ek3Wp/ZLcUZKrxLo+yQvWnjKd2bLMPc4Z2bD7dh1F5CnJTP5
X-Gm-Gg: ASbGnct4JWgJ9OMb3UqsZySgB2AO1Z821etaFcNnZKlDiKsu3lp3tozohzHuvWsOvkM
	MVWmGfRwxUURGMMXwghu4Pjk9ElVqY+/UyZkfpE2a8elfTrvG//+nRYKZaNTple6bNfrzLOSGFQ
	RPnnY3GRlje/IE77ndaV9Ht6lZwMzO9r1xGsNziHVJtTWCeeGBjuT6hKG3xEmpRzAJfiE/mJX0C
	q47skx76RfEOUnNEAeEqVCfcsp1KZ4p28XPxc9tj2e15NxrjT4EKW0el+zmarfcFgWKYh5AxMDH
	uISPx5AY5Q4xqhLb/dckip7NZmrBVpM3rH3p0pVXawT3f8OqkL8yTA==
X-Google-Smtp-Source: AGHT+IFpIbghEXYNTZOtEUyaPvCuWT9aVCtfenazq4IYK1FK4TvSByQAcE96AIcnA1tH6mC80jw8QQ==
X-Received: by 2002:a05:6a20:6f93:b0:1f3:329a:db7e with SMTP id adf61e73a8af0-1f5583f0511mr266453637.10.1741383248120;
        Fri, 07 Mar 2025 13:34:08 -0800 (PST)
Received: from localhost ([2409:40f2:1049:75fb:98f4:7f2a:9f11:7927])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af50b2d4c9fsm1465985a12.76.2025.03.07.13.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:34:07 -0800 (PST)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion x360 14-dy1xxx
Date: Sat,  8 Mar 2025 03:03:19 +0530
Message-ID: <20250307213319.35507-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a fixup to enable the mute LED on HP Pavilion x360 Convertible
14-dy1xxx with ALC295 codec. The appropriate coefficient index and bits
were identified through a brute-force method, as detailed in
https://bbs.archlinux.org/viewtopic.php?pid=2079504#p2079504.

Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d2a1f836d..a84857a3c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4790,6 +4790,21 @@ static void alc236_fixup_hp_coef_micmute_led(struct hda_codec *codec,
 	}
 }
 
+static void alc295_fixup_hp_mute_led_coefbit11(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0xb;
+		spec->mute_led_coef.mask = 3 << 3;
+		spec->mute_led_coef.on = 1 << 3;
+		spec->mute_led_coef.off = 1 << 4;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 static void alc285_fixup_hp_mute_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -7656,6 +7671,7 @@ enum {
 	ALC290_FIXUP_MONO_SPEAKERS_HSJACK,
 	ALC290_FIXUP_SUBWOOFER,
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
+	ALC295_FIXUP_HP_MUTE_LED_COEFBIT11,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_LENOVO_XPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
@@ -9401,6 +9417,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC283_FIXUP_INT_MIC,
 	},
+	[ALC295_FIXUP_HP_MUTE_LED_COEFBIT11] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc295_fixup_hp_mute_led_coefbit11,
+	},
 	[ALC298_FIXUP_SAMSUNG_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_samsung_amp,
@@ -10451,6 +10471,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.48.1


