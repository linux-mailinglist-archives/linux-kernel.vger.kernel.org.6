Return-Path: <linux-kernel+bounces-324827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30D97515B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A01DB26C93
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107319E970;
	Wed, 11 Sep 2024 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lh8UMUyR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED0219E98E;
	Wed, 11 Sep 2024 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055966; cv=none; b=gbWdn9LGpsKLk69bXCUWv0Q9jCIuXod1/POH0dDXEzsxnL8kFJhSF+09zj3MZOmRPRl/+hLx7XvKsoE1RJ8LW4s/W1DG6uHhJw0IbUgKYFuhf7ehT7Zz/CqExZj122M2PebBo1Ad/Lx+rZZ06T6GttxziBEK/4Ng3gqLSmKUe50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055966; c=relaxed/simple;
	bh=AYWLBb8Keyuw2fUFmizNHQwBmBNVP35YDuFTaDlBHz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiJXwJAHbybq/IBf02BlKUGCZ5zJCxer0PMXLS6PjyKZF/CpdignJg3Fut5cpex0dct0R6ANB6bPu6fA0g1DzSlbZD/h5dCNWE62u5WGLJCokNNX2YttZMJbKPlXoDmMSo5s6FFi3TSF+ZsuAkG/NVhMBHiqSc0gE+p4hYQi1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lh8UMUyR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055965; x=1757591965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AYWLBb8Keyuw2fUFmizNHQwBmBNVP35YDuFTaDlBHz4=;
  b=lh8UMUyRpmSoQwgZ0FbkrWyeS64rzNXFmFPpcB/nxp1/Y2KLVpOdiQwS
   TuCLMQS/MX85JMM8YCl2x+176KUWbLU37Z5aHAZVNgUB3TZsJuwlN4FnA
   HCpgrX5RD2SCuQ3LSBnVJ2BsI2snWvWgNstygYgXPPyF3WWanEtOUuI95
   GrtBTMr+Zn7lc8GCp/2L33LXaKXkJPfsnGckBNOzL4b/RZ31wSOMvXcmK
   adkmXmMpLQVfFl0YwOtREsZJ4N1PJULUoBDa61gObF0CgYE5Xjs4NgCVB
   AcOwAURaE1is07RMjOGF32+oFtcxr7zRKcEK5DRm3oQbggcO3to9bhWD1
   g==;
X-CSE-ConnectionGUID: QLGYxqJ5Q/qiSGPV0VpjVw==
X-CSE-MsgGUID: vImXfTAMRDCd4armKVCeVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417261"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417261"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:24 -0700
X-CSE-ConnectionGUID: eGgiJhvzSBqqYlzBuFWPXA==
X-CSE-MsgGUID: jJEBzvpGS2q30vhZt/AoNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292771"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:22 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 09/14] soundwire: mipi-disco: add error handling for property array read
Date: Wed, 11 Sep 2024 19:58:22 +0800
Message-ID: <20240911115827.233171-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
References: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The existing code assumes that there are no possible errors when using
fwnode_property_read_u32_array(), because fwnode_property_count_u32()
reads this array to determine its number of elements. We need to also
protect the second read to be completely bullet-proof.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 79cf8212f97a..99253f4c9a38 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -52,7 +52,9 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	struct sdw_master_prop *prop = &bus->prop;
 	struct fwnode_handle *link;
 	char name[32];
-	int nval, i;
+	int nval;
+	int ret;
+	int i;
 
 	device_property_read_u32(bus->dev,
 				 "mipi-sdw-sw-interface-revision",
@@ -91,9 +93,11 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 			return -ENOMEM;
 		}
 
-		fwnode_property_read_u32_array(link,
+		ret = fwnode_property_read_u32_array(link,
 				"mipi-sdw-clock-frequencies-supported",
 				prop->clk_freq, prop->num_clk_freq);
+		if (ret < 0)
+			return ret;
 	}
 
 	/*
@@ -119,10 +123,12 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 			return -ENOMEM;
 		}
 
-		fwnode_property_read_u32_array(link,
+		ret = fwnode_property_read_u32_array(link,
 					       "mipi-sdw-supported-clock-gears",
 					       prop->clk_gears,
 					       prop->num_clk_gears);
+		if (ret < 0)
+			return ret;
 	}
 
 	fwnode_property_read_u32(link, "mipi-sdw-default-frame-rate",
@@ -151,6 +157,7 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 			      struct sdw_dp0_prop *dp0)
 {
 	int nval;
+	int ret;
 
 	fwnode_property_read_u32(port, "mipi-sdw-port-max-wordlength",
 				 &dp0->max_word);
@@ -168,9 +175,11 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 		if (!dp0->words)
 			return -ENOMEM;
 
-		fwnode_property_read_u32_array(port,
+		ret = fwnode_property_read_u32_array(port,
 				"mipi-sdw-port-wordlength-configs",
 				dp0->words, dp0->num_words);
+		if (ret < 0)
+			return ret;
 	}
 
 	dp0->BRA_flow_controlled = mipi_fwnode_property_read_bool(port,
@@ -191,9 +200,10 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 {
 	struct fwnode_handle *node;
 	u32 bit, i = 0;
-	int nval;
 	unsigned long addr;
 	char name[40];
+	int nval;
+	int ret;
 
 	addr = ports;
 	/* valid ports are 1 to 14 so apply mask */
@@ -228,9 +238,11 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 				return -ENOMEM;
 			}
 
-			fwnode_property_read_u32_array(node,
+			ret = fwnode_property_read_u32_array(node,
 					"mipi-sdw-port-wordlength-configs",
 					dpn[i].words, dpn[i].num_words);
+			if (ret < 0)
+				return ret;
 		}
 
 		fwnode_property_read_u32(node, "mipi-sdw-data-port-type",
@@ -269,9 +281,11 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 				return -ENOMEM;
 			}
 
-			fwnode_property_read_u32_array(node,
+			ret = fwnode_property_read_u32_array(node,
 					"mipi-sdw-channel-number-list",
 					dpn[i].channels, dpn[i].num_channels);
+			if (ret < 0)
+				return ret;
 		}
 
 		nval = fwnode_property_count_u32(node, "mipi-sdw-channel-combination-list");
@@ -286,10 +300,12 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 				return -ENOMEM;
 			}
 
-			fwnode_property_read_u32_array(node,
+			ret = fwnode_property_read_u32_array(node,
 					"mipi-sdw-channel-combination-list",
 					dpn[i].ch_combinations,
 					dpn[i].num_ch_combinations);
+			if (ret < 0)
+				return ret;
 		}
 
 		fwnode_property_read_u32(node,
-- 
2.43.0


