Return-Path: <linux-kernel+bounces-295485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1A959BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79E6B22930
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD29188A33;
	Wed, 21 Aug 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ve4IpxUv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E444B5C1;
	Wed, 21 Aug 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242960; cv=none; b=KFJ1AKyNRdc91dL5S2uBvkkSRKF18VPJ/jKqPVEh6F2qY11HCje/8EyF48og/VEolbDb2QSz+l+lUaZulkycl9FXOCsOehFeu5HgnG78YVam0GsTdJwWRK/pfSRxvBRRuKKeAmTPsFBLdCYQcxybvCLaEelsqG3N9LgRTqlAp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242960; c=relaxed/simple;
	bh=FlOLuxQtdd89SSARaX34UujQADldUtksPmR1X5kA4no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdWr/D2QtYMOmyHsCL3OvOIGgOefHAMiOUlq5LVusCPCIYEe842MFKnO1RcTNCZ7R/i5Aju3Dp17TlUr73Ri0Lb1YA/yLMV6Mlia5+XXSnTc4kCxnLKditZqOFeRmqOA/OKd3JCFv0Vgz7/E0QtCMH30CfW0LbfDhD2UUhTOe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ve4IpxUv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724242959; x=1755778959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FlOLuxQtdd89SSARaX34UujQADldUtksPmR1X5kA4no=;
  b=Ve4IpxUvhNd0I0EMNYbxLOOCfez1In/3gj2TYE7Hj0gZlED04kAWWuTf
   nt65yUfnWP9Wm/wgzTDwX3ITJfss2VsmgaSQotsj17dVt7bHMOW/e0Iaa
   olL6UQ70I0B5JsLZQaqpqqYKtsSj2BPIHYVGyUAJ78fQ3CYR74MRrIA8C
   7qdEy+Ssb4rlvgXnVGsPnqR5e33+u3/vd5Vo9/6FbDoHspiXIFWHYbOL+
   9jgx9y10Cm7IIEY5iJBUvNjJ+c2DlbqAEeRPtg8zUOKslk7g7WywDGOIH
   1/bbqh7VkjdpA728ZldbjWivi+95PVBQ1ZBOGWs6EqEtJC2/U1lL3HBxt
   w==;
X-CSE-ConnectionGUID: X/nGXyuWR9SRkKqGE+eNMQ==
X-CSE-MsgGUID: uVvMD7csRjeeMeKs7HV81A==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="45123254"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="45123254"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:22:39 -0700
X-CSE-ConnectionGUID: ScnMfRBjRk2GW3B1rcHSsg==
X-CSE-MsgGUID: ygNQGqK9Qs2qml09G73shA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61057198"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 21 Aug 2024 05:22:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2640B49F; Wed, 21 Aug 2024 15:22:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v1 4/4] platform/x86: int3472: Use str_high_low()
Date: Wed, 21 Aug 2024 15:20:43 +0300
Message-ID: <20240821122233.3761645-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com>
References: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use str_high_low() rather than open coding.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 96a9673a0165..b5f6f71bb1dd 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
+#include <linux/string_choices.h>
 #include <linux/uuid.h>
 
 #include "common.h"
@@ -230,7 +231,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 
 	dev_dbg(int3472->dev, "%s %s pin %d active-%s\n", func,
 		agpio->resource_source.string_ptr, agpio->pin_table[0],
-		(polarity == GPIO_ACTIVE_HIGH) ? "high" : "low");
+		str_high_low(polarity == GPIO_ACTIVE_HIGH));
 
 	switch (type) {
 	case INT3472_GPIO_TYPE_RESET:
-- 
2.43.0.rc1.1336.g36b5255a03ac


