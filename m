Return-Path: <linux-kernel+bounces-338253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ADA985574
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE8C1F221A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FCD15990E;
	Wed, 25 Sep 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEU4YWVZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3EF7E574
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252852; cv=none; b=hDvM5A0QkpsBvsoNrgKAz7oh/M1HtJQFbET3/ECcMq5BVbypX0RmjnRUmmxJWxKp5xKGTmgKWYjK2ki/oIrfROAw189qUdEjMMElWrcxowkeHd6bR+qk9gzl3Yb7jEYnYUbqWsB270buTFCGg4bZnnMdr7ml/ecAZgWtxtHVUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252852; c=relaxed/simple;
	bh=2y2ixCf4N2myONTLqDniuYdI7WXLmCRyNgYUxMr/m58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHIk9uV3l6C4OaLTjb/TZETbtVqf/7G5EUhsqfPpBG9AksFdRWhpYObE407Dc0cyrvIJokm2icjTyCImVSqYLlOBsasN7p1n9kKaqjpg129Um7j2jwmsc7WWAU6gxmrkMFPuUoOmiX5NpyvFoytp/AfnLnj11ZMN760TYxXjw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEU4YWVZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727252851; x=1758788851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2y2ixCf4N2myONTLqDniuYdI7WXLmCRyNgYUxMr/m58=;
  b=NEU4YWVZSki2bKrFCHCrsXRhBuzOvqbJ7O+tJXkNAOsfou8CKa4LMixR
   bMz7Ps55qgqoZFOlJRXMwPNS3fi4gUyOaa6tpm7L7bm5hggmbvfbIY/mT
   dHxM7de6DewcXZXr8WjIvZwaxLTs+A/m1gDo1AsOXMlC5iuuxh0U19bcA
   LAYJHxw/XJ4sUOqBqAtofQkkq8ReV0OlGQ7Xzr7u+TDCnvibb4039layB
   +n+diaqAW+Fn/8XuKdFo+dIzxjB2cMmev7HqxFOmZsirSidNYNdUsHFMc
   g/albLDVvBHSkecVTfNRoV70qvZDLUzX38vX07CApXd1sYerg9hilH+bL
   Q==;
X-CSE-ConnectionGUID: yf9/InbcQZG9YA+KoZT+Rg==
X-CSE-MsgGUID: ub6tY5TTRLGbYjoPZTqHhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26468387"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26468387"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 01:27:30 -0700
X-CSE-ConnectionGUID: rYLXGgwVSvWZ0R+FD4MI7g==
X-CSE-MsgGUID: ftO+K2T+T2aIwhWB2ZDu7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71575357"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 25 Sep 2024 01:27:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 76F73565; Wed, 25 Sep 2024 11:27:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regmap-irq: Consistently use memset32() in regmap_irq_thread()
Date: Wed, 25 Sep 2024 11:27:26 +0300
Message-ID: <20240925082726.620622-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 4d60cac951fd ("regmap-irq: Add no_status support") adds
an additional branch into IRQ thread handler in regmap. It wisely
chose to use memset32() as it might be optimised on some architectures
and hence give a performance benefit. At the same time the old code
continue using simple memset(). Update the old code to use memset32().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-irq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index a750e48a26b8..33ec28e3a802 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -364,14 +364,11 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		memset32(data->status_buf, GENMASK(31, 0), chip->num_regs);
 	} else if (chip->num_main_regs) {
 		unsigned int max_main_bits;
-		unsigned long size;
-
-		size = chip->num_regs * sizeof(unsigned int);
 
 		max_main_bits = (chip->num_main_status_bits) ?
 				 chip->num_main_status_bits : chip->num_regs;
 		/* Clear the status buf as we don't read all status regs */
-		memset(data->status_buf, 0, size);
+		memset32(data->status_buf, 0, chip->num_regs);
 
 		/* We could support bulk read for main status registers
 		 * but I don't expect to see devices with really many main
-- 
2.43.0.rc1.1336.g36b5255a03ac


