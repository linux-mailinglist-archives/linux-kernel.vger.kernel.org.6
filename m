Return-Path: <linux-kernel+bounces-295856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C969295A21C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0806D1C23574
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A591C1758;
	Wed, 21 Aug 2024 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NG32o+DT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070D1B3B0F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255510; cv=none; b=RajgTrxOycQLS/0Xpglluv0jyu+CDnsLyRBL/to3u8XQC/B/nZTEISEGvzcC70tQgpLECFVax3PkOvCLcJBlIi/gLfpVILEc4wVLnbSOYgZ7/8byM9THV28F7oKnU67xaB+Dded5Vcj8IfhQ7sYlHdQUC1RCxXMR6IXCitNvtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255510; c=relaxed/simple;
	bh=3uK+cop85hkNe8fnneWu2/BxWL1E5gUGm99OP60IOc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQjuy9IV8tr8RfQscH43pikfkmfB2gddfeqEVtr7Hn9OI4YlbXwxjnXlKyIbIaDMMIpI9lXG7Itt5JB2PZwaKCkSZUKfGZZ6JSQlCe5Q+bWM68g2eaR/V6rKKlun9KZmp6ucp0bMLu41VX8xeNMtvFPrV47dkWQL3CNDcn0l5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NG32o+DT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724255509; x=1755791509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3uK+cop85hkNe8fnneWu2/BxWL1E5gUGm99OP60IOc4=;
  b=NG32o+DTefr9ufz3gR1rRYf8r+gBSCDk2thNMxTijU4Wk+qKF+o1Nx8s
   2Q7CN0FqQ0llO2BfqppIvlo3xn63mgpIemQ908oRF4VoaOfYyqjrlBF7k
   wzcOSbJ88onoA0DL60683XwjuzjmEOKTaX3Vtrq10xzG8jj5AcW8NUOYu
   G2pmfbNqoOpat7m5LxxZWbk1YpjC5mzR6dFbaNii6p8Q/7n+OYQvilVPd
   9+5MPfP724j5uVxnkudVefObMxF76q8RIryDYJcgE65P+tXd41g1Cxa66
   DnxFpTvWsnzi9dPLuJ91J/2TR+5J+JBuuw5fxNztk2JYTXl2Bqf5lQuEi
   g==;
X-CSE-ConnectionGUID: yaoyXLIKSW6SsS+DjOEsaQ==
X-CSE-MsgGUID: M6VQKEPyQYmIfyj6MZ2fIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22507238"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22507238"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:51:49 -0700
X-CSE-ConnectionGUID: j05WpTQ3RVKz/W2D0Z7U7g==
X-CSE-MsgGUID: 1qZv6PquTnuDk4GJIYY4Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65821584"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2024 08:51:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A918A268; Wed, 21 Aug 2024 18:51:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org
Cc: Tal Gilboa <talgi@nvidia.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] dimlib: Use *-y instead of *-objs in Makefile
Date: Wed, 21 Aug 2024 18:51:04 +0300
Message-ID: <20240821155140.611514-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*-objs suffix is reserved rather for (user-space) host programs while
usually *-y suffix is used for kernel drivers (although *-objs works
for that purpose for now).

Let's correct the old usages of *-objs in Makefiles.

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: gathered tags (Florian, Alexander), Cc'ed to Andrew to apply
 lib/dim/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dim/Makefile b/lib/dim/Makefile
index c4cc4026c451..5b9bfaac7ac1 100644
--- a/lib/dim/Makefile
+++ b/lib/dim/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_DIMLIB) += dimlib.o
 
-dimlib-objs := dim.o net_dim.o rdma_dim.o
+dimlib-y := dim.o net_dim.o rdma_dim.o
-- 
2.43.0.rc1.1336.g36b5255a03ac


