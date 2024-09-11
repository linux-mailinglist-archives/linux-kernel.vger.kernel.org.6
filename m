Return-Path: <linux-kernel+bounces-324817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6677197514F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23577285EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F251885A3;
	Wed, 11 Sep 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgiVlHBD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF81187553;
	Wed, 11 Sep 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055943; cv=none; b=riVEm+vgttquU1XM9k2o9guNl4kIj4hJcQG9HGbcPIgUnDQ20hxNmrKJe8sa/YNHOYNB3E+JtjnOkmBdL1dR4Enq4Zpvnu2Dq+1nx5c9tvTsswcceLdJTAIZf/kjwRAOr+nbpd1Q/GOuOIeT6gWYmuZ0H2WO59ujGC59+MYSJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055943; c=relaxed/simple;
	bh=P1RFG+COQDtA1pGNcFVUGHHXZDNGjOQ7cuBsZtBRVVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OACVxES5sMM+OBzaLXyKl7T+Z1Y2bOFfcNijGENIpMNjMu0fJvSiZHFyFuuAAS3J1k8PPv6+UWicfnKR3bXEoMiw8Bbl4lTeVlF/j8x6Ibk+DreO2/OA+86EKvYuRhZUzmuDKuTfaHkHHxnNQiPm8TkfK8EqXpeXzI8DgNxeKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgiVlHBD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055942; x=1757591942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P1RFG+COQDtA1pGNcFVUGHHXZDNGjOQ7cuBsZtBRVVc=;
  b=NgiVlHBDE4s4dcqp/Kdii7HW75hN/31/5k8E7DIVoZkVoTQniRXic2e8
   FglZj4YYfHijxQ8DxUbidwaZuXRuRbcyFVsiFt7cEw618YYw16LQhVGzJ
   nPP3ydsFqktUw8diofqXZCg6hf60N+bn8JX66FkYkVB+ahasfyeiOOlum
   nwd/p0sweRe1Otptkg7/C844IFxlauA6ljjJL3D1t14TGEPGuS3m4Tu5a
   7t5tcUZjQDNHrcboaDTBEg3zsDOj951CIDyPjWjzYGDcTvEDmwo4svwQj
   4toM2xDWE8FG+DaIaHRZ1a/qWfrLZtMVV3GoNQ64lwFopI2fw2yVXF+uT
   w==;
X-CSE-ConnectionGUID: r28rj4QqRxmMZOpWJw8vxA==
X-CSE-MsgGUID: E9o1dO3tR9ijdDL9zFiydA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417198"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417198"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:01 -0700
X-CSE-ConnectionGUID: iICmPkN4THC05jr9iTmW9A==
X-CSE-MsgGUID: yVXssQLqSlqGSV+Tpt/uDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292706"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:58:59 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 00/14] soundwire: mipi-disco: add partial SoundWire Disco 2.1
Date: Wed, 11 Sep 2024 19:58:13 +0800
Message-ID: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds partial support for the SoundWire Disco 2.1.

v2:
 - use mipi_device_property_read_bool() to get "mipi-sdw-sdca-interrupt-register-list"


Pierre-Louis Bossart (14):
  soundwire: mipi_disco: add MIPI-specific property_read_bool() helpers
  soundwire: optimize sdw_stream_runtime memory layout
  soundwire: optimize sdw_master_prop
  soundwire: optimize sdw_bus structure
  soundwire: optimize sdw_slave_prop
  soundwire: optimize sdw_dp0_prop
  soundwire: optimize sdw_dpn_prop
  soundwire: mipi-disco: remove DPn audio-modes
  soundwire: mipi-disco: add error handling for property array read
  soundwire: mipi_disco: add support for clock-scales property
  soundwire: mipi-disco: add support for peripheral channelprepare
    timeout
  soundwire: mipi-disco: add comment on DP0-supported property
  soundwire: mipi-disco: add new properties from 2.0 spec
  soundwire: mipi-disco: add support for DP0/DPn 'lane-list' property

 drivers/soundwire/mipi_disco.c | 144 +++++++++++++++++++-----
 include/linux/soundwire/sdw.h  | 200 +++++++++++++++------------------
 2 files changed, 206 insertions(+), 138 deletions(-)

-- 
2.43.0


