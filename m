Return-Path: <linux-kernel+bounces-535711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1DCA47651
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED673B18ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A20B2222A3;
	Thu, 27 Feb 2025 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hr92AC/d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E22206AC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640109; cv=none; b=TgmoghHPAZM8XgiMkwpwdB5lNDzA0ZL0hLcpqv3BsP+BnmGtD68yoMkrgZwKdWzIe3YcuKTIumgatO8NeNEmqjQOi/QG1EvrMlGKHENGgi5IxrlQi0el/76nt/IwDkRsYyUmD69Qj8pKBiaE2oE/cS5hqZ4OuWSJkD1oSTb+NSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640109; c=relaxed/simple;
	bh=ITwkKu7/jE4M2GGDC8Gq0PXRGW8IylfszRaf/ug78Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHlaPKvXmjcE+HvwBjkskd52FYmJ50s8HYivLI1a1EYoKSXHhfb4GNqHRhnjvElWVAE6RXWI/pNpYaMcy3x0+jeO2ytEcVXjhNID9EHuz9rjZgNnIHe/j1rcyMBn8/hUVobBtZj+cSpwOZ6hz1hjLSh+NfI7LwYBaVejongN1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hr92AC/d; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740640107; x=1772176107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ITwkKu7/jE4M2GGDC8Gq0PXRGW8IylfszRaf/ug78Vw=;
  b=Hr92AC/dZ4qcG6fJdM+yDt1M0lEzeEzKB864RMV/C90a/6m6oqAm26dk
   VUL666gGz+Scs44Vwio4Io+zbqW4MsPD3by3IBKgCbBqn9ZFsNyb5YaTW
   7xfYawRIVExoOYRBmxz1W+Zlr/SKJdF2RnLj/3vBseKeSp5D4OXQ2nI9D
   7wPEpfJKIIsNt9ncsxjV4A+EB/jXkOvSOPnXmbdWXoVPY6wayBPkKIYW1
   c0E17+GbeRdzhW8Xge0XOGxcripAzoPLotQF3kgPdjqpu2cFlu9X2ivf/
   A37JJ3lje/qCBy+OZlCqHyafQoTFzTAsA64lBD7A0XnPTauBU5MoK0aNG
   g==;
X-CSE-ConnectionGUID: +tkQ4u0+RVi2qBS1ssCi0Q==
X-CSE-MsgGUID: vXsXxtfsT+uXADZ4OmR/3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52505367"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52505367"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 23:08:27 -0800
X-CSE-ConnectionGUID: 4oh7oMzAQzyc0T0iOEV00Q==
X-CSE-MsgGUID: y/LQkAcrQ2G+eeVi0tTkoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154125499"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa001.jf.intel.com with ESMTP; 26 Feb 2025 23:08:24 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v3 1/2] drm/draw: include missing headers
Date: Thu, 27 Feb 2025 12:37:46 +0530
Message-Id: <20250227070747.3105451-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227070747.3105451-1-raag.jadav@intel.com>
References: <20250227070747.3105451-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include headers for the symbols directly used in this file instead of
relying on intermediate headers.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_draw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
index cb2ad12bce57..385eb5e10047 100644
--- a/drivers/gpu/drm/drm_draw.c
+++ b/drivers/gpu/drm/drm_draw.c
@@ -5,6 +5,8 @@
  */
 
 #include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/export.h>
 #include <linux/iosys-map.h>
 #include <linux/types.h>
 
-- 
2.34.1


