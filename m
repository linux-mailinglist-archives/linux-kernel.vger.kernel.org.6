Return-Path: <linux-kernel+bounces-533068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F092A4555D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4356A7A1CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB57268FCD;
	Wed, 26 Feb 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWDqeb5L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680E2686BD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550567; cv=none; b=Yd3IkiqOdgc3eoteJENAW+ixYWGWrF36Y8/PnSoFWLSZGw7p1bWK/jrXwnJmozIiZH6pTPtQxSykgoKMJaLTilcd4jN/map0YFhMPxdG8jWJ55fj6xyaHleMX9mHIM3oqDsvmrSS2WFqq5k1xBHnH4BxJ2r5a2EMQE5N0cdsFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550567; c=relaxed/simple;
	bh=rBMW5kD5Vi0TzRy+2B+pr84PvdtBiM7mxCSVZSoqN9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqiB7yUjIyJcEBo+ppw2pFz6tH7JhnmYffR8ESLg1iAumLHuqL6qncIzSPUzzX58FLckWTGtqubdyJXsssQIGTkzLOafTfpisiI6mdx9CDWJIMCT6Ao5J7PvCEA6Nn1H8XkGvRyxj67HPfIfZzQVRynBO41+1HWRVR1+ZHlztVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWDqeb5L; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740550566; x=1772086566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rBMW5kD5Vi0TzRy+2B+pr84PvdtBiM7mxCSVZSoqN9w=;
  b=eWDqeb5L8mUGWvqypX+UXUhRG+7Lf+GSaHuKNKSE/l0ttU7WlHVL2khz
   E3ecGxdXmHBrWD7iw04uNEJzmmS+tbETQBTTZJnVE1C6tN1+EKiilinCt
   0aLsaGwm/4b1R+2snNwqQ0T4C9vau6FUHyQPxozyvRHO+dlZGeeOJTNcB
   ANgvOdbNzVj7TBs2YQaAnQy3V1arR8kO4qeVzGZ+mqUSqCJhxk26rf9n8
   +xJF112lyK6OuRaCL4pE0Leic+4b04agxEVoIfkbGIhH/ZrI5RGUseGYJ
   txAnw1TEuekcQCZN8gTCJpzPkDtC7BjEi66pZrLBQc5FQqNvWpshaSQmu
   Q==;
X-CSE-ConnectionGUID: FZkI34wVSsewo94hUIiL7g==
X-CSE-MsgGUID: rlp4dEa1RzmcruUWnlC0FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41636482"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41636482"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:16:06 -0800
X-CSE-ConnectionGUID: 0fTVo6A5R3eKgKtV/sYGMg==
X-CSE-MsgGUID: cMG/q3nqRFSGhXvT/rjdmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="147434831"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa002.jf.intel.com with ESMTP; 25 Feb 2025 22:16:03 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: lee@kernel.org,
	giometti@enneenne.com,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	raymond.tan@intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 3/4] pps: generators: tio: Introduce Intel Elkhart Lake PSE TIO
Date: Wed, 26 Feb 2025 11:45:26 +0530
Message-Id: <20250226061527.3031250-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226061527.3031250-1-raag.jadav@intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for Intel Elkhart Lake PSE TIO controller.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pps/generators/pps_gen_tio.c | 17 ++++++++++++++++-
 drivers/pps/generators/pps_gen_tio.h |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
index 89b08301d21e..8339d8c8f8bb 100644
--- a/drivers/pps/generators/pps_gen_tio.c
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -22,6 +22,14 @@
 
 #include "pps_gen_tio.h"
 
+static const struct pps_tio_data ehl_pse_data = {
+	.regs = {
+		.ctl = TIOCTL_PSE,
+		.compv = TIOCOMPV_PSE,
+		.ec = TIOEC_PSE,
+	},
+};
+
 static const struct pps_tio_data pmc_data = {
 	.regs = {
 		.ctl = TIOCTL_PMC,
@@ -240,9 +248,16 @@ static const struct acpi_device_id intel_pmc_tio_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, intel_pmc_tio_acpi_match);
 
+static const struct platform_device_id pps_gen_tio_ids[] = {
+	{ "pps-gen-tio", (kernel_ulong_t)&ehl_pse_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, pps_gen_tio_ids);
+
 static struct platform_driver pps_gen_tio_driver = {
 	.probe          = pps_gen_tio_probe,
 	.remove         = pps_gen_tio_remove,
+	.id_table	= pps_gen_tio_ids,
 	.driver         = {
 		.name                   = "intel-pps-gen-tio",
 		.acpi_match_table       = intel_pmc_tio_acpi_match,
@@ -255,5 +270,5 @@ MODULE_AUTHOR("Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>");
 MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
 MODULE_AUTHOR("Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>");
 MODULE_AUTHOR("Subramanian Mohan <subramanian.mohan@intel.com>");
-MODULE_DESCRIPTION("Intel PMC Time-Aware IO Generator Driver");
+MODULE_DESCRIPTION("Intel Time-Aware IO Generator Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/pps/generators/pps_gen_tio.h b/drivers/pps/generators/pps_gen_tio.h
index e652f976e455..bbf5b994e7ff 100644
--- a/drivers/pps/generators/pps_gen_tio.h
+++ b/drivers/pps/generators/pps_gen_tio.h
@@ -14,6 +14,11 @@
 #include <linux/pps_gen_kernel.h>
 #include <linux/spinlock_types.h>
 
+/* EHL PSE Registers */
+#define TIOCTL_PSE			0x00
+#define TIOCOMPV_PSE			0x04
+#define TIOEC_PSE			0x24
+
 /* PMC Registers */
 #define TIOCTL_PMC			0x00
 #define TIOCOMPV_PMC			0x10
-- 
2.34.1


