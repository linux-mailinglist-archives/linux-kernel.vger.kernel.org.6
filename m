Return-Path: <linux-kernel+bounces-291300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA9C95609B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19481F2111D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AE31B5AA;
	Mon, 19 Aug 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhgUXoyc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC5912B8B;
	Mon, 19 Aug 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724028968; cv=none; b=l518XxtioOeMq5fPNdlRLcgEo8GWmVaWmPztT2lOubX8jteitePkVC6s6+VSJIbNkdugu32sri6bOrMK6YG+wSCOgNcJYJqeQRjc7kZLxtTYV7xney/HT6MnRy9wDuSKcQMrSg6hRimWyDYGJLqM2Ai+WFe9JyW5Eq8hIcSPhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724028968; c=relaxed/simple;
	bh=QlGml3VQN0QCRE1tJPnZayzy8uSBrrd14TR/0QQf2GE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+uX4KYTxQ5Wc5SrvV1hBMda5DQM5sfNNsCUvj+nw/Ex8Uufp6ndi9X3RgNbaj18R4jSuKF5bVe041WgFpxPZBRiVs5c7zHHASHfRMKiuKQ2/6MaL+p/4htoFSFm+38fr6AMssbqozSZUMl/GjX3d+wLnMBpAz0ICvQ2n9ZnUNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhgUXoyc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724028962; x=1755564962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QlGml3VQN0QCRE1tJPnZayzy8uSBrrd14TR/0QQf2GE=;
  b=mhgUXoycfOFB3ajMWYyOXrwsWdOSvSXmRbQkGbHmxyQ+rNXg2XsBZNZ2
   V0zeX1cEXa6K4f79StS/gJn2JV2HitCJadiPmKRhzDaW4+yhUhVjCu+xF
   TKN339Z+k2vCoxyHDwHAy/Ih5fWx0XOOigAsQwwbaVS13d9cpKEmlG2CO
   1TM1aHzLbtpwELFZXZ3l4jkqUexJr163ZWwoTW5hKSmHxpUGQtQEDrJvH
   G+hfcwoA2sBAwcH8NFftc+c3LFJkBb30l2IAlzZ7Bt56sLYeSlmCa/bWG
   EVoWk4WU2mYgWZx/aJqpoP4c3LjgMybMtIcLB4YcXpPuhjneTMcXPIs1+
   g==;
X-CSE-ConnectionGUID: ya0baTaxTbGfSvskZ52QIA==
X-CSE-MsgGUID: fU+vOAMuREGV5UcAiM9kRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22400160"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22400160"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 17:56:01 -0700
X-CSE-ConnectionGUID: tzbkMd5mTFCkEjFTyy1Lwg==
X-CSE-MsgGUID: vxXCJu5/TZyHx9yj/BvHDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60771396"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.197])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 17:55:58 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 0/3] ALSA/ASoC/SoundWire: Intel: update maximum number of links
Date: Mon, 19 Aug 2024 08:55:45 +0800
Message-ID: <20240819005548.5867-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Intel new platforms can have up to 5 SoundWire links.
This series does not apply to SoundWire tree due to recent changes in
machine driver. Can we go via ASoC tree with Vinod's Acked-by tag?

v2:
 - Change the patch order as per Vinod's suggestion

Pierre-Louis Bossart (3):
  ALSA/ASoC/SoundWire: Intel: use single definition for
    SDW_INTEL_MAX_LINKS
  soundwire: intel: add probe-time check on link id
  soundwire: intel: increase maximum number of links

 drivers/soundwire/intel.h               |  7 +++++++
 drivers/soundwire/intel_ace2x.c         | 20 ++++++++++++++++++++
 drivers/soundwire/intel_auxdevice.c     | 14 ++++++++++++++
 include/linux/soundwire/sdw_intel.h     |  8 ++++++++
 sound/hda/intel-sdw-acpi.c              |  5 ++---
 sound/soc/intel/boards/sof_sdw.c        |  4 +++-
 sound/soc/intel/boards/sof_sdw_common.h |  4 +---
 sound/soc/intel/boards/sof_sdw_hdmi.c   |  2 ++
 8 files changed, 57 insertions(+), 7 deletions(-)

-- 
2.43.0


