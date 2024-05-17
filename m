Return-Path: <linux-kernel+bounces-181910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769908C832E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2FF282700
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA78B25750;
	Fri, 17 May 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QVV9Vle2"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F8122EE8
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937739; cv=none; b=J9m8pEyj5bCihSf5BG+Qs54W24l9JAuJj0F4yjAXbpV8be8SXJSnzuQRT9N03R2bBfQW1uNSuqt2e0+yFR9Wdm/uQa4k7lGaSPTKo5m4X2mCzhNxfuczwplu65ay95x/AKNWRpWTk6QeXcrsiCwXFaVpF6yNPennP5+KA4wvb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937739; c=relaxed/simple;
	bh=tYAI6TOAKRcbV1juyFS7/yUxVV6DkbGrmukK/JfBr+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b+c9K9BmLD4U63DUV28VMPJ8JGVM4fobGTbcTli2VHvwkG+DurO0eNJVu5i3y3dYWGByAiIyEOkEzGs4o2pOilD46e/iqEfcQ4ubZwoyhAw7iu2VwoxAK78aktv5VV7FGPmfOeJsW9pgi4c3rHwq90zeHC7iBsICZdYBu23D0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QVV9Vle2; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44H9KnI9081866;
	Fri, 17 May 2024 04:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715937650;
	bh=qiiDi6iBA4vHp7ewYuXe/3jhyEOsgdvn9UBZf5Tf+Nw=;
	h=From:To:CC:Subject:Date;
	b=QVV9Vle2k6y0lauTeMd1Tzjy7x3gTq1uF+6qE9zTBH1UM6mUDspuObyEm0QvSVfTc
	 lQBoBXcvGdTqhsSzW1toI5U9a/+4OAU1BlcG1TJ435LkEXJ7CFzjhv+lDMOM+YBFAG
	 +CLlwVpzqVhhzeuAt8jL2FD6HPK3raKDoV25IOB4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44H9KnBe090369
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 May 2024 04:20:49 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 May 2024 04:20:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 May 2024 04:20:49 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44H9KhXq036740;
	Fri, 17 May 2024 04:20:44 -0500
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
Subject: [RESEND PATCH v5 1/3] ASoC: tas2781: Fix wrong loading calibrated data sequence
Date: Fri, 17 May 2024 17:20:36 +0800
Message-ID: <20240517092039.688-1-shenghao-ding@ti.com>
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

Remove declaration of unused API which load calibrated data in wrong
sequence, changed the copyright year and correct file name in license
header.

Fixes: ef3bcde75d06 ("ASoc: tas2781: Add tas2781 driver")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v5:
 - correct changelog has no much relationship with the patch
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


