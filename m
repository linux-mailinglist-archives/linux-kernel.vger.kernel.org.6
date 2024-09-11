Return-Path: <linux-kernel+bounces-325572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F93A975B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527E21C22013
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1571BA883;
	Wed, 11 Sep 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZuNbBg7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2891BA870;
	Wed, 11 Sep 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085950; cv=none; b=si9Ewy0nl4SoARMFhnsBqEtBxxAr21r5igxbPVpTpa+aagdgUQrzKcNn62KyYFbxce1lOgQ5G9FOxkCDsN7Vt0KRicQ2GXMOb2pFE8dCEZCzlFmidieXf/a8pTsjC9BdEe86ktG8p9i0+8LP9Y4vfo4LzINK4ES0eaEqzEZcqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085950; c=relaxed/simple;
	bh=l8yHxAlMYNR9kG0WkxQc19S1j5Kp7mzF6oAmQxgelvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mm0yfjldMvVmId1t3HFk4uvl6cJEAunxoPKjyNOUH4jVgZ1TB1AY64W5SNuyvzJASI4FLO1FZIRn9GJC3RbqiAPUr8ouEHxj3xgINKEWghhrt4gEmFSzo1DJGBfRFOti6LbAGB33ThPWxXqF3LQg02IPZADAHEbSpjUZd7hkaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZuNbBg7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726085948; x=1757621948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l8yHxAlMYNR9kG0WkxQc19S1j5Kp7mzF6oAmQxgelvU=;
  b=DZuNbBg7pGBzLYuU/qaDwCLTqVt9whReuwEIBViqus8OZx3JnFreEpvj
   ILImMkdL1pBM65Qdtcy9gfRT9gfoNrwNlXqvbQXr6CIliCV0C65MFoEpU
   SaAs9UMrBV/V+2ogawqAM+OPWVPYIF4Mb65Hj65JXAUUsVia/psp9Ob6m
   A3n6i13Kue8nqt+DJSqcnAF4/k34VCILAddJUqULGD0BtK8ITg5V3RqRZ
   GoQZsZjvpnoAYC7PrRWZxB1rwnHUIOvYtrrntzLMaNjmPNZYSNrJBWoP6
   3+T9AplFZ7aQZKjmwTCHmAAplD3gJZGWRF1Zx3/OmU8lXwU1YZ4HwVmWU
   w==;
X-CSE-ConnectionGUID: o7UIi0LOQeecbIwA7RuZSw==
X-CSE-MsgGUID: TZTXMGF1SRCRRI18niq63g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28796156"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="28796156"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 13:19:07 -0700
X-CSE-ConnectionGUID: 3Ok5t5IRTz6Tt+Ae4VGs1g==
X-CSE-MsgGUID: cNMCzwM9Q/O9Bn+pjYOIfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="71860339"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 11 Sep 2024 13:19:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 86D4A170; Wed, 11 Sep 2024 23:19:04 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] hwmon: (sch5636) Print unknown ID in error string via %*pE
Date: Wed, 11 Sep 2024 23:19:03 +0300
Message-ID: <20240911201903.2886874-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of custom approach this allows to print escaped strings
via %*pE extension. With this the unknown ID will be printed
as a string. Nonetheless, leave hex values to be printed as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/sch5636.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 6e6d54158474..a4b05ebb0546 100644
--- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -416,8 +416,7 @@ static int sch5636_probe(struct platform_device *pdev)
 	id[i] = '\0';
 
 	if (strcmp(id, "THS")) {
-		pr_err("Unknown Fujitsu id: %02x%02x%02x\n",
-		       id[0], id[1], id[2]);
+		pr_err("Unknown Fujitsu id: %3pE (%3ph)\n", id, id);
 		err = -ENODEV;
 		goto error;
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac


