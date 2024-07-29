Return-Path: <linux-kernel+bounces-266078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0F793FA67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355271C2237D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26679150981;
	Mon, 29 Jul 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nFLP2IPC"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1119ECC;
	Mon, 29 Jul 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269743; cv=none; b=NRDvc+VTgTT8n28EvfKscQNBQKjauOIp14sVO29LpHci4cH35gL0BesZOS6O8v4dOJKQghckBZWrRTsulMIcNq37Qeu4C/EGPkloh+kL/lGpyey20rCK0FHljapKcM+6ijnU1W1nkfcSB7/PCPcm34l4TohRzMGTcByTh6SkSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269743; c=relaxed/simple;
	bh=e25RnGm3UUfzN+5y7ZyHo2fNUQbHueNz+JQ13IN92Q8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BjOv3FAjPxF60X9DdcBfiaBSIvlCP51yEDKQ2bXsEPur0LetjQop+b80FXFm0oU3dl8igg/rOXgTxdzbocAyIVHxiCABy88lyCOuJn/9TIv15gblAig1jgjOAZPU+JDzh/R14HfH0GnYDQ8AXSPCzWLoZci6unopKCfH4TWWMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nFLP2IPC; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFGMTM019487;
	Mon, 29 Jul 2024 11:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=qRzBBbqoXOWQyyYO
	JMgkXOAR8+qV4bh0yhqqlwUEGVA=; b=nFLP2IPC2OwvDdvbC44c7L85phYx/Lz+
	aavMdD6RmN/mkSRX9N/a/bUz9SiEI/Gg8FU/yEC6Wer/XZhFH5B2HaG6h13TIlK9
	Hv5PxrNsPRikZ1+KD9tvgX/KSBLh6ELrdJRQKEXU2Kj6yT3HUfpvTrNxgGh3GSZf
	sxAV7mvY8g9GK1CcwAPM9r1bb2+ELpuCFgPBy4m9IKu0GMHQu2GmBXFm6V320GBr
	9Qnl33OzKSErJRGAIJgtqS0bISnI/eeCT3IcnMJBvSmY53ae1ZrIVyviFifosaju
	0So/5sAQVTNF0KRbzZz88NWQvW0/PlFQzjFKjwzafkvbi0xuW4KZLQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40mwajtbgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 11:15:36 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 17:15:34 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 29 Jul 2024 17:15:34 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3E6F6820244;
	Mon, 29 Jul 2024 16:15:34 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Stop creating ALSA controls for firmware coefficients
Date: Mon, 29 Jul 2024 16:15:32 +0000
Message-ID: <20240729161532.147893-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JDXsPmEN9C12lN1Lyq9L7W6c4TiV9wzo
X-Proofpoint-ORIG-GUID: JDXsPmEN9C12lN1Lyq9L7W6c4TiV9wzo
X-Proofpoint-Spam-Reason: safe

A number of laptops have gone to market with old firmware versions that
export controls that have since been hidden, but we can't just install a
newer firmware because the firmware for each product is customized and
qualified by the OEM. The issue is that alsactl save and restore has no
idea what controls are good to persist which can lead to
misconfiguration.

As the ALSA controls for the firmware coefficients are not used in
normal operation they can all be hidden, but add a kernel parameter so
that they can be re-enabled for debugging.

Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 96d3f13c5abf..1494383b22c9 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -23,6 +23,10 @@
 #include "hda_cs_dsp_ctl.h"
 #include "hda_generic.h"
 
+static bool expose_dsp_controls;
+module_param(expose_dsp_controls, bool, 0444);
+MODULE_PARM_DESC(expose_dsp_controls, "Expose firmware controls as ALSA controls 0=no (default), 1=yes");
+
  /*
   * The cs35l56_hda_dai_config[] reg sequence configures the device as
   *  ASP1_BCLK_FREQ = 3.072 MHz
@@ -758,6 +762,9 @@ static int cs35l56_hda_bind(struct device *dev, struct device *master, void *mas
 
 	cs35l56_hda_create_controls(cs35l56);
 
+	if (expose_dsp_controls)
+		cs35l56_hda_add_dsp_controls(cs35l56);
+
 #if IS_ENABLED(CONFIG_SND_DEBUG)
 	cs35l56->debugfs_root = debugfs_create_dir(dev_name(cs35l56->base.dev), sound_debugfs_root);
 	cs_dsp_init_debugfs(&cs35l56->cs_dsp, cs35l56->debugfs_root);
-- 
2.43.0


