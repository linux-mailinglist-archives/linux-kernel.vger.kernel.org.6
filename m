Return-Path: <linux-kernel+bounces-416852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136A39D4B20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE1A2828F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D31D278C;
	Thu, 21 Nov 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oxn1Bgoh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA41CD1F6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186728; cv=none; b=ihSw6A+kfUirwUGb9OCgsSCve83bz0Su7uv0iUhGIJT8Qwjv7NSeT8w8onhGpqUIgFzuKTYB3KAj1l9OM7SCPGoZIXTOBPJLdhVqtHFr60BGrSxA8Sb+sw8CGwwxJMzTpP7LV1T+Xt0hItvtV7rAN8H/b8LcRhJ3WR/qyKH5ndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186728; c=relaxed/simple;
	bh=UOShiaopThGZW3idfKE30w3RHaDOTrWaSt+rbaz4iMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLVkkKmXrLrk9rAnf72ruL6y7MboVxdeA8ZwZ1d0fvzEOBYkzLwJnom0w5Eu4Wu7YqFTq9y5ccjZIZW3LCuTgHzdSOw8+uIA0YqytBkM3g3Q4cD+AYIc0M92TmvUb1jhn+WTi6OqqlimlxS+pG3cHIe9yzyelvTvjYMTqPcNgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oxn1Bgoh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732186727; x=1763722727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UOShiaopThGZW3idfKE30w3RHaDOTrWaSt+rbaz4iMY=;
  b=Oxn1BgohoxIPH7BdaJJPS5nXXLxjfN/YOAYnvndadvKYNnH46OEv/YEr
   xu3+HiWPhs5JgG/QOfA20U+CVc/CFY1H221hyIK0OZ4cjYN5n+Ryyoouc
   YSkHnR5DxZL017KhJ88F32p91sf/Er9ZCM6jMe+Pzqv5G5yaaLupxfvoI
   w8xX2H3+O0XO378Lg8FueBLRd+CfjGV7vsZEESeqvjrZ69S7TuuqXXoHe
   P4W7UtcUfMfesg+jj3QNGkFpfju5FIVOBtKMVoxS6UBrgIyxw2B+Q0+Bm
   KJdmYPJyFCmWOV1w+ClfXQAejUksXL5DcWe5nNu2rWplyeR9UEpE4aYtG
   g==;
X-CSE-ConnectionGUID: DBzfk2sUQayouPrtInJ3ig==
X-CSE-MsgGUID: cncVx5D0TCSZ6Y0Xr0B//A==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="19882814"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="19882814"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 02:58:45 -0800
X-CSE-ConnectionGUID: tErbgRfSS+OfkAa64pv44A==
X-CSE-MsgGUID: z7boQprvT3a8HRe9rjNd6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="127744823"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 21 Nov 2024 02:58:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 43CBE38C; Thu, 21 Nov 2024 12:58:41 +0200 (EET)
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
Subject: [PATCH v1 3/3] regmap: place foo / 8 and foo % 8 closer to each other
Date: Thu, 21 Nov 2024 12:57:23 +0200
Message-ID: <20241121105838.4073659-4-andriy.shevchenko@linux.intel.com>
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

On x86 the compiler (gcc (Debian 14.2.0-8) 14.2.0) may generate
a better code if it sees division and modulo goes together.

  Function                          old     new   delta
  __regmap_init                    3740    3732      -8
  Total: Before=31159, After=31151, chg -0.03%

clang (Debian clang version 18.1.8) on x86_64 still shows better code

  Function                          old     new   delta
  __regmap_init                    3582    3579      -3
  Total: Before=39854, After=39851, chg -0.01%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d2944271022c..4f8ec8528e34 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -758,13 +758,13 @@ struct regmap *__regmap_init(struct device *dev,
 		map->alloc_flags = GFP_KERNEL;
 
 	map->reg_base = config->reg_base;
+	map->reg_shift = config->pad_bits % 8;
 
-	map->format.reg_bytes = BITS_TO_BYTES(config->reg_bits);
 	map->format.pad_bytes = config->pad_bits / 8;
 	map->format.reg_shift = config->reg_shift;
+	map->format.reg_bytes = BITS_TO_BYTES(config->reg_bits);
 	map->format.val_bytes = BITS_TO_BYTES(config->val_bits);
 	map->format.buf_size = BITS_TO_BYTES(config->reg_bits + config->val_bits + config->pad_bits);
-	map->reg_shift = config->pad_bits % 8;
 	if (config->reg_stride)
 		map->reg_stride = config->reg_stride;
 	else
-- 
2.43.0.rc1.1336.g36b5255a03ac


