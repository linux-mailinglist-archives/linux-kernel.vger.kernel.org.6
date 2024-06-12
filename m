Return-Path: <linux-kernel+bounces-211034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8EE904C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9515D1F242E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C3516C69E;
	Wed, 12 Jun 2024 07:07:51 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EED16B73C;
	Wed, 12 Jun 2024 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176070; cv=none; b=GP1IkPDWgiz8FgaYl+qy/4lSJyBS+0U+sfgXwbU+MQ4//omXF8oCj7gPaQhdtNmESzyptZmTqCHK9Xv5S22MZScsVeNf8l7I+FkSVYPakoh68LCKX/pvWcNEgBwt0/H9pL51lTbok6Zik3GtoXttp7Nm5PMl9O24if0gOn2BPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176070; c=relaxed/simple;
	bh=s7TgO1xFEFshQBAQY8OYv14stw9Qgxt8pZDh96opt3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TsxU2Cg8/F9tenyurob5+OdoreD22nCQ5MIxHJopJ3L+wwrFdgIk5xqQksC0kOYsJmDJP4zxCC/yyGSZkhte+ePThr8aVIEjoU8sZY7tBQuzKh/HkFwQ1pLacZ2FmihuQioeC96ivjuMYU7J2Bt9TNlbf6j1yqwAMLB3pknXKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA9851A124C;
	Wed, 12 Jun 2024 08:57:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D2A51A0FFA;
	Wed, 12 Jun 2024 08:57:47 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1D65C180222C;
	Wed, 12 Jun 2024 14:57:45 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com
Subject: [PATCH 2/3] ASoC: fsl_audmix: Split playback and capture stream to different DAI
Date: Wed, 12 Jun 2024 14:40:51 +0800
Message-Id: <1718174452-17596-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
References: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

As audmix requires playback and capture stream in different
master/slave mode, so separate playback and capture stream to
different DAI. There are three DAIs required, two DAIs for playback
one DAI for capture.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_audmix.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 0ab2c1962117..1671a3037c60 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -326,15 +326,6 @@ static struct snd_soc_dai_driver fsl_audmix_dai[] = {
 			.rates = SNDRV_PCM_RATE_8000_96000,
 			.formats = FSL_AUDMIX_FORMATS,
 		},
-		.capture = {
-			.stream_name = "AUDMIX-Capture-0",
-			.channels_min = 8,
-			.channels_max = 8,
-			.rate_min = 8000,
-			.rate_max = 96000,
-			.rates = SNDRV_PCM_RATE_8000_96000,
-			.formats = FSL_AUDMIX_FORMATS,
-		},
 		.ops = &fsl_audmix_dai_ops,
 	},
 	{
@@ -349,8 +340,13 @@ static struct snd_soc_dai_driver fsl_audmix_dai[] = {
 			.rates = SNDRV_PCM_RATE_8000_96000,
 			.formats = FSL_AUDMIX_FORMATS,
 		},
+		.ops = &fsl_audmix_dai_ops,
+	},
+	{
+		.id   = 2,
+		.name = "audmix-2",
 		.capture = {
-			.stream_name = "AUDMIX-Capture-1",
+			.stream_name = "AUDMIX-Capture-0",
 			.channels_min = 8,
 			.channels_max = 8,
 			.rate_min = 8000,
-- 
2.34.1


