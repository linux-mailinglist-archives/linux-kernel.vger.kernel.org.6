Return-Path: <linux-kernel+bounces-271429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 178BA944E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4FC1F24912
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B30D1A4F21;
	Thu,  1 Aug 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZDzjaonC"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296D1E4AB;
	Thu,  1 Aug 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522835; cv=none; b=gPNHbAxQSDrpqRrkpecnzHXCvPCBL1jqpJhdI0KTiUYfMwIbeoYA6o5tEqAglVvyc6PVuLUfBJUd2m+QMjSw4M0cJZsT89RjwrkPe8ovSSeSqrcUqh9jBRTBqyjxEj5P3etShhUQwU12Oq1smKV7JbSDrE8PDba1Nc/paiHylHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522835; c=relaxed/simple;
	bh=qDtxOqPLsQcOJe8TqfVlY5wm51p2NXX3ZCiOi/YHnz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UOlxUS8GvP7dEVh6aswsAahOIGDWoAGZfLbCV8NAyx8qUqUGaiz9ExGajEvvX33Q3OAdcEgESBnJm8vj00eu4bsjGYa68DGNyisO9eaNRBqt0x/wSjziVJADHxumZ1FZK5G/poZZ4Voy+m6UIR9Bw8Y2TYUHFbIqPkOPM30SNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZDzjaonC; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471B7jM2018617;
	Thu, 1 Aug 2024 09:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=t1VkGL6mPdtrtxmC
	EAca93+GS4gd18fjPVS4TxXhBk4=; b=ZDzjaonCljViJGvKSqcZZ+H/Sw7lhPhn
	tEIkGh7doaLrieZtunORafrqZk2lOBwUPcV7vdbfuxxUnDLh5PVTByIBg6jdu2Vn
	yJu4Ov4Mmm34aiNSXrJgnorMlC/8PupEqKFdCf5WDGJdQcpYmN4dQu1ftnIuM7PB
	bRSy85EHftukZoM9NHV5AVrZvwyIjF09V6u0bPpiRneANrC6hcS0jNiXJlIFXFDS
	x8k7CPbkI8ejYw1+ggZwvoW7f4MTm4EU7QN90J2j9aQv+4+jp1gZswuBGQ8rgpt7
	gfUHPllOhzuLBA8Qzvf2zZt+wb/qj830xyz8Kre6pq6xcfXOANmEVw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40qjw9adeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 09:31:45 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 Aug 2024
 15:31:42 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 1 Aug 2024 15:31:42 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 92C2A820244;
	Thu,  1 Aug 2024 14:31:42 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH v3] ALSA: hda: cs35l56: Stop creating ALSA controls for firmware coefficients
Date: Thu, 1 Aug 2024 14:31:39 +0000
Message-ID: <20240801143139.34549-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0nB_L6BAJxgoU621T3i4GeheG_Y26O9g
X-Proofpoint-ORIG-GUID: 0nB_L6BAJxgoU621T3i4GeheG_Y26O9g
X-Proofpoint-Spam-Reason: safe

A number of laptops have gone to market with old firmware versions that
export controls that have since been hidden, but we can't just install a
newer firmware because the firmware for each product is customized and
qualified by the OEM. The issue is that alsactl save and restore has no
idea what controls are good to persist which can lead to
misconfiguration.

There is no reason that the UCM or user should need to interact with any
of the ALSA controls for the firmware coefficients so they can be
removed entirely, this also simplifies the driver.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
Changes in v3:
- Remove ability to add firmware coefficients as ALSA controls
  entirely

Changes in v2:
- v1 was accidentally the backport version for older kernels instead of
  the one for v6.11

 sound/pci/hda/cs35l56_hda.c | 38 +------------------------------------
 sound/pci/hda/cs35l56_hda.h |  1 -
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 96d3f13c5abf..31cc92bac89a 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -559,18 +559,6 @@ static void cs35l56_hda_release_firmware_files(const struct firmware *wmfw_firmw
 	kfree(coeff_filename);
 }
 
