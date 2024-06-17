Return-Path: <linux-kernel+bounces-216716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F146D90A4F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B8AB24FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E39195FC0;
	Mon, 17 Jun 2024 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdnIaP76"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4A195B3B;
	Mon, 17 Jun 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604444; cv=none; b=gwomA+1ktnoWvEGyy2Xc1OxgOv/v0lL5sLyRkyz2JPDGWD840NOqZoCvCZwH01ydRH4EUipLifScUCJVIv2lvsCCmAscZ1k5WGo+8JU5L3/jYMmQb5jb2CB6Mdgqda9szY5GDQdhblG8LLkhfcXzVwnXCpEk8N9PuRKNh7QeAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604444; c=relaxed/simple;
	bh=trVupZUS2Mtb1JDbUh4F0hyrHCxAYYdbwUf1G/G4bOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FClSdnXupNDdBQMubj0bf8I0V0Nd+lHSoiBV5m+8THqPRPXMjIhHnQTk9SuoOdqKEdbP737mxRZrux3sK18hTladGOu0jjwhGKIMCKKuxvIxh7kTt9dowjYuQhEsLWONMr+Kp+BDbZMtb5dy7pzP6cbv4acDyYqhH8l8AFVMOFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdnIaP76; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718604443; x=1750140443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trVupZUS2Mtb1JDbUh4F0hyrHCxAYYdbwUf1G/G4bOg=;
  b=AdnIaP76QU7+GBetK20FP8gZ2cQzAYmCMWYEadNtpMe7JRDzeQtY/v/8
   W6SaeDPfQm9GsvNlICGRH9byYVt3a8fTrevNnRp6Iay9nV5ISQbYw7ioZ
   0By6mJU0LKVnWFEyP2QZCMLKnn9N7H7hMR219M+9wMGt/8ZqOuUK6CW3A
   Ihq11q2qAvzutHc4CUNRlfrAd4fgVoxPQcTeUncfPuZsapGS+J1RoheJ8
   k/L9XGkfKKGmQPSy9lNK4RTTKHiAJHFvMeYaTECPN5Q+He+FHtomlRAuE
   tIpcEh3RqSYQfLPn41i64bT89HOKxFcyjiJTFM0aW/JPD2sDzlKTRI+Pz
   Q==;
X-CSE-ConnectionGUID: B1LOtpqZSKu/pzig0YImeA==
X-CSE-MsgGUID: TSyq45DuRO+qVA7Hnze8UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15138461"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15138461"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:22 -0700
X-CSE-ConnectionGUID: 3On/po+YTtaOlE0lUndEsg==
X-CSE-MsgGUID: WXeOSIpNRa+hfOHxh12suQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41028191"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.69])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:20 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/7] platform/x86/intel-uncore-freq: Get rid of magic min_max argument
Date: Mon, 17 Jun 2024 09:04:36 +0300
Message-ID: <20240617060708.892981-4-tero.kristo@linux.intel.com>
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

Get rid of the hardcoded / magic min_max argument from internal APIs.
Instead, use an enumerated index value for it.

No functional change intended.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../uncore-frequency-common.c                 | 21 ++++++++++---------
 .../uncore-frequency-common.h                 |  8 ++++++-
 .../uncore-frequency/uncore-frequency-tpmi.c  | 18 +++++++++-------
 .../intel/uncore-frequency/uncore-frequency.c |  4 ++--
 4 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 33bb58dc3f78..7daca46f9235 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -20,7 +20,7 @@ static DEFINE_IDA(intel_uncore_ida);
 
 /* callbacks for actual HW read/write */
 static int (*uncore_read)(struct uncore_data *data, unsigned int *min, unsigned int *max);
