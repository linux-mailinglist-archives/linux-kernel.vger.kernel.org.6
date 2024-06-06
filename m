Return-Path: <linux-kernel+bounces-204722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4468FF2CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508A31C2137D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A4198E81;
	Thu,  6 Jun 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbIjW9Dl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5401E197A7F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692444; cv=none; b=P23BcogVzXX2qmbnQGGnNnwWNVxksldlywsYJbHd6r5sVVNFrQR5q7GGz89/bvKxLPd0E0dzKwaH6OhwRDHAT7+midbkj779pI/V+fEen5RM8kNoYAKzz7pTfj+zLb/QSHLBAOYtS0DhTiCRaFvHMAxJf8Hv9qabKYgA+4jUo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692444; c=relaxed/simple;
	bh=r+kfSuHjOqr17WFaqvO8+4gnvADH+fS1GXIF7AYuo5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IW/Uuq2hWjF6r9eaya8J7Kr8cqCIhKky7IB1b9pQO/USrxpGBvuPty6LcaeotxcJfjCSTGOtDx8mw73RLZEVB2cGWFQTlYd5As0lld25fKxBUVPdvEQ06DBZparJLLD4jhuKmstojtMsRNWeOluXUoHitLRKlY9PuZ7O3uU3TCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbIjW9Dl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717692443; x=1749228443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+kfSuHjOqr17WFaqvO8+4gnvADH+fS1GXIF7AYuo5c=;
  b=GbIjW9DlLs4oe979TFLfNWeP4quY0rPW3UGsvhyMUqdj308c7vBstBK/
   ZPr9iL3LbXmytGo/dh9sI9xlsYUWudSa9HcuP1L5Pmzj6oO5qeGRfbhYg
   fJOBM1wVGCdDwwPbcmgithLlLZBD8GBxrU3ntCRW30VrLMhvl8/0ih0xO
   njUwCJ4Wn/Jb7V4ghz8kerj1Zr6iX6jZWTzu29JBsEL8nh+4ZVQ+js29Y
   qmR7tMZnyk9Ev1+4AR/Y5tw7STMVAyj/JFmHJOvGcBLDLe9fyXje0n+aq
   CfOg1RuKlxzupPDRbSt97P84SW6vvqovx2sr5dfY3VX6VgJ22r3IA35aJ
   w==;
X-CSE-ConnectionGUID: oZkQDZ89Q5SepZM27ulyYA==
X-CSE-MsgGUID: ECAW4WfdSZqz/49rPmF1Fw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14531935"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14531935"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:47:21 -0700
X-CSE-ConnectionGUID: RnGBNQ96T4u1hzAFACMsLA==
X-CSE-MsgGUID: TXyaP7z9TaKCauX2aIQdRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38475877"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 06 Jun 2024 09:47:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D2367339; Thu, 06 Jun 2024 19:47:18 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 3/4] regmap: cache: Switch to use kmemdup_array()
Date: Thu,  6 Jun 2024 19:46:24 +0300
Message-ID: <20240606164717.3031107-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240606164717.3031107-1-andriy.shevchenko@linux.intel.com>
References: <20240606164717.3031107-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index bd7462c54271..7ec1ec605335 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -170,8 +170,8 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 	 * a copy of it.
 	 */
 	if (config->reg_defaults) {
-		tmp_buf = kmemdup(config->reg_defaults, map->num_reg_defaults *
-				  sizeof(struct reg_default), GFP_KERNEL);
+		tmp_buf = kmemdup_array(config->reg_defaults, map->num_reg_defaults,
+					sizeof(*map->reg_defaults), GFP_KERNEL);
 		if (!tmp_buf)
 			return -ENOMEM;
 		map->reg_defaults = tmp_buf;
-- 
2.43.0.rc1.1336.g36b5255a03ac


