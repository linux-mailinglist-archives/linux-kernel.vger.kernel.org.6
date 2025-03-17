Return-Path: <linux-kernel+bounces-564877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B44A65C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6076C882AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1141E1E08;
	Mon, 17 Mar 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVVyc4wA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279F1DE2B6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235260; cv=none; b=aybeTFlfwko0K4ki7g5oIitKInmsXHfxee/pQiWxr0ossrf5JTWzLO9IoMCplxL8XHu6HeRnS5xkZE4QzcUowAveVCwRTMFCYUs7D7pFSSTcyX8TRoj9RYXrekrYVSsV08F/zpCT9iOhfFK4o25MHp3awL2ll0Amp28iIgK3v8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235260; c=relaxed/simple;
	bh=B5cEWlXb6TDZQD3QiR+jDDqz1FNbhcB3N3zgLpxZPJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGdCBsxY+wabowlE1SKCQJG6CigreJ+vO5IW1zq9DwmgO7YS1lV1rcm7iu+r/DWrbQObFHvEzWLk2WcqdanVvu7iVajjAIjxZgXou2421iq89d3KsRtXRfoGd25lEcDx4kPzkJKX2yAzyYCfKDz9qVTRPYR2bYJGINyxWmSMqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVVyc4wA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742235260; x=1773771260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B5cEWlXb6TDZQD3QiR+jDDqz1FNbhcB3N3zgLpxZPJE=;
  b=CVVyc4wAaZevosRH75sMSRVR0it76ycK8RkK9itFEMsE2zAmXDcXnj7l
   V0EuRvJ38vtYokQ7Gh+QT2W1tCalBj3FLJDV2mf/LkfYet+AqzZt0h6Ry
   75pVi96eofZkgC9W0iEZkgc2fSbMDTVivvNeKXEAanc1KXIlWeNzNYdeB
   f2HayDx92MbQUd28pdcEDnAtOaR0lAikDV533xSZUuQmOFtxIMaVV/DCX
   JEa1HVEpK+GQMYv3gQEP+idoR/qS3KDngZdSuJFiAXw8vnD3J0EO3UBco
   /zGxRJQZOgVXPaeJcCTBtxLpkpsxUYtMNUPOH5Kft7x90c9y56oAJ654b
   A==;
X-CSE-ConnectionGUID: NT4G17W2RF64SVCvoLVMdQ==
X-CSE-MsgGUID: J1tMblrTTuKTH4c4WxzN/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43259469"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43259469"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:14:17 -0700
X-CSE-ConnectionGUID: qBnrCENSQyquLO+35FHsUg==
X-CSE-MsgGUID: NV+WN8aFQUuj82+ZKYsekQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="153007718"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 17 Mar 2025 11:14:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 390CD516; Mon, 17 Mar 2025 20:14:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/4] resource: Replace open coded variant of DEFINE_RES()
Date: Mon, 17 Mar 2025 20:11:13 +0200
Message-ID: <20250317181412.1560630-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317181412.1560630-1-andriy.shevchenko@linux.intel.com>
References: <20250317181412.1560630-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open coded variant of DEFINE_RES(). No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/resource.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index a30a32b47e0e..8ff2f8953a4a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -563,8 +563,7 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 	struct resource res, o;
 	bool covered;
 
-	res.start = start;
-	res.end = start + size - 1;
+	res = DEFINE_RES(start, size, 0);
 
 	for (p = parent->child; p ; p = p->sibling) {
 		if (!resource_intersection(p, &res, &o))
-- 
2.47.2


