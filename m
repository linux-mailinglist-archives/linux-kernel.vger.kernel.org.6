Return-Path: <linux-kernel+bounces-215726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755D909651
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFDA1C2187F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 06:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A5E17BCB;
	Sat, 15 Jun 2024 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQj5mueM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8317BA2
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718433135; cv=none; b=J6KPFDxp+ezFWjsYS4pb2T0rRd6j+mNdR3ocPNcJ3A1tAn9Tr6pTevytxBL5SQDsBSu8cHwWu/rNNEZb5lfwEL9nhvU50x3lNC1MJfsSDamU4CQIz6MocissVRXMYI06a7oD9wL5H4pN43s1IqemjiOtfR2BSwP6I9SosuJ4dQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718433135; c=relaxed/simple;
	bh=tDuObTQNohrxi3Di5MxkNEgF1UteDJXO8ZGJ0znwqRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7eM0eoYJbmlgWZsXEd/xzrX6V3aOkyFTA3yFZESsHEeOAqFNfx6COPYky0dWc451uH3BVna6hye3QbdDIbXW2hcP3hpcPXwdpuwIMjiYVGDUG7t9cP1dbY8raOFmlmhYph2iaIOWzSvG4sq8z60XSuGJ47SV8Phb2I/hmLpiY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQj5mueM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718433134; x=1749969134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tDuObTQNohrxi3Di5MxkNEgF1UteDJXO8ZGJ0znwqRk=;
  b=OQj5mueMPYnJLsLg1dHMCg6iNswXTyXKZ3nf4UL4T2gv/BRZYUuv1+tB
   7ex2jwjp5UJKI4tgP/hendm8ANSFwODT3+BqsFNtNPLGDj+1VlEiSt/q/
   RwgcMmaByPrNgSi57D2gVvlprdaNSIg+SvDzwLRAQZTQXU5Jx06d5LT3a
   iYYWsqL9WgGQdOwUKGu5BCI5MsR/0pZrjbzzRq2KA2bnhSX3LAOfmJCek
   GsMGxiqYKzCjMvFElOOdLEFg2/007kBDwod1JuF9lBG6dkwMAwSpRZE+L
   89yOL1mBDXV89crW9H+piD3Ka1kGwX3etBYoS06SCSPqTnBdSGDPEXvOR
   A==;
X-CSE-ConnectionGUID: YWgRuzchTaq/Z+bGCeKOhg==
X-CSE-MsgGUID: YgullBehTGujHsckA6hWuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="18255628"
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="18255628"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 23:32:13 -0700
X-CSE-ConnectionGUID: T825KSTvTcCXQOdgWavPfg==
X-CSE-MsgGUID: Sb4OFn+ZTsaPvQrQeYGOsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="71498047"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 23:32:11 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: bus-fixup: set timeout for MKHI send operations
Date: Sat, 15 Jun 2024 09:31:59 +0300
Message-ID: <20240615063159.1460290-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Set a timeout for MKHI client send operations in the bus fixup routines
to prevent potential lock-ups on the cl_bus_lock mutex.
In rare conditions, such as when the i915 or Xe driver is stopping and
not routing interrupts or when GSC FW is in unexpectedly reset the fixup
routines can get stuck.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 2733070acf39eabfd606da38..9eebeffcd8fd0645cecba167 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -80,6 +80,8 @@ static void whitelist(struct mei_cl_device *cldev)
 	cldev->do_match = 1;
 }
 
+#define MKHI_SEND_MAX_TIMEOUT_MSEC 4000
+
 #define OSTYPE_LINUX    2
 struct mei_os_ver {
 	__le16 build;
@@ -128,7 +130,7 @@ static int mei_osver(struct mei_cl_device *cldev)
 	os_ver = (struct mei_os_ver *)fwcaps->data;
 	os_ver->os_type = OSTYPE_LINUX;
 
-	return __mei_cl_send(cldev->cl, buf, size, 0, mode);
+	return __mei_cl_send_timeout(cldev->cl, buf, size, 0, mode, MKHI_SEND_MAX_TIMEOUT_MSEC);
 }
 
 #define MKHI_FWVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
@@ -148,8 +150,8 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	req.hdr.group_id = MKHI_GEN_GROUP_ID;
 	req.hdr.command = MKHI_GEN_GET_FW_VERSION_CMD;
 
-	ret = __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0,
-			    MEI_CL_IO_TX_BLOCKING);
+	ret = __mei_cl_send_timeout(cldev->cl, (u8 *)&req, sizeof(req), 0,
+				    MEI_CL_IO_TX_BLOCKING, MKHI_SEND_MAX_TIMEOUT_MSEC);
 	if (ret < 0) {
 		dev_info(&cldev->dev, "Could not send ReqFWVersion cmd ret = %d\n", ret);
 		return ret;
-- 
2.45.0


