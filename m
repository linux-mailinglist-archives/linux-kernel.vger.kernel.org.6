Return-Path: <linux-kernel+bounces-217278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4990ADB8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DF11C22F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B64194C9B;
	Mon, 17 Jun 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CD5cQbKj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4B17FAA2;
	Mon, 17 Jun 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626411; cv=none; b=eNQu2zWQWOnzeNzmlz2lF7Mlam5gppr891CVuDxLV9GYvOqh80WEg16cMRetgHGIQlf/leEM7gaJOeE5FT2DLAesdQNZN6eUH08U55f0Z9yKQCWci+00iwCMGrddDK/+PMf9a/+RdNkl5VqYYVH8wE6/2XlpIRrfG6a2TBGonCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626411; c=relaxed/simple;
	bh=XH5e5HqUseo3rEqUrboz5YJVYkGyWVbzJc5fvzkMpYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WxqoCbJbHhOSvwMDZwyAuHg7UNXZvaobwxreES5hvnMt5xjxiWdRNJZMh3fD/KbhdN2QWrTNtaS+QrP4et1/gNp8al3W78qoUwrgJbTqfpYt6Ymp7I+IT+pUa7i5NUIYK4+ELsglIUvLBODAs5QlYd+fgFbF7HaCiF4TVeibMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CD5cQbKj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718626410; x=1750162410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XH5e5HqUseo3rEqUrboz5YJVYkGyWVbzJc5fvzkMpYc=;
  b=CD5cQbKjukWxs5au397MTj06ox+Gw9uONe62KUKseByEgzoXnCtKUd0I
   V14ram5ivAQz9dDUpVCV3zsiXKUNSaUa0pvzgltzfjOwbMAtQkFjtIMn/
   IY8oSZK6lyjQcG4yz7ElxFGDaYZrhOYja74nb+FknTg5+UFK7zgqsBbi8
   c+PMG43xXGLubpMnHaQrAKT4aYRlSX7fb0RxINAYreFcouFnYcQShSGrp
   zRHKzO8IweU5tmSmNAmOPhBStnExGl2hKufFNaBOFv4UNWSZqOV6cGU9T
   ZLYqDcgCnMRJEbozbpfiot7dABOMHabR+bPK2yCk9FKVN9VzE3tefzSyU
   Q==;
X-CSE-ConnectionGUID: Z26jb1XPQJu22H7uH0agKA==
X-CSE-MsgGUID: 6yODV/T2SlaToN0eWB6dRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15218365"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15218365"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:13:29 -0700
X-CSE-ConnectionGUID: 0zJqMPAJRy2gqwDYQd+YYw==
X-CSE-MsgGUID: 8JpWJEIISW6VF0hXVPl8Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="45545674"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.149])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:13:27 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: Intel: clarify Copyright information
Date: Mon, 17 Jun 2024 20:13:18 +0800
Message-Id: <20240617121318.14037-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

For some reason a number of files included the "All rights reserved"
statement. Good old copy-paste made sure this mistake proliferated.

Remove the "All rights reserved" in all Intel-copyright to align with
internal guidance.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c         | 2 +-
 drivers/soundwire/intel_ace2x_debugfs.c | 2 +-
 drivers/soundwire/intel_bus_common.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 0dadf46faca6..4f78b7f99e44 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
-// Copyright(c) 2023 Intel Corporation. All rights reserved.
+// Copyright(c) 2023 Intel Corporation
 
 /*
  * Soundwire Intel ops for LunarLake
diff --git a/drivers/soundwire/intel_ace2x_debugfs.c b/drivers/soundwire/intel_ace2x_debugfs.c
index 3d24661ffd37..206a8d511ebd 100644
--- a/drivers/soundwire/intel_ace2x_debugfs.c
+++ b/drivers/soundwire/intel_ace2x_debugfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-// Copyright(c) 2023 Intel Corporation. All rights reserved.
+// Copyright(c) 2023 Intel Corporation
 
 #include <linux/acpi.h>
 #include <linux/debugfs.h>
diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index e5ac3cc7cb79..df944e11b9ca 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
-// Copyright(c) 2015-2023 Intel Corporation. All rights reserved.
+// Copyright(c) 2015-2023 Intel Corporation
 
 #include <linux/acpi.h>
 #include <linux/soundwire/sdw_registers.h>
-- 
2.40.1


