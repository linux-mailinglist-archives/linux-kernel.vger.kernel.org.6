Return-Path: <linux-kernel+bounces-336437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB32983ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B892822CE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A972BAFC;
	Tue, 24 Sep 2024 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQRg9t8M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C812E7E
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140639; cv=none; b=a1G94LI+Y2Xneo6yBP4ScS8gJqWPGBoRz1kiyjx0TWeNKv3xASo3zBaQ+DASuuRU9/TzBH9Brd9StztY7k4rA4bT4ZC0+LwBBEqKG7fjR6/XwcIN114D6gV8irklw0Fd0aJ7ePtLDJzpjexlXn+N++yyxvC51WaTT4cy8JnpNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140639; c=relaxed/simple;
	bh=6ALoeaC41g+MaGEwJSRyCvBiONdX4EAtPZdFIMUQEE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fO6so110cYewOt5ZLAbJXSEtvjHrEyaQ1joRTlOOP2Y01sFazpCM7NjsInE04lj9O1c1m7okRLUzfgkJ8Med93KCcRpQNBJz+xGrtOr8XlYWFbCf7BN+g2myqsIkOvnaaFflBpxdhqTwObiaGd+aq280Swxg1/HDIdHRcJoNQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQRg9t8M; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727140637; x=1758676637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ALoeaC41g+MaGEwJSRyCvBiONdX4EAtPZdFIMUQEE0=;
  b=hQRg9t8M655KJBkSTNGN0uhpt5rdlRLI+M0xBVSeWAnV4XR7Etn6a32s
   5so8VZqfmRQDR3gO68ulEzLH2GW0/T9i2eKkDKMMEEFzzPCAsjbl1Krxg
   KkL2ysdb+5N44+ZiH47mbbqp80bKcI8vBdJThxZjgmRfQ7D4YYhmMzXNQ
   WkGucgLsh1dVBSqYSsZ9diC3ZPcc+Jnp90ylTUflroYn1yNx6dBkLLisK
   eXt2Cce9Rpc7XCLSFP2BEPG9rJytihFyO1kR+5yZNmci9MVeXY7132iFB
   qzCGCkE4ckF8F19jJ2M0we1/gn98sZyCKDtQuhYDh8EYLi8kDnN4GPgQ/
   g==;
X-CSE-ConnectionGUID: TkANmsP0RPa8ArRA4Tef9g==
X-CSE-MsgGUID: XRAFMqICROGPjF39eo+sRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="30002051"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="30002051"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:17:11 -0700
X-CSE-ConnectionGUID: XVBMt6QAQySzvitwOcWK+A==
X-CSE-MsgGUID: EuABZkyHT6aA0zdKQwNlSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="108688466"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 23 Sep 2024 18:17:10 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v7 8/8] mm: Document the newly added mTHP zswpout stats, clarify swpout semantics.
Date: Mon, 23 Sep 2024 18:17:09 -0700
Message-Id: <20240924011709.7037-9-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added documentation for the newly added sysfs mTHP "zswpout" stats.

Clarified that only non-ZSWAP mTHP swapouts will be accounted in the mTHP
"swpout" stats.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index cfdd16a52e39..a65f905e9ca7 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -530,10 +530,14 @@ anon_fault_fallback_charge
 	instead falls back to using huge pages with lower orders or
 	small pages even though the allocation was successful.
 
-swpout
-	is incremented every time a huge page is swapped out in one
+zswpout
+	is incremented every time a huge page is swapped out to ZSWAP in one
 	piece without splitting.
 
+swpout
+	is incremented every time a huge page is swapped out to a non-ZSWAP
+	swap entity in one piece without splitting.
+
 swpout_fallback
 	is incremented if a huge page has to be split before swapout.
 	Usually because failed to allocate some continuous swap space
-- 
2.27.0


