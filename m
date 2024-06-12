Return-Path: <linux-kernel+bounces-210895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 135679049C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2740B23643
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37324374DD;
	Wed, 12 Jun 2024 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLeSvw5K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28EE374CB;
	Wed, 12 Jun 2024 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718164457; cv=none; b=RbyuSwZuU/SNiU8qWozd8SSe0dFbXrKl5zfwwvr5B2PxRzQZHYqiuQjeYUJ4gkHN8Si6ar3jsIGXA8bgQVx4KO/hY8Fx7lB0nOC3X4F0DPqFn6xBbfeV9uvoSHtIVmr1LKif81jV0wXlQMQKM+d45T/9v9IeZUwOsYFk4uCJ1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718164457; c=relaxed/simple;
	bh=n3C4QjnvaQVr1192wL2fDpdc3TZBKpAQ5IRhjv2jMjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gWJRGvV216Rd/wI8DXkC2zTtTBZxPzx9433fWEvwHm1Rhu75CbIDnGe6AlUtcOlAnE4dAaHqDFbYVETKDzKt7Thid0uJCqF8UPEVIvfIOF5N9akSsSKfhJvxgw43wvUsCiPI4OM4YeL6v59lDLIBIEtdmjNR6AsfLJ8Y3OPdNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLeSvw5K; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718164456; x=1749700456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n3C4QjnvaQVr1192wL2fDpdc3TZBKpAQ5IRhjv2jMjY=;
  b=JLeSvw5KjGSdHC4vqyPDswtoWpev1Mn2HMlsO20alVIpsl8Iq1rnS60m
   0C9C8nNEBPtwce/z/JTePJ2nLNMHnZcpYfCmahbl0D8c8KkIaFKRg0n5R
   9mGRDtG0CLBuHMXNWNt1PKntCTvrdJOIcbs2CkqAZCdmYBICSdWWGOrkN
   a3wocmk9r/3G3u6E1EChc0Oov+QpnmFHpTlliduS21O3LBaOg3jlhhnee
   FedBTzf4EV9dGBtSuKPG1fKE6a8m962AVy69p5AU9V2SXcZLx05Ahj7mA
   GkX/kCE66RalqV/a874FST7z/MQADfFWnM12ML7RT1OVPNi6U5mIVC6dR
   g==;
X-CSE-ConnectionGUID: HbAYMniuTQmIsOSVY1bDCQ==
X-CSE-MsgGUID: Ao6cgHwoSByBbafIHTC5sQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="37433761"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="37433761"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 20:54:15 -0700
X-CSE-ConnectionGUID: GLzJGoFzSQaO2abLHze6Ig==
X-CSE-MsgGUID: z1EoMolfQYym5xc05GnreQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39758579"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jun 2024 20:54:11 -0700
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
Subject: [PATCH v10 3/3] ABI: pps: Add ABI documentation for Intel TIO
Date: Wed, 12 Jun 2024 09:23:59 +0530
Message-Id: <20240612035359.7307-4-lakshmi.sowjanya.d@intel.com>
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
index aacccb376c28..9c623f167aa9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17946,6 +17946,7 @@ M:	Rodolfo Giometti <giometti@enneenne.com>
 L:	linuxpps@ml.enneenne.com (subscribers-only)
 S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
+F:	Documentation/ABI/testing/sysfs-platform-pps-tio
 F:	Documentation/ABI/testing/sysfs-pps
 F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
-- 
2.35.3


