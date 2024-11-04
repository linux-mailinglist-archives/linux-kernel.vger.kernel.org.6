Return-Path: <linux-kernel+bounces-394156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057DF9BAB3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373431C2166B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0E18F2F7;
	Mon,  4 Nov 2024 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmWosEi2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0918C030;
	Mon,  4 Nov 2024 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690643; cv=none; b=chZFcigOERnhP5WghuxcYgfMvohCobKwM/g/oum1uQc4uCP0sIDsgjFDPJXfoKOfDriB9uxBa3NCFRvCgjKqLiDmd0M6q3q4KCmKsg056EMNbz8wu2ZXrYtS/4L5eVCPbYiqXitCaInIBfhcPVjyBu0fgl9IVgAZnRAy96TmLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690643; c=relaxed/simple;
	bh=KoUskBTXBUY86r/8QhXh9AHgI3l1SllZZxO/ugjuwqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvOzznhpZkC8bjIIEb2Mw1pSJm0PDaeyjCFkWtsI1Nf1Nzil0PkAgJWra2f4f8S4Ky5GA9QCt/Z1RVPMB6UJZ0Kada/NWQ9wqw2+YJQz9Be0Hp1q0p4e4vMa5d6CgmXilQnExSu4l7aymRdW79/eSgAyYGHO+xCC9+KECQ9WSX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmWosEi2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690642; x=1762226642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoUskBTXBUY86r/8QhXh9AHgI3l1SllZZxO/ugjuwqE=;
  b=GmWosEi2vyV5gP4PDmrlLoEElY9+ZxWs1L+sHz1Sb/KzkYGt5hJPoKJA
   Hm9hL3qDtRiXYPvJ3mbeMp3sL6PYZaecH9EyqdJHLBAnRedUdRjwJAsP5
   iyzrkI5HbG3llHuLUYRW4mZmkX6AqJXLt/I425eH8bzTLqeddL/nw98Tt
   VqZti7WMZSVHeSKybeU8Bj4iGVzOULW7YOyHu+PgNVK7lAH6G5s0h3bhr
   Me5cj2dhuDt7WhHHtcpHCLJquTBKo2c27SRk5HnvQrtzlQlQOti68RYRb
   aC2JMNG1g4F1Li7lWQz5Wg6pVe1Ow3QndpxxGmtBX2MqwjLC3zQ81OBm0
   Q==;
X-CSE-ConnectionGUID: qRuql1bwQB6rAUGg3C5FaQ==
X-CSE-MsgGUID: P3YXKsrLT6OPCEiwWq/lSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594297"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594297"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:57 -0800
X-CSE-ConnectionGUID: qVDblZUvS7moqn5ZxztHtg==
X-CSE-MsgGUID: YExtx09/Rw2ELaa1/m3WKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331820"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:57 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 08/12] Soundwire: generic_bandwidth_allocation: set frame shape on fly
Date: Mon,  4 Nov 2024 03:23:54 +0000
Message-Id: <20241104032358.669705-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
References: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to recalculate frame shape when sdw bus clock is changed.
And need to make sure all Peripherals connected to the Manager support
dynamic clock change.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 .../soundwire/generic_bandwidth_allocation.c  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 2950a3d002ce..d847413141d3 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -327,6 +327,19 @@ static int sdw_select_row_col(struct sdw_bus *bus, int clk_freq)
 	return -EINVAL;
 }
 
+static bool is_clock_scaling_supported(struct sdw_bus *bus)
+{
+	struct sdw_master_runtime *m_rt;
+	struct sdw_slave_runtime *s_rt;
+
+	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node)
+		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node)
+			if (!is_clock_scaling_supported_by_slave(s_rt->slave))
+				return false;
+
+	return true;
+}
+
 /**
  * sdw_compute_bus_params: Compute bus parameters
  *
@@ -352,6 +365,10 @@ static int sdw_compute_bus_params(struct sdw_bus *bus)
 		clk_buf = NULL;
 	}
 
+	/* If dynamic scaling is not supported, don't try higher freq */
+	if (!is_clock_scaling_supported(bus))
+		clk_values = 1;
+
 	for (i = 0; i < clk_values; i++) {
 		if (!clk_buf)
 			curr_dr_freq = bus->params.max_dr_freq;
@@ -378,6 +395,12 @@ static int sdw_compute_bus_params(struct sdw_bus *bus)
 		return -EINVAL;
 	}
 
+	if (!mstr_prop->default_frame_rate || !mstr_prop->default_row)
+		return -EINVAL;
+
+	mstr_prop->default_col = curr_dr_freq / mstr_prop->default_frame_rate /
+				 mstr_prop->default_row;
+
 	ret = sdw_select_row_col(bus, curr_dr_freq);
 	if (ret < 0) {
 		dev_err(bus->dev, "%s: could not find frame configuration for bus dr_freq %d\n",
-- 
2.34.1


