Return-Path: <linux-kernel+bounces-325597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AAE975BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747E21C21CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A114E2D6;
	Wed, 11 Sep 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bP8akF4w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25F7E583
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087304; cv=none; b=SRchkFm6OI9tbD4BP4gaY+L8Z4idkmzYmMvfPjhfKMWTbfEb5xTa1K96YKZgulNHR7b2DUvdJgLWMuVN0WnonaPijxPhXwtiX4aJDeoeT0xJm8esNc+gDGYuh4yZZcoq1fV/pMnhMAPT/4/pPQHI3AhHUnp31pm3MY/tVKNQPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087304; c=relaxed/simple;
	bh=freNg6X75VgqxHI3Km0VGAccedxAeb/2ONtdg8xG5yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8KZ1EfK3qCM0GW9J4tx9gjgl6P33gTjVIs1oewqpJm6D9Qv6QXGGLeabuSIkA1zRfSNQF84rHPJQ1LXoqSH3UpIZl5JpePzZdFnFho85hOqLQThojmzY1bOcUmzawr8NRCHGuvGzrgtZHqkMEEOuXzT5BCIWAyiNG5kWaCh6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bP8akF4w; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726087303; x=1757623303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=freNg6X75VgqxHI3Km0VGAccedxAeb/2ONtdg8xG5yk=;
  b=bP8akF4w2WXE8rLOj3VJISRKnYuHmM0C88LNeySyjVW07F/0CoFyzLW1
   elQGvcaAawLDrGVlZagtPVe+0qLHnupmukyAheKBha0s1+nW39J3EiWGn
   Xvc/BNKfodCQXcaiBVd+4kU1t6UHH6hC13eUHk3uwnRmQ/ziQ2FveBkjq
   nlVjsovECdemhgalGy1nsLEOebbHt+yEBLA7mLYgSggX5vjskmkfXq1xX
   PJmfKcsO2rzi9t9aIoh1URp0jviRUe63517d/uZQFS1sdRCEyBc76p6jH
   Xnv5HcMy2sPYgKa0yYj5uU8KNaf1g0sbRWnfXXQJMAkFL1azpRQUxaH8P
   A==;
X-CSE-ConnectionGUID: +l9sg6sMR7uHUAPtW9b+Xg==
X-CSE-MsgGUID: hk9/2CgNQaOIxGMgQhIipQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="28798090"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="28798090"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 13:41:42 -0700
X-CSE-ConnectionGUID: /uNaH1bgQ0CODB78jzl6wA==
X-CSE-MsgGUID: aww58p/lSjW/4eaUkpPzkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="71864557"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 11 Sep 2024 13:41:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 19928170; Wed, 11 Sep 2024 23:41:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to print GUIDs
Date: Wed, 11 Sep 2024 23:41:36 +0300
Message-ID: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the custom approach with the %pUl printk() format specifier.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tee/amdtee/core.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index e487231d25dc..d3201eff1b74 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <linux/firmware.h>
+#include <linux/uuid.h>
 #include "amdtee_private.h"
 #include <linux/psp-tee.h>
 
@@ -172,21 +173,11 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
 {
 	const struct firmware *fw;
 	char fw_name[TA_PATH_MAX];
-	struct {
-		u32 lo;
-		u16 mid;
-		u16 hi_ver;
-		u8 seq_n[8];
-	} *uuid = ptr;
 	int n, rc = 0;
+	guid_t uuid;
 
-	n = snprintf(fw_name, TA_PATH_MAX,
-		     "%s/%08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.bin",
-		     TA_LOAD_PATH, uuid->lo, uuid->mid, uuid->hi_ver,
-		     uuid->seq_n[0], uuid->seq_n[1],
-		     uuid->seq_n[2], uuid->seq_n[3],
-		     uuid->seq_n[4], uuid->seq_n[5],
-		     uuid->seq_n[6], uuid->seq_n[7]);
+	import_guid(&uuid, ptr);
+	n = snprintf(fw_name, TA_PATH_MAX, "%s/%pUl.bin", TA_LOAD_PATH, &uuid);
 	if (n < 0 || n >= TA_PATH_MAX) {
 		pr_err("failed to get firmware name\n");
 		return -EINVAL;
-- 
2.43.0.rc1.1336.g36b5255a03ac


