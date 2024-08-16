Return-Path: <linux-kernel+bounces-289811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33264954BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A935D1F24FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40621C0DF7;
	Fri, 16 Aug 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kH/EoOza"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669F1BE235;
	Fri, 16 Aug 2024 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817307; cv=none; b=mYw/gkqjnrNVmDXlJ59IXHTjqYL9ro4wcXn1q+OCz4r8Ylw9gAEC5BkBJvs+qGTbG/F01gzookRC54fMYgmDXWVJ0p4aW2j0ylUK7B6JhMXWUYoR1kq5Pj5fS75kNS/ZvMI/ixJGukceJGXhEzXUj+3neqI718LzCsVvosYjCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817307; c=relaxed/simple;
	bh=vZCrYDGgJsqWw4zWKqT6JaErepZLQw01/HjqmWA8bGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqBibxuUyO/T4eC7iyipkST/P82OcUnBgkm1pSDlBcy8bkVoYCdGh7w8Uv7LYt2Xy01N4nGuvxF/8GzkpHMi3yajSVy5iYLpCYGAv2s1GF7yJnA+O9jE5ADnr/Sl6V21ScNDvTYET8SRnW4gIWS2zqtFy69HxAtjJLZ1OFMf0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kH/EoOza; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817306; x=1755353306;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vZCrYDGgJsqWw4zWKqT6JaErepZLQw01/HjqmWA8bGw=;
  b=kH/EoOzanT0SDyIq5cS/dxUsNPnVHIAqKKutzqkvMtoT2lk8AUbL4I8J
   H9DTs3+BlLXVLZCox57akT4hWVmrFK8/nPtrD/TLGLEtjaP7NFBnM+7z0
   un9VDK6mD5aab/5/LNVLTL70rjx7C4q9KnzR/seOvWkxAKLlxfAM5Obnx
   oKFyC9qspIt1p5ginM2cxkme9f70Qy7O2dS4qIbOEAQt1vlpZGnddMuk1
   1UJnx/9K14cukyCjPBcx+Da/7tkkjGJ8XH1Qev20I82uOg1rSlLn4GYh2
   iPdkm0KFrVubyW34MQpmuhCICTJxeaPg1AJ8XMqEHtO80jO2zToNeYCRd
   A==;
X-CSE-ConnectionGUID: PNb+koRHRwCcN6tEnCaHaA==
X-CSE-MsgGUID: 0f7Fwt93RQSRCN0Iqk9MVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22260936"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22260936"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:25 -0700
X-CSE-ConnectionGUID: kBqN+tubT+mREEettzWBfg==
X-CSE-MsgGUID: CoP6vh28SWa8Ko/jAsD0kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59847818"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:11 -0500
Subject: [PATCH RESEND v2 06/18] cxl/port: Add Dynamic Capacity size
 support to endpoint decoders
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-6-b4044aadf2bd@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=14411;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=vZCrYDGgJsqWw4zWKqT6JaErepZLQw01/HjqmWA8bGw=;
 b=ukWikDPl1wcEi2l9/ZKbkCuj0q9VTJyfrif6LB+5oDRXKWTC0FTMwDdlYCREvYJrVhGlWcVro
 AIK0/BVe9A8D8Pe7xKjHupO8gY66yn9zx/yoK+c/rsLHVUvsDED4zgd
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

To support Dynamic Capacity Devices (DCD) endpoint decoders will need to
map DC Regions (partitions).  Part of this is assigning the size of the
DC Region DPA to the decoder in addition to any skip value from the
previous decoder which exists.  This must be done within a continuous
DPA space.  Two complications arise with Dynamic Capacity regions which
did not exist with Ram and PMEM partitions.  First, gaps in the DPA
space can exist between and around the DC Regions.  Second, the Linux
resource tree does not allow a resource to be marked across existing
nodes within a tree.

For clarity, below is an example of an 60GB device with 10GB of RAM,
10GB of PMEM and 10GB for each of 2 DC Regions.  The desired CXL mapping
is 5GB of RAM, 5GB of PMEM, and all 10GB of DC1.

     DPA RANGE
     (dpa_res)
0GB        10GB       20GB       30GB       40GB       50GB       60GB
|----------|----------|----------|----------|----------|----------|

