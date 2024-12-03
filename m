Return-Path: <linux-kernel+bounces-429530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9C69E1D6C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A479166070
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505FD1F7099;
	Tue,  3 Dec 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etfT3cAX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641781F706B;
	Tue,  3 Dec 2024 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231924; cv=none; b=k46JkzbrmMquAqfgf0L+wbIgECjoDRmvuZqiv4SKcpfdSs6wm2n596sL8XWcbN3W6pWITOFg3h0smpNX6I3nw+wobahvM2DnTso0hw06/yNGIJdsgLMT3B5cCaRqyEJAYAGuNxj9NJuJtgb65DPsiZE8YPEd3DpVCBnvHbp8FZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231924; c=relaxed/simple;
	bh=HY0GNF1CvwcueXSIXst2p1u/o3/tB9VIM8vkl1ZIo70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9mjzV5+HH0Fw3XS9qKo5en253Cr4Np++ibM8tNB29clspBk+sKjzh3uMRsedt+oUmrhdwRSsiVdzbY+Lq58XTZSR04B2/Ew1y+8Ss6qy0yaUjvD6psTRDVheeh5ZnN5uGuuLQvGQM6NxZBPYgzhg9YtR7N+cd3Ftws3k6y/CmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etfT3cAX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231923; x=1764767923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HY0GNF1CvwcueXSIXst2p1u/o3/tB9VIM8vkl1ZIo70=;
  b=etfT3cAXpUSR+u8Yzbt4xHjvul3isCO4wd78rCfe0E4C4J0rwA+Jk9em
   L5a7dtPuDYTCaxczVAnhRflDxRIDoxxZ64itaciU+HomBHkTXzcDQp9Sd
   4AW6Yps4bGKVQY832KZzILY2nd22jHglMAzU7vGQXrbaUyCaPoHLg9Gu2
   hbIA4I9xH2pWr+vqH9jaLg2axc2W8zUSGLxJBcADSUwGfukUGtYVxdjLL
   WX1jiaO8MnD/q0v8p4VV+BsFhUlf0Lta4tS37W4FZuJPdDcneZObIgWXn
   yl+Xj6aGG2Umfw/9+3D8K8auAXEMSCIkO82ZRDdqxEhaW5HmWQwHLyoKs
   Q==;
X-CSE-ConnectionGUID: az1kNOYcQde9cg8wJaZGVA==
X-CSE-MsgGUID: SVcQt5ZCTtW3oQBfCgMCnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500762"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500762"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:43 -0800
X-CSE-ConnectionGUID: Ti907PVLSiCcPlxuHj1XGA==
X-CSE-MsgGUID: 4jEVKcacTC+VEAupVPknKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896126"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:42 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 10/14] soundwire: generic_bandwidth_allocation: check required freq accurately
Date: Tue,  3 Dec 2024 21:18:09 +0800
Message-ID: <20241203131813.58454-11-yung-chuan.liao@linux.intel.com>
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

Currently, we check curr_dr_freq roughly by "if (curr_dr_freq <=
bus->params.bandwidth)" in sdw_compute_bus_params() and check it
accurately in sdw_select_row_col(). It works if we only support one
freq. But, we need to check it accurately in sdw_select_row_col() to
give it a chance to use a higher freq or use multi-lane.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 5c4dac36ad1a..d2632af9c8af 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -373,7 +373,8 @@ static int sdw_compute_bus_params(struct sdw_bus *bus)
 				(bus->params.max_dr_freq >>  clk_buf[i]) :
 				clk_buf[i] * SDW_DOUBLE_RATE_FACTOR;
 
-		if (curr_dr_freq <= bus->params.bandwidth)
+		if (curr_dr_freq * (mstr_prop->default_col - 1) <
+		    bus->params.bandwidth * mstr_prop->default_col)
 			continue;
 
 		break;
-- 
2.43.0


