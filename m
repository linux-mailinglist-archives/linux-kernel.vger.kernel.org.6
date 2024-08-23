Return-Path: <linux-kernel+bounces-298341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB495C5FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650EF284F70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76EA13D246;
	Fri, 23 Aug 2024 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdxoyAuN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F513C9D9;
	Fri, 23 Aug 2024 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396489; cv=none; b=eiMPm31lETlhOUEcTLNf3eUuMzTtdqscXFFDKhHAOQskjb7WCKW1d+f6Ig/Nfw4Ldd5HJo1zaTGPP73C3g0zMl6U1FBnJu5+ddJrwiNTso1oHDSTQ6aRQDdaU+F+2I8RKcfQfMSXiFj3AHmv1O3WR8/GLJlypx3RHd5flzZ75tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396489; c=relaxed/simple;
	bh=M7u8dwEi2+oYVWiHViJ2HEDlciSMLJc87pWlx3bLL8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tS4gzlZ/kOpFx/XynOezthbV7/ecUpyJs1Wrr/emKZj57B0C4+6YcQFmIrZAJW9QsjCrUnjHuaLC54CM1B6ZnFC7MlaUPe+Agdv5dNNX+WLRztJTA2WxOe4GS13qNYI+hl8sxPGJBp8bgfcZCTOQWsct8ZTJR8l6KwIxYHgO3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdxoyAuN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724396487; x=1755932487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M7u8dwEi2+oYVWiHViJ2HEDlciSMLJc87pWlx3bLL8Q=;
  b=AdxoyAuNH/wcL5TVEuh85zOvXrGNkFFwFaItgn0xqpCO+J2fBPkT0Iux
   a6ROWHy+/0y3b2g/lKT8IU2dzTl3YRH8kOQ3uk5310krhW32EeVK2rfhm
   ptclAIMKpb/nOl+IfSGEQj9HcI7NVHeBbVJ5xmKfeXvtfN50Pkxbt0+7z
   QMrlgF05i+d96PZO//NueWSbWwtnBufTd4g+wCBectWxhMgWFKMO08IRy
   2owsoI4W8MpM0IGEr+JAc7xW8Tz4t/+DyATUQtD5qVs1RYywYS74op9gW
   qeWufEH9JWAWDc8KDSsDy/sHvyKXNl0I2RNN9TexPxFLLn+OW6jatDESe
   A==;
X-CSE-ConnectionGUID: /utSTpCsT0C7IdmPouo4Fg==
X-CSE-MsgGUID: 70UcUZlhRsekWRrORG8S2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26717165"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="26717165"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 00:01:26 -0700
X-CSE-ConnectionGUID: E2DHWZGKT4GD78r/w6LRWQ==
X-CSE-MsgGUID: 3VpCxLsjQaSRNVn3PskVaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="62004893"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa006.jf.intel.com with ESMTP; 23 Aug 2024 00:01:22 -0700
From: subramanian.mohan@intel.com
To: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com,
	david.zage@intel.com,
	srinivasan.chinnadurai@intel.com,
	subramanian.mohan@intel.com
Subject: [PATCH v12 3/3] ABI: pps: Add ABI documentation for Intel TIO
Date: Fri, 23 Aug 2024 12:31:08 +0530
Message-Id: <20240823070109.27815-4-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240823070109.27815-1-subramanian.mohan@intel.com>
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
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


