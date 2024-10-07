Return-Path: <linux-kernel+bounces-353438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D2992DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88371F222C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0591D45FC;
	Mon,  7 Oct 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASlFbjrl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C01D4176;
	Mon,  7 Oct 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309184; cv=none; b=jAGeFmbsZE1226606ZN4J/tfmQ/NnKN/QQeyAlqk8AOPgPK8yP/wgnxaAn05ZLefZSc9usD7ocXUrmrH6URmY3Goy26acyZh+2fzdGI8CRGX0iWIk/AlauhzmC5Wln1ltTyb//ayb5Gn1jwsUnE8gxwNrf8KFA1/XAYL/tJ+qog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309184; c=relaxed/simple;
	bh=Q9LePdrr2s4bq/oMP9zgTKba2onDYtfWkEOWJ9WSqBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RI0sPvQzmdA3VWNKR/bWxQeNR50xsoASjej/5fCTiHYL/xLg4mMP5Pzh5fi4HIJgR6oA3Ydvx+ivN6HSnFOPpp3Cg/M9+JuqrjHEABTH5lYu6J0J1SL37xIbgdthnF8yDMX9Zz2Ci/nzAEQIErC9nzbhMKQ9PTlFCRl5rf62Atk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASlFbjrl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728309183; x=1759845183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q9LePdrr2s4bq/oMP9zgTKba2onDYtfWkEOWJ9WSqBk=;
  b=ASlFbjrliWrAE7JXiWeXtBa72sx0fJoxdIXiL0wiEKYCK8vboGiXEJmi
   D+4URD0CL1Ay8hK6mvlicplsVMF2uJ0OxyqJ80+LFZq19QYJ/T5jynQY7
   x3Xrdd+Z6Y9ktFunX0HS+uxEuObmZdAlLJsOsoPvHkcXsb6WwqlGijL3a
   O7LT9voykZ1hUgauxxLBksRUZEv01QLd2iDIGcO76GwPklOueFhkQFoLu
   1+oewoHo//Gd4XIVx0es9sS398/pjxxSF+/nt335sQRj/fljOSba9/dk2
   8tcdqle2/U2TnpmtxgaI23Esw3nFdhZRD3s+679Hft+AGKoxGImtWWbXH
   g==;
X-CSE-ConnectionGUID: Kb7tqq7TRJKRrc6pN2VwgA==
X-CSE-MsgGUID: ANPHJ1tHThakMdYFug91ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27397771"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27397771"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:53:02 -0700
X-CSE-ConnectionGUID: St91g/rLT62zvHI4op/G6Q==
X-CSE-MsgGUID: R9gHraGpT/GsKfUxodrKpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75156310"
Received: from spc-west-001.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.83])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:53:00 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 0/3] ASoC: Intel: add rt722/rt721 support for PTL platform
Date: Mon,  7 Oct 2024 21:52:48 +0800
Message-ID: <20241007135251.9099-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rt722, rt721 and rt712 codecs are quite similar. Refactor the existing
spk_rtd_init() to support Realtek common multifunction SDCA codecs.

The "ASoC: Intel: soc-acpi-intel-ptl-match: Add rt721 support" patch
should not be applied before the "ASoC: rt721-sdca: Add RT721 SDCA
driver" is applied.

v2:
 - Add missing "select SND_SOC_RT721_SDCA_SDW"

Dharageswari R (1):
  ASoC: intel: sof_sdw: add RT722 SDCA card for PTL platform

Naveen Manohar (2):
  ASoC: intel/sdw_utils: refactor RT multifunction sdca speaker codecs
  ASoC: Intel: soc-acpi-intel-ptl-match: Add rt721 support

 include/sound/soc_sdw_utils.h                 |  3 +-
 sound/soc/intel/boards/Kconfig                |  1 +
 sound/soc/intel/boards/sof_sdw.c              |  8 ++
 .../intel/common/soc-acpi-intel-ptl-match.c   | 62 +++++++++++--
 sound/soc/sdw_utils/Makefile                  |  3 +-
 sound/soc/sdw_utils/soc_sdw_rt712_sdca.c      | 48 ----------
 sound/soc/sdw_utils/soc_sdw_rt722_sdca.c      | 41 ---------
 sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c      | 90 +++++++++++++++++++
 .../sdw_utils/soc_sdw_rt_sdca_jack_common.c   |  8 ++
 sound/soc/sdw_utils/soc_sdw_utils.c           | 45 +++++++++-
 10 files changed, 207 insertions(+), 102 deletions(-)
 delete mode 100644 sound/soc/sdw_utils/soc_sdw_rt712_sdca.c
 delete mode 100644 sound/soc/sdw_utils/soc_sdw_rt722_sdca.c
 create mode 100644 sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c

-- 
2.43.0


