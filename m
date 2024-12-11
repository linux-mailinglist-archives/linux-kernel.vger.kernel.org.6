Return-Path: <linux-kernel+bounces-440743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421AA9EC38D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D7F2828FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8312309BA;
	Wed, 11 Dec 2024 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtDY5P0t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0767D23FA1C;
	Wed, 11 Dec 2024 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888580; cv=none; b=UJhCK9/rCpbi8d8WcRhHvpKHh/7MfoEtSTLx0kehunSKautXMKKQFCXvbJn8GPIMolQ1y1jxsLDtLNITWCcCfLx8nGS58f2sZW9vA4qCBR5tP5Ply89XkeFmRJwuuY8LrumvMU9inmJhdFalZrRsnukD6pB72ejfosqJTPam1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888580; c=relaxed/simple;
	bh=KM2zszvDiVdUgnK0U3/vkgyIvb8wO1EqYAZZzeG5DWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5YlmizfxLxcgSWInqh9l3Qjch3lPt0qpYrrmE8weHyGn8HDXjH8mOY1Fjg4I+YGBNAuB5h5LUVXKvJJFrtmKYIl5iHvSTRNxYLGR8JRalHm/M9QlQv75E2DnL+YE6k8L2vdxa5ds7DupwRNCzvT1NZv3eSRCnb4lTJrslvGHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtDY5P0t; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733888578; x=1765424578;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KM2zszvDiVdUgnK0U3/vkgyIvb8wO1EqYAZZzeG5DWQ=;
  b=GtDY5P0tj9CCYMN0TsaYjNzrFOgVfyhuhlBeynwOivbTjY+aXCWpXtN5
   /qmBismnNn0V5thBavn9pY2K+GuQ82soY4yI/hFuQ5X8+9geUWPsufXsA
   5A/dyVxsEnmhUmDk2FCSlM5x+y1yignM5Cw4bmJQoVYL9IWn6QkRKi7dJ
   ZDoyD4Nihk+KpZ/gyYgql/5Rhj8qr7vNgB2Q4Kj2DC4//ly/mAuIqq3qZ
   K1W6IYF7QResuxcNkeqZD6ACJqpt/Xv3JGGTg1Gyz0i9vC5e+aB489Yzo
   TZyfI28qFawvp/nI4JMJSnIneJ34jmv/an3borbte8hYCP8LKA1xHbldw
   g==;
X-CSE-ConnectionGUID: V47eWEGkRuG6mAOZ6RTNjA==
X-CSE-MsgGUID: ZR6bCapUSdyBq6x7YCVQjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34178132"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="34178132"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 19:42:58 -0800
X-CSE-ConnectionGUID: 5igrcdpYQYiy7ShLbgDLiA==
X-CSE-MsgGUID: 8PqfHO8iTkWXGzk3g+e9ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95504234"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.125.109.231])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 19:42:56 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 10 Dec 2024 21:42:30 -0600
Subject: [PATCH v8 15/21] cxl/region/extent: Expose region extent
 information in sysfs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-dcd-type2-upstream-v8-15-812852504400@intel.com>
References: <20241210-dcd-type2-upstream-v8-0-812852504400@intel.com>
In-Reply-To: <20241210-dcd-type2-upstream-v8-0-812852504400@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733888537; l=4933;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=KM2zszvDiVdUgnK0U3/vkgyIvb8wO1EqYAZZzeG5DWQ=;
 b=cdCFJzAUayVDEUyg3YlXG33NULPyQqr/4nQaFBNGMx68Z2b19Hyh+n1F1XRNp7XU0dGvVwdtk
 O/vDrUeHmkmDpPJs5l/l7e6eMiWmAxn8NYjl8/aqfvX7ORvpj7sF0NB
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Extent information can be helpful to the user to coordinate memory usage
with the external orchestrator and FM.

Expose the details of region extents by creating the following
sysfs entries.

        /sys/bus/cxl/devices/dax_regionX/extentX.Y
        /sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
        /sys/bus/cxl/devices/dax_regionX/extentX.Y/length
        /sys/bus/cxl/devices/dax_regionX/extentX.Y/tag

Based on an original patch by Navneet Singh.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 33 +++++++++++++++++++
 drivers/cxl/core/extent.c               | 58 +++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index aeff248ea368cf49c9977fcaf43ab4def978e896..ee2ef4ea33e17cbc65e1252753f46f6d0dce1aee 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -632,3 +632,36 @@ Description:
 		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
 		the number to the closest initiator and access1 provides the
 		number to the closest CPU.
+
+What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) [For Dynamic Capacity regions only] Users can use the
+		extent information to create DAX devices on specific extents.
+		This is done by creating and destroying DAX devices in specific
+		sequences and looking at the mappings created.  Extent offset
+		within the region.
+
+What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) [For Dynamic Capacity regions only] Users can use the
+		extent information to create DAX devices on specific extents.
+		This is done by creating and destroying DAX devices in specific
+		sequences and looking at the mappings created.  Extent length
+		within the region.
+
+What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) [For Dynamic Capacity regions only] Users can use the
+		extent information to create DAX devices on specific extents.
+		This is done by creating and destroying DAX devices in specific
+		sequences and looking at the mappings created.  UUID extent
+		tag.
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index a45ff84727b0f8c2567f0d2dd8b5c261b23695e3..0ebdbe983d094de89579527459cd75e3e7e2b6c7 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -6,6 +6,63 @@
 
 #include "core.h"
 
+static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct region_extent *region_extent = to_region_extent(dev);
+
+	return sysfs_emit(buf, "%#llx\n", region_extent->hpa_range.start);
+}
+static DEVICE_ATTR_RO(offset);
+
+static ssize_t length_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct region_extent *region_extent = to_region_extent(dev);
+	u64 length = range_len(&region_extent->hpa_range);
+
+	return sysfs_emit(buf, "%#llx\n", length);
+}
+static DEVICE_ATTR_RO(length);
+
+static ssize_t tag_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct region_extent *region_extent = to_region_extent(dev);
+
+	return sysfs_emit(buf, "%pUb\n", &region_extent->tag);
+}
+static DEVICE_ATTR_RO(tag);
+
+static struct attribute *region_extent_attrs[] = {
+	&dev_attr_offset.attr,
+	&dev_attr_length.attr,
+	&dev_attr_tag.attr,
+	NULL
+};
+
+static uuid_t empty_tag = { 0 };
+
+static umode_t region_extent_visible(struct kobject *kobj,
+				     struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct region_extent *region_extent = to_region_extent(dev);
+
+	if (a == &dev_attr_tag.attr &&
+	    uuid_equal(&region_extent->tag, &empty_tag))
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group region_extent_attribute_group = {
+	.attrs = region_extent_attrs,
+	.is_visible = region_extent_visible,
+};
+
+__ATTRIBUTE_GROUPS(region_extent_attribute);
+
 static void cxled_release_extent(struct cxl_endpoint_decoder *cxled,
 				 struct cxled_extent *ed_extent)
 {
@@ -44,6 +101,7 @@ static void region_extent_release(struct device *dev)
 static const struct device_type region_extent_type = {
 	.name = "extent",
 	.release = region_extent_release,
+	.groups = region_extent_attribute_groups,
 };
 
 bool is_region_extent(struct device *dev)

-- 
2.47.1