-static void cs35l56_hda_create_dsp_controls_work(struct work_struct *work)
-{
-	struct cs35l56_hda *cs35l56 = container_of(work, struct cs35l56_hda, control_work);
-	struct hda_cs_dsp_ctl_info info;
-
-	info.device_name = cs35l56->amp_name;
-	info.fw_type = HDA_CS_DSP_FW_MISC;
-	info.card = cs35l56->codec->card;
-
-	hda_cs_dsp_add_controls(&cs35l56->cs_dsp, &info);
-}
-
 static void cs35l56_hda_apply_calibration(struct cs35l56_hda *cs35l56)
 {
 	int ret;
@@ -595,26 +583,15 @@ static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	char *wmfw_filename = NULL;
 	unsigned int preloaded_fw_ver;
 	bool firmware_missing;
-	bool add_dsp_controls_required = false;
 	int ret;
 
-	/*
-	 * control_work must be flushed before proceeding, but we can't do that
-	 * here as it would create a deadlock on controls_rwsem so it must be
-	 * performed before queuing dsp_work.
-	 */
-	WARN_ON_ONCE(work_busy(&cs35l56->control_work));
-
 	/*
 	 * Prepare for a new DSP power-up. If the DSP has had firmware
 	 * downloaded previously then it needs to be powered down so that it
-	 * can be updated and if hadn't been patched before then the controls
-	 * will need to be added once firmware download succeeds.
+	 * can be updated.
 	 */
 	if (cs35l56->base.fw_patched)
 		cs_dsp_power_down(&cs35l56->cs_dsp);
-	else
-		add_dsp_controls_required = true;
 
 	cs35l56->base.fw_patched = false;
 
@@ -698,15 +675,6 @@ static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 			  CS35L56_FIRMWARE_MISSING);
 	cs35l56->base.fw_patched = true;
 
-	/*
-	 * Adding controls is deferred to prevent a lock inversion - ALSA takes
-	 * the controls_rwsem when adding a control, the get() / put()
-	 * functions of a control are called holding controls_rwsem and those
-	 * that depend on running firmware wait for dsp_work() to complete.
-	 */
-	if (add_dsp_controls_required)
-		queue_work(system_long_wq, &cs35l56->control_work);
-
 	ret = cs_dsp_run(&cs35l56->cs_dsp);
 	if (ret)
 		dev_dbg(cs35l56->base.dev, "%s: cs_dsp_run ret %d\n", __func__, ret);
@@ -753,7 +721,6 @@ static int cs35l56_hda_bind(struct device *dev, struct device *master, void *mas
 	strscpy(comp->name, dev_name(dev), sizeof(comp->name));
 	comp->playback_hook = cs35l56_hda_playback_hook;
 
-	flush_work(&cs35l56->control_work);
 	queue_work(system_long_wq, &cs35l56->dsp_work);
 
 	cs35l56_hda_create_controls(cs35l56);
@@ -775,7 +742,6 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	struct hda_component *comp;
 
 	cancel_work_sync(&cs35l56->dsp_work);
-	cancel_work_sync(&cs35l56->control_work);
 
 	cs35l56_hda_remove_controls(cs35l56);
 
@@ -806,7 +772,6 @@ static int cs35l56_hda_system_suspend(struct device *dev)
 	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
 
 	cs35l56_hda_wait_dsp_ready(cs35l56);
-	flush_work(&cs35l56->control_work);
 
 	if (cs35l56->playing)
 		cs35l56_hda_pause(cs35l56);
@@ -1026,7 +991,6 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 	dev_set_drvdata(cs35l56->base.dev, cs35l56);
 
 	INIT_WORK(&cs35l56->dsp_work, cs35l56_hda_dsp_work);
-	INIT_WORK(&cs35l56->control_work, cs35l56_hda_create_dsp_controls_work);
 
 	ret = cs35l56_hda_read_acpi(cs35l56, hid, id);
 	if (ret)
diff --git a/sound/pci/hda/cs35l56_hda.h b/sound/pci/hda/cs35l56_hda.h
index c40d159507c2..38d94fb213a5 100644
--- a/sound/pci/hda/cs35l56_hda.h
+++ b/sound/pci/hda/cs35l56_hda.h
@@ -23,7 +23,6 @@ struct cs35l56_hda {
 	struct cs35l56_base base;
 	struct hda_codec *codec;
 	struct work_struct dsp_work;
-	struct work_struct control_work;
 
 	int index;
 	const char *system_name;
-- 
2.43.0


