Return-Path: <linux-kernel+bounces-400630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341D29C1042
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF5C285D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D6721A4D1;
	Thu,  7 Nov 2024 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBngy4r7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213D21A4B2;
	Thu,  7 Nov 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013123; cv=none; b=sJzjKnZemUcbVsqHprccSy7L7U/0zHb1k5UY0DRrus/rPQ1Yu2dEegTNP+aiA6YFRrJLs3AwnOErTY2eTqJYNjBplHMZ/a+CN44SX8mqxsn8y99EgiupXNfiZh3s95CYTKgBgivqVx2mb26JBgZtUC9mjDHBesDaqbt33XzbtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013123; c=relaxed/simple;
	bh=LLABFCK37K/MhI03Fb+yWDspPbVRYojKovJHMZlMT18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RScxpfpArGZmqJ7zc6qNw7YTvvCfExvHDE8Lyf69g5d40QgA/gY5uhhgmcn8D0dBx8gifF7thAWAAviBSDHBquL4/E1zpUV3MPNzZEoBDEeNIQZbJkDdkHSe900FfnzVcpVBmZHO3cSCegppn6Ww6XO2Gu8ASpxznV8oQdmFgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBngy4r7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731013121; x=1762549121;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LLABFCK37K/MhI03Fb+yWDspPbVRYojKovJHMZlMT18=;
  b=EBngy4r7C/0UL6wwpjoY52Fa8iVcWxMESdGi0Y5LXfFfw/wpY8+LrZsv
   hgZ7yLbXaNBfMj2zcvaByXvcmlYP9vUEBu1SH6xOLAkyJLD8yLDp+n4RD
   DMYtSuOQpS0HpjB0HShIostxUuaZut7C1F187VW8uhWam1VXVve9yzZ3j
   3bgh8QfkhLrNfMme0RuuL3P0RZHLOAI7PfDWUU+Y6VTzOaC82/6SmEXE8
   3Q8sTCJ+lRlsX+cgHZC5GF3ZLu+M46Eh5Muhe5Z4uMO1PfUH+FYP2jcCQ
   8SNqs1jkQG6fcJa2jBjcOt2sh2bzEOS3YBbKb9OzSjtHra1+kzTVOuNJY
   A==;
X-CSE-ConnectionGUID: 6VX5jqEGSIuNM16iUwVI4Q==
X-CSE-MsgGUID: aotUn4zTQfGFfnNRWeo4/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30300346"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="30300346"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:40 -0800
X-CSE-ConnectionGUID: xley0tb9TqmmrYTciajhvg==
X-CSE-MsgGUID: Elgy6iYITy+D1y1G1ytgwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="90093610"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.195])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:39 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 07 Nov 2024 14:58:23 -0600
Subject: [PATCH v7 05/27] cxl/hdm: Use guard() in cxl_dpa_set_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-dcd-type2-upstream-v7-5-56a84e66bc36@intel.com>
References: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
In-Reply-To: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731013104; l=2085;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=LLABFCK37K/MhI03Fb+yWDspPbVRYojKovJHMZlMT18=;
 b=KTcY7j4rhCzvnM1flH25sLGGRrHai72moyRVs3M3OOBwZWfMePnYfpNpfn3tgljCtRSzEsOVY
 lwwB8i4cSrTBiC5yPlyvg67b73nsnM3cQVJybLSEjTwljuABas9fTGT
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Additional DCD functionality is being added to this call which will be
simplified by the use of guard() with the cxl_dpa_rwsem.

Convert the function to use guard() prior to adding DCD functionality.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/hdm.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3df10517a3278f228c7535fcbdb607d7b75bc879..463ba2669cea55194e2be2c26d02af75dde8d145 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -424,7 +424,6 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &cxled->cxld.dev;
-	int rc;
 
 	switch (mode) {
 	case CXL_DECODER_RAM:
@@ -435,11 +434,9 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		return -EINVAL;
 	}
 
-	down_write(&cxl_dpa_rwsem);
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
-		rc = -EBUSY;
-		goto out;
-	}
+	guard(rwsem_write)(&cxl_dpa_rwsem);
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
+		return -EBUSY;
 
 	/*
 	 * Only allow modes that are supported by the current partition
@@ -447,21 +444,15 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	 */
 	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
 		dev_dbg(dev, "no available pmem capacity\n");
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
 		dev_dbg(dev, "no available ram capacity\n");
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
 	cxled->mode = mode;
-	rc = 0;
-out:
-	up_write(&cxl_dpa_rwsem);
-
-	return rc;
+	return 0;
 }
 
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)

-- 
2.47.0


