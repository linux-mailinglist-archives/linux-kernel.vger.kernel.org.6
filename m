Return-Path: <linux-kernel+bounces-202844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38D8FD1C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AE5283C13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB5A15A84D;
	Wed,  5 Jun 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYi1rR0I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDE15666F;
	Wed,  5 Jun 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601776; cv=none; b=qahmhl2qZcoTyiaCYQqCk/4W7ST09oS3WsY2/R+ugt5oZ/WH4G6eRW7mVLZQ0Cvgv7Vhv3b64GoSVq9tufCruwYe6O++34hCw7BnUXiyIOmwd6+BMU6ENdeMIvFz2EhkeOLyp87sGeXErlpmY7UGtuVIHWSDVov3acNM+kN113M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601776; c=relaxed/simple;
	bh=9z/rDhWsENdERmVUQdtCDhLPPh2i3nZGdWjTuzNIFbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ierqjG7Z/f4PbZeVHkAMtYgVR6Ioqxc0yELQI4mPlQo6HruJn2MfC8yDRW+QPgT2cvqYczpX3prjRdZRrfgxXBJYWj4Y3SJWyMjn+cIPdL/hSij+JMkKXQGeeKyaCGn7SGUtT1IwOlTvZirnsHeZzQa8W4wrQaHG7iwSjRH7TuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYi1rR0I; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717601775; x=1749137775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9z/rDhWsENdERmVUQdtCDhLPPh2i3nZGdWjTuzNIFbw=;
  b=WYi1rR0IHw4kXXmNFeznNK+xWftvkmFXHqH6MKxtcTPGqHHpgrFySKR1
   MCI+1JrHDBVDZnZjpheLnmrotLEjTkEonnUeQ7Pq+uFTyIPZit+RHWMzD
   93KtQj0ol1VS7iVsuDz0tcK5c0UcQKJhrSPl98Xei3iZnewMsP3RVev1C
   bfl92QfoTxDTSdjmaOvlaaG7OZoIXBZpreJ6SspSARF3m/p0dPnvn1HjR
   f7r+LHymdPhSEqN2Gx2nYJLKhym5uOib8SDm76VTB4l28Q1T6ZYVIE2SC
   98ACTNNP1ybKnu59Wl2YkWYLm2HPmfFK76yRfSlxAbKWfFPd6QIMrz/T7
   A==;
X-CSE-ConnectionGUID: jcjPwT12Rqy0RsAKvLyk0g==
X-CSE-MsgGUID: sEDFIe6VR6yuUNazNn5gpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14106039"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14106039"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:36:14 -0700
X-CSE-ConnectionGUID: GdnqcmzyRq+IQidqyjDRLA==
X-CSE-MsgGUID: tyhGzpZVQ8mpTh+vh87VJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37765326"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jun 2024 08:36:10 -0700
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
Subject: [PATCH v9 3/3] ABI: pps: Add ABI documentation for Intel TIO
Date: Wed,  5 Jun 2024 21:05:54 +0530
Message-Id: <20240605153554.11584-4-lakshmi.sowjanya.d@intel.com>
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

Document sysfs interface for Intel Timed I/O PPS driver.

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-pps-tio | 7 +++++++
 MAINTAINERS                                      | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio

diff --git a/Documentation/ABI/testing/sysfs-platform-pps-tio b/Documentation/ABI/testing/sysfs-platform-pps-tio
new file mode 100644
index 000000000000..e461cea12d60
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-pps-tio
@@ -0,0 +1,7 @@
+What:		/sys/devices/platform/INTCxxxx/enable
+Date:		September 2024
+KernelVersion:	6.11
+Contact:	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
+Description:
+		(RW) Enable or disable PPS TIO generator output, read to
+		see the status of hardware (Enabled/Disabled).
diff --git a/MAINTAINERS b/MAINTAINERS
index 8754ac2c259d..5c8a443233ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17948,6 +17948,7 @@ M:	Rodolfo Giometti <giometti@enneenne.com>
 L:	linuxpps@ml.enneenne.com (subscribers-only)
 S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
+F:	Documentation/ABI/testing/sysfs-platform-pps-tio
 F:	Documentation/ABI/testing/sysfs-pps
 F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
-- 
2.35.3


