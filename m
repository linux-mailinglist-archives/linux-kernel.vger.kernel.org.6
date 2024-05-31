Return-Path: <linux-kernel+bounces-196973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A098D647E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397D51F2833E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088A20B0F;
	Fri, 31 May 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSr0u95u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D21C680
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165567; cv=none; b=PntumWuY3koS67iq2FLeOHQt/ubwQoWg5/Gc8nBTgM8x4Qnh0jSqL7ua//6Wmt1Huia5GPF7Hwvl6bkmIGZuh45zoDFGLC+12pZ8KkuQ1/mdekfmf71EQd9hZzTT8QS6rHkeDStyEoiAIG8ApBwcoPJbklkSJUCluP0S/LSCftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165567; c=relaxed/simple;
	bh=+/+goGZXvVD0mX4k0BYGMzVPiKaylBwPwrokDA9Mr3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ak8uchAYjURug0PNYkhe/9u8FogjVli48UzCmwbfftB/g5Z1qxy8NpaFhytdIz/pcSC9CM5JQks3zAcp0bTmQZjyLcM/1n9/UeDD20gb3KzizgliKOek5apddWtei+Ae/rFgD23fFwKv92GvJxoLxY2vI0KM2KUZgErJ26rCvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSr0u95u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717165565; x=1748701565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+/+goGZXvVD0mX4k0BYGMzVPiKaylBwPwrokDA9Mr3g=;
  b=RSr0u95uM4wMYu0Le11otDPCl2L42hjKi6WMlg75AQo8tfnmv+vLk1Ph
   CMHuaBCzkSgAoLmvRzgAniqzzUwv5IAQ4AmLm8RiQK3xCdG/FLuLEvT0K
   04jV3Kz27EaYLCVib+/AwvvRkuTMcatsesF8GolV/qVSYBd2P0JkIvbXG
   CpqR6c+zQVOlKzagPzukPgFu+QPElsvqcr7XSMzH+UcW5xaUCRiD/dMO7
   s0+z+O+eE8JOzTCN+hmVfjDFcdIf+1LnqqefyP0EAWW67Oc3rpSTNT8kS
   ifXe23iHARN6gSM1UUBus92Zmj7PBtqrPfUPkPBNQ2hWSnHG6S72ESNUc
   g==;
X-CSE-ConnectionGUID: dlsjfkx/Q26eJdOxdNkDqQ==
X-CSE-MsgGUID: cOvUZK0dTZuwyAWLyqgWkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24374054"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24374054"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:25:14 -0700
X-CSE-ConnectionGUID: MWZ9398qTM+u+LB9qkvqzA==
X-CSE-MsgGUID: 1gn44HJZRvy3EqQHZDxUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="40731195"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:25:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] mfd: intel-lpss: Rename SPI intel_lpss_platform_info structs
Date: Fri, 31 May 2024 17:25:05 +0300
Message-Id: <20240531142505.1888-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver has intel_lpss_platform_info structs for I2C, SPI, and UART.
The I2C and UART structs are named with "i2c" and "uart" in the variable
name, whereas SPI ones do not mention "spi".

Rename the SPI related info structs to include "spi" in their names for
consistency and to make it obvious in the device ID list what kind of
device the line relates to.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 162 +++++++++++++++++------------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index c36a101df7be..1362b3f64ade 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -103,7 +103,7 @@ static const struct software_node spt_spi_node = {
 	.properties = spt_spi_properties,
 };
 
