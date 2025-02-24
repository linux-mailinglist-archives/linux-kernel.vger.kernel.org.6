Return-Path: <linux-kernel+bounces-529051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2490A41F36
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661F51884F51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145D7221F06;
	Mon, 24 Feb 2025 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwyodJ2J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12937163
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400593; cv=none; b=K/sOlTb4fnsQBF13JpENP/0bDce11dKObZDHBJFGuxN3KRtnGt58iA7YN6minZrlQ3xAKKd8hATyW7S8R1Y2oT/ZgRU+fm9aC22Amx3CWkonIJxrXYIkkzICFyyPwqdnKAscaCTjhMVI7nHEmPAASDzbsj8j+5szbW6xf6QxexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400593; c=relaxed/simple;
	bh=45m5CcrmPmDRLEmWHA/uRHsFxb+4TpHMivpW02LUGlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFA0W1l9oqKBsTCZ3EC2Stb3vvZw9riqWpaKLNGzwkaUJcOEo+u8TFyAMw+9LiOoOS3oCPi07YvHThcFkqnMwYhqEHMAmE2pVlQYQD1S96w2JBjXUIijdBoASMI2fOUYWXIvpnRMmwDGrqqpgtfaE4EymKDLLtXUBRmAhNINW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwyodJ2J; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740400592; x=1771936592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=45m5CcrmPmDRLEmWHA/uRHsFxb+4TpHMivpW02LUGlg=;
  b=QwyodJ2JckXqYujql+cfV5VblC6+V1lMLvmUSkj9RmUHCZGhBbP3JWHL
   Wv/g/19ypd3Ad0qFbMAqj7eAnoNMBxD8SzwmDSOi/TWQAQdzcYFBIHZNr
   buVBH5Q594bcTiZcyoH7b1aaKp3kg4Z2Ag04VlKY51Nt8BUi7pWWUfiAC
   xdpkgs4LmAFMI7H31pAzynE2l9Ij+al+gWmY57KV2QIecjaWbyXPy4y9s
   LUcRWNajJwFBvzqDTSrKhpfesu1eJ/gdh0QHf1qFCb7DcXLbVwre65Au/
   +H+3PFfa+LP5+fl+xjYFK3PnFv8cBagb0MfzdBwjaEk7XeiWXKrHDiW7z
   Q==;
X-CSE-ConnectionGUID: ylRJk0HmQ3OAYCccK7NbwA==
X-CSE-MsgGUID: YR7NEc6bQc2URFcfp0+iIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41064600"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41064600"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:36:31 -0800
X-CSE-ConnectionGUID: uvEXzI2GTDOyAcpcyOsOvA==
X-CSE-MsgGUID: agIKGxyHTqybssXeTMPRpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120665721"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2025 04:36:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 53BCC19E; Mon, 24 Feb 2025 14:36:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v1 1/1] auxdisplay: panel: Fix an API misuse in panel.c
Date: Mon, 24 Feb 2025 14:36:25 +0200
Message-ID: <20250224123625.3816062-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable allocated by charlcd_alloc() should be released
by charlcd_free(). The following patch changed kfree() to
charlcd_free() to fix an API misuse.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/panel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 098d490c1cf9..4da142692d55 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1664,7 +1664,7 @@ static void panel_attach(struct parport *port)
 	if (lcd.enabled)
 		charlcd_unregister(lcd.charlcd);
 err_unreg_device:
-	kfree(lcd.charlcd);
+	charlcd_free(lcd.charlcd);
 	lcd.charlcd = NULL;
 	parport_unregister_device(pprt);
 	pprt = NULL;
@@ -1692,7 +1692,7 @@ static void panel_detach(struct parport *port)
 		charlcd_unregister(lcd.charlcd);
 		lcd.initialized = false;
 		kfree(lcd.charlcd->drvdata);
-		kfree(lcd.charlcd);
+		charlcd_free(lcd.charlcd);
 		lcd.charlcd = NULL;
 	}
 
-- 
2.45.1.3035.g276e886db78b


