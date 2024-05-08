Return-Path: <linux-kernel+bounces-173465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81908C00B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F313B2586F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B840A126F0A;
	Wed,  8 May 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELneRCgx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3EB86AF4
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181151; cv=none; b=ljMKIpgfktTEAjnEMs8ZmMK4ilf2vlyfsTERoCUyTCmg77MuSN/9mZUtX9CmE+NN+mjsZgdI0MqHIKpcxW1QI6pEbH4rtNSNMNpFEiwenElD4GcPe6Iu2JSBKP2PQUK1/4wnTifT+A7xNS/jUmzalUsjoDqVJSPNi335R+7Whnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181151; c=relaxed/simple;
	bh=NeKIszsGqh9jwuCffltG5mcAS23lZDfRVcT3V/NAucg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+0+AvMrnz2dgeiCt3CffL/Ku/Vm8azzjegoulZbiobcB/Eil2YYHmSa7hWWNpapmKrYP9pgnG4nxjW63ABCr04wullbqMsDt/fgqcPEl1lUuSjeRipHmAWp6De0Koiu/DQ7tLuq6ItyGLQUojCBWegH0rHOeKNgpNgAEzVS7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELneRCgx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715181149; x=1746717149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NeKIszsGqh9jwuCffltG5mcAS23lZDfRVcT3V/NAucg=;
  b=ELneRCgxyVpq/P+x1U7ZPRZW0dYgF+/F3KQMjE2/9pqKQezRZcGoeAzm
   V69e9IUc3SSQn5vd+cyzYEFKjtC6Vfz+o2RyIwvNzleTjKZFc1nNoIOLo
   HpIqB4AedsYT6Ds+CnDT/87EsFgGZlwLSvqPiKDvT7j88kikCTY9QxWIl
   vyGPp5zI4mLBwJUUx26YjBXl9hJeu2W9LNEtMWYXEtlVfC/HS0QoUbQCV
   jbh32Cc7LlU9zZmv5qOXVOiJPIvybOLDfXOogKuvjzP5S50p5D0g7TTik
   0HyOIaIp6QLVGQfGzzegg1uW2OvTgVHbPoZmf9WICzSwiNryt1MrjGu+r
   Q==;
X-CSE-ConnectionGUID: 1aI6JsJrSYu9sNh+fis4qA==
X-CSE-MsgGUID: UASOLpqERBqMrwOtPMJD2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="13995756"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="13995756"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:12:29 -0700
X-CSE-ConnectionGUID: slK9hIdPTcSp/pfKo+282w==
X-CSE-MsgGUID: lEg6CzfaRZydWglcXvrh8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33442219"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 08 May 2024 08:12:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4F32F11F; Wed, 08 May 2024 18:12:26 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v1 1/1] mtd: physmap: Use *-y instead of *-objs in Makefile
Date: Wed,  8 May 2024 18:11:53 +0300
Message-ID: <20240508151222.1443491-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*-objs suffix is reserved rather for (user-space) host programs while
usually *-y suffix is used for kernel drivers (although *-objs works
for that purpose for now).

Let's correct the old usages of *-objs in Makefiles.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Note, the original approach is weirdest from the existing.
Only a few drivers use this (-objs-y) one most likely by mistake.

 drivers/mtd/maps/Makefile | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index a9083c888e3b..019f1e92cc41 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -17,13 +17,12 @@ obj-$(CONFIG_MTD_ICHXROM)	+= ichxrom.o
 obj-$(CONFIG_MTD_CK804XROM)	+= ck804xrom.o
 obj-$(CONFIG_MTD_TSUNAMI)	+= tsunami_flash.o
 obj-$(CONFIG_MTD_PXA2XX)	+= pxa2xx-flash.o
-physmap-objs-y			+= physmap-core.o
-physmap-objs-$(CONFIG_MTD_PHYSMAP_BT1_ROM) += physmap-bt1-rom.o
-physmap-objs-$(CONFIG_MTD_PHYSMAP_VERSATILE) += physmap-versatile.o
-physmap-objs-$(CONFIG_MTD_PHYSMAP_GEMINI) += physmap-gemini.o
-physmap-objs-$(CONFIG_MTD_PHYSMAP_IXP4XX) += physmap-ixp4xx.o
-physmap-objs			:= $(physmap-objs-y)
 obj-$(CONFIG_MTD_PHYSMAP)	+= physmap.o
+physmap-y			:= physmap-core.o
+physmap-$(CONFIG_MTD_PHYSMAP_BT1_ROM) += physmap-bt1-rom.o
+physmap-$(CONFIG_MTD_PHYSMAP_VERSATILE) += physmap-versatile.o
+physmap-$(CONFIG_MTD_PHYSMAP_GEMINI) += physmap-gemini.o
+physmap-$(CONFIG_MTD_PHYSMAP_IXP4XX) += physmap-ixp4xx.o
 obj-$(CONFIG_MTD_PISMO)		+= pismo.o
 obj-$(CONFIG_MTD_PCMCIA)	+= pcmciamtd.o
 obj-$(CONFIG_MTD_SA1100)	+= sa1100-flash.o
-- 
2.43.0.rc1.1336.g36b5255a03ac


