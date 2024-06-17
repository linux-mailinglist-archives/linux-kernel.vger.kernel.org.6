Return-Path: <linux-kernel+bounces-216718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB990A4FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C1B253AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE4195FFD;
	Mon, 17 Jun 2024 06:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LO8133hK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08796195FDB;
	Mon, 17 Jun 2024 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604448; cv=none; b=mOSuOEzo2Ig2SwCZk/a8GeKZGzKxYdolb2hZgBFNPpdqe8sNERpJUPuohTs+rCKeNJ8FlSicTKcTmP1Cgu+FtTLkQE2pHvBXaDqTAKXCREK3jQD5x5JsVTwzkEhHXbwQwBqVEQUxPyScHxDZ7G+RsKBuVut2KOgGqeXFmNJTN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604448; c=relaxed/simple;
	bh=pm4CS3uITJz8oWMTDsc9hsVdZ0jFek9ebREwEYUCGkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLDgPKQ+LxKb5u3+ECP66SwnBJqgesKj1co1QjuEQBIn2Hte/IMBYgBMIHmmTN4K1YE9wEo1FBNI1a/K3vH5nwwzdcboeU1ZB/LtH7BDvJ5SL2+dw7z1w/jatp0+1lXvvgjEcTTILcaucRTp9UrxeUVzTUJNG+uMNb+Oh2n7qP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LO8133hK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718604447; x=1750140447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pm4CS3uITJz8oWMTDsc9hsVdZ0jFek9ebREwEYUCGkU=;
  b=LO8133hKvfQTBuefi4JpdudD812bYKTseilBvcs8u6zQToBk3R4Ukl3f
   JvQZDubLoZUmutWRjpwbjAse5H+ywz68WV0XzqXYjFH43MsQmc0/R3r19
   XAcbXg7dZgB0VKjxSV72oLX7wH8A4oYrW//Tf+OEO/dHvVyAoMnT4868X
   r1n9Hz1GjhVPABLAz62gRp0CCcQRGZ4mZj75QVeZ8+GBUtKhJDjtfnOYq
   WpZgEsNXNXTJjg1KIuR6cRwqjeICAeMSr8QtwFmzSQgxq557CzAWlOJ5l
   H7rBKBi9g4LAjZGRakN8unOxH/Dxg0VpRxlJ2DYOzTtu4jlcIwaSfjM4d
   Q==;
X-CSE-ConnectionGUID: TiozYziLSGOc7Z7suG4m6g==
X-CSE-MsgGUID: 9uRkGVRmRsuoy5l5AV2DMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15138472"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15138472"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:27 -0700
X-CSE-ConnectionGUID: mBKfOPVtRwGkWQU6iIs2Eg==
X-CSE-MsgGUID: x2YlxM5MRVayPMoY/JrA+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41028205"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.69])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:24 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 5/7] platform/x86/intel-uncore-freq: Get rid of uncore_read_freq driver API
Date: Mon, 17 Jun 2024 09:04:38 +0300
Message-ID: <20240617060708.892981-6-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617060708.892981-1-tero.kristo@linux.intel.com>
References: <20240617060708.892981-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of uncore_read_freq driver API. Instead, add a new entry to the
enumerated read interface and use this.

No functional change intended.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../uncore-frequency-common.c                 | 19 ++++++--------
 .../uncore-frequency-common.h                 | 10 ++++----
 .../uncore-frequency/uncore-frequency-tpmi.c  | 25 ++++++++++++++++---
 .../intel/uncore-frequency/uncore-frequency.c | 20 +++++++++++++--
 4 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 8d9817d70e27..cfbff057458d 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -21,7 +21,6 @@ static DEFINE_IDA(intel_uncore_ida);
 /* callbacks for actual HW read/write */
 static int (*uncore_read)(struct uncore_data *data, unsigned int *value, enum uncore_index index);
 static int (*uncore_write)(struct uncore_data *data, unsigned int input, enum uncore_index index);
-static int (*uncore_read_freq)(struct uncore_data *data, unsigned int *freq);
 
 static ssize_t show_domain_id(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
@@ -85,7 +84,7 @@ static ssize_t show_perf_status_freq_khz(struct uncore_data *data, char *buf)
 	int ret;
 
 	mutex_lock(&uncore_lock);
-	ret = uncore_read_freq(data, &freq);
+	ret = uncore_read(data, &freq, UNCORE_INDEX_CURRENT_FREQ);
 	mutex_unlock(&uncore_lock);
 	if (ret)
 		return ret;
@@ -195,7 +194,7 @@ static int create_attr_group(struct uncore_data *data, char *name)
 	data->uncore_attrs[index++] = &data->initial_min_freq_khz_kobj_attr.attr;
 	data->uncore_attrs[index++] = &data->initial_max_freq_khz_kobj_attr.attr;
 
-	ret = uncore_read_freq(data, &freq);
+	ret = uncore_read(data, &freq, UNCORE_INDEX_CURRENT_FREQ);
 	if (!ret)
 		data->uncore_attrs[index++] = &data->current_freq_khz_kobj_attr.attr;
 
@@ -267,17 +266,15 @@ void uncore_freq_remove_die_entry(struct uncore_data *data)
 }
 EXPORT_SYMBOL_NS_GPL(uncore_freq_remove_die_entry, INTEL_UNCORE_FREQUENCY);
 
