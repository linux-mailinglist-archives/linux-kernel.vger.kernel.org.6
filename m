Return-Path: <linux-kernel+bounces-528269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D784CA4159F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB9C3B468D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EAB20B20A;
	Mon, 24 Feb 2025 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAQXCCWM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50E23F429;
	Mon, 24 Feb 2025 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379526; cv=none; b=BFkbu5ZppPz+tCVv6Mbp3C0FfbebeyxrtgB2dJFG+v4ZpjFjklsCUcpFwq6O7NIksIdxwkXH839eyMY3jlUxSn/mcHFw+c5In9jFHMmnJUikK2cSSPQlw5v7R9lUeMU0HQmoaajEHfoyaJtOI91gxJyLk3vS8ikcS/wpSQL2q3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379526; c=relaxed/simple;
	bh=PpaVG7OGW9rIryTEM6KOlC6XdSpWar7SbjM0gbJn8fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHNOc4IfEF+8o+zCXAZ1y9MPJd5KOkVctbFI//31VZbhq3YwkyG210kk+LmLRlMuJaYKtDmAp21dZs3zeBYngX3xJjUd58hrak0u2w2g9ywLIB7vCd7CnwUKYqd1gDdxTdRjZ6rcZS7EC+RTm4CSH7MhDn5lUiV4GB70Fl6O6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAQXCCWM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379524; x=1771915524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PpaVG7OGW9rIryTEM6KOlC6XdSpWar7SbjM0gbJn8fE=;
  b=XAQXCCWMrxZp1qVDhQYIM9pXSvU3CAriZ4YLsNYZmzMU4wHEzGJR0mzV
   A/MVEf7iQRUhk77OF1SzenAAciiT0m3cJ25Ex/FVTMqDsULrbpnVQ4Das
   46IAty9sKdtQ3IgNaygP+FISGKI4ouuDOaCQmVPscZkt3BGvx+p+cg1zM
   FLnwbz/q+YyXP7wI+EhMlykBkiYJ/vsUav/vECk4N7F0WWtUXKSJVQnnI
   COpwYjPko8g/pubRrYo9oXoLxlKIKbMawm0ViMOv8CBHENDnQVGt+0qhL
   JsqYWN2MeCcBWJPDUaF1NKBYVOf+3YHlIHtGDPvaNkbiIa4cc4DrVPUxH
   w==;
X-CSE-ConnectionGUID: v3i4AYX3R6ePDzWA6t5dqw==
X-CSE-MsgGUID: iNE4jKGmSamkVEEMv/hdwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58538935"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58538935"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:24 -0800
X-CSE-ConnectionGUID: Cfpz7n7BQbevTPzwDronvQ==
X-CSE-MsgGUID: SA+EIPGOQgKR4K62b0iF5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597686"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:22 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 04/16] soundwire: stream: extend sdw_alloc_stream() to take 'type' parameter
Date: Mon, 24 Feb 2025 14:44:38 +0800
Message-ID: <20250224064451.33772-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
References: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
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


