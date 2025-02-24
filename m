Return-Path: <linux-kernel+bounces-529680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31ECA429D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B34B3B7C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C047264A81;
	Mon, 24 Feb 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROJ70+h4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC30263F5B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418233; cv=none; b=MXo6CNFGR5WFKG8z1AetylWeU5ebEADFVDPtktZ3Sj1sl1qsj5cYqluigRTTZK6jEUOGKiOGu7xG0Ko31v8n5/RDQuZ4qKNqWuSooHXHdeayhxdBXbKyZYWRtCzTvVpoQbVqRhUaKhUAYqG/5WM3uEUYCmU2mh7XiFE/4kNb9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418233; c=relaxed/simple;
	bh=ja3yxX6RihsXvHqYTvrLS3Ry5RDySEQXHVAQ/lDoxXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OO0sdEKYdx9p97xWQHncIbKSkk9WztarmBjLgOpBETDVFnhrWxVBd8tqiVKMPtlOFhwIZWSU0PCqInADk9+HAXLvt909uKudYhiZZq17GSuEKgHAMZ7af0yOV4sDfy0RFKwvvEH8eVBMiMGD+CfunBUEGqaMrDken40F+KlDLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROJ70+h4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740418232; x=1771954232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ja3yxX6RihsXvHqYTvrLS3Ry5RDySEQXHVAQ/lDoxXE=;
  b=ROJ70+h4RPmUP7k8/G6HUW4/pFx7ssEgDrLUN12UEVipXL1CxGmirR51
   sMGh3hgzbTnAVWwha9yKQnFLinrmcCrjxalQG4qbypom5/4xqzs3hf9NS
   5einuuYED/IRnELLmaPoGTXkfjHWlOiQimVUXbFe6z8qIOdRLBJhAPjBz
   zVKLLVqbeWJQMSo8R1S9J4NwxAhi5ytpTTBmWCjj3bAbtzl1Z93yN4qWV
   2kfr904UUCwn4TOpJKcroZJm+/7Ik2HXJEKwEadH4vbY79bConztbNf/V
   Ioc97KhRxle/L4jS1rY3ubPTHA5SFAEW2e30yAiTVNu3Kr+4m7LBVppLg
   g==;
X-CSE-ConnectionGUID: JCb0Co4zTAiQHAjVRD+8KQ==
X-CSE-MsgGUID: V7TnRK8/T3aZg2HDy0vSNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41307958"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41307958"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:30:26 -0800
X-CSE-ConnectionGUID: gWWZSQJyQ5Kj7FWyOI6bbw==
X-CSE-MsgGUID: qEGQn4ySQvSPAHM42qZjzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117027896"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 24 Feb 2025 09:30:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 37082700; Mon, 24 Feb 2025 19:30:20 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v1 7/7] auxdisplay: hd44780: Rename hd to hdc in hd44780_common_alloc()
Date: Mon, 24 Feb 2025 19:27:44 +0200
Message-ID: <20250224173010.219024-8-andriy.shevchenko@linux.intel.com>
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

The hd44780_common_alloc() uses hd for local variable while
the respective header uses hdc, rename to make it consistent
and avoid potential confuse with the drivers that use both
for different reasons. No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/hd44780_common.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index fb340d18fcad..1792fe2a4460 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -353,17 +353,17 @@ EXPORT_SYMBOL_GPL(hd44780_common_redefine_char);
 
 struct charlcd *hd44780_common_alloc(void)
 {
-	struct hd44780_common *hd;
+	struct hd44780_common *hdc;
 	struct charlcd *lcd;
 
-	lcd = charlcd_alloc(sizeof(*hd));
+	lcd = charlcd_alloc(sizeof(*hdc));
 	if (!lcd)
 		return NULL;
 
-	hd = lcd->drvdata;
-	hd->ifwidth = 8;
-	hd->bwidth = DEFAULT_LCD_BWIDTH;
-	hd->hwidth = DEFAULT_LCD_HWIDTH;
+	hdc = lcd->drvdata;
+	hdc->ifwidth = 8;
+	hdc->bwidth = DEFAULT_LCD_BWIDTH;
+	hdc->hwidth = DEFAULT_LCD_HWIDTH;
 	return lcd;
 }
 EXPORT_SYMBOL_GPL(hd44780_common_alloc);
-- 
2.45.1.3035.g276e886db78b


