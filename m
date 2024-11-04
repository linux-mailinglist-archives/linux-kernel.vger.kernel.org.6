Return-Path: <linux-kernel+bounces-394148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8B9BAB32
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757031C20CEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AA416E892;
	Mon,  4 Nov 2024 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ty2VZ5jp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B41F949;
	Mon,  4 Nov 2024 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690637; cv=none; b=KqchYyUpF/hOpUlzgzULkmqVLDH7iiOQ/o9Jv9yPoT4S771b8U8f8KtsKCThsnkTqvxqwxdB+dXNe+KwPbMvRAVPXADehvzFONawW1UOxsZj6oj50k6f4YW0VgVYwMlOjl7tZbDH3acaPx+eV4W0/NEv/H/DCGm1Mv0jbjOJgts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690637; c=relaxed/simple;
	bh=F5IiQMJxODFTMhtdPbad+JgCVM72TL40/B3O/2mB5f8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EE2jJrbqWdooj4BPDlfT3ndvqeoj9OAQSJSo3AXoH+5jKfRAZ4SDeujtzHnNnwTPdrc16fOIBCzj9rwyjSjfYETrb3Qhs9hZz/Gc+80epa0mPb06nwy/D4SMD2cyLyviG0ljznQJxza1Mx0ui19QXFhhpzJf4vqe8d5UyAiopaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ty2VZ5jp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690636; x=1762226636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F5IiQMJxODFTMhtdPbad+JgCVM72TL40/B3O/2mB5f8=;
  b=Ty2VZ5jpqTFEUKSbcxOrFYrosOs4NIgToWmK5XNGqkf2DJj5Vpq3opaW
   9Mf1bbr+raHxzlSkWkfAilptCKGnWIpYWANLY8i/qJkdQV3DsjdBEzOoh
   yejZNGVZfdhvGAdTCTq1XOs6HnlIaW8kqtNqhU7lbPw1+oFajukbeById
   zLpB8iGIUT4PJ3NX8p8oK53p+FQN/H3N+papnlT9SLz72Uvdarq2axram
   Upch61yu0sYZwUo/fsqE4zq8BGlsj+KUcRNa+LcMyW3Po99QvtZboWhxb
   6rHauy9hKWgjNpluFGqkWtUNais4EmZBR2LBcBh9l94OD7jF0nJcQx8dL
   g==;
X-CSE-ConnectionGUID: noYtTfMsT6iT3O6f4ElWug==
X-CSE-MsgGUID: 3c4HxUu+RQuTKwm2h87HvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594262"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594262"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:55 -0800
X-CSE-ConnectionGUID: NSR1HZ0bTmyug3S1Sp2cVg==
X-CSE-MsgGUID: 7qANL+CdQ76ltkWVWy7zJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331783"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:55 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 00/12] soundwire: add multi-lane support
Date: Mon,  4 Nov 2024 03:23:46 +0000
Message-Id: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds multi-lane support for SoundWire. We will get the lane
connection information from ACPI and use multiple lanes if the bandwidth
is not enough.

Bard Liao (10):
  soundwire: add lane field in sdw_port_runtime
  soundwire: mipi_disco: read lane mapping properties from ACPI
  soundwire: add lane_used_bandwidth in struct sdw_bus
  Soundwire: add sdw_slave_get_scale_index helper
  Soundwire: stream: program BUSCLOCK_SCALE
  Soundwire: generic_bandwidth_allocation: set frame shape on fly
  soundwire: generic_bandwidth_allocation: correct clk_freq check in
    sdw_select_row_col
  soundwire: generic_bandwidth_allocation: check required freq
    accurately
  soundwire: generic_bandwidth_allocation: select data lane
  soundwire: generic_bandwidth_allocation: add lane in sdw_group_params

Pierre-Louis Bossart (2):
  soundwire: stream: set DEPREPARED state earlier
  soundwire: generic_bandwidth_allocation: skip DEPREPARED streams

 drivers/soundwire/amd_manager.c               |   2 +-
 drivers/soundwire/bus.c                       |  65 ++--
 drivers/soundwire/bus.h                       |   3 +
 .../soundwire/generic_bandwidth_allocation.c  | 294 +++++++++++++++---
 drivers/soundwire/mipi_disco.c                |  40 ++-
 drivers/soundwire/stream.c                    |  63 +++-
 include/linux/soundwire/sdw.h                 |  10 +
 7 files changed, 405 insertions(+), 72 deletions(-)

-- 
2.34.1


