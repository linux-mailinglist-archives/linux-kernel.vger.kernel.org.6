Return-Path: <linux-kernel+bounces-305297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750C962C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D461B24689
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E7419644C;
	Wed, 28 Aug 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZqHJy4h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711861A38FA;
	Wed, 28 Aug 2024 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859436; cv=none; b=s7tLtR8egA2+92z51plOtoMSUlhSsGEo859OaQltc+SlaXM9ITMHfpJS/Vn/GnCflUgBI6C9C1tul4zNUpaPMX9m14BuEleCzhsPCYC7DiYCAlU9kA99VPQ+QKQJ7ZW6Boh/4aXmTy1bMebY4WWZqm5jH4eTCWc0Vwo/pqgdArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859436; c=relaxed/simple;
	bh=8kgGQnTYilL6+bZZ6vBOIj+SIwgmVCVYPwhHF6XplIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlHuM2Nxq/hu5ccnlHQa/bjrFVhbaXTdblivOt/1OZJX0XC8incTsA+LyagIPVcBz1b5lvnNYYOwohSJxT5LoXeqCYfAw6+3rCwVJI1FBjDWucyYGwjKQ8FTfLC8fklsPaqshFwQJzqBE40/Eo4j1Lroice+likhsxmK+WfaIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZqHJy4h; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724859435; x=1756395435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kgGQnTYilL6+bZZ6vBOIj+SIwgmVCVYPwhHF6XplIY=;
  b=FZqHJy4hIfeeP4Gk2+CPGsW04Bn/eT6wMssOmyAnIUdIsKgUHy5pdv6b
   jXC5bGu0479upgeNhUDSK4FpfvsRUMsCpNK8wVqvWGer9ZwcixQTbLy6N
   0ZKgJ/pRNjzPYVz5u4n4iLbwVNiUj9gtf5pX6gGD70WBfsvo2kBSvUR5J
   pBFshPBc6DJauxkyDnPbTxwe/CC/YJ0mzSsQXnHWTfZzDTTKTQE6BdAcL
   B9Po4i52mBEmQALHz+uWOiku6i1AQVeKPRR/vcPoJa3zSLTJABoM6u7uJ
   SCXGA8cLYYVNNaOCJmVGf9TCsrMymrYU6vaXTVhvRHFmtzw2nfQcwq78c
   g==;
X-CSE-ConnectionGUID: pxG0VwbcRJuGX/IbAuEjNQ==
X-CSE-MsgGUID: eoqcXabpQwihEB927lqtfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34809274"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34809274"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:37:14 -0700
X-CSE-ConnectionGUID: CEnAmP5hSzCQf8UdAQVDdQ==
X-CSE-MsgGUID: jLNhNY3WQxKpKWc7TzMBMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="94064370"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:37:13 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] platform/x86/intel-uncore-freq: Add efficiency latency control to sysfs interface
Date: Wed, 28 Aug 2024 18:34:55 +0300
Message-ID: <20240828153657.1296410-4-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828153657.1296410-1-tero.kristo@linux.intel.com>
References: <20240828153657.1296410-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the TPMI efficiency latency control fields to the sysfs interface.
The sysfs files are mapped to the TPMI uncore driver via the registered
uncore_read and uncore_write driver callbacks. These fields are not
populated on older non TPMI hardware.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v2:
  * Added Ilpo's reviewed by tag

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


