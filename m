Return-Path: <linux-kernel+bounces-338211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBEF9854E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373111C236EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798EB15855E;
	Wed, 25 Sep 2024 08:01:54 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95F144D0A;
	Wed, 25 Sep 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251314; cv=none; b=bSx8a2gAKszulw5nqBbbzSjGAcUPUw58tk5AEkZYV7VFY8JenSgMi0YCtJ512N9G9jcUdfvxEZFrK9cVnEpYyynPjoQZx+pSUYXsAYUJnR42pK5TZwsyzVpwk8MhCVje8UkpwovdKXbfiaSkO1pzNADQH9TkPvvijX/0Ymms74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251314; c=relaxed/simple;
	bh=xIfw0yRqU10+8BUYFKO706Rgt3ulp51hvcjuux3TZ3o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETryroOoU4B0tMgVMU6IAMGNAo6w7byAcwTWgeHHei3shtr2DKjhCo6FmUIrcRqcRvCmYSt3hzOZzI3BNJTY1i66FuU3ENwzReguxHTdTBdpeZ6SwKl7dgmpVmFTSO8hbPX0N+0HD/uP1zTiqPGLyvKSpMoSv72MFfhvKoQbSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id WJA00132;
        Wed, 25 Sep 2024 16:00:32 +0800
Received: from localhost.localdomain (10.94.16.163) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 25 Sep 2024 16:00:33 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <yung-chuan.liao@linux.intel.com>, <ckeepax@opensource.cirrus.com>
CC: <alsa-devel@alsa-project.org>, <pierre-louis.bossart@linux.intel.com>,
	<liam.r.girdwood@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<broonie@kernel.org>, <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] ASoC: intel: sof_sdw: Add check devm_kasprintf() returned value
Date: Wed, 25 Sep 2024 16:00:30 +0800
Message-ID: <20240925080030.11262-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024925160032c5fe208e17589d9e2dc9fa15e5d58d53
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure but this
returned value is not checked.

Fixes: b359760d95ee ("ASoC: intel: sof_sdw: Add simple DAI link creation helper")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 sound/soc/intel/boards/sof_sdw.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index d258728d64cf..26917f6f15cf 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -919,6 +919,9 @@ static int create_ssp_dailinks(struct snd_soc_card *card,
 		char *cpu_dai_name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d Pin", i);
 		char *codec_name = devm_kasprintf(dev, GFP_KERNEL, "i2c-%s:0%d",
 						  ssp_info->acpi_id, j++);
+		if (!name || !cpu_dai_name || !codec_name)
+			return -ENOMEM;
+
 		int playback = ssp_info->dais[0].direction[SNDRV_PCM_STREAM_PLAYBACK];
 		int capture = ssp_info->dais[0].direction[SNDRV_PCM_STREAM_CAPTURE];
 
@@ -985,6 +988,9 @@ static int create_hdmi_dailinks(struct snd_soc_card *card,
 	for (i = 0; i < hdmi_num; i++) {
 		char *name = devm_kasprintf(dev, GFP_KERNEL, "iDisp%d", i + 1);
 		char *cpu_dai_name = devm_kasprintf(dev, GFP_KERNEL, "iDisp%d Pin", i + 1);
+		if (!name || !cpu_dai_name)
+			return -ENOMEM;
+
 		char *codec_name, *codec_dai_name;
 
 		if (intel_ctx->hdmi.idisp_codec) {
@@ -996,6 +1002,9 @@ static int create_hdmi_dailinks(struct snd_soc_card *card,
 			codec_dai_name = "snd-soc-dummy-dai";
 		}
 
+		if (!codec_dai_name)
+			return -ENOMEM;
+
 		ret = asoc_sdw_init_simple_dai_link(dev, *dai_links, be_id, name,
 						    1, 0, // HDMI only supports playback
 						    cpu_dai_name, platform_component->name,
@@ -1019,6 +1028,9 @@ static int create_bt_dailinks(struct snd_soc_card *card,
 			SOF_BT_OFFLOAD_SSP_SHIFT;
 	char *name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d-BT", port);
 	char *cpu_dai_name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d Pin", port);
+	if (!name || !cpu_dai_name)
+		return -ENOMEM;
+
 	int ret;
 
 	ret = asoc_sdw_init_simple_dai_link(dev, *dai_links, be_id, name,
-- 
2.31.1