-static const struct intel_lpss_platform_info spt_info = {
+static const struct intel_lpss_platform_info spt_spi_info = {
 	.clk_rate = 120000000,
 	.swnode = &spt_spi_node,
 };
@@ -148,7 +148,7 @@ static const struct software_node bxt_spi_node = {
 	.properties = bxt_spi_properties,
 };
 
-static const struct intel_lpss_platform_info bxt_info = {
+static const struct intel_lpss_platform_info bxt_spi_info = {
 	.clk_rate = 100000000,
 	.swnode = &bxt_spi_node,
 };
@@ -216,7 +216,7 @@ static const struct software_node cnl_spi_node = {
 	.properties = cnl_spi_properties,
 };
 
-static const struct intel_lpss_platform_info cnl_info = {
+static const struct intel_lpss_platform_info cnl_spi_info = {
 	.clk_rate = 120000000,
 	.swnode = &cnl_spi_node,
 };
@@ -240,7 +240,7 @@ static const struct software_node tgl_spi_node = {
 	.properties = tgl_spi_properties,
 };
 
-static const struct intel_lpss_platform_info tgl_info = {
+static const struct intel_lpss_platform_info tgl_spi_info = {
 	.clk_rate = 100000000,
 	.swnode = &tgl_spi_node,
 };
@@ -249,8 +249,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* CML-LP */
 	{ PCI_VDEVICE(INTEL, 0x02a8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x02a9), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x02aa), (kernel_ulong_t)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x02ab), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x02aa), (kernel_ulong_t)&cnl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x02ab), (kernel_ulong_t)&cnl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x02c5), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x02c6), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x02c7), (kernel_ulong_t)&spt_uart_info },
@@ -258,18 +258,18 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x02e9), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x02ea), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x02eb), (kernel_ulong_t)&cnl_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x02fb), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x02fb), (kernel_ulong_t)&cnl_spi_info },
 	/* CML-H */
 	{ PCI_VDEVICE(INTEL, 0x06a8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x06a9), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x06aa), (kernel_ulong_t)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x06ab), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x06aa), (kernel_ulong_t)&cnl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x06ab), (kernel_ulong_t)&cnl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x06c7), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x06e8), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x06e9), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x06ea), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x06eb), (kernel_ulong_t)&cnl_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x06fb), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x06fb), (kernel_ulong_t)&cnl_spi_info },
 	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0aac), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x0aae), (kernel_ulong_t)&bxt_i2c_info },
@@ -282,9 +282,9 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0abc), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x0abe), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x0ac0), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x0ac2), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x0ac4), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x0ac6), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x0ac2), (kernel_ulong_t)&bxt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x0ac4), (kernel_ulong_t)&bxt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x0ac6), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x0aee), (kernel_ulong_t)&bxt_uart_info },
 	/* BXT B-Step */
 	{ PCI_VDEVICE(INTEL, 0x1aac), (kernel_ulong_t)&bxt_i2c_info },
@@ -298,9 +298,9 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x1abc), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x1abe), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x1ac0), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x1ac2), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x1ac4), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x1ac6), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x1ac2), (kernel_ulong_t)&bxt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x1ac4), (kernel_ulong_t)&bxt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x1ac6), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x1aee), (kernel_ulong_t)&bxt_uart_info },
 	/* EBG */
 	{ PCI_VDEVICE(INTEL, 0x1bad), (kernel_ulong_t)&bxt_uart_info },
@@ -317,15 +317,15 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x31bc), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x31be), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x31c0), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x31c2), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x31c4), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x31c6), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x31c2), (kernel_ulong_t)&bxt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x31c4), (kernel_ulong_t)&bxt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x31c6), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x31ee), (kernel_ulong_t)&bxt_uart_info },
 	/* ICL-LP */
 	{ PCI_VDEVICE(INTEL, 0x34a8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x34a9), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x34aa), (kernel_ulong_t)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x34ab), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x34aa), (kernel_ulong_t)&cnl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x34ab), (kernel_ulong_t)&cnl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x34c5), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x34c6), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x34c7), (kernel_ulong_t)&spt_uart_info },
@@ -333,15 +333,15 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x34e9), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x34ea), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x34eb), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x34fb), (kernel_ulong_t)&cnl_spi_info },
 	/* ICL-N */
 	{ PCI_VDEVICE(INTEL, 0x38a8), (kernel_ulong_t)&spt_uart_info },
 	/* TGL-H */
 	{ PCI_VDEVICE(INTEL, 0x43a7), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x43a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x43a9), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x43aa), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x43ab), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x43aa), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x43ab), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x43ad), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x43ae), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x43d8), (kernel_ulong_t)&bxt_i2c_info },
