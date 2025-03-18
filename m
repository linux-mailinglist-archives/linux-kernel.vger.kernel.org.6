Return-Path: <linux-kernel+bounces-566083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F96CA672E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E5517FD65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA120B1FE;
	Tue, 18 Mar 2025 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWS7BQ4U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1C207657
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298102; cv=none; b=hR23fXMuZhwgZIYyYYBmcIjVrDqGcxUfNXgXZsYGiFWnWWIeWFe0ayp8c6z35hi4vxz3bKcl98T1XRueAGFw7BB0ssHjWESIHuYmNRxO0MAp5X9F3yMjBabSBZd8W2WCkLjRmt286xEtgvmFIYsVosJOndj40vFWYKCPaM9ta+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298102; c=relaxed/simple;
	bh=SxofddRPRlI1qKjXLI11P02gLGiwluXO+SH0e0hs77A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QSqJMSn3zUXfyS2Lrc1udG0z4rC8vZ/y2yg4nqWf0c4GCwwwZsfo18G4GSIJ+RDacuga7/7SravZnZEZbcmDZTsAdHK4OyYowWIwiTHZUBVZ2OGHU6ayoPlTKD3e1g2J4jexthhPV9F+pR0unt4c30KzE0E7nwshI111t2jcveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWS7BQ4U; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742298101; x=1773834101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SxofddRPRlI1qKjXLI11P02gLGiwluXO+SH0e0hs77A=;
  b=fWS7BQ4U402WHsXLBKoPMbq6inCdS00AR0rLqPYNFG3pZpXUUGZLxfk4
   VI1AjLVSrymtBvuFJfnuHBAoqjvVpM8aIupy6eMz8fm4Anhm9UTuzQXve
   yOLH6afLCeMLmHP8UKlcKjXIUe1pHeFJ5Se8TeBlugxzyGNmRe6QGeEXx
   AfiH3QvECHPWw+unxF0EaitF+7KKVsregDkSCfnRWD5RzeEBBIim+Q1Bu
   NM9h36WTl2kdImnEEpDnh2VXdsxCOttQRKc6Yhzs765Anl/ELI/SoQ+sU
   lNSq+XpxWuwvo6f1Njx+lHz205MlG/Ps+LjfnnwjO7UBnMw11zD6RH17I
   A==;
X-CSE-ConnectionGUID: exZtfnkvTBy8ScamrS5NQg==
X-CSE-MsgGUID: Si4151ZgSg6j0s2ztciDpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43623251"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43623251"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 04:41:40 -0700
X-CSE-ConnectionGUID: uAQTZNV2SjW5oaeLAZiD0g==
X-CSE-MsgGUID: cwY0FLX8SGaA+ID/hkywLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="127275742"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 18 Mar 2025 04:41:38 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: giometti@enneenne.com,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3] pps: generators: tio: fix platform_set_drvdata()
Date: Tue, 18 Mar 2025 17:10:38 +0530
Message-Id: <20250318114038.2058677-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_set_drvdata() is setting a double pointer to struct pps_tio as
driver_data, which will point to the local stack of probe function instead
of intended data. Set driver_data correctly and fix illegal memory access
by its user.

 BUG: unable to handle page fault for address: ffffc9000117b738
 RIP: 0010:hrtimer_active+0x2b/0x60
 Call Trace:
  ? hrtimer_active+0x2b/0x60
  hrtimer_cancel+0x19/0x50
  pps_gen_tio_remove+0x1e/0x80 [pps_gen_tio]

Fixes: c89755d1111f ("pps: generators: Add PPS Generator TIO Driver")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
---

v2: Add crash details in commit message (Greg, Andy)
v3: Shorten the call trace, rephrase commit message (Andy)

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

base-commit: a24b18aa4fd619cc7961dae3395473c355bb5b6a
-- 
2.34.1


