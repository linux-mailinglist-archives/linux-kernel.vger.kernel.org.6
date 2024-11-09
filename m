Return-Path: <linux-kernel+bounces-402813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB1E9C2CC1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 13:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352D2282D5B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6851922F1;
	Sat,  9 Nov 2024 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ty0SCalG"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A37147C96
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731154429; cv=none; b=X8I/gHwBpoUvJlZwBtZzAgTITFilfRY2VZF0hFpx/PBEDcYMpxGDM0rnfTfsC8t3B3yPE8kDiRtMGPcBUPooukngVvxTe+V9P+6YQ5jb3HfOzTytk6AOgOiy/i7WDqW4JUn+UqX/kCX3SkPnFTad95COLbdAkN6ASibDGZLH7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731154429; c=relaxed/simple;
	bh=cWh/qzqXAxW415ccO/BuzcUXH8VdNUIhUb0UjSbNNq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c86itmY4xCgEgKoVmuD51gtwf+K3RI8kl3id0HePYFAG8ORyU0okzyjnp+E8ZvW+upWdrWvL0iKYBE2X9TG/NZ2EeQAjj4VKkUmFUMoY+zRuWRj0HVN0/Gt5UFHIaPu2TnCkfuXSbSZBCg43q1u3aNmqknhza3jEG+A3NQAiJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ty0SCalG; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731154424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WeYnjmp5IQy0cuWBhqtRjgnSxGgbQpVQhnWsvUVd4RY=;
	b=Ty0SCalGJR4Afx2eJGwZgpQvOe6CVyuUWf3w6XoB59WKDXxYvaB0mL0azofRDAo0dFfGdQ
	bnuyFkD1xiSaMj9eyJQRnfYilq+WnZsNgMdwNqZ3GuLcRxejdn7U1scyF1sbLhc54I6y7G
	o9mBEfEJNVF3XzfROWlhGkeNI+TlcqY=
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
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Intel: Use str_yes_no() to improve bdw_dump()
Date: Sat,  9 Nov 2024 13:12:34 +0100
Message-ID: <20241109121236.39351-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/sof/intel/bdw.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 322ff118f0f6..08ae8ebbd595 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -266,20 +266,20 @@ static void bdw_dump(struct snd_sof_dev *sdev, u32 flags)
 	imrd = snd_sof_dsp_read(sdev, BDW_DSP_BAR, SHIM_IMRD);
 	dev_err(sdev->dev,
 		"error: ipc host -> DSP: pending %s complete %s raw 0x%8.8x\n",
-		(panic & SHIM_IPCX_BUSY) ? "yes" : "no",
-		(panic & SHIM_IPCX_DONE) ? "yes" : "no", panic);
+		str_yes_no(panic & SHIM_IPCX_BUSY),
+		str_yes_no(panic & SHIM_IPCX_DONE), panic);
 	dev_err(sdev->dev,
 		"error: mask host: pending %s complete %s raw 0x%8.8x\n",
-		(imrx & SHIM_IMRX_BUSY) ? "yes" : "no",
-		(imrx & SHIM_IMRX_DONE) ? "yes" : "no", imrx);
+		str_yes_no(imrx & SHIM_IMRX_BUSY),
+		str_yes_no(imrx & SHIM_IMRX_DONE), imrx);
 	dev_err(sdev->dev,
 		"error: ipc DSP -> host: pending %s complete %s raw 0x%8.8x\n",
-		(status & SHIM_IPCD_BUSY) ? "yes" : "no",
-		(status & SHIM_IPCD_DONE) ? "yes" : "no", status);
+		str_yes_no(status & SHIM_IPCD_BUSY),
+		str_yes_no(status & SHIM_IPCD_DONE), status);
 	dev_err(sdev->dev,
 		"error: mask DSP: pending %s complete %s raw 0x%8.8x\n",
-		(imrd & SHIM_IMRD_BUSY) ? "yes" : "no",
-		(imrd & SHIM_IMRD_DONE) ? "yes" : "no", imrd);
+		str_yes_no(imrd & SHIM_IMRD_BUSY),
+		str_yes_no(imrd & SHIM_IMRD_DONE), imrd);
 }
 
 /*
-- 
2.47.0


