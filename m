Return-Path: <linux-kernel+bounces-440735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BD69EC380
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B147318864B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C223D41B;
	Wed, 11 Dec 2024 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdmDwVXy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B023A580;
	Wed, 11 Dec 2024 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888560; cv=none; b=iYezct+EZqy0xVxFWCU32ODAAq2gB7tBMoKSAEHQxSuJKioB1SzSiJYc7W+ntbe/qdO/BohBZISricQG5FLy7dN2wz55BdReW3prH4QsvAz+liOL+TXZiRmhPzFTviVFdDnxBD0n5HczLE45SDsGuPfXixmIcCSWQMh1chVEa0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888560; c=relaxed/simple;
	bh=/vMBJZJdeoqlqKaln4j/LWL3nzaPd1XoD72KFre+WfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cenkRjAODMvWeV8JqN99B2F7KoMB6dJ4c0wbjuy47uiDHU0eUNpNNYZhxbKmxF3jqdwBh8A4pHqbHFe0qMtgkjTZ4l1oahz1zIBKj0XIU0CfXI99wJIXGv7r5xRHYPgjG+6uA6SXsmGu4+UcSdQ9+ZwsRW16FQgOp74atvZ8esA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdmDwVXy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733888559; x=1765424559;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/vMBJZJdeoqlqKaln4j/LWL3nzaPd1XoD72KFre+WfE=;
  b=jdmDwVXymo1l8r2I0K05HOCdASkNShd0W3yxYc4UCS6ERAL5fb35aHyI
   y6bC1IDBBrc6lS8mgy3QhRphfAfbgCiTW4+VAN+7CzB9G263FJWQzcRyv
   UF2nzJW9IuKjebVVJY7a/MNrN0GrVegt7EjVjr3fyqGvF1CDkWy/nOACg
   v/+SnYwZsnLLV+h5qaIT32tbeYI155eTrJLRNZnn8F5YBe7N62cVdAVwl
   brnravjgGO1APT6XqEBpxrPSEYn2Ys/kwVzhO88zDh2mH0w4H13KU9GqY
   Hn5InJdAHgmWOI0Ghlw8N3dZlOlNB0qUcNkvsq+MfHH9ekPePXfHcW3LV
   g==;
X-CSE-ConnectionGUID: 7Y6BP4anSYub98b+vcePHQ==
X-CSE-MsgGUID: ut7b20XnTImbeFs0J62ZRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34395695"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="34395695"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 19:42:38 -0800
X-CSE-ConnectionGUID: BdmO0if6Tmq/MYBC43TGbQ==
X-CSE-MsgGUID: 4USuJmhKRYmRFrvF7l3RXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95696828"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.125.109.231])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 19:42:36 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 10 Dec 2024 21:42:22 -0600
Subject: [PATCH v8 07/21] cxl/mem: Expose DCD partition capabilities in
 sysfs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-dcd-type2-upstream-v8-7-812852504400@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733888537; l=8304;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=/vMBJZJdeoqlqKaln4j/LWL3nzaPd1XoD72KFre+WfE=;
 b=NKghRBfaRaxVcC6E/qW3uLqK7lJFn2sM12PxobNq1+2leVR2D/eutr3SpL3E8VEXBE3jkg/+t
 aeWQd9tfWojBj1KEdM5P5N/3Ggc3n78w+LKwU4SIU210RINZWg6g35v
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

To properly configure CXL regions on Dynamic Capacity Devices (DCD),
user space will need to know the details of the DC partitions available.

Expose dynamic capacity capabilities through sysfs.

Based on an original patch by Navneet Singh.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  45 ++++++++++++
 drivers/cxl/core/memdev.c               | 124 ++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3f5627a1210a16aca7c18d17131a56491048a0c2..ff3ae83477f0876c0ee2d3955d27a11fa9d16d83 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -54,6 +54,51 @@ Description:
 		identically named field in the Identify Memory Device Output
 		Payload in the CXL-2.0 specification.
 
+What:		/sys/bus/cxl/devices/memX/dcY/size
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Dynamic Capacity (DC) region information.  Devices only
+		export dcY if DCD partition Y is supported.
+		dcY/size is the size of each of those partitions.
+
+What:		/sys/bus/cxl/devices/memX/dcY/read_only
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Dynamic Capacity (DC) region information.  Devices only
+		export dcY if DCD partition Y is supported.
+		dcY/read_only indicates true if the region is exported
+		read_only from the device.
+
+What:		/sys/bus/cxl/devices/memX/dcY/shareable
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Dynamic Capacity (DC) region information.  Devices only
+		export dcY if DCD partition Y is supported.
+		dcY/shareable indicates true if the region is exported
+		shareable from the device.
+
+What:		/sys/bus/cxl/devices/memX/dcY/qos_class
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Dynamic Capacity (DC) region information.  Devices only
+		export dcY if DCD partition Y is supported.  For CXL host
+		platforms that support "QoS Telemmetry" this attribute conveys
+		a comma delimited list of platform specific cookies that
+		identifies a QoS performance class for the persistent partition
+		of the CXL mem device. These class-ids can be compared against
+		a similar "qos_class" published for a root decoder. While it is
+		not required that the endpoints map their local memory-class to
+		a matching platform class, mismatches are not recommended as
+		there are platform specific performance related side-effects
+		that may result. First class-id is displayed.
 
 What:		/sys/bus/cxl/devices/memX/pmem/qos_class
 Date:		May, 2023
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index ae3dfcbe893897aaf315c947d3bdb0741aadf599..56cdf09d3affb81969755769a8803f6bded7a4ce 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation. */
 
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/string_choices.h>
 #include <linux/firmware.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -449,6 +450,121 @@ static struct attribute *cxl_memdev_security_attributes[] = {
 	NULL,
 };
 
