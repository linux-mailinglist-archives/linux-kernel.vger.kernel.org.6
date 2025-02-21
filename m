Return-Path: <linux-kernel+bounces-525183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A6BA3EC1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363491888E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD561FBE8E;
	Fri, 21 Feb 2025 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ev9OEKh7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF291DF968
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740114508; cv=none; b=TVDyoxPb4QIir1IGDUt5b4OcAibkwCjrw0Lx1qOH3deEP6X674ifwN6phMXVsUMLaF61HM6v0HCF5uMs1thLEeV45oNcEifUd2yUms19pBla/EWRGU5RABD4Gj5G6Qy8O9JEYNtET4bEKyLKoquOe6ITjpQKQ56K0H271wvJxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740114508; c=relaxed/simple;
	bh=etDWG/V65kok/FyIGXhRuyZcDtjdD116XRDUX+qd1YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mok3iHeQHRpNQfyJGN/Qs5bfPKxEH0hFWt5AFNJqOzykhDEGDuHjo+TJsyZOyC+PE3qnYiOTwWO7UuYAAC3TnERrp3Ke7BECpPtYpztZlLlen/I5GXiHmsMTdAuygKh32/qqnDTmwdXVtie/OF46/mKEa6t4xud3zoHjmxlihYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ev9OEKh7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740114507; x=1771650507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=etDWG/V65kok/FyIGXhRuyZcDtjdD116XRDUX+qd1YY=;
  b=ev9OEKh7BrfZ6MVnuxiC4z4o3jJldavlRcYuvdLG/3OmOcT1n6mGK8GN
   /+cFR/LqNPfWGTQUlxoWvmtXdkb8WpAh2huR1YneSXh068VHDJDRNlshg
   nwvS/0RGZ7TRVIos1FzX5ELqSLuRWpFNxVIVclIU1U42DO5yFnxgpjR86
   4AntaGY+5R09xiEBYzICNGBUA7Xjyd/SHYXxZMleSB5kSqdcfY8YDgam2
   b6v6Or0WQ6cz04Ne8hhVgBPGwdkyBx5YPBBxHYQsqffk7jkZlgkvOzKp0
   FQRh+TPz4EXowIcIIFGdZMLDSCrpdp3wX9J8nX3GileYeY1jWoJB0uxFk
   g==;
X-CSE-ConnectionGUID: 33QOxNa9Rw6TLjtPmHmixQ==
X-CSE-MsgGUID: jB3bE5XRSceG19r85V5nNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="28518721"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="28518721"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 21:08:27 -0800
X-CSE-ConnectionGUID: Wg8Byb+5Tm+FjcUkCWp+bw==
X-CSE-MsgGUID: pCEOxuG7QQyLg+ZtG6i1Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="115459300"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa008.fm.intel.com with ESMTP; 20 Feb 2025 21:08:24 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/2] io.h: drop unused headers
Date: Fri, 21 Feb 2025 10:38:03 +0530
Message-Id: <20250221050804.2764553-2-raag.jadav@intel.com>
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

Drop unused headers and type declaration from io.h.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
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


