Return-Path: <linux-kernel+bounces-373915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EA9A5EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DE81F2210E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A51E260E;
	Mon, 21 Oct 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLF9/g6j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F41E2305;
	Mon, 21 Oct 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500062; cv=none; b=eTA3S9Zb3VJgAVdOX7HOHSZBGbGKvOKwhQ8/f9kPXD+PE8CkvhK670H4PrCQ0v2KyFyLFRPoM61ly+eh2FcSCNhQYTEKgil3pr2XuOVshojPz6jsRt90hvJ5qf0bA3EMpo1swgITB+hP4Nsro1SpJECZ7Om72x4OrS5xQomNMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500062; c=relaxed/simple;
	bh=xrr2Tv8Prfj751SqQj7aeRu7DO0u4LIk/A0YJQFm5So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDIWyE1eS6exwgWHbb8NZ0vWpHUCxAzU4K0hHniKOWQEX8qGlkjPpBuHTKNZ5z++oHZGb5hKkT2hYfRYhDGMTIlKTnG3CUpFbSRZqEXz1GgGtxkpZmCYQbEcyWiAVNfahjedQhkuWJ9talmETj2PBeOTOtEJ3KapV/yPAUvVtwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLF9/g6j; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500062; x=1761036062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xrr2Tv8Prfj751SqQj7aeRu7DO0u4LIk/A0YJQFm5So=;
  b=YLF9/g6jILXA8ASOlMJnZrRgOBgQk6Mg/6DkCdEuoqfdnHmjLW3doMXz
   OQSoY/bZCKGgsjqVOPCzzTLMDhXXZiM3Zr4YJ6kaLDQHS2Q+XsMDnoyW5
   YLk5FZh6jwoKSN5+tFe5p+4E7UvLyx/n1KitNOQ+zZhnMtPHjWT9q2wbJ
   WpZy4pM9Z30dTPM+XxqYhX8pkNxkP+o+1tKWyf/sElVqtcgL6+O39S5NP
   tJneEaVw0/r2tp+4zlT7qM33sxXinKjU+UOahMRkntv5sFDl+9OHfiu8I
   eV0SJnI20Pma3n9mNk8QYGqqbSggBh8wjOzePoBH3EB8T5aJ7UbZ0T+0Z
   w==;
X-CSE-ConnectionGUID: VMtG4tLGSuSg+QliFrndSA==
X-CSE-MsgGUID: S1s0wD1ZTTCNO1fvaVcSBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32778772"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32778772"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:41:01 -0700
X-CSE-ConnectionGUID: JtwHjyYTTYy/RijISxA6BQ==
X-CSE-MsgGUID: Q2tD/Z3PQESKEIzH/FrH5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84250915"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 21 Oct 2024 01:40:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 417341E0; Mon, 21 Oct 2024 11:40:57 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Replace workaround by 32-bit IO
Date: Mon, 21 Oct 2024 11:38:51 +0300
Message-ID: <20241021084053.2443545-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
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


