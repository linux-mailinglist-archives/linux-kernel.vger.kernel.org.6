Return-Path: <linux-kernel+bounces-303382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ACA960B61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35161C22DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EEC1BD51F;
	Tue, 27 Aug 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cf0ndb6l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD01BFE06;
	Tue, 27 Aug 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764098; cv=none; b=E5lXeUkB1t29UDo1vCr+7jNQak/BcdRtgHwHeB8mc1a4LWsABaDwqHHSSP7E+CAjiljWeb6QBeddFyEEeGEGazkxfeE6wenw/9UG6xsXm7OcXMWmkNskKdgCVBMjNJitzAD27DpDOpormS34JG6jzkVpDxS1eaY0Gn37j6Apb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764098; c=relaxed/simple;
	bh=AYWLBb8Keyuw2fUFmizNHQwBmBNVP35YDuFTaDlBHz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1vmUwk2EDrRZJGi6ZHPZZUDupytKMUpHVjwQMr/TzKVUpx3F0obxXup+dit/kblzUIChOBWYNcqfLBHb/pB7Kf6pDp7tjqyxeeFocFHdEnkr+WWX30uUV1OK5a5ZtRXEyCLtIXzETBpaqjCuFGfVEqatXNQGTqKMncJmuZvTVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cf0ndb6l; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764097; x=1756300097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AYWLBb8Keyuw2fUFmizNHQwBmBNVP35YDuFTaDlBHz4=;
  b=Cf0ndb6lsD6HVD9wOf9FYs/RBhCt2vi6StldmZiSm1xDwIrbesVmCtTG
   TEQ/w/7/16Yri70KGksN6h/YX2kRWLtWqfay+5vieyCurPQMNSW0udgT7
   LX6qZKys1XXtU7REsFATyQVQDfkRRXaBmWoP9ozOeWobBSoZKCsaLw5CX
   sti3YdzGXCmAkuW66o33v7BsjRWKAj7IwnDGR/ensUkFFNYWbfrEbdzQh
   eMStuhfVpLCJF/L0ANqY7/rwhEfg0/MCLHBD6PtEMoYT4vZYhmTpHGy7T
   IWKMS3g0ecfZr2mHRZKMzEYBsyeM47N2c7ePHqf69GEl1NLLyyTmd0um+
   w==;
X-CSE-ConnectionGUID: XoMRec5DSBeFDNQSwLTjqg==
X-CSE-MsgGUID: cSmtC9BXQLaHF+xhbPo5QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400609"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400609"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:17 -0700
X-CSE-ConnectionGUID: YNJvfGldR/qc9divoPI22g==
X-CSE-MsgGUID: V0DIbfS7RW24PJ/uPSHF6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67552021"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:15 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 09/14] soundwire: mipi-disco: add error handling for property array read
Date: Tue, 27 Aug 2024 21:07:02 +0800
Message-ID: <20240827130707.298477-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
References: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
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


