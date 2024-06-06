Return-Path: <linux-kernel+bounces-204724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABBC8FF2D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF4A1F221C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC71E87F;
	Thu,  6 Jun 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjyAZeL6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB478198E60
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692445; cv=none; b=IL2nkZu03qnuuWFb96h77r7kS8KZYdtrlvI4uNRT9t+7oEzFr1+082gHWNMcSwiyIVzVK/dRuHkz1pkj5n7DgKwtcaBK3g16OhOrATI4Nex45G+sdJ3MUu/NxdG8tTCR2HdGGe0zs9U8W9wPjw2iOjiZYNHV0I+pBU8NLsqcRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692445; c=relaxed/simple;
	bh=HDET+H8swtWAsuC9EGfM92MQMWpKe/UfrivP17K517o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7mcSyqFR8zn1WNxs2/3lYFE9H5KvIOpv+ALmGkaQ1/gt2ENZ20SVJ/EbOJw5Q2IFd7zITky+eovBpX30xhQ1tUVMpp4krnudhhqk8JxfZbr/t0h51zImNNIAmcxUnXZtQtkx0wZqKrSorXNRDbjkwEio1Whaffk0bJYWLOvYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjyAZeL6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717692445; x=1749228445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HDET+H8swtWAsuC9EGfM92MQMWpKe/UfrivP17K517o=;
  b=jjyAZeL6zQ0roO+reZXmebaFVCaPPs/4LAgOfyvuaCSVPjRyhmx0UDDi
   Se1eOk6ras9thTE5rrEbeWp1eKvruXgr6GWd6TtXMTOul4CbuBd5oXzCz
   q2Xosxji1DOAPqkyz0GOeRCWSRs9sxbmFHR3exxKAdYER547PLRxhwOWA
   C7BvgMF1vrjq2005IgPnBHjqSOwi/y+zhxUAgNqRTP6AJBNB+jvlFM/79
   sFTacc9Q8XJYG8v8Yh+7/jN0dYNyOkCxJeV+jo6Fykmi8PMgK3Ahga9pQ
   GdvqTuL7gi+MxGASCEkkWpWymq0egyz9oWeW0F/Zehp+p8FVnoxuCBhua
   Q==;
X-CSE-ConnectionGUID: JiBZA+k7RM2CRK8orUQCQw==
X-CSE-MsgGUID: IAdR+tKGQbekEFHUg1UJMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14531940"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14531940"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:47:21 -0700
X-CSE-ConnectionGUID: 6uxtdCKYQ7uwLRQdiucT+A==
X-CSE-MsgGUID: ALkVom/ER02zq6BiJRsxTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38475875"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 06 Jun 2024 09:47:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9F0A72A4; Thu, 06 Jun 2024 19:47:18 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 0/4] regmap: Switch to use kmemdup_array()
Date: Thu,  6 Jun 2024 19:46:21 +0300
Message-ID: <20240606164717.3031107-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open coded kmemdup_array(), which does an additional
overflow check.

While at it, fix one minor issue in regcache.c.

Andy Shevchenko (4):
  regmap: Switch to use kmemdup_array()
  regmap: cache: Use correct type of the rb_for_each() parameter
  regmap: cache: Switch to use kmemdup_array()
  regmap: maple: Switch to use kmemdup_array()

 drivers/base/regmap/regcache-maple.c | 13 ++++++-------
 drivers/base/regmap/regcache.c       |  6 +++---
 drivers/base/regmap/regmap.c         |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


