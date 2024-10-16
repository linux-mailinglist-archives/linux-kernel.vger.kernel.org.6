Return-Path: <linux-kernel+bounces-367175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C6099FF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5722866D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D40017BEA4;
	Wed, 16 Oct 2024 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfUmYMPS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F6187877;
	Wed, 16 Oct 2024 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049374; cv=none; b=besFlD0pEClCpD4HTlU2O3A3JcD52UGzNbDZ1FTDBfPs9wQatLzk3F52j40Z7y+YjYAJGi4LRpkbVq7DyByT1q5E2eDGAH/1C6eV3I2kzPsd8Maw6UfyvEO5vJleFTmnAm7YcsPn7PCSuGyW3O25B01wVQ/t4fwLNJ0v97E4jQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049374; c=relaxed/simple;
	bh=ipVGNE72HnzLuRj6oepdeobbxw/astyo5Dsj0YhhbLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6PqtlP2soZGYGwnb6vcsFJ2DvDXtp9K7yzNmvbqV/kUjzCQlD0gNJVINIGrjLQ4BX48I+/YY0ucJfZevda1Qit+wsry7j5D4IDgNUpBKl8zuJSbk48nC5cVOTrkp1FXQ7GsO3t8UIr6e2QXBmn2wcYSEwaVeWUlVsRDXZecw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfUmYMPS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049373; x=1760585373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ipVGNE72HnzLuRj6oepdeobbxw/astyo5Dsj0YhhbLI=;
  b=AfUmYMPSHKFNK9OQL5igU8jGURXuDdF2zE5Ul85jnw6I7Qkif94cte5A
   KtJg+aQqQ5uvLU3GMrZw9xxEFDzMPN18U6bQX7NPDkKLulpf8AOqsdv97
   +whzJpP0GUlxOs7ITs/iLIegXSBM6Z17Y3TmmjGaQ64u/fAk/bFrQ8Wpx
   sta63DjyAu3M6A1qS9JY+e6otX0ZbWj5CshZwx/sUW8aASmEtD0EvBF5Z
   1G3q0dCJi6XEPKHhOV1tpztZvg0HW57nokshrVq6hj70biFajuAXWKOhR
   ATKPAJ5KVBdAZXxvmU3cmuzbR3dL/mF4e6xcGj2q/cjeKugArPsniTh7/
   g==;
X-CSE-ConnectionGUID: V7KtIbtDQ7aCOVt60gLylg==
X-CSE-MsgGUID: KlyFRyStTLezljB7yJvMgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28676517"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28676517"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:33 -0700
X-CSE-ConnectionGUID: ikVwpVuJSTWym9uOTlh6Kw==
X-CSE-MsgGUID: WJ+fZAUYSMqJUeR8jP+yKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78047690"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:30 -0700
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
Subject: [PATCH 3/4] soundwire: intel_ace2x: Send PDI stream number during prepare
Date: Wed, 16 Oct 2024 11:29:09 +0800
Message-ID: <20241016032910.14601-4-yung-chuan.liao@linux.intel.com>
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

In the case of a prepare callback after an xrun or when the PCM is
restarted after a call to snd_pcm_drain/snd_pcm_drop, avoid
reprogramming the SHIM registers but send the PDI stream number so that
the link DMA data can be set. This is needed for the case that the DMA
data is cleared when the PCM is stopped and restarted without being
closed.

Link: https://github.com/thesofproject/sof/issues/9502
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 3084f0ac7159..a005b63582e9 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -383,11 +383,12 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 static int intel_prepare(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_cdns_dai_runtime *dai_runtime;
+	struct snd_pcm_hw_params *hw_params;
 	int ch, dir;
-	int ret = 0;
 
 	dai_runtime = cdns->dai_runtime_array[dai->id];
 	if (!dai_runtime) {
@@ -396,12 +397,8 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		return -EIO;
 	}
 
+	hw_params = &rtd->dpcm[substream->stream].hw_params;
 	if (dai_runtime->suspended) {
-		struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-		struct snd_pcm_hw_params *hw_params;
-
-		hw_params = &rtd->dpcm[substream->stream].hw_params;
-
 		dai_runtime->suspended = false;
 
 		/*
@@ -422,15 +419,11 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		/* the SHIM will be configured in the callback functions */
 
 		sdw_cdns_config_stream(cdns, ch, dir, dai_runtime->pdi);
-
-		/* Inform DSP about PDI stream number */
-		ret = intel_params_stream(sdw, substream, dai,
-					  hw_params,
-					  sdw->instance,
-					  dai_runtime->pdi->intel_alh_id);
 	}
 
-	return ret;
+	/* Inform DSP about PDI stream number */
+	return intel_params_stream(sdw, substream, dai, hw_params, sdw->instance,
+				   dai_runtime->pdi->intel_alh_id);
 }
 
 static int
-- 
2.43.0


