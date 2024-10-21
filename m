Return-Path: <linux-kernel+bounces-374451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D8A9A6A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0220DB25374
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A81F7094;
	Mon, 21 Oct 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIocV2gF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097D198E69;
	Mon, 21 Oct 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517833; cv=none; b=s1CPRwtdRw4CdpHyfsFuvFxvg1lWe08W3UhvDu4G/FxgPc6pzWHSsGxm+4bzQFuNL5hoJ1OcdIDq2w2C60FoMqu5LZt0eF3bUzLyddIB1u+DonVzyLwvMI2+piqUrTCJGiCn1YQBkbsEFZCC3k/cH11CHOSyi+QWfcXctLs6ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517833; c=relaxed/simple;
	bh=Ub2dWPjLXcZSostXR3uZOgyUm+npCtYNbqjkwt9Nj1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxGP3b5R23uxqoY5+dtcw05cYNJ15ydFgPjGoG9Ri39Uus+DjK7agd0sPA5cESf14jW1pvL2seXv/3+DWBAH9CFDlbE8g231T+zncbp/iDwkQzBHFcvR2AtrR7CEon/EMdcrYkv4itAyjJWu2cDYKu8xbHSvh/Kj5lhpJbwNK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIocV2gF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729517831; x=1761053831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ub2dWPjLXcZSostXR3uZOgyUm+npCtYNbqjkwt9Nj1s=;
  b=JIocV2gFnk6/GVfU1BNt9zcYjptyp8xhxAOaP1l5T/yuAnYjAgTSvR8q
   b6NfSOIcK73WSTHvdmpPwR3FDa7i/7lAKWYasdpa3l2DqnTCgkgTZ1R8R
   KdgSGTBD5D3JziNBH2GxnAu1Yx5hZCOIoLv9tvEg4zneGpevDeUW22AOi
   qqvujuyetLPiNMbGmD4bo7y/OrBW/7ONi3kvdF7UYFCkXlRoDuDfLNRBN
   tNzB5uze9jyL+1PMwK9AxgRaiULg+3TQpzmYsEmw02qhqyo8GYMsqDLDZ
   Wt7/Ki6N/BugRx6883vfwKrv0TbgujGPvALN5uIIt7rJILst3Fx8VRgte
   A==;
X-CSE-ConnectionGUID: Lw2RZtxZQi6hpDySu+P/wQ==
X-CSE-MsgGUID: rgmgpv39SK27dMMP4/2IHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29210966"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29210966"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:37:10 -0700
X-CSE-ConnectionGUID: khsTC9uvTVipV93fflK3SA==
X-CSE-MsgGUID: E98V/QsnSUmNIef8oq4kvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="83544886"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 21 Oct 2024 06:37:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5217C35B; Mon, 21 Oct 2024 16:37:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v3 2/5] platform/x86: intel_scu_ipc: Replace workaround by 32-bit IO
Date: Mon, 21 Oct 2024 16:34:30 +0300
Message-ID: <20241021133705.2933464-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
References: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The theory is that the so called workaround in pwr_reg_rdwr() is
the actual reader of the data in 32-bit chunks. For some reason
the 8-bit IO won't fail after that. Replace the workaround by using
32-bit IO explicitly and then memcpy() as much data as was requested
by the user. The same approach is already in use in
intel_scu_ipc_dev_command_with_size().

Tested-by: Ferry Toth <fntoth@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 8d11d18701a4..290b38627542 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -217,12 +217,6 @@ static inline u8 ipc_read_status(struct intel_scu_ipc_dev *scu)
 	return __raw_readl(scu->ipc_base + IPC_STATUS);
 }
 
-/* Read ipc byte data */
-static inline u8 ipc_data_readb(struct intel_scu_ipc_dev *scu, u32 offset)
-{
-	return readb(scu->ipc_base + IPC_READ_BUFFER + offset);
-}
-
 /* Read ipc u32 data */
 static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
 {
@@ -326,10 +320,9 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 
 	err = intel_scu_ipc_check_status(scu);
 	if (!err) { /* Read rbuf */
-		/* Workaround: values are read as 0 without memcpy_fromio */
-		memcpy_fromio(cbuf, scu->ipc_base + 0x90, 16);
-		for (nc = 0; nc < count; nc++)
-			data[nc] = ipc_data_readb(scu, nc);
+		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
+			wbuf[nc] = ipc_data_readl(scu, offset);
+		memcpy(data, wbuf, count);
 	}
 	mutex_unlock(&ipclock);
 	return err;
-- 
2.43.0.rc1.1336.g36b5255a03ac


