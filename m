Return-Path: <linux-kernel+bounces-295849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9579795A210
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F086B27477
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBB71BF7E5;
	Wed, 21 Aug 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8oLptvQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B414E2F0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255327; cv=none; b=DxRtllB1p/0DjKFEyTygc3Frf6ElVBEnxmReMzNnCb3DVunAbqrnOb+ByHfZGbVMX2nvJ0+hjHgAgi1ASrwqHJqIcdXHWj85wAkI5uO9Uy6RMCaiog2cHmEBylTjHxgTk1AfjeOlDDfXZPnkE3dgjWhnfa7c4ZqKNc9WJ1KrspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255327; c=relaxed/simple;
	bh=I5Cv3aWuNr+mfC4v8KflKEYuNjZ/J/Xj9DgNNHl5MwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orEgxtb7LEg5jGUMadARzF9mIj3ubei2oSkAotxVh4poS7Wmzmn8HFY+IPJCZSpxmmzoXbuYI5a9pA2QwClcFbz15NZeKzX2ZT5prb+e7v0nwk3s3jq/Sko2BloCjI5O7CuUg2lIfzOIHhR5HvxP0rgll04jKI3qy67ltgD9atU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8oLptvQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724255326; x=1755791326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5Cv3aWuNr+mfC4v8KflKEYuNjZ/J/Xj9DgNNHl5MwI=;
  b=B8oLptvQ7Ov+YD5iIB+1Y2qwV4MN5QguaFl6JLx3f4scdj9c1ZTV/LGJ
   tr4hYRJIekTXQtO3yiYHbg621geakMRA8V/HkJO1Kd8v5Zl3FMhhgp3WR
   cCQSOCwNSqmaeVlc8CN1l8Bl6hmm6lG55qWjtcRMBf1ESy9I53RlsueST
   /MROd5xLwtkQtSeL3IJGZnWvH68S65huAeEe0WZMFmX2Ep03KoTDbqQzQ
   Guw4m5+stt/or+nahE1h5G0Y1ZuWDHxqLr2z1ihH0v4VB0IXk6qe8Lu2K
   0L07ZrVB0BtMaxVibYKMQvJZnRr9ye29durqUzH8ZjqqTGLsteq55ChO7
   g==;
X-CSE-ConnectionGUID: XMJ9veh8Txah8oRLGQCLsA==
X-CSE-MsgGUID: wBru0v5rTT67StIXjWOS7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="13135000"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="13135000"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:48:44 -0700
X-CSE-ConnectionGUID: VW0IWYxQQFaKNtpX+YW7zg==
X-CSE-MsgGUID: GRqCQDUrQau+4nyS+e7DLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61107976"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 21 Aug 2024 08:48:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 08B9C152; Wed, 21 Aug 2024 18:48:40 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] driver core: Sort headers
Date: Wed, 21 Aug 2024 18:48:19 +0300
Message-ID: <20240821154839.604259-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
References: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 144cb8c201fb..6b9d3d255135 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,29 +9,29 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/blkdev.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
+#include <linux/dma-map-ops.h> /* for dma_default_coherent */
 #include <linux/err.h>
 #include <linux/fwnode.h>
 #include <linux/init.h>
+#include <linux/kdev_t.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/kdev_t.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/blkdev.h>
-#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
-#include <linux/netdevice.h>
 #include <linux/rcupdate.h>
-#include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
 #include <linux/string_helpers.h>
 #include <linux/swiotlb.h>
 #include <linux/sysfs.h>
-#include <linux/dma-map-ops.h> /* for dma_default_coherent */
 
 #include "base.h"
 #include "physical_location.h"
-- 
2.43.0.rc1.1336.g36b5255a03ac


