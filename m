Return-Path: <linux-kernel+bounces-185310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525048CB358
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56501F22A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEA414884F;
	Tue, 21 May 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ek2ZomHX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D377105;
	Tue, 21 May 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315178; cv=none; b=LpxRu5QWQVL0Ey8m/FI8Uu05hmeE8YR+WbU0ns4OoCW2hxX07TEoQ+M0PlIV48DwcZtSwsgxH9WStEPUPyiR4im8tEpsjbJ+lLYx3Cf+gIDUeozK2QKo/PDmrwZE4JchQl/b7VDcXVthD2F23q+lAinnY/8jNlKgccZf/gtBzvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315178; c=relaxed/simple;
	bh=pelV7Lu9uPZxQtnhuXBP31d0jEKwnjwXv+Stp9All08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WoAb1PqwmcD6Ird2hyGSNlbAwmJqqjqDbttGou9QOCqlopVAfT2s5ZRZUIh2tKntS3BDIYIGb/QWefhfp8eid+syciamDMJBbbPu7x1H7VRxbBrK1UN7vwumJbgBmk8MOX5em45viaEsgp7t5IBiCjYX/kTVR3d94Edw0nbaWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ek2ZomHX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716315177; x=1747851177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pelV7Lu9uPZxQtnhuXBP31d0jEKwnjwXv+Stp9All08=;
  b=Ek2ZomHXvYtcUPl8jXl1WK3u/NHE12+Ct2NnBmShocrfSlpRIFgFL/E9
   C6pFr+dd8OlSCHqKc0OnZZ4UhynMufqaPLv2/4/pu3Dv/7fn3B4pyGMfz
   zxCiir2bE0s28dOTZRvUgxLVWf55851mv5mIkVgKl7bqQbHFLVt+DWISe
   4ndYE0zJfAzV3WwSzcpQ3F3KQHJejEqXnAh+YZEizDwz9oCK+VAHRMZCd
   4U9D9NrUPiMOQV2kHNlbgGnbhNqPv03jg9Q1j+r/05OFkHl88VcnD2N53
   D4PrLwbvU3y5IUsVbZjBJTkMF46WfuxQxGa4x4kDBjOwuWbUMQ2AEb1sp
   w==;
X-CSE-ConnectionGUID: U0cK0063SwGpNFSz4x2SOg==
X-CSE-MsgGUID: BAa8VR1RQm6mNW9qTD6FWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12375745"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12375745"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 11:12:56 -0700
X-CSE-ConnectionGUID: k+m1RDf5RDSLbVSljkxK8g==
X-CSE-MsgGUID: WiGwd8xFStqD93llk02bFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="70423956"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 11:12:55 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Tianfei zhang <tianfei.zhang@intel.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH] hwmon: intel-m10-bmc-hwmon: fix multiplier for N6000 board power sensor
Date: Tue, 21 May 2024 14:12:46 -0400
Message-ID: <20240521181246.683833-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel N6000 BMC outputs the board power value in milliwatt, whereas
the hwmon sysfs interface must provide power values in microwatt.

Fixes: e1983220ae14 ("hwmon: intel-m10-bmc-hwmon: Add N6000 sensors")
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
Incorrect `sensors` output on Intel N6001 with v6.9:

Board Power:                                   36.03 mW 

Correct `sensors` output on Intel N6001 with v6.9 and this patch:

Board Power:                                   35.79 W  
---
 drivers/hwmon/intel-m10-bmc-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
index 6500ca548f9c..ca2dff158925 100644
--- a/drivers/hwmon/intel-m10-bmc-hwmon.c
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -429,7 +429,7 @@ static const struct m10bmc_sdata n6000bmc_curr_tbl[] = {
 };
 
 static const struct m10bmc_sdata n6000bmc_power_tbl[] = {
-	{ 0x724, 0x0, 0x0, 0x0, 0x0, 1, "Board Power" },
+	{ 0x724, 0x0, 0x0, 0x0, 0x0, 1000, "Board Power" },
 };
 
 static const struct hwmon_channel_info * const n6000bmc_hinfo[] = {
-- 
2.45.1


