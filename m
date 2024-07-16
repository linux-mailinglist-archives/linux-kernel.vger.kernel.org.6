Return-Path: <linux-kernel+bounces-253394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4612693207F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05379282AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24921CD11;
	Tue, 16 Jul 2024 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kz1eXSb+"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380211862C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112172; cv=none; b=qAk4aOb1aYG7TB+HaCGCvywTUQdxGeZFW1ZA29yXT85zIaq3JyMRgzqfujOY2DIUL8d0SUd/ecCHpeUcUPTopWPjp/LV4Unft3BENg2eiL5gN5pIGIpfsRFGmZoTXIwc9Qa73VtMCgfDPwBFGe9wrVEaLwpZ+SAffqM34MtuiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112172; c=relaxed/simple;
	bh=SLm0A+C67J+1a0stnpjNftDb7NZpVKYQqx38hlCUxMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V+A2y2ycniMTheMmnYgK2wsMU3dKfVnazHMMAu+62QsjFJ70ROa2qeO2NaYwdAOwqC05MbtB3C9gI2uXH5LPhksRzHGQ8FhXhT176qXycWVJAWEDkT8z0VdNDaaM9YrSxmnse9PZGjfG+GwuJnunlp+P+SlhgGFrzHHPlLVtc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kz1eXSb+; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46G6fYHd004717;
	Tue, 16 Jul 2024 01:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721112094;
	bh=E2SIKmhtinzNu37HFD3FuaXiHlsdUOR1yd/jl8fXQDo=;
	h=From:To:CC:Subject:Date;
	b=Kz1eXSb+7N6DxeaWCRThnY8ND5LIMt9NC+daTF7q7CW2ubUMwXr1nsix4bN5NKqpH
	 nIqd4wr9DfUcN5UTH8KcqoAsR7WtPBfaQao0Miy0TAoiLcwYZdC50FP+bG+OrcVybM
	 MEbsKmcSzXoCpWvlptT8aQlJABip7XJAudsIFekI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46G6fYwI068159
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Jul 2024 01:41:34 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Jul 2024 01:41:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Jul 2024 01:41:33 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.243])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46G6fOth072440;
	Tue, 16 Jul 2024 01:41:24 -0500
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
        <jesse-ji@ti.com>, <darren.ye@mediatek.com>, <antheas.dk@gmail.com>,
        Shenghao
 Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ASoc: tas2781: Add TAS2563 into the Header
Date: Tue, 16 Jul 2024 14:41:17 +0800
Message-ID: <20240716064120.158-1-shenghao-ding@ti.com>
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

Add TAS2563 into the Header in case of misunderstanding and add
channel No information for error debug in tasdevice_dev_read.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - Add TAS2563 into the Header
 - Add channel no into the log in tasdevice_dev_read for error debug
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


