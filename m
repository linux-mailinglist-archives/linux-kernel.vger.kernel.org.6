Return-Path: <linux-kernel+bounces-367820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E11E9A073B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1534528D1FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C6B2071F6;
	Wed, 16 Oct 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezzjGnOI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44021206E6A;
	Wed, 16 Oct 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074229; cv=none; b=IX4AIboJ8hgRmn+CjeJ/z3dlJaijCMJ8YKRW50E6dc/ipTvs40W1UpvBFQrPi2OWTepkdFx+MDFYn//GttMwFdWM2zrhPwjNIpqNsA6qgI1jxGTKqPqo0Vl3jFq31wId/IQxzM1pIx9CBjmFL6DSvR/FThzRivG/vxY6axZ6rGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074229; c=relaxed/simple;
	bh=duvDr9mn6ONznmwCzM0juLtAPd4mMVAfQxkSAW/w++c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YDmSxQ8k3bMglbPKJBLADZCDgVjVwGABw60pFxFuyQPQbm7cfGsG69yVRrGF6/D11MK43mOwCEgf3DSbCcPnIKqIH3covtoVxRXOG2UXmok5IpwQz8BRcWYVUfwmmpeiu0JYy+sowvlBH/zZYnHlI0XpYguI95X59LOp2z6E1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezzjGnOI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074228; x=1760610228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=duvDr9mn6ONznmwCzM0juLtAPd4mMVAfQxkSAW/w++c=;
  b=ezzjGnOIHZicWzXwSu1qdFF9Q4DxoGQAYulHyNmWs6+D8R2BzUnbLE03
   aJJ1rTiFbeP4XoBWR3qJnn+KN+rBCq/9tFeeGj+TRtpiBsczhzl/eJ1p8
   FkK5mvjBzhSkojx0C2V6HgqH7cuMd9wTpQ6wfUO+Pqz+6CmLPhDN7GswU
   S5BKFZWifRaqugb4S46e9ziJN2a7ik+ZAbcWixFGaETTZd3Ezg/itTivv
   BLM+Dpuct7Ef82W0jC9taXvzoNAfU4LOATEuYRkKZ5EK7u/MqYU2vCi0p
   c9E7vVjYJR56eGOfilKp8DJBu8+ODds3Cp7Vobq2mCo4vMkxV1QKvR+V3
   Q==;
X-CSE-ConnectionGUID: /PpkekT6QD2X4diniJM3uQ==
X-CSE-MsgGUID: zmcnADvMSuKURG6sBtcQhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985856"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985856"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:23:47 -0700
X-CSE-ConnectionGUID: ayjCf5bTQAuFg+OaTaUUZQ==
X-CSE-MsgGUID: 8BsxSgJPRPSWXotGpoJbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82960807"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:23:45 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 00/11] ASoC/soundwire: add initial support for SDCA
Date: Wed, 16 Oct 2024 18:23:22 +0800
Message-ID: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We need to get rt712 version by reading SDCA version and functions.
This patch series adds initial support for SDCA and add a helper to tell
if the codec is RT712_VB.

This series may go via the ASoC tree with Vinod's Acked-by tag.

Bard Liao (1):
  soundwire: sdw_intel: include linux/acpi.h

Pierre-Louis Bossart (10):
  ASoC/soundwire: remove sdw_slave_extended_id
  ASoC: SDCA: add initial module
  soundwire: slave: lookup SDCA version and functions
  ASoC: SDCA: add quirk function for RT712_VB match
  ASoC: rt712-sdca: detect the SMART_MIC function during the probe stage
  ASoC: soc-acpi: introduce new 'machine check' callback
  ASoC: sdw_utils: add SmartMic DAI for RT712 VB
  ASoC: sdw_utils: add SmartMic DAI for RT713 VB
  ASoC: Intel: soc-acpi: add is_device_rt712_vb() helper
  ASoC: SOF: Intel: hda: use machine_check() for SoundWire

 drivers/soundwire/Kconfig                     |   1 +
 drivers/soundwire/amd_init.c                  |  12 +-
 drivers/soundwire/intel_init.c                |  13 +-
 drivers/soundwire/slave.c                     |  14 ++
 include/linux/soundwire/sdw.h                 |   9 +-
 include/linux/soundwire/sdw_amd.h             |   7 +-
 include/linux/soundwire/sdw_intel.h           |   8 +-
 include/sound/sdca.h                          |  62 +++++++
 include/sound/sdca_function.h                 |  55 ++++++
 include/sound/soc-acpi.h                      |   8 +-
 sound/soc/Kconfig                             |   1 +
 sound/soc/Makefile                            |   1 +
 sound/soc/amd/ps/pci-ps.c                     |   3 +-
 sound/soc/codecs/rt712-sdca-sdw.c             |   1 +
 sound/soc/codecs/rt712-sdca.c                 |  38 +++-
 sound/soc/codecs/rt712-sdca.h                 |   1 +
 sound/soc/intel/Kconfig                       |   5 +
 sound/soc/intel/common/Makefile               |   3 +
 .../intel/common/soc-acpi-intel-mtl-match.c   |  51 ++++++
 .../intel/common/soc-acpi-intel-sdca-quirks.c |  42 +++++
 .../intel/common/soc-acpi-intel-sdca-quirks.h |  14 ++
 sound/soc/sdca/Kconfig                        |  11 ++
 sound/soc/sdca/Makefile                       |   5 +
 sound/soc/sdca/sdca_device.c                  |  67 +++++++
 sound/soc/sdca/sdca_functions.c               | 173 ++++++++++++++++++
 sound/soc/sdw_utils/soc_sdw_utils.c           |  18 +-
 sound/soc/soc-acpi.c                          |  30 +--
 sound/soc/sof/amd/acp-common.c                |   3 +-
 sound/soc/sof/intel/hda.c                     |  19 +-
 29 files changed, 610 insertions(+), 65 deletions(-)
 create mode 100644 include/sound/sdca.h
 create mode 100644 include/sound/sdca_function.h
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdca-quirks.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdca-quirks.h
 create mode 100644 sound/soc/sdca/Kconfig
 create mode 100644 sound/soc/sdca/Makefile
 create mode 100644 sound/soc/sdca/sdca_device.c
 create mode 100644 sound/soc/sdca/sdca_functions.c

-- 
2.43.0


