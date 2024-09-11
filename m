Return-Path: <linux-kernel+bounces-324829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD3797515D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E24A1C20FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC8A19FA86;
	Wed, 11 Sep 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AA9EEnSb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9C19F133;
	Wed, 11 Sep 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055971; cv=none; b=mgG4Y+Fv23hz2BPE7J88Fq4vvoINqxEjiYwVcfTjbzH/bLQDst2RHm++NJ393/MmoMbrPFM8w7/aRxnmGOlkSsQFA4hW/nq/fUykBoJHT6LP3MqtXvzQ86H7UhjaIBIpXbYQD537V7NU160+Vs0zS7ZEBZJjOlReIFmNANTQGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055971; c=relaxed/simple;
	bh=tR8A1eViSyQSc4oQ1f/zM0XJtPGc9luqCHbxUT7oPnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glIo1aPnlHl+GGndutDtI0TSvD6iU9NjkHF/MPvJlLGuZSZK4Mz9cgtY2tOpH5ZEzXUNJyMsg4SoLWoO7UXUfmXxlLYIiSlDQxwpcXCwOJgri+IxwWvMQDo+eYJJSXQJAFl2W4ElfV2fU9qsWWXcXeZBqP1UmFdd2TsQGXuMFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AA9EEnSb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055970; x=1757591970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tR8A1eViSyQSc4oQ1f/zM0XJtPGc9luqCHbxUT7oPnk=;
  b=AA9EEnSbbbXeME1TlAccIhHEJ5LOXgN18lanHYW5NwclKJ4ojsjizArr
   JDTFCDFo/e0fe0edbS/ZKQ2slu6tWBlnXCthaiTRMtXcKoQn6uHnZbsQC
   zD8HUHmOzzuPVpidBvIOUvs8ncM7jplEDHh4vZWgnfdAdZEnbT21VZC/l
   HxkAMLhCND42fgi0fkQ9fLxJZA85gsDiqzCDgM7pomttCl7fUNaGr5PR2
   N4LKVYfxs7UrUsnIzLRM8lOyyeB8/6oLlT4NP5fWGDIzLDst9/AKzGis3
   uncsehqToB1GVRIQEiOhd4xktFNWE9fqZkk6njg5WPzaJ3+Zf5KxKIpso
   g==;
X-CSE-ConnectionGUID: f1gd+oJvRZKq5hUTY1HeDg==
X-CSE-MsgGUID: 8/FFL+HWQGatDDYvfRIrLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417272"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417272"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:30 -0700
X-CSE-ConnectionGUID: e27MVziTSjq4SPnfeqKeHg==
X-CSE-MsgGUID: IIkmz/++RgCr1TFvSLrPTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292801"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:27 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 11/14] soundwire: mipi-disco: add support for peripheral channelprepare timeout
Date: Wed, 11 Sep 2024 19:58:24 +0800
Message-ID: <20240911115827.233171-12-yung-chuan.liao@linux.intel.com>
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

The DisCo for SoundWire 2.0 spec renamed the
'mipi-sdw-slave-channelprepare-timeout', add support for the new
definition in backwards-compatible ways.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 5f42d23bbc85..6feba5631eae 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -344,6 +344,7 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	struct device *dev = &slave->dev;
 	struct fwnode_handle *port;
 	int nval;
+	int ret;
 
 	device_property_read_u32(dev, "mipi-sdw-sw-interface-revision",
 				 &prop->mipi_revision);
@@ -366,8 +367,11 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	device_property_read_u32(dev, "mipi-sdw-clockstopprepare-timeout",
 				 &prop->clk_stop_timeout);
 
-	device_property_read_u32(dev, "mipi-sdw-slave-channelprepare-timeout",
-				 &prop->ch_prep_timeout);
+	ret = device_property_read_u32(dev, "mipi-sdw-peripheral-channelprepare-timeout",
+				       &prop->ch_prep_timeout);
+	if (ret < 0)
+		device_property_read_u32(dev, "mipi-sdw-slave-channelprepare-timeout",
+					 &prop->ch_prep_timeout);
 
 	device_property_read_u32(dev,
 			"mipi-sdw-clockstopprepare-hard-reset-behavior",
-- 
2.43.0


