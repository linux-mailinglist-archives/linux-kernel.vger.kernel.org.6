Return-Path: <linux-kernel+bounces-348658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9EA98EA1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7A51F24BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80293147C91;
	Thu,  3 Oct 2024 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RS64llBx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BA145A05;
	Thu,  3 Oct 2024 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939269; cv=none; b=rlr2Wp0pwGvZoTbf2J52BZzE8jeBZBKUbQtRQrUBg4b6N3ZouWYVix4xegr/2Ihbd2SysAGAWNKtj4qEP8Vq4hh2o5jA3ctKRuzoMj58hUWTCJkE2ovOBVWq0+8U6Y9hcPuQs63b5FZU0JSKW+8o2KTCR1SqiRda8wQLOhU8Mp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939269; c=relaxed/simple;
	bh=gqvcCDV7IzMmRINKZ0ibda4nCVtOH01gXGIaUt4CVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOGM9rAg2Ybp/S1OB7HQPPWRST1Yg6AmOEG69ffpPBIrszqcrIJrSG7JeTats6SttSNI+a67VLUWGjItEdk97z8YK7zCHuvmSOXSuydn+exp2tjhV6FLqUKDUmqiZlVuWsIo8CKcPFinwq/+Evh41rjVFUslJQNZlOZuhytkrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RS64llBx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939268; x=1759475268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqvcCDV7IzMmRINKZ0ibda4nCVtOH01gXGIaUt4CVFE=;
  b=RS64llBxJFH8h6WrVKB2F4SyBumNSg/jR+mqCcs9J38IwwlaTv4C+PMN
   DiMQpqtSL5yYOQjT0ODAfvzeeryb4d+c0XHem4zrp9M3pHOPXJT+oll55
   D1Z/jBAGzq1hhYxhr6FfzTuGKben6VqRj7ejwt+nvsAkGrTRIaNvb5UR3
   +v1PJupV5c8veV2wasa8qOmBYgAaKxF2PCaUPlqEpJohJ/+Q5+t0g9NcD
   ZaUcSyB6Rrv3PRuDv5R3/5g8VDqVkisXSqcN4vubbtJUd8VNGvS4H7SJR
   Y6kL34K25Kl6LlwltJ1FAktqjgjhn4nrvcxV3qdXcqLKUSfXvjM3ty07l
   g==;
X-CSE-ConnectionGUID: razWLNYCSE6X061mvw5FBg==
X-CSE-MsgGUID: q5qBpbW6Qc+/v6GBreZq2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070788"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070788"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:48 -0700
X-CSE-ConnectionGUID: So8oSXwPS4SYpt+ZD7RHTA==
X-CSE-MsgGUID: z7KNKJueS/2dp6OTz1/3cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508415"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:45 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 10/14] soundwire: mipi_disco: add support for clock-scales property
Date: Thu,  3 Oct 2024 15:06:46 +0800
Message-ID: <20241003070650.62787-11-yung-chuan.liao@linux.intel.com>
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


