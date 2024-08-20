Return-Path: <linux-kernel+bounces-293624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AF1958215
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D59A2841B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F2218C929;
	Tue, 20 Aug 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkKHsFmG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA618C91B;
	Tue, 20 Aug 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145878; cv=none; b=bYm/n56yTLI4LhN+V+ITg8I57Pq4TKVQezgN8yc8t4WzItaSGWz6flh9Yx+c1MO7I3Y1J+vcXsagBC/WcAlwu3g91zqB21uSDFGGmUidIudig1EmW3le+gnvpHkdX3Vd4qvFjRp3CAvna/fQ7Emu7r5ifpDeUKzAT1+yX+EJmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145878; c=relaxed/simple;
	bh=M7u8dwEi2+oYVWiHViJ2HEDlciSMLJc87pWlx3bLL8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u58mOr7k0bQQJsgE55FiDnwJR5hjuE9I0VSdat67hL2712fQ5t4SmW8DpwdGU+sFuI3+8f99488X2DFXYjonhNEqsODaJA/oAOsG17BUXN4RWV9RyrXivM6xYV8o9WkPFD9/lYzbzXrLPek2SuzS/l2VARBB+ga9CchrIdVfxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkKHsFmG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724145878; x=1755681878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M7u8dwEi2+oYVWiHViJ2HEDlciSMLJc87pWlx3bLL8Q=;
  b=ZkKHsFmG1mrH3Va0GO3H9tTWKAZbVnSyz4HZ/bvtRrAJ8237H665lm9T
   o+KXZEv7RgTzO50wPCZIBYO9zkhFmREHcKvcQswCoXXAnkbx+P6gmTsR1
   VCy14S0YO4/kwBIAOuelyo031cMPiwi+jgpov4KMYi4yM4c26JOWkYp+n
   WH6shY5ZzEimxOIGnWmdX2GLHobS7VmQVT4ai2MD3R1C/nFqr5mPx4YiF
   cuh8Blcydq73SJGyjHhRhcb/nFgwkCEyH808n/pqzqgRuiyNmNrAyFi7t
   ddO4OcX3OLpOlzSWwMLP41J+im2ZU1U/1lBBY07fRLbMXc9a8zgJ65hyQ
   A==;
X-CSE-ConnectionGUID: abcGutbORjO6HHnhU5eW9g==
X-CSE-MsgGUID: +bQxRgiwQeWs98GLwKD05Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22578426"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22578426"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:24:37 -0700
X-CSE-ConnectionGUID: NhJfld54QCCNPFsEbmBQbA==
X-CSE-MsgGUID: HIbxi3B3SqW/wuDOYEFFvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65495056"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa003.jf.intel.com with ESMTP; 20 Aug 2024 02:24:34 -0700
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
Subject: [PATCH v11 3/3] ABI: pps: Add ABI documentation for Intel TIO
Date: Tue, 20 Aug 2024 14:54:20 +0530
Message-Id: <20240820092420.9185-4-subramanian.mohan@intel.com>
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

Document sysfs interface for Intel Timed I/O PPS driver.

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Acked-by: Christopher Hall <christopher.s.hall@intel.com>
Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-pps-tio | 8 ++++++++
 MAINTAINERS                                      | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio

diff --git a/Documentation/ABI/testing/sysfs-platform-pps-tio b/Documentation/ABI/testing/sysfs-platform-pps-tio
new file mode 100644
index 000000000000..8face1dc8010
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-pps-tio
@@ -0,0 +1,8 @@
+What:		/sys/devices/platform/INTCxxxx/enable
+Date:		September 2024
+KernelVersion:	6.12
+Contact:	Christopher Hall <christopher.s.hall@intel.com>
+		Subramanian Mohan<subramanian.mohan@intel.com>
+Description:
+		(RW) Enable or disable PPS TIO generator output, read to
+		see the status of hardware (Enabled/Disabled).
diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..242d9784ee5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18263,6 +18263,7 @@ M:	Rodolfo Giometti <giometti@enneenne.com>
 L:	linuxpps@ml.enneenne.com (subscribers-only)
 S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
+F:	Documentation/ABI/testing/sysfs-platform-pps-tio
 F:	Documentation/ABI/testing/sysfs-pps
 F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
-- 
2.35.3


