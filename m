Return-Path: <linux-kernel+bounces-370344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0B19A2B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFD61F24103
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3962B1DFD92;
	Thu, 17 Oct 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irjm2lSR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AF1DC07D;
	Thu, 17 Oct 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187162; cv=none; b=hoYJNL89EPYYLfmk9k6WsB2Inn8YK3CwojDFf4igWJbhyng0EKu/bniYQTScXEOkldME0F9ucS+h2ZNCzNMuEkIdxkyKe4nTFGoR38O0Yqwj4+uiJx9A10w8UOURkPWGMF2VJBTzxkLeHK/vhk17n17SBs2b3fKuJGiSks7pcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187162; c=relaxed/simple;
	bh=ZJeBnK/GFwecNC6DB0KU9Yd9+DCE9KBssCWtfmugMgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzVgJLKkyFqsY2sSMCBFCMl0+WtnrDsVqM5SQ90DhTQHMvVPSfAPCBOodq2ZEp9AK7b79RxHKMc+l2a3pUv364XddBga5zZRs2WMndHoZNN/+A9aWi1IAiwU3fGr5nNzRZwdaOMkuzWWonS18wnP7GA4DQUU75qmkbeReh6fw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irjm2lSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD6AC4CECE;
	Thu, 17 Oct 2024 17:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729187162;
	bh=ZJeBnK/GFwecNC6DB0KU9Yd9+DCE9KBssCWtfmugMgg=;
	h=From:To:Cc:Subject:Date:From;
	b=irjm2lSRz0tLBVVYZCcsyZr03XXQVDxmUejI56M6pCEiZsxx+UbWPMdijjFwllkKE
	 ZLdO7F/ilEIIIvDRuIEOZWZw8HUcn4pNa+nbhfyvXwKYDsmZvOEUtdk2j2vKUsb+Gd
	 HMoXY7fzFaJcQRtfrJ6eJTEgaz+XL6eMPeAHu4VM0xtQWBA9rJLUbD2oqjX6ws9aow
	 v6jUsXlH0GTdkvrE1qrOiPrlfg7B6w7p4kaBjWZ5n/iT4wAHnYyMEbQyKFcdeynFT7
	 SvsKsnF9Jik9ya1LnftpHUlHcKjMBlXpDQ96lky3vdOkwCGqej3EqGMurdTC/esud7
	 nt9bfYW89LP6w==
From: Mario Limonciello <superm1@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	linux-kernel@vger.kernel.org (open list),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] ASoC: amd: acp: Add stream name to ACP PDM DMIC devices
Date: Thu, 17 Oct 2024 12:45:52 -0500
Message-ID: <20241017174552.3194385-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

This makes the devices consistent with the earlier acp devices.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/acp/acp-rembrandt.c | 1 +
 sound/soc/amd/acp/acp-renoir.c    | 1 +
 sound/soc/amd/acp/acp63.c         | 1 +
 sound/soc/amd/acp/acp70.c         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index 008d97598b629..1ed85cf76f520 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -153,6 +153,7 @@ static struct snd_soc_dai_driver acp_rmb_dai[] = {
 	.name = "acp-pdm-dmic",
 	.id = DMIC_INSTANCE,
 	.capture = {
+		.stream_name = "DMIC capture",
 		.rates = SNDRV_PCM_RATE_8000_48000,
 		.formats = SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 166f1efacf1d8..b9339bde34adc 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -131,6 +131,7 @@ static struct snd_soc_dai_driver acp_renoir_dai[] = {
 	.name = "acp-pdm-dmic",
 	.id = DMIC_INSTANCE,
 	.capture = {
+		.stream_name = "DMIC capture",
 		.rates = SNDRV_PCM_RATE_8000_48000,
 		.formats = SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
diff --git a/sound/soc/amd/acp/acp63.c b/sound/soc/amd/acp/acp63.c
index e0b86132eb958..feb619f1e1ef8 100644
--- a/sound/soc/amd/acp/acp63.c
+++ b/sound/soc/amd/acp/acp63.c
@@ -147,6 +147,7 @@ static struct snd_soc_dai_driver acp63_dai[] = {
 	.name = "acp-pdm-dmic",
 	.id = DMIC_INSTANCE,
 	.capture = {
+		.stream_name = "DMIC capture",
 		.rates = SNDRV_PCM_RATE_8000_48000,
 		.formats = SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index 3e4fd113a8a41..fe830c270463e 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -126,6 +126,7 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 	.name = "acp-pdm-dmic",
 	.id = DMIC_INSTANCE,
 	.capture = {
+		.stream_name = "DMIC capture",
 		.rates = SNDRV_PCM_RATE_8000_48000,
 		.formats = SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,

base-commit: 469819cc17368702a6f68cec2148f518d3f3679b
-- 
2.43.0


