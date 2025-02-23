Return-Path: <linux-kernel+bounces-527947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA1A4118C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E160D3AB75A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2523A987;
	Sun, 23 Feb 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Grn9UCA4"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E916E5383
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740342440; cv=none; b=I7dauiup5pv21tPjIwkKpUyvyhtAlJaDzqNcV9tDTqS7425fjsKte9whqXIJbJFKRC4Z+ujziTE6oss5Eteb0JMoH5SOixggYqDAKAUNGaVDER9R9I549NfC+vYx9MGlaJQNj4h/Idx/w4hxvwG+4DEuKHtfnRTx4OIJ9SqRGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740342440; c=relaxed/simple;
	bh=aSVtieW9RVdJOGDeuNvcbe7wuEnIjpJIvPBzTalgqxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6kQ/LZevbNhEiAjMUltPGlOH2RcOWZRENxj0IjJ8RUOM3UdBaOIxQukqihBEZPqOqHzfrxTC/pothrGeuGP4ZuqevIj5e17cWgvOGB4zjL1AKjU/BO0itWN/rppeygfLoUGf4aC8vGLOs1IKnAF8GL0+Mdov4L4vSOazpEEqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Grn9UCA4; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740342425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0USvQ7FVPeZTKZG3dsxNELU1WFbDxidjBds5ni6CECQ=;
	b=Grn9UCA4xs+RKrV+Wzwvawz+9F+P1A3oivfEgZ0MimJPO+InJAKiaF4yrdaGQLLSZIV3tT
	D2Gqr77bGsfM5CXJYPYf0aDUGtROmioyAWw6Ee3SnVlhiSWagya34aMH5ojE7S+g+5plBE
	Yw+yb1rzV2QsSLJg8fjGwPumGL0Y5K4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Intel: hda-dai: Remove unnecessary bool conversion
Date: Sun, 23 Feb 2025 21:25:45 +0100
Message-ID: <20250223202547.1795-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the unnecessary bool conversion and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/sof/intel/hda-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index da12aabc1bb8..883d0d3bae9e 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -318,7 +318,7 @@ static int __maybe_unused hda_dai_trigger(struct snd_pcm_substream *substream, i
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		ret = hda_link_dma_cleanup(substream, hext_stream, dai,
-					   cmd == SNDRV_PCM_TRIGGER_STOP ? false : true);
+					   cmd != SNDRV_PCM_TRIGGER_STOP);
 		if (ret < 0) {
 			dev_err(sdev->dev, "%s: failed to clean up link DMA\n", __func__);
 			return ret;
-- 
2.48.1


