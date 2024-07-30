Return-Path: <linux-kernel+bounces-267885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D38941925
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAEB1F238FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD601A618F;
	Tue, 30 Jul 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DDWUlSQZ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5211A6196;
	Tue, 30 Jul 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356964; cv=none; b=LcBiA2vQDVVQhMiXKbNhzUVVR/ai0p8Kq4PsjP3t4YytkJL0xue6fUAys4cLJ8pxBp8j3wQISnoe0L3bjwEkMabffKce+Dheu5huuS9xY41zxPqOwlOeSVTBt5qkWu4HkNMidpGO3xFKa5ZxMJeJOECKlA6sJktdgr+ROlQOBv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356964; c=relaxed/simple;
	bh=VlviwKtHP665YGCmI0bZGZDw7hxPytqD75fhyDynpxM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1lhYwbw7GnxJTRwH3xMvEYPNgd8qTYHuJbZOl+XNly0HkkH7UZ8tKjzZh4XVsq1x+sz0P1JCQhjrJFrAEt0Om8i4pz1xRB2gAUADrQj3x4Tyuvzxzk0jxW8jMfT7OyZBR0rjFG7bEIW/Ah4A0MoXmxDuumOJU5ZFLCJIZYxXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DDWUlSQZ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UFVqWH031765;
	Tue, 30 Jul 2024 11:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=u1uco8dY1nLjJCL5
	MRzVa0owg84ItQ/f5cnVxKxZ2bA=; b=DDWUlSQZyvwsTXbUbXAxP8/uZ17K70YL
	G4UpuIX8udTkAt/uqA8L+B6WYySWRKQSNlQz86+twVh1s3/37mMmGzSIwIYFIS24
	0G1eBZaC9CX/48DDaOoQyPkWpQsbCibmq9/+foMEhKqKfcyWUmmLHUDQYPtWnzQ4
	8cFzj3nazD4bF0L04m2JuqnmizdjBmzUC7vsj14v36pj5XCUMgIL7l3QeJOR8i7q
	C31AkjYOXIW7BSPduI+qaRdUAmuinWYL0riGYsOoOlfn+/U8gAwidbWFUDrxHjGG
	GrE1rsopz6F7Fy8EHeB21LkQC5uEc47+Tl50W6JB3bWUTYlgj+DkRQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40mx9yknva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 11:29:16 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 17:29:13 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 30 Jul 2024 17:29:13 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6E219820244;
	Tue, 30 Jul 2024 16:29:13 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH v2] ALSA: hda: cs35l56: Stop creating ALSA controls for firmware coefficients
Date: Tue, 30 Jul 2024 16:29:07 +0000
Message-ID: <20240730162907.300046-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BG-5tlWomrq32wMWkNjD7FexXkw-8csm
X-Proofpoint-ORIG-GUID: BG-5tlWomrq32wMWkNjD7FexXkw-8csm
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

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
Changes in v2:
- v1 was accidentally the backport version for older kernels instead of
  the one for v6.11

 sound/pci/hda/cs35l56_hda.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 96d3f13c5abf..f2f623f713d1 100644
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
@@ -613,7 +617,7 @@ static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	 */
 	if (cs35l56->base.fw_patched)
 		cs_dsp_power_down(&cs35l56->cs_dsp);
-	else
+	else if (expose_dsp_controls)
 		add_dsp_controls_required = true;
 
 	cs35l56->base.fw_patched = false;
-- 
2.43.0


