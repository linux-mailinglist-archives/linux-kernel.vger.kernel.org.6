Return-Path: <linux-kernel+bounces-298340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176BD95C5F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75E0284F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831013C83D;
	Fri, 23 Aug 2024 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZURDUk63"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED02A13AD06;
	Fri, 23 Aug 2024 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396485; cv=none; b=geTccN/TaUzdktkJ0GSRQsDbSBvIOPZNaztxzoM3dEXuMmwSo6VwQ+ofjgZb6iUG0uRfpC/AGut5kJlMg4rD2EdzMvTR+lHuPnnHhQy5XN9K4wGPT0C+pf93z1tYVdJ2TYu3M5pJLxSsJkfYRa5iMIjJwwCIV3GaIpYpRk6EIyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396485; c=relaxed/simple;
	bh=/mQ+nFW7tD+wG4NYo2A7nzR5KtH1H0c10nCvLm2rll4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Esk1z7WTIFAMEEeOMEF/wHPL4i3COODRoz43GsDiuJwL0jUS5kXEvS5bpmvdXLbwgwDSk8vmIW703SehVePCD/DGAo0RdPHv/GVVXcgJ4TEpDCDsOfPl5monhGV2ksf6a7oHwfSKe1J+vlaOfXP+2O6xlcXuIa8bpMQsio4CCyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZURDUk63; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724396483; x=1755932483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mQ+nFW7tD+wG4NYo2A7nzR5KtH1H0c10nCvLm2rll4=;
  b=ZURDUk63IpIUKGAUa6FcbnIgtX2J4RrO2t67TE+O8R7ymf1PnO8n0zJU
   v+o1HxL4Y3B5Gko7hZtPws0CxtDVSqEj/KLQfz0ga5VnlEmnejlgfBlW6
   D1VHMNLa8Haz6Q62zK/pDIcqbXAQ9j1TT6wAJTILZ1osnvP2Fezk846cU
   xrXptJi+oEzlhafBBDPJ1tNbse23y/kQPKBufo6eK2Rbv2ymE4QrYxj/h
   waRWVeZxEZKEh84++A3qVETVGynAm4aBQh+emJKoTGZPuFgqOFZyeLZyK
   rvn9SukZBLBnFNpmEFeRNM60UL8hVq9NwOVhFuAmqUv6F9/KOclpyG9b1
   g==;
X-CSE-ConnectionGUID: 4lv5B7dOTSyT+tQT2cenjw==
X-CSE-MsgGUID: Xvp0JHqxTsCDGs9lhdp5wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26717153"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="26717153"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 00:01:22 -0700
X-CSE-ConnectionGUID: LVURrQ+2SvWIBBnsudZvhw==
X-CSE-MsgGUID: RCoLwkgsRQynrEh8k+G+Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="62004876"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa006.jf.intel.com with ESMTP; 23 Aug 2024 00:01:18 -0700
From: subramanian.mohan@intel.com
To: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com,
	david.zage@intel.com,
	srinivasan.chinnadurai@intel.com,
	subramanian.mohan@intel.com
Subject: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
Date: Fri, 23 Aug 2024 12:31:07 +0530
Message-Id: <20240823070109.27815-3-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240823070109.27815-1-subramanian.mohan@intel.com>
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
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
index 78dded03e5d8..75f7b094f963 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -246,3 +246,27 @@ delay between assert and clear edge as small as possible to reduce system
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
+        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
+
+Stop generating PPS signal::
+
+        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable
-- 
2.35.3


