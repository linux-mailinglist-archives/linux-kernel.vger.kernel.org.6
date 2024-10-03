Return-Path: <linux-kernel+bounces-348651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D7B98EA15
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E233C1F27B88
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85120130A7D;
	Thu,  3 Oct 2024 07:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmyunMig"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83382C7E;
	Thu,  3 Oct 2024 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939251; cv=none; b=j8PY1MhSaZ3dw7CG+FWgT5Yr/dJ8pUMxZZMdDW8lsLqaVZPeK+gzQD0haD4l72ohiZ5oYVJ45CbQI+YiHiyrqOc9M0ccDiyemqIlK3Scs1QUP27NRfgdNoVgWOj5km9PcvaD7hJ24jGszwOFzhuR1y2vdwpYDqdtjtuHoAdqG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939251; c=relaxed/simple;
	bh=gqV+DPaZQiWpZ8ck48YW8SBC25CmO7V6OVsBlat9ajg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guqLJfzCAeNoe1bztGsD85Mjx6pUTaJtbBqILZ/ZCBlmt6SxYXRCJqZHw2xmIn/9ostg2OdgOVnMmb3anv4aFzB2Q0/I8CBM+i25yxHjdV4hovEJBc4azPxJwrR6n7fIYNIfBAURPIlkZFA7UANApwL4N08SnX8tydBRBxHINiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmyunMig; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939250; x=1759475250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqV+DPaZQiWpZ8ck48YW8SBC25CmO7V6OVsBlat9ajg=;
  b=dmyunMigjtfrw9m7GbpSfCD8LK5fAzoFX2mzwUvGbXVMenjpa2SViVjJ
   wtaKPcLaXvDhTEuJ6DlcdEQudu/r9MmgZ9jvoa676uz4uqBU6ztV5KRlP
   Pc5b3CGVXtOSO4+oG2PLsLamljwrdoTtLw+eUPxmKJvVkQiUI9ooINxAA
   WPI8neAGTBMuZxdDeBgu51gWuEP65uA+iwsegMqg78tCZuGaioKVZg8yW
   mnV0r4E5Pr3D2uEcpGugns0dp6GfjTC0Hs8kuXuZimpAwJRMSKgaANR9c
   MJ2V/ygz5BpNy1Bsz1FSoBt195AAqVtXJeEMRHw7wktFmrv5JjOf3cNB4
   A==;
X-CSE-ConnectionGUID: qVjvY3vaQ9qJsI36wRlT6A==
X-CSE-MsgGUID: Wud1lKb1R3qrQNrhsRvhhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070736"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070736"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:30 -0700
X-CSE-ConnectionGUID: JXeM4hXqQUWWKO2rYhBPdA==
X-CSE-MsgGUID: Bqdxg5PcS0+pesKDFVFGwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508389"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:27 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 03/14] soundwire: optimize sdw_master_prop
Date: Thu,  3 Oct 2024 15:06:39 +0800
Message-ID: <20241003070650.62787-4-yung-chuan.liao@linux.intel.com>
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