RAM         PMEM                  DC0                   DC1
 (ram_res)  (pmem_res)            (dc_res[0])           (dc_res[1])
|----------|----------|   <gap>  |----------|   <gap>  |----------|

 RAM        PMEM                                        DC1
|XXXXX|----|XXXXX|----|----------|----------|----------|XXXXXXXXXX|
0GB   5GB  10GB  15GB 20GB       30GB       40GB       50GB       60GB

The previous skip resource between RAM and PMEM was always a child of
the RAM resource and fit nicely (see X below).  Because of this
simplicity this skip resource reference was not stored in any CXL state.
On release the skip range could be calculated based on the endpoint
decoders stored values.

Now when DC1 is being mapped 4 skip resources must be created as
children.  One of the PMEM resource (A), two of the parent DPA resource
(B,D), and one more child of the DC0 resource (C).

0GB        10GB       20GB       30GB       40GB       50GB       60GB
|----------|----------|----------|----------|----------|----------|
                           |                     |
|----------|----------|    |     |----------|    |     |----------|
        |          |       |          |          |
       (X)        (A)     (B)        (C)        (D)
	v          v       v          v          v
|XXXXX|----|XXXXX|----|----------|----------|----------|XXXXXXXXXX|
       skip       skip  skip        skip      skip

Expand the calculation of DPA freespace and enhance the logic to support
mapping/unmapping DC DPA space.  To track the potential of multiple skip
resources an xarray is attached to the endpoint decoder.  The existing
algorithm is consolidated with the new one to store a single skip
resource in the same way as multiple skip resources.

Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
An alternative of using reserve_region_with_split() was considered.
The advantage of that would be keeping all the resource information
stored solely in the resource tree rather than having separate
references to them.  However, it would best be implemented with a call
such as release_split_region() [name TBD?] which could find all the leaf
resources in the range and release them.  Furthermore, it is not clear
if reserve_region_with_split() is really intended for anything outside
of init code.  In the end this algorithm seems straight forward enough.

Changes for v2:
[iweiny: write commit message]
[iweiny: remove unneeded changes]
[iweiny: split from region creation patch]
[iweiny: Alter skip algorithm to use 'anonymous regions']
[iweiny: enhance debug messages]
[iweiny: consolidate skip resource creation]
[iweiny: ensure xa_destroy() is called]
[iweiny: consolidate region requests further]
[iweiny: ensure resource is released on xa_insert]
---
 drivers/cxl/core/hdm.c  | 188 +++++++++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/core/port.c |   2 +
 drivers/cxl/cxl.h       |   2 +
 3 files changed, 176 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3f4af1f5fac8..3cd048677816 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -222,6 +222,25 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, CXL);
 
+static void cxl_skip_release(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct device *dev = &port->dev;
+	unsigned long index;
+	void *entry;
+
+	xa_for_each(&cxled->skip_res, index, entry) {
+		struct resource *res = entry;
+
+		dev_dbg(dev, "decoder%d.%d: releasing skipped space; %pr\n",
+			port->id, cxled->cxld.id, res);
+		__release_region(&cxlds->dpa_res, res->start,
+				 resource_size(res));
+		xa_erase(&cxled->skip_res, index);
+	}
+}
+
 /*
  * Must be called in a context that synchronizes against this decoder's
  * port ->remove() callback (like an endpoint decoder sysfs attribute)
@@ -232,15 +251,11 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct resource *res = cxled->dpa_res;
-	resource_size_t skip_start;
 
 	lockdep_assert_held_write(&cxl_dpa_rwsem);
 
-	/* save @skip_start, before @res is released */
-	skip_start = res->start - cxled->skip;
 	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
-	if (cxled->skip)
-		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
+	cxl_skip_release(cxled);
 	cxled->skip = 0;
 	cxled->dpa_res = NULL;
 	put_device(&cxled->cxld.dev);
@@ -280,6 +295,98 @@ static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
 	return -EINVAL;
 }
 
