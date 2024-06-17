Return-Path: <linux-kernel+bounces-216720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876F90A4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A910E289D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B3019645C;
	Mon, 17 Jun 2024 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtJUpq5L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE40184122;
	Mon, 17 Jun 2024 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604456; cv=none; b=MzG+gUXrapOLIuna+x3xBEvN4ArMSm1djdqfxv5UTWWlNpy+vKmqWtp1ZpL4I9whisAW7SZB6n9KKnZBke09E5Rj80QsJn2+20C3FbcwBwC3rORiq+n2yywNntFRHn8beDYxPdBz8QxyFCKsj2KUERSSADytoUZyk3AA9Uxao38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604456; c=relaxed/simple;
	bh=vqYHgmndpHwLEmhD1XkZhw75vBOpWNqXGoDCVlx6mkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkmZtOMUQNyAO57iegSucqlVlt7LwpuLicf4Gn7g7GCvrGgwTckWyS8QCa/Zlfu+WdC5JTtM1w5TxU11QYy/wTQ7wfSjI88TwBKMOawTpDRhkuotdJuI0jj3tkBKQHuck8oxgLZ7U/CReN9rulk0x59ga6ex5w7OGUAXXnRs7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtJUpq5L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718604455; x=1750140455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vqYHgmndpHwLEmhD1XkZhw75vBOpWNqXGoDCVlx6mkA=;
  b=YtJUpq5LvcBGvVpHHFewxT/EILShqr8crKvI/vn7hcBT8ycb6mNMI14z
   Bxyu0WQsJMJd+ULLx/9qCiZ8oBg59pi9gM4bPg+WlU9ytwD+FsgZUrDpA
   0fEmI4QEL6UwjTWuyTScr029VZAh948XYxShui43KaIzccX0rmolxhxqT
   IY/BYyUOStgINaKjnZ1bQLAtWFloX42IKpTtrT7OT+lQ1QFUHTnG6W+10
   edKeT+cj1JFau+Eo3GB0DaLHay8gCGQEYJL9fY9X3hJeVc/8rZXoRoa5X
   7pEacOZD8plR63TSMlDS0PsH+JEUrv+it/trhW4bdVqpyXfuA4vN71eDT
   Q==;
X-CSE-ConnectionGUID: 4HHR+f4HRmCw96O4pYGPIA==
X-CSE-MsgGUID: 0+skqEDzSqKcEVmb8bAbgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15138486"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15138486"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:32 -0700
X-CSE-ConnectionGUID: 1iDcfLyGRBCJoTxbv0amYg==
X-CSE-MsgGUID: i8VxggnaT2OrFT1359YTrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41028219"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.69])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:27 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 6/7] platform/x86/intel-uncore-freq: Rename the sysfs helper macro names
Date: Mon, 17 Jun 2024 09:04:39 +0300
Message-ID: <20240617060708.892981-7-tero.kristo@linux.intel.com>
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

The macros to create sysfs entries are going to be used for other
attributes in addition to current min/max frequencies only, so rename
these to be more generic.

No functional change intended.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../uncore-frequency-common.c                 | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index cfbff057458d..9356a0f322e6 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -43,8 +43,7 @@ static ssize_t show_package_id(struct kobject *kobj, struct kobj_attribute *attr
 	return sprintf(buf, "%u\n", data->package_id);
 }
 
-static ssize_t show_min_max_freq_khz(struct uncore_data *data,
-				      char *buf, enum uncore_index index)
+static ssize_t show_attr(struct uncore_data *data, char *buf, enum uncore_index index)
 {
 	unsigned int value;
 	int ret;
@@ -58,9 +57,8 @@ static ssize_t show_min_max_freq_khz(struct uncore_data *data,
 	return sprintf(buf, "%u\n", value);
 }
 
-static ssize_t store_min_max_freq_khz(struct uncore_data *data,
-				      const char *buf, ssize_t count,
-				      enum uncore_index index)
+static ssize_t store_attr(struct uncore_data *data, const char *buf, ssize_t count,
+			  enum uncore_index index)
 {
 	unsigned int input;
 	int ret;
@@ -92,24 +90,23 @@ static ssize_t show_perf_status_freq_khz(struct uncore_data *data, char *buf)
 	return sprintf(buf, "%u\n", freq);
 }
 
-#define store_uncore_min_max(name, min_max)				\
+#define store_uncore_attr(name, index)					\
 	static ssize_t store_##name(struct kobject *kobj,		\
 				     struct kobj_attribute *attr,	\
 				     const char *buf, size_t count)	\
 	{								\
 		struct uncore_data *data = container_of(attr, struct uncore_data, name##_kobj_attr);\
 									\
-		return store_min_max_freq_khz(data, buf, count,	\
-					      min_max);		\
+		return store_attr(data, buf, count, index);		\
 	}
 
-#define show_uncore_min_max(name, min_max)				\
+#define show_uncore_attr(name, index)					\
 	static ssize_t show_##name(struct kobject *kobj,		\
 				    struct kobj_attribute *attr, char *buf)\
 	{                                                               \
 		struct uncore_data *data = container_of(attr, struct uncore_data, name##_kobj_attr);\
 									\
-		return show_min_max_freq_khz(data, buf, min_max);	\
+		return show_attr(data, buf, index);			\
 	}
 
 #define show_uncore_perf_status(name)					\
@@ -121,11 +118,11 @@ static ssize_t show_perf_status_freq_khz(struct uncore_data *data, char *buf)
 		return show_perf_status_freq_khz(data, buf); \
 	}
 
-store_uncore_min_max(min_freq_khz, UNCORE_INDEX_MIN_FREQ);
-store_uncore_min_max(max_freq_khz, UNCORE_INDEX_MAX_FREQ);
+store_uncore_attr(min_freq_khz, UNCORE_INDEX_MIN_FREQ);
+store_uncore_attr(max_freq_khz, UNCORE_INDEX_MAX_FREQ);
 
-show_uncore_min_max(min_freq_khz, UNCORE_INDEX_MIN_FREQ);
-show_uncore_min_max(max_freq_khz, UNCORE_INDEX_MAX_FREQ);
+show_uncore_attr(min_freq_khz, UNCORE_INDEX_MIN_FREQ);
+show_uncore_attr(max_freq_khz, UNCORE_INDEX_MAX_FREQ);
 
 show_uncore_perf_status(current_freq_khz);
 
-- 
2.43.0


