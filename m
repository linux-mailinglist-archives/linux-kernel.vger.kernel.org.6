Return-Path: <linux-kernel+bounces-348648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D7F98EA11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942851F2775F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE6D83CC7;
	Thu,  3 Oct 2024 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1U1rkER"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2C208A9;
	Thu,  3 Oct 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939243; cv=none; b=YUut1TOSpvU4ZjPq8P/Xl5jEOl3aJlAlU4cV4ljiNoYpzEP7mbritsx9yiNodX5C6iSYm9oqf0RJwh72sSCzMkmafuNyCe6Zf7wXgViTFa7vOOW7PHLOi+OSDwW6l0ljP8rE8HZAAkYAJsuQ/51+AGpMYEPNGxBXfM5BOffy4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939243; c=relaxed/simple;
	bh=BkBckbamIhAtwaoN2T2BEwkWDzAK6EzKlNIsEEBxkz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCXK4MlDSS7YvAgoMTCixQsh3N9ZPnaz/AediELvqsY0aF4Npm8hxpqsENemKeSCkBlBp+UZnsID4tmNfrWWIMjxilBh+MLEytDF1i6QhAZ3FAmSw8rmTL0HpJUf5jes+cgz3VOrAVJlr5Z1pWQpvLcYQIQNhNIDKX1QmQIkbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1U1rkER; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939242; x=1759475242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BkBckbamIhAtwaoN2T2BEwkWDzAK6EzKlNIsEEBxkz0=;
  b=B1U1rkERmT/f8W3qEAVwKQKLczeSeoSEvlBgZf4RjpC/GDmgnLCisBtj
   h30AqKUeNr5ztXgyjKH7IJHQUp0gDwZOIsl3QWyoq2v4Nt/fQ2FIlfVxZ
   o3WHonLG33nrh6glxQu3kQtqUS2TP8E95gVpslBATL0SBe//y76vM8pfl
   u8kyXhLE0vsiutK7lXAGZqRKBqahWp0E6rnFZ56mtPnB8DhNtJj0PT3b6
   zDDk4/HHUe/nvLmE0n730gwFjoGHuiUnoUXuF4ZtWM8taeWuSDL/wsLSy
   S/6vmYv/xc45xK7VXUywMBF3fyDJvNesEzsOYEXeD884uqHOrxDmK35uG
   g==;
X-CSE-ConnectionGUID: 0hPtWPqcSB+CdpB1GmA7jg==
X-CSE-MsgGUID: CZa5Fu1dQ1+nnCM6iokOTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070712"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070712"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:22 -0700
X-CSE-ConnectionGUID: ZT2nccotSnmBFAUvFLAOMw==
X-CSE-MsgGUID: 9H1HAvELSLiYNexI+duZmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508378"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:19 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 00/14] soundwire: mipi-disco: add partial SoundWire Disco 2.1
Date: Thu,  3 Oct 2024 15:06:36 +0800
Message-ID: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
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

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

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


