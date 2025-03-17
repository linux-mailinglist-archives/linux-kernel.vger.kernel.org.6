Return-Path: <linux-kernel+bounces-564551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271EEA65750
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176B83BC1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CEB17A318;
	Mon, 17 Mar 2025 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJnGsIV9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015117A30F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226925; cv=none; b=hv7OSxEvjt7uiY8zyqFlEjB7HrBIG4Cg3i51ToVUqkd4KNxZhllMCuDn3dA6fBt7yWfYtHt4ceDr0c4Sg5VrLll5oAXT/m3iRlLXLKIL4QzU0OBV9TwfI4svTWpLY+qwAl75V/bWrlV1QmzDW/9MM/iLUtiNN717930b7AN37DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226925; c=relaxed/simple;
	bh=Ndc2bReYSJUSie6WhUS+mnCu2jDPY4fjFHd4YY+TJH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sNOy/nfikiyC+ExaoTRDkNqXYLhCFfj4xebbFUUqOGxDf99WYStozOmnR12p12e2bn0vCw7e0bO1+n9lGnzV+y6JK1ymQpWDYCaYnHt3mb2hW10Qg3Hj7fmBB7AcuKGQh+gVEB/2XUd237ZhlL2lwFI7dN4bX2jvkb4cSE73fww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJnGsIV9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742226924; x=1773762924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ndc2bReYSJUSie6WhUS+mnCu2jDPY4fjFHd4YY+TJH8=;
  b=XJnGsIV9SefE1O/Fo4ksr+/jdWxkh6IhHX/4s/IyhudysQDC+qxcbd9T
   kcwhv+t0KHTRrKoqp3QIPahxtGSZfrPlKrxB/Prb5i4mEF8A5IGTDjRdB
   m/bIVdccHdsPc3yqNQD3Ap4trWeT3xeE+yy7abQHseb4Ed2nX/8WxfTnZ
   6FLXqus1hXxo+Faa1welabI6PWxhe41cXTOX47vuPI+Cdzhbhnc4YAA9g
   n3Do/SWcyI9Log1g55qR9UiRii89HegHGCSlhad7IVut/yG/K/Hlkgeim
   ALxrMtEZl46V9zlnB/SFPhM89MbVjyjIFbUb8YNwoQ8IwevAWFjsIue/+
   w==;
X-CSE-ConnectionGUID: 16ViZFBcQi+jDYtwAWq3JQ==
X-CSE-MsgGUID: Lwiema9qS6mbA66CHC0b/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="46094664"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="46094664"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 08:55:23 -0700
X-CSE-ConnectionGUID: cplgreKTSEakE5AyF5kxxg==
X-CSE-MsgGUID: ooRjsaEMSIq0Ki0sjX+eiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="121932500"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa010.jf.intel.com with ESMTP; 17 Mar 2025 08:55:21 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: giometti@enneenne.com,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2] pps: generators: tio: fix platform_set_drvdata()
Date: Mon, 17 Mar 2025 21:24:52 +0530
Message-Id: <20250317155452.2038020-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently driver_data user is expecting a pointer to pps_tio while
platform_set_drvdata() is setting a double pointer to it. Make them
consistent and fix illegal memory access in driver ->remove() path.

[  156.254066] BUG: unable to handle page fault for address: ffffc9000117b738
[  156.254099] #PF: supervisor read access in kernel mode
[  156.254111] #PF: error_code(0x0000) - not-present page
[  156.254197] RIP: 0010:hrtimer_active+0x2b/0x60
[  156.254367] Call Trace:
[  156.254375]  <TASK>
[  156.254382]  ? show_regs+0x6d/0x80
[  156.254393]  ? __die+0x29/0x70
[  156.254402]  ? page_fault_oops+0x15f/0x4e0
[  156.254415]  ? hrtimer_active+0x2b/0x60
[  156.254425]  ? search_exception_tables+0x65/0x70
[  156.254437]  ? kernelmode_fixup_or_oops.constprop.0+0x61/0x80
[  156.254451]  ? __bad_area_nosemaphore+0x195/0x2c0
[  156.254462]  ? __lock_acquire+0xaaf/0x2840
[  156.254475]  ? bad_area_nosemaphore+0x16/0x20
[  156.254486]  ? do_kern_addr_fault.part.0+0x64/0x80
[  156.254498]  ? exc_page_fault+0x190/0x2c0
[  156.254511]  ? asm_exc_page_fault+0x2b/0x30
[  156.254527]  ? __pfx_pps_gen_tio_remove+0x10/0x10 [pps_gen_tio]
[  156.254541]  ? hrtimer_active+0x2b/0x60
[  156.254551]  hrtimer_cancel+0x19/0x50
[  156.254561]  pps_gen_tio_remove+0x1e/0x80 [pps_gen_tio]

Fixes: c89755d1111f ("pps: generators: Add PPS Generator TIO Driver")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---

v2: Update commit message (Greg, Andy)

 drivers/pps/generators/pps_gen_tio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
index 6c46b46c66cd..6e4a383957d9 100644
--- a/drivers/pps/generators/pps_gen_tio.c
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -230,7 +230,7 @@ static int pps_gen_tio_probe(struct platform_device *pdev)
 	hrtimer_init(&tio->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 	tio->timer.function = hrtimer_callback;
 	spin_lock_init(&tio->lock);
-	platform_set_drvdata(pdev, &tio);
+	platform_set_drvdata(pdev, tio);
 
 	return 0;
 }

base-commit: 6f119e3da79ce5e586340059403ab77201c1bb45
-- 
2.34.1


