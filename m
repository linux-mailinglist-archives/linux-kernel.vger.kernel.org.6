Return-Path: <linux-kernel+bounces-293623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81580958213
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA37B24CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B618C35D;
	Tue, 20 Aug 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAOtWpTp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD518C34F;
	Tue, 20 Aug 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145874; cv=none; b=HDyyV17i3rTkku3+PXSHBuVDZfqx61wHb2MQzNhTRbYUkCFlhL/7dbH1QLSA8dZJGMHviU1n8HVMmlkMHl5TVrOSKndsmF7fmN6pz+biTCAHlz2XmY/bYA9r7zCFyc2rKEWHrq97oFNIcnWtQ9w7sj6OcymFOFRtd4LjvLgWRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145874; c=relaxed/simple;
	bh=/mQ+nFW7tD+wG4NYo2A7nzR5KtH1H0c10nCvLm2rll4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KKCF3w5duVt1/66CwUokrV2rv26yAy8id0/PrBP9GGjw4IUkvPeg5fYgymFqeIhHqN8Xr5cQhfc9DDpojXuCoSIc1x6w/CyGvXDy5pYq0Njmp5v+Y3e7a3iO+SEUev3qwXZk6tD2G8MAqlUn3Jfwn8WrKM7dm0rltmvxx8vKiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAOtWpTp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724145874; x=1755681874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mQ+nFW7tD+wG4NYo2A7nzR5KtH1H0c10nCvLm2rll4=;
  b=SAOtWpTpABcU9rSEZtPQz0Ra5Mc3lpug1upQDZacN05N+zCYAqOLjN+b
   iXzllXKfSfOCxnNYpgcC6aKdY7IidgG8h+oTPF2BXtad10FuAFJEAu+sK
   DafpNPLC+2tG5M4/x65E6ezUvBTOCspX0xbEG0xPjSE4enUjOi5KwOslS
   jp3pyasqWQ9maQxNsY99v5aQcW67agm1JlWAERUpiOZuOBhlKV+3AWmzV
   CUc7z+tyPA4NsV6ok+rd+Whgjd7MqrRLvkM0/UgXjlF5zacSef2Du7L1U
   WZAnG+hhVzAWVHeYTfB13OpXVW/ukvP84p2qQgpzG6TfuyuG1LRTT3B2w
   g==;
X-CSE-ConnectionGUID: m+28EFhORJeeuxzwqe3G4Q==
X-CSE-MsgGUID: Lf4NXZF5QF2qDImF4LDh8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22578415"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22578415"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:24:33 -0700
X-CSE-ConnectionGUID: ci4tsqxGTDqpAMne1oiGTA==
X-CSE-MsgGUID: pOkgC/oUS9++N0dGsvs7sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65495047"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa003.jf.intel.com with ESMTP; 20 Aug 2024 02:24:30 -0700
From: subramanian.mohan@intel.com
To: linux-drivers-review@eclists.intel.com,
	tglx@linutronix.de,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com
Subject: [PATCH v11 2/3] Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
Date: Tue, 20 Aug 2024 14:54:19 +0530
Message-Id: <20240820092420.9185-3-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240820092420.9185-1-subramanian.mohan@intel.com>
References: <20240820092420.9185-1-subramanian.mohan@intel.com>
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


