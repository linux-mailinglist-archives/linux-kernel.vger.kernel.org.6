Return-Path: <linux-kernel+bounces-273302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA59A946718
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 05:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774FC281DD3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA210A14;
	Sat,  3 Aug 2024 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HF+cLjwF"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298DB1078B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655809; cv=none; b=Dc5QT5/I6fWNB/yJZD0l/VznoivZvoJMoxr1DAJ7F2uzaW04EEBDhr82TsLw7ORRZ1gG/1x/ehH6n9aGBFJedm7vvehf2ugxkvDZfDTkdXLm8+xsXnxFQW9HIfJzSue3Ya/0kDpLT9n3OVxULZu6lFFx2lUPJQQ5oRkB4ozm9LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655809; c=relaxed/simple;
	bh=Jp4s2u0rPcRvnjZtDW6tpNcOkZxG/4WF21pFw18kwPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3jzuvCTverduXgLN4mUud7IJFEwjAndP0m7pG+RkVdHWoIm+eBEqaLMMHLyQLtK8rt9Dow5JVPdxcUY+qgrUJDCFW3zwyKNStwzAkGlIycZDHkqCSleSMMWYwa9PKzk0tucV43U+WRS8EdHJ6LVzbWRD+dt8iiY2/rkgu117m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HF+cLjwF; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4733RYv2063336;
	Fri, 2 Aug 2024 22:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722655655;
	bh=w8ZgzIw3ffEKLb+e21Wl0tugPEMWOMJhKlOMPqkQpb8=;
	h=From:To:CC:Subject:Date;
	b=HF+cLjwFIb6RgvSLRRZoorR7tPUPJNBrp0bcNq6diMAe4dpJyYDiFI6HymnC3OUFs
	 gGIqE8UNSlvGUuBxBREt6E/S7xav/xUc7GB1TMjzeLZzQPyL4KJg6bAUKp0s7MNUIv
	 xrkI56Vu5ghA9SMeAGdqEvK3ZNFSrZW9GCm8VKFM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4733RYeB025914
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Aug 2024 22:27:34 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Aug 2024 22:27:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Aug 2024 22:27:34 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.49])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4733RMx9057588;
	Fri, 2 Aug 2024 22:27:23 -0500
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
        <Jerry2.Huang@lcfuturecenter.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ASoc: tas2781: Rename dai_driver name to unify the name between TAS2563 and TAS2781
Date: Sat, 3 Aug 2024 11:27:14 +0800
Message-ID: <20240803032717.175-1-shenghao-ding@ti.com>
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

Rename dai_driver name to unify the name between TAS2563 and
TAS2781, remove unnecessary line feed, strscpy replace scnprintf.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - Use strscpy to replace scnprintf.
 - rename dai_driver name from "tas2781_codec" to "tasdev_codec",
   in case of misunderstanding whether tas2781 or tas2563.
 - Remove unnecessary line feed for tasdevice_dsp_create_ctrls
---
 sound/soc/codecs/tas2781-i2c.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 8a57c045afdd..6631254d4985 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -353,7 +353,7 @@ static int tasdevice_create_control(struct tasdevice_priv *tas_priv)
 		ret = -ENOMEM;
 		goto out;
 	}
-	scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "Speaker Profile Id");
+	strscpy(name, "Speaker Profile Id", SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 	prof_ctrls[mix_index].name = name;
 	prof_ctrls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	prof_ctrls[mix_index].info = tasdevice_info_profile;
@@ -424,8 +424,7 @@ static int tasdevice_configuration_put(
 	return ret;
 }
 
-static int tasdevice_dsp_create_ctrls(
-	struct tasdevice_priv *tas_priv)
+static int tasdevice_dsp_create_ctrls(struct tasdevice_priv *tas_priv)
 {
 	struct snd_kcontrol_new *dsp_ctrls;
 	char *prog_name, *conf_name;
@@ -453,8 +452,8 @@ static int tasdevice_dsp_create_ctrls(
 		goto out;
 	}
 
-	scnprintf(prog_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
-		"Speaker Program Id");
+	strscpy(prog_name, "Speaker Program Id",
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 	dsp_ctrls[mix_index].name = prog_name;
 	dsp_ctrls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	dsp_ctrls[mix_index].info = tasdevice_info_programs;
@@ -462,8 +461,7 @@ static int tasdevice_dsp_create_ctrls(
 	dsp_ctrls[mix_index].put = tasdevice_program_put;
 	mix_index++;
 
-	scnprintf(conf_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
-		"Speaker Config Id");
+	strscpy(conf_name, "Speaker Config Id", SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 	dsp_ctrls[mix_index].name = conf_name;
 	dsp_ctrls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	dsp_ctrls[mix_index].info = tasdevice_info_configurations;
@@ -673,7 +671,7 @@ static const struct snd_soc_dai_ops tasdevice_dai_ops = {
 
 static struct snd_soc_dai_driver tasdevice_dai_driver[] = {
 	{
-		.name = "tas2781_codec",
+		.name = "tasdev_codec",
 		.id = 0,
 		.playback = {
 			.stream_name = "Playback",
-- 
2.34.1


