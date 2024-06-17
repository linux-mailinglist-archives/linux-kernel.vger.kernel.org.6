Return-Path: <linux-kernel+bounces-216717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B19090A4FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924A71C26051
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCD3195FD9;
	Mon, 17 Jun 2024 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUG/fySt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818CD195F31;
	Mon, 17 Jun 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604446; cv=none; b=PHOx0KBZNf8cSSNiZiQAJvHXu5uTKF2p3YZBp/hZyQWSETJrTLwKLeS1HpjhPFhVQ8IL1cpUxY9CDbM8/8+8ATqGFWKSy5QEpH335pK/o0PrcruKUBXTyBTlVaz1sQ9TNbwZUpGFJCHZ7SbwNk9yBkvYO91PmYCGPeqNjo8c2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604446; c=relaxed/simple;
	bh=bIVKymQ9+PLi6mHIPvx1OZJY/3+VqvYt0uu9Ccw2RdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNNmjMY+rA0OGOesc0u0SBexZgMfXZ3x4Cc2xmAGvhBlllrjMOQmLE/cn54UiKmRK2vGPf16rH2rip67DE5//tzS/jNWr1cSk2J8WB3sRhjbyDNF1OAxAsHAbCaWb4MIK6q4itk+G6AdpLUIsgohlHkeLZUZKZ85VvTWjCPgDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUG/fySt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718604445; x=1750140445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bIVKymQ9+PLi6mHIPvx1OZJY/3+VqvYt0uu9Ccw2RdQ=;
  b=IUG/fySt1RvVF3sjyYevvjaFChRPkxDDq7dYvHeeBhZ2lfrZAbgLTWNj
   lTM23Di9s4E01Rl2VIxkW2+CpJhLcjRfVROKl26JcyS8nvYt3ZEB+MsW9
   UjEQjEvKH6aYzGzkGji2Sed/AyYEtn/nU3kZ9pjAEir7EDkUnekU+uf36
   ayik+t7jSFzzzpoC8LTnKdiyt/UrQH2LB4lN5s9ZVz7v4PxwYIFwrFw2q
   01ZznG2CMkBcIuSPz7i+weBMxZ3DZ2kplzBDNM5aReg00eMI29JioB9p2
   QR62x35EXYBijrfl79Uz7t1k52hJs7vZvwApNuQ4ac1T2v4j8wZb6m9gP
   w==;
X-CSE-ConnectionGUID: TTKJL/clQjavVFg3SnFYYA==
X-CSE-MsgGUID: 3lp9vQ6iTRO9+p1Yl0JHDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15138467"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15138467"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:24 -0700
X-CSE-ConnectionGUID: RIFWaEAVTT2lhtqsi9JhSw==
X-CSE-MsgGUID: E5NqtFfCReuYYsCogSzznQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41028199"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.69])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:22 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 4/7] platform/x86/intel-uncore-freq: Use uncore_index with read_control_freq
Date: Mon, 17 Jun 2024 09:04:37 +0300
Message-ID: <20240617060708.892981-5-tero.kristo@linux.intel.com>
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

Use the enumerated index for selecting the uncore driver parameter to
read, instead of reading everything. This is done in preparation to
expand the API to access more parameters later.

No functional change intended.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../uncore-frequency-common.c                 | 23 ++++++------
 .../uncore-frequency-common.h                 |  9 +++--
 .../uncore-frequency/uncore-frequency-tpmi.c  | 37 ++++++++++++-------
 .../intel/uncore-frequency/uncore-frequency.c | 10 +++--
 4 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 7daca46f9235..8d9817d70e27 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -19,7 +19,7 @@ static int uncore_instance_count;
 static DEFINE_IDA(intel_uncore_ida);
 
 /* callbacks for actual HW read/write */
-static int (*uncore_read)(struct uncore_data *data, unsigned int *min, unsigned int *max);
+static int (*uncore_read)(struct uncore_data *data, unsigned int *value, enum uncore_index index);
 static int (*uncore_write)(struct uncore_data *data, unsigned int input, enum uncore_index index);
 static int (*uncore_read_freq)(struct uncore_data *data, unsigned int *freq);
 
