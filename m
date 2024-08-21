Return-Path: <linux-kernel+bounces-295852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A41995A213
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63161F22D50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD41BAEFF;
	Wed, 21 Aug 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KttKlOsj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867B1B2ECB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255329; cv=none; b=bzt/mpHPKKayvonWXEwRdaV01+ZNKYIBNPrfnPjblPTPwqY6TyzeFdpTvlJ1eFMzbag5XuyWYLDNKeh7lKHx+F6hn7kfsvZrITsNMiFjHu1XsTwCeexGXwawXr37E9cnTv22sog/XyOzbcuLXAt2yPCpxpMTbEY/OMzavq0KFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255329; c=relaxed/simple;
	bh=nwX4DXZJkTTdl8FlMgTMpzQVu7Jzqhb9Qf7KQTNZCKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eq3bz0GFwn8l3YWa9LWFhWNKM+He5X48O9mdhc1ef5nIyxNBYzJq4vPRA0rkvmHK20HTMX/ohfPzFJ21pMIk+XoFiexAwpBRDtNk+m4yS+kOhEK+SGbHlphW44ao5pQ/cVzk7vcKQ+a8S1V/DX8jzUsbcP6lApw9EdxP31qyUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KttKlOsj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724255329; x=1755791329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nwX4DXZJkTTdl8FlMgTMpzQVu7Jzqhb9Qf7KQTNZCKE=;
  b=KttKlOsjZXOfXBiT1s+8CKKUHTUdNH50vQA3amkLrcQaMI4skDfyqq2V
   hhNlffJEPGRxyWpd45dl+YF/bZJBO9sFi0wjF8npfW6n/bfr1Us5D24L4
   FEPY6aJ39IIGUlvnZiV7wCuTEyjp7lhZOzR1gCNinbbdb8PBVlO4vOl55
   YTte8BCir+V4NrhCQSyV2ndxLrIakarYVo599vQmnwV7ZXE2w0eEi9WwN
   qeh4rWz9Ip/VRj8ZnpPDFqHnqkpwSRbUsjnsJaqLaRsvzqysS8y+jcTvC
   iFuJUgkTi5rsXMoLv2wqWZNIY1vHm6JKZM1LN6FEldC8vgh/smWZ84MEM
   w==;
X-CSE-ConnectionGUID: RO0Tk5zgRaaaNKajLTQ3og==
X-CSE-MsgGUID: 8NnoD3BuT66oJkxLRMDr1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26376299"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26376299"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:48:47 -0700
X-CSE-ConnectionGUID: DoWIQNj8TVOBYBQbmIMBFA==
X-CSE-MsgGUID: dhHqAWvZRnWnLQiBjkmZKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66080328"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2024 08:48:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3B71F72C; Wed, 21 Aug 2024 18:48:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] driver core: Use 2-argument strscpy()
Date: Wed, 21 Aug 2024 18:48:23 +0300
Message-ID: <20240821154839.604259-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
References: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andy.shevchenko@gmail.com>

Use 2-argument strscpy(), which is not only shorter but also provides
an additional check that destination buffer is an array.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1e5d7f9bc4f4..2a31dc0ed21b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4867,7 +4867,7 @@ set_dev_info(const struct device *dev, struct dev_printk_info *dev_info)
 	else
 		return;
 
-	strscpy(dev_info->subsystem, subsys, sizeof(dev_info->subsystem));
+	strscpy(dev_info->subsystem, subsys);
 
 	/*
 	 * Add device identifier DEVICE=:
-- 
2.43.0.rc1.1336.g36b5255a03ac


