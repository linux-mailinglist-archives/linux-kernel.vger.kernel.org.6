Return-Path: <linux-kernel+bounces-399970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9229B9C0739
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1968F1F2137F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C3C20FAA8;
	Thu,  7 Nov 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijuhllGI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8D1CC8BD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985956; cv=none; b=mf1SpiUBVOjqQtc8IR3CIe7nub/bQxiEdsv6Z0ncvfAzZJG41hY8K4SnwqjjJ5sWkSZca3bIyXv+1OAUIGdhEpHvOQGPVEqTRicc2WxZPNTH1sZWAV9ktmacWVn4uuzgW4CrQ5UrFZ0UwBK34tUZxtvf49qEfadbBeB1+TCjmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985956; c=relaxed/simple;
	bh=uagjKtC12kGaC+BTqNdpDCd/i2XVgyCLnpN+l3FezaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAot+NwhtQTdQim4PRKhdB8xm+GR5eGXeaaHQTZfoY1d98z+APnMK3EPZ9Kq8BIKBL+yW4u4VLkKo/YgrtoUxxMChw7bUaaw+zx3nuggGqMt2P+ocKqxWaz+eX++37eT7IXUURmv8vEukpHTmKoD8kLO9EY/lnW940c0835dbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijuhllGI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730985955; x=1762521955;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uagjKtC12kGaC+BTqNdpDCd/i2XVgyCLnpN+l3FezaY=;
  b=ijuhllGITsHLGRqzyWVNXRKXuENfCS5om7yIWD3SD1rBK/kFVFGocF1G
   YCy+SReHfZvwXGh42IvuEl0QyOmNnnoHZE+t/VlGcLxIUP97d/Iwe6CzY
   CgIsS8Gpstt1nlxZHk20hw9uPpsAX7QeMw8YY3kPqlS8+31S1ekoLzf97
   +8NCqV5FUBkaI7Ox/I6sSTSnVOOjzkEHPYtkKSe6Gc6CRPBQDSA7k3B1T
   7sVFp03lPQsL+1fqq3hT/N6Vvh3L4a4POc3J/v9HPqj4I99QTKAksSDTU
   6Izd4S4OrMswIo6iDLDIv7L6g6zO1g7DlkqfGsQH/ta8r5x3ErJEjZH1t
   Q==;
X-CSE-ConnectionGUID: sJdqoVpiSveEXuc2olf1pQ==
X-CSE-MsgGUID: PCWCyeAaR6+Ap61uqsSEeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34750688"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="34750688"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:25:54 -0800
X-CSE-ConnectionGUID: HVp9CwlkTHynF0nt3JWBsw==
X-CSE-MsgGUID: VbVMrnp3TB2Uzjo8b9i9pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="89921611"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:25:50 -0800
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
Subject: [PATCH v2 00/10] mtd: add driver for Intel discrete graphics 
Date: Thu,  7 Nov 2024 15:13:46 +0200
Message-ID: <20241107131356.2796969-1-alexander.usyskin@intel.com>
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
 drivers/gpu/drm/i915/intel_nvm.c      | 117 ++++
 drivers/gpu/drm/i915/intel_nvm.h      |  15 +
 drivers/gpu/drm/xe/Makefile           |   1 +
 drivers/gpu/drm/xe/regs/xe_gsc_regs.h |   4 +
 drivers/gpu/drm/xe/xe_device.c        |   3 +
 drivers/gpu/drm/xe/xe_device_types.h  |   8 +
 drivers/gpu/drm/xe/xe_heci_gsc.c      |   5 +-
 drivers/gpu/drm/xe/xe_nvm.c           | 130 ++++
 drivers/gpu/drm/xe/xe_nvm.h           |  15 +
 drivers/gpu/drm/xe/xe_pci.c           |   6 +
 drivers/mtd/devices/Kconfig           |  11 +
 drivers/mtd/devices/Makefile          |   1 +
 drivers/mtd/devices/mtd-intel-dg.c    | 841 ++++++++++++++++++++++++++
 include/linux/intel_dg_nvm_aux.h      |  27 +
 19 files changed, 1201 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/intel_nvm.c
 create mode 100644 drivers/gpu/drm/i915/intel_nvm.h
 create mode 100644 drivers/gpu/drm/xe/xe_nvm.c
 create mode 100644 drivers/gpu/drm/xe/xe_nvm.h
 create mode 100644 drivers/mtd/devices/mtd-intel-dg.c
 create mode 100644 include/linux/intel_dg_nvm_aux.h

-- 
2.43.0


