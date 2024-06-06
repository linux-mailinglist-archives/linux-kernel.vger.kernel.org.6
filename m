Return-Path: <linux-kernel+bounces-204980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59B68FF5CA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 537BDB226D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8424D7347F;
	Thu,  6 Jun 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNzDjxHD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8C71B27
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705268; cv=none; b=kwwnb3duOhJ2aMfOwj7RykkUCFEPxoAgUO/bw/RX/J2Bi3fFqZAPA4X+4EoFqokYZXNNvRq0km5S5bEzkWN1ij3/IHxgE6LzIuVx4GhhX8n2swii35AJfhFMH33WZ2xgzCwspBUL9kjzO+szDvG+1jH8IaaeD1ZAp1lx4mt/vLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705268; c=relaxed/simple;
	bh=OdFFAeKGrcLH1ze4oyjWUpua0Hk9BjusDQYrrQiiveE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DeUhxCjY0r1+DygUWvcvAynobRNq5tLuNg8irBnZ5nI8KqdzeIT8tVycdhLP/Cyft/3e9HC17E6oqdLvNkClCzi3dY/WoKaFmpOn+Rvht+sqU/6Ug84uWiuSORBk2KFWAAUnPQLxPQFJgHQl/zPXsFETF5o1r3R+k730d30EEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNzDjxHD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717705267; x=1749241267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OdFFAeKGrcLH1ze4oyjWUpua0Hk9BjusDQYrrQiiveE=;
  b=VNzDjxHDhhX+CkdperXgb7mprxgTuEzIa6ov+I6xRf0ESAXl2QUxY4Ij
   7GAZyIxaj2pdxB0gVWyu2UIp7vMrC0SHpk5wiKY9CT3xpSRXbvHf+gJuY
   0pEnKmt6MNAzhj8Wt2ThZfUn02WpjdJoF3MzoA1Bnajxc9FglK1XLtysr
   yM8bwH42M/IeIaM096VTKSxW3TNwIHWz07ZsH76KjBnLA9c0akaZhDTCF
   ld8++GFSPktljqDBpLMBvEIBVzYGu8C8g/8HL3kIEZtgOguPA+/xs/ZSn
   0T2jSHhIBHdhFVrOkKT6xY30Knb0AmTbG+1swFDXwNfpICMGOY/hCLJGJ
   Q==;
X-CSE-ConnectionGUID: QTHHzwCEQ1OoZaGiGFul1w==
X-CSE-MsgGUID: xZ+oaSPeTr6cHv66UVRbTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14626312"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14626312"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 13:21:06 -0700
X-CSE-ConnectionGUID: qegcAetdS6GYrV3p2g6cwg==
X-CSE-MsgGUID: hcbDtLvUQsKlNkehre2nIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38037517"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jun 2024 13:21:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DE6381C9; Thu, 06 Jun 2024 23:21:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regmap: kunit: Use array_size() and sizeof(*ptr) consistently
Date: Thu,  6 Jun 2024 23:21:02 +0300
Message-ID: <20240606202102.3108729-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the allocations use explit sizeof(type) instead of sizeof(*ptr),
which is fragile. In particular, stress_insert() allocates double
of memory without obvious need for a test. Convert all allocations
to use array_size() and sizeof(*ptr) to eliminate similar mistakes
or wrong memory sizes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-kunit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 31df46cbcae7..9ec91b0de4a6 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -163,7 +163,7 @@ static struct regmap *gen_regmap(struct kunit *test,
 			config->max_register += (BLOCK_TEST_SIZE * config->reg_stride);
 	}
 
-	size = (config->max_register + 1) * sizeof(unsigned int);
+	size = array_size(config->max_register + 1, sizeof(*buf));
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
@@ -768,10 +768,9 @@ static void stress_insert(struct kunit *test)
 	if (IS_ERR(map))
 		return;
 
-	vals = kunit_kcalloc(test, sizeof(unsigned long), config.max_register,
-			     GFP_KERNEL);
+	buf_sz = array_size(sizeof(*vals), config.max_register);
+	vals = kunit_kmalloc(test, buf_sz, GFP_KERNEL);
 	KUNIT_ASSERT_FALSE(test, vals == NULL);
-	buf_sz = sizeof(unsigned long) * config.max_register;
 
 	get_random_bytes(vals, buf_sz);
 
@@ -1507,15 +1506,16 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 	const struct regmap_test_param *param = test->param_value;
 	u16 *buf;
 	struct regmap *ret = ERR_PTR(-ENOMEM);
-	size_t size = (config->max_register + 1) * config->reg_bits / 8;
 	int i, error;
 	struct reg_default *defaults;
+	size_t size;
 
 	config->cache_type = param->cache;
 	config->val_format_endian = param->val_endian;
 	config->disable_locking = config->cache_type == REGCACHE_RBTREE ||
 					config->cache_type == REGCACHE_MAPLE;
 
+	size = array_size(config->max_register + 1, BITS_TO_BYTES(config->reg_bits));
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
@@ -1615,7 +1615,7 @@ static void raw_read_defaults(struct kunit *test)
 	if (IS_ERR(map))
 		return;
 
-	val_len = sizeof(*rval) * (config.max_register + 1);
+	val_len = array_size(sizeof(*rval), config.max_register + 1);
 	rval = kunit_kmalloc(test, val_len, GFP_KERNEL);
 	KUNIT_ASSERT_TRUE(test, rval != NULL);
 	if (!rval)
-- 
2.43.0.rc1.1336.g36b5255a03ac


