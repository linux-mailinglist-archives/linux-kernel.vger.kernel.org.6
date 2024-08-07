Return-Path: <linux-kernel+bounces-277509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA17D94A255
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74556282E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC21B86C9;
	Wed,  7 Aug 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXOjVuXY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1E1917F1;
	Wed,  7 Aug 2024 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017791; cv=none; b=b5T9Zz3IVmKLmkubeBpGPX3tjcfA7w7YnKiVHq0y/j9wtHP/8amIXIApMw7rOYS2UC+5yCKUoo3OP04qRVAxNV8OnsOMwMZBE4MnANhNEaid3NGtJLpPpyRP6ag0la5sRE6zOWXAT3xjBJbJsVUUhdC7RpltPfhrSZ6KhhTSDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017791; c=relaxed/simple;
	bh=QLoeyfbr6ACoE9T0you1YuvKuNhANsEAcuxwVoYWnQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8DzQ/u5BYLqv1aL7fxk9ZUfgksibVBNIvmalTvDxkd6HMiTdVqm6h1lAUxxUI+emQ+2xSos91hiHXSOSPPaMsvIrNZSdet6l/ncGn341XKd8QGLzBVOkLiqQOmoJ+K7l8PEjzO1/i+uzjOAu5rki/21JieMYkZRRZZTWUpZr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXOjVuXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FC0C32782;
	Wed,  7 Aug 2024 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723017789;
	bh=QLoeyfbr6ACoE9T0you1YuvKuNhANsEAcuxwVoYWnQw=;
	h=From:To:Cc:Subject:Date:From;
	b=AXOjVuXYUNFqaeafp3VLK4e5ZPIAfDLvgZIYrA7Mt8fAJo3jQzegObONgXwcdS504
	 iDZrwFTpzohJB6pikcszN3rN95wLSp3gGGnEtr9WnMZYXHa5os/kluO3yM6nKIHUlp
	 tqscp/9scfBWR42ItGSCHZzOAzSy35UGZ4lgvlHooW90orlp9TLtA53PqKuxcL6uDf
	 N0odeqfavQoQchnVoP4fpZdqb/DPTfPE7UHL8e5ko5B9qfR7ATefIH2ea2oBCNXbbU
	 5ILpVw9OluXJTyZugacWS0++LFu5XsX6Dzrs0sldwnHMysls9a08e8/WxbOP+sdu/3
	 M0991xP8mOPcw==
From: Arnd Bergmann <arnd@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Brent Lu <brent.lu@intel.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] sound: sof: ioc4-topology: avoid extra dai_params copy
Date: Wed,  7 Aug 2024 10:02:27 +0200
Message-Id: <20240807080302.2372297-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The snd_pcm_hw_params structure is really too large to fit on the
stack. Because of the way that clang inlines functions, it ends up
twice in one function, which exceeds the 1024 byte limit for 32-bit
architecutes:

sound/soc/sof/ipc4-topology.c:1700:1: error: stack frame size (1304) exceeds limit (1024) in 'sof_ipc4_prepare_copier_module' [-Werror,-Wframe-larger-than]
sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,

From what I can tell, this was unintentional, as both
sof_ipc4_prepare_dai_copier() and sof_ipc4_prepare_copier_module() make a
copy for the same purpose, but copying it once has the exact same effect.

Remove the extra copy and change the direct struct assignment to
an explicit memcpy() call to make it clearer to the reader that this
is what happens. Note that gcc treats struct assignment as a memcpy()
that may be inlined anyway, so the resulting object code is the same.

Fixes: f9209644ae76 ("ASoC: SOF: ipc4-topology: Correct DAI copier config and NHLT blob request")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sof/ipc4-topology.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 87be7f16e8c2..77f6850010f6 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1651,7 +1651,6 @@ sof_ipc4_prepare_dai_copier(struct snd_sof_dev *sdev, struct snd_sof_dai *dai,
 			    struct snd_pcm_hw_params *params, int dir)
 {
 	struct sof_ipc4_available_audio_format *available_fmt;
-	struct snd_pcm_hw_params dai_params = *params;
 	struct sof_ipc4_copier_data *copier_data;
 	struct sof_ipc4_pin_format *pin_fmts;
 	struct sof_ipc4_copier *ipc4_copier;
@@ -1676,7 +1675,7 @@ sof_ipc4_prepare_dai_copier(struct snd_sof_dev *sdev, struct snd_sof_dai *dai,
 		num_pin_fmts = available_fmt->num_input_formats;
 	}
 
-	ret = sof_ipc4_adjust_params_to_dai_format(sdev, &dai_params, pin_fmts,
+	ret = sof_ipc4_adjust_params_to_dai_format(sdev, params, pin_fmts,
 						   num_pin_fmts);
 	if (ret)
 		return ret;
@@ -1684,15 +1683,11 @@ sof_ipc4_prepare_dai_copier(struct snd_sof_dev *sdev, struct snd_sof_dai *dai,
 	single_bitdepth = sof_ipc4_copier_is_single_bitdepth(sdev, pin_fmts,
 							     num_pin_fmts);
 	ret = snd_sof_get_nhlt_endpoint_data(sdev, dai, single_bitdepth,
-					     &dai_params,
+					     params,
 					     ipc4_copier->dai_index,
 					     ipc4_copier->dai_type, dir,
 					     &ipc4_copier->copier_config,
 					     &copier_data->gtw_cfg.config_length);
-	/* Update the params to reflect the changes made in this function */
-	if (!ret)
-		*params = dai_params;
-
 	return ret;
 }
 
@@ -1784,9 +1779,9 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 		 * for capture.
 		 */
 		if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-			ref_params = *fe_params;
+			memcpy(&ref_params, fe_params, sizeof(ref_params));
 		else
-			ref_params = *pipeline_params;
+			memcpy(&ref_params, pipeline_params, sizeof(ref_params));
 
 		copier_data->gtw_cfg.node_id &= ~SOF_IPC4_NODE_INDEX_MASK;
 		copier_data->gtw_cfg.node_id |=
@@ -1819,7 +1814,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 		 * In case of capture the ref_params returned will be used to
 		 * find the input configuration of the copier.
 		 */
-		ref_params = *fe_params;
+		memcpy(&ref_params, fe_params, sizeof(ref_params));
 		ret = sof_ipc4_prepare_dai_copier(sdev, dai, &ref_params, dir);
 		if (ret < 0)
 			return ret;
@@ -1829,7 +1824,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 		 * input configuration of the copier.
 		 */
 		if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-			ref_params = *pipeline_params;
+			memcpy(&ref_params, pipeline_params, sizeof(ref_params));
 
 		break;
 	}
@@ -1838,7 +1833,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 		ipc4_copier = (struct sof_ipc4_copier *)swidget->private;
 		copier_data = &ipc4_copier->data;
 		available_fmt = &ipc4_copier->available_fmt;
-		ref_params = *pipeline_params;
+		memcpy(&ref_params, pipeline_params, sizeof(ref_params));
 
 		break;
 	}
-- 
2.39.2


