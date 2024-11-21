Return-Path: <linux-kernel+bounces-417059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE829D4E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B705F1F23021
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AB1D9A7F;
	Thu, 21 Nov 2024 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDewpsuM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9C70815
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198464; cv=none; b=tdPG2Tj4m78Ok3vZ2w39dVJVhJxfdNm39rNhEjyDN+v69r1d66yLT6sxsxtMAYEM+Fxc0DZjzDEjeOcWqeo6xG6jzZ7yUI+wmGYn1EDy2muQ1BCzPCJeDlD6Hz6JftNw1Bb3ub4mQOtQ5QbgDwlyq0i294+tK8lp1LQaw+09UVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198464; c=relaxed/simple;
	bh=78xqjkOvY8077gNE03pLHliHrusXeqsmg6kq4vYtz2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTDuUGbt1pxWG4NnuE32aAxqPZZNOWnrvqUXroBD3RLGLNK/EcmU3akbwd46+bfOmBCuTorDtsK/WF0sZpZqaYaSfJc/7kIJaUrLzeD2y4hHtL/cwCujbfAg6UT+IX4XBa3QDfBxqRqwD97t1+n8b9ghs0zlA6S+Q03QzgQdIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDewpsuM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732198463; x=1763734463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=78xqjkOvY8077gNE03pLHliHrusXeqsmg6kq4vYtz2A=;
  b=hDewpsuMrHUUqVp776Ric19JmxX9O87VeCLbOnD0gau4hTnTZVhkZKc3
   tuDm4evkctDl1NdBcluMNlhDLi4N7R0J9MbmXQA7F7Loi1poosAGYjwV4
   uemL2rjNxNRabwNnENoXSfa0MQgtSFMrfs+EinlW90uAxEpH7heYozXVu
   ZmQs8AylTYdxTqdeWv1FnoqSZQ9JBn+5wmif9gOoF5fkMc6CsldCHjJrC
   XkQ4prmueJxxEBOGC/e06CsYBsxUlpwgm66jtixgWcMaW6Rp4LWLboV7h
   pPMhL2QVhmOHUx6PCGQ8plKbT2jedneeC8bzxNToKI7j4X9+yPxHwMA6Z
   w==;
X-CSE-ConnectionGUID: mwQfn3NvQZOtXbcQh3lxug==
X-CSE-MsgGUID: yCdN4yfdTsOIo4xBBmpHgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43707178"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="43707178"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 06:14:21 -0800
X-CSE-ConnectionGUID: 2U49WKnvSGe6ETjvdnhKCQ==
X-CSE-MsgGUID: dpOzJJFQR4eGUOlkHuCW+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="89867598"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 21 Nov 2024 06:14:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EB1DE2CA; Thu, 21 Nov 2024 16:14:18 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2 1/2] kcsan: debugfs: Use krealloc_array() to replace krealloc()
Date: Thu, 21 Nov 2024 16:12:51 +0200
Message-ID: <20241121141412.107370-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241121141412.107370-1-andriy.shevchenko@linux.intel.com>
References: <20241121141412.107370-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use krealloc_array() to replace krealloc() with multiplication.
krealloc_array() has multiply overflow check, which will be safer.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/kcsan/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 53b21ae30e00..be7051d0e7f4 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -166,10 +166,10 @@ static ssize_t insert_report_filterlist(const char *func)
 	} else if (report_filterlist.used == report_filterlist.size) {
 		/* resize filterlist */
 		size_t new_size = report_filterlist.size * 2;
-		unsigned long *new_addrs =
-			krealloc(report_filterlist.addrs,
-				 new_size * sizeof(unsigned long), GFP_ATOMIC);
+		unsigned long *new_addrs;
 
+		new_addrs = krealloc_array(report_filterlist.addrs,
+					   new_size, sizeof(*new_addrs), GFP_ATOMIC);
 		if (new_addrs == NULL) {
 			/* leave filterlist itself untouched */
 			ret = -ENOMEM;
-- 
2.43.0.rc1.1336.g36b5255a03ac


