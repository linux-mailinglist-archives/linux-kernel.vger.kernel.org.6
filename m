Return-Path: <linux-kernel+bounces-303376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C709960B52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A28284A35
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06BA1BFE08;
	Tue, 27 Aug 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0HsLm5Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955581BDAA6;
	Tue, 27 Aug 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764084; cv=none; b=VUk+VkIkJK1AIILaRbOr3skL08XnOW3/xYEWrIOgaREVg57/oE5Jv5S1ZH2xhMcKBlp6Anp3/eraa6Lm819VLbfehHOCQyFILoux8ktool9loFjZbogGe3zKEIC8VClca6I4NqnkqW4DQ1XsyS2A699i0L16cGNOLlC86qo/ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764084; c=relaxed/simple;
	bh=gqV+DPaZQiWpZ8ck48YW8SBC25CmO7V6OVsBlat9ajg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6GgQw75UvITBntDZoMoMPtGDJBqmsmh5W/aOI1bfTRPoKqypr3YGJBqgHUTkpolVPRfSsDs+46GB02YQExBhqIgw3xHvQ5Xu9UA2Y4rEbF0QqLN4sJuuSZsguOZlpq1iSUCOlmYOJxANQQNQKXhip84W2leHbk7azEbQrOEwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0HsLm5Y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764082; x=1756300082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqV+DPaZQiWpZ8ck48YW8SBC25CmO7V6OVsBlat9ajg=;
  b=A0HsLm5YDzuRm0SBFYf2+Q0y3tFJSUTKttEihQ9vK1GAfMz8yhk+J1eC
   c8tBzPsNk7zeyLOwBacF3flb9KXGxN9aYfyO4+Jx5ebdRvh2+wGQQvGBe
   4dS3sh5UMH+4qv6jfy288XYgZvtlENeRcvg/7D8dmzSfxZlHnZC++6RB8
   W6k9yYd84Ouf98lmUjYfnHVPMm/BhQim38fiqxKE1RE6Wbswsus6jwsEu
   nLbb6PbPUCXAaZbykanbnxUC21wkrCqSE76L3hvyDFHCOpPhZX/9VOyd5
   Mo3Ta5LRbGi/pT28HAJjQ99v0EE1rl6Nekb3ekepZIA5oMwcInA218DKC
   A==;
X-CSE-ConnectionGUID: nJP9AJX4SguxgDa79B5woA==
X-CSE-MsgGUID: gZuq7d2eQmOachtDdztFNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400524"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400524"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:02 -0700
X-CSE-ConnectionGUID: j9e1Uqf2TMOat6nhKIXmKQ==
X-CSE-MsgGUID: 9CxeIsNuRUmVzZn1vAZPjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67551953"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:00 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 03/14] soundwire: optimize sdw_master_prop
Date: Tue, 27 Aug 2024 21:06:56 +0800
Message-ID: <20240827130707.298477-4-yung-chuan.liao@linux.intel.com>
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


