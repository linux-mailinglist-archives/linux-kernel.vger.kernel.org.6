Return-Path: <linux-kernel+bounces-414420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D699D27BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDB51F23149
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D091CEAB0;
	Tue, 19 Nov 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtRw0Lv6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F41CC150
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025564; cv=none; b=sxsBmx4iXcogGdfLb8NPGb69eJT1t/cVY31KtLVAHs4v4reFrRGIW2BPg+KJv7v+oe0OKGjLkDNllc7jupheDm+erpcASqSBrmpfaLZNCLq816wcsm1Gz6YsHwJHw8a5QiuhzqS5R2DPpCzotnoM39rt6jMW23pMwbgDOdysORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025564; c=relaxed/simple;
	bh=RB99tyFzSCxQFnvlo+XwbNX/gy2cNY31DDdREslWslY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFM9DZs0qonq6OeAEt6E23ASEIJtGxbNIuSRt1ZnDPmNPlinHnSTM7h20n76tm6+0EgpnhKNSarHArQZyK4A0C5Jx32Sri+YX4hSEX7T57AOXhYF6h61jzqA7Dsi37pmJe5lrtGY4J2fR+J0Q7JuJgYZtYK9q+BgT8eDGjmWQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtRw0Lv6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732025563; x=1763561563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RB99tyFzSCxQFnvlo+XwbNX/gy2cNY31DDdREslWslY=;
  b=TtRw0Lv6Jfis+kCAGal4RmMi+E6RDAMnI+u/EgopBG/ccBWJsmkqRGzW
   TRq+K8qVvq6kOMnv9uWKY1V+JIRoyJQLQL0anr8VKm98r3D8/b4/6+vv8
   rLDdhITZTsea+kJ0D5zqhC0F/wR7Gj/2Zn1AwiSWXCLal9m0Wfjy+zc/n
   v0Syc4P3yn0D+JEKRfv+S7GhxbfI7qY53sln65Z7osXbH3EAkBhX5XE40
   SJu5qIHQi9TZLBDZKErHWz57X/9pedksGYnGY9PxgrdNd8F5o7Nh1KpnS
   dmx/8OetIlqoisdWacAZexQTNY1cQAhXfqdcWjTaLMR48nQEbGMJ1j1B8
   Q==;
X-CSE-ConnectionGUID: lvjL4sTUTECXDVVBpokLAA==
X-CSE-MsgGUID: OJyc5kmlTny2vqOQO3cy+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="54526685"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="54526685"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 06:12:42 -0800
X-CSE-ConnectionGUID: kALZvKXUSwKgvANVtWcSTA==
X-CSE-MsgGUID: ZmjUfi5+RM6uWvx724maXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="94398524"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 06:12:37 -0800
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Oren Weil <oren.jer.weil@intel.com>,
	linux-mtd@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v3 00/10] mtd: add driver for Intel discrete graphics
Date: Tue, 19 Nov 2024 16:01:02 +0200
Message-ID: <20241119140112.790720-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver for access to Intel discrete graphics card
internal NVM device.
Expose device on auxiliary bus by i915 and Xe drivers and
provide mtd driver to register this device with MTD framework.

This is a rewrite of "drm/i915/spi: spi access for discrete graphics"
and "spi: add driver for Intel discrete graphics"
series with connection to the Xe driver and splitting
the spi driver part to separate module in mtd subsystem.

This series intended to be pushed through drm-xe-next.

V2: Replace dev_* prints with drm_* prints in drm (xe and i915) patches.
    Enable NVM device on Battlemage HW (xe driver patch)
    Fix overwrite register address (xe driver patch)
    Add Rodrigo's r-b

V3: Use devm_pm_runtime_enable to simplify flow.
    Drop print in i915 unload that was accidentally set as error.
    Drop HAS_GSC_NVM macro in line with latest Xe changes.
    Add more Rodrigo's r-b and Miquel's ack.

Alexander Usyskin (10):
  mtd: add driver for intel graphics non-volatile memory device
  mtd: intel-dg: implement region enumeration
  mtd: intel-dg: implement access functions
  mtd: intel-dg: register with mtd
  mtd: intel-dg: align 64bit read and write
  mtd: intel-dg: wake card on operations
  drm/i915/nvm: add nvm device for discrete graphics
  drm/i915/nvm: add support for access mode
  drm/xe/nvm: add on-die non-volatile memory device
  drm/xe/nvm: add support for access mode

 MAINTAINERS                           |   7 +
 drivers/gpu/drm/i915/Makefile         |   4 +
 drivers/gpu/drm/i915/i915_driver.c    |   6 +
 drivers/gpu/drm/i915/i915_drv.h       |   3 +
 drivers/gpu/drm/i915/i915_reg.h       |   1 +
 drivers/gpu/drm/i915/intel_nvm.c      | 115 ++++
 drivers/gpu/drm/i915/intel_nvm.h      |  15 +
 drivers/gpu/drm/xe/Makefile           |   1 +
 drivers/gpu/drm/xe/regs/xe_gsc_regs.h |   4 +
 drivers/gpu/drm/xe/xe_device.c        |   3 +
 drivers/gpu/drm/xe/xe_device_types.h  |   7 +
 drivers/gpu/drm/xe/xe_heci_gsc.c      |   5 +-
 drivers/gpu/drm/xe/xe_nvm.c           | 130 ++++
 drivers/gpu/drm/xe/xe_nvm.h           |  15 +
 drivers/gpu/drm/xe/xe_pci.c           |   6 +
 drivers/mtd/devices/Kconfig           |  11 +
 drivers/mtd/devices/Makefile          |   1 +
 drivers/mtd/devices/mtd-intel-dg.c    | 838 ++++++++++++++++++++++++++
 include/linux/intel_dg_nvm_aux.h      |  27 +
 19 files changed, 1195 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/intel_nvm.c
 create mode 100644 drivers/gpu/drm/i915/intel_nvm.h
 create mode 100644 drivers/gpu/drm/xe/xe_nvm.c
 create mode 100644 drivers/gpu/drm/xe/xe_nvm.h
 create mode 100644 drivers/mtd/devices/mtd-intel-dg.c
 create mode 100644 include/linux/intel_dg_nvm_aux.h

-- 
2.43.0