+static int cxl_request_skip(struct cxl_endpoint_decoder *cxled,
+			    resource_size_t skip_base, resource_size_t skip_len)
+{
+	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
+	const char *name = dev_name(&cxled->cxld.dev);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct resource *dpa_res = &cxlds->dpa_res;
+	struct device *dev = &port->dev;
+	struct resource *res;
+	int rc;
+
+	res = __request_region(dpa_res, skip_base, skip_len, name, 0);
+	if (!res)
+		return -EBUSY;
+
+	rc = xa_insert(&cxled->skip_res, skip_base, res, GFP_KERNEL);
+	if (rc) {
+		__release_region(dpa_res, skip_base, skip_len);
+		return rc;
+	}
+
+	dev_dbg(dev, "decoder%d.%d: skipped space; %pr\n",
+		port->id, cxled->cxld.id, res);
+	return 0;
+}
+
+static int cxl_reserve_dpa_skip(struct cxl_endpoint_decoder *cxled,
+				resource_size_t base, resource_size_t skipped)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	resource_size_t skip_base = base - skipped;
+	resource_size_t size, skip_len = 0;
+	struct device *dev = &port->dev;
+	int rc, index;
+
+	size = resource_size(&cxlds->ram_res);
+	if (size && skip_base <= cxlds->ram_res.end) {
+		skip_len = cxlds->ram_res.end - skip_base + 1;
+		rc = cxl_request_skip(cxled, skip_base, skip_len);
+		if (rc)
+			return rc;
+		skip_base += skip_len;
+	}
+
+	if (skip_base == base) {
+		dev_dbg(dev, "skip done!\n");
+		return 0;
+	}
+
+	size = resource_size(&cxlds->pmem_res);
+	if (size && skip_base <= cxlds->pmem_res.end) {
+		skip_len = cxlds->pmem_res.end - skip_base + 1;
+		rc = cxl_request_skip(cxled, skip_base, skip_len);
+		if (rc)
+			return rc;
+		skip_base += skip_len;
+	}
+
+	index = dc_mode_to_region_index(cxled->mode);
+	for (int i = 0; i <= index; i++) {
+		struct resource *dcr = &cxlds->dc_res[i];
+
+		if (skip_base < dcr->start) {
+			skip_len = dcr->start - skip_base;
+			rc = cxl_request_skip(cxled, skip_base, skip_len);
+			if (rc)
+				return rc;
+			skip_base += skip_len;
+		}
+
+		if (skip_base == base) {
+			dev_dbg(dev, "skip done!\n");
+			break;
+		}
+
+		if (resource_size(dcr) && skip_base <= dcr->end) {
+			if (skip_base > base)
+				dev_err(dev, "Skip error\n");
+
+			skip_len = dcr->end - skip_base + 1;
+			rc = cxl_request_skip(cxled, skip_base, skip_len);
+			if (rc)
+				return rc;
+			skip_base += skip_len;
+		}
+	}
+
+	return 0;
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -317,13 +424,12 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	}
 
 	if (skipped) {
-		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
-				       dev_name(&cxled->cxld.dev), 0);
-		if (!res) {
-			dev_dbg(dev,
-				"decoder%d.%d: failed to reserve skipped space\n",
-				port->id, cxled->cxld.id);
-			return -EBUSY;
+		int rc = cxl_reserve_dpa_skip(cxled, base, skipped);
+
+		if (rc) {
+			dev_dbg(dev, "decoder%d.%d: failed to reserve skipped space; %#llx - %#llx\n",
+				port->id, cxled->cxld.id, base, skipped);
+			return rc;
 		}
 	}
 	res = __request_region(&cxlds->dpa_res, base, len,
@@ -331,14 +437,20 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	if (!res) {
 		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
 			port->id, cxled->cxld.id);
-		if (skipped)
-			__release_region(&cxlds->dpa_res, base - skipped,
-					 skipped);
+		cxl_skip_release(cxled);
 		return -EBUSY;
 	}
 	cxled->dpa_res = res;
 	cxled->skip = skipped;
 
+	for (int mode = CXL_DECODER_DC0; mode <= CXL_DECODER_DC7; mode++) {
+		int index = dc_mode_to_region_index(mode);
+
+		if (resource_contains(&cxlds->dc_res[index], res)) {
+			cxled->mode = mode;
+			goto success;
+		}
+	}
 	if (resource_contains(&cxlds->pmem_res, res))
 		cxled->mode = CXL_DECODER_PMEM;
 	else if (resource_contains(&cxlds->ram_res, res))
@@ -349,6 +461,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		cxled->mode = CXL_DECODER_MIXED;
 	}
 
