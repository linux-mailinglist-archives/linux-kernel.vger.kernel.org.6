Return-Path: <linux-kernel+bounces-168969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F128BC05C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 14:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6360B21203
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582C19479;
	Sun,  5 May 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rzrBNOIY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A217556
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714911923; cv=none; b=BqzZAS7990RcNbX86LHi3ciM1WIINiFmSLyfH72W1GHmWQgRPu/gI8+YfNy/mxRjawhW6KKzj6B1Ms/HXhvquxYs+IBO6c7W0cLRu1YOk/ugVbXdSJ1lppRoU0diHs6YXgYQIXNHQdYTL53AEs5ydAx9aL4NKN1pF74qfmfB1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714911923; c=relaxed/simple;
	bh=kfEy6Lml/t/3cMIhRtI7Bj78a/7ugx6tLl1SRmL6rnE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QXT7m7nY6FhBcUaBXvlFHZvGTwRPJurSQpfPACZS8h+A/MDgyyH97LQw6VhqHbzSrBP2xnicVh5LgsPOEz0LuLt0EDSNCSWfDGAKnJ82xd7MqmHDTKjFJQuVgmMdUqaG0NIHYa9BK66uEiUp/ul6JBDbfkKYlqiQ7gI5/Daxezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rzrBNOIY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 445CO12A070737;
	Sun, 5 May 2024 07:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714911841;
	bh=hfpl7gB5elHvkCdR9N7Mf+3OMIJmGNcSYdH3zrkPOkc=;
	h=From:To:CC:Subject:Date;
	b=rzrBNOIYnmHNPWOaM0biDrEcbZAVJRFQTAGnlvVROt0eAQJqTywPUG4gGqZFnc98t
	 TrkqquSynMH0PyKYj70W7v3qJbn0j/mxwnvxOx2fIHxOvwOEk0h8AZQ7uGycTX/CU4
	 vOQ502JtyoAd7+Iut7aScVYc5qfSHsk8qBBShtFw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 445CO1FB030030
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 5 May 2024 07:24:01 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 5
 May 2024 07:24:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 5 May 2024 07:24:01 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.109])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 445CNtWn068090;
	Sun, 5 May 2024 07:23:56 -0500
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
Subject: [PATCH v2] ASoC: tas2781: Fix a warning reported by robot kernel test
Date: Sun, 5 May 2024 20:23:45 +0800
Message-ID: <20240505122346.1326-1-shenghao-ding@ti.com>
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

Fix a warning reported by robot kernel test that 'fw_entry' in function
'tas2781_load_calibration' is used uninitialized with compiler
sh4-linux-gcc (GCC) 13.2.0, an update of copyright and a correction of the
comments.

Fixes: ef3bcde75d06 ("ASoc: tas2781: Add tas2781 driver")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v2:
 - Describe more what was actually an issue reported by robot kernel test.
 - Correct the subject suffix, ALSA: ASoc/tas2781 --> ASoC: tas2781.
v1:
 - Update the copyright year to 2024
 - tasdevice-fmw.c --> tas2781-fmwlib.c
 - | Reported-by: kernel test robot <lkp@intel.com>
   | Closes: https://lore.kernel.org/oe-kbuild-all/202405021200.YHInjV43-lkp@intel.com/
---
 sound/soc/codecs/tas2781-fmwlib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 45760fe19523..a6be81adcb83 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// tasdevice-fmw.c -- TASDEVICE firmware support
+// tas2781-fmwlib.c -- TASDEVICE firmware support
 //
-// Copyright 2023 Texas Instruments, Inc.
+// Copyright 2023 - 2024 Texas Instruments, Inc.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 
@@ -1878,7 +1878,7 @@ int tas2781_load_calibration(void *context, char *file_name,
 {
 	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *)context;
 	struct tasdevice *tasdev = &(tas_priv->tasdevice[i]);
-	const struct firmware *fw_entry;
+	const struct firmware *fw_entry = NULL;
 	struct tasdevice_fw *tas_fmw;
 	struct firmware fmw;
 	int offset = 0;
-- 
2.34.1


