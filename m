Return-Path: <linux-kernel+bounces-527503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6950A40BF0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12ED319C00D2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC82A20468B;
	Sat, 22 Feb 2025 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l9JVxDwe"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418151F755B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740265103; cv=none; b=jVRtydQneHK6qWc2XsDM1f+25HSoda/1mIXRGbb7pYI59f6mA0LFCOHgqvwAppwjfg69OpPWFNiV0IPZtLQDRGj7fdvQ+Eik1AFQbER56sDoRqst51fdTqvUIfLFVFR5x1ix7TVGWkhXEz2Dtl6T44L/p4q4uRjVvuEIPfZ1ohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740265103; c=relaxed/simple;
	bh=8xX8lbiW+5RQ+wFxa3JghYTzhMpaR5RIrDRPY8soEFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2/97haIhrAuCBfzuJqsefzH4impJOaEiA7tOz/+dMVPGgSaaNLRyFSsvGQodih3rTL2HIvdVFT2ZGHkm2aoBpoLeLi/xZjxlHabHk1Rcv86zaLIpsb0Myr+9ORhAuTfMc+JQwFinCG74H1n2y7v/+zeqsQ2/8FKPh3w8BaXacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l9JVxDwe; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740265089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9ZqF8FngRBwwLVOgM6/1uD7/Y5CAfT801f3ud25fkUA=;
	b=l9JVxDweckFogGJH5q4Ka1r3ELgk/y203WVyzs94rM2BPk0/2cTPLi6lbUkK4KTuJnFdPv
	7R2gTe6WyOAbaLq/QTaRZiTg+V5tpDuu5GPm1H6PD3+ebFO/SHEdCPcmJhDrrsIhbKQeWy
	I6+ex6pNIvN7YgCqMhwnrVITcTQo/io=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sheetal <sheetal@nvidia.com>,
	Sameer Pujar <spujar@nvidia.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ritu Chaudhary <rituc@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tegra: Fix ADX S24_LE audio format
Date: Sat, 22 Feb 2025 23:56:59 +0100
Message-ID: <20250222225700.539673-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 4204eccc7b2a ("ASoC: tegra: Add support for S24_LE audio format")
added support for the S24_LE audio format, but duplicated S16_LE in
OUT_DAI() for ADX instead.

Fix this by adding support for the S24_LE audio format.

Compile-tested only.

Cc: stable@vger.kernel.org
Fixes: 4204eccc7b2a ("ASoC: tegra: Add support for S24_LE audio format")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/tegra/tegra210_adx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra210_adx.c b/sound/soc/tegra/tegra210_adx.c
index 3e6e8f51f380..0aa93b948378 100644
--- a/sound/soc/tegra/tegra210_adx.c
+++ b/sound/soc/tegra/tegra210_adx.c
@@ -264,7 +264,7 @@ static const struct snd_soc_dai_ops tegra210_adx_out_dai_ops = {
 			.rates = SNDRV_PCM_RATE_8000_192000,	\
 			.formats = SNDRV_PCM_FMTBIT_S8 |	\
 				   SNDRV_PCM_FMTBIT_S16_LE |	\
-				   SNDRV_PCM_FMTBIT_S16_LE |	\
+				   SNDRV_PCM_FMTBIT_S24_LE |	\
 				   SNDRV_PCM_FMTBIT_S32_LE,	\
 		},						\
 		.capture = {					\
@@ -274,7 +274,7 @@ static const struct snd_soc_dai_ops tegra210_adx_out_dai_ops = {
 			.rates = SNDRV_PCM_RATE_8000_192000,	\
 			.formats = SNDRV_PCM_FMTBIT_S8 |	\
 				   SNDRV_PCM_FMTBIT_S16_LE |	\
-				   SNDRV_PCM_FMTBIT_S16_LE |	\
+				   SNDRV_PCM_FMTBIT_S24_LE |	\
 				   SNDRV_PCM_FMTBIT_S32_LE,	\
 		},						\
 		.ops = &tegra210_adx_out_dai_ops,		\
-- 
2.48.1


