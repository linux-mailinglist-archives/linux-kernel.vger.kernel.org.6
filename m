Return-Path: <linux-kernel+bounces-367174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA22499FF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE80E2865D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14BD17622F;
	Wed, 16 Oct 2024 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AU0ZlAcm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BC18660A;
	Wed, 16 Oct 2024 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049371; cv=none; b=N2s2T3jKRjo7XVS4b3N0tELhg9L7DE4+aRElBrRRRbJMBmPgAUC0O9risIacLMFrA8oQKoxkP42UK68pBaKMc3+avLCGenuPwU869wwy5pVYL8w8PGxFPwpHDL7nqKISy547k24kZDBo4jyIdaUjA9hykKKYZAyRtx7tXqX7ouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049371; c=relaxed/simple;
	bh=zUe0gml481yHXpwIeC8XhLuuNu4uRr7bBhyLPhPLgFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6h/CwnpYaYGOTBSss5XwOr3y4QPPlyiGhWVGCRjPIVNtARWQ54iHpIlq86DmKR54k/F6VIgp8PvQB87KtfhP/EsDvIK1m3GvN9CfVxY/OujX0fTRj5kSRu/N+pfEEF4BUeOZKqHXmPJ8MEeHw9tqtzcQoebJc2M94fNEML8ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AU0ZlAcm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049370; x=1760585370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zUe0gml481yHXpwIeC8XhLuuNu4uRr7bBhyLPhPLgFk=;
  b=AU0ZlAcmO2NuokBET7ty8hKlwCRwLzEqKist2kZIHcRWqJUT2k/0oCYJ
   tCFq8VnGqDf6/ALffz//H+u7CveCU1mMhPox61ArnyI0u8LGptDwDGtlk
   S3vq14tLMiXo80ohyvA74KKruGnWBOg5pnhWvL+VTEcbT0fePnPINVNYU
   TdJEBXGkblSvCJ4AI0dZ/vimObxx/G4KlYBYow1//kXy6xDPX21a36PJF
   nHYrOSWHYA5sehR7lMGxN83iYGz9URwCzR+nyH2bVo/AO2TSlGlgv3yHI
   uVkRlJ48Obi4vFsMHB776Tdm8vCSECPz0wjCOYl1rv49o1a2BksbZfL6E
   A==;
X-CSE-ConnectionGUID: nTdQrlLVQ/y2WDKVQPlrnQ==
X-CSE-MsgGUID: 7/lb3oXOQJ2Qagwuy9LOPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28676510"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28676510"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:29 -0700
X-CSE-ConnectionGUID: cc6z6LLkSLifWiQh0j6k6A==
X-CSE-MsgGUID: VDs+mH0BRQKhTfd21PxD9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78047659"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:26 -0700
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
Subject: [PATCH 2/4] ASoC: SOF: Intel: hda: Handle prepare without close for non-HDA DAI's
Date: Wed, 16 Oct 2024 11:29:08 +0800
Message-ID: <20241016032910.14601-3-yung-chuan.liao@linux.intel.com>
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

When a PCM is restarted after a snd_pcm_drain/snd_pcm_drop(), the prepare
callback will be invoked and the hw_params will be set again. For the
HDA DAI's, the hw_params function handles this case already but not for
the non-HDA DAI's. So, add the check for link_prepared to verify if the
hw_params should be done again or not. Additionally, for SDW DAI's reset
the PCMSyCM registers as would be done in the case of a start after a
hw_free.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 36 +++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 1c823f9eea57..8cccf38967e7 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -370,6 +370,13 @@ static int non_hda_dai_hw_params_data(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	sdev = widget_to_sdev(w);
+	hext_stream = ops->get_hext_stream(sdev, cpu_dai, substream);
+
+	/* nothing more to do if the link is already prepared */
+	if (hext_stream && hext_stream->link_prepared)
+		return 0;
+
 	/* use HDaudio stream handling */
 	ret = hda_dai_hw_params_data(substream, params, cpu_dai, data, flags);
 	if (ret < 0) {
@@ -377,7 +384,6 @@ static int non_hda_dai_hw_params_data(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	sdev = widget_to_sdev(w);
 	if (sdev->dspless_mode_selected)
 		return 0;
 
@@ -482,6 +488,31 @@ int sdw_hda_dai_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 	int i;
 
+	ops = hda_dai_get_ops(substream, cpu_dai);
+	if (!ops) {
+		dev_err(cpu_dai->dev, "DAI widget ops not set\n");
+		return -EINVAL;
+	}
+
+	sdev = widget_to_sdev(w);
+	hext_stream = ops->get_hext_stream(sdev, cpu_dai, substream);
+
+	/* nothing more to do if the link is already prepared */
+	if (hext_stream && hext_stream->link_prepared)
+		return 0;
+
+	/*
+	 * reset the PCMSyCM registers to handle a prepare callback when the PCM is restarted
+	 * due to xruns or after a call to snd_pcm_drain/drop()
+	 */
+	ret = hdac_bus_eml_sdw_map_stream_ch(sof_to_bus(sdev), link_id, cpu_dai->id,
+					     0, 0, substream->stream);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "%s:  hdac_bus_eml_sdw_map_stream_ch failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
 	data.dai_index = (link_id << 8) | cpu_dai->id;
 	data.dai_node_id = intel_alh_id;
 	ret = non_hda_dai_hw_params_data(substream, params, cpu_dai, &data, flags);
@@ -490,10 +521,7 @@ int sdw_hda_dai_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ops = hda_dai_get_ops(substream, cpu_dai);
-	sdev = widget_to_sdev(w);
 	hext_stream = ops->get_hext_stream(sdev, cpu_dai, substream);
-
 	if (!hext_stream)
 		return -ENODEV;
 
-- 
2.43.0


