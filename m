Return-Path: <linux-kernel+bounces-295564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAE959E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27637B25C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5E1A2873;
	Wed, 21 Aug 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erFiIpgN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2119ABCA;
	Wed, 21 Aug 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246025; cv=none; b=eqzibwfVQPdX8xEdChHj+wNbZEeNb6l+qTKz0I8Wo/uQhHU6DjTwgcAx7O+KoiLXmjBybkqIZQoloJJ1l7ISizKMCdd3NWY/hHPBU6ZZyQuv1fQb0lWO9Czc/tapEMiTLO637z03HnfNSQEMcy2SH0RcunYt/ofo+a5IbW1OK7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246025; c=relaxed/simple;
	bh=NzNw6q5V7hr4qHyg6nI8oqQKW+bPNraqmhWgFaJ16dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDqFX9zWcV7p+/+ty9UwI1JJdJEU2C6iKbVKX/qkCurFRD68bwMdIkdrwAETFc1wo7sg4ZwTMO35b+WOiAg4DIEERvRWwWHrw4CRv//gArQPYIBGMD7X+WKsfxLvOVLkLcLcOE+MVnnTiolq8Y0ovkS6xUUxMYnBHqmSKfsp5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erFiIpgN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724246023; x=1755782023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzNw6q5V7hr4qHyg6nI8oqQKW+bPNraqmhWgFaJ16dw=;
  b=erFiIpgN6YtntAqO5YPU2ltfD8iY72narsrES8nn7zs0u71L/tOAKQYX
   8KC2ZW717yE30dAFw8EDk+0vvK5R9ZmuDTPwx05G6vCRCXH6CaCCwkMCN
   nV21eM/QHPo8oJJRBrTbxGmLjOwe/DAybkmDKjc4Sz2hzzLEUmkVAbklr
   R1okTgFf7q3tTwGXjNk4QSqDVo8dR+AQTXjwIAj2yFqTQMgvSFO58wehY
   leQ6FStdpOxZU73r7ImfcDcshdxMsgWSSYaOvoo5qlnsWasXtAZF+66Jm
   p46FxdyNE5tYztylukdaeVgj7i5wSeB4952f67X/wqswuD0mDCjC5hRPQ
   g==;
