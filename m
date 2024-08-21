Return-Path: <linux-kernel+bounces-295563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C5F959E58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE0728237F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB00B1A285C;
	Wed, 21 Aug 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tc/3glVP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469219ABB6;
	Wed, 21 Aug 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246023; cv=none; b=LyNtEQiN9JTfNbtymXeK3hsDlEeX942XYiyxRBPtDKOeJFXUFddkG4JOKznkm0GfZbk5hbGwb34L9KXG0w7JaHwF6Tsidl9EisY8QqVbgcLLwAkrTcpfxnYFI9AEyF4od5fwHjAENQ8GdbxLnNBjbJSO+h6easjFJo5/Qupgmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246023; c=relaxed/simple;
	bh=FfHj64DjgU96jfJY2kFWaP+2L0tmcgPb5CSjo6LuQvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aagV5IHFQ1U6wMMoD9g2gHTGwFMz/P/VHdJ9E+fpABp+ZByVf/YgPbnPKMw4I3R8HifACZpbHpbGSNApcoMPWxGXm1JEgmJgbZcmgTxDxh2uts47Hs1JS7rID3VlAB5UiRo/u7QlS/Q587CadMbqb3cFArGWWDMmNlav/CZk9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tc/3glVP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724246022; x=1755782022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FfHj64DjgU96jfJY2kFWaP+2L0tmcgPb5CSjo6LuQvU=;
  b=Tc/3glVPaAce0ZQEl/3k6lBV9fCqORE74F6YEW7qf+183oE2UllcRp0l
   s6qN6tbnAnanSHdg0rqWPc3YIQ/4TfJkmfxSKUMb5fu4IojGMlG8W3rh8
   yrTUuvYpkJJ8beJ6KQ6GWSAJrfmLeK10/5eoh/Hjccu4wAWJXtZv8jx9P
   dKoHPI2jJ1EdtQM+HFYKDXWWkNb5YxngshCUB0Y1Nk5tcvdJKfkx2Dd7U
   HZbTHx4NQz4kvCey4i8YM5GseBTb6m4wsR0xsaGE/fOFFp6Icn6ktnI6/
   h6F3aNfJ+LDReqzdHc6Ade+Qwt2aYmgN1QrSs+61+CVhdfd6DZMqcI1xe
   A==;
X-CSE-ConnectionGUID: E384lip8T0eWBvuYGd8IMQ==
X-CSE-MsgGUID: Qoi7L9V4R2OARP60wslrIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26399023"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26399023"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:13:38 -0700
X-CSE-ConnectionGUID: 95GGoDHiSpWYE9OwukaACg==
X-CSE-MsgGUID: JMBJb5xETB6GT2/4Nuxv7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66047782"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:13:37 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86/intel-uncore-freq: Add support for efficiency latency control
Date: Wed, 21 Aug 2024 16:10:29 +0300
Message-ID: <20240821131321.824326-3-tero.kristo@linux.intel.com>
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

Add efficiency latency control support to the TPMI uncore driver. This
defines two new threshold values for controlling uncore frequency, low
threshold and high threshold. When CPU utilization is below low threshold,
the user configurable floor latency control frequency can be used by the
system. When CPU utilization is above high threshold, the uncore frequency
is increased in 100MHz steps until power limit is reached.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../uncore-frequency-common.h                 |   4 +
 .../uncore-frequency/uncore-frequency-tpmi.c  | 153 +++++++++++++++++-
 2 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
