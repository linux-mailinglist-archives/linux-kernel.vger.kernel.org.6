Return-Path: <linux-kernel+bounces-198938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E32B08D7F79
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726C51F256EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E0783CB2;
	Mon,  3 Jun 2024 09:53:16 +0000 (UTC)
Received: from mail-m127109.qiye.163.com (mail-m127109.qiye.163.com [115.236.127.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6C763E4;
	Mon,  3 Jun 2024 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408395; cv=none; b=MZ6e5GfFfbP14mklXt/MUtB39MLjJ9GwRe0MswIUgmIXNptgCt7WV1G00uxZsJyD4USBYJqIuu0hWOzerW+da1lnLRABwvrCa4/vaLq/bKjvJ+WO5LY5GVsvbF1c+SHqEEj30ulwvabFK0HjlMx+tXWdSQKjSJNW/qJP5VnwIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408395; c=relaxed/simple;
	bh=6hvv4jqC8Za+2zbPosS6Bl+fq1y+ZlgTdZmqjdd4nGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c0ftNJ7v18a3SA2htMpKXAl6rjl/1eyCg+f4E7gH+85DOheQ2J1D4zPDMtVaRCEitUV1CFE/6FCOgKY4ArwbmiJzgsRW3cBGZb0ZyaQ93GKAHMmrjA3IgGqDwnDJeB/jd4pvCyFAErSpcXobi3FN1eSB4zg51v1GIAgOiM78XSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com; spf=pass smtp.mailfrom=senarytech.com; arc=none smtp.client-ip=115.236.127.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from book-ThinkStation-P328.. (unknown [61.183.143.78])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 46DE19005D5;
	Mon,  3 Jun 2024 17:34:36 +0800 (CST)
From: bo liu <bo.liu@senarytech.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Subject: [PATCH] ALSA: hda/senarytech: add senarytech codec support
Date: Mon,  3 Jun 2024 17:34:29 +0800
Message-Id: <20240603093429.25511-1-bo.liu@senarytech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGk5IVkgYQk0fHhodTB9IHVUTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpDSFVKT0hVTENZV1kWGg8SFR0UWUFZT0tIVUpNQ0xMT1VKS0tVSkJLS1kG
X-HM-Tid: 0a8fdd735d6f03a9kunm46de19005d5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6MQw4KTNJODg9OTkhCyk4
	CxVPCyxVSlVKTEpMT0tMSUxMS0tKVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBSkpOTks3Bg++

Add initial Senarytech codec support for SN6180. Note that this hda
patch relies on the configuration default registers to be set correctly
(normally by BIOS/firmware) in order for it to set up pin widgets
properly.

Signed-off-by: bo liu <bo.liu@senarytech.com>
---
 MAINTAINERS                      |   6 +
 sound/hda/hdac_device.c          |   1 +
 sound/pci/hda/Kconfig            |  11 ++
 sound/pci/hda/Makefile           |   2 +
 sound/pci/hda/patch_senarytech.c | 263 +++++++++++++++++++++++++++++++
 5 files changed, 283 insertions(+)
 create mode 100644 sound/pci/hda/patch_senarytech.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a6a011792167..82ea8c8f74c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24949,6 +24949,12 @@ F:	mm/zpool.c
 F:	mm/zswap.c
 F:	tools/testing/selftests/cgroup/test_zswap.c
 
+SENARYTECH AUDIO CODEC DRIVER
+M:	bo liu <bo.liu@senarytech.com>
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
+F:	sound/pci/hda/patch_senarytech.c
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 068c16e52dff..3fbb9793dcfc 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -665,6 +665,7 @@ static const struct hda_vendor_id hda_vendor_ids[] = {
 	{ 0x19e5, "Huawei" },
 	{ 0x1aec, "Wolfson Microelectronics" },
 	{ 0x1af4, "QEMU" },
+	{ 0x1fa8, "Senarytech" },
 	{ 0x434d, "C-Media" },
 	{ 0x8086, "Intel" },
 	{ 0x8384, "SigmaTel" },
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 0da625533afc..1252632f0ffa 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -292,6 +292,17 @@ config SND_HDA_CODEC_CONEXANT
 comment "Set to Y if you want auto-loading the codec driver"
 	depends on SND_HDA=y && SND_HDA_CODEC_CONEXANT=m
 
+config SND_HDA_CODEC_SENARYTECH
+	tristate "Build Senarytech HD-audio codec support"
+	select SND_HDA_GENERIC
+	select SND_HDA_GENERIC_LEDS
+	help
+	  Say Y or M here to include Senarytech HD-audio codec support in
+	  snd-hda-intel driver, such as SN6186.
+
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA=y && SND_HDA_CODEC_SENARYTECH=m
+
 config SND_HDA_CODEC_CA0110
 	tristate "Build Creative CA0110-IBG codec support"
 	select SND_HDA_GENERIC
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 058ca0a289e4..7ac2105c2e00 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -24,6 +24,7 @@ snd-hda-codec-cs8409-y :=	patch_cs8409.o patch_cs8409-tables.o
 snd-hda-codec-ca0110-y :=	patch_ca0110.o
 snd-hda-codec-ca0132-y :=	patch_ca0132.o
 snd-hda-codec-conexant-y :=	patch_conexant.o
+snd-hda-codec-senarytech-objs :=patch_senarytech.o
 snd-hda-codec-via-y :=		patch_via.o
 snd-hda-codec-hdmi-y :=		patch_hdmi.o hda_eld.o
 
@@ -55,6 +56,7 @@ obj-$(CONFIG_SND_HDA_CODEC_CS8409) += snd-hda-codec-cs8409.o
 obj-$(CONFIG_SND_HDA_CODEC_CA0110) += snd-hda-codec-ca0110.o
 obj-$(CONFIG_SND_HDA_CODEC_CA0132) += snd-hda-codec-ca0132.o
 obj-$(CONFIG_SND_HDA_CODEC_CONEXANT) += snd-hda-codec-conexant.o
+obj-$(CONFIG_SND_HDA_CODEC_SENARYTECH) += snd-hda-codec-senarytech.o
 obj-$(CONFIG_SND_HDA_CODEC_VIA) += snd-hda-codec-via.o
 obj-$(CONFIG_SND_HDA_CODEC_HDMI) += snd-hda-codec-hdmi.o
 
diff --git a/sound/pci/hda/patch_senarytech.c b/sound/pci/hda/patch_senarytech.c
new file mode 100644
index 000000000000..21756f1e946b
--- /dev/null
+++ b/sound/pci/hda/patch_senarytech.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HD audio interface patch for Senary HDA audio codec
+ *
+ * Initially based on sound/pci/hda/patch_conexant.c
+ */
+
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+
+#include <sound/hda_codec.h>
+#include "hda_local.h"
+#include "hda_auto_parser.h"
+#include "hda_beep.h"
+#include "hda_jack.h"
+#include "hda_generic.h"
+
+struct senary_spec {
+	struct hda_gen_spec gen;
+
+	/* extra EAPD pins */
+	unsigned int num_eapds;
+	hda_nid_t eapds[4];
+	bool dynamic_eapd;
+	hda_nid_t mute_led_eapd;
+
+	unsigned int parse_flags; /* flag for snd_hda_parse_pin_defcfg() */
+
+	int mute_led_polarity;
+	unsigned int gpio_led;
+	unsigned int gpio_mute_led_mask;
+	unsigned int gpio_mic_led_mask;
+};
+
+#ifdef CONFIG_SND_HDA_INPUT_BEEP
+/* additional beep mixers; private_value will be overwritten */
+static const struct snd_kcontrol_new senary_beep_mixer[] = {
+	HDA_CODEC_VOLUME_MONO("Beep Playback Volume", 0, 1, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_BEEP_MONO("Beep Playback Switch", 0, 1, 0, HDA_OUTPUT),
+};
+
+static int set_beep_amp(struct senary_spec *spec, hda_nid_t nid,
+			int idx, int dir)
+{
+	struct snd_kcontrol_new *knew;
+	unsigned int beep_amp = HDA_COMPOSE_AMP_VAL(nid, 1, idx, dir);
+	int i;
+
+	spec->gen.beep_nid = nid;
+	for (i = 0; i < ARRAY_SIZE(senary_beep_mixer); i++) {
+		knew = snd_hda_gen_add_kctl(&spec->gen, NULL,
+					    &senary_beep_mixer[i]);
+		if (!knew)
+			return -ENOMEM;
+		knew->private_value = beep_amp;
+	}
+	return 0;
+}
+
+static int senary_auto_parse_beep(struct hda_codec *codec)
+{
+	struct senary_spec *spec = codec->spec;
+	hda_nid_t nid;
+
+	for_each_hda_codec_node(nid, codec)
+		if ((get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_BEEP) &&
+			(get_wcaps(codec, nid) & (AC_WCAP_OUT_AMP | AC_WCAP_AMP_OVRD)))
+			return set_beep_amp(spec, nid, 0, HDA_OUTPUT);
+	return 0;
+}
+#else
+#define senary_auto_parse_beep()	0
+#endif
+
+/* parse EAPDs */
+static void senary_auto_parse_eapd(struct hda_codec *codec)
+{
+	struct senary_spec *spec = codec->spec;
+	hda_nid_t nid;
+
+	for_each_hda_codec_node(nid, codec) {
+		if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_PIN)
+			continue;
+		if (!(snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_EAPD))
+			continue;
+		spec->eapds[spec->num_eapds++] = nid;
+		if (spec->num_eapds >= ARRAY_SIZE(spec->eapds))
+			break;
+	}
+
+	/* NOTE: below is a wild guess; if we have more than two EAPDs,
+	 * it's a new chip, where EAPDs are supposed to be associated to
+	 * pins, and we can control EAPD per pin.
+	 * OTOH, if only one or two EAPDs are found, it's an old chip,
+	 * thus it might control over all pins.
+	 */
+	if (spec->num_eapds > 2)
+		spec->dynamic_eapd = 1;
+}
+
+static void senary_auto_turn_eapd(struct hda_codec *codec, int num_pins,
+			      const hda_nid_t *pins, bool on)
+{
+	int i;
+
+	for (i = 0; i < num_pins; i++) {
+		if (snd_hda_query_pin_caps(codec, pins[i]) & AC_PINCAP_EAPD)
+			snd_hda_codec_write(codec, pins[i], 0,
+					    AC_VERB_SET_EAPD_BTLENABLE,
+					    on ? 0x02 : 0);
+	}
+}
+
+/* turn on/off EAPD according to Master switch */
+static void senary_auto_vmaster_hook(void *private_data, int enabled)
+{
+	struct hda_codec *codec = private_data;
+	struct senary_spec *spec = codec->spec;
+
+	senary_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, enabled);
+}
+
+static void senary_init_gpio_led(struct hda_codec *codec)
+{
+	struct senary_spec *spec = codec->spec;
+	unsigned int mask = spec->gpio_mute_led_mask | spec->gpio_mic_led_mask;
+
+	if (mask) {
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
+				    mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION,
+				    mask);
+		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
+				    spec->gpio_led);
+	}
+}
+
+static int senary_auto_init(struct hda_codec *codec)
+{
+	struct senary_spec *spec = codec->spec;
+
+	snd_hda_gen_init(codec);
+	if (!spec->dynamic_eapd)
+		senary_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, true);
+
+	senary_init_gpio_led(codec);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
+
+	return 0;
+}
+
+static void senary_auto_shutdown(struct hda_codec *codec)
+{
+	struct senary_spec *spec = codec->spec;
+
+	/* Turn the problematic codec into D3 to avoid spurious noises
+	 * from the internal speaker during (and after) reboot
+	 */
+	senary_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);
+}
+
+static void senary_auto_free(struct hda_codec *codec)
+{
+	senary_auto_shutdown(codec);
+	snd_hda_gen_free(codec);
+}
+
+#ifdef CONFIG_PM
+static int senary_auto_suspend(struct hda_codec *codec)
+{
+	senary_auto_shutdown(codec);
+	return 0;
+}
+#endif
+
+static const struct hda_codec_ops senary_auto_patch_ops = {
+	.build_controls = snd_hda_gen_build_controls,
+	.build_pcms = snd_hda_gen_build_pcms,
+	.init = senary_auto_init,
+	.free = senary_auto_free,
+	.unsol_event = snd_hda_jack_unsol_event,
+#ifdef CONFIG_PM
+	.suspend = senary_auto_suspend,
+	.check_power_status = snd_hda_gen_check_power_status,
+#endif
+};
+
+static int patch_senary_auto(struct hda_codec *codec)
+{
+	struct senary_spec *spec;
+	int err;
+
+	codec_info(codec, "%s: BIOS auto-probing.\n", codec->core.chip_name);
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+	snd_hda_gen_spec_init(&spec->gen);
+	codec->spec = spec;
+	codec->patch_ops = senary_auto_patch_ops;
+
+	senary_auto_parse_eapd(codec);
+	spec->gen.own_eapd_ctl = 1;
+
+	if (!spec->gen.vmaster_mute.hook && spec->dynamic_eapd)
+		spec->gen.vmaster_mute.hook = senary_auto_vmaster_hook;
+
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
+	err = snd_hda_parse_pin_defcfg(codec, &spec->gen.autocfg, NULL,
+				       spec->parse_flags);
+	if (err < 0)
+		goto error;
+
+	err = senary_auto_parse_beep(codec);
+	if (err < 0)
+		goto error;
+
+	err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
+	if (err < 0)
+		goto error;
+
+	/* Some laptops with Senary chips show stalls in S3 resume,
+	 * which falls into the single-cmd mode.
+	 * Better to make reset, then.
+	 */
+	if (!codec->bus->core.sync_write) {
+		codec_info(codec,
+			   "Enable sync_write for stable communication\n");
+		codec->bus->core.sync_write = 1;
+		codec->bus->allow_bus_reset = 1;
+	}
+
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
+	return 0;
+
+ error:
+	senary_auto_free(codec);
+	return err;
+}
+
+/*
+ */
+
+static const struct hda_device_id snd_hda_id_senary[] = {
+	HDA_CODEC_ENTRY(0x1fa86186, "SN6186", patch_senary_auto),
+	{} /* terminator */
+};
+MODULE_DEVICE_TABLE(hdaudio, snd_hda_id_senary);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Senarytech HD-audio codec");
+
+static struct hda_codec_driver senary_driver = {
+	.id = snd_hda_id_senary,
+};
+
+module_hda_codec_driver(senary_driver);
-- 
2.34.1


