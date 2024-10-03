Return-Path: <linux-kernel+bounces-348661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521B98EA24
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78591C221C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F1C12A14C;
	Thu,  3 Oct 2024 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gy1BbbOd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA030146D40;
	Thu,  3 Oct 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939274; cv=none; b=lxoMm/xq8HIM0jI+BKmsCMGmoJILg3gJXNexJnWU5Nd+nvPpiDJ67Tfy9uYcfNxUPONnJrody7WsE/33LNF8ZMBi3/oYR3Fq1IWrHNPHDWDKWugJwD0t30LNtEiruUeMsSAX51pcXErUE4zCqFXC3KvfmC+wCW/17ScXDJtQgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939274; c=relaxed/simple;
	bh=ZB3aqSPbxq3S58RNyPbBpF2vKgfog9SCStSlk2aXwzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9v/H8mWAEHsX7RhT1zHUP/kQhM39l654Ymg8Kyn46vCuD3l4gwdTUaimyzXNB2zXHdRRx/Rdx+kJICL4XKC18jfBzSIqzLUbo4pmp2Jr0qhON4Bxl5jVATrDv4/5+ekRDFR8m7H5q4uQxU4jX/3C2zhjqwlLjJA7MJ2Pz5HHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gy1BbbOd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939273; x=1759475273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZB3aqSPbxq3S58RNyPbBpF2vKgfog9SCStSlk2aXwzI=;
  b=gy1BbbOdYIuoZwYbksFfoKOigw2VIvgS8F1+vxUtZgzbym7RIF6Bq2/i
   w1ZN25fItErmfQpqiG8lLesU7Tpehls8t7eoX/StguQKuHQNXiDmzV/KL
   Mu5aBw9x7L/23L/8G6QGEEX5ypB/jiUAuFv6nabt4am0OaHyP8S5eD5VU
   UYcaaTuPEQTfHb0b9S5hriSYK2MxtOMCxoxupzUAlgfZ4mdarRHCu+xjF
   D4BJ/0spwhnF+uRhZIBIg6NIPO8mw4gZuD9Srs2j5Lqwn/mEYA1hpzrYg
   pZqCrzDD2xiEbQVYiffqYB7QicAp4/u9DajNMBD+S4YvMaxTDAeVis3jk
   Q==;
X-CSE-ConnectionGUID: w7qDwYVCQdWXU8+zFvIkjQ==
X-CSE-MsgGUID: beWwHlmGSlqcptvjFcA7Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070797"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070797"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:53 -0700
X-CSE-ConnectionGUID: cMwgDRmXRKmi8rCfN7YALQ==
X-CSE-MsgGUID: TgDmnMDJRiaPp4hg4uF7vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508426"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:50 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 12/14] soundwire: mipi-disco: add comment on DP0-supported property
Date: Thu,  3 Oct 2024 15:06:48 +0800
Message-ID: <20241003070650.62787-13-yung-chuan.liao@linux.intel.com>
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

The DisCo for SoundWire 2.0 spec adds support for a new property, but
it's not very helpful. Add a comment to explain that it's
intentionally ignored.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 6feba5631eae..d6eb63bf1252 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -398,7 +398,11 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	device_property_read_u32(dev, "mipi-sdw-sink-port-list",
 				 &prop->sink_ports);
 
-	/* Read dp0 properties */
+	/*
+	 * Read dp0 properties - we don't rely on the 'mipi-sdw-dp-0-supported'
+	 * property since the 'mipi-sdw-dp0-subproperties' property is logically
+	 * equivalent.
+	 */
 	port = device_get_named_child_node(dev, "mipi-sdw-dp-0-subproperties");
 	if (!port) {
 		dev_dbg(dev, "DP0 node not found!!\n");
-- 
2.43.0


