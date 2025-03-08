Return-Path: <linux-kernel+bounces-552709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0924A57D3E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2850016C3E6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8B0214808;
	Sat,  8 Mar 2025 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQBI1T8b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E6213E87
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459020; cv=none; b=F/E4OpzCotVbzLjlug1aKR4M/suBmqZodDFEvR9b6qTYlufxT9XDrlBaY6Rz9WWmewt9AU91bZ7uXjCUaTzCAsivLZuokudwALPH4W+P612mtZFyGwAlkVsb5K44YDhc/93oWNdND8ubJvX2rfeqtJOstfBYAB4iTTMXZ9L0vco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459020; c=relaxed/simple;
	bh=ICxQvEvaELWXWRTD7ERZkdpAUoDpnDms71ShTxZILq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cmEeQKg97HWRO+f8/v54MwMSJAqsf0xfkwbnlxKsy+br5NSs/T+sO9fdKZeIietKL72CUkmjcwSnDpV0IxsJAox1dUlc6Dwi0Oy9LmDz1/05FUrAeSJ6cL71Sjcy6qkianxaI+S6Sb6p42bNuICgvpUdqZSgZFShAC+G2MJ+Op8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQBI1T8b; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741459019; x=1772995019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ICxQvEvaELWXWRTD7ERZkdpAUoDpnDms71ShTxZILq0=;
  b=KQBI1T8bKaFjcH/XnkQOhZhqfjjL/aBDU6+ElaH9zt19uYzOVTch5J4/
   rLaC2O0dpyJhzaqR4mCnLIS2e7cClQD2NDF3TjuIYyvrVGiWdf/K04nl7
   bC+L1dhQdO8iKbeOF/znpsXq/pBtO/nC5BZ+2mpGXiaRkLNeJDXfEwwij
   ggL7L757fdInzy5Oj/Ok/N0py0TMZvayITY76p7ZYEP7QH+f8M7ZznNoM
   xWMcUCA6iTvvE/WrPq9Pm+AhTk8Cx4smO0KxQ9HW0YpSmr1jaIzmhLomG
   xowQd4GKh5LMh3vIrQQtN7vgpwb8e6WnLnoqXkE7x2iNmCwn0nlUvKkhM
   w==;
X-CSE-ConnectionGUID: v6IeqwHNTam91Ck4xwAjwg==
X-CSE-MsgGUID: 3R9Y6mOySNejXB1v8BbeIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42532464"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="42532464"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 10:36:58 -0800
X-CSE-ConnectionGUID: peHxExb8RiWg0fMprmlMvw==
X-CSE-MsgGUID: oAv+XfKmSFS4HMQ+ecVGYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150548543"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2025 10:36:57 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] Platform Temperature Control interface
Date: Sat,  8 Mar 2025 10:36:52 -0800
Message-ID: <20250308183655.118285-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Platform Temperature Control is a dynamic control loop implemented in
hardware to manage the skin or any board temperature of a device. The
reported skin or board temperature is controlled by comparing to a
configured target temperature and adjusting the SoC (System on Chip)
performance accordingly.

This series supports optional controls from the user space.

Srinivas Pandruvada (3):
  thermal: intel: int340x: Add platform temperature control interface
  thermal: intel: int340x: Enable platform temperature control
  thermal: int340x: processor_thermal: Platform temperature control
    documentation

 .../driver-api/thermal/intel_dptf.rst         |  15 ++
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../platform_temperature_control.c            | 181 ++++++++++++++++++
 .../processor_thermal_device.c                |  15 +-
 .../processor_thermal_device.h                |   3 +
 .../processor_thermal_device_pci.c            |   6 +-
 6 files changed, 218 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/platform_temperature_control.c

-- 
2.48.1


