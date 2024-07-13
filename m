Return-Path: <linux-kernel+bounces-251383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D6F930446
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92B31C21409
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 07:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BE92E639;
	Sat, 13 Jul 2024 07:35:29 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B639FC1;
	Sat, 13 Jul 2024 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720856128; cv=none; b=rMhrzTcPsrwQzITtOZVO4ehlK1PYAzerJjEqw33l8mEiHxEQvkC2fW6CMwAuSnoT6Rru9uf49qLIhuZrCKL6CTe9ahCGkcMfv0MtxY1RPzgD8VjjROxkTA3qw7RsaCwSSKibmQoUR4dTNC/Ln7yS/Juf4Essnlq1q9E4zvKcsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720856128; c=relaxed/simple;
	bh=+H4Ybg8THbDCJSYLLE9r60UwCZ0jW4g/J7RJ1WodwqQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ruWVwt1VAr2ohHoVvEmjnYE6GZaIyUfZm3gSG5XeLHKU/F51aQ/SFKaXswyb8RZIByJ08JrD1g7lLCOazh+tzPR89Jek/sbiCijV2f9jqLF3okvshO6t+I1c21wj5Qd6huRMiZzUz+2hUIrupunNqZ9SAJozkMfebxjSYegUiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566922e2fc23-43c24;
	Sat, 13 Jul 2024 15:35:14 +0800 (CST)
X-RM-TRANSID:2ee566922e2fc23-43c24
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866922e2935b-6eecd;
	Sat, 13 Jul 2024 15:35:14 +0800 (CST)
X-RM-TRANSID:2ee866922e2935b-6eecd
From: tangbin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: loongson: Remove useless variable definitions
Date: Sat, 13 Jul 2024 11:34:28 -0400
Message-Id: <20240713153428.44858-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In the function loongson_pcm_trigger and loongson_pcm_open,
the 'ret' is useless, so remove it to simplify code.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 sound/soc/loongson/loongson_dma.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/loongson/loongson_dma.c b/sound/soc/loongson/loongson_dma.c
index 4fcc28681..0238f88bc 100644
--- a/sound/soc/loongson/loongson_dma.c
+++ b/sound/soc/loongson/loongson_dma.c
@@ -95,7 +95,6 @@ static int loongson_pcm_trigger(struct snd_soc_component *component,
 	struct device *dev = substream->pcm->card->dev;
 	void __iomem *order_reg = prtd->dma_data->order_addr;
 	u64 val;
-	int ret = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -129,7 +128,7 @@ static int loongson_pcm_trigger(struct snd_soc_component *component,
 		return -EINVAL;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int loongson_pcm_hw_params(struct snd_soc_component *component,
@@ -230,7 +229,6 @@ static int loongson_pcm_open(struct snd_soc_component *component,
 	struct snd_card *card = substream->pcm->card;
 	struct loongson_runtime_data *prtd;
 	struct loongson_dma_data *dma_data;
-	int ret;
 
 	/*
 	 * For mysterious reasons (and despite what the manual says)
@@ -252,20 +250,17 @@ static int loongson_pcm_open(struct snd_soc_component *component,
 	prtd->dma_desc_arr = dma_alloc_coherent(card->dev, PAGE_SIZE,
 						&prtd->dma_desc_arr_phy,
 						GFP_KERNEL);
-	if (!prtd->dma_desc_arr) {
-		ret = -ENOMEM;
+	if (!prtd->dma_desc_arr)
 		goto desc_err;
-	}
+
 	prtd->dma_desc_arr_size = PAGE_SIZE / sizeof(*prtd->dma_desc_arr);
 
 	prtd->dma_pos_desc = dma_alloc_coherent(card->dev,
 						sizeof(*prtd->dma_pos_desc),
 						&prtd->dma_pos_desc_phy,
 						GFP_KERNEL);
-	if (!prtd->dma_pos_desc) {
-		ret = -ENOMEM;
+	if (!prtd->dma_pos_desc)
 		goto pos_err;
-	}
 
 	dma_data = snd_soc_dai_get_dma_data(snd_soc_rtd_to_cpu(rtd, 0), substream);
 	prtd->dma_data = dma_data;
@@ -279,7 +274,7 @@ static int loongson_pcm_open(struct snd_soc_component *component,
 desc_err:
 	kfree(prtd);
 
-	return ret;
+	return -ENOMEM;
 }
 
 static int loongson_pcm_close(struct snd_soc_component *component,
-- 
2.18.4




