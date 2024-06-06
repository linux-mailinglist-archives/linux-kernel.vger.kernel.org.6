Return-Path: <linux-kernel+bounces-204721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99BB8FF2CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145D2289A5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47FE198A20;
	Thu,  6 Jun 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCZC9HVD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742B1E87F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692443; cv=none; b=ZMiaeKMSywAtspJBMSBP9mm7M3E4Z2UTlGB+CO2+CjEKY5ccqquWGyqFpF+Fdmjx3tPuc5W1U6yIXqDu4Xy8TS/4l7jWQ2t+uczlHluksHECUS39DmRIA8Iz35oLk3ipcQRq76K7GjQRUTsnLewphJYnzAcgl+2YuCBKYZbkjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692443; c=relaxed/simple;
	bh=QOAYhbWy+rWNPn1bB0ti3pyRKF4a9LVOkArl7dVvMrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHN7sK9h8Moy462cIh2dEcXlqWsmFjaxco4JqRdk1Mx9vLQoMJ7nZIQUBoMGUgnnvGIzKLstC9Tehl9Te8O/rOrSXmx9DD258bMiYnz+W4dxvzF7ExMbVsYzzUFbcT0zdoC8BSqwtEy6AbD2YzKj1j8GeM8tGmonBHuQMHc76Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCZC9HVD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717692442; x=1749228442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOAYhbWy+rWNPn1bB0ti3pyRKF4a9LVOkArl7dVvMrE=;
  b=LCZC9HVDnGhrUdaFkiMbxnZWufIHJOaSQ0FmsObRnRB3DiAc/twl13X7
   OkZ87pSTLviATQb4Kp+KXCYSsx7UwwQ8SRSV+Dx6nFtvI/qln0TEzTpGE
   J20kjTfk+5aesmgP7HEwxcbwey+4DjtBv7chqI5ab0DMS2YFeIOfB3tl0
   jOf7rq0NazBJkLKd5bPxHYXVD+iBRDHtX7KwlHXIEiO2YV1/gGooES4Zi
   hzcyW6TK/FFYF2MHCclkEhcTHIrw5u690iQQdrLxNecTv9ACUeLDRhBFT
   lKw0wi3K6izt8LWbxmCe0ftnTLbuemP2IvQhdDijMkX0JjO/N0XPwW1mr
   A==;
X-CSE-ConnectionGUID: THGdlaDVRze84W+87PZxYQ==
X-CSE-MsgGUID: le8N7KY9TbewEPsEYkzhOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14531932"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14531932"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:47:21 -0700
X-CSE-ConnectionGUID: xb1b+ml5RkedEVogHf1Urw==
X-CSE-MsgGUID: ZEHpW6pORb6gNozoa6dawQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38475874"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 06 Jun 2024 09:47:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C2DFD30B; Thu, 06 Jun 2024 19:47:18 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/4] regmap: cache: Use correct type of the rb_for_each() parameter
Date: Thu,  6 Jun 2024 19:46:23 +0300
Message-ID: <20240606164717.3031107-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240606164717.3031107-1-andriy.shevchenko@linux.intel.com>
References: <20240606164717.3031107-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiler is not happy:

  regcache.c:410:9: warning: Using plain integer as NULL pointer

Replace integer 0 by NULL.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 2e41cb12b8e2..bd7462c54271 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -407,7 +407,7 @@ int regcache_sync(struct regmap *map)
 	 * have gone out of sync, force writes of all the paging
 	 * registers.
 	 */
-	rb_for_each(node, 0, &map->range_tree, rbtree_all) {
+	rb_for_each(node, NULL, &map->range_tree, rbtree_all) {
 		struct regmap_range_node *this =
 			rb_entry(node, struct regmap_range_node, node);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


