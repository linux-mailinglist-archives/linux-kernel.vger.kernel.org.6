Return-Path: <linux-kernel+bounces-219428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C314990D133
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B176E1C23ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930D19EEAC;
	Tue, 18 Jun 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HbsjD6Q+"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085411581F6;
	Tue, 18 Jun 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716041; cv=none; b=m/0Z3rY67Y9Rmfpfv4izlC2Cb7/kAhuSuypwpXcv9NGaQCrK2nS5dXghJ8qQM/P5Id+uyEZHgjr1nxnpwOTSjKgIVki6BN+efrhpe/VBcexYagXnilh3ySMIkL2qe/9FRWZsJrQb1u42hqlcE8DoWfQdxihMFnj+vI85JggJCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716041; c=relaxed/simple;
	bh=owgvG94ctLRlxd224fF3qsnsskhj3HpX39bUjrr4YHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LnfD1tcCaAlhBlqExqvSN0OM+QRU89OSUroMEN/QLjUseBXM3rxDJfwlPnbSU1pQBxjBA8x+DI9QUeCweqUim6RRZbRIZ1CtGbvlaZaHs66MuN9vJ5WeL0ZFs5PoCvlfuBhs7MthulrMIDJkaIngxAhdIsPCNunHr7GWGuPU97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HbsjD6Q+; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I5c7Pt027173;
	Tue, 18 Jun 2024 08:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=upCJVoWEOu4dqc4l
	0kBAqZ+Zb/2+gNN0VMkcDlM9czc=; b=HbsjD6Q+f3v/kZVXtSxZ2FPmHBgrj99a
	xoGMU7NmLExLqR8jpnuArR8jjZGrwB4mdQlNAUcH5cjarlk7ESuzzOtdESUsl3xH
	kOuiVnBA8DySL63YHKnQDsqyOGDaA+Bj4QfKLLRkfA5NfRRQnhg3+p1a9qs4dpew
	VJXQLVSDgR1IHLQYldfYbkoDa5wVmsB6DBKgRb4qSKPs2mTrpsAI2y/81v7He3a1
	+A1xnkRA2e0plUDvPhdRnzJQWrtkyrknVANIOjTrXc5PidJUHQ8q/HExr/liM0MJ
	mWz3VT5NPA2JPLGkGhsRTp3HobEtnVtxL7a42kX7VV5Ce1zbnAa/Ww==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ys7cju2ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 08:00:16 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 14:00:14 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 18 Jun 2024 14:00:14 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.31])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A49D1820248;
	Tue, 18 Jun 2024 13:00:14 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH v2] ALSA: hda: cs35l56: Perform firmware download in the background
Date: Tue, 18 Jun 2024 14:00:11 +0100
Message-ID: <20240618130011.62860-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qz6luDEzsI5-lKGjLTQB3bVGnrLVfpNA
X-Proofpoint-ORIG-GUID: qz6luDEzsI5-lKGjLTQB3bVGnrLVfpNA
X-Proofpoint-Spam-Reason: safe

It is possible that during system boot when there multiple devices
attempting simultaneous initialization on a slow control bus the
download of firmware and tuning data may take a user perceivable amount
of time (a slow I2C bus with 4 amps this work could take over 2
seconds).

Adopt a pattern used in the ASoC driver and perform this activity in a
background thread so that interactive performance is not impaired. The
system_long_wq is a parallel workqueue and driver instances will perform
their firmware downloads in parallel to make best use of available bus
bandwidth.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 90 ++++++++++++++++++++++++++++++-------
 sound/pci/hda/cs35l56_hda.h |  3 ++
 2 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index cc4aa90db1d1..96d3f13c5abf 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -50,11 +50,19 @@ static const struct reg_sequence cs35l56_hda_dai_config[] = {
 
 };
 
