Return-Path: <linux-kernel+bounces-288860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A74953FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B841F24DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776F06CDAB;
	Fri, 16 Aug 2024 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYimUQAT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00954F20E;
	Fri, 16 Aug 2024 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775630; cv=none; b=VxkC1snLvhaAmAvXG/ytOH8ptZd2VvxWymMhVqPyPBTGS1NYvWZULUWUnqQd39wt1F/In7nA2z4r1cbSrbGdeMHUiyh6Jk1FcIMozQauvJ4v8IFSFmVYbnzxfldltK/9E2JDHoVoMlDu2USb5AlNAL82wpDMpmuev6SxpBnGiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775630; c=relaxed/simple;
	bh=HMRwzVYs/M9EtV34zw7AD/7vm/ahsPsaVILYWWzBuUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzT3GhdBGgLKyR6/gFictodvPXxA99kknLbUd76KUZ73X3ZuD8CEQOUbkbWEbC64jJs6a0E6G3SSdLikHspcndwjf6vNfKnFcpzJnE5zDXSdQyVJ0UbEcNBE25LI0ovtKaZd++MjD55/TaYvHIC3pDdsadse3CcKAHoKuXRs/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYimUQAT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723775629; x=1755311629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMRwzVYs/M9EtV34zw7AD/7vm/ahsPsaVILYWWzBuUk=;
  b=dYimUQATV7iTvk35inLg0n+DIMg4AQ0dqgLwIsV7C8f+leD8Xmdhx2EW
   jGY/R+YbF8av2/FcQYHCr52LkQ1oFre74DSVeISuMPGf8IudI0tNjKblb
   ahSpsqC6kV/DkuncJPTonyUYY80P2RpRYRdeE7PVye4dBMZdYQpksGIPb
   cgNI4ooYhFH39+kDW325xcowkQc0W66QvkytHX/ysiilG3jLF971DLyxF
   S2ujl1gYkXAbhFnA2He24fvL0LJmr9cJRhYYARzHta1hmpiRrR9S+10AM
   yhMRhc2PSl1mu6gZeANlswfCdDWqq46xXEqLf8hkjNOCSmk1gmB8SV2v+
   A==;
X-CSE-ConnectionGUID: AFvgf0B4QtmuHYE7eS032w==
X-CSE-MsgGUID: Augu0ShtSAiwx0gHzYa/oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22203564"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22203564"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:33:48 -0700
X-CSE-ConnectionGUID: lZuT+ivDR1uyq2a1ZhC3HQ==
X-CSE-MsgGUID: XRv+Dm8VQCuCc5jYOQJt7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="63949193"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.176])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:33:45 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 1/3] ALSA/ASoC/SoundWire: Intel: use single definition for SDW_INTEL_MAX_LINKS
Date: Fri, 16 Aug 2024 10:33:29 +0800
Message-ID: <20240816023331.6565-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
References: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The definitions are currently duplicated in intel-sdw-acpi.c and
sof_sdw.c.  Move the definition to the sdw_intel.h header, and change
the prefix to make it Intel-specific.

No functionality change in this patch.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h     | 5 +++++
 sound/hda/intel-sdw-acpi.c              | 5 ++---
 sound/soc/intel/boards/sof_sdw.c        | 4 +++-
 sound/soc/intel/boards/sof_sdw_common.h | 4 +---
 sound/soc/intel/boards/sof_sdw_hdmi.c   | 2 ++
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index d537587b4499..87d82ea9a13a 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -447,4 +447,9 @@ extern const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops;
 
 #define SDW_INTEL_DEV_NUM_IDA_MIN           6
 
+/*
+ * Max number of links supported in hardware
+ */
+#define SDW_INTEL_MAX_LINKS                4
+
 #endif
diff --git a/sound/hda/intel-sdw-acpi.c b/sound/hda/intel-sdw-acpi.c
index f3b2a610df23..04d6b6beabca 100644
--- a/sound/hda/intel-sdw-acpi.c
+++ b/sound/hda/intel-sdw-acpi.c
@@ -17,7 +17,6 @@
 #include <linux/string.h>
 
 #define SDW_LINK_TYPE		4 /* from Intel ACPI documentation */
-#define SDW_MAX_LINKS		4
 
 static int ctrl_link_mask;
 module_param_named(sdw_link_mask, ctrl_link_mask, int, 0444);
@@ -87,9 +86,9 @@ sdw_intel_scan_controller(struct sdw_intel_acpi_info *info)
 	}
 
 	/* Check count is within bounds */
-	if (count > SDW_MAX_LINKS) {
+	if (count > SDW_INTEL_MAX_LINKS) {
 		dev_err(&adev->dev, "Link count %d exceeds max %d\n",
-			count, SDW_MAX_LINKS);
+			count, SDW_INTEL_MAX_LINKS);
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index d258728d64cf..b1fb6fabd3b7 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -5,12 +5,14 @@
  *  sof_sdw - ASOC Machine driver for Intel SoundWire platforms
  */
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
+#include <linux/soundwire/sdw_intel.h>
 #include <sound/soc-acpi.h>
 #include "sof_sdw_common.h"
 #include "../../codecs/rt711.h"
@@ -883,7 +885,7 @@ static int create_sdw_dailinks(struct snd_soc_card *card,
 	struct intel_mc_ctx *intel_ctx = (struct intel_mc_ctx *)ctx->private;
 	int ret, i;
 
-	for (i = 0; i < SDW_MAX_LINKS; i++)
+	for (i = 0; i < SDW_INTEL_MAX_LINKS; i++)
 		intel_ctx->sdw_pin_index[i] = SOC_SDW_INTEL_BIDIR_PDI_BASE;
 
 	/* generate DAI links by each sdw link */
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 02f3eebd019d..c10d2711b730 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -19,8 +19,6 @@
 #define SOC_SDW_MAX_CPU_DAIS 16
 #define SOC_SDW_INTEL_BIDIR_PDI_BASE 2
 
-#define SDW_MAX_LINKS		4
-
 /* 8 combinations with 4 links + unused group 0 */
 #define SDW_MAX_GROUPS 9
 
@@ -57,7 +55,7 @@ enum {
 struct intel_mc_ctx {
 	struct sof_hdmi_private hdmi;
 	/* To store SDW Pin index for each SoundWire link */
-	unsigned int sdw_pin_index[SDW_MAX_LINKS];
+	unsigned int sdw_pin_index[SDW_INTEL_MAX_LINKS];
 };
 
 extern unsigned long sof_sdw_quirk;
diff --git a/sound/soc/intel/boards/sof_sdw_hdmi.c b/sound/soc/intel/boards/sof_sdw_hdmi.c
index 4084119a9a5f..f92867deb029 100644
--- a/sound/soc/intel/boards/sof_sdw_hdmi.c
+++ b/sound/soc/intel/boards/sof_sdw_hdmi.c
@@ -5,10 +5,12 @@
  *  sof_sdw_hdmi - Helpers to handle HDMI from generic machine driver
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/soundwire/sdw_intel.h>
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
 #include <sound/jack.h>
-- 
2.43.0


