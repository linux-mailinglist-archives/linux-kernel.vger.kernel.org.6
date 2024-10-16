Return-Path: <linux-kernel+bounces-367176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1699FF80
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B533B254C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016E189BBD;
	Wed, 16 Oct 2024 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwocKubb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2918870D;
	Wed, 16 Oct 2024 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049378; cv=none; b=CcmW2+4wpiIMLqRiDciu4QlO81+ZKUtDdnAcn0BSkVNKrx6yXOLgQipaFQzmPAOdywQdn/OoCD4U5PLRttMl1vNKG1bcikHVnfgvCrLnXRsg9gF3iWiiMIr1ICtW4CajHk9JVqnLXvxf7c93EVrTriuj5Ytf9mjeamjLsziDXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049378; c=relaxed/simple;
	bh=5iP9HtC1kQWNvWEhPvnhX/BLx8sgQFO32QZTth0dpKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djFlLHisdwsZbbCcGorNhq+9sCnXazbFXGqo7kTT4jqb0KmWiKMyp3SW7R3fha8QCmyLihlMmOcjufdCbibWu/ZpQzTz135t7rbIQ2EA5/U/JdVys680q7p/VT+qY4H0dJINbPnl3uJblrqtINC+d+eG6WsUHSBZPl2/WikNWFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwocKubb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049377; x=1760585377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5iP9HtC1kQWNvWEhPvnhX/BLx8sgQFO32QZTth0dpKY=;
  b=HwocKubbOW8bknNq9xDMlgU2JQQF4Nkkcjlf5HabRBT8DBYFWhZx5349
   p20LHXvfcxvHpa13NjDdV6VdAVioVy4Z39seDrQTVv6zOeAkGq0wglbUi
   9oRrNBu63azivJTvLoKdWboi4lJdsUQlatLILcqUcZ6/ITYaBdI5a38xt
   9VFHd74P6JDn4ozBD3Kq3NfcAg3ZkAhd3ILLSBg3MaED58dK19Lf3nA67
   F7mfUQsYEDXFlygbICxbNEXUUvIa0HeM9pKlsVteABu19dpbjnFKzLNYu
   taIUXj9oeO3cPqCJG9tXz1ZuIN46+pI00LZJcl4LXCZF5QkGzdR/whEL8
   Q==;
X-CSE-ConnectionGUID: eEewWZN/QTSDzyzFn0wRbw==
X-CSE-MsgGUID: Y1eDwj7sQTK7W+muuQoMWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28676522"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28676522"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:36 -0700
X-CSE-ConnectionGUID: bVU95W72Q9yBlZSViMZ9ZA==
X-CSE-MsgGUID: F9M7PSCmT2yn7gCt6ls1wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78047703"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:33 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com,
	ranjani.sridharan@linux.intel.com
Subject: [PATCH 4/4] ASoC: SOF: Intel: hda: Always clean up link DMA during stop
Date: Wed, 16 Oct 2024 11:29:10 +0800
Message-ID: <20241016032910.14601-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016032910.14601-1-yung-chuan.liao@linux.intel.com>
References: <20241016032910.14601-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

This is required to reset the DMA read/write pointers when the stream is
prepared and restarted after a call to snd_pcm_drain()/snd_pcm_drop().
Also, now that the stream is reset during stop, do not save LLP registers
in the case of STOP/suspend to avoid erroneous delay reporting.

Link: https://github.com/thesofproject/sof/issues/9502
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai-ops.c | 23 ++++++++++-------------
 sound/soc/sof/intel/hda-dai.c     |  1 +
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai-ops.c b/sound/soc/sof/intel/hda-dai-ops.c
index 484c76147885..92681ca7f24d 100644
--- a/sound/soc/sof/intel/hda-dai-ops.c
+++ b/sound/soc/sof/intel/hda-dai-ops.c
@@ -346,20 +346,21 @@ static int hda_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		snd_hdac_ext_stream_start(hext_stream);
 		break;
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		snd_hdac_ext_stream_clear(hext_stream);
-
 		/*
-		 * Save the LLP registers in case the stream is
-		 * restarting due PAUSE_RELEASE, or START without a pcm
-		 * close/open since in this case the LLP register is not reset
-		 * to 0 and the delay calculation will return with invalid
-		 * results.
+		 * Save the LLP registers since in case of PAUSE the LLP
+		 * register are not reset to 0, the delay calculation will use
+		 * the saved offsets for compensating the delay calculation.
 		 */
 		hext_stream->pplcllpl = readl(hext_stream->pplc_addr + AZX_REG_PPLCLLPL);
 		hext_stream->pplcllpu = readl(hext_stream->pplc_addr + AZX_REG_PPLCLLPU);
+		snd_hdac_ext_stream_clear(hext_stream);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		hext_stream->pplcllpl = 0;
+		hext_stream->pplcllpu = 0;
+		snd_hdac_ext_stream_clear(hext_stream);
 		break;
 	default:
 		dev_err(sdev->dev, "unknown trigger command %d\n", cmd);
@@ -512,7 +513,6 @@ static const struct hda_dai_widget_dma_ops sdw_ipc4_chain_dma_ops = {
 static int hda_ipc3_post_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *cpu_dai,
 				 struct snd_pcm_substream *substream, int cmd)
 {
-	struct hdac_ext_stream *hext_stream = hda_get_hext_stream(sdev, cpu_dai, substream);
 	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(cpu_dai, substream->stream);
 
 	switch (cmd) {
@@ -527,9 +527,6 @@ static int hda_ipc3_post_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *c
 		if (ret < 0)
 			return ret;
 
-		if (cmd == SNDRV_PCM_TRIGGER_STOP)
-			return hda_link_dma_cleanup(substream, hext_stream, cpu_dai);
-
 		break;
 	}
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 8cccf38967e7..ac505c7ad342 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -302,6 +302,7 @@ static int __maybe_unused hda_dai_trigger(struct snd_pcm_substream *substream, i
 	}
 
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		ret = hda_link_dma_cleanup(substream, hext_stream, dai);
 		if (ret < 0) {
-- 
2.43.0


