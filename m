Return-Path: <linux-kernel+bounces-202843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3F38FD1CE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FAAB21540
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58614374C;
	Wed,  5 Jun 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFK3K9Xm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572F6A347;
	Wed,  5 Jun 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601772; cv=none; b=kPSdGozJJlt0jZ5TZx7VhA7oQafZyRoxdgUwSM8v6V+T0FrOoH0a8qzEMpI+y9BF9fh5B7unoHkttP1GSkfTi1q0QJPVXgbGxxmpbdGTCVtv0AIKcRGc8OprxyJuds3BLGohiEOO2FjuXoIfIG5kVFoWeDV1/xuNeomHc7Qd7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601772; c=relaxed/simple;
	bh=q/8zO9CB4UAgFF1iUYVAX5n56NxMBBdgp8FtVEk6dIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OduknJF+t0ImkFl6VDg+AWp3/XMh2kLZiIixcQ1KY4gVMylOSLTAeyZosOkPYuDnifJqYHSkAaZUJf2ndGMpl+YZaGi/hxqk1jwfjrbvIrh8y+XV9YsGCyXEwriKwQn/Vi3oeYfsbU9SqzxEzdiUIy7P294D72WVQqZaLBZRKQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFK3K9Xm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717601771; x=1749137771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q/8zO9CB4UAgFF1iUYVAX5n56NxMBBdgp8FtVEk6dIY=;
  b=FFK3K9Xmu9WAtweDzG04GcuHELJ8he3vTQhPN0XRrvQCeKXBQCEnCIDY
   eNaCTuNP4J1OwYx1M2WNqzCXpwwC3s4l0vTkxQ21BW4RdQKdptA2w5ogH
   xYBIcgLPcrnGHg5yz/7FI/w/cPiLECg2A15rcv6dOOlmLUriA4Jse7Ogn
   gXHbKd8qRBsZ9oO0gIFMrg3k+ACy8k3kLeg26KFQ7ZwoS//+SI//5qk29
   6OJhGsl6H9/3duSnb9uzHn1Rm8yRlbA6DN9DncuR3AzezU+LMzabAqih+
   o7WSH1eVSOM0I9nLaIz3fcd/DrJKbBnJ+50HDoOz/m2YpCm5Wg1LzAWVR
   A==;
X-CSE-ConnectionGUID: h71F3IOERfWMa/V5nLWBdQ==
X-CSE-MsgGUID: Vn2N7j8PTpepqmBgc5ibAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14106022"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14106022"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:36:10 -0700
X-CSE-ConnectionGUID: EkZu9SQeS/q6x7wPH/QBjg==
X-CSE-MsgGUID: zXxz2OjYRUWLWVvV+kR8iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37765307"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jun 2024 08:36:05 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v9 2/3] Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
Date: Wed,  5 Jun 2024 21:05:53 +0530
Message-Id: <20240605153554.11584-3-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240605153554.11584-1-lakshmi.sowjanya.d@intel.com>
References: <20240605153554.11584-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Add Intel Timed I/O PPS usage instructions.

Co-developed-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---
 Documentation/driver-api/pps.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 78dded03e5d8..c812d1cb760e 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -246,3 +246,25 @@ delay between assert and clear edge as small as possible to reduce system
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
+        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
+
+Stop generating PPS signal::
+        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable
-- 
2.35.3


