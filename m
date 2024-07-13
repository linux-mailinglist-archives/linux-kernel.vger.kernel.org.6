Return-Path: <linux-kernel+bounces-251300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36067930326
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D457C1F21797
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085715AF6;
	Sat, 13 Jul 2024 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LIMkLRdp"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32DBDF53
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720835620; cv=none; b=AyBqmZhk2P1drmQ6GYvMevhVbcfQc2uyeD9y6p9Niihn3ZeVN7JxX9lrVEUZoF5hy38QKeyj793s9R03ISO6aRwb+3Bg5zCuiIuzjbeJRaYAd2rxEWb3acZ3KA+vB6UVX6UhMydgi084m88B3S1LbAbCJksNtO4UDyz1Pdeof/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720835620; c=relaxed/simple;
	bh=2MX1KLXTFjNfOMVjTG0kdwRapO48u9jmWDGEz+kukcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ou7LhzVLXR2zcXuJAGEqBUdyfDzPUnWYF7hmxJvkmWI+IvtT0XRc4feNUYIv6rpmlFjaIzzRdsek4b4j97m7+7GlweKxQ74v3pEafm6VKQ+Hz/3SiETCPq5C2HFnfSPGPvH67Sz8tEl7s/Y66JAWhXD6hT2C06oY5EQIAqThYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LIMkLRdp; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46D1qEXT054732;
	Fri, 12 Jul 2024 20:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720835534;
	bh=12zvunMgJ4BHmV2ehOmR6esUYfYMaau/21+alSU86Jc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LIMkLRdpfW2d5jdSSAUA3V2OfuLJBGo2Lz2ZXJI3PJqyuBfUEGsMVCHdXSON3tOmb
	 cb7p84kfQgKNqllOEvcbw3dWqAGSPJQCmLQ5IIARMoQRS8M8fyWAKFRUQV7GIhMN0K
	 mOykiP9BTFWUT2bq813EtJ2BxrMBVS1rj0wJqGMU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46D1qEct012773
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jul 2024 20:52:14 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jul 2024 20:52:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jul 2024 20:52:13 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.245])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46D1pnOs126053;
	Fri, 12 Jul 2024 20:52:03 -0500
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
Subject: [PATCH v1 2/2] ASoc: tas2781: Rename dai_driver name to unify the name between TAS2563 and TAS2781
Date: Sat, 13 Jul 2024 09:51:42 +0800
Message-ID: <20240713015145.314-2-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240713015145.314-1-shenghao-ding@ti.com>
References: <20240713015145.314-1-shenghao-ding@ti.com>
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

v1:
 - Use strscpy to replace scnprintf.
 - rename dai_driver name from "tas2781_codec" to "tasdev_codec"
 - Remove unnecessary line feed for tasdevice_dsp_create_ctrls
---
 sound/soc/codecs/tas2781-i2c.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index e79d613745b4..6482ec44f7a8 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -352,7 +352,7 @@ static int tasdevice_create_control(struct tasdevice_priv *tas_priv)
 		ret = -ENOMEM;
 		goto out;
 	}
-	scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "Speaker Profile Id");
+	strscpy(name, "Speaker Profile Id", SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 	prof_ctrls[mix_index].name = name;
 	prof_ctrls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	prof_ctrls[mix_index].info = tasdevice_info_profile;
@@ -423,8 +423,7 @@ static int tasdevice_configuration_put(
 	return ret;
 }
 
-static int tasdevice_dsp_create_ctrls(
-	struct tasdevice_priv *tas_priv)
+static int tasdevice_dsp_create_ctrls(struct tasdevice_priv *tas_priv)
 {
 	struct snd_kcontrol_new *dsp_ctrls;
 	char *prog_name, *conf_name;
@@ -452,8 +451,8 @@ static int tasdevice_dsp_create_ctrls(
 		goto out;
 	}
 
-	scnprintf(prog_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
-		"Speaker Program Id");
+	strscpy(prog_name, "Speaker Program Id",
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 	dsp_ctrls[mix_index].name = prog_name;
 	dsp_ctrls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	dsp_ctrls[mix_index].info = tasdevice_info_programs;
@@ -461,8 +460,7 @@ static int tasdevice_dsp_create_ctrls(
 	dsp_ctrls[mix_index].put = tasdevice_program_put;
 	mix_index++;
 
-	scnprintf(conf_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
-		"Speaker Config Id");
+	strscpy(conf_name, "Speaker Config Id", SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 	dsp_ctrls[mix_index].name = conf_name;
 	dsp_ctrls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	dsp_ctrls[mix_index].info = tasdevice_info_configurations;
@@ -672,7 +670,7 @@ static const struct snd_soc_dai_ops tasdevice_dai_ops = {
 
 static struct snd_soc_dai_driver tasdevice_dai_driver[] = {
 	{
-		.name = "tas2781_codec",
+		.name = "tasdev_codec",
 		.id = 0,
 		.playback = {
 			.stream_name = "Playback",
-- 
2.34.1


