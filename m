Return-Path: <linux-kernel+bounces-374455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21EC9A6A81
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C361C23EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34D21F940F;
	Mon, 21 Oct 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiGzNBB3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC361F81B7;
	Mon, 21 Oct 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517836; cv=none; b=b5oJwNqYYiZns83hBkWvV1pr1ZVUdTd5lOmZWRMPttpZNQtVcm5AIibNBoGL2XcYra0lfCmEZz+WFGT4wlAOxK2PH9Tsro2OT3WJZDf7Vb30AJu2NB40yoP88Y2WQNgCWgZBrYm8kv0X7S4nbbogT7LOn72OqqYH1csWGjU6+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517836; c=relaxed/simple;
	bh=AkHhds51M/8sSSLir/oPbIB3XfHomKMWs2MteMbrEKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPrV0bOVupYONOBlyWgxuvnClu1XdfUrt05/3BL/YUlDsoKsgOq3U4LeDTy1qfTMeIQu2IPNoJ/BknGxWv/6xSFjK6eRf6EsO4n1ksgkt9KIiphguEGK9ZcO+kyIqAWB3JgMr4bHwDr11R6TKqkBCvsyLHuQ6Q6gT2e0VQMWZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiGzNBB3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729517834; x=1761053834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AkHhds51M/8sSSLir/oPbIB3XfHomKMWs2MteMbrEKM=;
  b=HiGzNBB3+UJecGytPEQ67eLUUmvVMFdNhEoDh/RXU7WfkRDvfXPGR4J7
   UyNYlncc2IAeYWbUyDMo5r4QDCk5sxV6M/owq6hca0NnSDqK1krkscY9Q
   JXr7R2zjakO0UJn27agozC81u/XQ51M/W9E8I1KAJTP2uab4I2fyN2nXz
   2G7a5n/uIuS65yj7ym75gd6RA+5BWnQZ4jtvmPg+VW1AQW/OeUnY+JDDU
   wl7MfZX+Jbn/QNG0ZwMf8gu98NE+DQW3bhVf+AnNzWJp3SS6S5EAvin7n
   x2DwoCX7DW9PNh6lR3aWVFIJg4MZIjRivJBAiZXgL8jwO/WsE+TG+DMqk
   w==;
X-CSE-ConnectionGUID: 9Byjxli9TaC/8R5zyHE15A==
X-CSE-MsgGUID: wN9XbajVRX6L6izHz8qjgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29119830"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29119830"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:37:11 -0700
X-CSE-ConnectionGUID: e2tgUy5FSFqfuLcdwjsRJw==
X-CSE-MsgGUID: TpB8612dSN2hIy3MW6tVFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79931179"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 21 Oct 2024 06:37:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6B5F24FD; Mon, 21 Oct 2024 16:37:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v3 4/5] platform/x86: intel_scu_ipc: Convert to check for errors first
Date: Mon, 21 Oct 2024 16:34:32 +0300
Message-ID: <20241021133705.2933464-5-andriy.shevchenko@linux.intel.com>
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

Convert to use usual pattern, i.e. check for errors first. This makes
code less indented and easier to read after all.

Tested-by: Ferry Toth <fntoth@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 37 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 9829d4145c58..2d25a0a86143 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -317,12 +317,15 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 	}
 
 	err = intel_scu_ipc_check_status(scu);
-	if (!err) { /* Read rbuf */
-		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
-			wbuf[nc] = ipc_data_readl(scu, offset);
-		memcpy(data, wbuf, count);
-	}
-	return err;
+	if (err)
+		return err;
+
+	/* Read rbuf */
+	for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
+		wbuf[nc] = ipc_data_readl(scu, offset);
+	memcpy(data, wbuf, count);
+
+	return 0;
 }
 
 /**
@@ -480,7 +483,7 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
 {
 	size_t outbuflen = DIV_ROUND_UP(outlen, sizeof(u32));
 	size_t inbuflen = DIV_ROUND_UP(inlen, sizeof(u32));
-	u32 cmdval, inbuf[4] = {};
+	u32 cmdval, inbuf[4] = {}, outbuf[4] = {};
 	int i, err;
 
 	if (inbuflen > 4 || outbuflen > 4)
@@ -499,19 +502,17 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
 	cmdval = (size << 16) | (sub << 12) | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
-
-	if (!err) {
-		u32 outbuf[4] = {};
-
-		for (i = 0; i < outbuflen; i++)
-			outbuf[i] = ipc_data_readl(scu, 4 * i);
-
-		memcpy(out, outbuf, outlen);
+	if (err) {
+		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
+		return err;
 	}
 
-	if (err)
-		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
-	return err;
+	for (i = 0; i < outbuflen; i++)
+		outbuf[i] = ipc_data_readl(scu, 4 * i);
+
+	memcpy(out, outbuf, outlen);
+
+	return 0;
 }
 EXPORT_SYMBOL(intel_scu_ipc_dev_command_with_size);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


