Return-Path: <linux-kernel+bounces-396954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AFE9BD4E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AB71C22882
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863F31F4FC2;
	Tue,  5 Nov 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jg7Xlx0q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEB1F4733;
	Tue,  5 Nov 2024 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831926; cv=none; b=P4jKTOC1w92+Qwpc2ltGOLPRy1bdUmPVggYFCp4AXV4DrL04A5tnskonQntYn0brUUxT/fmw914tQOpy8gJKIgMf+GJaguxy3lwe3l4RtgoG7d7uQlWgynPqr5A7FkZYysbScqUIw01V758tdPcDbjx86WR7TCe0AOqYIQZm7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831926; c=relaxed/simple;
	bh=75BXQWBlu1qm/IwTqsytAV/le/RP7NEqiwLIaFQMfE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVhI5xVXHRhyjYdolkRoSfGlOudKKjnMvAADqiDx2ZSo3bd7uRrxQHqD0tZkUyBVSyNs8G8wFL6GK40ha9uZ+WYYFxUTpWr5shH6If4/U2AWlX5iWcCncrqAAshaLjPVIS6AKbgKkKwmKPGNB1+rA7j95KoAeicFsa9XtzYzwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jg7Xlx0q; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730831925; x=1762367925;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=75BXQWBlu1qm/IwTqsytAV/le/RP7NEqiwLIaFQMfE0=;
  b=Jg7Xlx0q2DFaasfESVcRdgl94dzPXcAXU8UxXk0iSIPxbudli7OxpyCK
   WnGuy3NN5ZHJxnWpMd1324p2ATTgU69YirxJF+eamjwxhFxRSYDGTWxWe
   2xQFwdUyzEgu9YxXPcD5VqbRmQULBVoPWCj3KWFBr5BywM6+96hl0QsPk
   fvXupx4mw+Ro0fwZN3R0myrKv6nWGG9iz9XZ67i3wcRxqTFC9BzeBgTP7
   3tkIPYjnf9J+V3ArmJNvAR9EiCybWrEVDbXPHxf6NPL68HeEZ0oFNckxL
   tWLxXFYnQfU6IHSSms9vFU/C9fmkc5uDXaTjH74t1Ie3T22HPDCZsUaoO
   g==;
X-CSE-ConnectionGUID: nH/mTx2dQPCwk5qZN4Nipg==
X-CSE-MsgGUID: 7Kh5YFw0RuG87/Q1X6gkSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41153118"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41153118"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:38:44 -0800
X-CSE-ConnectionGUID: 8QPtAFruTISacKlLAoB7Yg==
X-CSE-MsgGUID: cCfp5t7nQcS/PGkyM1EiAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84235664"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO localhost) ([10.125.109.247])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:38:41 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 05 Nov 2024 12:38:28 -0600
Subject: [PATCH v6 06/27] cxl/region: Refactor common create region code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-dcd-type2-upstream-v6-6-85c7fa2140fe@intel.com>
References: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
In-Reply-To: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
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
 Li Ming <ming4.li@intel.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730831904; l=2691;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=75BXQWBlu1qm/IwTqsytAV/le/RP7NEqiwLIaFQMfE0=;
 b=k29Apd4ClqH1JuVDrDNnd9iMT8uzD+HyCz7SeFbm3JzphFlM1PK7HQedNNwUUc0AYP5psaYch
 V5Cyxus/0GPDU9lj4cn/5NHisJL5Go4SEvJvLLdDrvo6rhE6sfZjZbb
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

create_pmem_region_store() and create_ram_region_store() are identical
with the exception of the region mode.  With the addition of DC region
mode this would end up being 3 copies of the same code.

Refactor create_pmem_region_store() and create_ram_region_store() to use
a single common function to be used in subsequent DC code.

Suggested-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming4.li@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/region.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e701e4b0403282a06bccfbca6bf212fd35e3a64c..02437e716b7e04493bb7a2b7d14649a2414c1cb7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2536,9 +2536,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
 }
 
-static ssize_t create_pmem_region_store(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t create_region_store(struct device *dev, const char *buf,
+				   size_t len, enum cxl_decoder_mode mode)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_region *cxlr;
@@ -2548,31 +2547,26 @@ static ssize_t create_pmem_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
+	cxlr = __create_region(cxlrd, mode, id);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
 	return len;
 }
+
+static ssize_t create_pmem_region_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	return create_region_store(dev, buf, len, CXL_DECODER_PMEM);
+}
 DEVICE_ATTR_RW(create_pmem_region);
 
 static ssize_t create_ram_region_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
-	struct cxl_region *cxlr;
-	int rc, id;
-
-	rc = sscanf(buf, "region%d\n", &id);
-	if (rc != 1)
-		return -EINVAL;
-
-	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
-	if (IS_ERR(cxlr))
-		return PTR_ERR(cxlr);
-
-	return len;
+	return create_region_store(dev, buf, len, CXL_DECODER_RAM);
 }
 DEVICE_ATTR_RW(create_ram_region);
 

-- 
2.47.0