+success:
+	dev_dbg(dev, "decoder%d.%d: %pr mode: %d\n", port->id, cxled->cxld.id,
+		cxled->dpa_res, cxled->mode);
 	port->hdm_end++;
 	get_device(&cxled->cxld.dev);
 	return 0;
@@ -492,11 +607,13 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
 					 resource_size_t *start_out,
 					 resource_size_t *skip_out)
 {
+	resource_size_t free_ram_start, free_pmem_start, free_dc_start;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	resource_size_t free_ram_start, free_pmem_start;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct device *dev = &cxled->cxld.dev;
 	resource_size_t start, avail, skip;
 	struct resource *p, *last;
+	int index;
 
 	lockdep_assert_held(&cxl_dpa_rwsem);
 
@@ -514,6 +631,20 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
 	else
 		free_pmem_start = cxlds->pmem_res.start;
 
+	/*
+	 * Limit each decoder to a single DC region to map memory with
+	 * different DSMAS entry.
+	 */
+	index = dc_mode_to_region_index(cxled->mode);
+	if (index >= 0) {
+		if (cxlds->dc_res[index].child) {
+			dev_err(dev, "Cannot allocate DPA from DC Region: %d\n",
+				index);
+			return -EINVAL;
+		}
+		free_dc_start = cxlds->dc_res[index].start;
+	}
+
 	if (cxled->mode == CXL_DECODER_RAM) {
 		start = free_ram_start;
 		avail = cxlds->ram_res.end - start + 1;
@@ -535,6 +666,29 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
 		else
 			skip_end = start - 1;
 		skip = skip_end - skip_start + 1;
+	} else if (cxl_decoder_mode_is_dc(cxled->mode)) {
+		resource_size_t skip_start, skip_end;
+
+		start = free_dc_start;
+		avail = cxlds->dc_res[index].end - start + 1;
+		if ((resource_size(&cxlds->pmem_res) == 0) || !cxlds->pmem_res.child)
+			skip_start = free_ram_start;
+		else
+			skip_start = free_pmem_start;
+		/*
+		 * If any dc region is already mapped, then that allocation
+		 * already handled the RAM and PMEM skip.  Check for DC region
+		 * skip.
+		 */
+		for (int i = index - 1; i >= 0 ; i--) {
+			if (cxlds->dc_res[i].child) {
+				skip_start = cxlds->dc_res[i].child->end + 1;
+				break;
+			}
+		}
+
+		skip_end = start - 1;
+		skip = skip_end - skip_start + 1;
 	} else {
 		dev_dbg(cxled_dev(cxled), "mode not set\n");
 		avail = 0;
@@ -572,6 +726,8 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 
 	avail = cxl_dpa_freespace(cxled, &start, &skip);
 
+	dev_dbg(dev, "DPA Allocation start: %llx len: %llx Skip: %llx\n",
+		start, size, skip);
 	if (size > avail) {
 		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
 			cxl_decoder_mode_name(cxled->mode), &avail);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index ce4a66865db3..a5db710a63bc 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -413,6 +413,7 @@ static void cxl_endpoint_decoder_release(struct device *dev)
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
 
 	__cxl_decoder_release(&cxled->cxld);
+	xa_destroy(&cxled->skip_res);
 	kfree(cxled);
 }
 
@@ -1769,6 +1770,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
 		return ERR_PTR(-ENOMEM);
 
 	cxled->pos = -1;
+	xa_init(&cxled->skip_res);
 	cxld = &cxled->cxld;
 	rc = cxl_decoder_init(port, cxld);
 	if (rc)	 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d41f3f14fbe3..0a225b0c20bf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -433,6 +433,7 @@ enum cxl_decoder_state {
  * @cxld: base cxl_decoder_object
  * @dpa_res: actively claimed DPA span of this decoder
  * @skip: offset into @dpa_res where @cxld.hpa_range maps
+ * @skip_res: array of skipped resources from the previous decoder end
  * @mode: which memory type / access-mode-partition this decoder targets
  * @state: autodiscovery state
  * @pos: interleave position in @cxld.region
@@ -441,6 +442,7 @@ struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
 	struct resource *dpa_res;
 	resource_size_t skip;
+	struct xarray skip_res;
 	enum cxl_decoder_mode mode;
 	enum cxl_decoder_state state;
 	int pos;

-- 
2.45.2


