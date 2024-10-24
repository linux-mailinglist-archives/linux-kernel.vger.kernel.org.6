Return-Path: <linux-kernel+bounces-379424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 251609ADE85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA4D1F233A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721E1AF0AD;
	Thu, 24 Oct 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLWzbTvE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178B2B9CD;
	Thu, 24 Oct 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757453; cv=none; b=TsHaSXKSNUebCKBrqgvEvaf7QCNwBbC1BvYXNC+pfEjNeHurdNKT5ttCOokFvDw2hczmGPXeL85bl0Yc8mhco9hFjN0YempIOeveWhUcKEi271IZLKg6nc5MrkpT2wPTfk5ef2hSMFedKwmNzC5r0qOw/fvt4HRTSMQa8pwmN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757453; c=relaxed/simple;
	bh=E2UMrjOOB1RTCxZbP86AJXOuiZ5+TRIP/vocU98RNY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yq2LE8VF7B/P9QJR0VIazpwwHNYlmcT33LmcMP2GNTr4YZIiQX1oxsDGb+yysB3i8CIOXZeS3wwKrX9G61e+AoCzN6gr9RX3g1koNofp/NtQr7enCJoLa84zLkFasdyx2mzh2UfjRG8+c/Ev/Xik3qJDJ1bz3WnB9Z3HSUSkbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLWzbTvE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729757451; x=1761293451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E2UMrjOOB1RTCxZbP86AJXOuiZ5+TRIP/vocU98RNY8=;
  b=GLWzbTvEBkHTuXA30dRDp5pltmRO9KaDlV7T+57sFVp49pJ4FXjDidh+
   H+2auVW08gTQJAcTeGAWXW3d5AXgbJk1eYXJGJ6dPMt/cBq/p22z0YkOG
   aFnP+LgxblbZBBHhT8gjUdU00Qdqid87bEsY4nHzPeZlu0Dh024uw2FpC
   WkmcRwMvNScyqJ63gTk35GwDpRhycak/+vqCBpM2M6U9aRwp1tkA1dGPd
   KFz3UD7cQc66lkzZE3+8wZDaA3bvYKp+DDwl+Y3O3KmC9pr8TA5vlvGsN
   tLpNouEHYhE0C/DpSpCxaQLNHlp83vjSX/ZrkuUWse+8IgouxuoM6t4YU
   w==;
X-CSE-ConnectionGUID: ZCxL3jaHSmm3hBrQ8hLF/g==
X-CSE-MsgGUID: IQMLBKKVRseJDCSY8uYQ6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29500963"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29500963"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:10:50 -0700
X-CSE-ConnectionGUID: d7fOBfywQuCPM6W9NMJz4g==
X-CSE-MsgGUID: TwRmqQ1mTYa6IHx09mf5nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80690698"
Received: from shsensorbuild.sh.intel.com ([10.239.133.18])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 01:10:48 -0700
From: Even Xu <even.xu@intel.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	corbet@lwn.net
Cc: linux-input@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Even Xu <even.xu@intel.com>
Subject: [PATCH v1 00/22] Add Intel Touch Host Controller drivers
Date: Thu, 24 Oct 2024 16:10:01 +0800
Message-Id: <20241024081023.1468951-1-even.xu@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Touch Host Controller (THC) is a new high performance input IP
which can benefit HID device's data transaction, such as touch screen,
touch pad, stylus.

THC IP now evoluates to V4, it can support 3 different modes: IPTS,
HIDSPI and HIDI2C. Here are upgrade history:
- THC v1, for TGL/LKF, supports intel private IPTS (Intel Precise Touch
  and Stylus) protocol ( IPTS mode)
- THC v2, for ADL, add industrial standard HID over SPI protocol support
  (HIDSPI mode)
- THC v3, for MTL, enhance HID over SPI mode
- THC v4, for LNL, add inudstrial standard HID over I2C protocol support
  (HIDI2C mode) 

Linux Surface community (https://github.com/linux-surface) already
implemented IPTS mode. These patch series provides THC HIDSPI mode and
THC HIDI2C mode support on Linux.

These patch series includes:
1. Document for THC hardware and software introduction.
2. Intel THC Hardware layer driver which provides control interfaces
   for protocol layer.
3. Intel QuickSPI (R) driver working as a HIDSPI device driver which
   implements HID over SPI protocol and flow.
4. Intel QuickI2C (R) driver working as a HIDI2C device driver which
   implements HID over I2C protocol and flow.

Even Xu (13):
  HID: THC: Add documentation
  HID: intel-thc-hid: intel-thc: Add THC DMA interfaces
  HID: intel-thc-hid: intel-thc: Add THC I2C config interfaces
  HID: intel-thc-hid: intel-quickspi: Add THC QuickSPI driver hid layer
  HID: intel-thc-hid: intel-quickspi: Add THC QuickSPI ACPI interfaces
  HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation
  HID: intel-thc-hid: intel-quickspi: Add PM implementation
  HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C driver skeleton
  HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C driver hid layer
  HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C ACPI interfaces
  HID: intel-thc-hid: intel-quicki2c: Add HIDI2C protocol implementation
  HID: intel-thc-hid: intel-quicki2c: Complete THC QuickI2C driver
  HID: intel-thc-hid: intel-quicki2c: Add PM implementation

Xinpeng Sun (9):
  HID: intel-thc-hid: Add basic THC driver skeleton
  HID: intel-thc-hid: intel-thc: Add THC registers definition
  HID: intel-thc-hid: intel-thc: Add THC PIO operation APIs
  HID: intel-thc-hid: intel-thc: Add APIs for interrupt
  HID: intel-thc-hid: intel-thc: Add THC LTR interfaces
  HID: intel-thc-hid: intel-thc: Add THC interrupt handler
  HID: intel-thc-hid: intel-thc: Add THC SPI config interfaces
  HID: intel-thc-hid: intel-quickspi: Add THC QuickSPI driver skeleton
  HID: intel-thc-hid: intel-quickspi: Complete THC QuickSPI driver

 Documentation/hid/intel-thc-hid.rst           |  560 +++++++
 MAINTAINERS                                   |    6 +
 drivers/hid/Kconfig                           |    2 +
 drivers/hid/Makefile                          |    2 +
 drivers/hid/intel-thc-hid/Kconfig             |   42 +
 drivers/hid/intel-thc-hid/Makefile            |   22 +
 .../intel-quicki2c/pci-quicki2c.c             |  962 +++++++++++
 .../intel-quicki2c/quicki2c-dev.h             |  182 +++
 .../intel-quicki2c/quicki2c-hid.c             |  166 ++
 .../intel-quicki2c/quicki2c-hid.h             |   14 +
 .../intel-quicki2c/quicki2c-protocol.c        |  219 +++
 .../intel-quicki2c/quicki2c-protocol.h        |   20 +
 .../intel-quickspi/pci-quickspi.c             |  970 +++++++++++
 .../intel-quickspi/quickspi-dev.h             |  168 ++
 .../intel-quickspi/quickspi-hid.c             |  165 ++
 .../intel-quickspi/quickspi-hid.h             |   14 +
 .../intel-quickspi/quickspi-protocol.c        |  410 +++++
 .../intel-quickspi/quickspi-protocol.h        |   25 +
 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 1442 +++++++++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dev.h   |  116 ++
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   |  969 +++++++++++
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  146 ++
 .../intel-thc-hid/intel-thc/intel-thc-hw.h    |  878 ++++++++++
 include/linux/hid-over-i2c.h                  |  117 ++
 include/linux/hid-over-spi.h                  |  155 ++
 25 files changed, 7772 insertions(+)
 create mode 100644 Documentation/hid/intel-thc-hid.rst
 create mode 100644 drivers/hid/intel-thc-hid/Kconfig
 create mode 100644 drivers/hid/intel-thc-hid/Makefile
 create mode 100644 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-thc/intel-thc-hw.h
 create mode 100644 include/linux/hid-over-i2c.h
 create mode 100644 include/linux/hid-over-spi.h

-- 
2.40.1


