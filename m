Return-Path: <linux-kernel+bounces-400628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACAA9C1038
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DC11F23DEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAD2185A3;
	Thu,  7 Nov 2024 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpQbZiYU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C821949D;
	Thu,  7 Nov 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013118; cv=none; b=agr38qXsalR8zT0svmB5S6AcuBhWL9sOQ1qQo8Fp6iGYcybEDazmUPkenQsavmCFZUURGZ36LZ3b3cvE5BRhbfc3DsMMKFRjKBtSB2R/EY9jFCk1daSZvVZzOJlxgj/lT2zkIDsO6pvjsb/3rc0UOiN3Amx9eiJnVcb0Mx3ldMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013118; c=relaxed/simple;
	bh=gfJbRpeGKgtSOBlBPI7Q67kRAUKRjyjICp8gVsI2eFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DaQjWr4uFpzgpTIzFQt2rBjcDsTh/GL8mppPYrhXF/Q4NPvRK/4X1h/NFpyqN31oeZDfPs2xcADRGdfcfcloAM6T7yMHecAgg9wxr54BB4FouDxn6Z3AX/B8/32ZSWu4ViaySG/PS6tLosq7F3N4cRQdgxPhQt1VsdoeIbpuPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpQbZiYU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731013116; x=1762549116;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gfJbRpeGKgtSOBlBPI7Q67kRAUKRjyjICp8gVsI2eFA=;
  b=DpQbZiYUrPllCpNfB5vIUFB1Zig53suCnCzIc4CN5/TsJ7ARX+8RJ01Z
   AEcE2I2AKl9kUbSXHc5BMzj9ovsmtY4CjzePoWLZ5mjSsafeafPDDl/Nv
   S3nGy+22X2g8UJejuhgigi1CMBNdNEJYJGpzvvoTaSCmbnuh+zEe6JCvx
   X/TI9ary6tN9jeM75FfVtpai5bklgMQ15qMb8PoT4bWm3KDQG3+DtWRWm
   H4O45gZxdpov3EMBD9xUdCWz5rj5oA+EQr3o7c+iSKsB2R7zq5xByLL02
   MGUBVUg0+X1l1QIpJX9EABuZ+WaFkx5OMiSFDoTpiupU+QXFOP3mnaa5D
   w==;
X-CSE-ConnectionGUID: +hYNa8a9TqS2L5/AwAurbA==
X-CSE-MsgGUID: rLoJXOpFTkOblC0iSnDOKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30300326"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="30300326"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:36 -0800
X-CSE-ConnectionGUID: CbT4nUaOREyMUgU37MZcKA==
X-CSE-MsgGUID: xgAhoK7bRQa1u/6kgzT8Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="90093595"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.195])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:34 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 07 Nov 2024 14:58:21 -0600
Subject: [PATCH v7 03/27] dax: Document struct dev_dax_range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-dcd-type2-upstream-v7-3-56a84e66bc36@intel.com>
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
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731013104; l=2335;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=gfJbRpeGKgtSOBlBPI7Q67kRAUKRjyjICp8gVsI2eFA=;
 b=g3T3ttDcyk15iq52gDRXIKCO20CiEumkB8taNJNZgHrtuiZhv6fJpwUEGDflcnd6EXWJjFGS6
 4goDnO8EN1HCHxPIEqRcocUOjzXr7XZaXDtXz2OyTDfS4zkgBiisIPY
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The device DAX structure is being enhanced to track additional DCD
information.  Specifically the range tuple needs additional parameters.
The current range tuple is not fully documented and is large enough to
warrant its own definition.

Separate the struct dax_dev_range definition and document it prior to
adding information for DC.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/dax-private.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 446617b73aeab2e6f5a2ec3ca4c3f740e1b3e719..0867115aeef2e1b2d4c88b5c38b6648a404b1060 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -40,12 +40,30 @@ struct dax_region {
 	struct device *youngest;
 };
 
+/**
+ * struct dax_mapping - device to display mapping range attributes
+ * @dev: device representing this range
+ * @range_id: index within dev_dax ranges array
+ * @id: ida of this mapping
+ */
 struct dax_mapping {
 	struct device dev;
 	int range_id;
 	int id;
 };
 
+/**
+ * struct dev_dax_range - tuple represenging a range of memory used by dev_dax
+ * @pgoff: page offset
+ * @range: resource-span
+ * @mapping: reference to the dax_mapping for this range
+ */
+struct dev_dax_range {
+	unsigned long pgoff;
+	struct range range;
+	struct dax_mapping *mapping;
+};
+
 /**
  * struct dev_dax - instance data for a subdivision of a dax region, and
  * data while the device is activated in the driver.
@@ -58,7 +76,7 @@ struct dax_mapping {
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @nr_range: size of @ranges
- * @ranges: resource-span + pgoff tuples for the instance
+ * @ranges: range tuples of memory used
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -72,11 +90,7 @@ struct dev_dax {
 	struct dev_pagemap *pgmap;
 	bool memmap_on_memory;
 	int nr_range;
-	struct dev_dax_range {
-		unsigned long pgoff;
-		struct range range;
-		struct dax_mapping *mapping;
-	} *ranges;
+	struct dev_dax_range *ranges;
 };
 
 /*

-- 
2.47.0


