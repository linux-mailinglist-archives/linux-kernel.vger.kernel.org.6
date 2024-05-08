Return-Path: <linux-kernel+bounces-173170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E18BFC7C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E1B1F24F51
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FE98288C;
	Wed,  8 May 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jz8zI2r3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81CB29CF0;
	Wed,  8 May 2024 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168607; cv=none; b=LtTQhGnuaRDYClvYgkrM9TjNCHUXQaGVskqUE0znOwrgFr1UO9Sxh9MjJSYvxbddNrFeWLp3VpjZOdPrXYVf+pKqGcb/+PN3UxLfzsY7vITfnx9yK533+XjsFFH/owvojEwNjciml05PcfegRFC9mduJ9EZXTL1ooRHJB7WC2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168607; c=relaxed/simple;
	bh=1m2nbM23V0tx0sSUwgJb7FeeRrIbu7fforeAmziQniU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITB4ZAjMcdMHevRWvLQyu8j/Rbn6OhYJ/swrKI5xvrJSIzo14d51Wjpfd75Lx0NwqNPsbo+Z855dyP0V3JZg7aFtagnURt88Zs262/1lsTNcR54sbm3pxbo3KT4JJSft95P3UnpcoL20AeWVeEDdPOilNtwW67h+JtNZmYPFfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jz8zI2r3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715168606; x=1746704606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1m2nbM23V0tx0sSUwgJb7FeeRrIbu7fforeAmziQniU=;
  b=Jz8zI2r3KYfZwcCjMs/vW8SmdcqfF/3SiFvQQyhC4Yh/ppwHZ1g2tlT6
   gp/pmH5iz/E/LrM1eLxf/o3MvAYn6NcPUjMREFEGAe4ErsGTXIPjoErcN
   vjP4SFtlHdVVqKqugRLqBzXiZqfXVHwPfFUDZ/AAnRixGDDVy+Ae3IpYJ
   SCDbu8+sXAGC1nx9bkU4aGYcIwNDGI3hsh6sVzLWkQ2tc8CEQeWSk6utC
   0RugLf5iKaMHSRTV6i4JYomysqINgcheMTCMRIdDL3gVjons+P6iKUp1S
   XU1nnGvJLmGiQu5vDjLMq/FXws9BFYMmq0FjLr6TJDZ48XHkI3/j5YWGV
   w==;
X-CSE-ConnectionGUID: Vz8iCMXQSh+8VjVTv1OwOQ==
X-CSE-MsgGUID: I+tQzHagSWOcQ0L0DeEizA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="13970550"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="13970550"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 04:43:25 -0700
X-CSE-ConnectionGUID: dcFrG9LvQAyheD0PLkl7bw==
X-CSE-MsgGUID: f4z/4969QEqmFCJSXPGe+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28827895"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 08 May 2024 04:43:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AE5CC11F; Wed, 08 May 2024 14:43:22 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mfd: omap-usb-host: Remove unused linux/gpio.h
Date: Wed,  8 May 2024 14:43:21 +0300
Message-ID: <20240508114321.964374-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/omap-usb-host.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 949feb03d4f8..6de7ba752345 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -13,7 +13,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
-#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/usb-omap.h>
 #include <linux/pm_runtime.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