@@ -350,14 +350,14 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x43e9), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x43ea), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x43eb), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x43fb), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x43fd), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x43fb), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x43fd), (kernel_ulong_t)&tgl_spi_info },
 	/* EHL */
 	{ PCI_VDEVICE(INTEL, 0x4b28), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x4b29), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x4b2a), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x4b2b), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x4b37), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x4b2a), (kernel_ulong_t)&bxt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x4b2b), (kernel_ulong_t)&bxt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x4b37), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x4b44), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4b45), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4b4b), (kernel_ulong_t)&ehl_i2c_info },
@@ -370,8 +370,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* JSL */
 	{ PCI_VDEVICE(INTEL, 0x4da8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x4da9), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x4daa), (kernel_ulong_t)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x4dab), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x4daa), (kernel_ulong_t)&cnl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x4dab), (kernel_ulong_t)&cnl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x4dc5), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4dc6), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4dc7), (kernel_ulong_t)&spt_uart_info },
@@ -379,12 +379,12 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4de9), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4dea), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4deb), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x4dfb), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x4dfb), (kernel_ulong_t)&cnl_spi_info },
 	/* ADL-P */
 	{ PCI_VDEVICE(INTEL, 0x51a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x51a9), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x51aa), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x51ab), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x51aa), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x51ab), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x51c5), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51c6), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51c7), (kernel_ulong_t)&bxt_uart_info },
@@ -394,12 +394,12 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x51e9), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51ea), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51eb), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x51fb), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x51fb), (kernel_ulong_t)&tgl_spi_info },
 	/* ADL-M */
 	{ PCI_VDEVICE(INTEL, 0x54a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x54a9), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x54aa), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x54ab), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x54aa), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x54ab), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x54c5), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x54c6), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x54c7), (kernel_ulong_t)&bxt_uart_info },
@@ -407,7 +407,7 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x54e9), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x54ea), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x54eb), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x54fb), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x54fb), (kernel_ulong_t)&tgl_spi_info },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5aac), (kernel_ulong_t)&apl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x5aae), (kernel_ulong_t)&apl_i2c_info },
@@ -420,46 +420,46 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x5abc), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x5abe), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x5ac0), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x5ac2), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x5ac4), (kernel_ulong_t)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x5ac6), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x5ac2), (kernel_ulong_t)&bxt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x5ac4), (kernel_ulong_t)&bxt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x5ac6), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x5aee), (kernel_ulong_t)&bxt_uart_info },
 	/* RPL-S */
 	{ PCI_VDEVICE(INTEL, 0x7a28), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x7a29), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x7a2a), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x7a2b), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7a2a), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7a2b), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x7a4c), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7a4d), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7a4e), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7a4f), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7a5c), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x7a79), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x7a7b), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7a79), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7a7b), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x7a7c), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7a7d), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7a7e), (kernel_ulong_t)&bxt_uart_info },
 	/* ADL-S */
 	{ PCI_VDEVICE(INTEL, 0x7aa8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa9), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x7aaa), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x7aab), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7aaa), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7aab), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x7acc), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7acd), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7ace), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7acf), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7adc), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x7af9), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x7afb), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7af9), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7afb), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x7afc), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7afd), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7afe), (kernel_ulong_t)&bxt_uart_info },
 	/* MTL-P */
 	{ PCI_VDEVICE(INTEL, 0x7e25), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x7e26), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x7e27), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x7e30), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x7e46), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7e27), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7e30), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7e46), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x7e50), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7e51), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7e52), (kernel_ulong_t)&bxt_uart_info },
@@ -470,22 +470,22 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* MTP-S */
 	{ PCI_VDEVICE(INTEL, 0x7f28), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x7f29), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x7f2a), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x7f2b), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f2a), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7f2b), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x7f4c), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7f4d), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7f4e), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7f4f), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7f5c), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x7f5d), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x7f5e), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0x7f5f), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5e), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7f5f), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x7f7a), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x7f7b), (kernel_ulong_t)&bxt_i2c_info },
 	/* LKF */
 	{ PCI_VDEVICE(INTEL, 0x98a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x98a9), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x98aa), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x98aa), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x98c5), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x98c6), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x98c7), (kernel_ulong_t)&bxt_uart_info },
