Return-Path: <linux-kernel+bounces-185096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A08CB071
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9407F1F23025
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B352012FF92;
	Tue, 21 May 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="en44kIKN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7DD12FF91
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301691; cv=none; b=tZKIq6/zYEbLfmjA+Dip0oJqE6mhnYUO8gGOQtKO3pTUnXfbxKyTFdV6RYvLYa0y6t7GXdBXj4kiBMypZwxnrrD96acQWmktZM1TARyYjCNV3ch1DtYkhxZzD3GHXhxDE/Ews77RbR6feKoZ17VQoUdK1RBT47rqvoDGqnyGd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301691; c=relaxed/simple;
	bh=EdNZ4h2iIcnlVFQVn+LHBQcKm+5zQwjrV9IduBirb9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ql/7cZwPnKNA82RksdIs829uv39zeiH37Q+tvf647y9MDX8odmj9ieBhs33eDxnoc+3Z6qYqzQ0ZvhEUo6hAm5nx7guLVn9TOKgCWjldm4SCDAi156HC1ngxwjSItYLDpvBgyfhQp0T1ChxpojZ+OuUcFMEsnOlkdA3+FokopFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=en44kIKN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716301689; x=1747837689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EdNZ4h2iIcnlVFQVn+LHBQcKm+5zQwjrV9IduBirb9w=;
  b=en44kIKN4t3DP7luVmWhtCO/eH8N8XHCEbzWXoGrxuNpg2R0xq9D1hlk
   POoEZWp6s1GFtUz7iHJjiH1FkdckHo4Sm6hur/nwuMGDKxjPbHNcUEO0b
   BYDKHFUWVOEDX1eVEJ+uZO3DsoWMKo0Bq1fCacfxaBiYWMSCQSGSyW2h+
   Fi5/hY1Zq0ZOLnqM5PM48X+KZqHmveA5g+VRyQrBo8oTwAqNljldAMN+V
   CRgjQvImLiMwG+Kef7EqDEcFbxNu1zgl2XfzfHYNEEXsV8ondy02JHsHJ
   Bxd/J4xBylndAd4wSkqSVleKcijELJjncwce30/w16TIKlroeDSJw0dOG
   g==;
X-CSE-ConnectionGUID: 7rEhHns/TziM6Qs8vmXSYA==
X-CSE-MsgGUID: 0VV7GZmCReaxXq7pTTaxrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12612712"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12612712"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 07:28:08 -0700
X-CSE-ConnectionGUID: DtrbXJVnTuWf04rbl2oPkA==
X-CSE-MsgGUID: dRuFqotDT+qYZ9Q27l6qvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="63774457"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 21 May 2024 07:28:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E9D2317F; Tue, 21 May 2024 17:28:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] MAINTAINERS: Add Intel MID section
Date: Tue, 21 May 2024 17:27:58 +0300
Message-ID: <20240521142758.2298717-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The different drivers are spread over the kernel. I would like
to be informed about the changes in them, which are done not by
me.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 29f43c8bfc16..3e80895074a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11082,6 +11082,21 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
 F:	drivers/fpga/intel-m10-bmc-sec-update.c
 
+INTEL MID (Mobile Internet Device) PLATFORM
+M:	Andy Shevchenko <andy@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	arch/x86/include/asm/intel-mid.h
+F:	arch/x86/pci/intel_mid_pci.c
+F:	arch/x86/platform/intel-mid/
+F:	drivers/extcon/extcon-intel-mrfld.c
+F:	drivers/iio/adc/intel_mrfld_adc.c
+F:	drivers/mfd/intel_soc_pmic_mrfld.c
+F:	drivers/platform/x86/intel/mrfld_pwrbtn.c
+F:	drivers/watchdog/intel-mid_wdt.c
+F:	include/linux/mfd/intel_soc_pmic_mrfld.h
+F:	include/linux/platform_data/intel-mid_wdt.h
+
 INTEL P-Unit IPC DRIVER
 M:	Zha Qipeng <qipeng.zha@intel.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.43.0.rc1.1336.g36b5255a03ac


