Return-Path: <linux-kernel+bounces-217875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A6990B573
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DB61F22CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38613E05A;
	Mon, 17 Jun 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HkVcsvYw"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77713DDD4;
	Mon, 17 Jun 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639019; cv=none; b=q+aFHF7nLKKaX0SCZYw1X4LH/G2vQYGBk57JKVyFzvqI8KyHUnH9ANG6s82Ea4NyJbM5+KUEafJHvKenPzzC8I6Nmvq5VVcWo5LmPrfFSAaR6yNPWHtz4LEvLqwi8GOM8BixQ1SxSrMYdIoHnWj50XvBinLTPWgwqTs//DSaFbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639019; c=relaxed/simple;
	bh=AF7oJy0aZTCp3wlzMVsWa6hAadJ85VbNoWfPEaIsx98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCB2T1xsPPKT4QvJjSlBWMg9zsHkZ8k3OPTZN+gai2lZp+0AlgWcNgLPoP5iGNuHStIre+ffe3ukssLROAmSSUVb8vae79vVGkS59rzvWai4WIL1I4k8nKOI95GQKRjSDMX3nHpg0IAygdjKHPiZVCSMa4LnXfNAF2mo/wd1KSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HkVcsvYw; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HFYSto018866;
	Mon, 17 Jun 2024 10:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=AbrUVgHW0M6XqFMkM9GyFEaeZh4wuvWncgNTUKIvFmM=; b=
	HkVcsvYwb6C2kVwhGDGFB9+IaFJZiCJVb/R0dpeE1IsGC1N0eGd+BtxNdSOAAvwi
	hzEuwwqMgpSWrp9twhx3D1RKuyNezAXVYUZj3jpx06Pwk2HvNRtEc9eVaxOUw1BI
	ITHPFeiPgQwC0O8l/cQo+XXHS6Zy+7vqfAe5zXnUY0ayD0by5D9pf3uMBpqCLoy8
	evbRuItwNuDDZJSMU1+2eSObIDf/4rID+Yc/SYETedavp8l4w/97WHpSh7LFcR2T
	i9nsIvJB+rOkFeY8rtRXe0SahRReHWRmlkKRqYJJw1dbHNL8+2L2oz1Z3FzwNWbY
	84tF5mBSzq8OA1HN6+TtUQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ys8by1vv8-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 10:42:59 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 16:42:56 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 17 Jun 2024 16:42:56 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.31])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0C1C182024D;
	Mon, 17 Jun 2024 15:42:56 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 3/4] ALSA: hda: hda_component: Move codec field into the parent
Date: Mon, 17 Jun 2024 16:41:04 +0100
Message-ID: <20240617154105.108635-4-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617154105.108635-1-simont@opensource.cirrus.com>
References: <20240617154105.108635-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sQoPquq4dJYzD_1O8xc3Gtgx4_QLCGuk
X-Proofpoint-GUID: sQoPquq4dJYzD_1O8xc3Gtgx4_QLCGuk
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
index 32c9d95150ba..9c45d5953c80 100644
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
index abe415795d90..53dee0286ee1 100644
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
index 8c11c8b37799..1a9950b76866 100644
--- a/sound/pci/hda/hda_component.c
+++ b/sound/pci/hda/hda_component.c
@@ -134,12 +134,9 @@ static int hda_comp_match_dev_name(struct device *dev, void *data)
 int hda_component_manager_bind(struct hda_codec *cdc,
 			       struct hda_component_parent *parent)
 {
-	int i;
-
 	/* Init shared and component specific data */
 	memset(parent, 0, sizeof(*parent));
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
index 2794acd4c9ab..7fab19f85968 100644
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


