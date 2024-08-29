Return-Path: <linux-kernel+bounces-306577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48719640B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DDB1C220A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864BA18CC18;
	Thu, 29 Aug 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMbgP7Q2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0BB156875
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925460; cv=none; b=JJn/AfZkT6pGJ7u/183yzYAjy/Ob1OtWR/asZ6VtXK2SiGdm5CWrPqUReZabAc8AL8SqsEwemLj3YVl4sTVLGWqJj9gppjNZMPkH7Lch7qbLlV7uIDnawc0c39iAxU8klq9e0e5UBRoWfyszC4zZOe782I7CNC+8jE+dny+ZN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925460; c=relaxed/simple;
	bh=/dq33L+wCHqTV5HbyMXSc1U5hW5k39SLNeDQ1ubJZ3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axJ9vCbTJWfd8H8ax6IC/iotAxdfJS5yjmeUOVYgG2ccf4BFLudGHMoW8DK5b/s5W92j6mgyRsYP8uqJJYwqfU9hH0pQQ0Cnaho4LnEisIae6iR81E2x9MSXd3OzvxU99SIfc155OLbC/4VfiGB9rm2AiYDyEjAXCHZ3q11CehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMbgP7Q2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724925459; x=1756461459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/dq33L+wCHqTV5HbyMXSc1U5hW5k39SLNeDQ1ubJZ3w=;
  b=DMbgP7Q2n75S9V0zTwtgrRM/2geVr1rON/n4BjUpewqJ7A376JMHcH9N
   N1gfi/RCJ1l3LBWTRKT7qW4gxBhHk5kdDS8CSJ0lpT4XMICj8oy1Ksjiy
   yMFnDty1xK5cChnfLuKNr5ChmMOV5UjiVafhs/ikHpdCuY9Zhd+u4Jngv
   ePUappBhic6233vOuDY0PgPBugrahjAm1MHQPUO+zyw3cEOLmELc5A1Kz
   g35u9MNcGWNzPS1z67O86x+fy84sBJiPtQIuV44LgfpKt1niVdvS6Jftc
   QBFDXq1nWU8I7BMFourQHAexz5IXxXIMrZWLLeWXxc8R6kw9W1rAVBQud
   A==;
X-CSE-ConnectionGUID: m4sYRGLoTMipGFWJAYJ2kg==
X-CSE-MsgGUID: V32Y7SNvQru7q2YRmDkthg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23391544"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23391544"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:57:39 -0700
X-CSE-ConnectionGUID: ZlhQZduxTru90J03bv+SyA==
X-CSE-MsgGUID: 4UDDIkOiSI2o5Rf3PFgIGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63155069"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:57:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] mfd: intel-lpss: Add Intel Arrow Lake-H LPSS PCI IDs
Date: Thu, 29 Aug 2024 12:57:18 +0300
Message-Id: <20240829095719.1557-2-ilpo.jarvinen@linux.intel.com>
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


