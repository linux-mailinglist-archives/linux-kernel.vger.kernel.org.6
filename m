Return-Path: <linux-kernel+bounces-197056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1228D658C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA531C20FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063EE176AA4;
	Fri, 31 May 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="b7WXap1B"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6B13FD69;
	Fri, 31 May 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168532; cv=none; b=gQ+UY1Bq5jLX8DCKgfsri9ssv6PQhrdBgFARFMVZlea6mVNTdCR0jJJvrpUVGitmHNnCMMCpiyioPTTdSKP7CiAoIXjtE8Z5+ChMVr3u7GHn18cTzkSIzxcRloIpCy0ufDlIisQqEO5mOK5KEfbzlD9UAkd03qXd+mqAknGAC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168532; c=relaxed/simple;
	bh=gOtGnElFSq5mT3hd0S/cbu75iZAqrJW1dFYWO7O4ta4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQNxC2rEe3XMrwjP3lYNGhDGueAOIQ6HovIdyjUJf5Z4B91evaf2bW++pVLGTmjro/02ePqy+RwVY1lAMvL+8ZDW3KRvX0ZGwqp5x9J0ccfdyCkP7GRqZDRxxElMXPBjqreEjBCvHRNi/bsIBj3Dwm3dA6ZuyjTHB8UGf812Kik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=b7WXap1B; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VB0WSv017940;
	Fri, 31 May 2024 10:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=GNGJ3diEt0SE1XVgokF/gVnc114gsHF6JrOcJW43PNk=; b=
	b7WXap1BpCUYU8eiPlAU9E1Yl2p8dyvl+qatsknPD5hWP/VNI0Hl+cV1wNibxtNw
	VLZUU2pD2qnvdwsIgJNSTsaaeGkmjgVoke4unVsOx7E5H2EsqAL0IFijg4AJuBiv
	7zo4Iu9Yr05+IgQs2SNr6qOWNE/ZhjUQZGx6F2dv0zFcsPSOMD9AlxtlGMxBliRG
	AXvCycsmoJHeF2OMAqaGAhc1TB/xNk/TRTiCCTuijO2OlLCxWUwNBHm6wWOpLPVq
	QjLiSQPpzYbY2/j0HKzuEJf8UqEH1W67sMs1EOGr9puT2IMVkN9PHI/SfC9m1gA1
	h1Lmbb5uYxqnLUwDrVSkYQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ybcdhe0a3-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 10:15:14 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 16:15:12 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 31 May 2024 16:15:12 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.72])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BE1E0820244;
	Fri, 31 May 2024 15:15:11 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <kailang@realtek.com>,
        Simon Trimmer
	<simont@opensource.cirrus.com>
Subject: [PATCH 6/7] ALSA: hda: hda_component: Move codec field into the parent
Date: Fri, 31 May 2024 16:14:08 +0100
Message-ID: <20240531151409.80284-7-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531151409.80284-1-simont@opensource.cirrus.com>
References: <20240531151409.80284-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NgQZcOGq6HRXCk7x9H6a8emF0ssgWi2V
X-Proofpoint-ORIG-GUID: NgQZcOGq6HRXCk7x9H6a8emF0ssgWi2V
X-Proofpoint-Spam-Reason: safe

There is one codec shared across all of the bound HDA components and a
copy is usually stashed in the amp driver so it doesn't need to be in
every hda_component.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c     | 7 ++++---
 sound/pci/hda/cs35l56_hda.c     | 2 +-
 sound/pci/hda/hda_component.c   | 5 +----
 sound/pci/hda/hda_component.h   | 2 +-
 sound/pci/hda/tas2781_hda_i2c.c | 2 +-
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index ceba4f2c85f1..ee9f83b737de 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1436,10 +1436,11 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	mutex_lock(&cs35l41->fw_mutex);
 
 	comp->dev = dev;
+	cs35l41->codec = parent->codec;
 	if (!cs35l41->acpi_subsystem_id)
 		cs35l41->acpi_subsystem_id = kasprintf(GFP_KERNEL, "%.8x",
-						       comp->codec->core.subsystem_id);
-	cs35l41->codec = comp->codec;
+						       cs35l41->codec->core.subsystem_id);
+
 	strscpy(comp->name, dev_name(dev), sizeof(comp->name));
 
 	cs35l41->firmware_type = HDA_CS_DSP_FW_SPK_PROT;
@@ -1470,7 +1471,7 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	mutex_unlock(&cs35l41->fw_mutex);
 
 	sleep_flags = lock_system_sleep();
-	if (!device_link_add(&comp->codec->core.dev, cs35l41->dev, DL_FLAG_STATELESS))
+	if (!device_link_add(&cs35l41->codec->core.dev, cs35l41->dev, DL_FLAG_STATELESS))
 		dev_warn(dev, "Unable to create device link\n");
 	unlock_system_sleep(sleep_flags);
 
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index df4498c77171..cc4aa90db1d1 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -697,7 +697,7 @@ static int cs35l56_hda_bind(struct device *dev, struct device *master, void *mas
 		return -EBUSY;
 
 	comp->dev = dev;
-	cs35l56->codec = comp->codec;
+	cs35l56->codec = parent->codec;
 	strscpy(comp->name, dev_name(dev), sizeof(comp->name));
 	comp->playback_hook = cs35l56_hda_playback_hook;
 
diff --git a/sound/pci/hda/hda_component.c b/sound/pci/hda/hda_component.c
index da49937a938b..84add31408f7 100644
--- a/sound/pci/hda/hda_component.c
+++ b/sound/pci/hda/hda_component.c
@@ -134,12 +134,9 @@ static int hda_comp_match_dev_name(struct device *dev, void *data)
 int hda_component_manager_bind(struct hda_codec *cdc,
 			       struct hda_component_parent *parent)
 {
-	int i;
-
 	/* Init shared and component specific data */
 	memset(parent, 0, sizeof(parent));
-	for (i = 0; i < ARRAY_SIZE(parent->comps); i++)
-		parent->comps[i].codec = cdc;
+	parent->codec = cdc;
 
 	return component_bind_all(hda_codec_dev(cdc), parent);
 }
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index e547e1f1e674..dd4dabeae9ee 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -19,7 +19,6 @@
 struct hda_component {
 	struct device *dev;
 	char name[HDA_MAX_NAME_SIZE];
-	struct hda_codec *codec;
 	struct acpi_device *adev;
 	bool acpi_notifications_supported;
 	void (*acpi_notify)(acpi_handle handle, u32 event, struct device *dev);
@@ -29,6 +28,7 @@ struct hda_component {
 };
 
 struct hda_component_parent {
+	struct hda_codec *codec;
 	struct hda_component comps[HDA_MAX_COMPONENTS];
 };
 
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index c6c1e8e81972..d7af4fd10714 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -719,7 +719,7 @@ static int tas2781_hda_bind(struct device *dev, struct device *master,
 	if (comp->dev)
 		return -EBUSY;
 
-	codec = comp->codec;
+	codec = parent->codec;
 	subid = codec->core.subsystem_id >> 16;
 
 	switch (subid) {
-- 
2.34.1


