Return-Path: <linux-kernel+bounces-367826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C821B9A0743
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88ECD28D342
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283A207A09;
	Wed, 16 Oct 2024 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLFNdE7g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F220F5D5;
	Wed, 16 Oct 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074246; cv=none; b=XxbQEbw0zEdxEE4FbBpbteLNPh3MPo1tKsO+MYx0qlMkn0Blx7cucYIJz2+tIFNkuG2Vb/D7ghniX8IZk4ISUlqY8GC65O0f89lqF1YHwNyrJGlnGf18pA1rJjmtUHQhLJR92UDq+yWGGr2NmaKgafG/o1dLijhIqE+BPLWYC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074246; c=relaxed/simple;
	bh=vQsikfVcqe1m+nqzWrrCnhb0/wGj2sneKFB8jR73Da0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gG2/MspRPudn9lMwZri2HVbDAwuEchODGIOychGGEwnEao6aYmhWnxE24yiaabDDGh/gYvRZRzraY+oXKMytoRtLFY9MwLHA5D9rLAekHx59TBvfb2rpbavKFADaGaBhwazqqJ2u/Iffl/DqRsAkt6dKO7I+14CcDLSGJzv7z1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLFNdE7g; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074245; x=1760610245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQsikfVcqe1m+nqzWrrCnhb0/wGj2sneKFB8jR73Da0=;
  b=NLFNdE7gcc8+mP3FrFXnHBng752f/a7eWwIU2dBxLFnKJ+yWSV+vsGqh
   TF1mpUpqGUhRTQooU9KFWIfwuTSgWTGv7qKLsG8cy4Te0S8+2roT4SEDx
   5cs15fmtEpCsAaYzmcQfOcv3qHi0lsRc7Bru9hYjs4vUpE9ehFxyLiYxf
   LLBJtLAhsTOO7KWB/RY6Ft/nlX2aL2dijRdzdN00wXJp5ECkBsuTjY7K6
   gKwezmv441n5eUFwOM49oyKC3ukrchQTeLwPyvFyk8UmxSDNpfqthmSDF
   pE81ICOf98CCwbhT89k6iqQ0UwNGfxDLp6LtL21ytHI2f/ItZwOf+eUNi
   A==;
X-CSE-ConnectionGUID: 5JJEMCC2TRCq0HCXnPCngQ==
X-CSE-MsgGUID: 7M+vCJsiTyW602IyF+OPuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985901"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985901"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:05 -0700
X-CSE-ConnectionGUID: r3SuJixVSNSO32NkF0aZRg==
X-CSE-MsgGUID: Y4er7GD8SyOpXEppwWScpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82960918"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:02 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 05/11] ASoC: SDCA: add quirk function for RT712_VB match
Date: Wed, 16 Oct 2024 18:23:27 +0800
Message-ID: <20241016102333.294448-6-yung-chuan.liao@linux.intel.com>
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

Add a generic match function for quirks, chances are we are going to
have lots of those...

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/sound/sdca.h         | 10 ++++++++-
 sound/soc/sdca/sdca_device.c | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/sound/sdca.h b/include/sound/sdca.h
index 34473ca4c789..7e138229e8f3 100644
--- a/include/sound/sdca.h
+++ b/include/sound/sdca.h
@@ -39,16 +39,24 @@ struct sdca_device_data {
 	struct sdca_function_desc sdca_func[SDCA_MAX_FUNCTION_COUNT];
 };
 
+enum sdca_quirk {
+	SDCA_QUIRKS_RT712_VB,
+};
+
 #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_SND_SOC_SDCA)
 
 void sdca_lookup_functions(struct sdw_slave *slave);
 void sdca_lookup_interface_revision(struct sdw_slave *slave);
+bool sdca_device_quirk_match(struct sdw_slave *slave, enum sdca_quirk quirk);
 
 #else
 
 static inline void sdca_lookup_functions(struct sdw_slave *slave) {}
 static inline void sdca_lookup_interface_revision(struct sdw_slave *slave) {}
-
+static inline bool sdca_device_quirk_match(struct sdw_slave *slave, enum sdca_quirk quirk)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/sound/soc/sdca/sdca_device.c b/sound/soc/sdca/sdca_device.c
index 58f5f6f0f723..c44dc21cb634 100644
--- a/sound/soc/sdca/sdca_device.c
+++ b/sound/soc/sdca/sdca_device.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/soundwire/sdw.h>
 #include <sound/sdca.h>
+#include <sound/sdca_function.h>
 
 void sdca_lookup_interface_revision(struct sdw_slave *slave)
 {
@@ -22,3 +23,45 @@ void sdca_lookup_interface_revision(struct sdw_slave *slave)
 				 &slave->sdca_data.interface_revision);
 }
 EXPORT_SYMBOL_NS(sdca_lookup_interface_revision, SND_SOC_SDCA);
+
+static bool sdca_device_quirk_rt712_vb(struct sdw_slave *slave)
+{
+	struct sdw_slave_id *id = &slave->id;
+	int i;
+
+	/*
+	 * The RT712_VA relies on the v06r04 draft, and the
+	 * RT712_VB on a more recent v08r01 draft.
+	 */
+	if (slave->sdca_data.interface_revision < 0x0801)
+		return false;
+
+	if (id->mfg_id != 0x025d)
+		return false;
+
+	if (id->part_id != 0x712 &&
+	    id->part_id != 0x713 &&
+	    id->part_id != 0x716 &&
+	    id->part_id != 0x717)
+		return false;
+
+	for (i = 0; i < slave->sdca_data.num_functions; i++) {
+		if (slave->sdca_data.sdca_func[i].type ==
+		    SDCA_FUNCTION_TYPE_SMART_MIC)
+			return true;
+	}
+
+	return false;
+}
+
+bool sdca_device_quirk_match(struct sdw_slave *slave, enum sdca_quirk quirk)
+{
+	switch (quirk) {
+	case SDCA_QUIRKS_RT712_VB:
+		return sdca_device_quirk_rt712_vb(slave);
+	default:
+		break;
+	}
+	return false;
+}
+EXPORT_SYMBOL_NS(sdca_device_quirk_match, SND_SOC_SDCA);
-- 
2.43.0


