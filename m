Return-Path: <linux-kernel+bounces-367947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422309A08B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAB6B264B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4C2207A0B;
	Wed, 16 Oct 2024 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/7AqyRj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F81206059;
	Wed, 16 Oct 2024 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079439; cv=none; b=hMliwM8ceBTlDPQxZPcFwo6R79lv6iMUBPHCcufPIkX7nV7M/DnvS9rsOUfXkNTInMKdvHwqRWjAGb9o1W+/FWuK1cVcbXc7gfl8vpnRFcR+b+jbeMBCyQMtDR84QCQcu6JLScGr1Mj4kCZUZWv7605hPy3cyhOG4QQMoBK5ciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079439; c=relaxed/simple;
	bh=v1on7WxTr15BmwhGpIyMY+hnj/xt4RZUht8X+2KbXaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZroahIyADLjPT3t3EwA2zi1O3ssgOgTYJlcqiLvtCekTEJO43LpvepSbbAk2CA7I++yCAEqu+ji39dA9hnAfVcQout0utt2077wcLglW995Jy/UMSXNOxvKPcN2jxw/9M+K7VTsmm+GMxHV+oXFSZt9qMGCx24lK0mYOVyVO8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/7AqyRj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729079439; x=1760615439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v1on7WxTr15BmwhGpIyMY+hnj/xt4RZUht8X+2KbXaY=;
  b=S/7AqyRjCD6wLlCkgkPvGV5WWDtfOPVfZAPXayf5jWNRzc3oNjQnshZN
   ZQva85hN+OOGtDGf3r7lkR8HhZRrg8rURjcYFjUYqfkrrHtKwOgBUh3M2
   df387cxhoXNbXtOM+zJMNlQu5ryCvoNjGM0tt7EGG4uTaI7ox69U3LgLU
   BAJnweUPlNrgjAlEgIseEMzulPpXDu6RkqgkpT2wYEjoFtjguc1gObXTu
   BZAHCYG90rJ9fPy0VMiX+YDd1tXzOzihoM7dJq8maHGkCrtYtDQvcODW8
   acCymtVDxDDk7m8ft1ae2y/fHVgEe6virDyZBwdH3g4BXZVG1sWlj5983
   A==;
X-CSE-ConnectionGUID: GCAwVjo3TtqmnVrGB7o0FA==
X-CSE-MsgGUID: rPlaU5BRTLCJb4REZs88Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28306990"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28306990"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:50:38 -0700
X-CSE-ConnectionGUID: HZxH4/4NSnamAqUioHzpvw==
X-CSE-MsgGUID: rREieHrfRymjLqCqutXcSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78548799"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 16 Oct 2024 04:50:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BD9C1159; Wed, 16 Oct 2024 14:50:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v1 1/3] platform/x86: intel_scu_ipc: Replace workaround by 32-bit IO
Date: Wed, 16 Oct 2024 14:48:24 +0300
Message-ID: <20241016115033.858574-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
References: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 5b16d29c93d7..290b38627542 100644
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
@@ -325,11 +319,10 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 	}
 
 	err = intel_scu_ipc_check_status(scu);
-	if (!err && id == IPC_CMD_PCNTRL_R) { /* Read rbuf */
-		/* Workaround: values are read as 0 without memcpy_fromio */
-		memcpy_fromio(cbuf, scu->ipc_base + 0x90, 16);
-		for (nc = 0; nc < count; nc++)
-			data[nc] = ipc_data_readb(scu, nc);
+	if (!err) { /* Read rbuf */
+		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
+			wbuf[nc] = ipc_data_readl(scu, offset);
+		memcpy(data, wbuf, count);
 	}
 	mutex_unlock(&ipclock);
 	return err;
-- 
2.43.0.rc1.1336.g36b5255a03ac


