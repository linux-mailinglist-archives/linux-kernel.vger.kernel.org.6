Return-Path: <linux-kernel+bounces-416850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1689D4B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD311F220C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB061D042A;
	Thu, 21 Nov 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDitwnrS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E3D1CB51C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186727; cv=none; b=TRCq7tP6/UFtWRV7pLtDETBIdCUAkmYh0GOP7/ukq2ocDp1rZKzceB1Ky6OmiR6e0w4qtTvisWfBAbisMC7peKdYrTCKm+Ld/MguvdyFJlG3zWU3r3FThQQrNrf9GgYmbUQL6V9rb5RvGcdyra5oUzmYsCLjNSXnBrQZPjWwjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186727; c=relaxed/simple;
	bh=q72Gj/SUfA1k0CyWT9Qff/94SnUAmYWSI18iC2SIVqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2DvzrtGJ6hucX+XmJzEmT96IO0Vbh8fu9x/ATd+oRU+vu19mWv8jFvqy2WxT2p6YCy/xxbQE/wU0P+d86rLuHXhvEUvb/jk3q8GR1wrlmKI0MLZhaNvH1/TAq5viwizp/flExGWqW3zw6l8QpooKkjb5wio9DIi2gCqeG4v6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDitwnrS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732186726; x=1763722726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q72Gj/SUfA1k0CyWT9Qff/94SnUAmYWSI18iC2SIVqk=;
  b=iDitwnrSsvt9ojZ7uM5+qxMtOkObToWFKC4oJsEG1p98sNC8pZ/oYkmV
   PNjODm3mPKQLDvwR6tbUAVn2JcRb58OM2X6QRAQDk1nhZx53wUv9nB6b/
   DSS5kJvcXuUzQ9kO6BCZG3mU6sUcLyae18Hv6gOUavzeCHUvuUmGzndhp
   VzzumoWe4HSSeALy9tC8fz2MD5NLM+FJaT2QgevHhf+EuLDjUFmsd/et0
   F21Z/0xMb/LuQjBbYEsnRwvQfLIdGddFd/68nhnnJK5V8brBcG9Gbu/2N
   nc+RK5FbrfNE8RokSnqbwcbBQjOBeKz+5qAC8+/V6dacQRTduVq4wlHy+
   g==;
X-CSE-ConnectionGUID: l5VFPOBASQyNxJI7z4oN9w==
X-CSE-MsgGUID: bvFXZKsrQAWL3lu+fJ1/Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="19882808"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="19882808"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 02:58:45 -0800
X-CSE-ConnectionGUID: OVNcQxKxTUGmS6uuj9IN5g==
X-CSE-MsgGUID: cGy7OQZeTl6c2KIWOD8GPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="127744822"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 21 Nov 2024 02:58:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3BD42380; Thu, 21 Nov 2024 12:58:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] regmap: Use BITS_TO_BYTES()
Date: Thu, 21 Nov 2024 12:57:22 +0200
Message-ID: <20241121105838.4073659-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241121105838.4073659-1-andriy.shevchenko@linux.intel.com>
References: <20241121105838.4073659-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BITS_TO_BYTES() is the existing macro which takes care about full
bytes that may fully hold the given amount of bits. Use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 53131a7ede0a..d2944271022c 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -759,12 +759,11 @@ struct regmap *__regmap_init(struct device *dev,
 
 	map->reg_base = config->reg_base;
 
-	map->format.reg_bytes = DIV_ROUND_UP(config->reg_bits, 8);
+	map->format.reg_bytes = BITS_TO_BYTES(config->reg_bits);
 	map->format.pad_bytes = config->pad_bits / 8;
 	map->format.reg_shift = config->reg_shift;
-	map->format.val_bytes = DIV_ROUND_UP(config->val_bits, 8);
-	map->format.buf_size = DIV_ROUND_UP(config->reg_bits +
-			config->val_bits + config->pad_bits, 8);
+	map->format.val_bytes = BITS_TO_BYTES(config->val_bits);
+	map->format.buf_size = BITS_TO_BYTES(config->reg_bits + config->val_bits + config->pad_bits);
 	map->reg_shift = config->pad_bits % 8;
 	if (config->reg_stride)
 		map->reg_stride = config->reg_stride;
-- 
2.43.0.rc1.1336.g36b5255a03ac


