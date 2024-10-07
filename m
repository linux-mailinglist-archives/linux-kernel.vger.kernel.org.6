Return-Path: <linux-kernel+bounces-353253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E53992B3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CF11C22B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C9D1D3584;
	Mon,  7 Oct 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBRbd/UT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A81D3182;
	Mon,  7 Oct 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303182; cv=none; b=OZ2X1MhI0MKT6vQ+ZW0jGqv/knqaX6ZE3cbNT75va9JoY8r4FVMcnseyqEACE/xBZu7eTeAL+OyiLKPY5UoliDUBwYkXwePnPgVQnKglSx/lvduV+/3FLaDEn6aaznEQcy/MDcjVusRb2qm/FD22xhTWIqPjdgML92/zUfAtQOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303182; c=relaxed/simple;
	bh=yOk5ChF3rFaV9qaso8EJg7Xh9XQOZqrw5oes/WowWO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVkky3deN79YB/bu40L9hsAcWZgBcrWxMIQg/KHgIZ5qDA2jWEBsiAAGeFCodpVR4wMvbpOKjzLTZ6yXwqu2ansbbz8LOcPA/wU++PkxS7WeI3neUOjs0SSQOBaB9tVPUfT0Mzr5+fAEwAzYYONPvsApny63mAIvWA53iozQfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBRbd/UT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303180; x=1759839180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOk5ChF3rFaV9qaso8EJg7Xh9XQOZqrw5oes/WowWO0=;
  b=IBRbd/UT2OtNHJgUOUuh6L9wTzelG+1LB4h6ayyFo8lWrHxkknkR+i+N
   5ApiZiHJWKuABi8pC57jvIQzno4r4Csjtjo0EDotgibRIT2P6Kk1NaQ7v
   NjKzA3zhV17guO31kAYrOWmwJwAs7PobD0ab2ldTMEh1QT8yG9Zh1hzyg
   veOGR3CHrn8rqnttk5HCyHcl3gGFEz4PbRXL6Dse8XEX94rQED4if/kyX
   jjgu8cYfMLLEOkaT5F3e08wPaoeOFzlVoIcEL4lpgTcwmXIIjMT7+zlz3
   xx1v1/GfnNf6ecE1aflpG6qMQeUxOceDP3zneYOCEK6T9E+EItdATLe5O
   w==;
X-CSE-ConnectionGUID: R0HsEAJHQlyhnJw2ldl7wg==
X-CSE-MsgGUID: b0SNyBlwRMuI9EPm8EqL6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="15064810"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="15064810"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:13:00 -0700
X-CSE-ConnectionGUID: ObuUEjOlRcih/3AMwSfOXg==
X-CSE-MsgGUID: wEfH7WqXR1K0IHTX+MNuiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80246898"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:12:57 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com,
	peter.ujfalusi@linux.intel.com
Subject: [PATCH 2/2] ASoC/SoundWire: Intel: lnl: enable interrupts after first power-up/before last power-down
Date: Mon,  7 Oct 2024 20:12:41 +0800
Message-ID: <20241007121241.30914-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007121241.30914-1-yung-chuan.liao@linux.intel.com>
References: <20241007121241.30914-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The HDaudio mlink support makes it more logical to couple interrupt
enabling/disabling with power-up/down sequences.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c |  7 +++++++
 sound/soc/sof/intel/hda-dsp.c   |  5 -----
 sound/soc/sof/intel/hda.c       |  2 --
 sound/soc/sof/intel/lnl.c       | 10 ----------
 4 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index fff312c6968d..3084f0ac7159 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -175,6 +175,9 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 				__func__, ret);
 			goto out;
 		}
+
+		hdac_bus_eml_enable_interrupt_unlocked(sdw->link_res->hbus, true,
+						       AZX_REG_ML_LEPTR_ID_SDW, true);
 	}
 
 	*shim_mask |= BIT(link_id);
