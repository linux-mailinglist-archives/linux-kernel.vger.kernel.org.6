Return-Path: <linux-kernel+bounces-537824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559D3A4918C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D35416DB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8492F1C3C1D;
	Fri, 28 Feb 2025 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVzgVPF0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEFA23DE;
	Fri, 28 Feb 2025 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724108; cv=none; b=JE54LdT82aCWNVZ16uMU8f7Hhxpv3QJmkQxcuMI5L90Q52yS/UgJOMLhrXQ9/LHw4mQYh+CTsBcs0TpVU4KdvRIHXM/JBL09GL5twDfkCQTz4uQw6uz1DifzAFGBiPlxjUKu+2bg1pNwcY42304T66MFN8I+uCNixfd4TjZvsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724108; c=relaxed/simple;
	bh=JYQpoBxDWX1atOvLNpQMu/92Q2VyC3fVdzrEB6DbUr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f2P6mUHM1iQ16Yrd2gKzJ13TECJ5A7I6xnEJcR2rMBU8c4nOKFlLEK14iGA+XBkx55HsO5V8tTwHsi7aNGAll9/8bqM8ca73kbMTyswblWZB+i0+FAHVj2QE7jxYJUfiFDglODw16GSzcHM7FwxGA6GPS+7pBbMAApT7/Qwlph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVzgVPF0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740724102; x=1772260102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JYQpoBxDWX1atOvLNpQMu/92Q2VyC3fVdzrEB6DbUr8=;
  b=bVzgVPF0xdIlL/8kZ/ktNRzR+Ws59EAq2jDhpibOD5trAy9udglckl/F
   /8Ujt08uYrNY0qFGlX3WRA+m8QhF7d0qMfSzENTCJjUtoZ+Jv6CW7Jwch
   t7f1QU7xFSWpXqZ78efHb8oL35jpWjsCbVqpGyrRfEtZD3K1Hrn8nnEoh
   OOLmKx9iKhwO2x78QzPbH2qIaRNXl3Z/Udx4ASxJOYX13TePWeQ0ilDy1
   0SxY0DmLzVlua1Jn0G/WQYsC3jkTJY1rFgBkWEwvRPHKMh2loZv2Fst54
   e3IhgVUmnWIAhcA+Ic3CTgDZ28xPXNZPUymR7QTiklX2UiRXMuZ0XF+Zq
   w==;
X-CSE-ConnectionGUID: a0UOw8MrSUuSr0eCJqzTiQ==
X-CSE-MsgGUID: +5ZuGzvOST6iRf0k98juSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41560563"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41560563"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:28:22 -0800
X-CSE-ConnectionGUID: VbhhwK40QleAD3U+91TRxg==
X-CSE-MsgGUID: E4SXyTX7Tai8K219GPUtMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122265230"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 27 Feb 2025 22:28:16 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	andriy.shevchenko@linux.intel.com,
	cezary.rojewski@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	jbrunet@baylibre.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/6] Convert sound drivers to use devm_kmemdup_array()
Date: Fri, 28 Feb 2025 11:58:06 +0530
Message-Id: <20250228062812.150004-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series converts sound drivers to use the newly introduced[1]
devm_kmemdup_array() helper. This depends on changes available on
immutable tag[2].

[1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
[2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com

v2: Split patch series per subsystem

Raag Jadav (6):
  ASoC: Intel: avs: use devm_kmemdup_array()
  ASoC: hdac_hdmi: use devm_kmemdup_array()
  ASoC: tlv320dac33: use devm_kmemdup_array()
  ASoC: uda1380: use devm_kmemdup_array()
  ASoC: meson: axg-tdm-interface: use devm_kmemdup_array()
  ASoC: uniphier: use devm_kmemdup_array()

 sound/soc/codecs/hdac_hdmi.c         | 3 +--
 sound/soc/codecs/tlv320dac33.c       | 6 ++----
 sound/soc/codecs/uda1380.c           | 6 ++----
 sound/soc/intel/avs/boards/da7219.c  | 3 ++-
 sound/soc/intel/avs/boards/es8336.c  | 3 ++-
 sound/soc/intel/avs/boards/nau8825.c | 3 ++-
 sound/soc/intel/avs/boards/rt274.c   | 3 ++-
 sound/soc/intel/avs/boards/rt286.c   | 3 ++-
 sound/soc/intel/avs/boards/rt298.c   | 3 ++-
 sound/soc/intel/avs/boards/rt5663.c  | 3 ++-
 sound/soc/intel/avs/boards/rt5682.c  | 3 ++-
 sound/soc/meson/axg-tdm-interface.c  | 9 ++-------
 sound/soc/uniphier/aio-cpu.c         | 8 ++------
 13 files changed, 25 insertions(+), 31 deletions(-)


base-commit: b8c38ccb2ca52b9a38cfeb9f89abab5d6e713221
-- 
2.34.1


