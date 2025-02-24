Return-Path: <linux-kernel+bounces-529682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C87BEA429D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F453B8B93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A9264F9F;
	Mon, 24 Feb 2025 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIfIjk8u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BBA25A64C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418254; cv=none; b=khHFqR+FORxx45aXxCCT7RTA2szYPQSYhw1TCCzrec/Ep+gJAVt3ay2QsjzWF45A0iKq/rkEZqlE/ub95nVcUTCkX7jQxK8zREXU1rBOmw0i8K/WTszAksiQL4cBWMHg0XIsOH3yj97gdKFRN1T6C7nk5HA6OEPK4kipxP69T0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418254; c=relaxed/simple;
	bh=VWVe1DTsFOp9n4K2h1AjDcSe/CR3C+t9B44JSaza3b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlZbB1Ha2ezqiNNKEtsOyPByYxyNeuEPR5pIKM+3DwhlaDYNV3oJAILYJSuypJFh2uKSf8UIHTp0F/9IxK7Jn/SslGhJHaRiwkYz9DRFw7gtCpMiN5UBN1W/9rPUB/TQT8wHH3yatS64agFNijMnQHDfv2jsxBoTXno18sR4vSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CIfIjk8u; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740418254; x=1771954254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VWVe1DTsFOp9n4K2h1AjDcSe/CR3C+t9B44JSaza3b4=;
  b=CIfIjk8uk8x9yYP3LvkxaCAMiz1Rsw+34TXv8uUP2zSG6txBoCTND1UB
   UOHSfQeelZxQWywTzwBnU9lMlckAJXkJ6sHkLAIeu/SuPWMWRTcgg601G
   Ykesc67Sx6kRLsyU1d1LpY5yg5FwiUdV9c/DOuV2ImNsye7silmjBTG2L
   VQZvjoWmYmvYIuu9jsCIBMcCg+CxbyMfR6GgVsm+NT8aJ8IRLUjWkvXWr
   SGIh582ORydCdUObyu1fMIEi/XraqPlV1z8WuAmzOsN445v6d5H2W82Yj
   sT6gs1ZaYivQ10/5CC197Oma4RNI93GVAk2qxqjYCOlnKf+362dWbOf7M
   g==;
X-CSE-ConnectionGUID: Sz9jI9bFROC7VIj5814qhw==
X-CSE-MsgGUID: RGBoKxIvQrqUBNOuMAJXqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="66555685"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="66555685"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:30:42 -0800
X-CSE-ConnectionGUID: 90FlX4sqS6eO5PaaSEzluQ==
X-CSE-MsgGUID: LKxnNpBLSBS0sXPUgZZ3Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115875662"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 24 Feb 2025 09:30:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0C0DA496; Mon, 24 Feb 2025 19:30:20 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v1 4/7] auxdisplay: hd44780: Make use of hd44780_common_free()
Date: Mon, 24 Feb 2025 19:27:41 +0200
Message-ID: <20250224173010.219024-5-andriy.shevchenko@linux.intel.com>
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

Use the symmetrical API to free the common resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/hd44780.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 1d67fe324341..ef38cb7bf13d 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -315,7 +315,7 @@ static int hd44780_probe(struct platform_device *pdev)
 fail2:
 	charlcd_free(lcd);
 fail1:
-	kfree(hdc);
+	hd44780_common_free(hdc);
 	return ret;
 }
 
@@ -326,8 +326,7 @@ static void hd44780_remove(struct platform_device *pdev)
 
 	charlcd_unregister(lcd);
 	kfree(hdc->hd44780);
-	kfree(lcd->drvdata);
-
+	hd44780_common_free(hdc);
 	charlcd_free(lcd);
 }
 
-- 
2.45.1.3035.g276e886db78b


