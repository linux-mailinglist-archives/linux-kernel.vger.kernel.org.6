Return-Path: <linux-kernel+bounces-520872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4FFA3B046
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CCE1728A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84B1B0F20;
	Wed, 19 Feb 2025 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyurA9Kc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145B1AF0BC;
	Wed, 19 Feb 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739937997; cv=none; b=T/Fi0OynEgfkJVwm3cC7xu5WAJfmX+B9R+S+OECPa5/g4fYWQOTAl0Tleqlu3S1jM0O6n13V/ZuiSS2WTXLV72GUkJgF+EIdNmCTU16e8tl5TDzT/L0tizynqhFofYEEnqvSYTz7VVXCdVIXMW5Bh5vIs6oqCUa9bGTmCAKr0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739937997; c=relaxed/simple;
	bh=syILJRFICNuwfc1hr1rVckmFJF5JIVDUFUmPw1y28sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcbhsnOHfB7IR+wZmJ+vqm5sKqSxlweiRhr9TaLmVjK61qGzudHe2kVleGEJGXsf/uEqavgotqx5bIo2Nt1/f4b+rf/MvByrcvlny9xgucKOIy5yBXjSAuRQ2CFkgKa7i+d+YJY5TozwW1G/ZpF7rU9ltkOGWhCy2fcvMKQ0KX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyurA9Kc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739937996; x=1771473996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=syILJRFICNuwfc1hr1rVckmFJF5JIVDUFUmPw1y28sU=;
  b=MyurA9KcgBYfK3XOTaOXuTnzdE1y6iJjPyHMLWlvubC505Ps+EVS3JtT
   WHzxqG2DEFzSZlpOUm0c6Zp5X2cWs7I3wRlLfHt4VQLf8FSihk0abVAYD
   kDs5hbVIeZHm1NT8d4AP1tZgCIzQPFpZ9m5/NYORmVIWas91FqEvyO92M
   ElH8GtxSE4fddcBq/886IgUZM7ESTUjTVovZEHkramOWyx3Ypxa4W+xQx
   Rmmpwu4RSNTTkzKX+x8KSPuTcaOCvvxOiTMdRaBc7TWfGL6mdE5TzI4zS
   Lk+lFBXraQAQ9y8SBU25cCw1475BmbNczG/bohKHT/21LuAqzbTrmWuHS
   Q==;
X-CSE-ConnectionGUID: bF2uM5nZSUyALFxMf1ZOzA==
X-CSE-MsgGUID: bmr8g4NrQz6ANy79NBvYAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44579163"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="44579163"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 20:06:36 -0800
X-CSE-ConnectionGUID: RIQ/jYwtScS0e80qqyim9Q==
X-CSE-MsgGUID: zzfwmuvcSJmLCx4Zej6V2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="119703828"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 20:06:31 -0800
From: subramanian.mohan@intel.com
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	giometti@enneenne.com,
	tglx@linutronix.de,
	corbet@lwn.net
Cc: eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com,
	david.zage@intel.com,
	srinivasan.chinnadurai@intel.com,
	subramanian.mohan@intel.com
Subject: [PATCH v15 3/4] Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
Date: Wed, 19 Feb 2025 09:36:17 +0530
Message-Id: <20250219040618.70962-4-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250219040618.70962-1-subramanian.mohan@intel.com>
References: <20250219040618.70962-1-subramanian.mohan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Subramanian Mohan <subramanian.mohan@intel.com>

Add Intel Timed I/O PPS usage instructions.

Co-developed-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
---
 Documentation/driver-api/pps.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 04f1b88778fc..598729f9cd27 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -285,3 +285,27 @@ delay between assert and clear edge as small as possible to reduce system
 latencies. But if it is too small slave won't be able to capture clear edge
 transition. The default of 30us should be good enough in most situations.
 The delay can be selected using 'delay' pps_gen_parport module parameter.
+
+
+Intel Timed I/O PPS signal generator
+------------------------------------
+
+Intel Timed I/O is a high precision device, present on 2019 and newer Intel
+CPUs, that can generate PPS signals.
+
+Timed I/O and system time are both driven by same hardware clock. The signal
+is generated with a precision of ~20 nanoseconds. The generated PPS signal
+is used to synchronize an external device with system clock. For example,
+it can be used to share your clock with a device that receives PPS signal,
+generated by Timed I/O device. There are dedicated Timed I/O pins to deliver
+the PPS signal to an external device.
+
+Usage of Intel Timed I/O as PPS generator:
+
+Start generating PPS signal::
+
+        $echo 1 > /sys/class/pps-gen/pps-genx/enable
+
+Stop generating PPS signal::
+
+        $echo 0 > /sys/class/pps-gen/pps-genx/enable
-- 
2.35.3


