Return-Path: <linux-kernel+bounces-305295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA1962C87
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5D41F2342F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A2C1A38D2;
	Wed, 28 Aug 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TD/5JiYO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D1F188014;
	Wed, 28 Aug 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859432; cv=none; b=Lsz4je/uy/S61+x1u4Zzt0U/606ze9bLwU+iIEjF7Rz3QHDQFEhDtxiBwxkPHQ+h5tR6e1f9TibyuYZ+jv/VKqBb0hMtMvtR92L6QXld5/2MrIEtEvnQ7zNUdmjxibu00aKx4HsIBxoWBYpbXcq8rHFK/G1eE1JO468OpzpH07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859432; c=relaxed/simple;
	bh=wveWSOl2iDkmjfaAlSQRHxBeV10WS1rrCw3NusQw5lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYjFmuiUI7G2V5KvaT0gxd2irI+p6N/kgfdvw6v6qk01CKzQk9hJpSzf6y+rnsTVWbIROU5if+ws3FfZ5I6sNkwncUxp3dc0312d+RG95bik8mtuu5oAIVWoZOo5pWfs1JJvZetpWIEyvHCv1Tz3npgiTdbvdSYIuSOw5NTfcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TD/5JiYO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724859431; x=1756395431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wveWSOl2iDkmjfaAlSQRHxBeV10WS1rrCw3NusQw5lY=;
  b=TD/5JiYOLZDA4aG6uoSUJgml9qj4u2fqzEnSzUutsNVVPpgZ+uWRl1YN
   ZPurkokezlx/YJEAAkM+c8QK1P79K+mDS9q2O+wKItsZ/CPuq5Jw1jBUP
   S0V2Yq1DWsfylbKXZQJa4QSUFJCYiUVT5WS7jR7zz36pdFVjHy8dK6jZ7
   YC9uldpaHUgtnTUL25JaDap3MkyQkUtkJiWQF8SQ3whxXufwgUQ4TgNri
   qljP258YPnFtwfUNzEjItjS/ilK08DKvTL0LGN5OR2D+AVqKwXcwaNvWK
   nu3XKyXkk2oVvfMts2JXdANlCZWCJmQ55239qpLNAnfN9Jvd01fsEtsTB
   A==;
X-CSE-ConnectionGUID: dGncf+ARQ02xoggb4YH5TA==
X-CSE-MsgGUID: 97xbgd+pS++fUiLjLPMGQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34809263"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34809263"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:37:10 -0700
X-CSE-ConnectionGUID: U727z7dAREWjQiuJb+buOw==
X-CSE-MsgGUID: 8oi2PM+SQo64uuFEK+gq5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="94064340"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:37:08 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Documentation: admin-guide: pm: Add efficiency vs. latency tradeoff to uncore documentation
Date: Wed, 28 Aug 2024 18:34:53 +0300
Message-ID: <20240828153657.1296410-2-tero.kristo@linux.intel.com>
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

Added documentation about the functionality of efficiency vs. latency tradeoff
control in intel Xeon processors, and how this is configured via sysfs.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
v2:
  * Largely re-wrote the documentation

 .../pm/intel_uncore_frequency_scaling.rst     | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
index 5ab3440e6cee..26ded32b06f5 100644
--- a/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
+++ b/Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
@@ -113,3 +113,62 @@ to apply at each uncore* level.
 
 Support for "current_freq_khz" is available only at each fabric cluster
 level (i.e., in uncore* directory).
+
+Efficiency vs. Latency Tradeoff
+-------------------------------
+
+The Efficiency Latency Control (ELC) feature improves performance
+per watt. With this feature hardware power management algorithms
+optimize trade-off between latency and power consumption. For some
+latency sensitive workloads further tuning can be done by SW to
+get desired performance.
+
+The hardware monitors the average CPU utilization across all cores
+in a power domain at regular intervals and decides an uncore frequency.
+While this may result in the best performance per watt, workload may be
+expecting higher performance at the expense of power. Consider an
+application that intermittently wakes up to perform memory reads on an
+otherwise idle system. In such cases, if hardware lowers uncore
+frequency, then there may be delay in ramp up of frequency to meet
+target performance.
+
+The ELC control defines some parameters which can be changed from SW.
+If the average CPU utilization is below a user defined threshold
+(elc_low_threshold_percent attribute below), the user defined uncore
+frequency floor frequency will be used (elc_floor_freq_khz attribute
+below) instead of hardware calculated minimum.
+
+Similarly in high load scenario where the CPU utilization goes above
+the high threshold value (elc_high_threshold_percent attribute below)
+instead of jumping to maximum uncore frequency, frequency is increased
+in 100MHz steps. This avoids consuming unnecessarily high power
+immediately with CPU utilization spikes.
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


