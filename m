Return-Path: <linux-kernel+bounces-324830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D0197515E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5035E289CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C67A1A257F;
	Wed, 11 Sep 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJzEK8no"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358831A01BF;
	Wed, 11 Sep 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055973; cv=none; b=aJz5p5cwNBqfuSmsNt1O7xNav96rZkcAeDAo6CLXxOSqD/YXOAWfbv3PxMTA9ZWSwGsCQb6CYbtb9MFhSSRRwi4eib2lQUVawl6RWu+7jBjSTB6uPpZLNZ/I2pPbEwONSf3Dk3yy/mUZl6fMTIMOIX54wU/ki9Xvfn1KyfuSJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055973; c=relaxed/simple;
	bh=ZB3aqSPbxq3S58RNyPbBpF2vKgfog9SCStSlk2aXwzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+IirxKjdcRELCAl9pw8/YZG7sNpU4djVlFmcWPun5JZrKCz0quSC3WJUOe0ES3jVi6ur9IXoD+so1bafkwm4YpF5CHHnFxM8DTUTs7mS8rPLtXLigmom0CpZaNI4Yj1gBWCLBOeFuf6+INN+4LtVu5Cq+b7wfhL3o36CppWwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJzEK8no; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055972; x=1757591972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZB3aqSPbxq3S58RNyPbBpF2vKgfog9SCStSlk2aXwzI=;
  b=jJzEK8noxKYf6VhXOhWZrCW5qZyFvot6C+FsvlOiKsrYZp1rAKnlvdvl
   V+FLaXCgWrekB2MUB5ETzHzUExFo5m+mdDqfhh6iywknCnxmYYAaf7u++
   Q85B8A3MhOgqDhsApRhRuApWooiiy1kkCjW8SCfkPzbCediwYaA23/wZc
   Hq+Kt0NY9cX+HgyJKaI9H9xiPWcCa/nac9FXenbQWpwBopkReoDP5U2wB
   nWncIv2Q8uu0/LGPdrRLt0D5IW4ji5CqYR81pqwz5h8PZK4JzPIO1t0f3
   YVnp+aD2N39OJggej4pR5td9+diVPOmnlsbcY5Z3ilTKXu3eoEALFEVJ2
   g==;
X-CSE-ConnectionGUID: XlgRvSILQuqSGYhlsmfVZw==
X-CSE-MsgGUID: Ex0Y5bi1Soa9Eyh3GSYa6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417280"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417280"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:32 -0700
X-CSE-ConnectionGUID: /wkxpD0mR3OXBS8QenhA6Q==
X-CSE-MsgGUID: SGks27XXQD2qLo7yDeOXZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292810"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:30 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 12/14] soundwire: mipi-disco: add comment on DP0-supported property
Date: Wed, 11 Sep 2024 19:58:25 +0800
Message-ID: <20240911115827.233171-13-yung-chuan.liao@linux.intel.com>
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


