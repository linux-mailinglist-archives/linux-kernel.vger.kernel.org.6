Return-Path: <linux-kernel+bounces-175941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E14C8C27A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F47A1C211D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C14B17165B;
	Fri, 10 May 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ7AYfwW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754D17109E;
	Fri, 10 May 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354809; cv=none; b=SlkrscntGegJHlEuaQolJVjnqwDrCObko2FHA0W79g6la2GatO9iF+AV172vdB/9ROyS417Wkuh0vBLv0S2IEPjGw9rfR+5nsrhpmDi5H2pZrYHMYMWN5YUsr+YaWciHEFPA/ZvtNJsOk8p/cinlVnq3SiGRPzK2PlxlE+lLOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354809; c=relaxed/simple;
	bh=WZ4TGuN2dW7cNy4EbwRGnB4/IoAEcv+5igcpsXySV48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3PNZjQcGu7ED5tkKH8DCLD3gA9+F+rrQz+NyRTDGsDPh+LT2j6l/nmK0z+ratKjPzIMHPfsXIeSuA0La346uJIGK7HOlSrAumV8IRDJB1Frp/8aJDslXnDBcJ7+mt+xifAY7Vu/G684DswuIzlzobSPl62wzIwUrOANm+IDeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ7AYfwW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715354809; x=1746890809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WZ4TGuN2dW7cNy4EbwRGnB4/IoAEcv+5igcpsXySV48=;
  b=fZ7AYfwWK3TVftVQrfys77GJpWfMjD2cvVi69J8Q2n/ooBr7WGBnlxFZ
   kNxkFUt0sxn1qfEnjEJHqR0n9Dz8GUnIyqxpsrhQKDQQY4bJPrQvJeCI1
   5fQB6qsLOnphAVGJd6jYejWmaqTxhNMKq7SMjLWrFvPd1EfRepM+M6+ij
   omPbg9xDtI1z41sbPndhuJ6MlNVf6oX0FKu5p2E8DQtXGQ5xUXCkDRSqN
   yvDiVFPfitRvdGZQ5vGlQxvknatsfglCHsmPpb6eiy3bx2Am+/lfas5GH
   Eue6WA10QLDGUME0ehh6JLB+lxqfZtW2S1pfJlzbM3oCeddYqR630vPEd
   g==;
X-CSE-ConnectionGUID: AwWSGOIBS5eTk4LgV/5YTA==
X-CSE-MsgGUID: bmlaT52yRBysECpAh3zkrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="33853116"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="33853116"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 08:26:48 -0700
X-CSE-ConnectionGUID: /fs8JJapR6CHsb9uccIbLA==
X-CSE-MsgGUID: ojovpLzbRRSLkx7ziSC9pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29655034"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 10 May 2024 08:26:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3B4441AC; Fri, 10 May 2024 18:26:43 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] usb: fotg210: Add missing kernel doc description
Date: Fri, 10 May 2024 18:26:22 +0300
Message-ID: <20240510152641.2421298-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc validator is not happy:

  warning: Function parameter or struct member 'fotg' not described in 'fotg210_vbus'

Add missing description.

Fixes: 3e679bde529e ("usb: fotg210-udc: Implement VBUS session")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo (LKP, Greg)
 drivers/usb/fotg210/fotg210-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index 958fc40eae86..0655afe7f977 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -95,6 +95,7 @@ static int fotg210_gemini_init(struct fotg210 *fotg, struct resource *res,
 
 /**
  * fotg210_vbus() - Called by gadget driver to enable/disable VBUS
+ * @fotg: pointer to a private fotg210 object
  * @enable: true to enable VBUS, false to disable VBUS
  */
 void fotg210_vbus(struct fotg210 *fotg, bool enable)
-- 
2.43.0.rc1.1336.g36b5255a03ac


