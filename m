Return-Path: <linux-kernel+bounces-390355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EEA9B78CD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C404B2706A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE581993AE;
	Thu, 31 Oct 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoIH9bPz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B4198E83;
	Thu, 31 Oct 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371103; cv=none; b=FaYdUbe11/umFadq0SlQG6blMdMEO1jxzuvwvphVPmoEyxzuhb+6mE2rnxRsBN+kpMQ3Q740X6aUT7BhS5zwu53PV3DDj8OfkVaLqZeQ1yOW+xvuLFtP7sp8LqBYmkTvT6cEDli94IcAW+2ofXquR5I8e2OLLjWUdY5HwZbRA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371103; c=relaxed/simple;
	bh=kP1jrl42ItV4kBif4xciDH0D5HyjEFhdlEhVXDJmBgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9PretVhbsq6cz59tiM8sINvmKFBOodTSOrSneALx6WwPNOhUBicW8DuGQz9rDd1/0TZNQz2eKc90EwYO39u6TV/3e6evVPDZ0inT8RgNokbdsYVa/nV74ubc/p0OXDErPG/tesDMq0/3xrKBU4vD9cRA2W8dM8QPHLrgqQ0Tc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoIH9bPz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730371102; x=1761907102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kP1jrl42ItV4kBif4xciDH0D5HyjEFhdlEhVXDJmBgg=;
  b=JoIH9bPztweCeHb5fIVgOq7jvSoNOvIJ3yJvl/QjLZNjUutTf+/zlnNq
   9Kk11dDWT+RN0DxCa8mM74o11W0159SCc9cwE3UJ2Aq2UQtwghAw2hHdx
   d/mzs8HEg7ry95muxb99FgrZQuHn4YzNN3yxSkys5T2I6KUzMf6x+7AqO
   db6lXjrQVWuqEPP6dK7wg5OzjJzzN64ImcpMjhusNZlRleRQg11MOMzqo
   vOvK6nZB73kxyHUKSJuoFKaKB8e6j9Yvvt1UvjXFUBRUOy2x8N4pnWPrh
   wHhjGk8+e46WxFb0UhNe/lYVQeUYx8x2A0NQpx2ryXZeIPxRmZ782S7hR
   w==;
X-CSE-ConnectionGUID: +E/GmNf1QF208D/GWW9dbQ==
X-CSE-MsgGUID: vNg1oeOKTrGK7dp+OyVutA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30294243"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30294243"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:38:21 -0700
X-CSE-ConnectionGUID: +VNJuCM9SfaWLB3ttEdn+A==
X-CSE-MsgGUID: uB7/kGqIRpCItx1Ve7h5kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="83394745"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 31 Oct 2024 03:38:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 107B017D; Thu, 31 Oct 2024 12:38:18 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] USB: bcma: Remove unused of_gpio.h
Date: Thu, 31 Oct 2024 12:38:18 +0200
Message-ID: <20241031103818.2451816-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove. The drivers in question
don't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/bcma-hcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/bcma-hcd.c b/drivers/usb/host/bcma-hcd.c
index 7558cc4d90cc..519386255886 100644
--- a/drivers/usb/host/bcma-hcd.c
+++ b/drivers/usb/host/bcma-hcd.c
@@ -25,7 +25,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


