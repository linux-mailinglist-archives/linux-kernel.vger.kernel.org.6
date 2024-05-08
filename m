Return-Path: <linux-kernel+bounces-173725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F328C049F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7948B25A28
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08212F5B1;
	Wed,  8 May 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fu4H3P1e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F586AD6
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194158; cv=none; b=hi/vDmLLbIw36xMygpBkB65STKs1hAWiEs/JL87MF8g5UHcn35Ju9DTyZhtMaD4ctA1eew1CWTiUOIvBzJRv0zysib3Q/r/4hn6HE3qUzWPWtMC5QQP7BHFkcJs1w6ry8SNTkle+zmGnXLhNpTQhOoZ1hsAywmME3kbVxtDviOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194158; c=relaxed/simple;
	bh=U+HVZQS+64kb8Zey97r2FujuAXEKiql5arjTI8jUYZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcqEnXXWT3PvTQdnixU5J/pLLuDixxbp9Z4yfwGi7j18lkoyQA6rIo7pVEWBvOJyZn4Vv+yEFYbh6/uFZrGeYc38QUncBMycnSK+WwHj8njqKjiRqh0KPB/KLGFlKhmvLNQfxbDCs+Z6CqsEitxmijQhacElem4hwtL98LafXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fu4H3P1e; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194158; x=1746730158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U+HVZQS+64kb8Zey97r2FujuAXEKiql5arjTI8jUYZk=;
  b=Fu4H3P1el2merNEOoZQZT196wUOKGG1XUDyIumYihXLA7OIBiE6kO+M+
   KsAJdecj1GPyf1VwrfnLA+OGugRlGIJEq83JZW2LoVjvnI3AIloeWyVyX
   UNvCsTsXHChI9DAhah/67S4tRjUZmim5EDUZ+Z01DSGVhqzmBGHqc7pDm
   hFO3i+kqIo8crZq9Yrj6xxgp+xjHmFRnFJY3JouHrShwnElB6d9AHzdEv
   yVPpa9CwjFP5Hu0v4SVIf6GemcfkhyIx6ANOGa7XfWLXRP+cJu4e5siGc
   PRVW0FAJsb2igskwbxYNQJ3U/o4NK3W7LmuFtepsKTh6/y8tqUqdkXU4p
   A==;
X-CSE-ConnectionGUID: 8dB7YwzkSOmuYubkWV7YiA==
X-CSE-MsgGUID: 8/dwVLJNRjqRcRa7DeAlsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="36457766"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="36457766"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:15 -0700
X-CSE-ConnectionGUID: P/iSq1CrTZyyxZLN9I9h/Q==
X-CSE-MsgGUID: G+VL2WWnTRav6fCPfXLIFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28957213"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 08 May 2024 11:49:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8A386656; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 02/10] eeprom: digsy_mtc: Fix 93xx46 driver probe failure
Date: Wed,  8 May 2024 21:46:55 +0300
Message-ID: <20240508184905.2102633-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com>
References: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The update to support other (bigger) types of EEPROMs broke
the driver loading due to removal of the default size.

Fix this by adding the respective (new) flag to the platform data.

Fixes: 14374fbb3f06 ("misc: eeprom_93xx46: Add new 93c56 and 93c66 compatible strings")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/digsy_mtc_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index f1f766b70965..4eddc5ba1af9 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -42,7 +42,7 @@ static void digsy_mtc_op_finish(void *p)
 }
 
 struct eeprom_93xx46_platform_data digsy_mtc_eeprom_data = {
-	.flags		= EE_ADDR8,
+	.flags		= EE_ADDR8 | EE_SIZE1K,
 	.prepare	= digsy_mtc_op_prepare,
 	.finish		= digsy_mtc_op_finish,
 };
-- 
2.43.0.rc1.1336.g36b5255a03ac