-static int (*uncore_write)(struct uncore_data *data, unsigned int input, unsigned int min_max);
+static int (*uncore_write)(struct uncore_data *data, unsigned int input, enum uncore_index index);
 static int (*uncore_read_freq)(struct uncore_data *data, unsigned int *freq);
 
 static ssize_t show_domain_id(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
@@ -45,7 +45,7 @@ static ssize_t show_package_id(struct kobject *kobj, struct kobj_attribute *attr
 }
 
 static ssize_t show_min_max_freq_khz(struct uncore_data *data,
-				      char *buf, int min_max)
+				      char *buf, enum uncore_index index)
 {
 	unsigned int min, max;
 	int ret;
@@ -56,7 +56,7 @@ static ssize_t show_min_max_freq_khz(struct uncore_data *data,
 	if (ret)
 		return ret;
 
-	if (min_max)
+	if (index == UNCORE_INDEX_MAX_FREQ)
 		return sprintf(buf, "%u\n", max);
 
 	return sprintf(buf, "%u\n", min);
@@ -64,7 +64,7 @@ static ssize_t show_min_max_freq_khz(struct uncore_data *data,
 
 static ssize_t store_min_max_freq_khz(struct uncore_data *data,
 				      const char *buf, ssize_t count,
-				      int min_max)
+				      enum uncore_index index)
 {
 	unsigned int input;
 	int ret;
@@ -73,7 +73,7 @@ static ssize_t store_min_max_freq_khz(struct uncore_data *data,
 		return -EINVAL;
 
 	mutex_lock(&uncore_lock);
-	ret = uncore_write(data, input, min_max);
+	ret = uncore_write(data, input, index);
 	mutex_unlock(&uncore_lock);
 
 	if (ret)
@@ -125,11 +125,11 @@ static ssize_t show_perf_status_freq_khz(struct uncore_data *data, char *buf)
 		return show_perf_status_freq_khz(data, buf); \
 	}
 
-store_uncore_min_max(min_freq_khz, 0);
-store_uncore_min_max(max_freq_khz, 1);
+store_uncore_min_max(min_freq_khz, UNCORE_INDEX_MIN_FREQ);
+store_uncore_min_max(max_freq_khz, UNCORE_INDEX_MAX_FREQ);
 
-show_uncore_min_max(min_freq_khz, 0);
-show_uncore_min_max(max_freq_khz, 1);
+show_uncore_min_max(min_freq_khz, UNCORE_INDEX_MIN_FREQ);
+show_uncore_min_max(max_freq_khz, UNCORE_INDEX_MAX_FREQ);
 
 show_uncore_perf_status(current_freq_khz);
 
@@ -270,7 +270,8 @@ void uncore_freq_remove_die_entry(struct uncore_data *data)
 EXPORT_SYMBOL_NS_GPL(uncore_freq_remove_die_entry, INTEL_UNCORE_FREQUENCY);
 
 int uncore_freq_common_init(int (*read_control_freq)(struct uncore_data *data, unsigned int *min, unsigned int *max),
-			     int (*write_control_freq)(struct uncore_data *data, unsigned int input, unsigned int set_max),
+			     int (*write_control_freq)(struct uncore_data *data, unsigned int input,
+						       enum uncore_index index),
 			     int (*read_freq)(struct uncore_data *data, unsigned int *freq))
 {
 	mutex_lock(&uncore_lock);
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
index 0e5bf507e555..c6ceeda3f2bf 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
@@ -66,8 +66,14 @@ struct uncore_data {
 
 #define UNCORE_DOMAIN_ID_INVALID	-1
 
+enum uncore_index {
+	UNCORE_INDEX_MIN_FREQ,
+	UNCORE_INDEX_MAX_FREQ,
+};
+
 int uncore_freq_common_init(int (*read_control_freq)(struct uncore_data *data, unsigned int *min, unsigned int *max),
-			     int (*write_control_freq)(struct uncore_data *data, unsigned int input, unsigned int min_max),
+			     int (*write_control_freq)(struct uncore_data *data, unsigned int input,
+						       enum uncore_index index),
 			     int (*uncore_read_freq)(struct uncore_data *data, unsigned int *freq));
 void uncore_freq_common_exit(void);
 int uncore_freq_add_entry(struct uncore_data *data, int cpu);
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index b58294498921..c8e8c8087812 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -130,13 +130,13 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
 
 /* Helper function to write MMIO offset for max/min control frequency */
 static void write_control_freq(struct tpmi_uncore_cluster_info *cluster_info, unsigned int input,
-			      unsigned int min_max)
+			      unsigned int index)
 {
 	u64 control;
 
 	control = readq(cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
 
-	if (min_max) {
+	if (index == UNCORE_INDEX_MAX_FREQ) {
 		control &= ~UNCORE_MAX_RATIO_MASK;
 		control |= FIELD_PREP(UNCORE_MAX_RATIO_MASK, input);
 	} else {
@@ -149,7 +149,7 @@ static void write_control_freq(struct tpmi_uncore_cluster_info *cluster_info, un
 
 /* Callback for sysfs write for max/min frequencies. Called under mutex locks */
 static int uncore_write_control_freq(struct uncore_data *data, unsigned int input,
-				     unsigned int min_max)
+				     enum uncore_index index)
 {
 	struct tpmi_uncore_cluster_info *cluster_info;
 	struct tpmi_uncore_struct *uncore_root;
@@ -174,10 +174,10 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 
 			for (j = 0; j < uncore_root->pd_info[i].cluster_count; ++j)
 				write_control_freq(&uncore_root->pd_info[i].cluster_infos[j],
-						  input, min_max);
+						  input, index);
 		}
 
-		if (min_max)
+		if (index == UNCORE_INDEX_MAX_FREQ)
 			uncore_root->max_ratio = input;
 		else
 			uncore_root->min_ratio = input;
@@ -185,13 +185,15 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 		return 0;
 	}
 
-	if (min_max && uncore_root->max_ratio && uncore_root->max_ratio < input)
+	if (index == UNCORE_INDEX_MAX_FREQ && uncore_root->max_ratio &&
+	    uncore_root->max_ratio < input)
 		return -EINVAL;
 
-	if (!min_max && uncore_root->min_ratio && uncore_root->min_ratio > input)
+	if (index == UNCORE_INDEX_MIN_FREQ && uncore_root->min_ratio &&
+	    uncore_root->min_ratio > input)
 		return -EINVAL;
 
-	write_control_freq(cluster_info, input, min_max);
+	write_control_freq(cluster_info, input, index);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index d3fdae695bbd..18ebd95080ed 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -62,7 +62,7 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
 }
 
 static int uncore_write_control_freq(struct uncore_data *data, unsigned int input,
-				     unsigned int min_max)
+				     enum uncore_index index)
 {
 	int ret;
 	u64 cap;
@@ -78,7 +78,7 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 	if (ret)
 		return ret;
 
-	if (min_max) {
+	if (index == UNCORE_INDEX_MAX_FREQ) {
 		cap &= ~UNCORE_MAX_RATIO_MASK;
 		cap |= FIELD_PREP(UNCORE_MAX_RATIO_MASK, input);
 	} else  {
-- 
2.43.0


