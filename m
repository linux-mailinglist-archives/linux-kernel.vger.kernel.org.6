Return-Path: <linux-kernel+bounces-241997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1E928254
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDCA1F24EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAB0144D20;
	Fri,  5 Jul 2024 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G/47uHTD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B861FFA;
	Fri,  5 Jul 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162200; cv=none; b=DY+PcDywxMQsmHtRHAhFKSb49atZtvvQqtKl+wGfYOYSTmpEQwyoec40QCTzrc09f7JWdJ5Nu7LamJp21ufr1YbXbRt+Uf6r/nf6HlHqLARl81Ogsn029f/cBkRcsXZM2Q01LqDXJOFwcCEaed1Es4edDRnH0OuWGrnlJfvF0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162200; c=relaxed/simple;
	bh=X4sBpiFvGRf8s3sGpg8NrXHB+7eBnkw+aAoHuQGw5oc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dx3SLstjuzHSzno2lsYptZoyjZN6aazCxZLNn73Pv23cweipYNBPAo60DK7lMmAsz2FzBbeoBuefuhFS/LCVUNVnfNj5McflxO+rjQCKqKlWgm6QCSpIJRjiKqzTcXnTEBYj9jD/RPazfsFPNgRZzrdc2KIzymBuOTDdkYQD3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G/47uHTD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4656muEa061005;
	Fri, 5 Jul 2024 01:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720162136;
	bh=RvGJO/GUepuJX0Iexd1UfxNYXvI37Rbvm22LhgAfUkM=;
	h=From:To:CC:Subject:Date;
	b=G/47uHTDMtsE8lFph9gnnXrl23nSV0thFa7kbRucHOEELc3IKnLhJ6aNx0DTICfy5
	 ALjwvPOpuhRO3lVGiH8RBw8j+FzGjQhF47Ebc+wxDtbofGQZAYoUt17QYtolsOhO9S
	 zglvtzxyN7kBc5AbAyIfBPyFmgGYZ1Ag4mh4g1Xo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4656mu0i071188
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jul 2024 01:48:56 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 01:48:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 01:48:56 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.205])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4656mquG027792;
	Fri, 5 Jul 2024 01:48:53 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <linux-sound@vger.kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <13916275206@139.com>,
        <soyer@irl.hu>, <tiwai@suse.de>, <Baojun.Xu@fpt.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ASoc: pcm6240: Remove unnecessary name-prefix for all the controls
Date: Fri, 5 Jul 2024 14:48:46 +0800
Message-ID: <20240705064846.1723-1-shenghao-ding@ti.com>
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

Adding name-prefix for each audio controls is a redundant, because
name-prefix will be automatically added behind the control name when
creating a new control.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - remove pcmdev_ctrl_name_with_prefix
 - remove some processes for control name_prefix handling
---
 sound/soc/codecs/pcm6240.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
index 86e126783a1d..3de35b62439b 100644
--- a/sound/soc/codecs/pcm6240.c
+++ b/sound/soc/codecs/pcm6240.c
@@ -57,12 +57,6 @@ static const char *const pcmdev_ctrl_name[] = {
 	"%s i2c%d Dev%d Ch%d Fine Volume",
 };
 
-static const char *const pcmdev_ctrl_name_with_prefix[] = {
-	"%s Dev%d Ch%d Ana Volume",
-	"%s Dev%d Ch%d Digi Volume",
-	"%s Dev%d Ch%d Fine Volume",
-};
-
 static const struct pcmdevice_mixer_control adc5120_analog_gain_ctl[] = {
 	{
 		.shift = 1,
@@ -1365,10 +1359,7 @@ static int pcmdev_gain_ctrl_add(struct pcmdevice_priv *pcm_dev,
 
 	name_id = pcmdev_gain_ctl_info[id][ctl_id].pcmdev_ctrl_name_id;
 
-	if (comp->name_prefix)
-		ctrl_name = pcmdev_ctrl_name_with_prefix[name_id];
-	else
-		ctrl_name = pcmdev_ctrl_name[name_id];
+	ctrl_name = pcmdev_ctrl_name[name_id];
 
 	for (chn = 1; chn <= nr_chn; chn++) {
 		name = devm_kzalloc(pcm_dev->dev,
@@ -1377,13 +1368,9 @@ static int pcmdev_gain_ctrl_add(struct pcmdevice_priv *pcm_dev,
 			ret = -ENOMEM;
 			goto out;
 		}
-		if (comp->name_prefix)
-			scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
-				ctrl_name, comp->name_prefix, dev_no, chn);
-		else
-			scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
-				ctrl_name, pcm_dev->upper_dev_name, adap->nr,
-				dev_no, chn);
+		scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+			ctrl_name, pcm_dev->upper_dev_name, adap->nr,
+			dev_no, chn);
 		pcmdev_controls[mix_index].tlv.p =
 			pcmdev_gain_ctl_info[id][ctl_id].gain;
 		pcmdev_ctrl = devm_kmemdup(pcm_dev->dev,
@@ -1437,13 +1424,8 @@ static int pcmdev_profile_ctrl_add(struct pcmdevice_priv *pcm_dev)
 	if (!name)
 		return -ENOMEM;
 
-	if (comp->name_prefix)
-		scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
-			"%s Profile id", comp->name_prefix);
-	else
-		scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
-			"%s i2c%d Profile id", pcm_dev->upper_dev_name,
-			adap->nr);
+	scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+		"%s i2c%d Profile id", pcm_dev->upper_dev_name, adap->nr);
 	pcmdev_ctrl->name = name;
 	pcmdev_ctrl->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	pcmdev_ctrl->info = pcmdevice_info_profile;
-- 
2.34.1


