Return-Path: <linux-kernel+bounces-429519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7FB9E1D59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87961164D02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747FA1EF08B;
	Tue,  3 Dec 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5q27q50"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974E192D98;
	Tue,  3 Dec 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231910; cv=none; b=Pg7kQvVNbD5gA7zLWshlQAv4rKDpJ/GThpUmfxaI51kYr3rRAQM6c97mOAqkPEt0UC3eX5gdBmEO0a9m/PDyjNVd78hsAqyR4aPSgxV7CKpFtqBL+lU3TKM+WE+pEakOux2i9V3IdkhOKhKN/Yjg2BHTRjsWrk/LgT79a4FJFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231910; c=relaxed/simple;
	bh=s0DN9hpt416mOBUPedmlYijDtppPsLc3JjgXQAAVFmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ieuSTapKzR36a8fGOHrpswGmlIkgjqmVngKTuLOGcME0L1VWThd/6VEJt76UfdphlNYpDvW8+jKZLQLnPCM9IoAxyLhRUjrSeGBWr/rHk/PJmusaZYZW1RfZkJ/YcGeVqv3KPR/EJ8inyrLG+jLeOF3kF8Weempj+E1gnzuxJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5q27q50; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231909; x=1764767909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s0DN9hpt416mOBUPedmlYijDtppPsLc3JjgXQAAVFmM=;
  b=O5q27q506tSZKc+0LUehG7FBUlfjQIbXkGN0sxJ71c9Dm+HL8bUwBgnC
   cFjW7XlWo6YKKZoNgmjqj/0DuFVgKWWR9jgKpICO5/1M7NiolLga1dm7p
   hOxuCJl4Q41vgII8jZRp7CdbphXTZlN+R6GME+vS8Gv83M6KWirlTGx01
   whhCWUYKdY6+uaPAewBFaRpFvVRbEzk8d/69lU4KQSsWluzsfNObLe4fP
   Pmi+zA48NPGitDZUq2pEq3OlGVlKsesTR7D94gQgVpytl328PnSzIRDBu
   liAT5NUnqQ5HcG5EYB28YryMlfIerZTBZKqAXb9KIq/oq3DJEgQcxiENu
   w==;
X-CSE-ConnectionGUID: lToErx/zRRadmHylfZOY5g==
X-CSE-MsgGUID: tmvg4qweSyu+NKFuBHXECA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500705"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500705"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:28 -0800
X-CSE-ConnectionGUID: N76no5O8RvibfqIJIG/Dug==
X-CSE-MsgGUID: LVMluU+iThC/MC66tzetqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896040"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:27 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 00/14] soundwire: add multi-lane support
Date: Tue,  3 Dec 2024 21:17:59 +0800
Message-ID: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

v2:
 - add 2 commits to fix the issue of starting streams simultaneously

Bard Liao (12):
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
  SoundWire: pass stream to compute_params()
  soundwire: generic_bandwidth_allocation: count the bandwidth of active
    streams only

Pierre-Louis Bossart (2):
  soundwire: stream: set DEPREPARED state earlier
  soundwire: generic_bandwidth_allocation: skip DEPREPARED streams

 drivers/soundwire/amd_manager.c               |   4 +-
 drivers/soundwire/bus.c                       |  65 ++--
 drivers/soundwire/bus.h                       |   3 +
 .../soundwire/generic_bandwidth_allocation.c  | 316 +++++++++++++++---
 drivers/soundwire/mipi_disco.c                |  40 ++-
 drivers/soundwire/qcom.c                      |   2 +-
 drivers/soundwire/stream.c                    |  67 +++-
 include/linux/soundwire/sdw.h                 | 192 ++++++-----
 8 files changed, 519 insertions(+), 170 deletions(-)

-- 
2.43.0


