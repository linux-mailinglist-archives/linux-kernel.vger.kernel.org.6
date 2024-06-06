Return-Path: <linux-kernel+bounces-204723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94338FF2CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E11289F14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCA198E87;
	Thu,  6 Jun 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtF2O/A4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B33198A16
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692444; cv=none; b=Wj+U3Vv1zPmEdLq0+2AKXnwkIRnAaxPFt798xEFKitZ+hGTVeohZFO3yH5+ix+tRVMKNfmbi9sdesVHQcpLnyZfVsLLVzdEJsQr3U1GPq19p4Af2YBnLnr0JZFQ7JiGjkCq9l9Yd3bar7DdsD+Vj7feIj59xm5MLY+b7V0/oiLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692444; c=relaxed/simple;
	bh=EHAguvGTDCaazxEec7Y5c7L9Y24xpgClBLYrG0xPN+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIc1ffXO+M2X2u/Y7Ml+NUa6wEqWDpRfWTR6xLb85YqFuC4Ly3rBbcvgvgJFafJSJ75eFF8l2k/9rbpxlpBqvdKT19F3eIJ3wBqR4kndBmKn1qwC5+wTV2Lv2KVZWcELpQVN6zHbQtQwOZtEVmrt+cM1lLZNvvizddS6NI29SG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtF2O/A4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717692444; x=1749228444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EHAguvGTDCaazxEec7Y5c7L9Y24xpgClBLYrG0xPN+k=;
  b=TtF2O/A4YLzlmX4N85nl/0NZ1ampcCsS9DcJhqrkaCUztcjtU9RNpMsN
   MR5aqBjD8Y3bdcrLW0Rq2Ephirp7c25urZ0OpK+rjRAryZJWCbFEp3y0r
   GnJUt90dcLKxva4IUeOdmiG+b62DAige3aJbqWuyKMWtqCIM58RzdljaJ
   TLdjJyrO/d4AwsI0B/QcD5L57JNUYRLKInrcd/UzCfiK8ZfJRXwVPovF2
   gOAJXTEGg6cG/xywwqAr/DEDtPnnXxP5KlUo58g3CCMXwy3Jd5OxI5AFN
   i+twgDQtCAVOQ0ZA29COTyFITvCuT7WtUZtJpKHCY+dyANWQo6wyZWLQ4
   A==;
X-CSE-ConnectionGUID: Fw+TYToASoy2DQlzYfRlBQ==
X-CSE-MsgGUID: 9fBgO9Q5QEeLaSfeZDdEzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14531937"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14531937"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:47:21 -0700
X-CSE-ConnectionGUID: PbcrPNtRS0+QLHOHEzBWOg==
X-CSE-MsgGUID: asaEZJvDRUSvP3Iy+e6qaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38475876"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 06 Jun 2024 09:47:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AEB871C9; Thu, 06 Jun 2024 19:47:18 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/4] regmap: Switch to use kmemdup_array()
Date: Thu,  6 Jun 2024 19:46:22 +0300
Message-ID: <20240606164717.3031107-2-andriy.shevchenko@linux.intel.com>
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

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0a34dd3c4f38..88c02b71b2ee 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2347,7 +2347,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 	} else {
 		void *wval;
 
-		wval = kmemdup(val, val_count * val_bytes, map->alloc_flags);
+		wval = kmemdup_array(val, val_count, val_bytes, map->alloc_flags);
 		if (!wval)
 			return -ENOMEM;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


