Return-Path: <linux-kernel+bounces-559083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D67A5EF58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4674F17512D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF29264607;
	Thu, 13 Mar 2025 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5xHGUJS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F21FBCB8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857398; cv=none; b=jnoQU7Bt/APvYdf/MbMFPFRNSMiCuA+JGA1bYmXgKlPPLxzxa6G9TZZ63me6nDlddJSZV0RtksuxkkEAYZPyZXsrfK9GWlIsCPr7TWiPGCFa0QVV1t8hCqz+r2JbZl2sxOzIhsdPiPgUvlaQLlCcUUBp6YOGn7fzqq5nVZ/PYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857398; c=relaxed/simple;
	bh=OlHTnQoywCSCuoi3FTq6oim2FtxvRr3TSS7h7lgSzTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ibxq8fUTYSENqZMcoIJjk0CGKOhl8UmThJYZUO17GPR5Xjn/683f6dnsGg3vUZZtY6bjJSvpLT9erGlFzNyQRscJTMlOCWfQdPorW6cGU0ZStJ+K8BesABlg+ZAOKjVXumxwvPLIKDX0BVeH11PMoY1t/jWr9WotP7G8cUe5bDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5xHGUJS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741857396; x=1773393396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OlHTnQoywCSCuoi3FTq6oim2FtxvRr3TSS7h7lgSzTY=;
  b=W5xHGUJS9BiiPw0KdUuyZ8t3noMj7mJoAIFUtbCSBrHXqT8HJqMDyAR0
   JXRjc8w+XLewOEwWz+qKVZ7dWndyLGLtDplJkO76G1GjTHmib1+WnVUe9
   sHEpYPf1CZ14vmBldFNU1owAYGPZIDZslYTNCckYSyZ6AbkV2gkpruZeu
   fwS8ZYXZ/WsnLZZ81Lw2V9KMyQUhlKmW2ML7vRuMdVRaApdlFKu2X+kzA
   lFfHhIoEodrakUOJQ0e4tacM+cZmr5txKYF7nyJBaYLudAxQs3pBf8TnL
   wCTy/X/GtxbL92VW9YAlEhd1ZkBnwa3IUnXH2bag0xzulzo20RYqlTon1
   A==;
X-CSE-ConnectionGUID: oeKgCtYeS6Ce7gNAclpWNQ==
X-CSE-MsgGUID: G4HC79GzRX6HDWxfmmHn0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42994265"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42994265"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 02:16:35 -0700
X-CSE-ConnectionGUID: tgAyOsX5SHOFMeuHHdBVtQ==
X-CSE-MsgGUID: J6KkLHM6TOuyz/PUdGSjRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="151730926"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 13 Mar 2025 02:16:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D5EB31FC; Thu, 13 Mar 2025 11:16:32 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 1/1] mtd: mtdpart: Do not supply NULL to printf()
Date: Thu, 13 Mar 2025 11:15:53 +0200
Message-ID: <20250313091631.243346-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC compiler is not happy about NULL being supplied as printf() parameter:

drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]

Move the code after the parser test for NULL, and drop the ternary completely.
The user can deduct this since when it's not NULL two messages will be printed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: changed approach to remove that ternary completely, seems less hackish

 drivers/mtd/mtdpart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 6811a714349d..994e8c51e674 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -690,10 +690,9 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
 			parser = mtd_part_parser_get(*types);
 			if (!parser && !request_module("%s", *types))
 				parser = mtd_part_parser_get(*types);
-			pr_debug("%s: got parser %s\n", master->name,
-				parser ? parser->name : NULL);
 			if (!parser)
 				continue;
+			pr_debug("%s: got parser %s\n", master->name, parser->name);
 			ret = mtd_part_do_parse(parser, master, &pparts, data);
 			if (ret <= 0)
 				mtd_part_parser_put(parser);
-- 
2.47.2