X-CSE-ConnectionGUID: 4uogTFFCS/+1npbW7lhirA==
X-CSE-MsgGUID: lnvefS/XQmG4K4KwRj+/KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26399026"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26399026"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:13:40 -0700
X-CSE-ConnectionGUID: Z1qmEUhMSfaHIOFcYpLDCA==
X-CSE-MsgGUID: hO1ScID2RWK46XPpb6cjOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66047797"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:13:39 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86/intel-uncore-freq: Add efficiency latency control to sysfs interface
Date: Wed, 21 Aug 2024 16:10:30 +0300
Message-ID: <20240821131321.824326-4-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821131321.824326-1-tero.kristo@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the TPMI efficiency latency control fields to the sysfs interface.
The sysfs files are mapped to the TPMI uncore driver via the registered
uncore_read and uncore_write driver callbacks. These fields are not
populated on older non TPMI hardware.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../uncore-frequency-common.c                 | 42 ++++++++++++++++---
 .../uncore-frequency-common.h                 | 13 +++++-
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 4e880585cbe4..e22b683a7a43 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -60,11 +60,16 @@ static ssize_t show_attr(struct uncore_data *data, char *buf, enum uncore_index
 static ssize_t store_attr(struct uncore_data *data, const char *buf, ssize_t count,
 			  enum uncore_index index)
 {
-	unsigned int input;
+	unsigned int input = 0;
 	int ret;
 
-	if (kstrtouint(buf, 10, &input))
-		return -EINVAL;
+	if (index == UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE) {
+		if (kstrtobool(buf, (bool *)&input))
+			return -EINVAL;
+	} else {
+		if (kstrtouint(buf, 10, &input))
+			return -EINVAL;
+	}
 
 	mutex_lock(&uncore_lock);
 	ret = uncore_write(data, input, index);
@@ -103,6 +108,18 @@ show_uncore_attr(max_freq_khz, UNCORE_INDEX_MAX_FREQ);
 
 show_uncore_attr(current_freq_khz, UNCORE_INDEX_CURRENT_FREQ);
 
+store_uncore_attr(elc_low_threshold_percent, UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
+store_uncore_attr(elc_high_threshold_percent, UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD);
+store_uncore_attr(elc_high_threshold_enable,
+		  UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE);
+store_uncore_attr(elc_floor_freq_khz, UNCORE_INDEX_EFF_LAT_CTRL_FREQ);
+
+show_uncore_attr(elc_low_threshold_percent, UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
+show_uncore_attr(elc_high_threshold_percent, UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD);
+show_uncore_attr(elc_high_threshold_enable,
+		 UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE);
+show_uncore_attr(elc_floor_freq_khz, UNCORE_INDEX_EFF_LAT_CTRL_FREQ);
+
 #define show_uncore_data(member_name)					\
 	static ssize_t show_##member_name(struct kobject *kobj,	\
 					   struct kobj_attribute *attr, char *buf)\
@@ -146,7 +163,8 @@ show_uncore_data(initial_max_freq_khz);
 
 static int create_attr_group(struct uncore_data *data, char *name)
 {
-	int ret, freq, index = 0;
+	int ret, index = 0;
+	unsigned int val;
 
 	init_attribute_rw(max_freq_khz);
 	init_attribute_rw(min_freq_khz);
@@ -168,10 +186,24 @@ static int create_attr_group(struct uncore_data *data, char *name)
 	data->uncore_attrs[index++] = &data->initial_min_freq_khz_kobj_attr.attr;
 	data->uncore_attrs[index++] = &data->initial_max_freq_khz_kobj_attr.attr;
 
-	ret = uncore_read(data, &freq, UNCORE_INDEX_CURRENT_FREQ);
+	ret = uncore_read(data, &val, UNCORE_INDEX_CURRENT_FREQ);
 	if (!ret)
 		data->uncore_attrs[index++] = &data->current_freq_khz_kobj_attr.attr;
 
+	ret = uncore_read(data, &val, UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD);
+	if (!ret) {
+		init_attribute_rw(elc_low_threshold_percent);
+		init_attribute_rw(elc_high_threshold_percent);
+		init_attribute_rw(elc_high_threshold_enable);
+		init_attribute_rw(elc_floor_freq_khz);
+
+		data->uncore_attrs[index++] = &data->elc_low_threshold_percent_kobj_attr.attr;
+		data->uncore_attrs[index++] = &data->elc_high_threshold_percent_kobj_attr.attr;
+		data->uncore_attrs[index++] =
+			&data->elc_high_threshold_enable_kobj_attr.attr;
+		data->uncore_attrs[index++] = &data->elc_floor_freq_khz_kobj_attr.attr;
+	}
+
 	data->uncore_attrs[index] = NULL;
 
 	data->uncore_attr_group.name = name;
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
index b5c7311bfa05..26c854cd5d97 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
@@ -34,6 +34,13 @@
  * @domain_id_kobj_attr: Storage for kobject attribute domain_id
  * @fabric_cluster_id_kobj_attr: Storage for kobject attribute fabric_cluster_id
  * @package_id_kobj_attr: Storage for kobject attribute package_id
+ * @elc_low_threshold_percent_kobj_attr:
+		Storage for kobject attribute elc_low_threshold_percent
+ * @elc_high_threshold_percent_kobj_attr:
+		Storage for kobject attribute elc_high_threshold_percent
+ * @elc_high_threshold_enable_kobj_attr:
+		Storage for kobject attribute elc_high_threshold_enable
+ * @elc_floor_freq_khz_kobj_attr: Storage for kobject attribute elc_floor_freq_khz
  * @uncore_attrs:	Attribute storage for group creation
  *
  * This structure is used to encapsulate all data related to uncore sysfs
@@ -61,7 +68,11 @@ struct uncore_data {
 	struct kobj_attribute domain_id_kobj_attr;
 	struct kobj_attribute fabric_cluster_id_kobj_attr;
 	struct kobj_attribute package_id_kobj_attr;
-	struct attribute *uncore_attrs[9];
+	struct kobj_attribute elc_low_threshold_percent_kobj_attr;
+	struct kobj_attribute elc_high_threshold_percent_kobj_attr;
+	struct kobj_attribute elc_high_threshold_enable_kobj_attr;
+	struct kobj_attribute elc_floor_freq_khz_kobj_attr;
+	struct attribute *uncore_attrs[13];
 };
 
 #define UNCORE_DOMAIN_ID_INVALID	-1
-- 
2.43.1