@@ -496,8 +496,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* SPT-LP */
 	{ PCI_VDEVICE(INTEL, 0x9d27), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x9d28), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x9d29), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x9d2a), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x9d29), (kernel_ulong_t)&spt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x9d2a), (kernel_ulong_t)&spt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x9d60), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9d61), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9d62), (kernel_ulong_t)&spt_i2c_info },
@@ -508,8 +508,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* CNL-LP */
 	{ PCI_VDEVICE(INTEL, 0x9da8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x9da9), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x9daa), (kernel_ulong_t)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x9dab), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x9daa), (kernel_ulong_t)&cnl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x9dab), (kernel_ulong_t)&cnl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x9dc5), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9dc6), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9dc7), (kernel_ulong_t)&spt_uart_info },
@@ -517,12 +517,12 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x9de9), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9dea), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9deb), (kernel_ulong_t)&cnl_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x9dfb), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x9dfb), (kernel_ulong_t)&cnl_spi_info },
 	/* TGL-LP */
 	{ PCI_VDEVICE(INTEL, 0xa0a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa0a9), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0xa0aa), (kernel_ulong_t)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa0ab), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa0aa), (kernel_ulong_t)&cnl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xa0ab), (kernel_ulong_t)&cnl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0xa0c5), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa0c6), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa0c7), (kernel_ulong_t)&bxt_uart_info },
@@ -532,20 +532,20 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa0db), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa0dc), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa0dd), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0xa0de), (kernel_ulong_t)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa0df), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa0de), (kernel_ulong_t)&cnl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xa0df), (kernel_ulong_t)&cnl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0xa0e8), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa0e9), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa0ea), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa0eb), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0xa0fb), (kernel_ulong_t)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa0fd), (kernel_ulong_t)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa0fe), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa0fb), (kernel_ulong_t)&cnl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xa0fd), (kernel_ulong_t)&cnl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xa0fe), (kernel_ulong_t)&cnl_spi_info },
 	/* SPT-H */
 	{ PCI_VDEVICE(INTEL, 0xa127), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa128), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0xa129), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0xa12a), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa129), (kernel_ulong_t)&spt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xa12a), (kernel_ulong_t)&spt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0xa160), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa161), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa162), (kernel_ulong_t)&spt_i2c_info },
@@ -553,8 +553,8 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* KBL-H */
 	{ PCI_VDEVICE(INTEL, 0xa2a7), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa2a8), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0xa2a9), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0xa2aa), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa2a9), (kernel_ulong_t)&spt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xa2aa), (kernel_ulong_t)&spt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0xa2e0), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa2e1), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa2e2), (kernel_ulong_t)&spt_i2c_info },
@@ -563,19 +563,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* CNL-H */
 	{ PCI_VDEVICE(INTEL, 0xa328), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa329), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0xa32a), (kernel_ulong_t)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa32b), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa32a), (kernel_ulong_t)&cnl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xa32b), (kernel_ulong_t)&cnl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0xa347), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa368), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa369), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&cnl_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&cnl_spi_info },
 	/* CML-V */
 	{ PCI_VDEVICE(INTEL, 0xa3a7), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a8), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0xa3a9), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0xa3aa), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa3a9), (kernel_ulong_t)&spt_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xa3aa), (kernel_ulong_t)&spt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0xa3e0), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa3e1), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa3e2), (kernel_ulong_t)&spt_i2c_info },
@@ -584,9 +584,9 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* LNL-M */
 	{ PCI_VDEVICE(INTEL, 0xa825), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa826), (kernel_ulong_t)&bxt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0xa827), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0xa830), (kernel_ulong_t)&tgl_info },
-	{ PCI_VDEVICE(INTEL, 0xa846), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0xa827), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xa830), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xa846), (kernel_ulong_t)&tgl_spi_info },
 	{ PCI_VDEVICE(INTEL, 0xa850), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa851), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa852), (kernel_ulong_t)&bxt_uart_info },
-- 
2.39.2