@@ -201,6 +204,10 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 
 	*shim_mask &= ~BIT(link_id);
 
+	if (!*shim_mask)
+		hdac_bus_eml_enable_interrupt_unlocked(sdw->link_res->hbus, true,
+						       AZX_REG_ML_LEPTR_ID_SDW, false);
+
 	ret = hdac_bus_eml_sdw_power_down_unlocked(sdw->link_res->hbus, link_id);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "%s: hdac_bus_eml_sdw_power_down failed: %d\n",
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 4c88522d4048..6028a80418bb 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -858,7 +858,6 @@ static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
 
 static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 {
-	const struct sof_intel_dsp_desc *chip;
 	int ret;
 
 	/* display codec must be powered before link reset */
@@ -891,10 +890,6 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 		hda_dsp_ctrl_ppcap_int_enable(sdev, true);
 	}
 
-	chip = get_chip_info(sdev->pdata);
-	if (chip && chip->hw_ip_version >= SOF_INTEL_ACE_2_0)
-		hda_sdw_int_enable(sdev, true);
-
 cleanup:
 	/* display codec can powered off after controller init */
 	hda_codec_i915_display_power(sdev, false);
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 70fc08c8fc99..e4cb4ffc7270 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -866,8 +866,6 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 			dev_err(sdev->dev, "could not startup SoundWire links\n");
 			goto disable_pp_cap;
 		}
-
-		hda_sdw_int_enable(sdev, true);
 	}
 
 	init_waitqueue_head(&hdev->waitq);
diff --git a/sound/soc/sof/intel/lnl.c b/sound/soc/sof/intel/lnl.c
index 3d5a1f8b17e5..e3c4b4a0d705 100644
--- a/sound/soc/sof/intel/lnl.c
+++ b/sound/soc/sof/intel/lnl.c
@@ -192,16 +192,8 @@ static bool lnl_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
 	return hdac_bus_eml_check_interrupt(bus, true,  AZX_REG_ML_LEPTR_ID_SDW);
 }
 
-static void lnl_enable_sdw_irq(struct snd_sof_dev *sdev, bool enable)
-{
-	struct hdac_bus *bus = sof_to_bus(sdev);
-
-	hdac_bus_eml_enable_interrupt(bus, true,  AZX_REG_ML_LEPTR_ID_SDW, enable);
-}
-
 static int lnl_dsp_disable_interrupts(struct snd_sof_dev *sdev)
 {
-	lnl_enable_sdw_irq(sdev, false);
 	mtl_disable_ipc_interrupts(sdev);
 	return mtl_enable_interrupts(sdev, false);
 }
@@ -237,7 +229,6 @@ const struct sof_intel_dsp_desc lnl_chip_info = {
 	.ssp_count = MTL_SSP_COUNT,
 	.d0i3_offset = MTL_HDA_VS_D0I3C,
 	.read_sdw_lcount =  hda_sdw_check_lcount_ext,
-	.enable_sdw_irq = lnl_enable_sdw_irq,
 	.check_sdw_irq = lnl_dsp_check_sdw_irq,
 	.check_sdw_wakeen_irq = lnl_sdw_check_wakeen_irq,
 	.sdw_process_wakeen = hda_sdw_process_wakeen_common,
@@ -262,7 +253,6 @@ const struct sof_intel_dsp_desc ptl_chip_info = {
 	.ssp_count = MTL_SSP_COUNT,
 	.d0i3_offset = MTL_HDA_VS_D0I3C,
 	.read_sdw_lcount =  hda_sdw_check_lcount_ext,
-	.enable_sdw_irq = lnl_enable_sdw_irq,
 	.check_sdw_irq = lnl_dsp_check_sdw_irq,
 	.check_sdw_wakeen_irq = lnl_sdw_check_wakeen_irq,
 	.check_ipc_irq = mtl_dsp_check_ipc_irq,
-- 
2.43.0


