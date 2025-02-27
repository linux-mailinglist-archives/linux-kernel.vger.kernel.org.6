Return-Path: <linux-kernel+bounces-536101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0227A47B85
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB97A3E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9881E229B00;
	Thu, 27 Feb 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNyOrG8B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C51DC997;
	Thu, 27 Feb 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654703; cv=none; b=uU5wvMU4rA/u3JHgpBpj/f3+oODGRKNvvJRTDtujx111CG1KSkcx0aH9x5eDezrgHvOChTeIAohCufXfIYPOavIq1xxh0Q/PZHldyfFJJGTlWC733lJjNNwQ0HAwQRZmT0QfQcfcIBIq3pB9Fciwq7RTzGSF5AbNfHtBAqARcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654703; c=relaxed/simple;
	bh=puyOqXTaAFdAHzneFujskoG6Urd7foCgfpM+CyvxkDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g8e8IPvEXFnGl4vnp9OgFLw+HFsCaPUKdU6SPCjohWppt3I3LIhWgczfy8hVB1DhAaM+UhCNnUnOToU7f8jN1kQyzCRQfalhFtqZlTV2SGjC++eBNC36sOGwkZweCHLYVRAFZWdHSiY1srnZVYyYVMsKbMTX8pexnQNsOAiAJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNyOrG8B; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654702; x=1772190702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=puyOqXTaAFdAHzneFujskoG6Urd7foCgfpM+CyvxkDg=;
  b=dNyOrG8BjILr/plBEomfGPaybuKACRYkmju4z7daKOwEWoypzgh80jjV
   e+JeA6AmbKq4vDJTJ5arakqrsPxIFUqvJElwfkTLSXZnfY02WEoffBwKb
   hlJOAajW5u77w7oJV1R1H1zDFyRvOc40CYItqBxA8Lkuw7+U1FkVeiHGP
   ivkICzFRO1tx7CWuhQwqdegiNfSMNVSqDxRBHf/aJp6HbX6ZYeHjLJZKI
   NiXl9MtTwqs/MBPAsNI2PSPC044OV47j99NQ/Nug0r4FLs8+kXnWlQ793
   IALB/S3eYQxVQGoDiVoayhlXrfKU+UgDf7rK556X7yUdkkbiyNKZnfK0r
   g==;
X-CSE-ConnectionGUID: nmOg+TZ0Q9qvir+Ozt0WBQ==
X-CSE-MsgGUID: XNmv65EDS/es/rlScnTfWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189781"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189781"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:41 -0800
X-CSE-ConnectionGUID: gE3XcC18ScGnK0pM5r7C+Q==
X-CSE-MsgGUID: lVrehQdLQry3NKbIWluP1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154178899"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:39 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 00/16] SoundWire/ASoC: add SDW BPT/BRA support
Date: Thu, 27 Feb 2025 19:11:13 +0800
Message-ID: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
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
 - Change sdw_cdns_write_pdi1_buffer_size and sdw_cdns_read_pdi0_buffer_size
   to static values.


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


