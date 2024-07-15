Return-Path: <linux-kernel+bounces-252239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A9C931062
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972B21F21EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A25918EFF7;
	Mon, 15 Jul 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDggX+Tt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E172186E4F;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032805; cv=none; b=itCHPj5McSPdMp8nV/eJEQ8PZFb731QKy6odKG12Jz2soZNgPmTbxfZRjp6XMGfWEEz7kqV6RVgAMUh2d94QfMjLcaHY7M2uoFVRJXTTd7Vxpb2JBX290ZQKfcUmTkVgGyNOqAMvlz46eWZhnWINgXvKQ/vqs/zacX/pHRHLVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032805; c=relaxed/simple;
	bh=tBkZbYGVVOZU5vTFJf/4Hx9sKzgEywOUrQAiC76tePA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPxZXsF1oSKndPnRtJIcxXZzCaJDqVmHRqkkP7ip0s8MdjAQoDmDlEBFtSxCt8EcQx09oKmaahRO7viImtertVltIe4DfugFRCHD53Hvmb0PL5KLowZr5a5WfpKb9fbpPKbvvQRb8c0Guc5q8155naVPom2q0mgLuczYRDqk76A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDggX+Tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 982B3C4AF1C;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032804;
	bh=tBkZbYGVVOZU5vTFJf/4Hx9sKzgEywOUrQAiC76tePA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WDggX+TtBwPmhUk1hFUDpRfiqtd766mIn/3ywGz3gzs9+Q/kAg8zDU0/Rne1H6zAd
	 SdeAqk111QGQbwjZgZNh6xauDqiK6syPmwYXpBLhzSCaTswfP5GfC7Txs6M2ujPIJE
	 PF9bQA290ljJHL5hoSg20KKSPawrUijA5KwpS9tJEgYhcucWmCe3Fd4sJlBIpEssz+
	 wnbFQ1TQ+ayfsCCKW3XH1rKBkegy0x20lPVnDcjB5M5J0Z08DNhJAMhaJ3rpgQ+iCs
	 2d5Ef5wsH/2KsfWCzwTlPtON21R3zMT/E8YsknTdCzpl8GpGfPz/wdIFhJP8P/u4+d
	 3uoKk50TtOREg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFA5C3DA5B;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:32 +0300
Subject: [PATCH v11 28/38] ASoC: ep93xx: Drop legacy DMA support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-ep93xx-v11-28-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032799; l=3001;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=SYU0FfCpDAQ8R3Z8Qf0jhP48bWMjlrK6VfAOntLJB4w=;
 b=LcOcjqItH0H/4lcxXM39N8SahQf4nAfn5o6ncX4TJE69n3SZW4wTsqQc5mpY3Zol55cdxybCTwB3
 VbdRGaYqDC++Vj+vU+UoTnnEB+dqwu/Yj4B1xg9DB7ZEfgd8DJAd
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

And rely on OF DMA.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 sound/soc/cirrus/ep93xx-i2s.c | 19 -------------------
 sound/soc/cirrus/ep93xx-pcm.c | 19 +------------------
 2 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 522de4b80293..9e83cdf8a943 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -24,7 +24,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
 #include <linux/soc/cirrus/ep93xx.h>
 
 #include "ep93xx-pcm.h"
@@ -80,19 +79,6 @@ struct ep93xx_i2s_info {
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
 
-static struct ep93xx_dma_data ep93xx_i2s_dma_data[] = {
-	[SNDRV_PCM_STREAM_PLAYBACK] = {
-		.name		= "i2s-pcm-out",
-		.port		= EP93XX_DMA_I2S1,
-		.direction	= DMA_MEM_TO_DEV,
-	},
-	[SNDRV_PCM_STREAM_CAPTURE] = {
-		.name		= "i2s-pcm-in",
-		.port		= EP93XX_DMA_I2S1,
-		.direction	= DMA_DEV_TO_MEM,
-	},
-};
-
 static inline void ep93xx_i2s_write_reg(struct ep93xx_i2s_info *info,
 					unsigned reg, unsigned val)
 {
@@ -198,11 +184,6 @@ static int ep93xx_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 
-	info->dma_params_tx.filter_data =
-		&ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_PLAYBACK];
-	info->dma_params_rx.filter_data =
-		&ep93xx_i2s_dma_data[SNDRV_PCM_STREAM_CAPTURE];
-
 	snd_soc_dai_init_dma_data(dai,	&info->dma_params_tx,
 					&info->dma_params_rx);
 
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index fa72acd8d334..5ecb4671cbba 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -18,8 +18,6 @@
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
-#include <linux/platform_data/dma-ep93xx.h>
-
 #include "ep93xx-pcm.h"
 
 static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
@@ -35,30 +33,15 @@ static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
 	.fifo_size		= 32,
 };
 
-static bool ep93xx_pcm_dma_filter(struct dma_chan *chan, void *filter_param)
-{
-	struct ep93xx_dma_data *data = filter_param;
-
-	if (data->direction == ep93xx_dma_chan_direction(chan)) {
-		chan->private = data;
-		return true;
-	}
-
-	return false;
-}
-
 static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config = {
 	.pcm_hardware = &ep93xx_pcm_hardware,
-	.compat_filter_fn = ep93xx_pcm_dma_filter,
 	.prealloc_buffer_size = 131072,
 };
 
 int devm_ep93xx_pcm_platform_register(struct device *dev)
 {
 	return devm_snd_dmaengine_pcm_register(dev,
-		&ep93xx_dmaengine_pcm_config,
-		SND_DMAENGINE_PCM_FLAG_NO_DT |
-		SND_DMAENGINE_PCM_FLAG_COMPAT);
+		&ep93xx_dmaengine_pcm_config, 0);
 }
 EXPORT_SYMBOL_GPL(devm_ep93xx_pcm_platform_register);
 

-- 
2.43.2



