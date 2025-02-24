Return-Path: <linux-kernel+bounces-529683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A54AA429D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907C73B8BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C2264FB0;
	Mon, 24 Feb 2025 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1Pj0sNy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A915264A88
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418255; cv=none; b=hMGmfi04VONLNKEbKEGsUmMAwEeXaNsEu5E//8IOzivbx8SyNPjoiN1lyrY/FwWcEUq7Nc/xgIawDPmJqAcNtuzpFoZNhJOk7Y4/QVIwmwymIvYNfLq5DvouG7APXvYCw4+tDPVoRKD5tq3A8B1BaZZqtPT/BJtWEb8D7qsB0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418255; c=relaxed/simple;
	bh=VjWVgbSMDbC5Upj8LIuVG2O8EKByj2emxs/hZwqVhTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMIG40f4he874rm31r37J/4b+wtFqPxTTWx1+C3j4DdBBgAmjWf7r+Fne8L11M7ZUH7WgTsKYVuLsy8G/gE+oaD8jgIiW9dYc7swPM1POflZflPCr21Uzz/365i3K+oQPfi6TGRKHbUDuJWo2FSzfTdcNLid7aPG0wAIYwyquKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1Pj0sNy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740418254; x=1771954254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VjWVgbSMDbC5Upj8LIuVG2O8EKByj2emxs/hZwqVhTE=;
  b=f1Pj0sNyMEwN/I0ykmwkH0vDnXFp32Hc6lEdQEi7YeJ2U33x/nOyaje3
   G+e/i7tgi6Nh1rmX4CaEp1VjS/JsTWyFwTns350x9AOl9C5i1cYc4IROx
   I9C+FIjeRe9hqvr28us9SN08VNz6fEciKyfB8q5Atuqyh1otwkNw+moFj
   T2tvpJIlQpiAXa+xKBVlhy/bYecCvbCH3EWlzq9zGmXyxRF2hCBOXI/f0
   5IO7ESJtX1jNzHmHTe8DVTVN9ySYHmfuWYmg3HLvWhVa6JyGlSzP3hZbF
   PQ/WdyJncXhFxp6q2LtHS5yYa5LvLR2d6/apBjPtG6VuECGWQX3Gfot8A
   w==;
X-CSE-ConnectionGUID: aUrdpYXgQBqyZq9kHRH8Qg==
X-CSE-MsgGUID: hqdvkuiRQPa/o8dWHpOtGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="66555689"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="66555689"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:30:42 -0800
X-CSE-ConnectionGUID: iicq4B0LTPSTD7WHjfujsA==
X-CSE-MsgGUID: L1K7vNYgRxCa1AJwD0qBfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115875663"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 24 Feb 2025 09:30:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E6FF21D0; Mon, 24 Feb 2025 19:30:19 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v1 2/7] auxdisplay: lcd2s: Allocate memory for custom data in charlcd_alloc()
Date: Mon, 24 Feb 2025 19:27:39 +0200
Message-ID: <20250224173010.219024-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
In-Reply-To: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate memory for custom data in charlcd_alloc() instead of doing that
explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/lcd2s.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index d573d36e3067..d18735665706 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -301,20 +301,18 @@ static int lcd2s_i2c_probe(struct i2c_client *i2c)
 			I2C_FUNC_SMBUS_WRITE_BLOCK_DATA))
 		return -EIO;
 
-	lcd2s = devm_kzalloc(&i2c->dev, sizeof(*lcd2s), GFP_KERNEL);
-	if (!lcd2s)
-		return -ENOMEM;
-
 	/* Test, if the display is responding */
 	err = lcd2s_i2c_smbus_write_byte(i2c, LCD2S_CMD_DISPLAY_OFF);
 	if (err < 0)
 		return err;
 
-	lcd = charlcd_alloc(0);
+	lcd = charlcd_alloc(sizeof(*lcd2s));
 	if (!lcd)
 		return -ENOMEM;
 
-	lcd->drvdata = lcd2s;
+	lcd->ops = &lcd2s_ops;
+
+	lcd2s = lcd->drvdata;
 	lcd2s->i2c = i2c;
 	lcd2s->charlcd = lcd;
 
@@ -329,8 +327,6 @@ static int lcd2s_i2c_probe(struct i2c_client *i2c)
 	if (err)
 		goto fail1;
 
-	lcd->ops = &lcd2s_ops;
-
 	err = charlcd_register(lcd2s->charlcd);
 	if (err)
 		goto fail1;
-- 
2.45.1.3035.g276e886db78b


