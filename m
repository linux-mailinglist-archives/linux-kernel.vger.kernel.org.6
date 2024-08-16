Return-Path: <linux-kernel+bounces-288859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322D4953FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52992854ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5054EB45;
	Fri, 16 Aug 2024 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUjZSkya"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB147F7A;
	Fri, 16 Aug 2024 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775628; cv=none; b=q42vKeG8bVmuMSSmRpucA3GaXiYrPhT3SrTymnQx900eysF93APZ0eQ4C1vtyLLPQAhi6HMY3oGoSiLTjHs6kBLkHJWf5oCBTrHWLS/5SjYWEGisRP9yYegC2c8xzYIWgBARksF8cZLgSZ76iAHxfBIxr9Nt9/W0NTLmWMKPtqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775628; c=relaxed/simple;
	bh=j/Tmxz2nOBApFpWXdFs4/pzneW3wrT151GdufwbfMjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jqsmm5Lt1keied+y9wyrQXw1n5M10VA/kYllFok1yKhnQyKt9tph61gFmzvcgUD/RHiOWx3kZz8AuoTPvGWWmzsfrUdWYvAoE/ee9+piYyS4lbxXnhait+nbrqvJ4C9AT3VQSboVKZJpV2hfvfXnOGgEE9hvtYcUrmbw4kZIt4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUjZSkya; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723775626; x=1755311626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j/Tmxz2nOBApFpWXdFs4/pzneW3wrT151GdufwbfMjo=;
  b=UUjZSkyaJV5mAenSVheHiQxpUXGZvHt3vBmc72RKUOmubYo5eT/i/wL4
   njtARIrDcwcf0rQe+Zrf6bAodYVkfCSiLY8FHXUcNuc2mgef1J6ll7WO7
   ZjdotPwJetD9YlcbhAJYDcINzv4j2w/j9K/Ojh4oOYkRboFHmpc2Qc/BC
   AGOYNL93QfdnkBPVYp6OcdM1DkjCGkz+9tz9E1fQTKsFXnR2OYbdRUNun
   xvbuf6PcTqowB7Qo//g/B3E4VOMsEN7GG/nli3VNGuCfQq+oE1On7Bknz
   YSuaCB7XBo80smvqiI8MaOeVyuTyfqP8+rHXHf19ek/W1bq9zm6JnTOA4
   A==;
X-CSE-ConnectionGUID: GkwNZMyaS122eOZQDQmJ+g==
X-CSE-MsgGUID: YihQ6oKqQjCav3KZFaDK2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22203550"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22203550"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:33:45 -0700
X-CSE-ConnectionGUID: Ytw8eBn9R5yMw1IpmiG5Ug==
X-CSE-MsgGUID: DnSk4vkXT8SNIkUEWZYueA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="63949173"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.176])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:33:42 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 0/3] ALSA/ASoC/SoundWire: Intel: update maximum number of links
Date: Fri, 16 Aug 2024 10:33:28 +0800
Message-ID: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
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

Pierre-Louis Bossart (3):
  ALSA/ASoC/SoundWire: Intel: use single definition for
    SDW_INTEL_MAX_LINKS
  soundwire: intel: increase maximum number of links
  soundwire: intel: add probe-time check on link id

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


