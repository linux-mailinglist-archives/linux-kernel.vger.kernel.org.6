Return-Path: <linux-kernel+bounces-348662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E754098EA25
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0C7289298
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6B12C465;
	Thu,  3 Oct 2024 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrLWoLwl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66514D2BD;
	Thu,  3 Oct 2024 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939277; cv=none; b=h7P4kkJIvib5wHn/QydJuYwk0W2AbWeOGiQJjSl4KQCbX+scs+RzvYbUP3sYba8HU1b9XLoj3bASR9mzRcAFr0XExWI4k8N2Yeu2BLybgIkrdUmwUT8IiAjCga+K2r6fN0VV0qVDJ53HfAcImVlrVwX4sW4hY2PZZnMB8SVFjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939277; c=relaxed/simple;
	bh=8QxpkFSxoNjBvdT/4TaTLNU6cNZOZw6ufXE7ms0iV0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBOcM/lM1+fjV2VvYNaUSxdLeOV1/rJsaTkGhYiMg4IHxPqoq3z390levBMQgFdnuw78Q748qV/9fyPIRNrGChp809mDTIAsQQbfjznluz7sIEVPqpd/H3BZm2FoN5+Dh/l0mcfUMUf0cPaaqCzgR2KqCruLNeFjoaWRIk8Hf4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrLWoLwl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939276; x=1759475276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8QxpkFSxoNjBvdT/4TaTLNU6cNZOZw6ufXE7ms0iV0A=;
  b=RrLWoLwljuyTvWAMPL72lTHw3jB/jZFKYXVGiOKs4qn2TtK0kPe4R5aJ
   g/s724g10Q3yJeXDHQpMm2jfwQ4/yF5XLDZo6i2pGU9LKg8Tl/asd7ztK
   YYYut10GoS0NxyoaUW31OuFslOsZRorAFzsyIjrgh8GNu/LaODTkhuRKy
   hKrRqk3J2WXP91cnEN8SfF6+rCkgJwQ7gnYO6lGuDmH0oyarqPODal7v/
   0fEB+HeJHKKR7v6MyJtWfJnHHoB/hV+MGXqLRtzx1yo4VWsupFkGRV4Ad
   w/olLycie/E5s8QJ+0oQDgz1ZQVoKnTawnMqOItaXIQBNTYeyUQLjA6sm
   Q==;
X-CSE-ConnectionGUID: EaxBXnIIR7GrRon/AD4Ipg==
X-CSE-MsgGUID: aYJESn8qS6euh9ky4GMD0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070805"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070805"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:56 -0700
X-CSE-ConnectionGUID: 9FB7ddP3SsiJu2kej1xG2Q==
X-CSE-MsgGUID: ty/onVeHSjOC3fcGRqaK+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508430"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:53 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 13/14] soundwire: mipi-disco: add new properties from 2.0 spec
Date: Thu,  3 Oct 2024 15:06:49 +0800
Message-ID: <20241003070650.62787-14-yung-chuan.liao@linux.intel.com>
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

The DisCo for SoundWire 2.0 spec adds support for new
'mipi-sdw-sdca-interrupt-register-list' and
'mipi-sdw-commit-register-supported'.

This patch only adds the definitions and property reads, but the use
of these properties will come at some point in the future when needed.

Note a slight conceptual disconnect between the MIPI DisCo definition
of a boolean property and the Linux implementation. The latter only
checks the presence of the property to set its value to 'true',
whereas the MIPI definitions allow for a property with a 'false'
value. This patch uses the new introduced mipi_device_property_read_bool()
to handle it.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 6 ++++++
 include/linux/soundwire/sdw.h  | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index d6eb63bf1252..36e734751225 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -398,6 +398,12 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	device_property_read_u32(dev, "mipi-sdw-sink-port-list",
 				 &prop->sink_ports);
 
+	device_property_read_u32(dev, "mipi-sdw-sdca-interrupt-register-list",
+				 &prop->sdca_interrupt_register_list);
+
+	prop->commit_register_supported = mipi_device_property_read_bool(dev,
+			"mipi-sdw-commit-register-supported");
+
 	/*
 	 * Read dp0 properties - we don't rely on the 'mipi-sdw-dp-0-supported'
 	 * property since the 'mipi-sdw-dp0-subproperties' property is logically
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 66feaa79ecfc..952514f044f0 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -335,8 +335,11 @@ struct sdw_dpn_prop {
  * @master_count: Number of Masters present on this Slave
  * @source_ports: Bitmap identifying source ports
  * @sink_ports: Bitmap identifying sink ports
- * @scp_int1_mask: SCP_INT1_MASK desired settings
  * @quirks: bitmask identifying deltas from the MIPI specification
+ * @sdca_interrupt_register_list: indicates which sets of SDCA interrupt status
+ * and masks are supported
+ * @commit_register_supported: is PCP_Commit register supported
+ * @scp_int1_mask: SCP_INT1_MASK desired settings
  * @clock_reg_supported: the Peripheral implements the clock base and scale
  * registers introduced with the SoundWire 1.2 specification. SDCA devices
  * do not need to set this boolean property as the registers are required.
@@ -363,6 +366,8 @@ struct sdw_slave_prop {
 	u32 source_ports;
 	u32 sink_ports;
 	u32 quirks;
+	u32 sdca_interrupt_register_list;
+	u8 commit_register_supported;
 	u8 scp_int1_mask;
 	bool clock_reg_supported;
 	bool use_domain_irq;
-- 
2.43.0


