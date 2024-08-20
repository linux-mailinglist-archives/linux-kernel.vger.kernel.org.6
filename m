Return-Path: <linux-kernel+bounces-293594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F292F9581B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306211C23C29
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26E18C32D;
	Tue, 20 Aug 2024 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdKhhNJg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D418C032;
	Tue, 20 Aug 2024 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145052; cv=none; b=Ns8lRKTbarw1l7ZauiXX8bSWHOgf2pe97MZfkhF9U11m/HufpfkzXJ/sJWemo6opk8CxZl8E+MhyBy77LBq0wKmS17YG41zhBLoNXffUd/ccLYkXL1OF8m2lgHqCo9HSQ+Gnb9wBFQBrX1Y5enUEYygRsa1JM5GHkAiT6UCcNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145052; c=relaxed/simple;
	bh=M7u8dwEi2+oYVWiHViJ2HEDlciSMLJc87pWlx3bLL8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KcRzFsqypC5Pu/sqnq/8FSRCW+uBKO49AsKAqf9Ka/TbAJ0TDX5kX3CfdPuAJ2IpHGZxgAaINM78fXToAB0X4FFO0SebgDIpXuT8QbmsAneI3CbG+js48LGYmSSr9iUenaJ8SR8ecCv6m+dY7k9CMeu9B3hzhAvpWc+zlrOHDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdKhhNJg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724145050; x=1755681050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M7u8dwEi2+oYVWiHViJ2HEDlciSMLJc87pWlx3bLL8Q=;
  b=EdKhhNJgfAgTgN2PPTB19uUsWSJ8pdgzwrY69Y3ONnXNhXntz84WOoc5
   mgWEuDw1Hn7DZ5Y5w32+dq+1qGyCs/XaeB8wyjGs8oHKrwJ3H3iG3k1tn
   52eYMi2Ru0PTjbgo0nzx52o2K6vlRpujlgmDH42UhAcTi6EgoxUs+RhIF
   h/bH4L2clL+Hq0uSSytOxV20VYJBK6ebToUGDRKW3se8vvn7kiZZd5QSE
   h5FXxK+WFI55WE7KKBxFejpkeahQj9Alu1mxm76oV4JMqtceXLTM5QHoA
   LVS9HTuzCd9DVKpdlie6GIEPEfhYejPXvqb+BPGstcPlwEbZTPjEpnrs+
   A==;
X-CSE-ConnectionGUID: FoBYFEnFSvqXjT/l1NqXjQ==
X-CSE-MsgGUID: d9sh8e+3ROin/fhHS5fANA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39889225"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="39889225"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:10:50 -0700
X-CSE-ConnectionGUID: 6Pvti0v0Tgyx7qQqULbjFA==
X-CSE-MsgGUID: QWig2m5yTr67W5gkY57yZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60505013"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa010.jf.intel.com with ESMTP; 20 Aug 2024 02:10:47 -0700
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
Subject: [PATCH v11 3/3] ABI: pps: Add ABI documentation for Intel TIO
Date: Tue, 20 Aug 2024 14:40:35 +0530
Message-Id: <20240820091035.71288-4-subramanian.mohan@intel.com>
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


