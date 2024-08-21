Return-Path: <linux-kernel+bounces-295484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19F959BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6539DB22759
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF98188A34;
	Wed, 21 Aug 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WT4H/jXv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1101D12E4;
	Wed, 21 Aug 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242960; cv=none; b=K1r7wSwahGQGbSFaJu/4qKgpoOwSuhHraDh6+dtdtLXB2RXcTETDD+/LSD+XLlF/3n/wq4FHa9E0sBBEK0RmeFrAp1XCDlcWsSL2UvCLpaS1HyoZNoUGNMvfj1TRcYMj5zgi5NidvJ30EhRTOSnsY5Z5BGYHEe/CJrS2Kk1xntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242960; c=relaxed/simple;
	bh=RBpH8hwL+8rZvJde/hlF1OhlTiKmsXGFm5qezkEgjHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sbs9aQg4Py3AWWEdJx7zkkRAsJ5k8t2nvLz7wA7jTVJtc7O50fosD2Ta3z34ewDNz8UNGFVjwRs22g0OAzOuBisj7jY4/gHQA4ITxV+hmML65yQp5z7daLdVHg4dWg7nEYnWGHCtvdR5s70+06NJPDw1AzOJKHfWet5EFfnUnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WT4H/jXv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724242959; x=1755778959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RBpH8hwL+8rZvJde/hlF1OhlTiKmsXGFm5qezkEgjHw=;
  b=WT4H/jXvmqOmWgvmhlAefCm6N3fD/N258pnuwSiC5GbGJrB+VNm4PadZ
   aOoHNjO8EbPgaPBnhmgfm3n58bfq5cMPzNhTUzcPzYaW2oKDuAaHHoXxh
   GNmtfA4mvgr4C+z6SYkgzQc1tjbUqQwAs6ogm+kamd2eVeM+4lrFdDSAC
   xX5u7PCD/p18cppFPkluNy2TNRID2dhrBN6g4QBG3c+dJK+5VGbarLmsU
   2XmY7dJc7N05eWhhPohS8IpHhEOtWRRrUoYVZ97mfSVAVnjglNVHmq6GV
   bNj3jiY/ANhefWotTdcfOkVjW15qrRh6Mjan1gmzBRleF+YEZTXjTo9Ym
   g==;
X-CSE-ConnectionGUID: b7EFh8naRNK5We/KCEjVCA==
X-CSE-MsgGUID: EQD2UQI9RuGjiewfo+xZ6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33166205"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33166205"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:22:39 -0700
X-CSE-ConnectionGUID: Y86rsnDdQVCt9yAjKXkYdw==
X-CSE-MsgGUID: yYvvj1xrS0Ce/nPohDk+Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66035955"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2024 05:22:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1783F719; Wed, 21 Aug 2024 15:22:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v1 3/4] platform/x86: int3472: Use GPIO_LOOKUP() macro
Date: Wed, 21 Aug 2024 15:20:42 +0300
Message-ID: <20240821122233.3761645-4-andriy.shevchenko@linux.intel.com>
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

Use GPIO_LOOKUP() macro which provides a compound literal
and can be used with dynamic data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index cd0743300d7f..96a9673a0165 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -69,11 +69,7 @@ static int skl_int3472_fill_gpiod_lookup(struct gpiod_lookup *table_entry,
 	if (!adev)
 		return -ENODEV;
 
-	table_entry->key = acpi_dev_name(adev);
-	table_entry->chip_hwnum = agpio->pin_table[0];
-	table_entry->con_id = func;
-	table_entry->idx = 0;
-	table_entry->flags = polarity;
+	*table_entry = GPIO_LOOKUP(acpi_dev_name(adev), agpio->pin_table[0], func, polarity);
 
 	return 0;
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


