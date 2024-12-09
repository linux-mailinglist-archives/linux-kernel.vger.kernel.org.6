Return-Path: <linux-kernel+bounces-438515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D8B9EA21B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B0818885FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423A719F421;
	Mon,  9 Dec 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vo39HsVG"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7219F111
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784372; cv=none; b=MtfDBNz6eeC0z1VJaYxHnftToWHQif0ULYxMVscK29ITnYcTNrbqznWPGyTeeJOMbnrqbJHrJ/Y3KXDmTRyvgwK7wNnkTJ9zuK/O4KGjXKs6X1RamOsUsQq204jxBu0ziXaQ2uJnIeifem3p6waOyFmljqPDaNxUjxCJnPF/Aek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784372; c=relaxed/simple;
	bh=YvS7IlcHII7Ec1Ap2hjO6zIeRNlxDIEarM6QhxpvSmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMYv/VnKO4oGIyp2ksQTSQiOldhqLCrWyJk1DSo1N5YumfwScIJS7sYKs7veDN0yVY2uwhcuw9uC3xmdRRRR8A9wzAEF12bBtgfnuObG+SuxyAeFOFjDJ2I2Rxyhpa8qCqRX3FQQnkU3nMeWp0i6KHrDicV1T/bKE25i9LoW/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vo39HsVG; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733784368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PgE/DJOCaLAqXOezkuTQtuZKY8OjvgD1FJlU8+ERQyw=;
	b=Vo39HsVGSBVL3vs6jFvqdT4e4mmeLAwmDrv1llJ1nzrgviYskf2+tHxu+mn9xsPEZ1yveT
	qsdAAW1Mf2SWPTfiufc8A0bLROtNdwRinlXHqfeTgWsWMXb4EGRTRYiFCPIMt0IMYg+k3w
	/+jplCvxXa5GoNfLPeppWyjPYgBud8E=
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
	Greg KH <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Intel: Use str_yes_no() helper in atom_dump()
Date: Mon,  9 Dec 2024 23:45:18 +0100
Message-ID: <20241209224521.100450-2-thorsten.blum@linux.dev>
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
 sound/soc/sof/intel/atom.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/atom.c b/sound/soc/sof/intel/atom.c
index 30e981c558c6..0d364bcdcfa9 100644
--- a/sound/soc/sof/intel/atom.c
+++ b/sound/soc/sof/intel/atom.c
@@ -78,20 +78,20 @@ void atom_dump(struct snd_sof_dev *sdev, u32 flags)
 	imrd = snd_sof_dsp_read64(sdev, DSP_BAR, SHIM_IMRD);
 	dev_err(sdev->dev,
 		"error: ipc host -> DSP: pending %s complete %s raw 0x%llx\n",
-		(panic & SHIM_IPCX_BUSY) ? "yes" : "no",
-		(panic & SHIM_IPCX_DONE) ? "yes" : "no", panic);
+		str_yes_no(panic & SHIM_IPCX_BUSY),
+		str_yes_no(panic & SHIM_IPCX_DONE), panic);
 	dev_err(sdev->dev,
 		"error: mask host: pending %s complete %s raw 0x%llx\n",
-		(imrx & SHIM_IMRX_BUSY) ? "yes" : "no",
-		(imrx & SHIM_IMRX_DONE) ? "yes" : "no", imrx);
+		str_yes_no(imrx & SHIM_IMRX_BUSY),
+		str_yes_no(imrx & SHIM_IMRX_DONE), imrx);
 	dev_err(sdev->dev,
 		"error: ipc DSP -> host: pending %s complete %s raw 0x%llx\n",
-		(status & SHIM_IPCD_BUSY) ? "yes" : "no",
-		(status & SHIM_IPCD_DONE) ? "yes" : "no", status);
+		str_yes_no(status & SHIM_IPCD_BUSY),
+		str_yes_no(status & SHIM_IPCD_DONE), status);
 	dev_err(sdev->dev,
 		"error: mask DSP: pending %s complete %s raw 0x%llx\n",
-		(imrd & SHIM_IMRD_BUSY) ? "yes" : "no",
-		(imrd & SHIM_IMRD_DONE) ? "yes" : "no", imrd);
+		str_yes_no(imrd & SHIM_IMRD_BUSY),
+		str_yes_no(imrd & SHIM_IMRD_DONE), imrd);
 
 }
 EXPORT_SYMBOL_NS(atom_dump, "SND_SOC_SOF_INTEL_ATOM_HIFI_EP");
-- 
2.47.1


