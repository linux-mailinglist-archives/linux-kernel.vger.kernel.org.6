Return-Path: <linux-kernel+bounces-324821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB014975155
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6921A1F26300
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C46188A1D;
	Wed, 11 Sep 2024 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjtVwwlr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC0193092;
	Wed, 11 Sep 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055950; cv=none; b=gNSV63Xy5ZSJ67k5uzz/PBS4HM+eIm+DFYOWbDyv4zy+T+FilQtOZwKt7xQM+t2jNtjfnVM/5xgVUjiM+GpSqfNl2Sx1Mds7+q6dl4MHic6hduvC1mPVFzR20tHlI7WCtmXdSGG7KmJlDMKE1dhXpgJdNmjd5XAQJMsCMhk6TK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055950; c=relaxed/simple;
	bh=gqV+DPaZQiWpZ8ck48YW8SBC25CmO7V6OVsBlat9ajg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSCI3QEfPTN1sqVzPwGYDTNJrYMLhLFBFM7IpKNTZOShWDYoyyAzI6yVNfCIzHlHhnyXUi4pSJeXtvKVCaCp+fzBcGkcAshMNCLkHiSECLXLr4HQKfEiBhChvVeNC2lPflYeU14YuK96PUejLDQ+uWCcCwcEJMVN2xyUdUxOpVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjtVwwlr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055949; x=1757591949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqV+DPaZQiWpZ8ck48YW8SBC25CmO7V6OVsBlat9ajg=;
  b=JjtVwwlrmsEOc1WSv/G0mQ6LWI6PZ9AiozXrDgQ9x63/4rwZQmWUgPYD
   kkV+sDuZbfb7BWg4UpT80huLIOAHOcYIRCdR2KQVxtdefrX3Q5cGQhmzF
   wwf6/NC47Yllj2Vz02whpH3KrjmWb7YXKUU7oASW3LkJL7xOmcUUAPka+
   qgPEmz8tG04pcGa8BSuI2qLHMwhLjcBd0VE1ARiswKDtPdJ7nOVfG22yT
   imnL8Aw/0PoUuOc1uaXNpI2URsQQ8MzrZuobQDhYmBY+ZBqnQtw8pcGoL
   xZOQ43kfUyLnE9wKnAoTLjzDBmXn9l3VBthVsD/lfJKD57ntmYTMDF2ey
   Q==;
X-CSE-ConnectionGUID: ua+SRcLmTP2lODspd83z+g==
X-CSE-MsgGUID: oc9tbXxdQ+2Ot0n1e1b51w==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417227"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417227"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:09 -0700
X-CSE-ConnectionGUID: Fi3t/gOXRwmUs4ui1ydOsg==
X-CSE-MsgGUID: 186p3x3iQOCt4FeKaZRx6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292730"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:07 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 03/14] soundwire: optimize sdw_master_prop
Date: Wed, 11 Sep 2024 19:58:16 +0800
Message-ID: <20240911115827.233171-4-yung-chuan.liao@linux.intel.com>
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

Make pahole happy by moving pointers and u64 first instead of
interleaving them.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index a4fa45132030..2caea7345c3e 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -406,13 +406,14 @@ struct sdw_slave_prop {
 
 /**
  * struct sdw_master_prop - Master properties
+ * @clk_gears: Clock gears supported
+ * @clk_freq: Clock frequencies supported, in Hz
+ * @quirks: bitmask identifying optional behavior beyond the scope of the MIPI specification
  * @revision: MIPI spec version of the implementation
  * @clk_stop_modes: Bitmap, bit N set when clock-stop-modeN supported
  * @max_clk_freq: Maximum Bus clock frequency, in Hz
  * @num_clk_gears: Number of clock gears supported
- * @clk_gears: Clock gears supported
  * @num_clk_freq: Number of clock frequencies supported, in Hz
- * @clk_freq: Clock frequencies supported, in Hz
  * @default_frame_rate: Controller default Frame rate, in Hz
  * @default_row: Number of rows
  * @default_col: Number of columns
@@ -421,24 +422,23 @@ struct sdw_slave_prop {
  * command
  * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
  * @hw_disabled: if true, the Master is not functional, typically due to pin-mux
- * @quirks: bitmask identifying optional behavior beyond the scope of the MIPI specification
  */
 struct sdw_master_prop {
+	u32 *clk_gears;
+	u32 *clk_freq;
+	u64 quirks;
 	u32 revision;
 	u32 clk_stop_modes;
 	u32 max_clk_freq;
 	u32 num_clk_gears;
-	u32 *clk_gears;
 	u32 num_clk_freq;
-	u32 *clk_freq;
 	u32 default_frame_rate;
 	u32 default_row;
 	u32 default_col;
-	bool dynamic_frame;
 	u32 err_threshold;
 	u32 mclk_freq;
+	bool dynamic_frame;
 	bool hw_disabled;
-	u64 quirks;
 };
 
 /* Definitions for Master quirks */
-- 
2.43.0


