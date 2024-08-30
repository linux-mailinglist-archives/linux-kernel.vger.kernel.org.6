Return-Path: <linux-kernel+bounces-308355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07A2965AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561AE284907
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689D16F0CB;
	Fri, 30 Aug 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lthEYSMi"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096413BAC2;
	Fri, 30 Aug 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007543; cv=none; b=bADgml5SJLaS2YleapyIpWdCJv9f3dx9xtg4Q2v+5Zh+5sXyQfXlzhucvJ/jvHQFIk0leqmu17K++QVJKYsIFA3YET3HNMsMkocMJpmeSFAQ6o4UZBZB0xbpZ9Of4jGy4JarAWjISPTPAP8IMdaGP9t/c737DNsIqEgWbeH4kNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007543; c=relaxed/simple;
	bh=wiXdC8NleT4FNkllqwZD+eTmy/deYiDnRn8i/MkAf9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OgT+kcTdGMDXdRE8QH4N26tW4cC75xHsLSMPru9lwSwCrCT5IGF9lLe7K3ZlKy9dUo21QQXQYEScR96YTjZQN26jHFcmC3iaU6KlOahGF7MNfZZI5pLTAGnJlrR7E7PB8mt88eqSzPTgYt1MKtg1dVQ0FwQSei/kX/niXgPn5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lthEYSMi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20219a0fe4dso13648075ad.2;
        Fri, 30 Aug 2024 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725007541; x=1725612341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWp62dvKeWezfq1cKVNp8W2gUEG6SEcVrTgI7hly2Ek=;
        b=lthEYSMiiwzxf/XF/Mrlh/eRNQPntkAh3sTqFJCKN93D+BKimV3nSph2qNTnhEuvMI
         k2jY4hQFKR2q8vV19b3CxSDsBQDa9FUFrvcuQDX6Y65x7bN/SztkkD7zm0cpfRUQYEue
         5XroKnOBSBDctfP+WOGIdq0+dX88vdpoKSnDsdNHZqK9rsNkN5b4Sx8Q6UlUUuI5Xg8D
         YvzuIAhnAsHi7c0/XoO8hk9vddqPbu37jtkxJ0I/ktl69HBbQt/lR5+NZDJY741GimQe
         CGJM84w7+3yw6Bt5AUQDk17GKIfj9/Ew95p40U4KF3e7SNKQT5KwZAYmHEX4FdE2MDiJ
         vnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725007541; x=1725612341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWp62dvKeWezfq1cKVNp8W2gUEG6SEcVrTgI7hly2Ek=;
        b=Rg6tRC5O8csj5BSh71C2yEfYsbDedEh1zb1cdulEhv2pt8h+LQvA5AhHEL8NrQ3xv5
         z2vzFS2JseVvVjJrFXxpE2E+YTSlsLfWDzzkfYjnk9ijBQQUdXF+7BVv9dUGQd09uzyQ
         FwgwnMJG9zK80Yk1liUwkibDm7xYTd8R2S3lrlbw/6Jpfd1MTnIP8S9pjilRYK3igPB8
         KYQISTlw4BstSAWZkeEwcZW8GMpDZTJ4eHaFaS0PzxQwtQSRnxMq3B52Z9lgzyu8FKmN
         Z3QvjKDTOs5iQMLn3LME28cho5UCXG7ySuJbn3S6Hoz/cgluSiR8qMnbtnCAEQkisqUz
         dHzg==
X-Forwarded-Encrypted: i=1; AJvYcCW1wUFXGs/uWGZzC+Nl8xGv1D6wearde4aujIBPMWR2WnCthMq3oK5hkx7NcXt9fiJIGhRoKEH8CTybj14=@vger.kernel.org, AJvYcCWIetfOMXLohlTZOqUPX0N7jKaE+bS+tcvPkC+ci6MBxtBqECfruOiJ8SuSGhcqWCDwRh/PaQPGnr1Vhvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylWAlIO3/+ys+mTsXK3xFkigo1Hh/EcWY/3u2TlR0Kdg8D0BSy
	VAYjWbfG6TCSWkeVoP/4AEgY1l0lxWaFs3VoIQ6SWjAxLLVDDSZd3Yu+ZS+f
