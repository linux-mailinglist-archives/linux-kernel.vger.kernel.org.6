Return-Path: <linux-kernel+bounces-350110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359EE98FFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1011C2329E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDF01487DF;
	Fri,  4 Oct 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGYUE0fD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20169146D6E
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034878; cv=none; b=FwjsdYqSQI0BUMV+cK/zkpu+jk+Ih974rqvmPj6T4ADOkU0EU51b+FcP5YPOwwXELTe1OBseMM+8ki3na+2RUUUgXezm4pfx6UnWAkV6vXXvq8Rq1B3P7b6/Cd9Z7Wz6WtrCqc0waL4vmscZ4C1WtRRRqi27GFN2axyNW9rz9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034878; c=relaxed/simple;
	bh=LoDMn8oLI+zmmSeepH0FlORxx4htN8CLZ9oCrZyMwF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Si5ynUVjr1tBStodFXzdhNCJ8SkDxGWY8hr0QfVkOJA4KdD21ZoAJrgu1tOny80O3eQ6m4tw3Vcd8cfwbiftxVG/EkJQT1iAQifHdqijXMj8HHuqrqgAST4x5xNdiin//9hPq/ed8RhC7lx/7fxRK1AujChj66Mi+9L70Xu51JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGYUE0fD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034877; x=1759570877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LoDMn8oLI+zmmSeepH0FlORxx4htN8CLZ9oCrZyMwF8=;
  b=LGYUE0fDmfA/P6v0O1FOUFCtJycna906cpwfatmO7kKrwHc5eb9SyX1Q
   XQSSyrfEbsGHD5+06fVTL67hQui/1YK4BuH1ZyvpmAqomF073pbaDBBF9
   +RVE6t79lVlp8F5GhRJdaF1CBQ3+lqPbqlIvdLfOaWPhhkP9tazmI6NA8
   sXiDF6c+X4/XxkPw3g+rU0oo8bZv8VFaJcE+6vvJUS6Z+L5laWzy0QNTh
   rD2sqzQoQKr099ncf6z3VSn5EnhVsS+lX3ZTNLhEeajeT2Ib4DXonjXa2
   nMxKCY4Dkim31NEqv3CGoiZ+0hfRQwbDyVwu9xfN36fj0r1I4uA3MNH73
   w==;
X-CSE-ConnectionGUID: M3nDOSKEQ2m0Vm6ycRYaXw==
X-CSE-MsgGUID: vkpdw9XcRIySdMdzJes4oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37856174"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37856174"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:15 -0700
X-CSE-ConnectionGUID: M/n8WbVXT3WYq35x4ToFVg==
X-CSE-MsgGUID: fIizvODVTaWkUwz8Jed71Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74331920"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:14 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id D31B21203FA;
	Fri,  4 Oct 2024 12:41:11 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoB-000TVZ-2j;
	Fri, 04 Oct 2024 12:41:11 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/51] hwrng: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:11 +0300
Message-Id: <20241004094111.113419-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/char/hw_random/cctrng.c        | 2 +-
 drivers/char/hw_random/omap3-rom-rng.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index 4c50efc46483..87288e14bf5f 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -99,7 +99,7 @@ static void cc_trng_pm_put_suspend(struct device *dev)
 	int rc = 0;
 
 	pm_runtime_mark_last_busy(dev);
-	rc = pm_runtime_put_autosuspend(dev);
+	rc = __pm_runtime_put_autosuspend(dev);
 	if (rc)
 		dev_err(dev, "pm_runtime_put_autosuspend returned %x\n", rc);
 }
diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_random/omap3-rom-rng.c
index 8064c792caf0..e2b95f0d34c6 100644
--- a/drivers/char/hw_random/omap3-rom-rng.c
+++ b/drivers/char/hw_random/omap3-rom-rng.c
@@ -57,7 +57,7 @@ static int omap3_rom_rng_read(struct hwrng *rng, void *data, size_t max, bool w)
 		r = 4;
 
 	pm_runtime_mark_last_busy(ddata->dev);
-	pm_runtime_put_autosuspend(ddata->dev);
+	__pm_runtime_put_autosuspend(ddata->dev);
 
 	return r;
 }
-- 
2.39.5