index 4c245b945e4e..b5c7311bfa05 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
@@ -70,6 +70,10 @@ enum uncore_index {
 	UNCORE_INDEX_MIN_FREQ,
 	UNCORE_INDEX_MAX_FREQ,
 	UNCORE_INDEX_CURRENT_FREQ,
+	UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD,
+	UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD,
+	UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE,
+	UNCORE_INDEX_EFF_LAT_CTRL_FREQ,
 };
 
 int uncore_freq_common_init(int (*read)(struct uncore_data *data, unsigned int *value,
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 9fa3037c03d1..3a83b6ce54a5 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -30,6 +30,7 @@
 
 #define	UNCORE_MAJOR_VERSION		0
 #define	UNCORE_MINOR_VERSION		2
+#define UNCORE_ELC_SUPPORTED_VERSION	2
 #define UNCORE_HEADER_INDEX		0
 #define UNCORE_FABRIC_CLUSTER_OFFSET	8
 
@@ -46,6 +47,7 @@ struct tpmi_uncore_struct;
 /* Information for each cluster */
 struct tpmi_uncore_cluster_info {
 	bool root_domain;
+	bool elc_supported;
 	u8 __iomem *cluster_base;
 	struct uncore_data uncore_data;
 	struct tpmi_uncore_struct *uncore_root;
@@ -75,6 +77,10 @@ struct tpmi_uncore_struct {
 /* Bit definitions for CONTROL register */
 #define UNCORE_MAX_RATIO_MASK				GENMASK_ULL(14, 8)
 #define UNCORE_MIN_RATIO_MASK				GENMASK_ULL(21, 15)
+#define UNCORE_EFF_LAT_CTRL_RATIO_MASK			GENMASK_ULL(28, 22)
+#define UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK		GENMASK_ULL(38, 32)
+#define UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE	BIT(39)
+#define UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK		GENMASK_ULL(46, 40)
 
 /* Helper function to read MMIO offset for max/min control frequency */
 static void read_control_freq(struct tpmi_uncore_cluster_info *cluster_info,
@@ -89,6 +95,48 @@ static void read_control_freq(struct tpmi_uncore_cluster_info *cluster_info,
 		*value = FIELD_GET(UNCORE_MIN_RATIO_MASK, control) * UNCORE_FREQ_KHZ_MULTIPLIER;
 }
 
+/* Helper function to read efficiency latency control values over MMIO */
+static int read_eff_lat_ctrl(struct uncore_data *data, unsigned int *val, enum uncore_index index)
+{
+	struct tpmi_uncore_cluster_info *cluster_info;
+	u64 ctrl;
+
+	cluster_info = container_of(data, struct tpmi_uncore_cluster_info, uncore_data);
+	if (cluster_info->root_domain)
+		return -ENODATA;
+
+	if (!cluster_info->elc_supported)
+		return -EOPNOTSUPP;
+
+	ctrl = readq(cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
+
+	switch (index) {
+	case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
+		*val = FIELD_GET(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK, ctrl);
+		*val *= 100;
+		*val = DIV_ROUND_UP(*val, FIELD_MAX(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK));
+		break;
+
+	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
+		*val = FIELD_GET(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK, ctrl);
+		*val *= 100;
+		*val = DIV_ROUND_UP(*val, FIELD_MAX(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK));
+		break;
+
+	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
+		*val = FIELD_GET(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE, ctrl);
+		break;
+	case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
+		*val = FIELD_GET(UNCORE_EFF_LAT_CTRL_RATIO_MASK, ctrl) * UNCORE_FREQ_KHZ_MULTIPLIER;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 #define UNCORE_MAX_RATIO	FIELD_MAX(UNCORE_MAX_RATIO_MASK)
 
 /* Helper for sysfs read for max/min frequencies. Called under mutex locks */
@@ -137,6 +185,77 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *valu
 	return 0;
 }
 
+/* Helper function for writing efficiency latency control values over MMIO */
+static int write_eff_lat_ctrl(struct uncore_data *data, unsigned int val, enum uncore_index index)
+{
+	struct tpmi_uncore_cluster_info *cluster_info;
+	u64 control;
+
+	cluster_info = container_of(data, struct tpmi_uncore_cluster_info, uncore_data);
+
+	if (cluster_info->root_domain)
+		return -ENODATA;
+
+	if (!cluster_info->elc_supported)
+		return -EOPNOTSUPP;
+
+	switch (index) {
+	case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
+		if (val > 100)
+			return -EINVAL;
+		break;
+
+	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
+		if (val > 100)
+			return -EINVAL;
+		break;
+
+	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
+		if (val > 1)
+			return -EINVAL;
+		break;
+
+	case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
+		val /= UNCORE_FREQ_KHZ_MULTIPLIER;
+		if (val > FIELD_MAX(UNCORE_EFF_LAT_CTRL_RATIO_MASK))
+			return -EINVAL;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	control = readq(cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
+
+	if (index == UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD) {
+		val *= FIELD_MAX(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK);
+		val /= 100;
+		control &= ~UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK;
+		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK, val);
+	}
+
+	if (index == UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD) {
+		val *= FIELD_MAX(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK);
+		val /= 100;
+		control &= ~UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK;
+		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK, val);
+	}
+
+	if (index == UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE) {
+		control &= ~UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE;
+		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE, val);
+	}
+
+	if (index == UNCORE_INDEX_EFF_LAT_CTRL_FREQ) {
+		control &= ~UNCORE_EFF_LAT_CTRL_RATIO_MASK;
+		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_RATIO_MASK, val);
+	}
+
+	writeq(control, cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
+
+	return 0;
+}
+
 /* Helper function to write MMIO offset for max/min control frequency */
 static void write_control_freq(struct tpmi_uncore_cluster_info *cluster_info, unsigned int input,
 			      unsigned int index)
@@ -156,7 +275,7 @@ static void write_control_freq(struct tpmi_uncore_cluster_info *cluster_info, un
 	writeq(control, (cluster_info->cluster_base + UNCORE_CONTROL_INDEX));
 }
 
-/* Callback for sysfs write for max/min frequencies. Called under mutex locks */
+/* Helper for sysfs write for max/min frequencies. Called under mutex locks */
 static int uncore_write_control_freq(struct uncore_data *data, unsigned int input,
 				     enum uncore_index index)
 {
@@ -234,6 +353,33 @@ static int uncore_read(struct uncore_data *data, unsigned int *value, enum uncor
 	case UNCORE_INDEX_CURRENT_FREQ:
 		return uncore_read_freq(data, value);
 
+	case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
+	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
+	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
+	case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
+		return read_eff_lat_ctrl(data, value, index);
+
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/* Callback for sysfs write for TPMI uncore data. Called under mutex locks. */
+static int uncore_write(struct uncore_data *data, unsigned int value, enum uncore_index index)
+{
+	switch (index) {
+	case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
+	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
+	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
+	case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
+		return write_eff_lat_ctrl(data, value, index);
+
+	case UNCORE_INDEX_MIN_FREQ:
+	case UNCORE_INDEX_MAX_FREQ:
+		return uncore_write_control_freq(data, value, index);
+
 	default:
 		break;
 	}
@@ -291,7 +437,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 		return -EINVAL;
 
 	/* Register callbacks to uncore core */
-	ret = uncore_freq_common_init(uncore_read, uncore_write_control_freq);
+	ret = uncore_freq_common_init(uncore_read, uncore_write);
 	if (ret)
 		return ret;
 
@@ -409,6 +555,9 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 
 			cluster_info->uncore_root = tpmi_uncore;
 
+			if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) >= UNCORE_ELC_SUPPORTED_VERSION)
+				cluster_info->elc_supported = true;
+
 			ret = uncore_freq_add_entry(&cluster_info->uncore_data, 0);
 			if (ret) {
 				cluster_info->cluster_base = NULL;
-- 
2.43.1


