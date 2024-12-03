Return-Path: <linux-kernel+bounces-429528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881339E1D6B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558E31657D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8441EF08F;
	Tue,  3 Dec 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUDVfkqK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D0B1EF0B6;
	Tue,  3 Dec 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231922; cv=none; b=bPfedX9xI9bskDjw88tLXVjdt0ZI5RP54KpfhdO3XoUOnfhGI7YMQxbybdyscSlc3gzbZ3munZziZ45ROCpWE4MpfE11yTfN5SjeZ1wNXDfa9AgJcw6wipWaYgVaaZtf0a/ogl0i2XG/QeYDUfsBxbAe0oeAWC6TAgz7ttlt0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231922; c=relaxed/simple;
	bh=ApjkdRYwQ2ORFr53CDMbK49sgSkAU2vxCx5m+FcoCxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/iRGi1YhoJBvM618ZiHkevybG9QWmGV+MTasN7y7W6FzZc23bpA7Xmg5QCBiN80q6hA4kQ6a54zEHKWSsrmLrvdFQAdMOQITkcuyFQXD1E/RmNMW2Y1GaH/b+S1eMRhdJ1O7xfS6DU+CSHNCGykWTfURTTSOvmi40QX9DQA7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUDVfkqK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231921; x=1764767921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ApjkdRYwQ2ORFr53CDMbK49sgSkAU2vxCx5m+FcoCxI=;
  b=hUDVfkqKjjukytgHZIDihYP1i69WrznMFvyCgO6yMYkAf2L9kuXFgOsN
   5/ln3aQ1W2llxufMVJoyH86c5joA7ehI0cG5XX2YmzCVHfrKDmctamYY6
   PUkniogz8sSEGJ2/oKzyfisD0tXFAkS8k17YvR363OyHfrMQr/KDlplkY
   aBtA1f6Y1mYkF3iADlLmJehoaKOC2PapRy0PBlxoEq+O8Icvs2eygV9TU
   n747Tb7DDhaUfsnLrZe2bqXnJIyc3hqozNEBUhIVuyW9hsskunOH++gRO
   JvwgJ0wMuBWSHJr8QX851UkJy2Wiw07tffVgdil64eJPD2l1e9RCe/GsR
   w==;
X-CSE-ConnectionGUID: u0HRHHy6TgSgdc8Eo46PXA==
X-CSE-MsgGUID: VTEkZykeRrGUQuR2KJHIGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500753"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500753"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:40 -0800
X-CSE-ConnectionGUID: 4jIowKB8QqaMK/cdWVeRLA==
X-CSE-MsgGUID: cEs68dm9TcmXhzcLm8qgsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896109"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:39 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 08/14] Soundwire: generic_bandwidth_allocation: set frame shape on fly
Date: Tue,  3 Dec 2024 21:18:07 +0800
Message-ID: <20241203131813.58454-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
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
2.43.0


