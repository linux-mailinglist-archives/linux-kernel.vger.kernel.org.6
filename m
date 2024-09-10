Return-Path: <linux-kernel+bounces-322332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8A3972768
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CC71F242E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B0214F122;
	Tue, 10 Sep 2024 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoK4ATCo"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB424A0C;
	Tue, 10 Sep 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937454; cv=none; b=K0SaA+xv/Vx8ii30QCMWAPwFa8MzQ2L4ntttLYHwZTchjjM7CovbUU+X9DXDYVubnMG7tqr4x0gP3Cm3u+24afZeN8ifPuoA5GBrf7oRBW2hDBsDCbKAl4fBOB6UqbaVb0gIgmruAppH3Se5ayoGalCNJ4xGKU0kxuy90ZQOsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937454; c=relaxed/simple;
	bh=7u3mvC3quw4Iq9MUuO2yJeb+rVXaSqaTB8bmmj8wsfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dfxyXPw1I7J9hrc7K3SUvJJiez7pL1dkOkuHR1L0+ezMkjRub10EpRYOzene0SPSItI9BWNgARbt6X+wxEQNYymLqVxQXXAEbFo8a9qbfFPdESzK+oITryz5dOTp19vrcGQ83tloG4c8wnMXfX3nfk8oOE7Iy+DbxggYA5HDHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoK4ATCo; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3613767a12.0;
        Mon, 09 Sep 2024 20:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725937452; x=1726542252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zTPV0QAxETLyB0ffSzBFpGcDqC9fhVTxXSRciFgACp0=;
        b=QoK4ATCoiBSpF+DO6mgBEL31vYEnXZIgTTout5heiiUypwyDG1hkU+w1LMXd+InNHh
         q6ps2fR1/lOjTdO6n/i9obLBAdRY5fZqk+8PP98X0mrG2ZX2wMhXsqNpnP7DZ5xNF/9f
         Br0SAZHc7ingADRHVBCQO1tRf+8iwzPAXJ1XwBhMUSytrFrurldc6sz20+DS9ec+7a8P
         Jk1UBW+ilfEdfnnM8axqVrOTqsf6hDKvY+1H5Q185+GbSdD8KEu8Xbxt38exDNxjj1aH
         QK2HeTAO9MJQOtR8QSJvjZeaqrZNEUUDD3oddaV3CjtK8I0bbG/91rMVZVlrkN7iWU+R
         9VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725937452; x=1726542252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTPV0QAxETLyB0ffSzBFpGcDqC9fhVTxXSRciFgACp0=;
        b=quS6MCtuYOhhnbnYGU9YM0rrXBxRfZPBPLVHu0YscUz+8X+YY8uI9ZSiDPlFhZlpmD
         v1EJe2AY2F80BIbfN/8rHENQlRUMRO8ERg7vMPF54udsSOlv84hLrLxzJuIlMmiP6FOh
         s3PQe4Re4pMxlkYszwf/Chhl3/ic+NbN5mVCXtjj9M/NEJjBXf38NLNsO0Ip5IZQQKu9
         4IbYImsmytZzNlrO9n1q50bRhjNHpavfD/VlniO54T85+7yyhSGC0A1IJUZRSzKYxlZ4
         0PSvgHr9g6yjp3pZV7lZ4FeTIdz1CVHM8L1rupSca+Uz9C3tCg6BAID+CK8lNjLrkcuH
         wo3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnfu1WiuriTTMXIxKl8DmQlX3mwpmcRSAQCpKAYltFwPfhwqdPXG6S5KNm53GYA3HR27kHsoZjLmhWJGo=@vger.kernel.org, AJvYcCX4T/ic12mM5/hS7OobWz4l0wa9sljsM0y7gRqYnWPG9lO7GxGmEtjEdDrLYAEnjuKrHUjLOlS+KyQJxXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzolL0Zs2cnNyL1x/Pls2AmmBRkUDHo/hbttbqGRCedcBN2K84J
	4VHUb3Kl+4cK8tfuTVQMTj0G0eJhtRH3jPaEWLfAzTfHpPJbRTKDjmoAJMYf
X-Google-Smtp-Source: AGHT+IEu74iKokulLnr1mudVOKiVipW4GTsRAFdE3cPSd38YQccNCtIXum0WBhf2+DfgI3NTKyOycg==
X-Received: by 2002:a17:90a:bb95:b0:2d8:a9af:b94f with SMTP id 98e67ed59e1d1-2daffa3aaedmr11259891a91.7.1725937451482;
        Mon, 09 Sep 2024 20:04:11 -0700 (PDT)
