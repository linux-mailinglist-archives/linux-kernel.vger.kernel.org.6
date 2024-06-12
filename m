Return-Path: <linux-kernel+bounces-211309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE037904FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1291C20E5C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278A16DECF;
	Wed, 12 Jun 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtidBo2h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B216DEDD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186285; cv=none; b=S+7WY+2sdSOGiB5yTcXeBMi7ryH6xFkISpImIC67ybbygIjM0fSUA548gT/eXaSMCOxhnzE+/C96e/AsrsjEFLGLwCH0Lm8jCpaEVN+OyNxX19xv2XEvNwzyMAhZsxTHPLgX5bkZGYZiPrU8vCtU4a8r411dXY2GqS3i7/+Va7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186285; c=relaxed/simple;
	bh=/dq33L+wCHqTV5HbyMXSc1U5hW5k39SLNeDQ1ubJZ3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lK2J/I2t3Q/gYXbt6n2euc71pny1LJOkylP4ZO+vPTIga3Hv2ZNc2ZZd+X086mIboAVApVBaC/C+J0vwrOm8obbQOn6nkcMsAy6fOEWczzT6dxq71cyRzS8SYqkwLb4ijt3hgIFeK+OK8/7tOob5AAH1fl0zP+hSj6Z9RGKDIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtidBo2h; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718186284; x=1749722284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/dq33L+wCHqTV5HbyMXSc1U5hW5k39SLNeDQ1ubJZ3w=;
  b=WtidBo2hvYB/V+fq1E7WnxbWqjaXDh2UJHd4zOhKs3wiRLe1dBjHf8ss
   oLW3YhjtPIKuonPmpeewuW/h2Mba1PqMbZIwghXKPAIyWeu/lvS12S1XX
   cwqCoXxhcyiab1KQgRhfRxPXzkpengT8PbWmFLynavXl5FQXhvK611w36
   MiaX79BYGb1NO9elcCDazrsSUlnhBzyzUCUmea9oRMpPtaEFXr4ix9EKC
   W4doE7lZEKAnlYUQoILh9FnBAsNYS4VPdPyCdImwOcJERHnlam6DTBmLO
   Ju9QiV865bevWajHJ5xqFJKP+adJu6v0VfuluB93u2eD0WofPcO/2XMn4
   Q==;
X-CSE-ConnectionGUID: eS0iyHuGQbOBhWe3qdRmHw==
X-CSE-MsgGUID: LG1w25ULQESDpd/YVKO2yA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="25516607"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="25516607"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:58:03 -0700
X-CSE-ConnectionGUID: z5/sL7oBSh25qe/D+7ptaw==
X-CSE-MsgGUID: shZa+CeIQYud3SXvNrfj4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="70545970"
Received: from unknown (HELO localhost) ([10.245.247.204])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:58:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] mfd: intel-lpss: Add Intel Arrow Lake-H LPSS PCI IDs
Date: Wed, 12 Jun 2024 12:57:55 +0300
Message-Id: <20240612095755.18137-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Intel Arrow Lake-H PCI IDs.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 1362b3f64ade..0eb6a98ed0fc 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -424,6 +424,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x5ac4), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x5ac6), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x5aee), (kernel_ulong_t)&bxt_uart_info },
+	/* ARL-H */
+	{ PCI_VDEVICE(INTEL, 0x7725), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7726), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7727), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7730), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7746), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7750), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7751), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7752), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7778), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7779), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x777a), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x777b), (kernel_ulong_t)&bxt_i2c_info },
 	/* RPL-S */
 	{ PCI_VDEVICE(INTEL, 0x7a28), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x7a29), (kernel_ulong_t)&bxt_uart_info },
-- 
2.39.2


