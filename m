Return-Path: <linux-kernel+bounces-429529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8669E1D6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F652819D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32D31F668F;
	Tue,  3 Dec 2024 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIcRMdCz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F601F668C;
	Tue,  3 Dec 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231923; cv=none; b=G5HMKLmkIck/luSTJLj8ud28QFZXTUxQ+cAaGgZbv/H6wbakwOp7PnbdwWUEV/4FrrnXQDCfxRGwgh0PNINTdydaYkY27Xf6ntzg/EbWOpePDeIvzXKQ8BQ2fHLbk3qi1Xsgc847HHTcfhplFoNVOr840RQyMBv/8WPdMelMD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231923; c=relaxed/simple;
	bh=Bbir8Z6IL9F1YVRy3jwAe9p99Ugyno6+qfCPr+tqjHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDs5NE6KAePjHm1GWlTlHWKrkryVrLLXSApkgQsayjp0e5jqhtgzCwnrPTxrQW9pPsSYBDxzy/euwwxkzbZDlYoI1GIumNFjl8MnTLXUJIG8rgyjNAg+DPcc2h4eFpObGLTNfoWcxCdg7kpbociW2ihjRVcLhkaHUUSaVgp0w38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIcRMdCz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231922; x=1764767922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bbir8Z6IL9F1YVRy3jwAe9p99Ugyno6+qfCPr+tqjHU=;
  b=nIcRMdCzNjVOqt4znJSFWJW0sNAhvcUddQrjGtBgMlUuMsaEdo4jr+vM
   pptzv65TeAKLNxr6z4h81wTj+r+cE+NJ2b2n4y7ROpc5V8f/Xt+VYdWmB
   8Cv3Tmn8R2rakxMF3fZ1BmJ1Ly2FTY31Dwudk67idiVcwfxC/IOVqdBnJ
   3ZKPliwmiOdW0n5lepkpddQJ+8rUytHjYENbUBWNwFCuecK7WTW1LQaJ4
   CBQGvKydEux7oAo7NEAD9dV0TC67ajPzHtkx9XR/IDfoI/MWoG9Qjzcnw
   COEJReXHpwYAPlRkcp/+IKyADK5dYOhwzfisx1llbctn1b6AlVyNKr4YO
   Q==;
X-CSE-ConnectionGUID: 1x0xq4IxTyG5+xl+kQJ9NQ==
X-CSE-MsgGUID: R5W8ldjbRzqa4v2SgJGq0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500757"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500757"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:41 -0800
X-CSE-ConnectionGUID: ZbgVXoLnR9OXM+b+CgpL6A==
X-CSE-MsgGUID: yRhj4p1cT3KdnnWmcWCzIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896116"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:40 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 09/14] soundwire: generic_bandwidth_allocation: correct clk_freq check in sdw_select_row_col
Date: Tue,  3 Dec 2024 21:18:08 +0800
Message-ID: <20241203131813.58454-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bits in Column 0 of Rows 0 to 47 are for control word and cannot be
used for audio. In practice, entire Column 0 is skipped.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index d847413141d3..5c4dac36ad1a 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -302,7 +302,6 @@ static int sdw_compute_port_params(struct sdw_bus *bus)
 static int sdw_select_row_col(struct sdw_bus *bus, int clk_freq)
 {
 	struct sdw_master_prop *prop = &bus->prop;
-	int frame_int, frame_freq;
 	int r, c;
 
 	for (c = 0; c < SDW_FRAME_COLS; c++) {
@@ -311,11 +310,8 @@ static int sdw_select_row_col(struct sdw_bus *bus, int clk_freq)
 			    sdw_cols[c] != prop->default_col)
 				continue;
 
-			frame_int = sdw_rows[r] * sdw_cols[c];
-			frame_freq = clk_freq / frame_int;
-
-			if ((clk_freq - (frame_freq * SDW_FRAME_CTRL_BITS)) <
-			    bus->params.bandwidth)
+			if (clk_freq * (sdw_cols[c] - 1) <
+			    bus->params.bandwidth * sdw_cols[c])
 				continue;
 
 			bus->params.row = sdw_rows[r];
-- 
2.43.0


