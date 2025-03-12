Return-Path: <linux-kernel+bounces-558080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA10A5E164
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C49C3AF756
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325F31B85FD;
	Wed, 12 Mar 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4BmwvNj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769818D643;
	Wed, 12 Mar 2025 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795527; cv=none; b=HDA0dAv7CrvWLPYW+eZowKwd3Y6n7iQpMkvxaGoVpHuYMe8Ub66giRvQmlY9z6fgCCspIhVaY8gCQGLqxQ9aVpX8cURup8VwNNtps7J7JC7pUIAxGz6ti8OBlNYFxRoUTDvDVvo2ZtZrJoyIZsp1Amz//YbD17fOzo37uH37yKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795527; c=relaxed/simple;
	bh=tJ/nhHfV0CVrnMQlUMw1ESbGNGb5q3D5vrP/VNuW0Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mSSRLdxXRDlUTJ6/slRPWITv5Wp1CcHA53Gv5b9ygHXeFSzKpGw3icmNg+eYQFWql+L/JYTiy/9xMMb9+sZ0qZOjcdO09wcbMro+pXcfbM+y/67RXk359M32ZpKCjgDfO1lBCaBuJEqJEdH6x6ocXDEgBlWhdTiYm+Huupe0+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4BmwvNj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741795527; x=1773331527;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tJ/nhHfV0CVrnMQlUMw1ESbGNGb5q3D5vrP/VNuW0Cg=;
  b=T4BmwvNjC53NvGU1VPVAnrAWi0lKml6Tub5KMKuzmCY9hw4iz8I1nzyR
   pz4F4W+t/8VlKU69skybUdYNqGD3LeGekPySze5DV2iviC2am1ftBlkZS
   ZULalAV0P9EmcBZRFjpu+0oQr5521SAIxYkSexBdofAJXnKwXOKfEwini
   F+7RLjG3aZLYRY+BOQYiuSHBhhYtHM6xdLRGb51WQRRekRtD05K588cL7
   DF/zETk6k3JJVhA+IwjXbMeg/hoM0BjLDSSnK3MBJKBs9wkk788laTjuc
   qH6tcctLg4DUnTEvD1ef7AlObmxhdiPW5LNrIVhc5bnSU82ElHy+lJtBV
   A==;
X-CSE-ConnectionGUID: ndHw4wIgSNWswT85ol5nrA==
X-CSE-MsgGUID: Ssf7/E9jRU+zTu+UFaxqaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42991874"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42991874"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 09:05:26 -0700
X-CSE-ConnectionGUID: /KSqFaw3RBigt8LNBjfZQw==
X-CSE-MsgGUID: Qw1McBJaRBW0ZazJlQjESA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="124836067"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 12 Mar 2025 09:05:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D20FC1F2; Wed, 12 Mar 2025 18:05:19 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ASoC: SOF: ipc4-topology: Allocate ref_params on stack
Date: Wed, 12 Mar 2025 18:05:16 +0200
Message-ID: <20250312160516.3864295-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the compiler (clang 19.1.7) is not happy about the size of
the stack frame in sof_ipc4_prepare_copier_module:

sound/soc/sof/ipc4-topology.c:1800:1: error: stack frame size (1288) exceeds limit (1024) in 'sof_ipc4_prepare_copier_module' [-Werror,-Wframe-larger-than]
 1800 | sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
      | ^

Work around this by allocating ref_params on stack, as it looks the biggest
variable on stack right now.

Note, this only happens when compile for 32-bit machines (x86_32 in my case).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 6d5cda813e48..41110ee6edc7 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -7,6 +7,7 @@
 //
 //
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <uapi/sound/sof/tokens.h>
 #include <sound/pcm_params.h>
 #include <sound/sof/ext_manifest4.h>
@@ -1807,8 +1808,8 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct sof_ipc4_copier_data *copier_data;
 	int input_fmt_index, output_fmt_index;
-	struct snd_pcm_hw_params ref_params;
 	struct sof_ipc4_copier *ipc4_copier;
+	struct snd_pcm_hw_params *ref_params __free(kfree) = NULL;
 	struct snd_sof_dai *dai;
 	u32 gtw_cfg_config_length;
 	u32 dma_config_tlv_size = 0;
@@ -1884,9 +1885,11 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 		 * for capture.
 		 */
 		if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-			ref_params = *fe_params;
+			ref_params = kmemdup(fe_params, sizeof(*ref_params), GFP_KERNEL);
 		else
-			ref_params = *pipeline_params;
+			ref_params = kmemdup(pipeline_params, sizeof(*ref_params), GFP_KERNEL);
+		if (!ref_params)
+			return -ENOMEM;
 
 		copier_data->gtw_cfg.node_id &= ~SOF_IPC4_NODE_INDEX_MASK;
 		copier_data->gtw_cfg.node_id |=
@@ -1919,8 +1922,11 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 		 * In case of capture the ref_params returned will be used to
 		 * find the input configuration of the copier.
 		 */
-		ref_params = *fe_params;
-		ret = sof_ipc4_prepare_dai_copier(sdev, dai, &ref_params, dir);
+		ref_params = kmemdup(fe_params, sizeof(*ref_params), GFP_KERNEL);
+		if (!ref_params)
+			return -ENOMEM;
+
+		ret = sof_ipc4_prepare_dai_copier(sdev, dai, ref_params, dir);
 		if (ret < 0)
 			return ret;
 
@@ -1929,7 +1935,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 		 * input configuration of the copier.
 		 */
 		if (dir == SNDRV_PCM_STREAM_PLAYBACK)
-			ref_params = *pipeline_params;
+			memcpy(ref_params, pipeline_params, sizeof(*ref_params));
 
 		break;
 	}
@@ -1938,7 +1944,10 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 		ipc4_copier = (struct sof_ipc4_copier *)swidget->private;
 		copier_data = &ipc4_copier->data;
 		available_fmt = &ipc4_copier->available_fmt;
-		ref_params = *pipeline_params;
+
+		ref_params = kmemdup(pipeline_params, sizeof(*ref_params), GFP_KERNEL);
+		if (!ref_params)
+			return -ENOMEM;
 
 		break;
 	}
@@ -1951,7 +1960,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 	/* set input and output audio formats */
 	input_fmt_index = sof_ipc4_init_input_audio_fmt(sdev, swidget,
 							&copier_data->base_config,
-							&ref_params, available_fmt);
+							ref_params, available_fmt);
 	if (input_fmt_index < 0)
 		return input_fmt_index;
 
-- 
2.47.2


