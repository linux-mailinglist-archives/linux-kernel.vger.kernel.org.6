Return-Path: <linux-kernel+bounces-564878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B006A65C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01703B9F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6DA1E832F;
	Mon, 17 Mar 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNm1qyI3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76A1DED42
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235261; cv=none; b=ND93n9xzrGlLZPQ3JIF3hn+JKYTfvDjXCFnl2vU8SUQiSVUxRmg/FQ9wRCzun5nS1tLvwvI5PYedZ/huKCAY0ZRICRYwvUapjDoAKsKl+P2G9rrtV9Iuwt3fJzH3jpPDvvCeKIQ+0sSKzd+BCZS1B3PWCCAEAkvvrYGjT57OpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235261; c=relaxed/simple;
	bh=eQWREJ1jkAgHZ1l02bU7KO6zxlVWSx2zj/sKtF5fNy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3+Ra9ysDBCDx4DVcLR6Css0y+2ROkd9LyoLgzvgoB/jUXrADgQWJqCkCXcelEwOXMyMkiQC1WF1mlgbDnf7aG6aH6IiBZtlQC863PJDMswQJzmHC94eaEB4VqNqaOYoMCYBsPvWWkVY62t9RAWWGtwNBuj4GvMk+RBsprl2aC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNm1qyI3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742235261; x=1773771261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eQWREJ1jkAgHZ1l02bU7KO6zxlVWSx2zj/sKtF5fNy0=;
  b=UNm1qyI342wSFUPYem4r2WUJrRhghNeLbTxsofFBb7z8al96ICBZfGyc
   dW/tDvs3veFBV4iXNZ1GE+t5aUujuY/ONymZSXT1Z55BRFlfMxGEvwEmD
   ebBwKJ1RyCLsW7EVGGXaTj0huPjtaOql503gBp6cHjUM2fSpWOzWDkwyn
   aFnv7GVDs77MPsihwIj4zyL0SpD0q1TVE2ujTfipCAtSKLbGW1S6jjF4O
   +Rl9/KOWIqGgCYxgRM3hdw5XLB0MDhh+Soncjt+Z7MvCNu+ElmAHRAxPv
   JUyWGOOuBFFJ9rRSu0o1iB+5sckAoySynxExnb6f1lsXvXvHPktERYKTN
   Q==;
X-CSE-ConnectionGUID: faHL/6G6SkWtOk2Sm5epbQ==
X-CSE-MsgGUID: 5n52qhY4RomNv+yBxNc44w==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53972043"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="53972043"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:14:17 -0700
X-CSE-ConnectionGUID: trVRbIyYR36FbuDi2BxZ5A==
X-CSE-MsgGUID: Qj6F6T7dSTm8UNY+8yjIiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122512767"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 17 Mar 2025 11:14:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 227F1475; Mon, 17 Mar 2025 20:14:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/4] resource: Replace open coded variant of DEFINE_RES_NAMED_DESC()
Date: Mon, 17 Mar 2025 20:11:11 +0200
Message-ID: <20250317181412.1560630-3-andriy.shevchenko@linux.intel.com>
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

Replace open coded variant of DEFINE_RES_NAMED_DESC().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/resource.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 80d10714cb38..dc9031267942 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1957,11 +1957,7 @@ __get_free_mem_region(struct resource *base, resource_size_t size,
 			 */
 			revoke_iomem(res);
 		} else {
-			res->start = addr;
-			res->end = addr + size - 1;
-			res->name = name;
-			res->desc = desc;
-			res->flags = IORESOURCE_MEM;
+			*res = DEFINE_RES_NAMED_DESC(addr, size, name, IORESOURCE_MEM, desc);
 
 			/*
 			 * Only succeed if the resource hosts an exclusive
-- 
2.47.2


