Return-Path: <linux-kernel+bounces-254784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D85F93378D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484611F21857
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845018641;
	Wed, 17 Jul 2024 07:03:34 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF71862A;
	Wed, 17 Jul 2024 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199813; cv=none; b=F6dedco1Mg6k9i9uJS+GT89EJ6Bc+LloySjauEUQda3iUN+W4R1EaVqMZmw5TBewMKJT8Wj8P9oDcc44hXMUM7tvyNNMphJtpLPOpxBW4gkPzE6aP2j2ADvVlj2YeoDaMVdjyEI6VMfPlyshH/IGZCTVnG9hmv7d0YDYlRH0X0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199813; c=relaxed/simple;
	bh=hJvvScmhIqGJyC3XUqfGf9ZhzNYQ9GAhIcMvzBgGxW4=;
	h=From:To:Subject:Date:Message-Id; b=uSStgWBTBykK8h++5IMKHhmVq5kkFSd+U7f/KOG7KLz5OjhBUPr3+EIHFKLNAAK53eADQhbEIyrYqWR/VRWo9kqFa56lMMQ2XqG9snSLbpLOHaiaSxxZNBQ+BDdc+M/Nlo1CG+BKwUTeP/PTywiZ2LLeTbr2vpt7HPQ0kJgjLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 507BF1A1C27;
	Wed, 17 Jul 2024 09:03:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 190061A1C1C;
	Wed, 17 Jul 2024 09:03:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 15968183AD09;
	Wed, 17 Jul 2024 15:03:24 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lars@metafoo.de,
	perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	shengjiu.wang@gmail.com
Subject: [PATCH] ALSA: pcm_dmaengine: Don't synchronize DMA channel when DMA is paused
Date: Wed, 17 Jul 2024 14:44:53 +0800
Message-Id: <1721198693-27636-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When suspended, the DMA channel may enter PAUSE state if dmaengine_pause()
is supported by DMA.
At this state, dmaengine_synchronize() should not be called, otherwise
the DMA channel can't be resumed successfully.

Fixes: e8343410ddf0 ("ALSA: dmaengine: Synchronize dma channel after drop()")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/core/pcm_dmaengine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index b54336d4bffc..b134a51b3fd5 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -352,8 +352,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
 int snd_dmaengine_pcm_sync_stop(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct dma_tx_state state;
+	enum dma_status status;
 
-	dmaengine_synchronize(prtd->dma_chan);
+	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
+	if (status != DMA_PAUSED)
+		dmaengine_synchronize(prtd->dma_chan);
 
 	return 0;
 }
-- 
2.34.1


