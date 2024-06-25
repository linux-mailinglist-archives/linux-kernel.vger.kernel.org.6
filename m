Return-Path: <linux-kernel+bounces-228500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261EA9160BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37A72847AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313721494C7;
	Tue, 25 Jun 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAxBKiq9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012E1494A0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303113; cv=none; b=guhfyZ4W37i5WImK8lrQ7tietHKfEjRrypiqyCWK98BUegjy56fvHUKSc/YAp3ScNGt8EpVsxesj9vKB6YHNHT0PpNwuY7wRjrl6HoUzVBL6hY+/5a5ff8xYbFWDgzBjG2x0KGDBA215xNz2mGwUb8LOUr2PxNf+Hp+N8o32V4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303113; c=relaxed/simple;
	bh=daxe32aE67oVuOh6zKBhL8mvnX6zPKZ6M93+wHKfLcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nkm6/x0DNskKf5rPXh2IHQjFFOrlSUdOrX18zQPfpsb4PIGOGFTSjLcs82sF5u52JPVYyrLYqQVHsYT8hOgVHMcP4OmkB3+6P52JJGwTShrCwIuWGJiyJnEfX3i1pK9CugOOpT6lEMW1RWvYFLBC81N3qZBQRmy96+jhiKKX30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAxBKiq9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719303112; x=1750839112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=daxe32aE67oVuOh6zKBhL8mvnX6zPKZ6M93+wHKfLcQ=;
  b=PAxBKiq9/Q24XS3VPf5yQXpuDHY4btnPQi3XWgPq1hjkkkYkyIfdTE4M
   cB3gRKgkKdpHLu/Y467yus9lU1TPVOx11DRHhqeswBY4zhM1tUTKyAMk+
   /y644PxJ5X6JtiYyJ0akGxUgUZh7YPaW087gcVamHI260Ayn5JKEjop6w
   2If9sqSHMYucrVF0vOhx/AytyGTsX0Y4/60FBOpVvVIuP7bPwvVt3S1zl
   e+55FWKx9eqob/ApEylL/aHbAi5lvFY8buXUTl+9daw2gOEEVo//RoSeU
   ficLN2ZveLg0Kue9GgeZ48PqvfACxvyNuiQitjPQX7L1qlAT2xsdbdmlB
   w==;
X-CSE-ConnectionGUID: ulrsd1I2SjSgPYhjoajghw==
X-CSE-MsgGUID: mPCH/r8lTJuA1bihhyWnWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12232507"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="12232507"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:11:52 -0700
X-CSE-ConnectionGUID: YCPGnEtVQciQVTViGhkBrA==
X-CSE-MsgGUID: Q5yqqKxgQvW1EYN2+D/UnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47944910"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2024 01:11:50 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v4 4/5] mei: vsc: Enhance SPI transfer of IVSC ROM
Date: Tue, 25 Jun 2024 16:10:46 +0800
Message-Id: <20240625081047.4178494-5-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625081047.4178494-1-wentong.wu@intel.com>
References: <20240625081047.4178494-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before downloading firmware, a command response is required to
identify the silicon. However, when downloading IVSC firmware,
reading data from the SPI transfers with the IVSC ROM is not
necessary. Therefore, the rx buffer of SPI transfer command is
determined based on the specific request of the caller.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 876330474444..1618cca9a731 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -331,7 +331,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 		return ret;
 	}
 
-	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
+	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, ibuf ? tp->rx_buf : NULL, len);
 	if (ret)
 		return ret;
 
-- 
2.34.1


