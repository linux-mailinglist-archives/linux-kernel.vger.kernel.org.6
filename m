Return-Path: <linux-kernel+bounces-180775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9598C72ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A1D1F22F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781BD1411ED;
	Thu, 16 May 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBPcHUMO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6FC13E88C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848446; cv=none; b=qwDqEBlBfDL9XZU4L8DaUOfIG8fyZlP1nGiwZewFxsP6qD/dGiAiowahFt0aPi1agNTcKY51YXPRk2e2Kdg4iiloNMlAHHy0lPeK9Pz92PiTdwPNxQDTO+Lys7qSrorlQwp9Omt0w0OFTrHmcrdE1GVDBXiqBHLCvjjeQ3N/LjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848446; c=relaxed/simple;
	bh=hIe/GV+SszjqFG9FGCcYxpExlFJkuc/XiXVVaFGHMwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f6/c3n40jzTZog/WrrI0klqRrufz9oA6jxVcXJDH6fj5vcUrI7NvbYpqzRPriJGpoQ7E7iOAbkr64EeQJMBV0ZrZNKeAEO8COeKDXAtnZtExKcgqjCXoaPvG2xDB3RT/yECs7YmdstpKTpYZNALebUk/WnV605DitsRafbbReGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBPcHUMO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715848445; x=1747384445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hIe/GV+SszjqFG9FGCcYxpExlFJkuc/XiXVVaFGHMwQ=;
  b=HBPcHUMOtS/0KsrzhcI6N/QfxIx/fm+BFvI8JSi7KSEyT4QLd6JfAfgr
   UGsKLAIBS228RHq1XwcsRzJ0zHz0f1fr1ZkHd302SEyiptPwGQdhpgl/M
   eKJbRdWrZ4C73M2QCD2hpj9rG2eOq4AdL/2U5/SbHGMtFQthRwhGHFqrZ
   JYdzNtpcEOg/z68rIWWQJzjaefS0JDQTAsR7/raMZDk6HRhT6C6mCAE2v
   rdV+Z4EE5FHeDHErr4AdDOGcr9iBjgCHPyqOad5VGDbyPh/GIPWl5GF/C
   twQ1LEOgzhh1uCGzKMupi4nrYskoqdMYn5vEj5dOVA2i1QOtClw1BnMf9
   Q==;
X-CSE-ConnectionGUID: a4PmO9vDSVmgzWe+fgKrRw==
X-CSE-MsgGUID: u7lRcZWoRwO30DItI9GicQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23081689"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23081689"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 01:34:04 -0700
X-CSE-ConnectionGUID: NNgXWuVAQfWrK5VFPenzMQ==
X-CSE-MsgGUID: 5lfnjkIfQHWuizl9w2DZKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="35910641"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.208])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 01:34:01 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	airlied@gmail.com,
	Jani Nikula <jani.nikula@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] drm: have config DRM_WERROR depend on !WERROR
Date: Thu, 16 May 2024 11:33:43 +0300
Message-Id: <20240516083343.1375687-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

If WERROR is already enabled, there's no point in enabling DRM_WERROR or
asking users about it.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/r/CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com
Fixes: f89632a9e5fa ("drm: Add CONFIG_DRM_WERROR")
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 026444eeb5c6..d0aa277fc3bf 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -450,6 +450,7 @@ config DRM_PRIVACY_SCREEN
 config DRM_WERROR
 	bool "Compile the drm subsystem with warnings as errors"
 	depends on DRM && EXPERT
+	depends on !WERROR
 	default n
 	help
 	  A kernel build should not cause any compiler warnings, and this
-- 
2.39.2


