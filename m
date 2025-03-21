Return-Path: <linux-kernel+bounces-571862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE628A6C351
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3A63B3F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4245622FDEE;
	Fri, 21 Mar 2025 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PILuv2fR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BD1D54D1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585139; cv=none; b=Zb87znJ0KxV1SjEkhUvG0a6tUlDftHS3TolV4eW4ixkMzFwH8FoKhzAFlBlsNCFsYItTZwVWhIfY30gEUGCLlnsqNOueRlqN9BVAgdOdsCEjgmcwDe4ypfwZRrPKl22H+tDI8etjJdw/YcxdNzn14u03MN23623k06PmHRCn7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585139; c=relaxed/simple;
	bh=3IuvYQyG9EosyVBfW3oIksk9W/HDKCe373SOs77IIVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrWIbK5K02E5kk4o8D6M1yFF4sOauuR2ozg9h2TyQC9xfK4b3NLWZL3TPqb29nv3Tegv9P7Cdo43+ZPPqTaiTW6J9GTIb5w9NkKkwUIJ/XSAT9RmBR4HZrj5OMh2GR2wfdWc+zDzaehD5wEmjRdmUu6CweyS3sjsV/qu/SFb9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PILuv2fR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742585138; x=1774121138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3IuvYQyG9EosyVBfW3oIksk9W/HDKCe373SOs77IIVw=;
  b=PILuv2fRURGLTfWjnsVE7GbddLfCb8D2RW0iseVOrcMGJ7JkVb3UAB+g
   VH7/GlQGjmcWTLH7AFzt1riGdh4FetZgugMXHYCk2/wyeBE2oPqkH8mST
   L8jaPQoDCAjBW0p3H+oNbpdDdtpaqfHijOjI2cLr0HFKZnhr/krcEC5UP
   3oN0Ccm1wBMSV5aqWd3Gtj6kKhc0DsAreTBr7ajjKjsEy6bCAQypwut7K
   tvpLU8Q6sdKybGcd5/QVRFHhqRi2dqjxv7DOSySckfpXzd2zbyh/BgEzV
   Z4nwTLdRnEFgbps/iIWfXL4LK6BM3UQJqFTgXd4JyOZHeOYKiOgw7OX3r
   w==;
X-CSE-ConnectionGUID: pygh4GaAQBO3qqQMRkxRAQ==
X-CSE-MsgGUID: oxeN2sTaSaKUIru0Qpeg2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="47520358"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="47520358"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 12:25:30 -0700
X-CSE-ConnectionGUID: d62vawfxQ/iwqt0Ny/r06A==
X-CSE-MsgGUID: IAkKrnsEQFqqF5BqDDim2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123945194"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 12:25:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 909A014B; Fri, 21 Mar 2025 21:25:27 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] i3c: master: Drop duplicate check before calling OF APIs
Date: Fri, 21 Mar 2025 21:25:26 +0200
Message-ID: <20250321192527.457324-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OF APIs are usually NULL-aware and returns an error in case when
device node is not present or supported. We already have a check
for the returned value, no need to check for the parameter.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i3c/master.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d5dc4180afbc..1580e2630dfe 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2486,7 +2486,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	struct i2c_adapter *adap = i3c_master_to_i2c_adapter(master);
 	struct i2c_dev_desc *i2cdev;
 	struct i2c_dev_boardinfo *i2cboardinfo;
-	int ret, id = -ENODEV;
+	int ret, id;
 
 	adap->dev.parent = master->dev.parent;
 	adap->owner = master->dev.parent->driver->owner;
@@ -2497,9 +2497,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	adap->timeout = 1000;
 	adap->retries = 3;
 
-	if (master->dev.of_node)
-		id = of_alias_get_id(master->dev.of_node, "i2c");
-
+	id = of_alias_get_id(master->dev.of_node, "i2c");
 	if (id >= 0) {
 		adap->nr = id;
 		ret = i2c_add_numbered_adapter(adap);
-- 
2.47.2


