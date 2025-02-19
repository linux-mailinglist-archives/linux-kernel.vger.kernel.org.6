Return-Path: <linux-kernel+bounces-520873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1502CA3B048
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD08E18935C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289751B415B;
	Wed, 19 Feb 2025 04:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwlUtMqE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2381B3953;
	Wed, 19 Feb 2025 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739938001; cv=none; b=CuCbSJJVTxlvyjT115G8Kje5VaGxj1ywAZLJGx0kOvyqwuwf25EmstTHEYZseUj1ccN3NmWApaGpKEHG14dQRd5oACXdW4Edb3oXi4eSjedFbHle+OtjpBv2Sps7KkHGNX5IyRh8h43NXNPQHNOOfK1cmWaCfQcz0U8+NnRLFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739938001; c=relaxed/simple;
	bh=qv6BirrjVU0NWcV17jTzqJq8GK7JkoueKqhKnIlpvlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dle2+M3yERjN5RGcQuH8O3zZKMTeLw0gL1ROjExE497Qb3aCgY0d5G+nnOHctj4hVpaekIVCmHmmGPzvOJ5EOS9hv4og0ilod3K/C9buEkB7lXUzEOzW+STtj9SMkadfBsy+PjhRvJ6ewVKfd6pTsgx6n/6JQKXqzYkeiFImAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwlUtMqE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739938000; x=1771474000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qv6BirrjVU0NWcV17jTzqJq8GK7JkoueKqhKnIlpvlU=;
  b=fwlUtMqE5X2oLJragcPxqGRFxaTvtXV6HbqexxNGz/9aVzYYxzI/6AEM
   xQHlOv3oRYFmemoAgE6CZUVAq8Ci7qNyIYU5T55wlOPT1xhCKgTFiJnIg
   SF9e7ErJ95pybMbCASLGYikq3IpMhH1bK3KeGyw7frAXXfMXVpTnQNPWc
   LtltYz8XHDaC5fPELdvzNmYneDKMYEWgOeudKqL/KoFRAJMnXT04UFHcB
   BTSY8xxpn3tCb6ktAkaE3qfwpNSsya6M0mocqmdYvow1wmtsszJwlPE7x
   uYNXJNykCZtWF9yDHVkw9PGP0SQlWbWvlBKlwNIaPdt7D1Af0yMr2wy/P
   g==;
X-CSE-ConnectionGUID: KFHQory9QgSOtAoMfKC15g==
X-CSE-MsgGUID: WlHa29ziRZCk+7F8hIYsTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44579171"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="44579171"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 20:06:40 -0800
X-CSE-ConnectionGUID: Qy/EUbnCTFuWIl/l5kQjHw==
X-CSE-MsgGUID: eY1chkT4Ssasj26Y1d4uug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="119703838"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 20:06:36 -0800
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
Subject: [PATCH v15 4/4] ABI: pps: Add ABI documentation for Intel TIO
Date: Wed, 19 Feb 2025 09:36:18 +0530
Message-Id: <20250219040618.70962-5-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250219040618.70962-1-subramanian.mohan@intel.com>
References: <20250219040618.70962-1-subramanian.mohan@intel.com>
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
index efee40ea589f..35e254d0a9db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18912,6 +18912,7 @@ S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
 F:	Documentation/ABI/testing/sysfs-pps
 F:	Documentation/ABI/testing/sysfs-pps-gen
+F:	Documentation/ABI/testing/sysfs-pps-gen-tio
 F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
 F:	drivers/pps/
-- 
2.35.3


