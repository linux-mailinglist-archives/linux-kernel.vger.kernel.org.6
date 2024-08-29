Return-Path: <linux-kernel+bounces-306578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E789640BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDF3285C06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0694718A924;
	Thu, 29 Aug 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IA87SeXe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E0156875
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925470; cv=none; b=ocyNZrMldZ2VFgnHrxTkIkeAIVRBAO7EXmq92WCgwHPQu4i3nGW+aGg23I0Rbok3tPxYsm6dCMZLceTiaVC/9dDY6OgJ+RPASQkciWvDKEd4LoGSM85CiFXH2Pc7W6Es5rbEFGrheo7fmob1eaqHZ59HP0abGDqOmzAs2sMfXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925470; c=relaxed/simple;
	bh=u4c05mH2Q5HvvDAEeclkfosT9EVX2sxn4Dng+XIUAio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dR0gyRXCFiK5B9EiEmj02Xt6h/j8jSZlq7arfmmyPmwZdPY4lGWlXRjoQOu7hn2FO2OR6u27NqEaWCay1Ibg9nQmlcogGQnqDc5ehwmWaxSLYIhBH6e7MmGwyV8wXvz0ZgEY51jhGPAF9ii4wEwysG0BuImJ0O299nhI6FTpq0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IA87SeXe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724925469; x=1756461469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u4c05mH2Q5HvvDAEeclkfosT9EVX2sxn4Dng+XIUAio=;
  b=IA87SeXeMxFoXJsyXcDoU+RDT4wfDYT8FL+bzzN+tQzO9Qq13Zn9OLmf
   9HpwDNDuzfAQ6VoiXjWMFwQiv0LmyRs6NiEv9aNyn3oiAfp5URQ/WN7UQ
   sXy2vcMIl6NLq2+vcTn72oJsMO/Zseah19P1yFkhWlgEIgvVoqRZTJGNC
   V0kKv9hlhXnFK0DxIP3ZZJRPeTf6ht0/s6bcXfHn1QhRVyh7tWNRAiCdm
   hItzYgCxW83eqW90njMdVAsGCCllkNCOitQQjVcffjPtSoKb8ZYvzPPED
   bNdKjEtbKjVxDy8WJW/l+IN5YXK/yRbEFyd13SPu+vGhutqr3+i0/5NRo
   A==;
X-CSE-ConnectionGUID: CzzwDs4HS3acL7rhhA1wsg==
X-CSE-MsgGUID: 9WBBKwuyRd2lGWbT5lfLyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23391555"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23391555"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:57:48 -0700
X-CSE-ConnectionGUID: bXxvcu9LTUOot/cbdgiyeA==
X-CSE-MsgGUID: mbXV2pW6Qam7C4mSLlQthQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63155081"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:57:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] mfd: intel-lpss: Add Intel Panther Lake LPSS PCI IDs
Date: Thu, 29 Aug 2024 12:57:19 +0300
Message-Id: <20240829095719.1557-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829095719.1557-1-ilpo.jarvinen@linux.intel.com>
References: <20240829095719.1557-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Intel Panther Lake-H/P PCI IDs.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 0eb6a98ed0fc..1d8cdc4d5819 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -607,6 +607,32 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa879), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa87a), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa87b), (kernel_ulong_t)&ehl_i2c_info },
+	/* PTL-H */
+	{ PCI_VDEVICE(INTEL, 0xe325), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe326), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe327), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe330), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe346), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe350), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe351), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe352), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe378), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe379), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe37a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe37b), (kernel_ulong_t)&ehl_i2c_info },
+	/* PTL-P */
+	{ PCI_VDEVICE(INTEL, 0xe425), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe426), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe427), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe430), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe446), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe450), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe451), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe452), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe478), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe479), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe47a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe47b), (kernel_ulong_t)&ehl_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);
-- 
2.39.2


