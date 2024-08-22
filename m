Return-Path: <linux-kernel+bounces-297308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8F95B5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95E7B23FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB14A1C9EBD;
	Thu, 22 Aug 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCVFNsFB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47191CBEA9;
	Thu, 22 Aug 2024 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332060; cv=none; b=aVi2rwIlHjdj0X++FJAUGgI2TNRy7rnc2sXSKoM+DbOVytkCJhrMpXZvMjQdY/261U6sUxrlPp/CL2vXk4NkR1MX/PSc/8tcIh7FMU23oLaGxpIQ2hiKTaQyQxApabA2l8e7WQVDB2T2oSUD8KQAjb6AHo5DpOxAFjovgOSCpcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332060; c=relaxed/simple;
	bh=6yzkxgeeNpy0+7GerH1TmbwM9kjda6sRhMx93hTsO3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecyuTmCa/kKjo21kKflFbH2+H4uR0s3YKMLaGebFAtEAUWpLI8oLMKTWsdbmd9tcnKyeS2O05jsbjxRoSLKHwacjJMRX7hLBCaA+3CM4X1XzLn+bh2Ax8/AAdscO6CEHcSdVexYq1efv3cWUkn6AHVAxA6Ie8cWAwUAZQxb3JDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCVFNsFB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724332058; x=1755868058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yzkxgeeNpy0+7GerH1TmbwM9kjda6sRhMx93hTsO3k=;
  b=DCVFNsFBlwzqMX+/jlAtdoClKE0dawN0Vq9JunE5sVdQDe2Ucl1dfJ6o
   sKQbAgr6SFrTUl9Dkecuo5WZxH7GmkfnyXhcbZsmuXUafLG3GOkn+ewCv
   ewQpOavmP9wU87AYby3e/3EAy7OARj6sraS6YOLP7Y2AZ1orTffcslRwK
   OC/WF9L0+uEMwWdrZNRmx1FKT0UxHk+XpP3cAE+eUX9CyTKxx1rUgCtCT
   eDtVYc8/bV9TDJSMlwhJKzw/j+Qs4GBqTJVKvzTQ4RHC7dALSWEgD7OZp
   FaxUq5Sld6WU+lOAKJvL5SRyEtbYSNOMwDl1YKByNc1XCGMUx+nqW7EjY
   w==;
X-CSE-ConnectionGUID: a6tOBIvaSaqvTALI3azZsg==
X-CSE-MsgGUID: 9uVBiN6YQU6vFTQ9aA5STg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26538887"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="26538887"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:07:38 -0700
X-CSE-ConnectionGUID: GhF9q9DCRZu6KIHJfg9RaQ==
X-CSE-MsgGUID: bW4xKgsjQJKwf+eqvTGVTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61146785"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 22 Aug 2024 06:07:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AAF0C6CC; Thu, 22 Aug 2024 16:07:23 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v2 4/4] platform/x86: int3472: Use str_high_low()
Date: Thu, 22 Aug 2024 16:05:41 +0300
Message-ID: <20240822130722.1261891-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use str_high_low() rather than open coding.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index a360901d03f0..0559295dfb27 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
+#include <linux/string_choices.h>
 #include <linux/uuid.h>
 
 #include "common.h"
@@ -240,7 +241,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 
 	dev_dbg(int3472->dev, "%s %s pin %d active-%s\n", func,
 		agpio->resource_source.string_ptr, agpio->pin_table[0],
-		(polarity == GPIO_ACTIVE_HIGH) ? "high" : "low");
+		str_high_low(polarity == GPIO_ACTIVE_HIGH));
 
 	switch (type) {
 	case INT3472_GPIO_TYPE_RESET:
-- 
2.43.0.rc1.1336.g36b5255a03ac


