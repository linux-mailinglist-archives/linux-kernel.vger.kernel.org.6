Return-Path: <linux-kernel+bounces-281559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF59194D828
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877551F22C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64C16849A;
	Fri,  9 Aug 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ki9kmp9D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC53A1BA;
	Fri,  9 Aug 2024 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236415; cv=none; b=dgTl8wugsftiOwNktEW0U7qkbePFC0gkbCg2AYzVLRAcRNsJh9tSNYYVIMtT3DHI9gp5Ea2xebPDLxX+OFZryaB5yh9BCjY6BcQWSpBogl4lPaBAMj7mU+vX3iilqOHAR2eYq2aD4FxcllHLSKnkpea4359/ZtmeYplIF+qQbxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236415; c=relaxed/simple;
	bh=Ju6wlfB7LkoudstdhVoXwuwoIEocdDd7fHs8cyE8NI0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JWM/EL1XdctN7XZ8BHQdq9MjTA4NTNCZLbW7nmDWa0elrIlFuwzriNM9K2rP/lnrhOnRbfY2R/3iNkiM+Vl8pgej3TYUoEpkdQfgPzjqAP0rMQ5tHmCHu+sd1LUVEIBPd+5cCRaTY5Y/z6W6WnZ/E+wEQWBXj8sNt9Z5L2FHI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ki9kmp9D; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723236413; x=1754772413;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ju6wlfB7LkoudstdhVoXwuwoIEocdDd7fHs8cyE8NI0=;
  b=Ki9kmp9DMoblPHjFh6Df6N/x08T5QWubYQGRc3lQKWz94XFKnLEFXjxu
   KKr1M+G6/XM1SpAUD0ldnZ20/oBoLL7tb5rf2z+xg2Dgb5gQF4m1/1E09
   ZdVsHnfT2G+2VeVleUCVt9wmR0qaeFanZ7DRDSZC/C7VE8Yr5wm32Nj6X
   7HZhwYf6e8NtWGqXoEuc2yHj3Q6yrvm9NYIjjZTEYiobBV1ixiORVovxU
   q5bnHQWDC28s2F4SBQXciGjrOJta5sn4xtTeN3EzIGkYZ1PaOwmXocdbn
   8ySg1G5VKKT7pAgzYkJ2S/ws/NjDfxyHeuP7l4NeJvTsn/kZniMMQWGTo
   A==;
X-CSE-ConnectionGUID: n38yovofTHuj+y/QPy9xFg==
X-CSE-MsgGUID: WPs9kxypTuSBLeZjqGJ2hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32819012"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="32819012"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:52 -0700
X-CSE-ConnectionGUID: WI/Tl+PGSwmciipUhz2iaw==
X-CSE-MsgGUID: p/8ut4vPRRKWjyMo07kd9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57650468"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.221.156])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:51 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Create Intel PMC SSRAM Telemetry driver
Date: Fri,  9 Aug 2024 13:46:29 -0700
Message-ID: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series removes the SSRAM support from Intel PMC Core driver
and creates a separate PCI driver for SSRAM device. The new Intel PMC
SSRAM driver provides the following functionalities:
 
1. Search and store the PMC information in a structure, including PWRMBASE
address and devid for each available PMC. Then Intel PMC Core driver
achieves the PMC information using the API provided by the new driver.
 
2. Search and register Intel Platform Monitoring Techology telemetry
regions so they would by available for read through sysfs and Intel PMT
API. Intel PMC Core driver can achieve Low Power Mode requirement
information from a telemetry region registered by the new driver.
The above functionalities was previously handled by Intel PMC Core
driver. Intel PMC Core driver returns -EPROBE_DEFER when trying to read
data from a telem region that is not available yet. This setup may
result in an infinite loop of .probe() calls as Intel PMC Core driver
creates child devices. Creating a separate PCI driver avoids the infinite
loop possibility.
 
Xi Pardee (7):
  platform/x86:intel/pmc: Remove SSRAM support from PMC Core
  platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver
  platform/x86:intel/pmc: Add support to get PMC information from SSRAM
  platform/x86:intel/pmt: Get PMC from SSRAM for available platforms
  platform/x86:intel/pmt: Create inline version for telemetry functions
  platform/x86:intel/pmc: Add support to Retrieve LPM information
  platform/x86:intel/pmc: Get LPM information for available platforms

 drivers/platform/x86/intel/pmc/Kconfig        |  13 +-
 drivers/platform/x86/intel/pmc/Makefile       |   8 +-
 drivers/platform/x86/intel/pmc/arl.c          |  36 +-
 drivers/platform/x86/intel/pmc/core.c         | 216 +++++++++++-
 drivers/platform/x86/intel/pmc/core.h         |  25 +-
 drivers/platform/x86/intel/pmc/core_ssram.c   | 326 ------------------
 drivers/platform/x86/intel/pmc/lnl.c          |  36 +-
 drivers/platform/x86/intel/pmc/mtl.c          |  34 +-
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 184 ++++++++++
 .../platform/x86/intel/pmc/ssram_telemetry.h  |  45 +++
 drivers/platform/x86/intel/pmt/telemetry.h    |  19 +-
 11 files changed, 550 insertions(+), 392 deletions(-)
 delete mode 100644 drivers/platform/x86/intel/pmc/core_ssram.c
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.c
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h

-- 
2.43.0


