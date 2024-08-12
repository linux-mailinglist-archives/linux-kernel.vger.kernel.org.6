Return-Path: <linux-kernel+bounces-283662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D915A94F77F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF651F22E03
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F7192B89;
	Mon, 12 Aug 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BM0/M9A+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5610D18E05A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491070; cv=none; b=lDTPyuQKy0I1kJ2UnDNsCU5xudjlmUy59kqLOrk4WQzayjZWLBBnE+7tHlYJLkxVwoC4cUwkz3/Y/L4+drfReNXfUZOpUlurxJWwaDSIl3Ysjt1WKR7KENhTU8/7lblx+SbZBLIMP6Xuav53iyZgfTZchTu3HNvenCXJhN30bGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491070; c=relaxed/simple;
	bh=WDcz9ooY3AuNzqQt7G0a2VVIOoZxqggPZCGlLCHGS4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mk93gayoWlJSgw69FngHebjSv2iI85F2SPZvWD9yFPmgRbvq8T8GDBkkxk4kZCOAVoHyjMj+/lqUnXrF1wrVQU2PbMyJVIPFNfHK6p7oBGsOU9h0fxy2fvlnpzqaCJcQxgoRvsMU3vkKzawUkehLqLRpFQ3NoReeOhNMXHU1D4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BM0/M9A+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723491069; x=1755027069;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WDcz9ooY3AuNzqQt7G0a2VVIOoZxqggPZCGlLCHGS4Q=;
  b=BM0/M9A+cwq28xWlqOvt0OSN5y+ElVDF15SysEOvYqmhrSyhBgQ0zHyH
   ZRYojiHT91jh2YSeM8N60nnWHnvye5jy6AdxhrCq54IEy8sUOLacUmCzX
   o7YEHkBoC+FYlnQyS8AJn0huaOwD9TrpgxOvZXe6HQYVHzbq0vJh4t/jq
   CpB2qNfuORJUQX42TAgZpFA2tlPoHDTgvhkOtZmlbZ30LmXAoi6IBMPGf
   QeCbCU9bZV1/G7Kl5j0Rc9kB8dJ9T4nUiMcoB73Nx1rtkUr/OzIUmtZw4
   fsJH18ap7IIu3oag9gtrNE9apMCqGFBa0EKpgNiXSL4JTrzcYs85XM7PN
   g==;
X-CSE-ConnectionGUID: j15cXJ+US2q1UGEsWYC0xw==
X-CSE-MsgGUID: LjHPi3IkTlqqPzYyyIVmhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33024732"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="33024732"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 12:31:07 -0700
X-CSE-ConnectionGUID: O/Cgr4t7RUCoiQ4JM/U5JA==
X-CSE-MsgGUID: zPPLXJxxSteWCz+mj8NtUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58320867"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 12 Aug 2024 12:31:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2F4B61F8; Mon, 12 Aug 2024 22:31:04 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Herve Codina <herve.codina@bootlin.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] irqdomain: A couple of fixes
Date: Mon, 12 Aug 2024 22:29:38 +0300
Message-ID: <20240812193101.1266625-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently added code has some issues of different severities.
Here are the fixes.

Assuming Thomas has an immutable branch/tag, I think it's worth
to pull them there, so if regmap needs that code it will be fixed.

Andy Shevchenko (2):
  irqdomain: Unify checks for bus_token
  irqdomain: Remove stray '-' in the IRQ domain name

 kernel/irq/irqdomain.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


