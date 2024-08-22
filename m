Return-Path: <linux-kernel+bounces-297306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348FC95B5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635B0B20D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A81CB312;
	Thu, 22 Aug 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBa9NbrU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA71C9EAC;
	Thu, 22 Aug 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332050; cv=none; b=TA2qJVV67dkppo/vSDWvucs42s7ueSuHvC3jrhdLMe1Z15ybpZ87iGAQBjgSnk7KhNlSzmlJurCM7/6ayz6kU8XdhyphdJabgiStifp2K3FoZperD3WKh9lf4gEs+hEVnbwo8EERFvazDFXE49Nqsr1amNL6wSSRecrR1sjfZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332050; c=relaxed/simple;
	bh=OqnDzu9+ZUXGdtQdWMi+KA9baRD3epmipJVFFEG+fXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Icx270Ii3ljawauecoStbEoNzNlHRxYFKunpXouTpb4fYMSefBDL7AMaGj0npe8YJbSmmstQi/GIZeuD0yMXKlAI5gfv/N/d49X73Muf08SSivmPGdvym6FGH2Hnn5KG1/xst7QO4IGTSPMDjCiMAQkvk2xCw12Nm9l4A7s7iec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBa9NbrU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724332050; x=1755868050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OqnDzu9+ZUXGdtQdWMi+KA9baRD3epmipJVFFEG+fXg=;
  b=UBa9NbrUyN6UA4bh7dH9Q2Wc5QzXuIockut0b5OG7rmsW45/l7xqqVwd
   E9A/tP+44wYvE02FAfKlWFNivHBF+zkOv02YowxRj+Fo/xQYSFgTQ/4gS
   AZKjztmdwc4nekHAGn1Di1zVCEnyUieyPzPD0HBNFoTgMtBJp/qcAktsE
   9vZTxFKjMo1Z0+sWqPLFtoHa/8soeAtXUx1x/QjjkIy5zHnvoKPix+g8F
   EmpGD6ApGcZZlhPyP/66U43rxm77zNfQaKXXFGaLVHFW3bcJkjDYBOR6J
   clZsPG5RNSForLFmcsBNjs6rbXH4T78xJeEas/iQce22wp4a1fUIvL/H7
   g==;
X-CSE-ConnectionGUID: rVNG4oZSSbit29v76+UNYg==
X-CSE-MsgGUID: rMGNNms7QJS02SoenqxeBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22621716"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22621716"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:07:27 -0700
X-CSE-ConnectionGUID: 3G/r6TtETPSpG7yPi+/cLg==
X-CSE-MsgGUID: Nl++LU2QRnOGqCaGmbBKPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66363060"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 22 Aug 2024 06:07:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9C43D4D7; Thu, 22 Aug 2024 16:07:23 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v2 3/4] platform/x86: int3472: Use GPIO_LOOKUP() macro
Date: Thu, 22 Aug 2024 16:05:40 +0300
Message-ID: <20240822130722.1261891-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use GPIO_LOOKUP() macro which provides a compound literal
and can be used with dynamic data.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 29df19379464..a360901d03f0 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -69,11 +69,7 @@ static int skl_int3472_fill_gpiod_lookup(struct gpiod_lookup *table_entry,
 	if (!adev)
 		return -ENODEV;
 
-	table_entry->key = acpi_dev_name(adev);
-	table_entry->chip_hwnum = agpio->pin_table[0];
-	table_entry->con_id = func;
-	table_entry->idx = 0;
-	table_entry->flags = polarity;
+	*table_entry = GPIO_LOOKUP(acpi_dev_name(adev), agpio->pin_table[0], func, polarity);
 
 	return 0;
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac


