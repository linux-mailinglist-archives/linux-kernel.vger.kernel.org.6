Return-Path: <linux-kernel+bounces-320542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4074B970BC4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327531C219CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393F317555;
	Mon,  9 Sep 2024 02:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+g0i098"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF4EEA6;
	Mon,  9 Sep 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725848639; cv=none; b=Q3oUITg1ihtCXGIeo2bOlSxrsJL/TIuNyDHeVRkJs248bTq/2kZnYXF+cN7VhMJVxAW6dBfmdik5a/6APt8gw3Gv9SCz/Mj+lShgloeEtPaJvrxkByPJgyDfj6Tb7SkNmfPSth3BitCh6bkT9v9XVGgejg03IcmT0e9tWvL2gbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725848639; c=relaxed/simple;
	bh=mq1koLWNEnW4Fe+hl1VsqjMrVn3w+6BFGCrtwgAVWdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EtxJ5OgA5ZxDP+TKjIYD9s6xR3R5ImFmzK+9PYa9cd4Qki/ao9T6I+bunWjHLZpkz0+XUVnl2sRwZV48CyI/I/TfhziniE7EN42u84OUhuHdCNBHUitBUPBaD+tBAYjrwY/9td8O0zo0A/KNJ2FP8iRvKE3/sjUJOvG1ECvmt/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+g0i098; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2705d31a35cso2341198fac.0;
        Sun, 08 Sep 2024 19:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725848636; x=1726453436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nK1sgAxKmiOnePQ9gWQZYzclNhaDo5IztXHHadMM5YU=;
        b=F+g0i098bKTQogqkKbcEJEHrCev7fOYd1K//YznmE45kugzfKFgXHpixl9YT9fAy/L
         HKTYE3LllZTQ7488hdQ3Jwhd4W69qAJePvCoFUzaTsB1f0P/eJAcWY3LyHlyxVra31Nj
         XhVN65q2HJ7Lr7J+MqTE53/lp4AYVWiMWlcMAHM8tULo1gE44lhjAufmPGTF/dxwbrfO
         t5dgfrKotJ5CqyEszbPA7e4zyq2oygwMfFgaAlaOYIp4zfOOafX5izlhSxhsb6TImZNe
         9frZgRCBRDNP8e0qwI74bOgDChCU3rBb+GNo3bGzdCeoV9MJkAcyw/4dH6vw7UHH2yaW
         4+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725848636; x=1726453436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nK1sgAxKmiOnePQ9gWQZYzclNhaDo5IztXHHadMM5YU=;
        b=FDvsHP/hOZdTyAah7YC9EUd9rFprWLr6QAokSFogblgkjuEVCfnr1c2MoRT1RTCNz9
         iJtDp2xcCpPyhqIr9eedyndGyCKUVJw8KclhQq3w8KA2zqKqMRhrS2BwhF14b2c2upXM
         YUchsUReOnH+pcD3nR5lKsqgQI8AIBFNqRYhxLsHWoxTCuTbuN9l45WZUMPhpDjjGaMb
         RunG3HUXiMTJi7Hr/GGAXplr5FbmajUI3aA2AtFbgMbqH5FphKOHFsY8zVNcVGjwUDeP
         l8vgIgiyBI5Y79wOFR0PQREEB4PUtnioWxPgAz/BSnyeQM+XzPQDVlQbqARIL9SJAWNH
         EGJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdVvteV4w6gwoamzkHsAtFTEZE0ywYLYeUZ8nca7BrYMl3SySlkgFsPnSQ4Hes+FH+cBc+9iAnD399iCU=@vger.kernel.org, AJvYcCWloWf7jsqPyLUoAC4jip8wAFi2ix70zNCXn5gjh0kR6o6zYPxeqNREc7Ns30+p/odfdq5tVwsPNAgMEek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqYDKCvBkx3+ABRvn4m9mFLsS07cnRcBruLykkFTBBveeda+d
	0mRJXuGFzV0TaGSMR/ELogMcCCA6N//nLhUgZWOAcG3seqIwJ0F3tCzI2V2h
X-Google-Smtp-Source: AGHT+IHzQ91+/hhEYfTYWkvlB6JdAipi5AVorjdaVP1wJlGP0ZLvnTf4ZFZbuollkAx+JkpLMdzUqQ==
X-Received: by 2002:a05:6870:538d:b0:270:3139:59fe with SMTP id 586e51a60fabf-27b82e10e21mr11049322fac.12.1725848636554;
        Sun, 08 Sep 2024 19:23:56 -0700 (PDT)
Received: from smtp.gmail.com (220-128-132-142.hinet-ip.hinet.net. [220.128.132.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e59687e2sm2562964b3a.114.2024.09.08.19.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 19:23:56 -0700 (PDT)
From: Leo Tsai <antivirus621@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: leo.tsai@cmedia.com.tw,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leo Tsai <antivirus621@gmail.com>
Subject: [PATCH] ALSA: hda: Add a new CM9825 standard driver.
Date: Mon,  9 Sep 2024 10:23:40 +0800
Message-Id: <20240909022340.7808-1-antivirus621@gmail.com>
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
 sound/pci/hda/patch_cmedia.c | 268 +++++++++++++++++++++++++++++++++++
 1 file changed, 268 insertions(+)
 mode change 100644 => 100755 sound/pci/hda/patch_cmedia.c

diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
old mode 100644
new mode 100755
index 2ddd33f8dd6c..3195261a7d2c
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -17,10 +17,230 @@
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
+	{0x3C, AC_VERB_SET_AMP_GAIN_MUTE | 0x0a0, 0x2d},	/* Gain set */
+	{0x3C, AC_VERB_SET_AMP_GAIN_MUTE | 0x090, 0x2d},	/* Gain set */
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
+#define cmi_is_s3_resume(codec) \
+	((codec)->core.dev.power.power_state.event == PM_EVENT_RESUME)
+#define cmi_is_s4_resume(codec) \
+	((codec)->core.dev.power.power_state.event == PM_EVENT_RESTORE)
+
+static int cm9825_init(struct hda_codec *codec)
+{
+	snd_hda_gen_init(codec);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
+
+	return 0;
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
+	/* hibernation resume needs the full chip initialization */
+	if (cmi_is_s4_resume(codec))
+		codec_dbg(spec->codec, "resume from S4\n");
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
@@ -32,6 +252,53 @@ static const struct hda_codec_ops cmi_auto_patch_ops = {
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
+	codec->spec = spec;
+	spec->codec = codec;
+	codec->patch_ops = cmi_auto_patch_ops;
+	codec->patch_ops.init = cm9825_init;
+	codec->patch_ops.suspend = cm9825_suspend;
+	codec->patch_ops.resume = cm9825_resume;
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
+	INIT_DELAYED_WORK(&spec->unsol_hp_work, cm9825_unsol_hp_delayed);
+
+	cm9825_setup_unsol(codec);
+
+	return 0;
+
+ error:
+	snd_hda_gen_free(codec);
+
+	codec_info(codec, "Enter err %d\n", err);
+
+	return err;
+}
+
 static int patch_cmi9880(struct hda_codec *codec)
 {
 	struct cmi_spec *spec;
@@ -113,6 +380,7 @@ static const struct hda_device_id snd_hda_id_cmedia[] = {
 	HDA_CODEC_ENTRY(0x13f68888, "CMI8888", patch_cmi8888),
 	HDA_CODEC_ENTRY(0x13f69880, "CMI9880", patch_cmi9880),
 	HDA_CODEC_ENTRY(0x434d4980, "CMI9880", patch_cmi9880),
+	HDA_CODEC_ENTRY(0x13f69825, "CM9825", patch_cm9825),
 	{} /* terminator */
 };
 MODULE_DEVICE_TABLE(hdaudio, snd_hda_id_cmedia);
-- 
2.34.1


