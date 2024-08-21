Return-Path: <linux-kernel+bounces-295850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48295A211
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBBF1C2385E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C9314E2EF;
	Wed, 21 Aug 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aE+2ta93"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144DE1BAEEE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255328; cv=none; b=MvLIu4GnYxPDGCOzL3gMTPokZGX/xUX3Vp+xhhe82wbbqLmGMQ6L3l0cCJLm8QhgJ6UaePBSHqO3OLAvs1CUQfH6qcQ5ls9nugYZphWvCUmBIH57gancqjJEYh3Zs8IBGuCZnuMxZDEuo/hIFdVSn9Z7b3XfDuYAAzGryeDS4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255328; c=relaxed/simple;
	bh=wTr9OwyVYoEGd6pIaHciUj5C6cu6tfettl9Td7ydvdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clq0fp0EcgHqYd3j1AoibyLGjhHMO99O8EoS2xK6woXI0t2HfcO2wekNgflSSyskst+nzhOdj92N8+ryTiTkRbMo5fI3NbLwzlZuNZZhG+jbpww7e19ZNPt+1QTkkJQeGJgBcKMRQXyu0Yo+le6PcEUilpsu9/XibwIer/y2fO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aE+2ta93; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724255327; x=1755791327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wTr9OwyVYoEGd6pIaHciUj5C6cu6tfettl9Td7ydvdA=;
  b=aE+2ta93ZZEcNULYRlEDCcXEKLVxkDLunCLCIYHUxAAjuEKHiEXMteC/
   TOjabDPmS15ltENc66etoo0kJYf/mHzqnc0h6md4DekBHH2pHYFeFhmzC
   chs9e6WfDjfvHiRRBudiYNYwbv5fMLWzgG6w4Dx8urHF6Puu6kLyhZEAi
   xtETMFGykFb0uY7XXQIoD3WLN6lFS/SqMygP6pnnCC+ZLCdOsuD8GtjIB
   Z5ebdG4CghzPjmzuP0RQBj0bnGLSL8IC7xh2+8u7mPCHVD7saAhyHnyiO
   ZDrBASa/he7bhruwV0Wu68+WVKHZeyJLVk+zdaJVQq0vDkkD/6p0pezNQ
   Q==;
X-CSE-ConnectionGUID: Mkn5kSC/RE2Caala2l40mw==
X-CSE-MsgGUID: 24kbc43gRc65y6MWkAKAmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26376287"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26376287"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:48:44 -0700
X-CSE-ConnectionGUID: w1Fo7pkPS2+Cpn1erdWtpg==
X-CSE-MsgGUID: yhQkbyajQzeF85TjNg8Zmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66080306"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2024 08:48:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 30BCC719; Wed, 21 Aug 2024 18:48:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] driver core: Make use of returned value of dev_err_probe()
Date: Wed, 21 Aug 2024 18:48:22 +0300
Message-ID: <20240821154839.604259-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
References: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of assigning ret explicitly to the same value that is supplied
to dev_err_probe(), make use  of returned value of the latter.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bff5e53ca0ce..1e5d7f9bc4f4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1084,10 +1084,8 @@ int device_links_check_suppliers(struct device *dev)
 			}
 
 			device_links_missing_supplier(dev);
-			dev_err_probe(dev, -EPROBE_DEFER,
-				      "supplier %s not ready\n",
-				      dev_name(link->supplier));
-			ret = -EPROBE_DEFER;
+			ret = dev_err_probe(dev, -EPROBE_DEFER,
+					    "supplier %s not ready\n", dev_name(link->supplier));
 			break;
 		}
 		WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
-- 
2.43.0.rc1.1336.g36b5255a03ac


