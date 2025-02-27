Return-Path: <linux-kernel+bounces-536105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23202A47B98
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BD63A6F79
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9D22C32D;
	Thu, 27 Feb 2025 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMjjukS2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EBA22CBE4;
	Thu, 27 Feb 2025 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654712; cv=none; b=gdcQ8PVLEqHpp7rfVF8TBvPQokdnFpnysK3wvoLwXZvyZR/TgjB8lonBi6r5Ne5odnvQHDsbPKvBJC5mpTv85rfnkl0EiKErB+Cb44bkEgvnzcJuMVvK/MSCgzNtua4aK5nLuBQm8zOIeH60kAiqQrwyoACScq8rFuFSYdXxJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654712; c=relaxed/simple;
	bh=PpaVG7OGW9rIryTEM6KOlC6XdSpWar7SbjM0gbJn8fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgHYh9V4p3NgjHbL7/ld4Ca/hVQZOAMQVlpE/sSQ8HzUlqzq4bqqxsXQqhac6M4brtXCloCkfI/IyhkXN/VAMR4cmthKJy2HPJJU6t45PpGuWQ3tf20qbSo8iHMam7TT1RsK3i3yluo5zg/Usdlo7p9ratwDaXyPAUFL2TuNqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMjjukS2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654711; x=1772190711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PpaVG7OGW9rIryTEM6KOlC6XdSpWar7SbjM0gbJn8fE=;
  b=DMjjukS2jhpSwD9jjGIPhuZEyTDcRls8/gnGhd2Cg03FoYk2HnYtstiE
   9okM1Z1medyNAbHeg/5rfrizRWwH46lgQASYo9GPYQeptX0IOfdRB0sa2
   BnOfpMm7E3pBd35ZU0SrJHuJt6QK2lX/Hod7jhSrtTZx8ahgTWHyXrzce
   TkUWtIcRlDevM8efQTUeFenVWlQC7eCjOMGkE29p1oAgRRt2ZA7MWh/xM
   0EVF0us4qdv43Rr+4G/IDq/Va5EsUOvXa8RdolmaYsmhAvfly4YWCTFBx
   7JDKHUdOaWFmcG+wBPo/+rb2hvO4ycLvZ9FgmlCGcM2I/VKFnqfNABdxp
   w==;
X-CSE-ConnectionGUID: o9NcVusdQnGKUbJQzhJZwg==
X-CSE-MsgGUID: dKDiH1gaR2CmbCSO+Tvkbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189811"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189811"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:50 -0800
X-CSE-ConnectionGUID: PlqV0sKlSOuwdJ0lZi45Zg==
X-CSE-MsgGUID: ccw6hdqrSki8dzm07gihTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154178940"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:48 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 04/16] soundwire: stream: extend sdw_alloc_stream() to take 'type' parameter
Date: Thu, 27 Feb 2025 19:11:17 +0800
Message-ID: <20250227111130.272698-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
References: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

In the existing definition of sdw_stream_runtime, the 'type' member is
never set and defaults to PCM. To prepare for the BPT/BRA support, we
need to special-case streams and make use of the 'type'.

No functional change for now, the implicit PCM type is now explicit.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 Documentation/driver-api/soundwire/stream.rst | 2 +-
 drivers/soundwire/stream.c                    | 6 ++++--
 include/linux/soundwire/sdw.h                 | 2 +-
 sound/soc/qcom/sdw.c                          | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
index 2a794484f62c..d66201299633 100644
--- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -291,7 +291,7 @@ per stream. From ASoC DPCM framework, this stream state maybe linked to
 
 .. code-block:: c
 
-  int sdw_alloc_stream(char * stream_name);
+  int sdw_alloc_stream(char * stream_name, enum sdw_stream_type type);
 
 The SoundWire core provides a sdw_startup_stream() helper function,
 typically called during a dailink .startup() callback, which performs
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index dd8de88d8b46..ae6d1c767ab9 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1806,12 +1806,13 @@ static int set_stream(struct snd_pcm_substream *substream,
  * sdw_alloc_stream() - Allocate and return stream runtime
  *
  * @stream_name: SoundWire stream name
+ * @type: stream type (could be PCM ,PDM or BPT)
  *
  * Allocates a SoundWire stream runtime instance.
  * sdw_alloc_stream should be called only once per stream. Typically
  * invoked from ALSA/ASoC machine/platform driver.
  */
-struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name)
+struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name, enum sdw_stream_type type)
 {
 	struct sdw_stream_runtime *stream;
 
@@ -1823,6 +1824,7 @@ struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name)
 	INIT_LIST_HEAD(&stream->master_list);
 	stream->state = SDW_STREAM_ALLOCATED;
 	stream->m_rt_count = 0;
+	stream->type = type;
 
 	return stream;
 }
@@ -1851,7 +1853,7 @@ int sdw_startup_stream(void *sdw_substream)
 	if (!name)
 		return -ENOMEM;
 
-	sdw_stream = sdw_alloc_stream(name);
+	sdw_stream = sdw_alloc_stream(name, SDW_STREAM_PCM);
 	if (!sdw_stream) {
 		dev_err(rtd->dev, "alloc stream failed for substream DAI %s\n", substream->name);
 		ret = -ENOMEM;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 857b670eb9a5..ba58e2a52322 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1019,7 +1019,7 @@ struct sdw_bus {
 	unsigned int lane_used_bandwidth[SDW_MAX_LANES];
 };
 
-struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name);
+struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name, enum sdw_stream_type type);
 void sdw_release_stream(struct sdw_stream_runtime *stream);
 
 int sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream);
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index f2eda2ff46c0..875da4adb1d7 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -27,7 +27,7 @@ int qcom_snd_sdw_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *codec_dai;
 	int ret, i;
 
-	sruntime = sdw_alloc_stream(cpu_dai->name);
+	sruntime = sdw_alloc_stream(cpu_dai->name, SDW_STREAM_PCM);
 	if (!sruntime)
 		return -ENOMEM;
 
-- 
2.43.0