-int uncore_freq_common_init(int (*read_control_freq)(struct uncore_data *data, unsigned int *value,
-						     enum uncore_index index),
-			    int (*write_control_freq)(struct uncore_data *data, unsigned int input,
-						      enum uncore_index index),
-			    int (*read_freq)(struct uncore_data *data, unsigned int *freq))
+int uncore_freq_common_init(int (*read)(struct uncore_data *data, unsigned int *value,
+					enum uncore_index index),
+			    int (*write)(struct uncore_data *data, unsigned int input,
+					 enum uncore_index index))
 {
 	mutex_lock(&uncore_lock);
 
-	uncore_read = read_control_freq;
-	uncore_write = write_control_freq;
-	uncore_read_freq = read_freq;
+	uncore_read = read;
+	uncore_write = write;
 
 	if (!uncore_root_kobj) {
 		struct device *dev_root = bus_get_dev_root(&cpu_subsys);
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
index 2d98931cd8e2..4c245b945e4e 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
@@ -69,13 +69,13 @@ struct uncore_data {
 enum uncore_index {
 	UNCORE_INDEX_MIN_FREQ,
 	UNCORE_INDEX_MAX_FREQ,
+	UNCORE_INDEX_CURRENT_FREQ,
 };
 
-int uncore_freq_common_init(int (*read_control_freq)(struct uncore_data *data, unsigned int *value,
-						     enum uncore_index index),
-			    int (*write_control_freq)(struct uncore_data *data, unsigned int input,
-						      enum uncore_index index),
-			    int (*uncore_read_freq)(struct uncore_data *data, unsigned int *freq));
+int uncore_freq_common_init(int (*read)(struct uncore_data *data, unsigned int *value,
+					enum uncore_index index),
+			    int (*write)(struct uncore_data *data, unsigned int input,
+					 enum uncore_index index));
 void uncore_freq_common_exit(void);
 int uncore_freq_add_entry(struct uncore_data *data, int cpu);
 void uncore_freq_remove_die_entry(struct uncore_data *data);
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index e6ec66eb2f03..8d8260781cf0 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -91,7 +91,7 @@ static void read_control_freq(struct tpmi_uncore_cluster_info *cluster_info,
 
 #define UNCORE_MAX_RATIO	FIELD_MAX(UNCORE_MAX_RATIO_MASK)
 
-/* Callback for sysfs read for max/min frequencies. Called under mutex locks */
+/* Helper for sysfs read for max/min frequencies. Called under mutex locks */
 static int uncore_read_control_freq(struct uncore_data *data, unsigned int *value,
 				    enum uncore_index index)
 {
@@ -207,7 +207,7 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 	return 0;
 }
 
-/* Callback for sysfs read for the current uncore frequency. Called under mutex locks */
+/* Helper for sysfs read for the current uncore frequency. Called under mutex locks */
 static int uncore_read_freq(struct uncore_data *data, unsigned int *freq)
 {
 	struct tpmi_uncore_cluster_info *cluster_info;
@@ -223,6 +223,24 @@ static int uncore_read_freq(struct uncore_data *data, unsigned int *freq)
 	return 0;
 }
 
+/* Callback for sysfs read for TPMI uncore values. Called under mutex locks. */
+static int uncore_read(struct uncore_data *data, unsigned int *value, enum uncore_index index)
+{
+	switch (index) {
+	case UNCORE_INDEX_MIN_FREQ:
+	case UNCORE_INDEX_MAX_FREQ:
+		return uncore_read_control_freq(data, value, index);
+
+	case UNCORE_INDEX_CURRENT_FREQ:
+		return uncore_read_freq(data, value);
+
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static void remove_cluster_entries(struct tpmi_uncore_struct *tpmi_uncore)
 {
 	int i;
@@ -273,8 +291,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 		return -EINVAL;
 
 	/* Register callbacks to uncore core */
-	ret = uncore_freq_common_init(uncore_read_control_freq, uncore_write_control_freq,
-				      uncore_read_freq);
+	ret = uncore_freq_common_init(uncore_read, uncore_write_control_freq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 433ddba4608e..f31a8912bb1f 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -114,6 +114,23 @@ static int uncore_read_freq(struct uncore_data *data, unsigned int *freq)
 	return 0;
 }
 
+static int uncore_read(struct uncore_data *data, unsigned int *value, enum uncore_index index)
+{
+	switch (index) {
+	case UNCORE_INDEX_MIN_FREQ:
+	case UNCORE_INDEX_MAX_FREQ:
+		return uncore_read_control_freq(data, value, index);
+
+	case UNCORE_INDEX_CURRENT_FREQ:
+		return uncore_read_freq(data, value);
+
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 /* Caller provides protection */
 static struct uncore_data *uncore_get_instance(unsigned int cpu)
 {
@@ -256,8 +273,7 @@ static int __init intel_uncore_init(void)
 	if (!uncore_instances)
 		return -ENOMEM;
 
-	ret = uncore_freq_common_init(uncore_read_control_freq, uncore_write_control_freq,
-				      uncore_read_freq);
+	ret = uncore_freq_common_init(uncore_read, uncore_write_control_freq);
 	if (ret)
 		goto err_free;
 
-- 
2.43.0


