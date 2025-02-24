Return-Path: <linux-kernel+bounces-528265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B75A4159D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEDF16F335
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EC61B413D;
	Mon, 24 Feb 2025 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcpoDRGN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998CF207DF6;
	Mon, 24 Feb 2025 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379519; cv=none; b=EBdXsRAHVW45eKcHwCmHfx47gsqzydYsla88G9XTM6cau1c8445kjo5y/7N3SnPokTTCX+bRYmI7YjRZJIrRHg8siAozv4WXmHwRBfyiVHU8ZjxarBph+TDGDGx7IclMxuogTzKhLEa8YUJ/mtXw3sNj/NNBpBZGp3ewsBqRnbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379519; c=relaxed/simple;
	bh=0TnaDdbMR1QNtHbB/qr6uHPlnA8ZDUaXNcbX/zWenMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JraYOEhe9Abp0tJxyKmcrC5k8W1juhIsh4ioLokVqr/0K18inUkwHR2tg4jnxr2m+RmdEdk6KpBYobdGh3gqk98lU0cMyHwd+8yNOA+aN/+pBv5VmwuHbLUo45BFZivuMuyoSfT9EW/VP2ftMjfMZG4cJlUvnDZCC9FC+V9nTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcpoDRGN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379517; x=1771915517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0TnaDdbMR1QNtHbB/qr6uHPlnA8ZDUaXNcbX/zWenMY=;
  b=dcpoDRGN7ZBRE2G6ct/xYEOgaX+UnpJTHje1rcx9GHVFG7To+N0AiOxH
   3b/pG04mDBujXBStGRut0v9BM089JKCOphA+09qxhaB41KH6Zcv4q805F
   sFO9QTuT88KwkjF6GnfN5xT+OnHlowAVAQoe4bBmnzkZ1mzAHifahCYf8
   pP7TpJqylhA12cCjFeXKEiVr2qfRt3XV8qZNoHMEFSGCiiLBJEyr8R4ua
   ndKaifwUrt0n50g/CF/ZAueWMI9SKONNzTrhl5xbcLC6EvTE/lhOiRtn8
   0wSe6gH+dySR+KVitwCttqerrDyFwusmitox4kEEynp1hDdP+ejj2tQ+9
   Q==;
X-CSE-ConnectionGUID: JcQemXKkSruM4YrgcQQ9Ag==
X-CSE-MsgGUID: AE2jahrhQN+nqmsoHncrIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58538911"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58538911"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:17 -0800
X-CSE-ConnectionGUID: +VoswLeYSDWSD+X/KVZezw==
X-CSE-MsgGUID: aWexeXhpTTWewOaj/4ntOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597638"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:15 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 00/16] SoundWire/ASoC: add SDW BPT/BRA support
Date: Mon, 24 Feb 2025 14:44:34 +0800
Message-ID: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
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
 drivers/soundwire/cadence_master.c            | 658 +++++++++++++++++-
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
 24 files changed, 2294 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/driver-api/soundwire/bra.rst
 create mode 100644 Documentation/driver-api/soundwire/bra_cadence.rst
 create mode 100644 include/sound/hda-sdw-bpt.h
 create mode 100644 sound/soc/sof/intel/hda-sdw-bpt.c

-- 
2.43.0


