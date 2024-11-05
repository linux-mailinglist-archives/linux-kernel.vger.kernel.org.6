Return-Path: <linux-kernel+bounces-396951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26F99BD4D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07D1284107
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C70A1EF92D;
	Tue,  5 Nov 2024 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FT7Wx6aK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814F1EC006;
	Tue,  5 Nov 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831918; cv=none; b=K22wb7tPc/9k+JmTclhQZTr5FYlRZBL0aU6qaE2y2+WRLYIyqJYGr8zSBjGadk5YUKtO3jToeUhXB68gQCUKGJEI0pelxod82O3jQqIoFz4gc/CiMs3jEzVPENAyAyfpKaE3REWo49DdCme6EZaxpJzcPZQjmCdKuCYe9yYUfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831918; c=relaxed/simple;
	bh=whk51TLvCUMpkOxwHO3pcJKiWlya46CdptjgCbtvUgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5043ewaGXDQNuZQQAilJy897liZU2mZJPay/RdGDboolcmG6d8kLe+G7L0KlKYPIQWQ55Kxu9fBIZGsnPKv521jFoAC+EmoES5FQl2cZjvtqqsiaE1+6hbRfr7K+rxm2xlwE+0Qfdw4mtRSjEIJgVkfu16HV8S6eV+0OUrfJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FT7Wx6aK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730831916; x=1762367916;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=whk51TLvCUMpkOxwHO3pcJKiWlya46CdptjgCbtvUgM=;
  b=FT7Wx6aK4C1Nt5SQnF+pryEoyBAvDZVBAv+5a7L5zMTT5IC+F4Y/dxiu
   wa/8h/YdO2VYHUrY3yob0tp++8+Xvcd2VFBcC74q5lsnNrDJkaN7d5CnH
   c7irREIIm6yLPxMns6e3eIGzJ9mAg4n1lQdcEBeYGcgwvmv1HaDqdVWOZ
   /Gm4ndMQ8s3oxS5RsQ6B9po0p9C00ZkNcYwDTVQSGlFWY9D0gkNTG5nlu
   OssavlXNQRIul7n5fwNkpQBNK2fqekD0YKwR1Ax0Gvyo7EhzzSrbJzLj7
   JihsmsAVnYCIhFkiToW5fpgvEHBBk2LJm+01WXucMs7GCQPWpEKuGcRQR
   w==;
X-CSE-ConnectionGUID: 2ZVGdjsNT+aaJs450TN+UA==
X-CSE-MsgGUID: Y57cQ+EIQ7Kdgo9ulNxorw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30708396"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="30708396"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:38:36 -0800
X-CSE-ConnectionGUID: YwW5vf54TNONWf/+iX16vg==
X-CSE-MsgGUID: ss5BpfGzQvyrU7ri6ljULQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84948702"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO localhost) ([10.125.109.247])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:38:35 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 05 Nov 2024 12:38:25 -0600
Subject: [PATCH v6 03/27] dax: Document struct dev_dax_range
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-dcd-type2-upstream-v6-3-85c7fa2140fe@intel.com>
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
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730831904; l=2274;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=whk51TLvCUMpkOxwHO3pcJKiWlya46CdptjgCbtvUgM=;
 b=Rm4Ob2itVxjxMvcSay6Bso3+CYnO711SVHsGb5h//nu5hGxLmzu2dSt7oNKTDBuuSUuiPE53s
 LdVbcjA1zBGCoFX67M8hVuWjKgfXPlMzSVLDHvfEdA+mNhI7aLzQSt5
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