Received: from smtp.gmail.com (220-128-132-142.hinet-ip.hinet.net. [220.128.132.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04136b4esm5297225a91.8.2024.09.09.20.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 20:04:11 -0700 (PDT)
From: Leo Tsai <antivirus621@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: leo.tsai@cmedia.com.tw,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leo Tsai <antivirus621@gmail.com>
Subject: [PATCH] [PATCH v2]ALSA: hda: Add a new CM9825 standard driver.
Date: Tue, 10 Sep 2024 11:03:57 +0800
Message-Id: <20240910030357.6292-1-antivirus621@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CM9825 is a High Definition Audio Codec.
There are 2 independent stereo outputs, one of the stereo
outputs is cap-less with HP AMP, and the other is line out to
connect the active speaker. The inputs can be Line-in and MIC-in.

Signed-off-by: Leo Tsai <antivirus621@gmail.com>
---
 sound/pci/hda/patch_cmedia.c | 267 +++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index 2ddd33f8dd6c..92f8d3682e84 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -17,10 +17,229 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
+/* CM9825 Offset Definitions */
+
+#define CM9825_VERB_SET_HPF_1 0x781
+#define CM9825_VERB_SET_HPF_2 0x785
+#define CM9825_VERB_SET_PLL 0x7a0
+#define CM9825_VERB_SET_NEG 0x7a1
+#define CM9825_VERB_SET_ADCL 0x7a2
+#define CM9825_VERB_SET_DACL 0x7a3
+#define CM9825_VERB_SET_MBIAS 0x7a4
+#define CM9825_VERB_SET_VNEG 0x7a8
+#define CM9825_VERB_SET_D2S 0x7a9
+#define CM9825_VERB_SET_DACTRL 0x7aa
+#define CM9825_VERB_SET_PDNEG 0x7ac
+#define CM9825_VERB_SET_VDO 0x7ad
+#define CM9825_VERB_SET_CDALR 0x7b0
+#define CM9825_VERB_SET_MTCBA 0x7b1
+#define CM9825_VERB_SET_OTP 0x7b2
+#define CM9825_VERB_SET_OCP 0x7b3
+#define CM9825_VERB_SET_GAD 0x7b4
+#define CM9825_VERB_SET_TMOD 0x7b5
+#define CM9825_VERB_SET_SNR 0x7b6
+
 struct cmi_spec {
 	struct hda_gen_spec gen;
+	const struct hda_verb *chip_d0_verbs;
+	const struct hda_verb *chip_d3_verbs;
+	const struct hda_verb *chip_hp_present_verbs;
+	const struct hda_verb *chip_hp_remove_verbs;
+	struct hda_codec *codec;
+	struct delayed_work unsol_hp_work;
+	int quirk;
+};
+
+static const struct hda_verb cm9825_std_d3_verbs[] = {
+	/* chip sleep verbs */
+	{0x43, CM9825_VERB_SET_D2S, 0x62},	/* depop */
+	{0x43, CM9825_VERB_SET_PLL, 0x01},	/* PLL set */
+	{0x43, CM9825_VERB_SET_NEG, 0xc2},	/* NEG set */
+	{0x43, CM9825_VERB_SET_ADCL, 0x00},	/* ADC */
+	{0x43, CM9825_VERB_SET_DACL, 0x02},	/* DACL */
+	{0x43, CM9825_VERB_SET_VNEG, 0x50},	/* VOL NEG */
+	{0x43, CM9825_VERB_SET_MBIAS, 0x00},	/* MBIAS */
+	{0x43, CM9825_VERB_SET_PDNEG, 0x04},	/* SEL OSC */
+	{0x43, CM9825_VERB_SET_CDALR, 0xf6},	/* Class D */
+	{0x43, CM9825_VERB_SET_OTP, 0xcd},	/* OTP set */
+	{}
+};
+
+static const struct hda_verb cm9825_std_d0_verbs[] = {
+	/* chip init verbs */
+	{0x34, AC_VERB_SET_EAPD_BTLENABLE, 0x02},	/* EAPD set */
+	{0x43, CM9825_VERB_SET_SNR, 0x30},	/* SNR set */
+	{0x43, CM9825_VERB_SET_PLL, 0x00},	/* PLL set */
+	{0x43, CM9825_VERB_SET_ADCL, 0x00},	/* ADC */
+	{0x43, CM9825_VERB_SET_DACL, 0x02},	/* DACL */
+	{0x43, CM9825_VERB_SET_MBIAS, 0x00},	/* MBIAS */
+	{0x43, CM9825_VERB_SET_VNEG, 0x56},	/* VOL NEG */
+	{0x43, CM9825_VERB_SET_D2S, 0x62},	/* depop */
+	{0x43, CM9825_VERB_SET_DACTRL, 0x00},	/* DACTRL set */
+	{0x43, CM9825_VERB_SET_PDNEG, 0x0c},	/* SEL OSC */
+	{0x43, CM9825_VERB_SET_VDO, 0x80},	/* VDO set */
+	{0x43, CM9825_VERB_SET_CDALR, 0xf4},	/* Class D */
+	{0x43, CM9825_VERB_SET_OTP, 0xcd},	/* OTP set */
+	{0x43, CM9825_VERB_SET_MTCBA, 0x61},	/* SR set */
+	{0x43, CM9825_VERB_SET_OCP, 0x33},	/* OTP set */
+	{0x43, CM9825_VERB_SET_GAD, 0x07},	/* ADC -3db */
+	{0x43, CM9825_VERB_SET_TMOD, 0x26},	/* Class D clk */
+	{0x3C, AC_VERB_SET_AMP_GAIN_MUTE | AC_AMP_SET_RIGHT, 0x2d},	/* Gain set */
+	{0x3C, AC_VERB_SET_AMP_GAIN_MUTE | AC_AMP_SET_LEFT, 0x2d},	/* Gain set */
+	{0x43, CM9825_VERB_SET_HPF_1, 0x40},	/* HPF set */
+	{0x43, CM9825_VERB_SET_HPF_2, 0x40},	/* HPF set */
+	{}
 };
 
+static const struct hda_verb cm9825_hp_present_verbs[] = {
+	{0x42, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00},	/* PIN off */
+	{0x43, CM9825_VERB_SET_ADCL, 0x88},	/* ADC */
+	{0x43, CM9825_VERB_SET_DACL, 0xaa},	/* DACL */
+	{0x43, CM9825_VERB_SET_MBIAS, 0x10},	/* MBIAS */
+	{0x43, CM9825_VERB_SET_D2S, 0xf2},	/* depop */
+	{0x43, CM9825_VERB_SET_DACTRL, 0x00},	/* DACTRL set */
+	{0x43, CM9825_VERB_SET_VDO, 0xc4},	/* VDO set */
+	{}
+};
+
+static const struct hda_verb cm9825_hp_remove_verbs[] = {
+	{0x43, CM9825_VERB_SET_ADCL, 0x00},	/* ADC */
+	{0x43, CM9825_VERB_SET_DACL, 0x56},	/* DACL */
+	{0x43, CM9825_VERB_SET_MBIAS, 0x00},	/* MBIAS */
+	{0x43, CM9825_VERB_SET_D2S, 0x62},	/* depop */
+	{0x43, CM9825_VERB_SET_DACTRL, 0xe0},	/* DACTRL set */
+	{0x43, CM9825_VERB_SET_VDO, 0x80},	/* VDO set */
+	{0x42, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},	/* PIN on */
+	{}
+};
+
+static void cm9825_unsol_hp_delayed(struct work_struct *work)
+{
+	struct cmi_spec *spec =
+	    container_of(to_delayed_work(work), struct cmi_spec, unsol_hp_work);
+	struct hda_jack_tbl *jack;
+	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	bool hp_jack_plugin = false;
+	int err = 0;
+
+	hp_jack_plugin = snd_hda_jack_detect(spec->codec, hp_pin);
+
+	codec_dbg(spec->codec, "hp_jack_plugin %d, hp_pin 0x%X\n",
+		  (int)hp_jack_plugin, hp_pin);
+
+	if (!hp_jack_plugin) {
+		err =
+		    snd_hda_codec_write(spec->codec, 0x42, 0,
+					AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40);
+		if (err)
+			codec_dbg(spec->codec, "codec_write err %d\n", err);
+
+		snd_hda_sequence_write(spec->codec, spec->chip_hp_remove_verbs);
+	} else {
+		snd_hda_sequence_write(spec->codec,
+				       spec->chip_hp_present_verbs);
+	}
+
+	jack = snd_hda_jack_tbl_get(spec->codec, hp_pin);
+	if (jack) {
+		jack->block_report = 0;
+		snd_hda_jack_report_sync(spec->codec);
+	}
+}
+
+static void hp_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
+{
+	struct cmi_spec *spec = codec->spec;
+	struct hda_jack_tbl *tbl;
+
+	/* Delay enabling the HP amp, to let the mic-detection
+	 * state machine run.
+	 */
+
+	codec_dbg(spec->codec, "cb->nid 0x%X\n", cb->nid);
+
+	tbl = snd_hda_jack_tbl_get(codec, cb->nid);
+	if (tbl)
+		tbl->block_report = 1;
+	schedule_delayed_work(&spec->unsol_hp_work, msecs_to_jiffies(200));
+}
+
+static void cm9825_setup_unsol(struct hda_codec *codec)
+{
+	struct cmi_spec *spec = codec->spec;
+
+	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+
+	snd_hda_jack_detect_enable_callback(codec, hp_pin, hp_callback);
+}
+
+static int cm9825_init(struct hda_codec *codec)
+{
+	snd_hda_gen_init(codec);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
+
+	return 0;
+}
+
+static void cm9825_free(struct hda_codec *codec)
+{
+	struct cmi_spec *spec = codec->spec;
+
+	cancel_delayed_work_sync(&spec->unsol_hp_work);
+	snd_hda_gen_free(codec);
+}
+
+static int cm9825_suspend(struct hda_codec *codec)
+{
+	struct cmi_spec *spec = codec->spec;
+
+	cancel_delayed_work_sync(&spec->unsol_hp_work);
+
+	snd_hda_sequence_write(codec, spec->chip_d3_verbs);
+
+	return 0;
+}
+
+static int cm9825_resume(struct hda_codec *codec)
+{
+	struct cmi_spec *spec = codec->spec;
+	hda_nid_t hp_pin = 0;
+	bool hp_jack_plugin = false;
+	int err;
+
+	err =
+	    snd_hda_codec_write(spec->codec, 0x42, 0,
+				AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00);
+	if (err)
+		codec_dbg(codec, "codec_write err %d\n", err);
+
+	msleep(150);		/* for depop noise */
+
+	codec->patch_ops.init(codec);
+
+	hp_pin = spec->gen.autocfg.hp_pins[0];
+	hp_jack_plugin = snd_hda_jack_detect(spec->codec, hp_pin);
+
+	codec_dbg(spec->codec, "hp_jack_plugin %d, hp_pin 0x%X\n",
+		  (int)hp_jack_plugin, hp_pin);
+
+	if (!hp_jack_plugin) {
+		err =
+		    snd_hda_codec_write(spec->codec, 0x42, 0,
+					AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40);
+
+		if (err)
+			codec_dbg(codec, "codec_write err %d\n", err);
+
+		snd_hda_sequence_write(codec, cm9825_hp_remove_verbs);
+	}
+
+	snd_hda_regmap_sync(codec);
+	hda_call_check_power_status(codec, 0x01);
+
+	return 0;
+}
+
 /*
  * stuff for auto-parser
  */
@@ -32,6 +251,53 @@ static const struct hda_codec_ops cmi_auto_patch_ops = {
 	.unsol_event = snd_hda_jack_unsol_event,
 };
 
+static int patch_cm9825(struct hda_codec *codec)
+{
+	struct cmi_spec *spec;
+	struct auto_pin_cfg *cfg;
+	int err;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&spec->unsol_hp_work, cm9825_unsol_hp_delayed);
+	codec->spec = spec;
+	spec->codec = codec;
+	codec->patch_ops = cmi_auto_patch_ops;
+	codec->patch_ops.init = cm9825_init;
+	codec->patch_ops.suspend = cm9825_suspend;
+	codec->patch_ops.resume = cm9825_resume;
+	codec->patch_ops.free = cm9825_free;
+	codec->patch_ops.check_power_status = snd_hda_gen_check_power_status;
+	cfg = &spec->gen.autocfg;
+	snd_hda_gen_spec_init(&spec->gen);
+	spec->chip_d0_verbs = cm9825_std_d0_verbs;
+	spec->chip_d3_verbs = cm9825_std_d3_verbs;
+	spec->chip_hp_present_verbs = cm9825_hp_present_verbs;
+	spec->chip_hp_remove_verbs = cm9825_hp_remove_verbs;
+
+	snd_hda_sequence_write(codec, spec->chip_d0_verbs);
+
+	err = snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
+	if (err < 0)
+		goto error;
+	err = snd_hda_gen_parse_auto_config(codec, cfg);
+	if (err < 0)
+		goto error;
+
+	cm9825_setup_unsol(codec);
+
+	return 0;
+
+ error:
+	cm9825_free(codec);
+
+	codec_info(codec, "Enter err %d\n", err);
+
+	return err;
+}
+
 static int patch_cmi9880(struct hda_codec *codec)
 {
 	struct cmi_spec *spec;
@@ -113,6 +379,7 @@ static const struct hda_device_id snd_hda_id_cmedia[] = {
 	HDA_CODEC_ENTRY(0x13f68888, "CMI8888", patch_cmi8888),
 	HDA_CODEC_ENTRY(0x13f69880, "CMI9880", patch_cmi9880),
 	HDA_CODEC_ENTRY(0x434d4980, "CMI9880", patch_cmi9880),
+	HDA_CODEC_ENTRY(0x13f69825, "CM9825", patch_cm9825),
 	{} /* terminator */
 };
 MODULE_DEVICE_TABLE(hdaudio, snd_hda_id_cmedia);
-- 
2.34.1


