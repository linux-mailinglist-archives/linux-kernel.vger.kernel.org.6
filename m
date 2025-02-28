Return-Path: <linux-kernel+bounces-537881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D3A4920D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82E53B59C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988E1C5F23;
	Fri, 28 Feb 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCyR8OhG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CAC276D12
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727264; cv=none; b=jHf1/DORd7ZBDA4y1SAUFYi23KIDSy2rU0vk97Aev3NKnQsJyARCsbz96aoT4TwtYSxLHV68zffUxi2HE8BkQIJoZKFgxrU2Ta7fMvPGJPM/dTc5Z/hRz0vjN07PRXxD2e8+GFkc5e5RP3nL8uaSbS12jp7FsnM1USjJsjBlgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727264; c=relaxed/simple;
	bh=1gAWfoSMq8LFM7YVwcijVnd2p21QSP7sglR7kagc+3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L7HJkg8KZmAS87P1iRwRbN8TGIu4ClcdY5QCF6jfc8taQOlLGCGPvACix7tMMAvC1OLvKtvTaeoqT59xQLAK3XU3NknvPAUsF+5GTBRm05YpSaS5cXcuCN6NRE5L34S/wi9FfiB61vHgR1jnfvXjJzWbYA3Mip+gVqj8kRxh9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCyR8OhG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740727262; x=1772263262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1gAWfoSMq8LFM7YVwcijVnd2p21QSP7sglR7kagc+3o=;
  b=QCyR8OhG+JO8VnOSilpbSoC+j03FWwtg6cwINp73+r7t6InTZeA8sGXF
   4uphsD6jmlKA/DOMQONkZW0dMztP8OO3RUcnwQzCbjatVqLlG9NI/kkPI
   b9hLa5idYGyzVtwi4ujxSlNnoSvLaIfz3bEDr++Ng+YUw5E1uNQmDtnIt
   zqG+vsWew9IBaKSGw+4UZ+R4lA0ZHCveY2QCa+wzDxUcxGskb/MU+rsQx
   vawkY3iWYUM1HGhsgwHEKCXDy94tNdPbOT314c4Bf9/EfnsvnFw9VPSw1
   goyXfJGbbwSrNUc7fHJvX0HCG52bNQ41T5LozCT8y4MTHwW4HIzogvMdp
   w==;
X-CSE-ConnectionGUID: hjJeCcEuR1mN/DMlm0+tTw==
X-CSE-MsgGUID: 1dRh+YlkTkqy///6aAaXsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="29242628"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="29242628"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:21:01 -0800
X-CSE-ConnectionGUID: M607BflNSAaFQQvfmt8aHQ==
X-CSE-MsgGUID: wtuZKRbpSVuw4A/vWwr0+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="140487400"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2025 23:20:58 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	bleung@chromium.org,
	groeck@chromium.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/2] Convert regulator drivers to use devm_kmemdup_array()
Date: Fri, 28 Feb 2025 12:50:55 +0530
Message-Id: <20250228072057.151436-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts regulator drivers to use the newly introduced[1]
devm_kmemdup_array() helper. This depends on changes available on
immutable tag[2].

[1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
[2] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com

v2: Split patch series per subsystem

Raag Jadav (2):
  regulator: devres: use devm_kmemdup_array()
  regulator: cros-ec: use devm_kmemdup_array()

 drivers/regulator/cros-ec-regulator.c | 4 ++--
 drivers/regulator/devres.c            | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)


base-commit: b8c38ccb2ca52b9a38cfeb9f89abab5d6e713221
-- 
2.34.1