@@ -47,19 +47,16 @@ static ssize_t show_package_id(struct kobject *kobj, struct kobj_attribute *attr
 static ssize_t show_min_max_freq_khz(struct uncore_data *data,
 				      char *buf, enum uncore_index index)
 {
-	unsigned int min, max;
+	unsigned int value;
 	int ret;
 
 	mutex_lock(&uncore_lock);
-	ret = uncore_read(data, &min, &max);
+	ret = uncore_read(data, &value, index);
 	mutex_unlock(&uncore_lock);
 	if (ret)
 		return ret;
 
-	if (index == UNCORE_INDEX_MAX_FREQ)
-		return sprintf(buf, "%u\n", max);
-
-	return sprintf(buf, "%u\n", min);
+	return sprintf(buf, "%u\n", value);
 }
 
 static ssize_t store_min_max_freq_khz(struct uncore_data *data,
@@ -238,7 +235,8 @@ int uncore_freq_add_entry(struct uncore_data *data, int cpu)
 		sprintf(data->name, "package_%02d_die_%02d", data->package_id, data->die_id);
 	}
 
-	uncore_read(data, &data->initial_min_freq_khz, &data->initial_max_freq_khz);
+	uncore_read(data, &data->initial_min_freq_khz, UNCORE_INDEX_MIN_FREQ);
+	uncore_read(data, &data->initial_max_freq_khz, UNCORE_INDEX_MAX_FREQ);
 
 	ret = create_attr_group(data, data->name);
 	if (ret) {
@@ -269,10 +267,11 @@ void uncore_freq_remove_die_entry(struct uncore_data *data)
 }
 EXPORT_SYMBOL_NS_GPL(uncore_freq_remove_die_entry, INTEL_UNCORE_FREQUENCY);
 
-int uncore_freq_common_init(int (*read_control_freq)(struct uncore_data *data, unsigned int *min, unsigned int *max),
-			     int (*write_control_freq)(struct uncore_data *data, unsigned int input,
-						       enum uncore_index index),
-			     int (*read_freq)(struct uncore_data *data, unsigned int *freq))
+int uncore_freq_common_init(int (*read_control_freq)(struct uncore_data *data, unsigned int *value,
+						     enum uncore_index index),
+			    int (*write_control_freq)(struct uncore_data *data, unsigned int input,
+						      enum uncore_index index),
+			    int (*read_freq)(struct uncore_data *data, unsigned int *freq))
 {
 	mutex_lock(&uncore_lock);
 
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
index c6ceeda3f2bf..2d98931cd8e2 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
@@ -71,10 +71,11 @@ enum uncore_index {
 	UNCORE_INDEX_MAX_FREQ,
 };
 
-int uncore_freq_common_init(int (*read_control_freq)(struct uncore_data *data, unsigned int *min, unsigned int *max),
-			     int (*write_control_freq)(struct uncore_data *data, unsigned int input,
-						       enum uncore_index index),
-			     int (*uncore_read_freq)(struct uncore_data *data, unsigned int *freq));
+int uncore_freq_common_init(int (*read_control_freq)(struct uncore_data *data, unsigned int *value,
+						     enum uncore_index index),
+			    int (*write_control_freq)(struct uncore_data *data, unsigned int input,
+						      enum uncore_index index),
+			    int (*uncore_read_freq)(struct uncore_data *data, unsigned int *freq));
 void uncore_freq_common_exit(void);
 int uncore_freq_add_entry(struct uncore_data *data, int cpu);
 void uncore_freq_remove_die_entry(struct uncore_data *data);
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index c8e8c8087812..e6ec66eb2f03 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -78,20 +78,22 @@ struct tpmi_uncore_struct {
 
 /* Helper function to read MMIO offset for max/min control frequency */
 static void read_control_freq(struct tpmi_uncore_cluster_info *cluster_info,
-			     unsigned int *min, unsigned int *max)
+			     unsigned int *value, enum uncore_index index)
 {
 	u64 control;
 
 	control = readq(cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
-	*max = FIELD_GET(UNCORE_MAX_RATIO_MASK, control) * UNCORE_FREQ_KHZ_MULTIPLIER;
-	*min = FIELD_GET(UNCORE_MIN_RATIO_MASK, control) * UNCORE_FREQ_KHZ_MULTIPLIER;
+	if (index == UNCORE_INDEX_MAX_FREQ)
+		*value = FIELD_GET(UNCORE_MAX_RATIO_MASK, control) * UNCORE_FREQ_KHZ_MULTIPLIER;
+	else
+		*value = FIELD_GET(UNCORE_MIN_RATIO_MASK, control) * UNCORE_FREQ_KHZ_MULTIPLIER;
 }
 
 #define UNCORE_MAX_RATIO	FIELD_MAX(UNCORE_MAX_RATIO_MASK)
 
 /* Callback for sysfs read for max/min frequencies. Called under mutex locks */
-static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
-				    unsigned int *max)
+static int uncore_read_control_freq(struct uncore_data *data, unsigned int *value,
+				    enum uncore_index index)
 {
 	struct tpmi_uncore_cluster_info *cluster_info;
 
@@ -99,10 +101,11 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
 
 	if (cluster_info->root_domain) {
 		struct tpmi_uncore_struct *uncore_root = cluster_info->uncore_root;
-		int i, _min = 0, _max = 0;
+		unsigned int _min, _max, _value;
+		int i;
 
-		*min = UNCORE_MAX_RATIO * UNCORE_FREQ_KHZ_MULTIPLIER;
-		*max = 0;
+		_min = UNCORE_MAX_RATIO * UNCORE_FREQ_KHZ_MULTIPLIER;
+		_max = 0;
 
 		/*
 		 * Get the max/min by looking at each cluster. Get the lowest
@@ -113,17 +116,23 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
 
 			for (j = 0; j < uncore_root->pd_info[i].cluster_count; ++j) {
 				read_control_freq(&uncore_root->pd_info[i].cluster_infos[j],
-						  &_min, &_max);
-				if (*min > _min)
-					*min = _min;
-				if (*max < _max)
-					*max = _max;
+						  &_value, index);
+				if (_value < _min)
+					_min = _value;
+				if (_value > _max)
+					_max = _value;
 			}
 		}
+
+		if (index == UNCORE_INDEX_MIN_FREQ)
+			*value = _min;
+		else
+			*value = _max;
+
 		return 0;
 	}
 
-	read_control_freq(cluster_info, min, max);
+	read_control_freq(cluster_info, value, index);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 18ebd95080ed..433ddba4608e 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -42,8 +42,8 @@ static enum cpuhp_state uncore_hp_state __read_mostly;
 
 #define UNCORE_CURRENT_RATIO_MASK	GENMASK_ULL(6, 0)
 
-static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
-				    unsigned int *max)
+static int uncore_read_control_freq(struct uncore_data *data, unsigned int *value,
+				    enum uncore_index index)
 {
 	u64 cap;
 	int ret;
@@ -55,8 +55,10 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
 	if (ret)
 		return ret;
 
-	*max = FIELD_GET(UNCORE_MAX_RATIO_MASK, cap) * UNCORE_FREQ_KHZ_MULTIPLIER;
-	*min = FIELD_GET(UNCORE_MIN_RATIO_MASK, cap) * UNCORE_FREQ_KHZ_MULTIPLIER;
+	if (index == UNCORE_INDEX_MAX_FREQ)
+		*value = FIELD_GET(UNCORE_MAX_RATIO_MASK, cap) * UNCORE_FREQ_KHZ_MULTIPLIER;
+	else
+		*value = FIELD_GET(UNCORE_MIN_RATIO_MASK, cap) * UNCORE_FREQ_KHZ_MULTIPLIER;
 
 	return 0;
 }
-- 
2.43.0


