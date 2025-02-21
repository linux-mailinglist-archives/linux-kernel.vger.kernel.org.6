Return-Path: <linux-kernel+bounces-525184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD1A3EC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CEF3BC9F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8D1FC105;
	Fri, 21 Feb 2025 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5vLdfVN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C991FBEBE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740114512; cv=none; b=C0omohLZF0r6A0uCM1v0czVUOSWuNiUrmcXwjnnImLQCROGXWDszAeaiuum05hye+z5ewhrUUHHxbqwxDKeTrqmSuju0w1OuK6/1wlWDBoRObIDrym58qtLbUcDmLZ4g8hkqFYYOf8Y6M8dEwfWieDLsVMLa1ozrrrC8+ngT2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740114512; c=relaxed/simple;
	bh=TVYoOTVKyEAencSjBAyeJyQSl8CPe1x13zL0NhN2xus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QV2M5jOwZr9CUP4tATngSTKNtJw8DN26C0whgjq+mmSGaImF9+/R9Wkn7n4lhysWtqfbK4HzF4XIIAY92Yvpj/xP77Ij666Jgtj1ND8A+yclb4lsP4xKpqtJaMBhwyw5qrAD3sns/RF/mofi2zGTJAjhg5KK8A1aeh8EdGe7GhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5vLdfVN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740114511; x=1771650511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TVYoOTVKyEAencSjBAyeJyQSl8CPe1x13zL0NhN2xus=;
  b=i5vLdfVNQyRtBP03DIm4ljTtRt/CkdSMZ1yXTPhoGOgqJbW7VdfwskYj
   Jv/ZMps6Ghyor4OfxYjxz+GHBQDOrs5Y/j+SrurPJanyt5DO99JZNvNke
   77hzQ8a2eDc/ei+d/7kCRhdAjf6hG+Rg3iHo9WLSfYzlQHIBdPKlG4vzE
   BMghOGHf/dMpuZ3cgdpiVpIIZA3WTBGgNDNzybSYiab3EBkXEbZBJZmb3
   kP8sVMjaOMxB1NZz114+yXyi1DBfYhEUMs1HzAAwfavQ/eSDhTdLMj/Ua
   OHwwe+0FUN9ytELXV4veohVbRN6lZ2JCvbZIyKxHrQaoxhUp2LT4Kx9iW
   g==;
X-CSE-ConnectionGUID: 8eRkFdomTwiLR6kAUXmQEQ==
X-CSE-MsgGUID: dW1kyMiwTcC16VpM9TG0Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="28518729"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="28518729"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 21:08:29 -0800
X-CSE-ConnectionGUID: +w0BIQlaQHaI+AIUSMhEyg==
X-CSE-MsgGUID: I4ZCIjD+TxeYCAuuxxPisg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="115459304"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa008.fm.intel.com with ESMTP; 20 Feb 2025 21:08:27 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/2] drm/draw: include bug.h
Date: Fri, 21 Feb 2025 10:38:04 +0530
Message-Id: <20250221050804.2764553-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221050804.2764553-1-raag.jadav@intel.com>
References: <20250221050804.2764553-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Directly include bug.h for WARN() helpers instead of relying on
intermediate headers.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/drm_draw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
index cb2ad12bce57..0a0e1eebf481 100644
--- a/drivers/gpu/drm/drm_draw.c
+++ b/drivers/gpu/drm/drm_draw.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/bug.h>
 #include <linux/iosys-map.h>
 #include <linux/types.h>
 
-- 
2.34.1


