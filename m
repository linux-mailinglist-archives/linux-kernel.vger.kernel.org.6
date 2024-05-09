Return-Path: <linux-kernel+bounces-175059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D28C19B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2466D1C22989
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847EB130A65;
	Thu,  9 May 2024 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVn9MbBs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490012D766;
	Thu,  9 May 2024 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295769; cv=none; b=lzf41l1y0+bVJIB7qliBP/CMvcyi55cTlOJIwEwsOi/i/Ro8dPX5BtIQF986rSOoOm8qJeIuxCgtjHgMkDg3r8rQ5HY76fM/lRGrvgOoptrlgwxQaJ1O10pRHCjrTtZiZT4tob79WWwe5hFBZVXD7qDkHqSJzwTPFfuPbdwaY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295769; c=relaxed/simple;
	bh=oNrUGgcCk1pvGWzqlqg4HGyJYpoKusDOo1+YDxj1Nig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny1tj6MZj0S+TwZryfkAwSOGpVonfcOQK/MfR2+Q9LZhkx/Vat2qBxX0OL4SMOdoc2c45GXvUHi7sRTmW95kKKJloeUZFbASDp988k61QfJHQMbyNAKK+ljvZbMbskDSUYNuHa1zBp/Rzp8VeMbkZBonUFrC7u5jmSV+az1sQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVn9MbBs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715295768; x=1746831768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oNrUGgcCk1pvGWzqlqg4HGyJYpoKusDOo1+YDxj1Nig=;
  b=XVn9MbBsk/jdogk02prsLxhgdjTaE/WmmIvpS5Ap+h7ADiikdJkWTUHK
   9fneZqf9oYBkWAYzf/9zcXauRcJXrgm23GUbPq+wTBwO5ZMTRohjrSidc
   9rTzHtjydq67uTLCWUqBtlo3bxOjvXpD2qNDpk/KUsQAF0r+S6W71rOwk
   AK0GQmLm7YRGfuquAcl2u0a+up05mbc+PSAjX7f0BBZALDsz4raiT0qR8
   6QLXhAfPueTh3Dhx5I18bJQDRFMAS99wUjNsWyvrlrAPqEFYzUbPtNUdE
   iEiZyWkhNamkVWQn7m2OdAfpopqYaf5voYsqGk4F1vqSRiQZESLXLWD+Y
   w==;
X-CSE-ConnectionGUID: 9+1LTUnIQSuD2fV6rx6Rkg==
X-CSE-MsgGUID: cJyeWIGERcS9oy2BIzFUiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11100509"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11100509"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 16:02:46 -0700
X-CSE-ConnectionGUID: LEwwS8lGTWG5x4DP1jj5rQ==
X-CSE-MsgGUID: 0/AfS9CWRO6tKs3tr5L0TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29790214"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa006.jf.intel.com with ESMTP; 09 May 2024 16:02:45 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] platform/x86: ISST: Use only TPMI interface when present
Date: Thu,  9 May 2024 16:02:36 -0700
Message-ID: <20240509230236.1494326-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509230236.1494326-1-srinivas.pandruvada@linux.intel.com>
References: <20240509230236.1494326-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the TPMI interface is present, use this interface instead of legacy.
On some systems legacy IO device is also present. Using both interfaces
together is confusing and may set the hardware in inconsistent state.

When TPMI interface is present, don't load legacy drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index f886f9369fad..6283af37e73b 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -775,6 +775,9 @@ int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
 	if (device_type >= ISST_IF_DEV_MAX)
 		return -EINVAL;
 
+	if (device_type < ISST_IF_DEV_TPMI && isst_hpm_support)
+		return -ENODEV;
+
 	mutex_lock(&punit_misc_dev_open_lock);
 	/* Device is already open, we don't want to add new callbacks */
 	if (misc_device_open) {
-- 
2.44.0


