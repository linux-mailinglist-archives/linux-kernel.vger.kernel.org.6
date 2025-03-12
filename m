Return-Path: <linux-kernel+bounces-558387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB81A5E52B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90053A3FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767D01E990B;
	Wed, 12 Mar 2025 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icDHNfyl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3991EE7DD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810617; cv=none; b=uB052s5v4wqdNEsSLRRHEUO8Wy9v20lZM458XZ5fU/qoRUzFseavzhcsdFpe/r14B4SiskqmeFCqKWiryFSH7/JQx7LUC+v1DG4gpnGjwL9gDQZbebdDApegkY/8qYBu0vwriDSR+ML5KtIP+hB8Iq2inx3XN/Uve/Shx2xT8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810617; c=relaxed/simple;
	bh=LdXPczmAvLFOtdsRAuqJEfZQmT1DM6lFW14qyWC1FHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZZQZOFI8KFBaU/mbrmHHiJnBq45cUDSN5fKlXl3sFKLaRPU2nbUoGyuib2blnGyrPKQRVUvoNIOGwr8WdzbkA0k7jHQD2+dkNExNWAML9j3xkQmsddv6a/2keOzDjOVflEhER2q4Y8Gg6hmuDs/h7cfTrqW3qKISQt24uOthYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icDHNfyl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741810616; x=1773346616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LdXPczmAvLFOtdsRAuqJEfZQmT1DM6lFW14qyWC1FHo=;
  b=icDHNfylFkOMWyhi45M+zDl/BvkaeCwSU9WKHuo7AvC36bfWJ9oB0mp9
   dR2Ec7A9kEVxLTZTUbKvGc+RRPiVGwMy4PQfzQzzfmW/Y25371HXRcsxu
   m+W5Xpi9Jfhif/FBuWIGu9RVOn23k+gtuKyDejijJiF3Eq1jb+klTMxa3
   sAWVDRWeGbQEAmcBiaXS95LQznnepx7gI2+ip98pOBUrG4lRXf2M9NSlg
   5IhHI/K5yfiK9kn+NC9cUn2PJZNA/rPfll9js0UpCqyc6uIt7nfRBGwku
   jaxk/6CsuPSNJx5Z6MAY+mGXCkAoi4VXkWahZ8yjaBkRTPR09um3r8yTb
   w==;
X-CSE-ConnectionGUID: mtNe+iGlS+SkjsHo4Dclcw==
X-CSE-MsgGUID: Wrfn2kQnQy23a01awh5ywA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60451918"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="60451918"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:16:56 -0700
X-CSE-ConnectionGUID: 2GApYVQCRt6Zs/NzK1RSlQ==
X-CSE-MsgGUID: 1TuaK3NvT6evsUOJYk6neQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121242351"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 12 Mar 2025 13:16:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5A33D1F2; Wed, 12 Mar 2025 22:16:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v1 1/1] mtd: mtdpart: Do not supply NULL to printf()
Date: Wed, 12 Mar 2025 22:16:49 +0200
Message-ID: <20250312201649.217555-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compiler is not happy about NULL being supplied as printf() parameter:

drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]

Replace that with "(null)" to fix compilation error.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mtd/mtdpart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 6811a714349d..6f7e250ef710 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -691,7 +691,7 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
 			if (!parser && !request_module("%s", *types))
 				parser = mtd_part_parser_get(*types);
 			pr_debug("%s: got parser %s\n", master->name,
-				parser ? parser->name : NULL);
+				parser ? parser->name : "(null)");
 			if (!parser)
 				continue;
 			ret = mtd_part_do_parse(parser, master, &pparts, data);
-- 
2.47.2


