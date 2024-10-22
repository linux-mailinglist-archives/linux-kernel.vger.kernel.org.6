Return-Path: <linux-kernel+bounces-376126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2569E9AA078
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB1EB2095A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791D619B3C5;
	Tue, 22 Oct 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3YirA6f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37D18859B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594434; cv=none; b=XmK0Ld4UGzYNA3FXsBqe4aUfBO+Z2Y9RASKKCfrsUNsacSfiE9QhESLwPQUybFNEf0oP7JXCnE//ZBwXe3aKNHVCXiGUGGjMOQa/halh/K2tW/f27JmFKn7UZaOk83RRR+eg+s79KkQXhsm+7G6pTjUMWJSbXTyuNKCCjY8OF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594434; c=relaxed/simple;
	bh=X8W2PZaMjTbO7L4oT2o41c/8RKlDJ2p+caMbV4wPX+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRauPf2k7R9ybfb+m2GvbQYURZ+rYtEIRMUzjkyNetGdo2gXE4lGZA8YFyUXI5EG5oQ4AHcTI6Ua98k0vQY1ccASwo4ViT9dPQ5vmUFhC4Dil6QSLf2+bxv77KnJ7XZM3REtfoMpQQNLqbLjaGeU9uVI5VxX2tka/eox13uEgQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3YirA6f; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729594434; x=1761130434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X8W2PZaMjTbO7L4oT2o41c/8RKlDJ2p+caMbV4wPX+M=;
  b=D3YirA6fLJo3PPmwJ0emZcsSVellsSj9BuHYnMlKm0KXlwRmxIs1vXPc
   wZNQjrIxVaycpKzms5pnzaATqmOynQjpLLCBHZDSdG7d8lSMiRu4KiC7V
   5Cks87y3vuXLBV9R25BFGAGkEVqp+Sg8me4LcouBe9q7CNJown0nanIca
   CGcLTtYaxR7y+fx4t+l6h5gzz+3vAoO0JQdul/qEW3OZ2UYZ37vqpRzej
   vNib5bMtMaU9CpCDcIpTVL1uetRufqv+cgRzsgA8ptjEMbOamu8kYzdVG
   3CqzPxGWzO8Xx2tsJKpR50bBhwK62RoBSFLcTqEn4n1dto9fWX2F49fND
   w==;
X-CSE-ConnectionGUID: tzSAO5XcQLyXaxX0T177Bg==
X-CSE-MsgGUID: QwdWDQ3uRWCHQ3vrRswDjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="39704940"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="39704940"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP; 22 Oct 2024 03:53:39 -0700
X-CSE-ConnectionGUID: UREAHlpEQralW+/fzp3LJw==
X-CSE-MsgGUID: 0rHqH6V4T7es1JCTrMAaZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79847576"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 03:53:06 -0700
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
Subject: [PATCH 00/10] mtd: add driver for Intel discrete graphics
Date: Tue, 22 Oct 2024 13:41:09 +0300
Message-ID: <20241022104119.3149051-1-alexander.usyskin@intel.com>
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
 drivers/gpu/drm/i915/intel_nvm.c      | 119 ++++
 drivers/gpu/drm/i915/intel_nvm.h      |  15 +
 drivers/gpu/drm/xe/Makefile           |   1 +
 drivers/gpu/drm/xe/regs/xe_gsc_regs.h |   4 +
 drivers/gpu/drm/xe/xe_device.c        |   3 +
 drivers/gpu/drm/xe/xe_device_types.h  |   8 +
 drivers/gpu/drm/xe/xe_heci_gsc.c      |   5 +-
 drivers/gpu/drm/xe/xe_nvm.c           | 131 ++++
 drivers/gpu/drm/xe/xe_nvm.h           |  15 +
 drivers/gpu/drm/xe/xe_pci.c           |   5 +
 drivers/mtd/devices/Kconfig           |  11 +
 drivers/mtd/devices/Makefile          |   1 +
 drivers/mtd/devices/mtd-intel-dg.c    | 843 ++++++++++++++++++++++++++
 include/linux/intel_dg_nvm_aux.h      |  27 +
 19 files changed, 1205 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/intel_nvm.c
 create mode 100644 drivers/gpu/drm/i915/intel_nvm.h
 create mode 100644 drivers/gpu/drm/xe/xe_nvm.c
 create mode 100644 drivers/gpu/drm/xe/xe_nvm.h
 create mode 100644 drivers/mtd/devices/mtd-intel-dg.c
 create mode 100644 include/linux/intel_dg_nvm_aux.h

-- 
2.43.0


