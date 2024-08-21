Return-Path: <linux-kernel+bounces-295562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19237959E57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728D0B25AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F919F46E;
	Wed, 21 Aug 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ri5v3YLQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D019ABAB;
	Wed, 21 Aug 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246023; cv=none; b=BSwiNGOsT2ybyYVWfoGvUr6H0CwVAcB8LdNAxdHfZHVZ/0hVxP5RoXWESjuqu6L2tM5yLl+YFx2m4UFKDcBe8r1nWmNGah7spSE3X/4NG1VMPpDsGo52gdRNKde6Kw5lnXUHhNlf1QPZ1EeUVZN1Wy33eUi/kyYvtLbHkpB4APA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246023; c=relaxed/simple;
	bh=xtbLYZNXUp+o9VccRXiKi6IVlaWqRoId2x7pfkY0tFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9NUDevf9jCBnM9bGVXRSf6zx7flU5AaysqApmbcgtgiLm5CjzLMTi7hG1m6I7U6b1ddp9v3ZtrHv1hKhJdi8We+E7ybYhBAdATK8+Z3W92DY2eAv8plq+c0qKnr6R4Q3nV9eBjT660vYGY65Z/TP3lnnY/OzfpGiipXj+N5YlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ri5v3YLQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724246022; x=1755782022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xtbLYZNXUp+o9VccRXiKi6IVlaWqRoId2x7pfkY0tFI=;
  b=Ri5v3YLQAoOQSae/+Nd+69qLfFgA/3DBbeuChX5uvtvd7J2qH2AHyaPR
   jv44HvYA0OJ5s9Hi66QnXnP59jjBjErycJtxbamqoS+dycniXs/xjB9oF
   wjUe8C13R7G83uyoAyycLmCS0OBkVc0SjaB41X7Oa2oCouVR9TII57Ur/
   y7YkoGcTswVxgdXOCgkR6IhZLdfYIpYKD8rCt81mLAR2Ulvab5Ol7KpVR
   xKXnG5fLlYBgjdpZ85ouTblTYqPSPg9Zt8BsR1JAE6HrUAQRHXdU56bOc
   hMOpoOdCOVVd/HQES9wBlw2teikB1lSj3/KxVrXZaNB44QJ6NXoVevGx4
   w==;
X-CSE-ConnectionGUID: GrKc/bx6T6O/XADevoOGRA==
X-CSE-MsgGUID: HlllM/QEQM6bywbGcUqxEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26399019"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26399019"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:13:36 -0700
X-CSE-ConnectionGUID: pP5Yif0PQAigFDTc8Y0Jzw==
X-CSE-MsgGUID: 3UiVsd06RdebToRBsv61iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66047775"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:13:34 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Documentation: admin-guide: pm: Add efficiency vs. latency tradeoff to uncore documentation
Date: Wed, 21 Aug 2024 16:10:28 +0300
Message-ID: <20240821131321.824326-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821131321.824326-1-tero.kristo@linux.intel.com>
References: <20240821131321.824326-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Added documentation about the functionality of efficiency vs. latency tradeoff
control in intel Xeon processors, and how this is configured via sysfs.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../pm/intel_uncore_frequency_scaling.rst     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
index 5ab3440e6cee..fb83aa2b744e 100644
--- a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
+++ b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
@@ -113,3 +113,54 @@ to apply at each uncore* level.
 
 Support for "current_freq_khz" is available only at each fabric cluster
 level (i.e., in uncore* directory).
+
+Efficiency vs. Latency Tradeoff
+-------------------------------
+
+In the realm of high-performance computing, particularly with Xeon
+processors, managing uncore frequency is an important aspect of system
+optimization. Traditionally, the uncore frequency is ramped up rapidly
+in high load scenarios. While this strategy achieves low latency, which
+is crucial for time-sensitive computations, it does not necessarily yield
+the best performance per watt, —a key metric for energy efficiency and
+operational cost savings.
+
+The Efficiency vs. Latency Control (ELC) feature allows user to influence
+the uncore frequency scaling algorithm. Hardware monitors the average CPU
+utilization across all cores at regular intervals. If the average CPU
+utilization is below a user defined threshold (elc_low_threshold_percent),
+the user defined uncore frequency floor frequency will be used
+(elc_floor_freq_khz), minimizing latency. Similarly in high load scenario
+where the CPU utilization goes above the high threshold value
+(elc_high_threshold_percent) instead of jumping to maximum uncore
+frequency, uncore frequency is increased in 100MHz steps until the power
+limit is reached.
+
+Attributes for efficiency latency control:
+
+``elc_floor_freq_khz``
+	This attribute is used to get/set the efficiency latency floor frequency.
+	If this variable is lower than the 'min_freq_khz', it is ignored by
+	the firmware.
+
+``elc_low_threshold_percent``
+	This attribute is used to get/set the efficiency latency control low
+	threshold. This attribute is in percentages of CPU utilization.
+
+``elc_high_threshold_percent``
+	This attribute is used to get/set the efficiency latency control high
+	threshold. This attribute is in percentages of CPU utilization.
+
+``elc_high_threshold_enable``
+	This attribute is used to enable/disable the efficiency latency control
+	high threshold. Write '1' to enable, '0' to disable.
+
+Example system configuration below, which does following:
+  * when CPU utilization is less than 10%: sets uncore frequency to 800MHz
+  * when CPU utilization is higher than 95%: increases uncore frequency in
+    100MHz steps, until power limit is reached
+
+  elc_floor_freq_khz:800000
+  elc_high_threshold_percent:95
+  elc_high_threshold_enable:1
+  elc_low_threshold_percent:10
-- 
2.43.1


