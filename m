Return-Path: <linux-kernel+bounces-432619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9E9E4DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759E8167EDC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F244C19645D;
	Thu,  5 Dec 2024 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2TlLoJo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3417C208
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381526; cv=none; b=de7AnqLk8jWDza1mWMUy7mkuuJIQT+AK+7O1Y58UlFZ8MeloAPaXASlA6OeZSGoAFALt9B7y4OE6tVEt0oUS0g4TD2zw0NfKJP3HuvvuaGyr1equ0rAMjahL5kxDCw38q8iCRbGa0Og8HDcWsdgwQVMuPpd005VjIe2/9WrvuuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381526; c=relaxed/simple;
	bh=eSX2v5PuzA2MXSSzTQpEhE29wIDDU83B8ybeS+K6Kww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O4EfqjQ6SjR+OfE5h75wXKvg3zcw3tFST80j0NcfvigOi+ErqcfhysgrHJWGluSzFnSoIE57FS/+X6A5IWaYbGoYHxKVwkNlyQ71QMfW8c+tkVpgJVQMwtppNWqRCerE8sqy9LL3adzEB19ok6PGq0325gouQACu3iAFcSNdGiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2TlLoJo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733381525; x=1764917525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eSX2v5PuzA2MXSSzTQpEhE29wIDDU83B8ybeS+K6Kww=;
  b=b2TlLoJo7nck0PzGUO6P3A3vajhTnH/VmB5BX12Bn49AKetkTnCGWYZR
   tFvx+LwNYlYG626YuZcu9Nf+tE+8g4QxfxvI6TJdTz8ZJ63hfkXAzHyt7
   KyBzXaPXXeUL197dsxapGk57hCqqnafCOo2D1z95Y5mE4Q+fhVOP+OiJs
   pBT0lJSTU4So9EYS2Vwro9PsQyv3BgnQa/T7tc1Uix/uvw0STzkUfwAT0
   7ZUsR3wWWX1fwRJWCcojIL+4NGMWxTNTUVXlNgNtd8Mmr+OiW6c2bS6ty
   cLtkWLjUq4i5VbTEu3DY1wGqUI0w9RRMyq9rtAHTDSa1+kNkHdsolwsYO
   Q==;
X-CSE-ConnectionGUID: xejOwO3VQaibenmKL5qQEA==
X-CSE-MsgGUID: C9xWSF4WTnuvafKAKvLmGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33028964"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="33028964"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 22:52:04 -0800
X-CSE-ConnectionGUID: 4U68goN8T+yxGjMZ97rmzQ==
X-CSE-MsgGUID: tAxrJk4qRtKMwowbqdGFQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="117250934"
Received: from ubuntu.bj.intel.com ([10.238.156.105])
  by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2024 22:52:03 -0800
From: Jun Miao <jun.miao@intel.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Shyam-sundar.S-k@amd.com
Cc: linux-kernel@vger.kernel.org,
	jun.miao@intel.com
Subject: [PATCH] net/ethernet: fix typo in annotation comment
Date: Thu,  5 Dec 2024 14:52:18 +0800
Message-Id: <20241205065218.1288394-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It`s "auto-negotiation", not "auto-negotitation". Let's fix that.

Signed-off-by: Jun Miao <jun.miao@intel.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c  | 2 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 07f4f3418d01..5597e7df0aba 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1264,7 +1264,7 @@ static int __xgbe_phy_config_aneg(struct xgbe_prv_data *pdata, bool set_mode)
 	/* Disable and stop any in progress auto-negotiation */
 	xgbe_an_disable_all(pdata);
 
-	/* Clear any auto-negotitation interrupts */
+	/* Clear any auto-negotiation interrupts */
 	xgbe_an_clear_interrupts_all(pdata);
 
 	pdata->an_result = XGBE_AN_READY;
diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index fa3dfafd2bb1..2bcce6eef0c7 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -1581,7 +1581,7 @@ s32 igb_disable_pcie_master(struct e1000_hw *hw)
  *  igb_validate_mdi_setting - Verify MDI/MDIx settings
  *  @hw: pointer to the HW structure
  *
- *  Verify that when not using auto-negotitation that MDI/MDIx is correctly
+ *  Verify that when not using auto-negotiation that MDI/MDIx is correctly
  *  set, which is forced to MDI mode only.
  **/
 s32 igb_validate_mdi_setting(struct e1000_hw *hw)
-- 
2.32.0


