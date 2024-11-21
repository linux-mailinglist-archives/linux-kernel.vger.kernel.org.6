Return-Path: <linux-kernel+bounces-416954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5F29D4CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD12B21481
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E5A1D2F64;
	Thu, 21 Nov 2024 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcijktP0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6F15ADB4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732192479; cv=none; b=DSstdWSyTxRfKrWGPVfrbInywWzLI7wfEdj9q+viy+siNJP6TYYnvhTdz02dYgx4F2SsWCi7IV0gXNCbwNIzVTmT4LlnO+TlLaogYscHJZqp+sOo7LOw1aBr90kFXlO7ZJiGtwRIbe9VgOBW1yyHO5SSSfTZYi11igct2qk6YWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732192479; c=relaxed/simple;
	bh=QKZP4Uh01oBkc237eEN5Cd5VoGA67HiCz8Rl5bZAbz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kd4oLJ/i9ae6OT9bF48e0PDjlRAf8cTDUmLi3GVQ6vRm35IWTYmoUdK5IsVoHGO8R6YamyvZPpEd1EfEMtKjEezf7rLNYhzpUB/pY0L4oLPoOK9B2ha78Tk36bQ9zz9L941dqicUFfyAaX46rXzofjqZ0ciHo8mUfCDLL8J69Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcijktP0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732192478; x=1763728478;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QKZP4Uh01oBkc237eEN5Cd5VoGA67HiCz8Rl5bZAbz4=;
  b=gcijktP0dw2rBItSST+XLaz32oERQ1XsymLeRxNtXMaRO9uWyfSY+kDT
   ssmwadNazGgYqGPuZtydo15Pqvk8W2qWopsrbcSi9KIfB64yfwbeSEybb
   cx3uwkAfrwEQ8GuOg9ToQn4TDkDZoRG58dNK8tzHCHclNjIXHJ+qmKvnQ
   zBC/jim9eCvv1UhXIH2p8k0m6ZViemS/eVfFnBnkxFe1uZfqLAY82Y0Nr
   Hecx7HuUV4TbLbiJ7QplAS/9YGZ2WhetrxZSgXOlKAfuzslFGthfhyqQE
   u6llCe24DB81Qvt/nm4cgVD/nPbn1ON9j4gz4ywId6Ex7tqLPEgEvCGaV
   A==;
X-CSE-ConnectionGUID: WGXCihWXQnWXYxdF5xkEUA==
X-CSE-MsgGUID: xdiOrpUCRpylIS7gtuV/Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="35968019"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="35968019"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 04:34:38 -0800
X-CSE-ConnectionGUID: 8LszzqN/QUK9uGV5QxtPxQ==
X-CSE-MsgGUID: lHRJuqUtTj6svk0eyKh7RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="90646786"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 21 Nov 2024 04:34:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 252362CA; Thu, 21 Nov 2024 14:34:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regmap: cache: mapple: use kmalloc_array() to replace kmalloc()
Date: Thu, 21 Nov 2024 14:34:33 +0200
Message-ID: <20241121123433.4180133-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kmalloc_array() to replace kmalloc() with multiplication.
kmalloc_array() has multiply overflow check, which will be safer.
In once case change kcalloc() as we don't need to clear the memory
since it's all being reinitialised just immediately after that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regcache-maple.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 23da7b31d715..2319c30283a6 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -73,8 +73,7 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 
 	rcu_read_unlock();
 
-	entry = kmalloc((last - index + 1) * sizeof(unsigned long),
-			map->alloc_flags);
+	entry = kmalloc_array(last - index + 1, sizeof(*entry), map->alloc_flags);
 	if (!entry)
 		return -ENOMEM;
 
@@ -204,7 +203,7 @@ static int regcache_maple_sync_block(struct regmap *map, unsigned long *entry,
 	 * overheads.
 	 */
 	if (max - min > 1 && regmap_can_raw_write(map)) {
-		buf = kmalloc(val_bytes * (max - min), map->alloc_flags);
+		buf = kmalloc_array(max - min, val_bytes, map->alloc_flags);
 		if (!buf) {
 			ret = -ENOMEM;
 			goto out;
@@ -320,7 +319,7 @@ static int regcache_maple_insert_block(struct regmap *map, int first,
 	unsigned long *entry;
 	int i, ret;
 
-	entry = kcalloc(last - first + 1, sizeof(unsigned long), map->alloc_flags);
+	entry = kmalloc_array(last - first + 1, sizeof(*entry), map->alloc_flags);
 	if (!entry)
 		return -ENOMEM;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


