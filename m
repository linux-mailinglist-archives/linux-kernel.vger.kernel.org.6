Return-Path: <linux-kernel+bounces-418293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5AF9D5FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C18283092
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3620F132111;
	Fri, 22 Nov 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jns0OCVU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6712BEBB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283262; cv=none; b=erJETuE24TY4f7Fp5ndB740pE/gg8eNEUMSU7SS57u2gEj6FYMvZvFej97TuwRGnbymXfTe5dUMduMpIiej3bg0F/OaNBWfdVckTMhIxKrsHQhn3Q4xYhwUq/D8CfPlOdMil2pfWS79+Jll8NhVn2O5Oj5IRd0AamusSxcp0XJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283262; c=relaxed/simple;
	bh=pnkug61wRDhP8ZI1zkcljAvXZs3uJYc6IfE2oGVqfQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDDvmN5WfNgVzz0gybxdgOY30VajYdl6dDwfLO3kgKN/k9cgjQO6qHRCv/7hZBEXan8qxB4Vb6X4o13JWTpHKTw8O7GB2Opa3a5DGA5qsokG3he/J+IDeajb/P2SC0gKri8q9UtseIGDVXSJrXFgDWSgtcgwkiIO/StT9Ps1Hg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jns0OCVU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732283261; x=1763819261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pnkug61wRDhP8ZI1zkcljAvXZs3uJYc6IfE2oGVqfQ8=;
  b=jns0OCVUB6CbnCcJ0hl6Gw+uBoztRCP/m/0KeQCfh6l2J2EDaVDxHTEm
   vwoLJS6qhqaI3ZcmZwr5t8icBwu7z4ukgKQ6L90iQH3txPNtea/xRefxQ
   nF9JM6cHskqoUmurD48YMb6NMY1R1Z4NJsBZdEjQazo8G+rOItXjogZyQ
   gmDRRJ2jQ7LHqTR3EuDFQ1Ybxt0fcBT4WtXq3FQ2wd6p36NxHWmNVYq3r
   3XtU+bFVNMq/Ha7km71RfXw2FfqEqxmGl4GoifV31cf48kaqfBC/0Zn4e
   MtjUYXo9iUBHRsJ2Ndw7kask+5vGrxrdyjjpVFy07V7zx6SW5X8I6j8t3
   w==;
X-CSE-ConnectionGUID: zmKm92erQuK9nWX2oTf8Gw==
X-CSE-MsgGUID: GMoyty7HTzahcbk0BEsGMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="54943764"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="54943764"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 05:47:40 -0800
X-CSE-ConnectionGUID: PTIwFYSLQgaIYCqvfT5+7Q==
X-CSE-MsgGUID: aGTsFVEjSMuNWow87F9B3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="94664615"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 22 Nov 2024 05:47:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EAF9E329; Fri, 22 Nov 2024 15:47:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regmap: Synchronize cache for the page selector
Date: Fri, 22 Nov 2024 15:47:34 +0200
Message-ID: <20241122134734.1336768-1-andriy.shevchenko@linux.intel.com>
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
 drivers/base/regmap/regmap.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0c22123c89af..e3beee18a537 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1508,24 +1508,41 @@ static int _regmap_select_page(struct regmap *map, unsigned int *reg,
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
+		unsigned int sel_offset = range->selector_reg - range->window_start;
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
+		if (page_chg && sel_offset < range->window_len) {
+			unsigned int page = win_page * range->window_len;
+			unsigned int sel_register = range->range_min + page + sel_offset;
+
+			_regmap_update_bits(map, sel_register, mask, val, NULL, false);
+		}
 	}
 
 	*reg = range->window_start + win_offset;
-- 
2.43.0.rc1.1336.g36b5255a03ac


