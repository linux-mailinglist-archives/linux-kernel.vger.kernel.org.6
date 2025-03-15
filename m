Return-Path: <linux-kernel+bounces-562590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E789A62D7C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C586D3BAB3D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6BE1EB36;
	Sat, 15 Mar 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XT06k3m8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D3B64A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742045531; cv=none; b=DnUmX8bwJCPaxIttmK2kAGt4aNGsxi4H5NyaKy7A0GgUfEptI2TNdba5/v2KfVuJlsFmeadb0PYw4K6RoOujgXr5OYfSITBB9tLwY2x1xv0epbJoiAb9oQrxb1gh4QHslN1x3StQmffyhDKBrfYvgUax+ujouVVTYnYBqiFqLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742045531; c=relaxed/simple;
	bh=Vi2s4rEbVCpwwO1scAuD/drTL0bN0ZJrl+jU9CAaTlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pBUTOVq2uVQjZlvUR2JgTKXlVIe+nv5ip60/l2zpAtHfuw3S6jDUR0xfzyGtnj5ciWjtjHiH1TV6CLHzohteKDIInBts9Cwn/D0Uxq2Hli4FA+HUVK5gHrsT2KbqllFNM8AuOIJuLmjxntK10ZKk5yVtYPBldndM1/z4D5DIOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XT06k3m8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742045531; x=1773581531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vi2s4rEbVCpwwO1scAuD/drTL0bN0ZJrl+jU9CAaTlo=;
  b=XT06k3m8r9Fckucd+YquNWN32A3EyKaUCwkyHj9rcXJKAJpaCNycuCAN
   8ZUxizHXw1c37UzD/tlO92u7zmuy1MgszWL7NbtZkuYmsEW2UCgKVnmdP
   7fjN7+1ICpky6pmxUwlzt6bvTNO0tWai2CCT6pSUh8s7ZmxGNgOjU9Isj
   1QopsTb7me9gpK5DrHwAmEYHcjdSSD5/HfYBME2XE2gBVo2Pi6HQkWvBu
   nKeVbSzGt2EPd2pK3SrhsV0LjSSbwGuZwHphhwBPQDGr7aGFAX9nLV9DQ
   liL77JZEmXy0pjajYqawamkmIqzaOT73Xp1kmEIniLFaaiKJGFO0K7NDF
   Q==;
X-CSE-ConnectionGUID: N4xWH7uVRc+Vpo4Tpyq1fA==
X-CSE-MsgGUID: 2WY40ly8RDG1Z545v45zLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11374"; a="43100576"
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="43100576"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 06:32:10 -0700
X-CSE-ConnectionGUID: a31XBvqrQxmS+RcbsvpjdQ==
X-CSE-MsgGUID: /mRNUi+pR1yCzlHAH9M3Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="152469925"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa001.fm.intel.com with ESMTP; 15 Mar 2025 06:32:07 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: giometti@enneenne.com,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pps: generators: tio: fix platform_set_drvdata()
Date: Sat, 15 Mar 2025 19:01:40 +0530
Message-Id: <20250315133140.1707949-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set driver_data correctly and fix illegal memory access on driver reload.

Fixes: c89755d1111f ("pps: generators: Add PPS Generator TIO Driver")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
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