X-Google-Smtp-Source: AGHT+IGNtITH37hET0HjzFUzIllI5oiOvZAucoyjMz5zogyWWRngEr0A++2+CvJZN/QWUlgb4zP/4A==
X-Received: by 2002:a17:902:ea12:b0:201:fac8:ff68 with SMTP id d9443c01a7336-2050c42d88dmr60133045ad.50.1725007540392;
        Fri, 30 Aug 2024 01:45:40 -0700 (PDT)
Received: from smtp.gmail.com (220-128-132-142.hinet-ip.hinet.net. [220.128.132.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b11dbsm22642525ad.50.2024.08.30.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:45:40 -0700 (PDT)
From: Leo Tsai <antivirus621@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: leo.tsai@cmedia.com.tw,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: Add new CM9825 driver
Date: Fri, 30 Aug 2024 16:45:21 +0800
Message-Id: <20240830084521.15706-1-antivirus621@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leo Tsai <leo.tsai@cmedia.com.tw>

Add new CM9825 driver with standard and NCR model.

Signed-off-by: Leo Tsai <leo.tsai@cmedia.com.tw>
---
 sound/pci/hda/patch_cmedia.c | 646 ++++++++++++++++++++++++++++++++++-
 1 file changed, 643 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index 2ddd33f8dd6c..c25bd0e74879 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -17,8 +17,538 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
+static char CM9825_Standard_Drv_Ver[15] = { "0.240723.0" };
+static char CM9825_NCR_Drv_Ver[15] = { "1.240805.0" };
+
+module_param_string(CM9825_Standard_Drv_Ver, CM9825_Standard_Drv_Ver,
+		    sizeof(CM9825_Standard_Drv_Ver), 0444);
+module_param_string(CM9825_NCR_Drv_Ver, CM9825_NCR_Drv_Ver,
+		    sizeof(CM9825_NCR_Drv_Ver), 0444);
+
 struct cmi_spec {
 	struct hda_gen_spec gen;
+	const struct hda_verb *chip_D0_verbs;
+	const struct hda_verb *chip_D3_verbs;
+	const struct hda_verb *chip_playback_start_verbs;
+	const struct hda_verb *chip_playback_stop_verbs;
+	const struct hda_verb *chip_HP_Present_verbs;
+	const struct hda_verb *chip_HP_Remove_verbs;
+	struct hda_codec *codec;
+	struct delayed_work unsol_hp_work;
+	int quirk;
+	unsigned int playback_started:1;
+};
+
+static const struct hda_verb cm9825_NCR_TpCon_verbs[] = {
+	{0x01, 0x720, 0xF0},
+	{0x01, 0x721, 0x88},
+	{0x01, 0x722, 0x43},
+	{0x01, 0x723, 0x10},
+	{0x34, 0x70C, 0x02},
+	{0x36, 0x71E, 0x11},
+	{0x43, 0x7A2, 0x8C},
+	{0x43, 0x7A9, 0x76},
+	{0x43, 0x7AA, 0x60},
+	{0x43, 0x7AD, 0xC0},
+	{0x43, 0x7B0, 0xF7},
+	{0x43, 0x7B1, 0xE1},
+	{0x43, 0x7B2, 0xCD},
+	{0x43, 0x7AA, 0xE0},
+	{0x43, 0x7A9, 0xF6},
+	{0x3C, 0x3A0, 0x2D},
+	{0x3C, 0x390, 0x2D},
+	{0x46, 0x7EF, 0x64},
+	{0x46, 0x78A, 0x40},
+	{0x46, 0x78B, 0x10},
+	{0x46, 0x78C, 0x06},
+	{0x46, 0x7B8, 0x2D},
+	{0x46, 0x7B9, 0x2D},
+	{0x46, 0x7BA, 0x83},
+	{}
+};
+
+static const struct hda_verb cm9825_NCR_D3_verbs[] = {
+	/* chip sleep verbs */
+	{0x43, 0x7A9, 0x62},
+	{0x43, 0x7A0, 0x01},
+	{0x43, 0x7A1, 0xC2},
+	{0x43, 0x7A2, 0x00},
+	{0x43, 0x7A3, 0x02},
+	{0x43, 0x7A8, 0x50},
+	{0x43, 0x7A4, 0x00},
+	{0x43, 0x7AC, 0x04},
+	{0x43, 0x7B0, 0xF6},
+	{0x43, 0x7B2, 0xCD},
+	{}
+};
+
+static const struct hda_verb cm9825_NCR_D0_verbs[] = {
+	/* chip init verbs */
+	{0x34, 0x70C, 0x02},
+	{0x43, 0x7B6, 0x30},
+	{0x43, 0x7A0, 0x00},
+	{0x43, 0x7A2, 0x00},
+	{0x43, 0x7A3, 0x02},
+	{0x43, 0x7A4, 0x00},
+	{0x43, 0x7A8, 0x56},
+	{0x43, 0x7A9, 0x62},
+	{0x43, 0x7AA, 0x00},
+	{0x43, 0x7AC, 0x0C},
+	{0x43, 0x7AD, 0xC4},
+	{0x43, 0x7B0, 0xF4},
+	{0x43, 0x7B2, 0xCD},
+	{0x43, 0x7B1, 0x61},
+	{0x43, 0x7B3, 0x33},
+	{0x43, 0x7B4, 0x07},
+	{0x43, 0x7B5, 0x26},
+	{0x3C, 0x3A0, 0x2D},
+	{0x3C, 0x390, 0x2D},
+	{0x43, 0x781, 0x40},
+	{0x43, 0x785, 0x40},
+	{0x3C, 0x341, 0x80},
+	{0x01, 0x720, 0xF0},
+	{0x01, 0x721, 0x88},
+	{0x01, 0x715, 0x01},
+	{0x01, 0x717, 0x01},
+	{0x3C, 0x340, 0x00},
+	{}
+};
+
+static const struct hda_verb cm9825_std_playback_start_verbs[] = {
+	{}
+};
+
+static const struct hda_verb cm9825_std_playback_stop_verbs[] = {
+	{}
+};
+
+static const struct hda_verb cm9825_NCR_playback_start_verbs[] = {
+	{0x43, 0x7A3, 0xAE},
+	{0x43, 0x7A9, 0xF2},
+	{0x43, 0x7AD, 0xC4},
+	{0x43, 0x7AA, 0xE0},
+	{}
+};
+
+static const struct hda_verb cm9825_NCR_playback_stop_verbs[] = {
+	{0x43, 0x7AD, 0xC0},
+	{0x43, 0x7A9, 0x62},
+	{0x43, 0x7AD, 0x80},
+	{0x43, 0x7AA, 0x00},
+	{0x43, 0x7A3, 0x02},
+	{}
+};
+
+static const struct hda_verb cm9825_D3_verbs[] = {
+	/* chip sleep verbs */
+	{0x43, 0x7A9, 0x62},
+	{0x43, 0x7A0, 0x01},
+	{0x43, 0x7A1, 0xC2},
+	{0x43, 0x7A2, 0x00},
+	{0x43, 0x7A3, 0x02},
+	{0x43, 0x7A8, 0x50},
+	{0x43, 0x7A4, 0x00},
+	{0x43, 0x7AC, 0x04},
+	{0x43, 0x7B0, 0xF6},
+	{0x43, 0x7B2, 0xCD},
+	{}
+};
+
+static const struct hda_verb cm9825_D0_verbs[] = {
+	/* chip init verbs */
+	{0x34, 0x70C, 0x02},
+	{0x43, 0x7B6, 0x30},
+	{0x43, 0x7A0, 0x00},
+	{0x43, 0x7A2, 0x00},
+	{0x43, 0x7A3, 0x02},
+	{0x43, 0x7A4, 0x00},
+	{0x43, 0x7A8, 0x56},
+	{0x43, 0x7A9, 0x62},
+	{0x43, 0x7AA, 0x00},
+	{0x43, 0x7AC, 0x0C},
+	{0x43, 0x7AD, 0x80},
+	{0x43, 0x7B0, 0xF4},
+	{0x43, 0x7B2, 0xCD},
+	{0x43, 0x7B1, 0x61},
+	{0x43, 0x7B3, 0x33},
+	{0x43, 0x7B4, 0x07},
+	{0x43, 0x7B5, 0x26},
+	{0x3C, 0x3A0, 0x2D},
+	{0x3C, 0x390, 0x2D},
+	{0x43, 0x781, 0x40},
+	{0x43, 0x785, 0x40},
+	{}
+};
+
+static const struct hda_verb cm9825_HP_Present_verbs[] = {
+	{0x42, 0x707, 0x00},
+	{0x43, 0x7A2, 0x88},
+	{0x43, 0x7A3, 0xAA},
+	{0x43, 0x7A4, 0x10},
+	{0x43, 0x7A9, 0xF2},
+	{0x43, 0x7AA, 0x00},
+	{0x43, 0x7AD, 0xC4},
+	{}
+};
+
+static const struct hda_verb cm9825_HP_Remove_verbs[] = {
+	{0x43, 0x7A2, 0x00},
+	{0x43, 0x7A3, 0x56},
+	{0x43, 0x7A4, 0x00},
+	{0x43, 0x7A9, 0x62},
+	{0x43, 0x7AA, 0xE0},
+	{0x43, 0x7AD, 0x80},
+	{0x42, 0x707, 0x40},
+	{}
+};
+
+/*
+ * CM9825 quirks table
+ */
+enum {
+	QUIRK_NONE,
+	QUIRK_CM9825_STANDARD,
+	QUIRK_CM9825_NCR,
+};
+
+static const struct snd_pci_quirk cm9825_quirks[] = {
+	SND_PCI_QUIRK(0x13F6, 0x9825, "Cmedia Standard", QUIRK_CM9825_STANDARD),
+	{}
+};
+
+static hda_nid_t cmi_get_hp_pin(struct cmi_spec *spec)
+{
+	if (spec->gen.autocfg.hp_pins[0]) {
+		codec_dbg(spec->codec, "hp_pin 0x%X\n",
+			  spec->gen.autocfg.hp_pins[0]);
+		return spec->gen.autocfg.hp_pins[0];
+	}
+	return 0;
+}
+
+static void cm9825_unsol_hp_delayed(struct work_struct *work)
+{
+	struct cmi_spec *spec =
+	    container_of(to_delayed_work(work), struct cmi_spec, unsol_hp_work);
+	struct hda_jack_tbl *jack;
+	hda_nid_t hp_pin = cmi_get_hp_pin(spec);
+	bool hp_jack_plugin = false;
+	int err = 0;
+
+	hp_jack_plugin = snd_hda_jack_detect(spec->codec, hp_pin);
+
+	codec_dbg(spec->codec, "hp_jack_plugin %d, hp_pin 0x%X\n",
+		  (int)hp_jack_plugin, hp_pin);
+
+	if (!hp_jack_plugin) {
+		err = snd_hda_codec_write(spec->codec, 0x42, 0, 0x707, 0x40);
+		if (err)
+			codec_dbg(spec->codec, "codec_write err %d\n", err);
+
+		snd_hda_sequence_write(spec->codec, spec->chip_HP_Remove_verbs);
+	} else {
+		snd_hda_sequence_write(spec->codec,
+				       spec->chip_HP_Present_verbs);
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
+	hda_nid_t hp_pin = cmi_get_hp_pin(spec);
+
+	snd_hda_jack_detect_enable_callback(codec, hp_pin, hp_callback);
+}
+
+static void CM9825_init_hook(struct hda_codec *codec)
+{
+	struct cmi_spec *spec = codec->spec;
+
+	codec_dbg(spec->codec, "Start\n");
+
+	snd_hda_sequence_write(codec, spec->chip_D0_verbs);
+}
+
+static void cm9825_playback_pcm_hook(struct hda_pcm_stream *hinfo,
+				     struct hda_codec *codec,
+				     struct snd_pcm_substream *substream,
+				     int action)
+{
+	struct cmi_spec *spec = codec->spec;
+
+	codec_dbg(codec, "start, action %d\n", action);
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_PREPARE:
+		spec->playback_started = 1;
+		snd_hda_sequence_write(codec, spec->chip_playback_start_verbs);
+		break;
+	case HDA_GEN_PCM_ACT_CLEANUP:
+		spec->playback_started = 0;
+		snd_hda_sequence_write(codec, spec->chip_playback_stop_verbs);
+		break;
+	default:
+		return;
+	}
+}
+
+#define cmi_is_s3_resume(codec) \
+	((codec)->core.dev.power.power_state.event == PM_EVENT_RESUME)
+#define cmi_is_s4_resume(codec) \
+	((codec)->core.dev.power.power_state.event == PM_EVENT_RESTORE)
+
+static int CM9825_init(struct hda_codec *codec)
+{
+	codec_dbg(codec, "Start\n");
+
+	snd_hda_gen_init(codec);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int cm9825_suspend(struct hda_codec *codec)
+{
+	struct cmi_spec *spec = codec->spec;
+
+	codec_dbg(codec, "Start\n");
+
+	cancel_delayed_work_sync(&spec->unsol_hp_work);
+
+	snd_hda_sequence_write(codec, spec->chip_D3_verbs);
+
+	return 0;
+}
+
+static int cm9825_NCR_suspend(struct hda_codec *codec)
+{
+	struct cmi_spec *spec = codec->spec;
+
+	codec_dbg(codec, "Start\n");
+
+	snd_hda_sequence_write(codec, spec->chip_D3_verbs);
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
+	codec_dbg(spec->codec, "Start\n");
+
+	err = snd_hda_codec_write(spec->codec, 0x42, 0, 0x707, 0x00);
+	if (err)
+		codec_dbg(codec, "codec_write err %d\n", err);
+
+	/* hibernation resume needs the full chip initialization */
+	if (cmi_is_s4_resume(codec))
+		codec_dbg(spec->codec, "resume from S4\n");
+
+	msleep(150);
+
+	codec->patch_ops.init(codec);
+
+	hp_pin = cmi_get_hp_pin(spec);
+	hp_jack_plugin = snd_hda_jack_detect(spec->codec, hp_pin);
+
+	codec_dbg(spec->codec, "hp_jack_plugin %d, hp_pin 0x%X\n",
+		  (int)hp_jack_plugin, hp_pin);
+
+	if (!hp_jack_plugin) {
+		err = snd_hda_codec_write(spec->codec, 0x42, 0, 0x707, 0x40);
+
+		if (err)
+			codec_dbg(codec, "codec_write err %d\n", err);
+
+		snd_hda_sequence_write(codec, cm9825_HP_Remove_verbs);
+	}
+
+	snd_hda_regmap_sync(codec);
+	hda_call_check_power_status(codec, 0x01);
+
+	return 0;
+}
+
+static int cm9825_NCR_resume(struct hda_codec *codec)
+{
+	struct cmi_spec *spec = codec->spec;
+
+	codec_dbg(spec->codec, "Start\n");
+
+	/* hibernation resume needs the full chip initialization */
+	if (cmi_is_s4_resume(codec))
+		codec_dbg(spec->codec, "resume from S4\n");
+
+	codec->patch_ops.init(codec);
+
+	snd_hda_regmap_sync(codec);
+	hda_call_check_power_status(codec, 0x01);
+
+	return 0;
+}
+#endif
+
+static void cm9825_detect_quirk(struct hda_codec *codec)
+{
+	struct cmi_spec *spec = codec->spec;
+
+	switch (codec->core.subsystem_id) {
+	case 0x104316E2:
+		spec->quirk = QUIRK_CM9825_STANDARD;
+		break;
+	case 0x104388F0:
+		spec->quirk = QUIRK_CM9825_NCR;
+		break;
+	default:
+		spec->quirk = QUIRK_CM9825_STANDARD;
+		break;
+	}
+}
+
+static u32 get_amp_max_value(struct hda_codec *codec, hda_nid_t nid, int dir,
+			     unsigned int ofs)
+{
+	u32 caps = query_amp_caps(codec, nid, dir);
+	/* get num steps */
+	caps = (caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT;
+	if (ofs < caps)
+		caps -= ofs;
+	return caps;
+}
+
+static inline int
+update_amp_value(struct hda_codec *codec, hda_nid_t nid,
+		 int ch, int dir, int idx, unsigned int ofs, unsigned int val)
+{
+	unsigned int maxval;
+
+	if (val > 0)
+		val += ofs;
+	/* ofs = 0: raw max value */
+	maxval = get_amp_max_value(codec, nid, dir, 0);
+	if (val > maxval)
+		val = maxval;
+	return snd_hda_codec_amp_update(codec, nid, ch, dir, idx,
+					HDA_AMP_VOLMASK, val);
+}
+
+static int cm9825_ncr_spk_vol_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	int chs = get_amp_channels(kcontrol);
+	int dir = get_amp_direction(kcontrol);
+	int idx = get_amp_index(kcontrol);
+	unsigned int ofs = get_amp_offset(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	int change = 0;
+
+	codec_dbg(codec, "nid 0x%X, chs %d, dir %d, *valp %ld\n",
+		  nid, chs, dir, *valp);
+
+	if (chs & 1) {
+		change = update_amp_value(codec, nid, 0, dir, idx, ofs, *valp);
+		update_amp_value(codec, 0x38, 0, dir, idx, ofs, *valp);
+		valp++;
+	}
+	if (chs & 2) {
+		change |= update_amp_value(codec, nid, 1, dir, idx, ofs, *valp);
+		update_amp_value(codec, 0x38, 1, dir, idx, ofs, *valp);
+	}
+	return change;
+}
+
+static int cm9825_ncr_switch_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = get_amp_nid(kcontrol);
+	int chs = get_amp_channels(kcontrol);
+	int dir = get_amp_direction(kcontrol);
+	int idx = get_amp_index(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	int change = 0;
+
+	codec_dbg(codec, "nid 0x%X, chs %d, dir %d, *valp %ld\n",
+		  nid, chs, dir, *valp);
+
+	if (chs & 1) {
+		change = snd_hda_codec_amp_update(codec, nid, 0, dir, idx,
+						  HDA_AMP_MUTE,
+						  *valp ? 0 : HDA_AMP_MUTE);
+		snd_hda_codec_amp_update(codec, 0x38, 0, dir, idx,
+					 HDA_AMP_MUTE,
+					 *valp ? 0 : HDA_AMP_MUTE);
+		valp++;
+	}
+	if (chs & 2) {
+		change |= snd_hda_codec_amp_update(codec, nid, 1, dir, idx,
+						   HDA_AMP_MUTE,
+						   *valp ? 0 : HDA_AMP_MUTE);
+		snd_hda_codec_amp_update(codec, 0x38, 1, dir, idx,
+					 HDA_AMP_MUTE,
+					 *valp ? 0 : HDA_AMP_MUTE);
+	}
+	hda_call_check_power_status(codec, nid);
+	return change;
+}
+
+#define CM9825_NCR_CODEC_VOL(xname, nid, channel, dir) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	  .name = xname, \
+	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
+	  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+			SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
+	  .info = snd_hda_mixer_amp_volume_info, \
+	  .get = snd_hda_mixer_amp_volume_get, \
+	  .put = cm9825_ncr_spk_vol_put, \
+	  .tlv = { .c = snd_hda_mixer_amp_tlv }, \
+	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, 0, dir) }
+
+#define CM9825_NCR_CODEC_MUTE(xname, nid, channel, dir) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	  .name = xname, \
+	  .subdevice = HDA_SUBDEV_AMP_FLAG, \
+	  .info = snd_hda_mixer_amp_switch_info, \
+	  .get = snd_hda_mixer_amp_switch_get, \
+	  .put = cm9825_ncr_switch_put, \
+	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, 0, dir) }
+
+static const struct snd_kcontrol_new cm9825_ncr_mixer[] = {
+	CM9825_NCR_CODEC_VOL("Master Playback Volume", 0x3C, 3, HDA_OUTPUT),
+	CM9825_NCR_CODEC_MUTE("Master Playback Switch", 0x3C, 3, HDA_OUTPUT),
+	{}
 };
 
 /*
@@ -32,6 +562,114 @@ static const struct hda_codec_ops cmi_auto_patch_ops = {
 	.unsol_event = snd_hda_jack_unsol_event,
 };
 
+static int patch_cm9825(struct hda_codec *codec)
+{
+	struct cmi_spec *spec;
+	struct auto_pin_cfg *cfg;
+	int err, i;
+	const struct snd_pci_quirk *quirk;
+
+	codec_dbg(spec->codec, "Start\n");
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	spec->codec = codec;
+
+	/* Detect codec quirk */
+	quirk = snd_pci_quirk_lookup(codec->bus->pci, cm9825_quirks);
+	if (quirk)
+		spec->quirk = quirk->value;
+	else
+		spec->quirk = QUIRK_CM9825_STANDARD;
+
+	if (spec->quirk == QUIRK_CM9825_STANDARD)
+		cm9825_detect_quirk(codec);
+
+	codec_dbg(spec->codec, "spec->quirk %d\n", spec->quirk);
+
+	codec->patch_ops = cmi_auto_patch_ops;
+	codec->patch_ops.init = CM9825_init;
+#ifdef CONFIG_PM
+	codec->patch_ops.suspend = cm9825_suspend;
+	codec->patch_ops.resume = cm9825_resume;
+	codec->patch_ops.check_power_status = snd_hda_gen_check_power_status;
+#endif
+	spec->gen.init_hook = CM9825_init_hook;
+	/* add hooks */
+	spec->gen.pcm_playback_hook = cm9825_playback_pcm_hook;
+
+	cfg = &spec->gen.autocfg;
+	snd_hda_gen_spec_init(&spec->gen);
+
+	if (spec->quirk == (int)QUIRK_CM9825_STANDARD) {
+		snd_hda_codec_set_name(codec, "CM9825 Standard");
+		spec->chip_D0_verbs = cm9825_D0_verbs;
+		spec->chip_D3_verbs = cm9825_D3_verbs;
+		spec->chip_HP_Present_verbs = cm9825_HP_Present_verbs;
+		spec->chip_HP_Remove_verbs = cm9825_HP_Remove_verbs;
+		spec->chip_playback_start_verbs =
+		    cm9825_std_playback_start_verbs;
+		spec->chip_playback_stop_verbs = cm9825_std_playback_stop_verbs;
+	} else if (spec->quirk == (int)QUIRK_CM9825_NCR) {
+#ifdef CONFIG_PM
+		codec->patch_ops.suspend = cm9825_NCR_suspend;
+		codec->patch_ops.resume = cm9825_NCR_resume;
+		codec->patch_ops.check_power_status =
+		    snd_hda_gen_check_power_status;
+#endif
+		snd_hda_codec_set_name(codec, "CM9825 NCR");
+		snd_hda_sequence_write(codec, cm9825_NCR_TpCon_verbs);
+		spec->chip_D0_verbs = cm9825_NCR_D0_verbs;
+		spec->chip_D3_verbs = cm9825_NCR_D3_verbs;
+		spec->chip_playback_start_verbs =
+		    cm9825_NCR_playback_start_verbs;
+		spec->chip_playback_stop_verbs = cm9825_NCR_playback_stop_verbs;
+
+		for (i = 0; i < ARRAY_SIZE(cm9825_ncr_mixer); i++) {
+			err = snd_hda_add_new_ctls(codec, &cm9825_ncr_mixer[i]);
+			if (err < 0) {
+				codec_info(codec, "add new ctls fail: %d\n",
+					   err);
+				goto error;
+			}
+		}
+	} else {
+		snd_hda_codec_set_name(codec, "CM9825 Standard");
+		spec->chip_D0_verbs = cm9825_D0_verbs;
+		spec->chip_D3_verbs = cm9825_D3_verbs;
+		spec->chip_HP_Present_verbs = cm9825_HP_Present_verbs;
+		spec->chip_HP_Remove_verbs = cm9825_HP_Remove_verbs;
+		spec->chip_playback_start_verbs =
+		    cm9825_std_playback_start_verbs;
+		spec->chip_playback_stop_verbs = cm9825_std_playback_stop_verbs;
+	}
+
+	err = snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
+	if (err < 0)
+		goto error;
+	err = snd_hda_gen_parse_auto_config(codec, cfg);
+	if (err < 0)
+		goto error;
+
+	if (spec->quirk == (int)QUIRK_CM9825_STANDARD) {
+		INIT_DELAYED_WORK(&spec->unsol_hp_work,
+				  cm9825_unsol_hp_delayed);
+		cm9825_setup_unsol(codec);
+	}
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
@@ -91,8 +729,8 @@ static int patch_cmi8888(struct hda_codec *codec)
 	if (get_defcfg_device(snd_hda_codec_get_pincfg(codec, 0x10)) ==
 	    AC_JACK_HP_OUT) {
 		static const struct snd_kcontrol_new amp_kctl =
-			HDA_CODEC_VOLUME("Headphone Amp Playback Volume",
-					 0x10, 0, HDA_OUTPUT);
+		    HDA_CODEC_VOLUME("Headphone Amp Playback Volume",
+				     0x10, 0, HDA_OUTPUT);
 		if (!snd_hda_gen_add_kctl(&spec->gen, NULL, &amp_kctl)) {
 			err = -ENOMEM;
 			goto error;
@@ -113,8 +751,10 @@ static const struct hda_device_id snd_hda_id_cmedia[] = {
 	HDA_CODEC_ENTRY(0x13f68888, "CMI8888", patch_cmi8888),
 	HDA_CODEC_ENTRY(0x13f69880, "CMI9880", patch_cmi9880),
 	HDA_CODEC_ENTRY(0x434d4980, "CMI9880", patch_cmi9880),
-	{} /* terminator */
+	HDA_CODEC_ENTRY(0x13f69825, "CM9825", patch_cm9825),
+	{}			/* terminator */
 };
+
 MODULE_DEVICE_TABLE(hdaudio, snd_hda_id_cmedia);
 
 MODULE_LICENSE("GPL");
-- 
2.34.1


