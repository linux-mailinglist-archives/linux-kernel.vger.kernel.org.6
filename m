Return-Path: <linux-kernel+bounces-274602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8676947A95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162531C2117F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC93155CB5;
	Mon,  5 Aug 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hw50HoVR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A921547CC;
	Mon,  5 Aug 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858618; cv=none; b=Zt4li0aM6IqhzYtB2hso+1AMH1P7LkntrspbcYrVtIMWTQ2Qon2FJOjgnqvowMxBVss/cxExXPhOu/F/drqZzXYIdXDEnd4xaDnbNJ+Crk/96o5EVLKH3pcGYxnH/ZDLiJGniaVsqHOyZm+Lu4R2c3U0TQOYOdVkcS3L/ti+o3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858618; c=relaxed/simple;
	bh=9ovFynt3b40ahsg006bNqlL8urBMdE4VrkjwcfoBQ8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WN8NlaTIj2XGFpWFhV1p+6mcLS1fBOHUfwbSomJKMKZUiFcNDa8kie6PDp6V+PH2+FkSr6lJB7/zPXNPs0gigHNzNf+RTqxfBBjptoDpWRgY88fJk/7CIt1fwEYqc+3jKWaLW0Uiae1sbWVD4PVsMlE3gf1WIGzr6DF/LQqBHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hw50HoVR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722858616; x=1754394616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9ovFynt3b40ahsg006bNqlL8urBMdE4VrkjwcfoBQ8A=;
  b=Hw50HoVRS56WI/b3TCXjPH5tR7U3rIe76M692ILYoYWMGHAFw5sy6TKQ
   YcmEWaaF5xU/y7GFkm82o06angGBgbjX0JsxHCQ87oTmVxWGdIDNTHlzO
   lWHkzxlui80LTbuRhg/PbGDY5dOYRWEbCSGAHFT9Jm39qZx8eXVlz6/+m
   nHEiJsWGf4cjav428GfXbUnah3+wDjWkIFj/564kcRdqB1qfajg513o6y
   DzvYp2bJ1pQFhjn0r3Z3YajGIXzZkjzWJiAxlK7RKV4lqERCXNFCvZV9Y
   6eXxrUFrhm67m4G9AwXRHjSC+QqJtk/WZH2+e5WyztbmS5pxrCpCEMOv/
   g==;
X-CSE-ConnectionGUID: S269MDwyRBqekPW3+XVpEA==
X-CSE-MsgGUID: Z0PRYUtwRjmJhFsLAc2LxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="32224199"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="32224199"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 04:50:15 -0700
X-CSE-ConnectionGUID: sC6W97SlQPGeA7dRqeCm7w==
X-CSE-MsgGUID: 7aGCM9hoStq7itt93NzysQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="61103007"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.12])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 04:50:13 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: intel_bus_common: enable interrupts before exiting reset
Date: Mon,  5 Aug 2024 19:50:03 +0800
Message-ID: <20240805115003.88035-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The existing code enables the Cadence IP interrupts after the bus
reset sequence. The problem with this sequence is that it might be
pre-empted, giving SoundWire devices time to sync and report as
ATTACHED before the interrupts are enabled. In that case, the Cadence
IP will not detect a state change and will not throw an interrupt to
proceed with the enumeration of a Device0.

In our overnight stress tests, we observed that a slight
sub-millisecond delay in enabling interrupts after the reset was
correlated with detection failures. This problem is more prevalent on
the LunarLake silicon, likely due to SOC integration changes, but it
was observed on earlier generations as well.

This patch reverts the sequence, with the interrupts enabled before
performing the bus reset. This removes the race condition and makes
sure the Cadence IP is able to detect the presence of a Device0 in all
cases.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_bus_common.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index 2bc960d05780..d3ff6c65b64c 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -45,18 +45,18 @@ int intel_start_bus(struct sdw_intel *sdw)
 		return ret;
 	}
 
+	ret = sdw_cdns_enable_interrupt(cdns, true);
+	if (ret < 0) {
+		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
+		return ret;
+	}
+
 	ret = sdw_cdns_exit_reset(cdns);
 	if (ret < 0) {
 		dev_err(dev, "%s: unable to exit bus reset sequence: %d\n", __func__, ret);
 		return ret;
 	}
 
-	ret = sdw_cdns_enable_interrupt(cdns, true);
-	if (ret < 0) {
-		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
-		return ret;
-	}
-
 	sdw_cdns_check_self_clearing_bits(cdns, __func__,
 					  true, INTEL_MASTER_RESET_ITERATIONS);
 
@@ -139,18 +139,18 @@ int intel_start_bus_after_reset(struct sdw_intel *sdw)
 			return ret;
 		}
 
+		ret = sdw_cdns_enable_interrupt(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "cannot enable interrupts during resume\n");
+			return ret;
+		}
+
 		ret = sdw_cdns_exit_reset(cdns);
 		if (ret < 0) {
 			dev_err(dev, "unable to exit bus reset sequence during resume\n");
 			return ret;
 		}
 
-		ret = sdw_cdns_enable_interrupt(cdns, true);
-		if (ret < 0) {
-			dev_err(dev, "cannot enable interrupts during resume\n");
-			return ret;
-		}
-
 	}
 	sdw_cdns_check_self_clearing_bits(cdns, __func__, true, INTEL_MASTER_RESET_ITERATIONS);
 
-- 
2.43.0


