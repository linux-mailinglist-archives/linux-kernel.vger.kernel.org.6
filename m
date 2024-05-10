Return-Path: <linux-kernel+bounces-175261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848A8C1D23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2CC1F21AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62226149E04;
	Fri, 10 May 2024 03:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R0gEPi0s"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860691494DE
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312574; cv=none; b=SsOq2AlpAHUgLYn9pfIjYIGABXvxucmSq+TGVsl1bynPghMXBHV6FInmFqqr8ePVJsXJJkFPh2O2o5MzU51SjA7nSoJMYJlpn8mZoQH9hN8dX8XirDH1fX9z/1x3kKDQ/f5fSN/GIFRPRxnS3kxkhYMllw9TGml5LrHI3mxZYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312574; c=relaxed/simple;
	bh=hluzFYdNftixgqYYd+oYVF/QqyvWXjGtaUfIDEEzD8k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H+cw4JWigr5eDQ9PPfpqd9COMx1b8IGP12hWq0oy5rkyPOV3thiKdOnGON12XfSvsigV5P1flRLYlVUi5Pg8WjzDT2jLk9raCco5S3dbeytLVuuuPyFQXhGIJS61EmkxPD78JNgPvX9SjZDmFXSmVA0hlETs2rpXZ6dKQtfqK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R0gEPi0s; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44A3faVK101052;
	Thu, 9 May 2024 22:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715312496;
	bh=ePKK2zPryndYkv7XmifCJAxCubJ5BMU9tcPAaWiyu/U=;
	h=From:To:CC:Subject:Date;
	b=R0gEPi0s0YDt/MQVPupXMncG8m3Vse0txidFe6GWu41FfEEosmF3YeqNgdssp5auI
	 EAVPDPM2uLU+P6sAsoBRm/PGNj+8AZsVFX/gVk+/VXkcXC8NLnQQxUrHsvLkeUU8bx
	 zSg7UI+Os8JJJ6LdKPj/uNte1GYy9eGC0J8jQ5O8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44A3faUG027531
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 May 2024 22:41:36 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 22:41:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 22:41:35 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.109])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44A3fSBL116558;
	Thu, 9 May 2024 22:41:29 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <bard.liao@intel.com>, <yung-chuan.liao@linux.intel.com>,
        <kevin-lu@ti.com>, <cameron.berkenpas@gmail.com>, <tiwai@suse.de>,
        <baojun.xu@ti.com>, <soyer@irl.hu>, <Baojun.Xu@fpt.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v4 1/3] ALSA: ASoc/tas2781: Fix wrong loading calibrated data sequence
Date: Fri, 10 May 2024 11:41:19 +0800
Message-ID: <20240510034123.1181-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Calibrated data will be set to default after loading DSP config params,
which will cause speaker protection work abnormally. Reload calibrated
data after loading DSP config params.

Fixes: ef3bcde75d06 ("ASoc: tas2781: Add tas2781 driver")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v4:
 - Use the the culprit of the bug itself as the fixes tag
v3:
 - No changes.
v2:
 - In the Subject, fixed --> Fix
 - Add Fixes tag
 - Changed the copyright year to 2024 in the related files
 - In tas2781-dsp.h, __TASDEVICE_DSP_H__ --> __TAS2781_DSP_H__
v1:
 - Download calibrated data after loading the new DSP config params
 - Remove tasdevice_prmg_calibdata_load, because it is unnecessary to load
   calibrated data after loading DSP program.
---
 include/sound/tas2781-dsp.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/sound/tas2781-dsp.h b/include/sound/tas2781-dsp.h
index ea9af2726a53..7fba7ea26a4b 100644
--- a/include/sound/tas2781-dsp.h
+++ b/include/sound/tas2781-dsp.h
@@ -2,7 +2,7 @@
 //
 // ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
 //
-// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
 // https://www.ti.com
 //
 // The TAS2781 driver implements a flexible and configurable
@@ -13,8 +13,8 @@
 // Author: Kevin Lu <kevin-lu@ti.com>
 //
 
-#ifndef __TASDEVICE_DSP_H__
-#define __TASDEVICE_DSP_H__
+#ifndef __TAS2781_DSP_H__
+#define __TAS2781_DSP_H__
 
 #define MAIN_ALL_DEVICES			0x0d
 #define MAIN_DEVICE_A				0x01
@@ -180,7 +180,6 @@ void tasdevice_calbin_remove(void *context);
 int tasdevice_select_tuningprm_cfg(void *context, int prm,
 	int cfg_no, int rca_conf_no);
 int tasdevice_prmg_load(void *context, int prm_no);
-int tasdevice_prmg_calibdata_load(void *context, int prm_no);
 void tasdevice_tuning_switch(void *context, int state);
 int tas2781_load_calibration(void *context, char *file_name,
 	unsigned short i);
-- 
2.34.1


