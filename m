Return-Path: <linux-kernel+bounces-210894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A12BB9049C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97411C2360E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAE12031D;
	Wed, 12 Jun 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJHTFW/6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C1286A8;
	Wed, 12 Jun 2024 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718164454; cv=none; b=hFxh5SwabY7jDq/mPIubVQk8ABOId5jH3G1Sj7Fs4/Tp+VUhjVWXLpBys60EZlk4tg4HCoZDJlnCsSKtJoKNIZcHABPVUMEUBRpQNvG1IErNBuGW5zi+qegHpPErdyz8sAkap+U/LRqNpR6btx+Gl6YG8GRLnj1xmFx1t+fGTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718164454; c=relaxed/simple;
	bh=bivqRNthuRrhiu9l+tfLYSHdvbOw1MUw9EiQZxQ84PY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0gbhhs4Y7EC+aX9v/D66aLCSNENEu+umqMnPaknYCQxbSmbdrRw5jb0cZDCNdGHolUZ/Pb5g9BgvD/JFX84my2jVP6ayFptYQPA/ahC3JhzgXnJffy/TcM8q5dngB6i5fFHJqt41durS4k8L0Ky0FMWufkZn4bo655cNUItbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJHTFW/6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718164452; x=1749700452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bivqRNthuRrhiu9l+tfLYSHdvbOw1MUw9EiQZxQ84PY=;
  b=BJHTFW/6tTI/OyceWy+kxLwmO0jJQfXV1dWv2+R8lcCoAZObS6PzbQR9
   5DXcFrY+RjUDCY4PYUQqx/3sogMvm6NERxZL7B6M5OJ2IJlcBTYldihMt
   NKTkGw3CV5RfDwp/nvwvnElV9KooPXYy8e+DFBFdwWUFp/PhNJYObD1Q9
   kE5vdQ+O2LitpyceShncN/zwzEe5faAaEQ9BDznGm3cZrS/nQ8L1NGbC0
   eY6zPCHVFmp6Zwe1pe5JJ9aGKLv2R3P1NVoU0PCgcCCW18ApkNsMZpSLl
   AOzvl+FsXTjV8z6Mh0YTren5haTnnWLFS/7IUHz3hAhqi3Sm6eNpKTMbx
   Q==;
X-CSE-ConnectionGUID: 1d5+CItlTLiagrLxn+oFkQ==
X-CSE-MsgGUID: VuMhyoKVQqCeU0S/XPsfxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="37433749"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="37433749"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 20:54:11 -0700
X-CSE-ConnectionGUID: zsV2O8ztT6W34B88zsQXEA==
X-CSE-MsgGUID: YDkcNxk2R7e1D08QS9jxWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39758576"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jun 2024 20:54:07 -0700
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
Subject: [PATCH v10 2/3] Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
Date: Wed, 12 Jun 2024 09:23:58 +0530
Message-Id: <20240612035359.7307-3-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
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


