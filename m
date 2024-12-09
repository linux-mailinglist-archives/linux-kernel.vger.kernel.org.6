Return-Path: <linux-kernel+bounces-437315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9260D9E91AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85568163444
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22034219EB9;
	Mon,  9 Dec 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xhd6RIu8"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA788216614
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742389; cv=none; b=TngFzOwUZeJ47ujvWVxtM2HdOB92Izop5uUu0+55hEFxsVFRwmrNC/8rix4oEpuLnIZdaDB/05pDlADjrJUF9DLlwsUB2BZsw3ZIXJ53VSE1wLxTnqHRuKNTrEH7QR3kQmwmzin2LZzmUE+Z2kNr5W9LcSdnZOy9o1Br4E0N7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742389; c=relaxed/simple;
	bh=sqEbjb89vWAjdb3F55lInvUwtmmq8OUfjJF/BWvS3F4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGUZ+9a5pQ0YhQT0a7pR095dswhGzuPAOTkwOocF/zZQ+2HjtqkXS+Mhv4FJEsytTzoysucrxgQ/jQb5wTNar9hYCZ5iUjhYKhoVfPfveRKrfHW8Er3Yezwq3zq4hGq+UweNqw1kvUARSW2sMgvcA4m3oben6RKrj/JT/0TeYOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xhd6RIu8; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733742384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Bt/Tg56N3ejEPxGoyt26WWJWEYLD2p6ANEZv7IrsyM=;
	b=Xhd6RIu8zfjsnw4PnOMA1T9UJKLxnHwSOM2OPg5G6vP+VSpCnnBiKTSdDGEqOKiOZKyEE2
	KEjYWpoXKIFuJi6WGfe6JzuXRHQAc197LkMCTFw6XHFuBZW62QUwEcJeN05fBIdnnRVwBo
	JpkeHJOUGALVGGXljHWgyMH2/0EXmg8=
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ASoC: SOF: Intel: Use str_yes_no() to improve bdw_dump()
Date: Mon,  9 Dec 2024 12:06:04 +0100
Message-ID: <20241209110606.39853-2-thorsten.blum@linux.dev>
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
index c4d92f3508b6..5282c0071534 100644
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
2.47.1


