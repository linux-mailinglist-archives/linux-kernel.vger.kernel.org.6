Return-Path: <linux-kernel+bounces-414449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0859D282A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2C3281984
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A711CEACE;
	Tue, 19 Nov 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRfAsg3q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8481CEAB9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026563; cv=none; b=QPn+f2hLrbo3lrhuEU4CLWHqaIygC0+YARS9hDwAQTuPQAQtufmTjxVjeNyosGJoTNQMSJBPmrftKcejaObrB1Vhq4D1PBm2Z1fiYK+XdIMbF+cEQNVuTxiAfrch+L8St46ptQuQgbXLocO3Sk233zvw1gV1e2Pb8UXRL9pf9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026563; c=relaxed/simple;
	bh=SYP7O5TeiQmjdeTWHzOdICHHQ/4UOpfjhgvRNDowIsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foM5g1ISVWLnSyofsAnngW9TxHH5pEOqrsnADI0tmFPZ9VN3SdY7as1Vik4AZlKdPHJQ82vc5whshH/ZIFmlSy4bXKk6lWyIApaaPQmWCodWAb4sk2gTT5xQIsPMDv2eHJrjovTim3zIYHEDP26+fmjS9y3Y4HKOfAE39MrLRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRfAsg3q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732026562; x=1763562562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SYP7O5TeiQmjdeTWHzOdICHHQ/4UOpfjhgvRNDowIsg=;
  b=kRfAsg3q0K8kMiw8YNwZ+ADjUCuT+sEU0HiFm8OkrLCGY8qrxChu+abz
   ab8hWlky88cRYYIWtx8zYJN8XWHKLqlQfH2Bhsfws0zSaW7Ti2Hg9DYvB
   Zk3M8lxsf96mgKsN4SD6sq34aSbVbaGnkT059cviYOOXtrWsa7XS4LzdO
   ARb4bFa9Evb3K/HzV8R2XRVDJkE/YNtGTAKOJaUJ5TPEef+KSSPpjaEiU
   Q4XU4iyEyXNsV+1UyT8SQRRYlihA0tRDiTK09tBg6YzQTJNYZyyckwOFp
   cTAyNzcNU7jKdZzLgRoY711WArTdJ6DQcyObw/k8HmLE1dF6wLT7/vB28
   g==;
X-CSE-ConnectionGUID: +ZptjixMTqSQtWK6pEa6rQ==
X-CSE-MsgGUID: U5zkPNDtRJqdaezVnJfbXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32087819"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32087819"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 06:29:21 -0800
X-CSE-ConnectionGUID: N4m8j0uRR66FwEk7opkPag==
X-CSE-MsgGUID: Bf0Tx5McSDWfQzVVL66eyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89982237"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 19 Nov 2024 06:29:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B4774268; Tue, 19 Nov 2024 16:29:18 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regmap: Drop unused devm_regmap_*_free() APIs
Date: Tue, 19 Nov 2024 16:29:15 +0200
Message-ID: <20241119142915.2339362-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides the fact that currently defined devm_*_free() APIs
are being unused, it's usually a sign of bad design to call
such explicitly. Drop them and make people pay more attention
on the misuse of devm_regmap_*() APIs,

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap.c | 36 ------------------------------------
 include/linux/regmap.h       |  3 ---
 2 files changed, 39 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 53131a7ede0a..4fd914167c76 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1320,42 +1320,6 @@ void regmap_field_bulk_free(struct regmap_field *field)
 }
 EXPORT_SYMBOL_GPL(regmap_field_bulk_free);
 
-/**
- * devm_regmap_field_bulk_free() - Free a bulk register field allocated using
- *                            devm_regmap_field_bulk_alloc.
- *
- * @dev: Device that will be interacted with
- * @field: regmap field which should be freed.
- *
- * Free register field allocated using devm_regmap_field_bulk_alloc(). Usually
- * drivers need not call this function, as the memory allocated via devm
- * will be freed as per device-driver life-cycle.
- */
-void devm_regmap_field_bulk_free(struct device *dev,
-				 struct regmap_field *field)
-{
-	devm_kfree(dev, field);
-}
-EXPORT_SYMBOL_GPL(devm_regmap_field_bulk_free);
-
-/**
- * devm_regmap_field_free() - Free a register field allocated using
- *                            devm_regmap_field_alloc.
- *
- * @dev: Device that will be interacted with
- * @field: regmap field which should be freed.
- *
- * Free register field allocated using devm_regmap_field_alloc(). Usually
- * drivers need not call this function, as the memory allocated via devm
- * will be freed as per device-driver life-cyle.
- */
-void devm_regmap_field_free(struct device *dev,
-	struct regmap_field *field)
-{
-	devm_kfree(dev, field);
-}
-EXPORT_SYMBOL_GPL(devm_regmap_field_free);
-
 /**
  * regmap_field_alloc() - Allocate and initialise a register field.
  *
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index fd41baccbf3e..c4c3e7ef7a63 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1383,7 +1383,6 @@ void regmap_field_free(struct regmap_field *field);
 
 struct regmap_field *devm_regmap_field_alloc(struct device *dev,
 		struct regmap *regmap, struct reg_field reg_field);
-void devm_regmap_field_free(struct device *dev,	struct regmap_field *field);
 
 int regmap_field_bulk_alloc(struct regmap *regmap,
 			     struct regmap_field **rm_field,
@@ -1394,8 +1393,6 @@ int devm_regmap_field_bulk_alloc(struct device *dev, struct regmap *regmap,
 				 struct regmap_field **field,
 				 const struct reg_field *reg_field,
 				 int num_fields);
-void devm_regmap_field_bulk_free(struct device *dev,
-				 struct regmap_field *field);
 
 int regmap_field_read(struct regmap_field *field, unsigned int *val);
 int regmap_field_update_bits_base(struct regmap_field *field,
-- 
2.43.0.rc1.1336.g36b5255a03ac


