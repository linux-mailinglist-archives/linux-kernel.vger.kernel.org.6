Return-Path: <linux-kernel+bounces-367827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434A79A0744
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAE028D357
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF3920FAB8;
	Wed, 16 Oct 2024 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBhvWNzC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D920FAA1;
	Wed, 16 Oct 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074249; cv=none; b=gBWOu+zXLMpCqLr30zob42JUlGN7bXdimXjQ53ROVnqP0krBVUgzrQEJq4Jz0pMaGoxW7Y+khzT6Lg+WTjr5KsArw1dguDDEzIkEuOqpH0o6bvM0oxqx0v5AF6b+uc85i9xrPn99/Vis4PNfIQtYDK3rNp9Km3eT0PLFgxwXx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074249; c=relaxed/simple;
	bh=R3L3OdjrZ7wDoYzeI5ybv3xYxVMF4yQecWFgcQqX9Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyEgt81Ja/kyuSCTQsgFym6yKJtEvp1ylUf12eU1jgMQanxNK+A0DwXerjycRHilNcRTQYAdPk3cp26JXddQjwFDDEQXRFXIuwnBOk7hJ/OIoH2KINPbtKTjJKgZL8ePNONsWrQrBhAhZzPD5AZ7mrFIQn3dcvLxKNLCksAm36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBhvWNzC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074248; x=1760610248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3L3OdjrZ7wDoYzeI5ybv3xYxVMF4yQecWFgcQqX9Aw=;
  b=GBhvWNzCn0oZgz03dn4L2QgZlR1re4uJhNMhR6kSRXz+dsJyo2qYlJGh
   2HDM1oaAJCy2+t/e1BuANlTOd2kYke/nuejghNGGmejBYNFC2U32CIEbj
   Af+EWOl4hX8um7FZeEZAtZq/tvTMS51DEIK+pIvD3IpIQUBEyV1E1L5B2
   +5xRkk6ffI3aX9R7Ha5DAhvrx2G6mxBGsagxHudOVDQOM0tLzKvoOWkQq
   q4JRWOh1GkL7xnsVXeurHCUwMZEeLPvrWoO5dM8HMTPtzdd5k5LnVeUeP
   p2BixZ4FGt2Zh4aPj53TfJIPwTgO385zmMuIGkAcRiQFyjX5HfHzyqnZ7
   Q==;
X-CSE-ConnectionGUID: 8VweWllhRXafTz2eW1ucGQ==
X-CSE-MsgGUID: WatDMxNAQmyPFXLBka9nzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985908"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985908"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:08 -0700
X-CSE-ConnectionGUID: h8wlzai2QXGEKoPgI9OkjA==
X-CSE-MsgGUID: K8ZDfds/Q0yH3mNGlpQ11w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82960947"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:05 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 06/11] ASoC: rt712-sdca: detect the SMART_MIC function during the probe stage
Date: Wed, 16 Oct 2024 18:23:28 +0800
Message-ID: <20241016102333.294448-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
References: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We shouldn't do any devm_ based allocation in the io_init(), this need
to happen in the probe(). Luckily, we now have an SDCA helper to look
in ACPI tables if a SMART_MIC function is exposed.