+static void cs35l56_hda_wait_dsp_ready(struct cs35l56_hda *cs35l56)
+{
+	/* Wait for patching to complete */
+	flush_work(&cs35l56->dsp_work);
+}
+
 static void cs35l56_hda_play(struct cs35l56_hda *cs35l56)
 {
 	unsigned int val;
 	int ret;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	pm_runtime_get_sync(cs35l56->base.dev);
 	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_PLAY);
 	if (ret == 0) {
@@ -180,6 +188,8 @@ static int cs35l56_hda_mixer_get(struct snd_kcontrol *kcontrol,
 	unsigned int reg_val;
 	int i;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	regmap_read(cs35l56->base.regmap, kcontrol->private_value, &reg_val);
 	reg_val &= CS35L56_ASP_TXn_SRC_MASK;
 
@@ -203,6 +213,8 @@ static int cs35l56_hda_mixer_put(struct snd_kcontrol *kcontrol,
 	if (item >= CS35L56_NUM_INPUT_SRC)
 		return -EINVAL;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	regmap_update_bits_check(cs35l56->base.regmap, kcontrol->private_value,
 				 CS35L56_INPUT_MASK, cs35l56_tx_input_values[item],
 				 &changed);
@@ -227,6 +239,8 @@ static int cs35l56_hda_posture_get(struct snd_kcontrol *kcontrol,
 	unsigned int pos;
 	int ret;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	ret = regmap_read(cs35l56->base.regmap, CS35L56_MAIN_POSTURE_NUMBER, &pos);
 	if (ret)
 		return ret;
@@ -248,6 +262,8 @@ static int cs35l56_hda_posture_put(struct snd_kcontrol *kcontrol,
 	    (pos > CS35L56_MAIN_POSTURE_MAX))
 		return -EINVAL;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	ret = regmap_update_bits_check(cs35l56->base.regmap,
 				       CS35L56_MAIN_POSTURE_NUMBER,
 				       CS35L56_MAIN_POSTURE_MASK,
@@ -291,6 +307,8 @@ static int cs35l56_hda_vol_get(struct snd_kcontrol *kcontrol,
 	int vol;
 	int ret;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	ret = regmap_read(cs35l56->base.regmap, CS35L56_MAIN_RENDER_USER_VOLUME, &raw_vol);
 
 	if (ret)
@@ -323,6 +341,8 @@ static int cs35l56_hda_vol_put(struct snd_kcontrol *kcontrol,
 	raw_vol = (vol + CS35L56_MAIN_RENDER_USER_VOLUME_MIN) <<
 		  CS35L56_MAIN_RENDER_USER_VOLUME_SHIFT;
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+
 	ret = regmap_update_bits_check(cs35l56->base.regmap,
 				       CS35L56_MAIN_RENDER_USER_VOLUME,
 				       CS35L56_MAIN_RENDER_USER_VOLUME_MASK,
@@ -539,8 +559,9 @@ static void cs35l56_hda_release_firmware_files(const struct firmware *wmfw_firmw
 	kfree(coeff_filename);
 }
 
-static void cs35l56_hda_add_dsp_controls(struct cs35l56_hda *cs35l56)
+static void cs35l56_hda_create_dsp_controls_work(struct work_struct *work)
 {
+	struct cs35l56_hda *cs35l56 = container_of(work, struct cs35l56_hda, control_work);
 	struct hda_cs_dsp_ctl_info info;
 
 	info.device_name = cs35l56->amp_name;
@@ -566,7 +587,7 @@ static void cs35l56_hda_apply_calibration(struct cs35l56_hda *cs35l56)
 		dev_info(cs35l56->base.dev, "Calibration applied\n");
 }
 
-static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
+static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 {
 	const struct firmware *coeff_firmware = NULL;
 	const struct firmware *wmfw_firmware = NULL;
@@ -574,15 +595,34 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	char *wmfw_filename = NULL;
 	unsigned int preloaded_fw_ver;
 	bool firmware_missing;
-	int ret = 0;
+	bool add_dsp_controls_required = false;
+	int ret;
+
+	/*
+	 * control_work must be flushed before proceeding, but we can't do that
+	 * here as it would create a deadlock on controls_rwsem so it must be
+	 * performed before queuing dsp_work.
+	 */
+	WARN_ON_ONCE(work_busy(&cs35l56->control_work));
 
-	/* Prepare for a new DSP power-up */
+	/*
+	 * Prepare for a new DSP power-up. If the DSP has had firmware
+	 * downloaded previously then it needs to be powered down so that it
+	 * can be updated and if hadn't been patched before then the controls
+	 * will need to be added once firmware download succeeds.
+	 */
 	if (cs35l56->base.fw_patched)
 		cs_dsp_power_down(&cs35l56->cs_dsp);
+	else
+		add_dsp_controls_required = true;
 
 	cs35l56->base.fw_patched = false;
 
-	pm_runtime_get_sync(cs35l56->base.dev);
+	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+	if (ret < 0) {
+		dev_err(cs35l56->base.dev, "Failed to resume and get %d\n", ret);
+		return;
+	}
 
 	/*
 	 * The firmware can only be upgraded if it is currently running
@@ -606,7 +646,6 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	 */
 	if (!coeff_firmware && firmware_missing) {
 		dev_err(cs35l56->base.dev, ".bin file required but not found\n");
-		ret = -ENOENT;
 		goto err_fw_release;
 	}
 
@@ -659,6 +698,15 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 			  CS35L56_FIRMWARE_MISSING);
 	cs35l56->base.fw_patched = true;
 
+	/*
+	 * Adding controls is deferred to prevent a lock inversion - ALSA takes
+	 * the controls_rwsem when adding a control, the get() / put()
+	 * functions of a control are called holding controls_rwsem and those
+	 * that depend on running firmware wait for dsp_work() to complete.
+	 */
+	if (add_dsp_controls_required)
+		queue_work(system_long_wq, &cs35l56->control_work);
+
 	ret = cs_dsp_run(&cs35l56->cs_dsp);
 	if (ret)
 		dev_dbg(cs35l56->base.dev, "%s: cs_dsp_run ret %d\n", __func__, ret);
@@ -678,8 +726,13 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 					   coeff_firmware, coeff_filename);
 err_pm_put:
 	pm_runtime_put(cs35l56->base.dev);
+}
 
-	return ret;
+static void cs35l56_hda_dsp_work(struct work_struct *work)
+{
+	struct cs35l56_hda *cs35l56 = container_of(work, struct cs35l56_hda, dsp_work);
+
+	cs35l56_hda_fw_load(cs35l56);
 }
 
 static int cs35l56_hda_bind(struct device *dev, struct device *master, void *master_data)
@@ -687,7 +740,6 @@ static int cs35l56_hda_bind(struct device *dev, struct device *master, void *mas
 	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
 	struct hda_component_parent *parent = master_data;
 	struct hda_component *comp;
-	int ret;
 
 	comp = hda_component_from_index(parent, cs35l56->index);
 	if (!comp)
@@ -701,12 +753,10 @@ static int cs35l56_hda_bind(struct device *dev, struct device *master, void *mas
 	strscpy(comp->name, dev_name(dev), sizeof(comp->name));
 	comp->playback_hook = cs35l56_hda_playback_hook;
 
-	ret = cs35l56_hda_fw_load(cs35l56);
-	if (ret)
-		return ret;
+	flush_work(&cs35l56->control_work);
+	queue_work(system_long_wq, &cs35l56->dsp_work);
 
 	cs35l56_hda_create_controls(cs35l56);
-	cs35l56_hda_add_dsp_controls(cs35l56);
 
 #if IS_ENABLED(CONFIG_SND_DEBUG)
 	cs35l56->debugfs_root = debugfs_create_dir(dev_name(cs35l56->base.dev), sound_debugfs_root);
@@ -724,6 +774,9 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	struct hda_component_parent *parent = master_data;
 	struct hda_component *comp;
 
+	cancel_work_sync(&cs35l56->dsp_work);
+	cancel_work_sync(&cs35l56->control_work);
+
 	cs35l56_hda_remove_controls(cs35l56);
 
 #if IS_ENABLED(CONFIG_SND_DEBUG)
@@ -752,6 +805,9 @@ static int cs35l56_hda_system_suspend(struct device *dev)
 {
 	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
 
+	cs35l56_hda_wait_dsp_ready(cs35l56);
+	flush_work(&cs35l56->control_work);
+
 	if (cs35l56->playing)
 		cs35l56_hda_pause(cs35l56);
 
@@ -850,11 +906,8 @@ static int cs35l56_hda_system_resume(struct device *dev)
 
 	ret = cs35l56_is_fw_reload_needed(&cs35l56->base);
 	dev_dbg(cs35l56->base.dev, "fw_reload_needed: %d\n", ret);
-	if (ret > 0) {
-		ret = cs35l56_hda_fw_load(cs35l56);
-		if (ret)
-			return ret;
-	}
+	if (ret > 0)
+		queue_work(system_long_wq, &cs35l56->dsp_work);
 
 	if (cs35l56->playing)
 		cs35l56_hda_play(cs35l56);
@@ -972,6 +1025,9 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 	mutex_init(&cs35l56->base.irq_lock);
 	dev_set_drvdata(cs35l56->base.dev, cs35l56);
 
+	INIT_WORK(&cs35l56->dsp_work, cs35l56_hda_dsp_work);
+	INIT_WORK(&cs35l56->control_work, cs35l56_hda_create_dsp_controls_work);
+
 	ret = cs35l56_hda_read_acpi(cs35l56, hid, id);
 	if (ret)
 		goto err;
diff --git a/sound/pci/hda/cs35l56_hda.h b/sound/pci/hda/cs35l56_hda.h
index 464e4aa63cd1..c40d159507c2 100644
--- a/sound/pci/hda/cs35l56_hda.h
+++ b/sound/pci/hda/cs35l56_hda.h
@@ -14,6 +14,7 @@
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/firmware/cirrus/wmfw.h>
 #include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
 #include <sound/cs35l56.h>
 
 struct dentry;
@@ -21,6 +22,8 @@ struct dentry;
 struct cs35l56_hda {
 	struct cs35l56_base base;
 	struct hda_codec *codec;
+	struct work_struct dsp_work;
+	struct work_struct control_work;
 
 	int index;
 	const char *system_name;
-- 
2.34.1