+static ssize_t show_size_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%#llx\n", mds->dc_region[pos].decode_len);
+}
+
+static ssize_t show_read_only_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%s\n",
+			  str_true_false(mds->dc_region[pos].read_only));
+}
+
+static ssize_t show_shareable_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%s\n",
+			  str_true_false(mds->dc_region[pos].shareable));
+}
+
+static ssize_t show_qos_class_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%d\n", mds->dc_perf[pos].qos_class);
+}
+
+#define CXL_MEMDEV_DC_ATTR_GROUP(n)						\
+static ssize_t dc##n##_size_show(struct device *dev,				\
+				 struct device_attribute *attr,			\
+				 char *buf)					\
+{										\
+	return show_size_dcN(to_cxl_memdev(dev), buf, (n));			\
+}										\
+struct device_attribute dc##n##_size = {					\
+	.attr	= { .name = "size", .mode = 0444 },				\
+	.show	= dc##n##_size_show,						\
+};										\
+static ssize_t dc##n##_read_only_show(struct device *dev,			\
+				      struct device_attribute *attr,		\
+				      char *buf)				\
+{										\
+	return show_read_only_dcN(to_cxl_memdev(dev), buf, (n));		\
+}										\
+struct device_attribute dc##n##_read_only = {					\
+	.attr	= { .name = "read_only", .mode = 0444 },			\
+	.show	= dc##n##_read_only_show,					\
+};										\
+static ssize_t dc##n##_shareable_show(struct device *dev,			\
+				     struct device_attribute *attr,		\
+				     char *buf)					\
+{										\
+	return show_shareable_dcN(to_cxl_memdev(dev), buf, (n));		\
+}										\
+struct device_attribute dc##n##_shareable = {					\
+	.attr	= { .name = "shareable", .mode = 0444 },			\
+	.show	= dc##n##_shareable_show,					\
+};										\
+static ssize_t dc##n##_qos_class_show(struct device *dev,			\
+				      struct device_attribute *attr,		\
+				      char *buf)				\
+{										\
+	return show_qos_class_dcN(to_cxl_memdev(dev), buf, (n));		\
+}										\
+struct device_attribute dc##n##_qos_class = {					\
+	.attr	= { .name = "qos_class", .mode = 0444 },			\
+	.show	= dc##n##_qos_class_show,					\
+};										\
+static struct attribute *cxl_memdev_dc##n##_attributes[] = {			\
+	&dc##n##_size.attr,							\
+	&dc##n##_read_only.attr,						\
+	&dc##n##_shareable.attr,						\
+	&dc##n##_qos_class.attr,						\
+	NULL									\
+};										\
+static umode_t cxl_memdev_dc##n##_attr_visible(struct kobject *kobj,		\
+					       struct attribute *a,		\
+					       int pos)				\
+{										\
+	struct device *dev = kobj_to_dev(kobj);					\
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
+										\
+	/* Not a memory device */						\
+	if (!mds)								\
+		return 0;							\
+	return a->mode;								\
+}										\
+static umode_t cxl_memdev_dc##n##_group_visible(struct kobject *kobj)		\
+{										\
+	struct device *dev = kobj_to_dev(kobj);					\
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
+										\
+	/* Not a memory device or partition not supported */			\
+	return mds && n < mds->nr_dc_region;					\
+}										\
+DEFINE_SYSFS_GROUP_VISIBLE(cxl_memdev_dc##n);					\
+static struct attribute_group cxl_memdev_dc##n##_group = {			\
+	.name = "dc"#n,								\
+	.attrs = cxl_memdev_dc##n##_attributes,					\
+	.is_visible = SYSFS_GROUP_VISIBLE(cxl_memdev_dc##n),			\
+}
+CXL_MEMDEV_DC_ATTR_GROUP(0);
+CXL_MEMDEV_DC_ATTR_GROUP(1);
+CXL_MEMDEV_DC_ATTR_GROUP(2);
+CXL_MEMDEV_DC_ATTR_GROUP(3);
+CXL_MEMDEV_DC_ATTR_GROUP(4);
+CXL_MEMDEV_DC_ATTR_GROUP(5);
+CXL_MEMDEV_DC_ATTR_GROUP(6);
+CXL_MEMDEV_DC_ATTR_GROUP(7);
+
 static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -525,6 +641,14 @@ static struct attribute_group cxl_memdev_security_attribute_group = {
 };
 
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
+	&cxl_memdev_dc0_group,
+	&cxl_memdev_dc1_group,
+	&cxl_memdev_dc2_group,
+	&cxl_memdev_dc3_group,
+	&cxl_memdev_dc4_group,
+	&cxl_memdev_dc5_group,
+	&cxl_memdev_dc6_group,
+	&cxl_memdev_dc7_group,
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,

-- 
2.47.1


