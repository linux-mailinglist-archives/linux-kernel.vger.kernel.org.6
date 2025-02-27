Return-Path: <linux-kernel+bounces-535712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E14A47652
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1F13B1833
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90968223308;
	Thu, 27 Feb 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzZObun0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5FD2222B0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640112; cv=none; b=qvElQsS9pOLTUK1d2c3iNxklZTzVOPvQ5l4o9jA0NlqT6OYYcevsEzzNtiP6EgRqzQ57GCu0TisWdKWkL3YGR8QErZOzs4zL4cp63UjtSNrMwqbBIYDD/rbvvOX5MWGY5kfiRG/GYtWlJwWu98qTub9EK6rwUrDjja+7zvGrWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640112; c=relaxed/simple;
	bh=CYn+J+RYo7NjqKP9XZZaessz4aXZwAjvRg6hXxx+oDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bS1HuLcbI+qWn1vqGTAKSgbimQoStYyI4yS+PmygOIQ+I47coGk9a6bvUEEOfKLIWVzI8UGGXEhhXuz7EUPmxG3UIPv/tgLYCXtqNN8Wvx1eBXuqOrrNtLwIWbWeGGecn36NmBOjtg49OipiAg3k2fLvkPgXUEy4/CUtpwqGxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzZObun0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740640110; x=1772176110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CYn+J+RYo7NjqKP9XZZaessz4aXZwAjvRg6hXxx+oDw=;
  b=mzZObun053KIG9s0tnX2VZp2u7BNStIuYrAQmzxCCGfXDV9pABlngzJZ
   w7DuT0VJUfjL0FufZHVRf4zHNCuKvbwHsaU4fZknUEdTaVep0/xWrc+Ti
   T0AtAP569dibp58FgeRv0bIMzp6AMV42rwgK3yzS02TVhlHDte5SzYuD/
   aMG3Sr7Q5hyOMRF3YbWoIV3aVA3EdIULOfmm67418En+ZeTr4dub+N3Zw
   /fbJeKAi9dXQwUIh80z42SapmkPczoQzcuy6pCXq9sr9cw3qgP0RR4EHE
   t8KG9yxKmfwVDY2TF6xIew8MeVJvCll8CU/+J47Zr0VBF3IfmbWevXhba
   w==;
X-CSE-ConnectionGUID: BL+fdQnQTzuHRyqR6/W/RA==
X-CSE-MsgGUID: XGCc7IFuQwqar1v0VVbzzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52505379"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52505379"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 23:08:30 -0800
X-CSE-ConnectionGUID: BBjjK3xdQieAwBI/cIRqzA==
X-CSE-MsgGUID: Yb/h9RU0TWykJkybZ04AeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154125504"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa001.jf.intel.com with ESMTP; 26 Feb 2025 23:08:28 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 2/2] io.h: drop unused headers
Date: Thu, 27 Feb 2025 12:37:47 +0530
Message-Id: <20250227070747.3105451-3-raag.jadav@intel.com>
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

Drop unused headers and type declaration from io.h.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/io.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 40cb2de73f5e..6a6bc4d46d0a 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -9,13 +9,10 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/init.h>
-#include <linux/bug.h>
-#include <linux/err.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
 struct device;
-struct resource;
 
 #ifndef __iowrite32_copy
 void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
-- 
2.34.1


