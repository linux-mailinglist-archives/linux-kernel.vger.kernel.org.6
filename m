Return-Path: <linux-kernel+bounces-240363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93132926CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504CB1F22F07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBB979DC;
	Thu,  4 Jul 2024 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+GM3/74"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33827748F;
	Thu,  4 Jul 2024 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053277; cv=none; b=hadJlg0vkWFgSuWh+YMinkd2XKp3njcGFijyqeAE8bVnBCQcZ35OsU74cVZ9SX+sgaS/+kVJnVOTK0SoMWBmzle0XHP42WJgtPjtdi3Rlc+qx7EDJeS80M8mrlo5IYUl0ZmH0AaFsSezKb+lAeOkyc3giE0At51NZGwNaWNO5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053277; c=relaxed/simple;
	bh=iduZoLfEe6fCd6EV59/339DKsF+6HAe/yjTx7nWTOmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GIUUy7Y9QQphN6AKvPYFE8Kn7KQ+5l9ASlpLe4hKwaBbbfPeYCHaCfVsv9SWJH6kd+Jp2UUrDAXlH+/eowj/HopPrWLabTHd5RrFcHliHZqjJa7mSgyqlTiuQD5dJrF5einQwj+q5LIqdoeMPvCbgA3vtGnOuETNpyp7K64dw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+GM3/74; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720053276; x=1751589276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iduZoLfEe6fCd6EV59/339DKsF+6HAe/yjTx7nWTOmI=;
  b=h+GM3/74LtcpKwb2fwI6smHT/shWlodkxgKY+pDe91ZIunoMyItLXO8f
   tuob90OHWl6ee09gqqam97U2hkqYIhZ85qYMJJe+4C8uO6iaLqBMLX0w+
   Ixo7qEWAbqJ/8Af/HhZbVlZyTrAO9O+E+fgUVOXQuX/D+kmqvj4jXw9yc
   tfzPYNeqFtZM+rub96bVeE/7yOlPqcmKxk5V53zO/mtRkHjNEltfEINkW
   IPbq0fxpFPvrsBde/KRtDhRsg/fQXpr3rsSbyxAGkxQIs61eeg8fIdBXt
   q6S+/SJ2NW/duqMOixVHBH1+QN/i4metJE/P9IUSOGjK9s5OlueyDwjfJ
   w==;
X-CSE-ConnectionGUID: x+0dAvLlS4m2IO7rAVA2Yw==
X-CSE-MsgGUID: 2CsJKb9WQI2/ByKPZyDXjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="21118870"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="21118870"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:34:36 -0700
X-CSE-ConnectionGUID: 9p2x86pBRoygUSwNfQD/VA==
X-CSE-MsgGUID: IJPEtiz/QICKl7sH4hpcWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46364525"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.119.127])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:34:33 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: intel_auxdevice: start the bus at default frequency
Date: Thu,  4 Jul 2024 08:34:11 +0800
Message-ID: <20240704003411.10347-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

When platform firmware exposes multiple supported bus frequencies, the
existing SoundWire support selects the maximum frequency. This is not
aligned with the SoundWire 1.2 directions: the MIPI recommendation is
to start at a 'safe' speed, compatible with the default frame rate and
shape, and only increase the clock when vendor and codec PHY
parameters are updated.

However, clock changes are not supported for now by the SoundWire
core, so in practice this patch has the effect of discarding
frequencies different to the implicit default. Dynamic clock changes
will be required at some point, and this limitation will be removed
after the core is updated, specifically to perform synchronous clock
scale changes on manager and peripheral sides with a bank switch.

On Intel LunarLake platforms with a 'standard' DSDT, this forces the
use of 4.8MHz. On older platforms this patch has no effect.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 54cb455ed870..64ca55c1c94b 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -209,9 +209,30 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 
 static int intel_prop_read(struct sdw_bus *bus)
 {
+	struct sdw_master_prop *prop;
+
 	/* Initialize with default handler to read all DisCo properties */
 	sdw_master_read_prop(bus);
 
+	/*
+	 * Only one bus frequency is supported so far, filter
+	 * frequencies reported in the DSDT
+	 */
+	prop = &bus->prop;
+	if (prop->clk_freq && prop->num_clk_freq > 1) {
+		unsigned int default_bus_frequency;
+
+		default_bus_frequency =
+			prop->default_frame_rate *
+			prop->default_row *
+			prop->default_col /
+			SDW_DOUBLE_RATE_FACTOR;
+
+		prop->num_clk_freq = 1;
+		prop->clk_freq[0] = default_bus_frequency;
+		prop->max_clk_freq = default_bus_frequency;
+	}
+
 	/* read Intel-specific properties */
 	sdw_master_read_intel_prop(bus);
 
-- 
2.43.0


