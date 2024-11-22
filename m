Return-Path: <linux-kernel+bounces-418302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD039D601B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825001F215F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213B2D638;
	Fri, 22 Nov 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRnWpIql"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6529CE6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732284244; cv=none; b=I+UDcFnPXwk2RHMc67THt+7rKJob5U0bsTjFobWm15d0sj+cLr/xGuqJnFMMMfjOSUtAS1O94wPeNQT/jq8V7hsKNbcnoeD3vf87umJCT9gdkF3r2t/jNoF6y9F/bm2Cye627kKQILAyjlLNkb9cCo08PK5iA5hsErSqo/NECus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732284244; c=relaxed/simple;
	bh=qAetYgJlC7C1fkFsdDOyYm1EhvEvFdqrS4qUEfYoTsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EoPBIVolWBcgIRgaCFTkFOcAJimbOQ4ppECoxoI9clcx9Ho6Khofvg+Sy9iZZMc7cC7ht3A6MyA8nKP0X99BduergCZkjfOcQIwW3JPRn8W6n3ZC57bWRQ7Cg9XI3ZSas+3dk0bFYNDsyq2xsDjDCmsJceXino7uG4jkGJUtEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRnWpIql; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732284243; x=1763820243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qAetYgJlC7C1fkFsdDOyYm1EhvEvFdqrS4qUEfYoTsk=;
  b=JRnWpIqlb4aBMwqWds7MTCtGfhPVTn5QgiLH9ooHBKKI2evhtArcs7Wh
   sJSYLbiosT7KIsa656pjv+AT0qUgX7eI7s4RIoNvILAulgux5hRZlt90F
   vY4Mtg+eTFY2kaQxP1ielqzFUMbYU9jeHp6d/6ULfLB6m1uUfYFsWmIX0
   D8tIHN2ddjg+am6tWuw5waTkX+XZM2tF9SUDjmHsBx7oReLK5vBW8HvRb
   qsc/iyMRmkdq1odMWcq4Oj3g93hNmrWT24IXbPd2MfuaStaEeQFzA8aM3
   RZL4jzdE9F/MSbN0HjUnuXJBIg+wTrScHwMlyxO8IhJhmqr3v7pl4mjfs
   g==;
X-CSE-ConnectionGUID: u1DcBdTpR9ycFOoRgc5BJw==
X-CSE-MsgGUID: oiYjgKCORnuCOJYWMpTfPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32495836"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32495836"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 06:04:03 -0800
X-CSE-ConnectionGUID: hOgyQa6DSWSn0dhuzluusw==
X-CSE-MsgGUID: SUQdieGIQAOP4P5hbyiZFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="94668673"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 22 Nov 2024 06:04:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 80B42329; Fri, 22 Nov 2024 16:03:59 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] regmap: Synchronize cache for the page selector
Date: Fri, 22 Nov 2024 16:03:20 +0200
Message-ID: <20241122140357.1337686-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the selector register is represented in each page, its value
in accordance to the debugfs is stale because it gets synchronized
only after the real page switch happens. Synchronize cache for
the page selector.

Before (offset followed by hexdump, the first byte is selector):

    // Real registers
    18: 05 ff 00 00 ff 0f 00 00 f0 00 00 00
    ...
    // Virtual (per port)
    40: 05 ff 00 00 e0 e0 00 00 00 00 00 1f
    50: 00 ff 00 00 e0 e0 00 00 00 00 00 1f
    60: 01 ff 00 00 ff ff 00 00 00 00 00 00
    70: 02 ff 00 00 cf f3 00 00 00 00 00 0c
    80: 03 ff 00 00 00 00 00 00 00 00 00 ff
    90: 04 ff 00 00 ff 0f 00 00 f0 00 00 00

After:

    // Real registers
    18: 05 ff 00 00 ff 0f 00 00 f0 00 00 00
    ...
    // Virtual (per port)
    40: 00 ff 00 00 e0 e0 00 00 00 00 00 1f
    50: 01 ff 00 00 e0 e0 00 00 00 00 00 1f
    60: 02 ff 00 00 ff ff 00 00 00 00 00 00
    70: 03 ff 00 00 cf f3 00 00 00 00 00 0c
    80: 04 ff 00 00 00 00 00 00 00 00 00 ff
    90: 05 ff 00 00 ff 0f 00 00 f0 00 00 00

Fixes: 6863ca622759 ("regmap: Add support for register indirect addressing.")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: improved test for selector to be in the range window
 drivers/base/regmap/regmap.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4ded93687c1f..6d3c69c68cad 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1545,24 +1545,40 @@ static int _regmap_select_page(struct regmap *map, unsigned int *reg,
 			return -EINVAL;
 	}
 
-	/* It is possible to have selector register inside data window.
-	   In that case, selector register is located on every page and
-	   it needs no page switching, when accessed alone. */
+	/*
+	 * It is possible to have selector register inside data window.
+	 * In that case, selector register is located on every page and it
+	 * needs no page switching, when accessed alone.
+	 *
+	 * Nevertheless we should synchronize the cache values for it.
+	 */
 	if (val_num > 1 ||
 	    range->window_start + win_offset != range->selector_reg) {
+		unsigned int page_off = win_page * range->window_len;
+		unsigned int sel_offset = range->selector_reg - range->window_start;
+		unsigned int sel_register = range->range_min + page_off + sel_offset;
+		unsigned int val = win_page << range->selector_shift;
+		unsigned int mask = range->selector_mask;
+
 		/* Use separate work_buf during page switching */
 		orig_work_buf = map->work_buf;
 		map->work_buf = map->selector_work_buf;
 
-		ret = _regmap_update_bits(map, range->selector_reg,
-					  range->selector_mask,
-					  win_page << range->selector_shift,
+		ret = _regmap_update_bits(map, range->selector_reg, mask, val,
 					  &page_chg, false);
 
 		map->work_buf = orig_work_buf;
 
 		if (ret != 0)
 			return ret;
+
+		/*
+		 * If selector register has been just updated, update the respective
+		 * virtual copy as well.
+		 */
+		if (page_chg &&
+		    in_range(range->selector_reg, range->window_start, range->window_len))
+			_regmap_update_bits(map, sel_register, mask, val, NULL, false);
 	}
 
 	*reg = range->window_start + win_offset;
-- 
2.43.0.rc1.1336.g36b5255a03ac


