Return-Path: <linux-kernel+bounces-283660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C3894F77D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990241C21BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE66A1917CD;
	Mon, 12 Aug 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WL5/wT54"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BBA2599
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491069; cv=none; b=aQOODzhRWl3Aasb+Dzk/eBdcg28E99A3p41uzy/OAr6qUjhMbK/p6xu67FEdUXZY5hPJruBbHi+yN8iI6/4Z3gLDGEvqnrXTwIStHjLToi5kAUiDAyJ7VIOz99oijqPTEULufm6ioG8NRiZZWYjLyHdBbRLHtJeMSVCy15valDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491069; c=relaxed/simple;
	bh=aAHzoeuUnXGRvitrK+OloYMAGSoAC3+6V7r2mpdWbDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pp90RZ81fem4xmWggctWE7XG+daV3lwSiEGTWNfryDzZODCIOIBCzm8Jyli9voQ63ysyWa3fTVZAFuN318GaI6y2t8pCVNrh/c5aTH4cgS4hwadhPtSAON++E/rPese/AAGr8ifA/DdH6ND9jvF6ZsdgvaZPASOB8R/Vpddj/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WL5/wT54; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723491068; x=1755027068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aAHzoeuUnXGRvitrK+OloYMAGSoAC3+6V7r2mpdWbDo=;
  b=WL5/wT54opvRvR8UkZrnjHFuHYvVkG0LjDkI3fEfB5053Jfyq/2mXMKi
   HTzP9PCT3UlR+M5xaip3s5XbOS8+7s9c+kV73oeBv3tRgjw0C8ZSkkTez
   h1uRQF+eaGO1VfYRN4EsaEGmRIrHRLzg1dKrdYrI8hg7/bmJfo9oBs6wn
   RbCyAMnLaX121/ODYMNHgsytw4PzklGGQimjL/YhiXn9UtmHxYuaWZ/mj
   NgtxHlE/BjGW/lIhRkFM553lBsMAdXYIZEMMHlB+yls26Mbacg/0x8ZE7
   EOkDRLPkVYVI6l3RWlLxJ1QZ02Fdt5zCblGatv4xuj6ZNf1r77NKKz0iC
   A==;
X-CSE-ConnectionGUID: PNysMwYeT8qnK+ATGKQlVg==
X-CSE-MsgGUID: AqloVVreQ0igTTp0bjHYbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33024737"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="33024737"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 12:31:07 -0700
X-CSE-ConnectionGUID: SvdYsHybQ+6PUdvly9h+ug==
X-CSE-MsgGUID: Gh/bgniVS+WH626Yf7Rbmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58320868"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 12 Aug 2024 12:31:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4C95C321; Mon, 12 Aug 2024 22:31:04 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Herve Codina <herve.codina@bootlin.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] irqdomain: Remove stray '-' in the IRQ domain name
Date: Mon, 12 Aug 2024 22:29:40 +0300
Message-ID: <20240812193101.1266625-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240812193101.1266625-1-andriy.shevchenko@linux.intel.com>
References: <20240812193101.1266625-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When domain suffix is not supplied the fwnode case (not irqchip-fwnode)
uses alloc_fwnode_name(). This currently unconditionally adds a
separator. Fix the logic to make it conditional and drop stray '-' in
the IRQ domain name.

Fixes: 1e7c05292531 ("irqdomain: Allow giving name suffix for domain")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 18d253e10e87..1acc5308fcb7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -149,9 +149,9 @@ static int alloc_fwnode_name(struct irq_domain *domain, const struct fwnode_hand
 	char *name;
 
 	if (bus_token == DOMAIN_BUS_ANY)
-		name = kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, suf);
+		name = kasprintf(GFP_KERNEL, "%pfw%s%s", fwnode, sep, suf);
 	else
-		name = kasprintf(GFP_KERNEL, "%pfw-%s%s%d", fwnode, suf, sep, bus_token);
+		name = kasprintf(GFP_KERNEL, "%pfw%s%s-%d", fwnode, sep, suf, bus_token);
 	if (!name)
 		return -ENOMEM;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


