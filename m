Return-Path: <linux-kernel+bounces-305296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E5B962C89
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F79528871F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717D61A3BC1;
	Wed, 28 Aug 2024 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkfKC15t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B91A257A;
	Wed, 28 Aug 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859434; cv=none; b=Qq1cn1sc/Ev5xugIbaCzl0WGUx85t2J4xfL726091hKL/vUVn7h71UYJf0J69BzuXglcVRLK1VZuQgXWOI+nGHGKIUquHHQp1MSwRU5YbCWX/+/SQGMrkTvRQL7Rj7HZfLLJR4Hn/t+6XM5vn4+lBozssF3pN3TABvstHsT5dF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859434; c=relaxed/simple;
	bh=OcPrd7nHRFmS4qTnofNkLKtGbq2pWyjfUsqWOPtLLOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8P5xXLna+lAKJd/yVbGspdm7jchmSM6kEP6p5Ha3g38da0w3WxRBfaNcbODd2UY0XyASmTMZW/Vkkh0cjIuFeBssby9qFL7iB3NhdV6rs4XnJV7lxEZzQd0vH8bObS4EVF7fg+AZTFsX8lQXX/CN/b/hKM0jLw/SxS0gBF56+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkfKC15t; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724859433; x=1756395433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OcPrd7nHRFmS4qTnofNkLKtGbq2pWyjfUsqWOPtLLOU=;
  b=VkfKC15tSFJjRU0iLoG7SevCnG3QHTp48XStZu/HROZhnZq5ZcBrmYlI
   NX9G9pG3O0II1nAeVweUX9PWBaa4LMjVCYv2W7D5sCAmIqH18EEXrrO7S
   csONsYVa3UgYVKyMmeAlXp3cUVFYx2Uui+vzq64A6jHkLxLp4HP2AVGpf
   wiTLGX4Iio3fGq/nqKIswJSiCUL/7SwYvL56ou0WBdovLFOpQ1lSIlTQb
   zyQChXeMLiiMasf7osMQEspOEB06/9zY82W9WS3urCN44BYLjIaqfu+JH
   sxkb37YN1T+YlfyuzZ0V4cBe7ix+7Xm6mim5cdh9MrdoyzVcIXQrJYe29
   A==;
X-CSE-ConnectionGUID: FpKgralESBOhp6UiIR7/Og==
X-CSE-MsgGUID: EvdNGSZFQESvXY/A6UTGaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34809269"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34809269"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:37:12 -0700
X-CSE-ConnectionGUID: G3cNEQ1GTSWzKAp0bkNF7A==
X-CSE-MsgGUID: RqG2TAn/RaOyIQJzLpx1sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="94064352"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:37:10 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] platform/x86/intel-uncore-freq: Add support for efficiency latency control
Date: Wed, 28 Aug 2024 18:34:54 +0300
Message-ID: <20240828153657.1296410-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828153657.1296410-1-tero.kristo@linux.intel.com>
References: <20240828153657.1296410-1-tero.kristo@linux.intel.com>
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
v2:
  * Converted a long sequence of if (...)'s to a switch

 .../uncore-frequency-common.h                 |   4 +
 .../uncore-frequency/uncore-frequency-tpmi.c  | 158 +++++++++++++++++-
 2 files changed, 160 insertions(+), 2 deletions(-)

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
index 9fa3037c03d1..50b28b4b1fc0 100644
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
@@ -137,6 +185,82 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *valu
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
+	switch (index) {
+	case UNCORE_INDEX_EFF_LAT_CTRL_LOW_THRESHOLD:
+		val *= FIELD_MAX(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK);
+		val /= 100;
+		control &= ~UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK;
+		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_LOW_THRESHOLD_MASK, val);
+		break;
+
+	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD:
+		val *= FIELD_MAX(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK);
+		val /= 100;
+		control &= ~UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK;
+		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_MASK, val);
+		break;
+
+	case UNCORE_INDEX_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE:
+		control &= ~UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE;
+		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_HIGH_THRESHOLD_ENABLE, val);
+		break;
+
+	case UNCORE_INDEX_EFF_LAT_CTRL_FREQ:
+		control &= ~UNCORE_EFF_LAT_CTRL_RATIO_MASK;
+		control |= FIELD_PREP(UNCORE_EFF_LAT_CTRL_RATIO_MASK, val);
+		break;
+
+	default:
+		break;
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
@@ -156,7 +280,7 @@ static void write_control_freq(struct tpmi_uncore_cluster_info *cluster_info, un
 	writeq(control, (cluster_info->cluster_base + UNCORE_CONTROL_INDEX));
 }
 
-/* Callback for sysfs write for max/min frequencies. Called under mutex locks */
+/* Helper for sysfs write for max/min frequencies. Called under mutex locks */
 static int uncore_write_control_freq(struct uncore_data *data, unsigned int input,
 				     enum uncore_index index)
 {
@@ -234,6 +358,33 @@ static int uncore_read(struct uncore_data *data, unsigned int *value, enum uncor
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
@@ -291,7 +442,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 		return -EINVAL;
 
 	/* Register callbacks to uncore core */
-	ret = uncore_freq_common_init(uncore_read, uncore_write_control_freq);
+	ret = uncore_freq_common_init(uncore_read, uncore_write);
 	if (ret)
 		return ret;
 
@@ -409,6 +560,9 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 
 			cluster_info->uncore_root = tpmi_uncore;
 
+			if (TPMI_MINOR_VERSION(pd_info->ufs_header_ver) >= UNCORE_ELC_SUPPORTED_VERSION)
+				cluster_info->elc_supported = true;
+
 			ret = uncore_freq_add_entry(&cluster_info->uncore_data, 0);
 			if (ret) {
 				cluster_info->cluster_base = NULL;
-- 
2.43.1


