Return-Path: <linux-kernel+bounces-234887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B651991CC0F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 12:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D81C21280
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CF43D575;
	Sat, 29 Jun 2024 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VptIlpJk"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A372E3EE
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719655979; cv=none; b=ar8+A07Qt+3zqIYLwp2Hhqmo8VnNumnBSmqGNbN76093LcVcOKknx7P+PLAeCG2gqeUiXXslSi0ZBmiK2aAcHOQt4TNY8mMnEWhGe5oEoGh/5bhPR/jVojqi7e5FsE1zbwh2ZkIajsoTxQoL7maVfkrZzf52CPwcT2GLVK4A2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719655979; c=relaxed/simple;
	bh=mVb24fnuRVL8X+zLFAfCADvfEPJ+TVtgExoeRQHI38k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BT+OjgLZXALNedRLCMLdEqDxlsnSYhT8Mojup9IBpCPcvIDv9xo8Fy9Ncn/gHtljIyF+7uFbDD/yWkvZQl7MNnczszW1cLVzQMP5hQbtzTi93NjCXfXAyE3/lerGoPIQLdAmmeiF3EzZQx5rGwWzR16qlmqBCbmczBVmoFiiY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VptIlpJk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45TABWGL075947;
	Sat, 29 Jun 2024 05:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719655892;
	bh=j+35sZloQtOncQRrC2TQVPifEH/ctuOisMlfiAP9d5Q=;
	h=From:To:CC:Subject:Date;
	b=VptIlpJkn+NFmFYIRl2THRZ+eRJptDnn+04i7BymHc5Uu0hPFEJytzNfEiqh+C6r7
	 tszNwSMj/b/T62ElZ6kOa+qoCDvcdVXW/9iyt/qe+BjlMYMPrHXobkhhfPt31QZHsz
	 ZU6JIbxXYhG165Kbu7/GbEkE7Rhz07XK+6wh9DQE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45TABWrU127666
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Jun 2024 05:11:32 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 29
 Jun 2024 05:11:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 29 Jun 2024 05:11:31 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.158])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45TABLfH074877;
	Sat, 29 Jun 2024 05:11:22 -0500
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
Subject: [PATCH v1] ASoc: tas2781: Add name_prefix as the prefix name of DSP firmwares and calibrated data files
Date: Sat, 29 Jun 2024 18:11:10 +0800
Message-ID: <20240629101112.628-1-shenghao-ding@ti.com>
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

Add name_prefix as the prefix name of DSP firmwares
and calibrated data files which stored speaker
calibrated impedance.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/soc/codecs/tas2781-i2c.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 4d1a0d836e77..cc765d45c6b5 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -394,8 +394,12 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	 * failing to load DSP firmware is NOT an error.
 	 */
 	tas_priv->fw_state = TASDEVICE_RCA_FW_OK;
-	scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
-		tas_priv->dev_name);
+	if (tas_priv->name_prefix)
+		scnprintf(tas_priv->rca_binaryname, 64, "%s-%s_coef.bin",
+			tas_priv->name_prefix, tas_priv->dev_name);
+	else
+		scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
+			tas_priv->dev_name);
 	ret = tasdevice_dsp_parser(tas_priv);
 	if (ret) {
 		dev_err(tas_priv->dev, "dspfw load %s error\n",
@@ -418,8 +422,15 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	 * calibrated data inside algo.
 	 */
 	for (i = 0; i < tas_priv->ndev; i++) {
-		scnprintf(tas_priv->cal_binaryname[i], 64, "%s_cal_0x%02x.bin",
-			tas_priv->dev_name, tas_priv->tasdevice[i].dev_addr);
+		if (tas_priv->name_prefix)
+			scnprintf(tas_priv->cal_binaryname[i], 64,
+				"%s-%s_cal_0x%02x.bin", tas_priv->name_prefix,
+				tas_priv->dev_name,
+				tas_priv->tasdevice[i].dev_addr);
+		else
+			scnprintf(tas_priv->cal_binaryname[i], 64,
+				"%s_cal_0x%02x.bin", tas_priv->dev_name,
+				tas_priv->tasdevice[i].dev_addr);
 		ret = tas2781_load_calibration(tas_priv,
 			tas_priv->cal_binaryname[i], i);
 		if (ret != 0)
-- 
2.34.1


