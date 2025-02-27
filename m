Return-Path: <linux-kernel+bounces-536516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A4FA480CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8964201C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84711236A79;
	Thu, 27 Feb 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+NuRa+p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2EA236457;
	Thu, 27 Feb 2025 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665218; cv=none; b=ARsoGTh9cYYrnyPtG+RUuW9vFAv+YXb6FHc2SasbFnJtedzld8LCvLpfK1WcYUPKXZ+zFi533FSh8hgQZ51MPOHE9BHnJRXGJ5VDKF8hyR1Nv7m4FZmQnW5qHQ8KFOZEtWwgodPLeuP7U4nxemBfyDTORN0h0lP8/JXEXDZljP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665218; c=relaxed/simple;
	bh=au0BwBJcVIOb3eE1ednRg0kZV6iGDN4eS5jkoD21FPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ino0pPyZFY52EE7zhhq3Zq0rPr73WmqNZDKRE/DA3bC1afqJ/h7rwOc7UMw3/UioxODHzhuaESiph2YHhTZ5fDleFEoUhKpiwSA/Vr80jEogr/uwavs3p65Wn2GujyZCW3NfR9nSAsVb5FS/LcG6gY58kOUnARywJwKiBof7l7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+NuRa+p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665217; x=1772201217;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=au0BwBJcVIOb3eE1ednRg0kZV6iGDN4eS5jkoD21FPQ=;
  b=L+NuRa+p/xE6KOJmQ8BXlVdUt1qa3FgWiAn3NOeXPgEpYAcGwYI/+TBW
   nb3hoCOJ70fk7NpgEbknCO7HOFVoCI/pMdG9RKI5jk+ZbRzdS/sSq1Bdg
   9++wD5WayGzWd5tYxZCnX04K7xusmJ7C/dvueg4UUvclhWX9lwCfBIx/F
   AdvcltIJZjd+TOGUHaObs9a14GcD+KmIZZ0iZcEaPj9fIUlI64EyK0ajL
   DBEjQUzNX+4tMlQVgNsNnBb+Z1biZSOCaZX5QpgeqBmWsesh3arlRzXGa
   NZNJlb6+GbTfIgUpfrb6Gu7wFfMUnwMkUFq3TCwmttjxiYC0gpUwPmc7m
   w==;
X-CSE-ConnectionGUID: /Hw4Vg0rSmivOqqdVKHOvQ==
X-CSE-MsgGUID: oCIXP6J4T72SbiLg9kDiCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41437979"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41437979"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:28 -0800
X-CSE-ConnectionGUID: S1V5T6Z5TRizvo2Ysrd3kw==
X-CSE-MsgGUID: O6kamYaKT2WAMq+NjVSDsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116831518"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.154])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:26 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v4 00/16] SoundWire/ASoC: add SDW BPT/BRA support
Date: Thu, 27 Feb 2025 22:05:59 +0800
Message-ID: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds support for SoundWire BPT/BRA. The change is mainly on
the SoundWire tree. It is better to go through the SoundWire tree with
Mark's Acked-by tag.

v2:
 - Add MODULE_DESCRIPTION in the "ASoC: SOF: Intel: hda-sdw-bpt: add
   helpers for SoundWire BPT DMA" patch.

v3:
 - Change sdw_cdns_write_pdi1_buffer_size and
   sdw_cdns_read_pdi0_buffer_size to static values.

v4:
 - Revise bra.rst as suggested.

Bard Liao (1):
  ASoC: SOF: Intel: hda-sdw-bpt: add CHAIN_DMA support

Pierre-Louis Bossart (15):
  Documentation: driver: add SoundWire BRA description
  soundwire: cadence: add BTP support for DP0
  soundwire: extend sdw_stream_type to BPT
  soundwire: stream: extend sdw_alloc_stream() to take 'type' parameter
  soundwire: stream: special-case the bus compute_params() routine
  soundwire: stream: reuse existing code for BPT stream
  soundwire: bus: add send_async/wait APIs for BPT protocol
  soundwire: bus: add bpt_stream pointer
  soundwire: cadence: add BTP/BRA helpers to format data
  soundwire: intel_auxdevice: add indirection for BPT send_async/wait
  ASoC: SOF: Intel: hda-sdw-bpt: add helpers for SoundWire BPT DMA
  soundwire: intel: add BPT context definition
  soundwire: intel_ace2x: add BPT send_async/wait callbacks
  soundwire: debugfs: add interface for BPT/BRA transfers
  ASoC: rt711-sdca: add DP0 support

 Documentation/driver-api/soundwire/bra.rst    | 336 +++++++++
 .../driver-api/soundwire/bra_cadence.rst      |  67 ++
 Documentation/driver-api/soundwire/index.rst  |   2 +
 Documentation/driver-api/soundwire/stream.rst |   2 +-
 .../driver-api/soundwire/summary.rst          |   8 -
 drivers/soundwire/Kconfig                     |   1 +
 drivers/soundwire/bus.c                       |  43 ++
 drivers/soundwire/bus.h                       |  18 +
 drivers/soundwire/cadence_master.c            | 646 +++++++++++++++++-
 drivers/soundwire/cadence_master.h            |  20 +
 drivers/soundwire/debugfs.c                   |  84 ++-
 .../soundwire/generic_bandwidth_allocation.c  |  48 ++
 drivers/soundwire/intel.h                     |  23 +
 drivers/soundwire/intel_ace2x.c               | 312 +++++++++
 drivers/soundwire/intel_auxdevice.c           |  24 +
 drivers/soundwire/stream.c                    | 140 +++-
 include/linux/soundwire/sdw.h                 |  33 +-
 include/linux/soundwire/sdw_intel.h           |   4 +
 include/sound/hda-sdw-bpt.h                   |  69 ++
 sound/soc/codecs/rt711-sdca-sdw.c             |   8 +
 sound/soc/qcom/sdw.c                          |   2 +-
 sound/soc/sof/intel/Kconfig                   |   7 +
 sound/soc/sof/intel/Makefile                  |   4 +
 sound/soc/sof/intel/hda-sdw-bpt.c             | 445 ++++++++++++
 24 files changed, 2282 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/driver-api/soundwire/bra.rst
 create mode 100644 Documentation/driver-api/soundwire/bra_cadence.rst
 create mode 100644 include/sound/hda-sdw-bpt.h
 create mode 100644 sound/soc/sof/intel/hda-sdw-bpt.c

-- 
2.43.0


