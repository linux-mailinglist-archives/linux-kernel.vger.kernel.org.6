Return-Path: <linux-kernel+bounces-293593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BEE9581B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B42F1C24347
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3C18C02A;
	Tue, 20 Aug 2024 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnF51T/t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4716C18B482;
	Tue, 20 Aug 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145049; cv=none; b=swFkTQq5RrF8fSeaXs3qUofkOxg0jCsoZ1X2K8ie75h6FxpI+IGjDbVcPYXNgEAk7dhoVlTh7JWq4pNDhC7RERLu9WpGX8NtHvgylegkjJSKvR0KyV5BOR2oVTe7ky0CPJI981H5YoNLL6sWp4UG5v7SbcnUMNUmptuHXZjQQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145049; c=relaxed/simple;
	bh=/mQ+nFW7tD+wG4NYo2A7nzR5KtH1H0c10nCvLm2rll4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TsF4w2310is4wiH1WXF3RB6P00hAqO4wndoLThSI28ILTVnwOj0+hVoWDChnu7ViNsRoUJfdxSVxkHxrfLE0PXv2zthuF0g5UgdTgoD0A27AaMFp44g7/zJmQXS4K84Waz7TqOIV/aY8ouuGlOHdLfGEs31O52kaAX166iu+IwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnF51T/t; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724145047; x=1755681047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mQ+nFW7tD+wG4NYo2A7nzR5KtH1H0c10nCvLm2rll4=;
  b=WnF51T/t40/vLElhydDR1BqihucPvC3rVauhwl76n3EZ0ZRsIp8jXG04
   c3Og2PsZJ1qtrR7O3+F/UDL+gx1McJUdzrzo+SNxfIv10x6f6j4L2+U6j
   L2CgwHognblSfzjIMJqyVxBVUbMJtdYnF37Df9i6/Ga2oE8xiMwKo+EAm
   iyO8sA82yREqIRkyS8amUU+wITMi+ioReHfpeCkOVyxFjl5bRZrjLgroo
   zxqCezeVK4HO8R+dKErqrFo9wckIX4/Uwu8yvJRaT38yD6ixsbM6xTOH8
   NPts7p5p5Q3L71c0fPh98VIsA1GGsvSSy/pzXh8LV9vjgT1322GeWZB0f
   w==;
X-CSE-ConnectionGUID: pmwXVyFDT5Wc+p2RqsjMpQ==
X-CSE-MsgGUID: OiriOzHfQ7C194hBqF8C3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39889217"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="39889217"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:10:47 -0700
X-CSE-ConnectionGUID: kfypK1SOS7idOCbth2AX2g==
X-CSE-MsgGUID: c4wbYOk3SS6bMjP5151ijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60505003"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa010.jf.intel.com with ESMTP; 20 Aug 2024 02:10:44 -0700
From: subramanian.mohan@intel.com
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
	thejesh.reddy.t.r@intel.com
Subject: [PATCH v11 2/3] Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
Date: Tue, 20 Aug 2024 14:40:34 +0530
Message-Id: <20240820091035.71288-3-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240820091035.71288-1-subramanian.mohan@intel.com>
References: <20240820091035.71288-1-subramanian.mohan@intel.com>
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


