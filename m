Return-Path: <linux-kernel+bounces-204725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FA88FF31C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0645B2BCE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D41991AD;
	Thu,  6 Jun 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNIkGz+4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB00198E70
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692446; cv=none; b=PHYT/11A8cNp3IAQYToEbsG/V4xbziksf1z3ej1/UKWuy2Ka+ejhb3HxQ/yslweuusNo0QAgFC/RDACjdxHrcHW0E/oz4lX1mf+JS4/37KQZlJblxNbSXW69aUQ3Zee8EAqAiz1ze473v9s8fxZiD5yz2WnQAdo7I6CzGVWG3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692446; c=relaxed/simple;
	bh=T6gLK4Xhn6yVmKQMI4ularKMV+lLmcOSTs0tDmhhchQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+YogUPlVPaiwVXGMW2J4hoGbgMmMusDXuTbr7gLkcAD1nP/3uMVvVlcyGMjxo8nzmTP8eTYP9YnmzZaWlp2buPkJRKxsH0NpiVT6psdv/1weFUYTvldBZ/CJdh7VEI8GZQEAi3Gv4RH1yaZUkJ4hc42KP+HPEkb5tWYHcVYWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNIkGz+4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717692445; x=1749228445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6gLK4Xhn6yVmKQMI4ularKMV+lLmcOSTs0tDmhhchQ=;
  b=UNIkGz+4gUcEfTLqMC70xLllwPhZewW/AWrDVfbhCeyVsGcVKllgs04T
   ExFgptU3kmaec94EXELQl25cFko+jZjykINQBPIWyFtDa0KYEYeyCQWQL
   5FInGefVr0U/InV9tdKLB2LQau16rf8+56W5zdqWhmvZAr/VK+wkrcQ+g
   eHRqmeLR0GY+Q2g1O833hc/luIKvOpeAgZWQoXlYZXr3ijUCsLI6twB/U
   NMRHxktcqQhe1Q+NvyFuEeNG74HE2CmhBQaGaQFiCTwYOFlxHQmsM/ckk
   CiwP2U9b7ClJRngqvfM25hOko2wDVX2UUA6ZXGzGVUjNSPuPN8+hVKziQ
   g==;
X-CSE-ConnectionGUID: PEe7vukoSM6CSw0+R7CyCw==
X-CSE-MsgGUID: xxJZHO0gQnKu6nCWuEbgpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14531942"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14531942"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:47:21 -0700
X-CSE-ConnectionGUID: kPBrPhZJQBq/JOJdCyogdA==
X-CSE-MsgGUID: c1BP5ct6QlSic9YG4VK5/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38475879"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 06 Jun 2024 09:47:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DBCC52CF; Thu, 06 Jun 2024 19:47:18 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 4/4] regmap: maple: Switch to use kmemdup_array()
Date: Thu,  6 Jun 2024 19:46:25 +0300
Message-ID: <20240606164717.3031107-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240606164717.3031107-1-andriy.shevchenko@linux.intel.com>
References: <20240606164717.3031107-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regcache-maple.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index e42433404854..f0df2da6d522 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -132,9 +132,9 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 			lower_index = mas.index;
 			lower_last = min -1;
 
-			lower = kmemdup(entry, ((min - mas.index) *
-						sizeof(unsigned long)),
-					map->alloc_flags);
+			lower = kmemdup_array(entry,
+					      min - mas.index, sizeof(*lower),
+					      map->alloc_flags);
 			if (!lower) {
 				ret = -ENOMEM;
 				goto out_unlocked;
@@ -145,10 +145,9 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 			upper_index = max + 1;
 			upper_last = mas.last;
 
-			upper = kmemdup(&entry[max - mas.index + 1],
-					((mas.last - max) *
-					 sizeof(unsigned long)),
-					map->alloc_flags);
+			upper = kmemdup_array(&entry[max - mas.index + 1],
+					      mas.last - max, sizeof(*upper),
+					      map->alloc_flags);
 			if (!upper) {
 				ret = -ENOMEM;
 				goto out_unlocked;
-- 
2.43.0.rc1.1336.g36b5255a03ac


