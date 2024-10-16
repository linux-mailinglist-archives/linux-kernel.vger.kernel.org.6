Return-Path: <linux-kernel+bounces-367825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518999A0742
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B441F24DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830DC20821A;
	Wed, 16 Oct 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCCGfRXH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FA20821B;
	Wed, 16 Oct 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074243; cv=none; b=lZ7N/mYl6YIVIRmD/OA0Gl7/mvYHCbZ7psABY0Qr4vxO3rWth9FqJy7vpqsR688YH7hr/p/YCmB7OdHYVmGjgCGgyiwOzodSb2i4Dav6jTPgCkDxCxIJFIq2fkW1Cu6GynCQUrTQyK1mMYc2yEIiVfVCcZHgt0sb0MpTeCMgI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074243; c=relaxed/simple;
	bh=kRto2Vxs+QZGWQmqTFa0+UrJ1B4FDOrZfg6FGj1DPak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0Ntd0whAHE5rw/4osuE1GiMlZfxXgdvdDNMq/ZOE/SrptIckQ88UKLClBbkz9bmly0JabCriDvQ8SEElkUxgo+O5tCug+IBZdz/PriP+5nNuKkuENB9VAtcfked3KrwscWq+9hycA6E2IBDhMmMDK0DgEm14AQa6JcrUvs5FMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCCGfRXH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074242; x=1760610242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRto2Vxs+QZGWQmqTFa0+UrJ1B4FDOrZfg6FGj1DPak=;
  b=SCCGfRXH+57d0NtnhKzNXYgFU4J+wt5Iq88FU0JnIDuBcGHcoI1YYj3b
   MarPFuSPQmZx2Fp2zsCcexoKJuCFAwMquLuvWTfZYSFFO/QfT+BdpYaLN
   2GDY7GYSh3B3lfiwOtasjhP/h+8qw7Pn/EadMrOG16gibnad+vZnDNJPb
   +hdYCiPRjFA3ztDiYIcFw0HjH/UulnZpAxxwmXAkQsR9YbhDXuw4gWPz0
   Lr7i9UgEe8BuMWm2Vr0j/nnhtd1YEiWlLcdMs/9RRfgnJd3UzMJxRgcAJ
   lHvU01mKL9pcO0XZEyLyfUUDajHnQ/JRWSohr3r5R4jVHMGrWbaoJfiPm
   Q==;
X-CSE-ConnectionGUID: +W7dHz8iS+CYPzHN43gl9Q==
X-CSE-MsgGUID: YtZXd4ekQuKHuiWdgrgxgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985889"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985889"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:01 -0700
X-CSE-ConnectionGUID: 6kBq1D5ASJ2tWrukyPoceg==
X-CSE-MsgGUID: AvJSmFVrTr2FzlgiydFL/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82960870"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:23:58 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 04/11] soundwire: slave: lookup SDCA version and functions
Date: Wed, 16 Oct 2024 18:23:26 +0800
Message-ID: <20241016102333.294448-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
References: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Use SDCA helpers to get the basic information and store it in the
slave context. The information will be optionally be used in codec
drivers to register sub-devices for each Function.

When platforms are not based on ACPI the helpers do absolutely
nothing.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/Kconfig |  1 +
 drivers/soundwire/slave.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 4d8f3b7024ae..f66f869dff2e 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -6,6 +6,7 @@
 menuconfig SOUNDWIRE
 	tristate "SoundWire support"
 	depends on ACPI || OF
+	depends on SND_SOC_SDCA_OPTIONAL
 	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index f1a4df6cfebd..97cf8bcca047 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -5,6 +5,7 @@
 #include <linux/of.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
+#include <sound/sdca.h>
 #include "bus.h"
 #include "sysfs_local.h"
 
@@ -70,6 +71,17 @@ int sdw_slave_add(struct sdw_bus *bus,
 	list_add_tail(&slave->node, &bus->slaves);
 	mutex_unlock(&bus->bus_lock);
 
+	/*
+	 * The Soundwire driver probe may optionally register SDCA
+	 * sub-devices, one per Function. This means the information
+	 * on the SDCA revision and the number/type of Functions need
+	 * to be extracted from platform firmware before the SoundWire
+	 * driver probe, and as a consequence before the SoundWire
+	 * device_register() below.
+	 */
+	sdca_lookup_interface_revision(slave);
+	sdca_lookup_functions(slave);
+
 	ret = device_register(&slave->dev);
 	if (ret) {
 		dev_err(bus->dev, "Failed to add slave: ret %d\n", ret);
@@ -259,3 +271,5 @@ int sdw_of_find_slaves(struct sdw_bus *bus)
 
 	return 0;
 }
+
+MODULE_IMPORT_NS(SND_SOC_SDCA);
-- 
2.43.0


