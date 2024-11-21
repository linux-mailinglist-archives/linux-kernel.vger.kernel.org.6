Return-Path: <linux-kernel+bounces-416851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B703F9D4B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D172824AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CCB1D172C;
	Thu, 21 Nov 2024 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECTbav/v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64B1CB9F4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186728; cv=none; b=HILehiq0CwwKCJFipJeX2EuVa4Ju0CvujTBt13icWtS/oorRryTTb9r6SCjwzr8wYH8+rLKKZe/hS+fZklDz4yM8U5iMhTYBhoX4au3DZYl/9h6rVmQCa1oP43rKbbAz3Aw3NKDxJOOxdZdObv+co9mvGcsxgcpOFNgG+Bck/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186728; c=relaxed/simple;
	bh=/QyavsQUbkpLYIOhPWStJrL8BeUImds2oNJsQDyj6xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZ/eprsypfAP4yevnMBg9a/1oq8vJibrVp8W626XVUWoC8SQzB/Iw2TTrDmkID1FcSzb5ofMyb+JVIYX7W3Fgrevni/aKE8md+ezrVZ5ULqLCiR4r9cL1csOo0rl3fHN/m/C6O8Zt1nCyDw6vPm7PqUYg6Xjhv9/sE3idMU9fOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECTbav/v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732186727; x=1763722727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/QyavsQUbkpLYIOhPWStJrL8BeUImds2oNJsQDyj6xk=;
  b=ECTbav/vc6y2NfezwCpBCdyAjkWoYG/2WCoupZKg4Z6Q5Z/nornunkGE
   kFIU/CH5SBiXmcW4h1J8psZEvRaxvMKcH/LS+Tu0CEk84Kh9ILnxJl1KX
   LO/YTAmjlzGlDg/bgroGqdZX5AoMomqLfBnKMuJKQctDyuPu03Ffz9O/I
   qu6vG9nWuGgY9Gf/YBEy5FWmNzfVDoa5jOnDAXXcZwkfggOBS5/qrZbP/
   0tqyGMvXAR+k8SAQxVwTzGxAEXjl/imk0mzAs08zs1eWZSoi0FEpuV3hp
   1zoA8eAFkOIvPu4Wfc7SWJaXTqVuz4NHQOCkWomijT+6SNg8QvQcSBrWz
   Q==;
X-CSE-ConnectionGUID: 8qEB8r/DSgyCynrdx+f6lQ==
X-CSE-MsgGUID: EgtL4twTRuyq+TSm5SaI8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="43687812"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="43687812"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 02:58:45 -0800
X-CSE-ConnectionGUID: O2iT1MNrRcO2nOyMTdLr0w==
X-CSE-MsgGUID: t01zKYMoRyCxzHsCprasHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="90623760"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 21 Nov 2024 02:58:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1EED51BD; Thu, 21 Nov 2024 12:58:41 +0200 (EET)
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
Subject: [PATCH v1 0/3] regmap: Cleanup and microoptimization
Date: Thu, 21 Nov 2024 12:57:20 +0200
Message-ID: <20241121105838.4073659-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two patches move the code to use BITS_TO_BYTES(), while the last
one otpimizes the code generation on x86 (32- and 64-bit on different
compilers).

Andy Shevchenko (3):
  regmap: cache: Use BITS_TO_BYTES()
  regmap: Use BITS_TO_BYTES()
  regmap: place foo / 8 and foo % 8 closer to each other

 drivers/base/regmap/regcache.c | 2 +-
 drivers/base/regmap/regmap.c   | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


