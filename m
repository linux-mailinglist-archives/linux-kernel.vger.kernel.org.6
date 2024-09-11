Return-Path: <linux-kernel+bounces-324828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BB197515C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0A41C204F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732119F126;
	Wed, 11 Sep 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfLCNeCN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2876A19F112;
	Wed, 11 Sep 2024 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055968; cv=none; b=CyRkJ+aL9Rb+1kJA3uUDZeHM+Af6iFfG6rwbn4P0eKlF70i9X/MdalMiazP+6D4w9RpYTqezmF966YXYFM15E+IbIxQk1lfNr/cq3+AkSq+lIxdNE0R6PSTiLCmFAkCh3o9IYeaaYd/GPyqiVRSsWWsAkqrQyuSlZV/z5JmGNKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055968; c=relaxed/simple;
	bh=gqvcCDV7IzMmRINKZ0ibda4nCVtOH01gXGIaUt4CVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKWG939Jd90VmeyhbBEsqOk4HTIwjV6FFDH03dKd0g1ytdEeH+h1SfAtlGRiBmtAXwEec2uFhklkuRnBMvSdl6IDcrXzDPOFUMZpXGE7J3FYjLEHaYvzcHcVMgerkBy9Cdf5bj+iDc+KdZFjClUFTi4xUFL6zT7PbCrjtdYcky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfLCNeCN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055967; x=1757591967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqvcCDV7IzMmRINKZ0ibda4nCVtOH01gXGIaUt4CVFE=;
  b=kfLCNeCNEm3a04I3N593/ZRYTpg2KkgGwIJ0FalFDyHMGV11F+5XEy21
   FXMQ7bwsCvRFkF85WWVX0nHqstz4vmPDwL9FVLzzkjo0ZrHwAAakrdBMD
   dWgsZ6N/A/400TyXHWfNEMSlxAMlaQqfpdmPH1lszEkMvIQjz1RXZs4Qf
   2Ino+4LkidypeFz0BSC85Fbow0qS1sKFoxnRCObOxRs08gQbtIWdZ8BuE
   6qbVyHIQUFv180riiXDOgwmDNq7CR0/4UI3KhcIh6cLuwEii1CU20pFYL
   sn9mF/3FCx5v6SdphBHrJnfwA9ZkR4zhhvM9TAI5f30naNpSNujymWAY3
   A==;
X-CSE-ConnectionGUID: juc0rks8TkK3Vmiz+RJNdw==
X-CSE-MsgGUID: +Ld0ne+tTmeCjeztUeyeeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417267"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417267"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:27 -0700
X-CSE-ConnectionGUID: fURjMYspTVazeMu4tHjTtw==
X-CSE-MsgGUID: ZDaEX7kEQgCw7Lf4uvhwbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292789"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:24 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 10/14] soundwire: mipi_disco: add support for clock-scales property
Date: Wed, 11 Sep 2024 19:58:23 +0800
Message-ID: <20240911115827.233171-11-yung-chuan.liao@linux.intel.com>
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

The DisCo for SoundWire 2.0 spec adds support for the
'mipi-sdw-supported-clock-scales' property, which is just a
rename. Add in a backwards-compatible manner.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 99253f4c9a38..5f42d23bbc85 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -51,6 +51,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 {
 	struct sdw_master_prop *prop = &bus->prop;
 	struct fwnode_handle *link;
+	const char *scales_prop;
 	char name[32];
 	int nval;
 	int ret;
@@ -112,7 +113,12 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		}
 	}
 
-	nval = fwnode_property_count_u32(link, "mipi-sdw-supported-clock-gears");
+	scales_prop = "mipi-sdw-supported-clock-scales";
+	nval = fwnode_property_count_u32(link, scales_prop);
+	if (nval == 0) {
+		scales_prop = "mipi-sdw-supported-clock-gears";
+		nval = fwnode_property_count_u32(link, scales_prop);
+	}
 	if (nval > 0) {
 		prop->num_clk_gears = nval;
 		prop->clk_gears = devm_kcalloc(bus->dev, prop->num_clk_gears,
@@ -124,7 +130,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		}
 
 		ret = fwnode_property_read_u32_array(link,
-					       "mipi-sdw-supported-clock-gears",
+					       scales_prop,
 					       prop->clk_gears,
 					       prop->num_clk_gears);
 		if (ret < 0)
-- 
2.43.0


