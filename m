Return-Path: <linux-kernel+bounces-417060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11D9D4E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5411C281C88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC21DACAA;
	Thu, 21 Nov 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8/YLJ2g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB31D9A54
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198466; cv=none; b=K6rMSVKjYUtFcgEijcQKWcWeJmu3eHIK0tie/oP/qWea/bz7o8m9eFeATi+vss0EsukFb9+Yl7LUl2YL2Jby2HIscoIdsgIPwzb7dUdimJyBhuhybVgLHrOBYoXBeB2xK2SDvjA8TqNlUPnWl2VqN1hV1dyWlSPP+h315cek6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198466; c=relaxed/simple;
	bh=0Z0Bk3+OOSXoR947Kj1mRZrXpBGW7Ca+cVp3m+WsJqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhMh/FDu4R96AtyUgoxDV3he93ABs5121NAuJuhrlcTSJ4EZKIAO9SglzsWV0/kgdxlpNklw1atyatsqU3Sd5ApEQ1PXoE0rEeuWo3mv5cDn9vMK7nATyWWlhosUlpcER7OPrerDRjYKtfxxWT9EL5RL6J9pBqxjFqyICbb9zd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8/YLJ2g; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732198464; x=1763734464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Z0Bk3+OOSXoR947Kj1mRZrXpBGW7Ca+cVp3m+WsJqY=;
  b=A8/YLJ2gUDInuK+VzLQTYDiHwdn6B02uMm33JeW/JdSyk9VN107Bv+xS
   s08wVEpLNV+1o2x+MSksEtH+/5bOBTs3e/mzsFcesrdYAwmGvu0u8kZx8
   3wBIjupJ3ObZvdYV94GPFkJgDPMErMSyGLybfbMOmElnSM+VuW4C49SF9
   aL0FuKKZ6MKo/xpzET3U41VSz7VTuXOZkEwyf+jROFbvALEg7abUUuLml
   XX9pvv6QEWmkFz2Wp97IKGPY7XJrk0dw7iCGwCCtvdtUvS/NENWCytdPn
   3LVptj/uPwM3zGXQmCA77QZNU5+yju4eflOSe0szY4lac6nHSqt8WI/3h
   A==;
X-CSE-ConnectionGUID: mXljsFMxSEaIkzQNaJbg3Q==
X-CSE-MsgGUID: jFi8YYXQQ9mXFHQ5Blb3zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43707186"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="43707186"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 06:14:23 -0800
X-CSE-ConnectionGUID: aqkPYLhlRLObQJvhxtAwrA==
X-CSE-MsgGUID: Z2NK+wbrQjSOaHZdZYG+lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="89867605"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 21 Nov 2024 06:14:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 23EFB18E; Thu, 21 Nov 2024 16:14:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2 2/2] kcsan: debugfs: Use krealloc_array() for initial allocation as well
Date: Thu, 21 Nov 2024 16:12:52 +0200
Message-ID: <20241121141412.107370-3-andriy.shevchenko@linux.intel.com>
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

Use krealloc_array() for initial allocation as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/kcsan/debugfs.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index be7051d0e7f4..ac31412de646 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -145,6 +145,8 @@ static ssize_t insert_report_filterlist(const char *func)
 {
 	unsigned long flags;
 	unsigned long addr = kallsyms_lookup_name(func);
+	unsigned long *new_addrs;
+	size_t new_size = 0;
 	ssize_t ret = 0;
 
 	if (!addr) {
@@ -156,18 +158,12 @@ static ssize_t insert_report_filterlist(const char *func)
 
 	if (report_filterlist.addrs == NULL) {
 		/* initial allocation */
-		report_filterlist.addrs =
-			kmalloc_array(report_filterlist.size,
-				      sizeof(unsigned long), GFP_ATOMIC);
-		if (report_filterlist.addrs == NULL) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		new_size = report_filterlist.size;
 	} else if (report_filterlist.used == report_filterlist.size) {
 		/* resize filterlist */
-		size_t new_size = report_filterlist.size * 2;
-		unsigned long *new_addrs;
-
+		new_size = report_filterlist.size * 2;
+	}
+	if (new_size) {
 		new_addrs = krealloc_array(report_filterlist.addrs,
 					   new_size, sizeof(*new_addrs), GFP_ATOMIC);
 		if (new_addrs == NULL) {
-- 
2.43.0.rc1.1336.g36b5255a03ac


