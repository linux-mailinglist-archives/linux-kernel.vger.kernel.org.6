Return-Path: <linux-kernel+bounces-348657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A9C98EA1E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577CEB2517B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4FB145FE4;
	Thu,  3 Oct 2024 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFbOoCLT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910D14431B;
	Thu,  3 Oct 2024 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939267; cv=none; b=aT0s1FZOrVsPsG7fldatAxREsCl/ClpbUL0c7YpTaoYC0M1k505NsPACX8FOvCMTOyrNR5nCZLiF/c7P1qdqNqFVgeAE3LG5pB+3LiC8k6f1ZwnFbkIATUI3LKXhoFzhBeqPcwtmG72d3d6gjmgq3QBXuek5oxSkfjvzlMb3Uy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939267; c=relaxed/simple;
	bh=AYWLBb8Keyuw2fUFmizNHQwBmBNVP35YDuFTaDlBHz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdwMfUdMs6PoksOz1vA4h0sZmLELBDF3DAkKkhi4njfRy6GfY+fEdxWmRdvRAVBIhVUrHiT9GUOOc6t83aMr5F3wYsNmSHfhXC89FrwesSptqZiFG42jOCBkGSYj777aY4YD8z9Qs+QyVCIRkvLAsPvL7t5k2OD1RTX/ADtEpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFbOoCLT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939266; x=1759475266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AYWLBb8Keyuw2fUFmizNHQwBmBNVP35YDuFTaDlBHz4=;
  b=YFbOoCLT1HROBXhxPMq92++SMl2UWeThut7waMT66SIGFeiu3D+KMCkA
   8HfG6w3r+7B4zG2sYwFMfZJy3Jgk5bK+390lzKJkiEOTUO2rVujzsIrlr
   VN9RQ/hha7gRQg1+aHw6FzyvL2yjGbMio0LJ/S/KU0us1MA52uR7cciEB
   vJDdpH5o+6YQIJjxJSUywR2ZKF5XKBz/mnMqGh4BjKDs61RNfJda+Ee8f
   XE+d7hxqYryOw+f6v9/VuW/DOLo2DDqpX/iZt64uMoEFp5b4lL924BxHx
   v9GhZgb+GBwQVA6umFhDqWQOgnqhc5WJov4oKfmfNSxbxHfAdOh/hvLFZ
   Q==;
X-CSE-ConnectionGUID: 2TNftbK/QzKzdCUCzcgaaQ==
X-CSE-MsgGUID: I+0eTq2QT6uWEq7gPRCiwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070781"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070781"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:45 -0700
X-CSE-ConnectionGUID: l1eW+k16SY642lthsyQnBA==
X-CSE-MsgGUID: 5hjjAEh0SWS6PCcwTZ1cOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508411"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:43 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 09/14] soundwire: mipi-disco: add error handling for property array read
Date: Thu,  3 Oct 2024 15:06:45 +0800
Message-ID: <20241003070650.62787-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
References: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
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


