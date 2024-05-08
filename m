Return-Path: <linux-kernel+bounces-173400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839AD8BFFF9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B533B1C22B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3E85931;
	Wed,  8 May 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4q2EIUN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D642AB0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178650; cv=none; b=bA9WPnn1wXRhy55rX1xrxQgjpYGsFq6RQrrNn2OD5y5RoDLwL5Wz45OGETsO9ZiKZcKs5WgkmGJNlaMQzGtRoCUT5LtSB0U0YaPcaXoTc2hcj0jBgv0opQ6PW01wfm1sLba+dL4VxGvZTvBTm65AoBBb1+0l0zvuIXwEtdzkciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178650; c=relaxed/simple;
	bh=/xKK8HN/Q524pQNOyq68zVQ7Qa06UWnwbSgkLjRCzlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aT3WxdJ64I0IjWqDFYu/vMh5aHCqeUJulOtkz5Odg/GLT7wrusAFYpYU0NX9SE9uqLiF9sbRI7rV3QXSk4s04zNXd7jFvXM3jVhJUoPlZ3/bYJN7LAOOignEDn0AIjjJaZwqcil4fr3KS0mwEREXxH6HaHC6EcCD0qFylGR4pJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4q2EIUN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715178649; x=1746714649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/xKK8HN/Q524pQNOyq68zVQ7Qa06UWnwbSgkLjRCzlU=;
  b=i4q2EIUNKih7EXIUFOaspY8+o/5Q6HDvfsbtzo7ZbsciYRZG8pSUk9Xp
   tc22HqtWITJlvTS3g++I8xKP/c39JL6yWDL7U93u6+uDw+yLW3eN4JG6+
   iHMmwo97ip5BznNONT/pUn+BTFVMnHMIwMY/hgqB1IfUbW0k9unL/5Ek5
   LpYMF5zEcltkrtW00Nd63RaUFluBN8maMjQbCREfR9VL+wddZhOV9K8hN
   bNh+C+lIWMb8VRT49gOfyiyQz8pTUzpTNwxxm8FpnghsehIg/oWK19KqI
   Nrqd/tFkCM5fL9L0Nlgl9u3CRee8QC/GZu0tyFsXnu95jfs2NeN/Yaeq/
   w==;
X-CSE-ConnectionGUID: c1u2/hxrRQSlqgy8tvF/Kw==
X-CSE-MsgGUID: AFfXzieJTBWp8pQsrH8EgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10878493"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10878493"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:30:44 -0700
X-CSE-ConnectionGUID: oKjIC11AS9OIQLL6sWXUcQ==
X-CSE-MsgGUID: wEUnZmtQQAOCKzm4vYZxmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28835869"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 08 May 2024 07:30:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E70F8109; Wed, 08 May 2024 17:30:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Tal Gilboa <talgi@nvidia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] dimlib: Use *-y instead of *-objs in Makefile
Date: Wed,  8 May 2024 17:29:42 +0300
Message-ID: <20240508143039.1196671-1-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Reported by Olek. As I said him this is correct change which is
documented in Documentation/kbuild/makefiles.rst "Composite Host
Programs" (mind the meaning of the word "host"!). 

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