FIXME: the registers are not well handled today, the regmap lists
registers which are not really supported in all platforms. The regmap
needs to throw an error if those registers are accessed without
existing.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/codecs/rt712-sdca-sdw.c |  1 +
 sound/soc/codecs/rt712-sdca.c     | 38 +++++++++++++++++++++++--------
 sound/soc/codecs/rt712-sdca.h     |  1 +
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt712-sdca-sdw.c b/sound/soc/codecs/rt712-sdca-sdw.c
index 90d5aaddbd5b..549aa31faed4 100644
--- a/sound/soc/codecs/rt712-sdca-sdw.c
+++ b/sound/soc/codecs/rt712-sdca-sdw.c
@@ -507,3 +507,4 @@ module_sdw_driver(rt712_sdca_sdw_driver);
 MODULE_DESCRIPTION("ASoC RT712 SDCA SDW driver");
 MODULE_AUTHOR("Shuming Fan <shumingf@realtek.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SND_SOC_SDCA);
diff --git a/sound/soc/codecs/rt712-sdca.c b/sound/soc/codecs/rt712-sdca.c
index e210c574bb74..78dbf9eed494 100644
--- a/sound/soc/codecs/rt712-sdca.c
+++ b/sound/soc/codecs/rt712-sdca.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/sdca.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/slab.h>
 #include <sound/soc-dapm.h>
@@ -1652,6 +1653,17 @@ int rt712_sdca_init(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return ret;
 
+	/* only add the dmic component if a SMART_MIC function is exposed in ACPI */
+	if (sdca_device_quirk_match(slave, SDCA_QUIRKS_RT712_VB)) {
+		ret =  devm_snd_soc_register_component(dev,
+						       &soc_sdca_dev_rt712_dmic,
+						       rt712_sdca_dmic_dai,
+						       ARRAY_SIZE(rt712_sdca_dmic_dai));
+		if (ret < 0)
+			return ret;
+		rt712->dmic_function_found = true;
+	}
+
 	/* set autosuspend parameters */
 	pm_runtime_set_autosuspend_delay(dev, 3000);
 	pm_runtime_use_autosuspend(dev);
@@ -1799,7 +1811,6 @@ static void rt712_sdca_vb_io_init(struct rt712_sdca_priv *rt712)
 int rt712_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 {
 	struct rt712_sdca_priv *rt712 = dev_get_drvdata(dev);
-	int ret = 0;
 	unsigned int val;
 	struct sdw_slave_prop *prop = &slave->prop;
 
@@ -1829,15 +1840,22 @@ int rt712_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	rt712->version_id = (val & 0x0f00) >> 8;
 	dev_dbg(&slave->dev, "%s hw_id=0x%x, version_id=0x%x\n", __func__, rt712->hw_id, rt712->version_id);
 
-	if (rt712->version_id == RT712_VA)
+	if (rt712->version_id == RT712_VA) {
+		if (rt712->dmic_function_found) {
+			dev_err(&slave->dev, "%s RT712 VA detected but SMART_MIC function exposed in ACPI\n",
+				__func__);
+			goto suspend;
+		}
+
 		rt712_sdca_va_io_init(rt712);
-	else {
+	} else {
+		if (!rt712->dmic_function_found) {
+			dev_err(&slave->dev, "%s RT712 VB detected but no SMART_MIC function exposed in ACPI\n",
+				__func__);
+			goto suspend;
+		}
+
 		/* multilanes and DMIC are supported by rt712vb */
-		ret =  devm_snd_soc_register_component(dev,
-			&soc_sdca_dev_rt712_dmic, rt712_sdca_dmic_dai, ARRAY_SIZE(rt712_sdca_dmic_dai));
-		if (ret < 0)
-			return ret;
-
 		prop->lane_control_support = true;
 		rt712_sdca_vb_io_init(rt712);
 	}
@@ -1862,10 +1880,12 @@ int rt712_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt712->hw_init = true;
 
+	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
+
+suspend:
 	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
-	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/rt712-sdca.h b/sound/soc/codecs/rt712-sdca.h
index 2169f2f726b9..a08491496d90 100644
--- a/sound/soc/codecs/rt712-sdca.h
+++ b/sound/soc/codecs/rt712-sdca.h
@@ -36,6 +36,7 @@ struct  rt712_sdca_priv {
 	unsigned int scp_sdca_stat2;
 	unsigned int hw_id;
 	unsigned int version_id;
+	bool dmic_function_found;
 	bool fu0f_dapm_mute;
 	bool fu0f_mixer_l_mute;
 	bool fu0f_mixer_r_mute;
-- 
2.43.0


