Return-Path: <linux-kernel+bounces-251299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E488930327
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8E51F237F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608EA168A9;
	Sat, 13 Jul 2024 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bjw85pRI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751FEAF1
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720835620; cv=none; b=tl88L+CbUA/ZAltUpnpQwMfzceFy7tVYfTyx0v42yeV/BUdHHLkKjXOBn2Z4xrBiU66YSNjqi+w4RPycFQWWpcBghO3nEpVyxPuULsyFkq4ELjB1/4AFZ5yzdaB4DnHLcQJDhh1Z89de/EAGVtftPbY0jxzLQUBX53uLwUjSHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720835620; c=relaxed/simple;
	bh=tUHBoPpfwV9ww3Rg+vE6njqj2/QAGGdRe8bvcD3tA/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qf1Pjuaq+SWHmtz5UdLt9LkPzsP4KRUHMsrcK04VUsK5BHHiv3imrShG9oR30wMevN2iEKAq8zRJyQCm8SQKEEkFMEwys7pOt1TiFiash2YFjoq3pHmILpSRedbV9/efY3F0YotVkka/b35Qql3vdb/Ut9m9aw6jVLT5FO7i1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bjw85pRI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46D1q1Hx048968;
	Fri, 12 Jul 2024 20:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720835521;
	bh=XCsCoUbllZWzfU40ldOwwVYbrbFWnPwTlY//EdX4WEE=;
	h=From:To:CC:Subject:Date;
	b=Bjw85pRIyyk0Ylb77/9m16gYMU59GtJoN+XE9xJ/VFpasvBAQrsZbkn955a3aJBZ8
	 cYxILH80jwWjoIvS1+F11J+z3sHPngzl42lxONrFceFG83RZE0O9vkR1UNWvxMiVj0
	 jMs5YnkHiIxAqEhbKAcL7VVFXMZZ4i2TvAZ1oMHs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46D1q03n012395
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jul 2024 20:52:01 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jul 2024 20:52:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jul 2024 20:52:00 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.245])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46D1pnOr126053;
	Fri, 12 Jul 2024 20:51:50 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <zhourui@huaqin.com>,
        <alsa-devel@alsa-project.org>, <i-salazar@ti.com>,
        <linux-kernel@vger.kernel.org>, <j-chadha@ti.com>,
        <liam.r.girdwood@intel.com>, <jaden-yue@ti.com>,
        <yung-chuan.liao@linux.intel.com>, <dipa@ti.com>, <yuhsuan@google.com>,
        <henry.lo@ti.com>, <tiwai@suse.de>, <baojun.xu@ti.com>, <soyer@irl.hu>,
        <Baojun.Xu@fpt.com>, <judyhsiao@google.com>, <navada@ti.com>,
        <cujomalainey@google.com>, <aanya@ti.com>, <nayeem.mahmud@ti.com>,
        <savyasanchi.shukla@netradyne.com>, <flaviopr@microsoft.com>,
        <jesse-ji@ti.com>, <darren.ye@mediatek.com>,
        Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v1 1/2] ASoc: tas2781: Add TAS2563 into the Header
Date: Sat, 13 Jul 2024 09:51:41 +0800
Message-ID: <20240713015145.314-1-shenghao-ding@ti.com>
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

Add TAS2563 into the Header in case of misunderstanding.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - Add TAS2563 into the Header
 - Add channel no into the log for error debug
---
 sound/soc/codecs/tas2781-comlib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 1fbf4560f5cc..58abbc098a91 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// TAS2781 Common functions for HDA and ASoC Audio drivers
+// TAS2563/TAS2781 Common functions for HDA and ASoC Audio drivers
 //
 // Copyright 2023 - 2024 Texas Instruments, Inc.
 //
@@ -64,8 +64,8 @@ static int tasdevice_change_chn_book(struct tasdevice_priv *tas_priv,
 			 */
 			ret = regmap_write(map, TASDEVICE_PAGE_SELECT, 0);
 			if (ret < 0) {
-				dev_err(tas_priv->dev, "%s, E=%d\n",
-					__func__, ret);
+				dev_err(tas_priv->dev, "%s, E=%d channel:%d\n",
+					__func__, ret, chn);
 				goto out;
 			}
 		}
-- 
2.34.1


