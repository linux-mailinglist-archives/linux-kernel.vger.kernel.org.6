Return-Path: <linux-kernel+bounces-173448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B08C0090
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C251F26C64
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97286AC4;
	Wed,  8 May 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUc6Xj6p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125D654657;
	Wed,  8 May 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180621; cv=none; b=OIfr5hK9KZuyxvPM4/XYUhj+16lortBnFCdVVQoaI+d6oS1h9SOSOtj/7ZfMcngDRSCRCEI3R51qhYod1j7fzZAH1a5xfI7Tlr3CdGP8MZLOjp9s9tbtvJC+8REuUbITNpuONob10El/9PASuGZJw9SAX24h60Z7Mp70g2seaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180621; c=relaxed/simple;
	bh=6R7VbWU4UHh6DRuRP3H6pDD/zjW/wRiXQOmBhrWQydY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJmcDnTFErmK4wQXSH8GKPdBZCodWjdd2ue9dvNXj2W+LTUsoYqkOlLpfjuxl7jTKX4k1YhUZPBqySq3jkTu/1V9PPlb+K6KMTTZXf2jmSCYv99/zLw5/Nyf7ngfcgwCJRxXP0LlbHNL1vO17jtL68sTtcgOdQembkNIv4KgIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUc6Xj6p; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715180620; x=1746716620;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6R7VbWU4UHh6DRuRP3H6pDD/zjW/wRiXQOmBhrWQydY=;
  b=OUc6Xj6pIr+SGybqtHaaDL9Wfhb+bZ6afqu5xbzhGApOUPzOtSljJP3E
   znlWtILVpys5/jII7tkj1sUNkShK18tN9qCIAs07ilSb1RQSHG38I2/0G
   eN9iW2/B0iZ55v9sr67dz+g2HG24PaHnek8tsbyzoIWUJS8xab+tXULHK
   aMfZpmmfnze0ZnkbQQ4DvKE7Oqa/WHTqDJ2ESVJCUSAYk5UXEnLfrIZiH
   R0JoQYE5gS2jHaLLjxWZI26OHTWPteZRWJUsQcyjxH8Xe0cvZhmSNtT0p
   hxR/tmqp8R551CK/oZd5jgHDtlCldf0t64jC4aAcaEcOAzkCd5hdE0SX1
   Q==;
X-CSE-ConnectionGUID: hG/mENeARdGTWbXIKZ8H2A==
X-CSE-MsgGUID: YR7bmJoyTlehj/uZ1T0hvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11177332"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11177332"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:03:39 -0700
X-CSE-ConnectionGUID: UDPUCy8tQFuW8iHIvaC1OA==
X-CSE-MsgGUID: v6VE7CF/QvOvr08iOQwqiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33716818"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 08 May 2024 08:03:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6007A109; Wed, 08 May 2024 18:03:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: fotg210: Add missing kernel doc description
Date: Wed,  8 May 2024 18:03:35 +0300
Message-ID: <20240508150335.1378629-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc validator is not happy:

  warning: Function parameter or struct member 'fotg' not described in 'fotg210_vbus'

Add missing description.

Fixes: 3e679bde529e ("usb: fotg210-udc: Implement VBUS session")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/fotg210/fotg210-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index 958fc40eae86..00483da40f04 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -95,6 +95,7 @@ static int fotg210_gemini_init(struct fotg210 *fotg, struct resource *res,
 
 /**
  * fotg210_vbus() - Called by gadget driver to enable/disable VBUS
+ * @fotg210: pointer to a private fotg210 object
  * @enable: true to enable VBUS, false to disable VBUS
  */
 void fotg210_vbus(struct fotg210 *fotg, bool enable)
-- 
2.43.0.rc1.1336.g36b5255a03ac


