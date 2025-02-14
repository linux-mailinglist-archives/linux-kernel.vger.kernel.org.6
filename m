Return-Path: <linux-kernel+bounces-514649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329D0A359BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C1016EC6C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722022FDF0;
	Fri, 14 Feb 2025 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lW5Sqw8u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78C22D78E;
	Fri, 14 Feb 2025 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524120; cv=none; b=GnGYDrd1f73raz/Qdcg91SgoXnrkBUE4gTBgEBBlF0qvF8ZEcMYzUPk5ZGtXCoyOpfNfcTg5NCvGe0jQBPObPGJYd5G4le5JLzFNJ+0BRTIzIRuY9TnNlznRIehnmviHlhJE9CAlrlG6CJpT6TH+LF/6f+BfvAsPvdO5usV1Zyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524120; c=relaxed/simple;
	bh=BUMwJBFmmCgIajK9QzBHIVRRQQs+ucHortjyYy4kOlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CYZcCjSBOpTH+Tlfws089Aj064ss1OaTgy2RqrkOC1N/UayGTujVLWoLqLgS4lj4gMfs7zPbEv1txlQMoMjebiuj7SUn799olTmvxL01Bo9Y1gqjMhVb+vKoIMkGDD7vV2qEZNqeIialyEA8bjzWyMkBEpYZFJh/LZGEzIGXbUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lW5Sqw8u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739524118; x=1771060118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BUMwJBFmmCgIajK9QzBHIVRRQQs+ucHortjyYy4kOlA=;
  b=lW5Sqw8u3VYG3ORmeDG7C/rInQ3sFMmhMj2CkmtMesEwjnjIKKNjWxEv
   r0jOKUwihzreKPIBU7obTHvwPxONni2GISh0oV/iTCNk+nFXGOaKYA0na
   5zvUyOOF35osxUCytmSSov9BSoPP38Hb6+1d4UhuMf/EXk2fvkmUvFhrH
   BH/addoc/zanekB1a57rS10bo7im53siD3jMBEij0iJSJ2LsNG845syul
   VMDwn29W3w9/3GHvqgOBnnjVnzAQA5RP0NeonIWUZakAU5OyLhNL4v/tb
   5DOhoxL5opBOO/Z6rZmiodWWXoMOpkH3n1d4TO22NayqnK86C6u7JycM7
   Q==;
X-CSE-ConnectionGUID: YZnCUAjESD+tX50x9hC0nA==
X-CSE-MsgGUID: LftW7VUFSXWRWhluL5dCrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51694826"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51694826"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:08:37 -0800
X-CSE-ConnectionGUID: xEU9KErcT6WzBy7ZE4IcHA==
X-CSE-MsgGUID: DBiIPmSkQxajPbyzEHgpIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114303155"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa008.jf.intel.com with ESMTP; 14 Feb 2025 01:08:19 -0800
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
Subject: [PATCH v14 4/4] ABI: pps: Add ABI documentation for Intel TIO
Date: Fri, 14 Feb 2025 14:37:55 +0530
Message-Id: <20250214090755.37450-5-subramanian.mohan@intel.com>
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

Document sysfs interface for Intel Timed I/O PPS driver.

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
---
 Documentation/ABI/testing/sysfs-pps-gen-tio | 6 ++++++
 MAINTAINERS                                 | 1 +
 2 files changed, 7 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-pps-gen-tio

diff --git a/Documentation/ABI/testing/sysfs-pps-gen-tio b/Documentation/ABI/testing/sysfs-pps-gen-tio
new file mode 100644
index 000000000000..3c34ff17a335
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-pps-gen-tio
@@ -0,0 +1,6 @@
+What:		/sys/class/pps-gen/pps-genx/enable
+Date:		April 2025
+KernelVersion:	6.15
+Contact:	Subramanian Mohan<subramanian.mohan@intel.com>
+Description:
+		Enable or disable PPS TIO generator output.
diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..d4280facbe51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18916,6 +18916,7 @@ S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
 F:	Documentation/ABI/testing/sysfs-pps
 F:	Documentation/ABI/testing/sysfs-pps-gen
+F:	Documentation/ABI/testing/sysfs-pps-gen-tio
 F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
 F:	drivers/pps/
-- 
2.35.3


