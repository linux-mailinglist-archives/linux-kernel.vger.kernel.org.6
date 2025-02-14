Return-Path: <linux-kernel+bounces-514648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C925DA359C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECBC3AE76F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514F22DFBB;
	Fri, 14 Feb 2025 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLcEiZKc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A222333E;
	Fri, 14 Feb 2025 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524118; cv=none; b=eqFqf3iO4LhgFEP+/e5usv+Eme0m6BxtulGT76KGr/264c5r/rTrFPFV4EpXCbpq9PlRTENXPook5jcgACqVHGoz9ZBQqYdzb5hPXpJDXCKuuq/yO083YF3dzKSasnMYQwjat9Lpo/iOBOVr9XhfefpQqVfVG1seUV/kgN8LDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524118; c=relaxed/simple;
	bh=syILJRFICNuwfc1hr1rVckmFJF5JIVDUFUmPw1y28sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6r00GjYe821mH64IVtIPswxKjrbhabKMEwFlOW2p5nphpmcGcwPoZOVfspWKehlztRgZNb9m6CcL6TsGarAlJaqI1mO+WVTZogVSlDMnG67A+0IW1hYVRniqQkQKm8da5bQuHtO8cNyL6kp+lS5W4nB3BeM1tXTIO4m7lqAiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLcEiZKc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739524116; x=1771060116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=syILJRFICNuwfc1hr1rVckmFJF5JIVDUFUmPw1y28sU=;
  b=ZLcEiZKczkwzQGvoNXRHg4tKcaK8+rp55jZNDLEhdB9R9chDjwnBkKFu
   Cdcf4rU747EApdq3miILWFsuOGAfuNpx8GpwG2UifOEJRbbMfz0msjKbc
   j0O6PTBqDtPYb6ZCFchYUGbnL+hSIsR/2FMpAlJmmF5omvM7lN8GJ712A
   NQqs+NSvDnt8MdmH/p35kRQRX1KlG/jS912G5CNYptm00lmWqm4vG5X95
   ef79AnVvkV+lMdiJJlRm31Upv/n+05Z9NuLCi2LXnAKttmeVz0Mtjz9IB
   wj9cn6pAIU4F71Rr+1azfu99u1MkSUzniEXCoagjTGxIzZ4BxSummy7/0
   g==;
X-CSE-ConnectionGUID: wHlu4nT5RVu/jr5mqpOToQ==
X-CSE-MsgGUID: Q/bXnsxnT3WYyrK/7citiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51694804"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51694804"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:08:31 -0800
X-CSE-ConnectionGUID: zk2AmN2lTHSCyhiRWNHN5Q==
X-CSE-MsgGUID: QmaRMmkESimYeRRxIVzhUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114303141"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa008.jf.intel.com with ESMTP; 14 Feb 2025 01:08:13 -0800
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
Subject: [PATCH v14 3/4] Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
Date: Fri, 14 Feb 2025 14:37:54 +0530
Message-Id: <20250214090755.37450-4-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250214090755.37450-1-subramanian.mohan@intel.com>
References: <20250214090755.37450-1-subramanian.mohan@intel.com>
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


