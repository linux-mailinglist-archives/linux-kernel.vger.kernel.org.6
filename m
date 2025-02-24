Return-Path: <linux-kernel+bounces-529684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F3AA429D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A570420912
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F4265624;
	Mon, 24 Feb 2025 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZZf6Em3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420A264A8B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418256; cv=none; b=XTAimS/M3YBvYq/QVwt+6nyrUCqxR32ghLklQ7/RKyrDdipGRHV0ZdPUjl6Q6UauYPCqMbqGRYNQe4ze2kIsaQI1jAKaUzCgbX90+Cdv0bHq2OAEbwYU9x1O4XfmZ6MhyllPt5SQuIIOrItzg5+SPLTEPsgkhv97pDJgglBF6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418256; c=relaxed/simple;
	bh=ZJx/N0qiFPNt2/WxJ1XGL0hASo9jQLxxQlpmZknVIfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaxKcpI7Qzzg7po23Ka/8pQioYjdU3KV49SEVrO0lEU+1efSBJr7N3eXxSHq6WUkOxxpjZRQB9w0qYJ8DEm/5GqfveYFbK7qo7p3DvqCNrbkBokrGJbNa3qGUxt343JmPStDdP6Ojbt3+H4X+7kG5nuLG9WzjF+9qm0lhHF03Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZZf6Em3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740418255; x=1771954255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZJx/N0qiFPNt2/WxJ1XGL0hASo9jQLxxQlpmZknVIfo=;
  b=OZZf6Em3X1pMWdKMfmR1U0qYsnbm8v7dNxgi4qlVGUiFrEsxtrMdAImk
   PVc61hgrnEhXmib2Jkb5SbICex4npYMvsor4QxWg64fo+RWRnXN2N9AKA
   c5OjLzMM/PZLGK9kB9CnwR7yUeLcPseGPXLeXke/ujlKfmrzvNENlTFy+
   kF42fECt8RyTFf5Fy10cKWnM/hyw1Rh/Ved8tHPrgRsnDnwF8po3KeYXF
   BCwb9om6VpPgTrmxHvnV+RXGqXAlYwvTZtqnHqueO3Ku5eAXDMyINk0wL
   QTMXNQ+KmFaNeIxZ3yT6WsH1vIsbADUx2WGv28jTbI60MLdSMDopLYXpr
   A==;
X-CSE-ConnectionGUID: hkAYOkAcQVawtvwrr/PEEQ==
X-CSE-MsgGUID: QHqBlrQiQ9u5ZwMoP/Blug==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="66555698"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="66555698"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:30:42 -0800
X-CSE-ConnectionGUID: hdFdTaLEQs2tgox0fUWZgQ==
X-CSE-MsgGUID: H9/CPlnOQeWZmRf9hF4TgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115875687"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 24 Feb 2025 09:30:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1942D4BB; Mon, 24 Feb 2025 19:30:20 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v1 5/7] auxdisplay: panel: Make use of hd44780_common_free()
Date: Mon, 24 Feb 2025 19:27:42 +0200
Message-ID: <20250224173010.219024-6-andriy.shevchenko@linux.intel.com>
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
 drivers/auxdisplay/panel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 4da142692d55..aa1d03fef22e 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -837,7 +837,7 @@ static void lcd_init(void)
 
 	charlcd = charlcd_alloc(0);
 	if (!charlcd) {
-		kfree(hdc);
+		hd44780_common_free(hdc);
 		return;
 	}
 
@@ -1691,7 +1691,7 @@ static void panel_detach(struct parport *port)
 	if (lcd.enabled) {
 		charlcd_unregister(lcd.charlcd);
 		lcd.initialized = false;
-		kfree(lcd.charlcd->drvdata);
+		hd44780_common_free(lcd.charlcd->drvdata);
 		charlcd_free(lcd.charlcd);
 		lcd.charlcd = NULL;
 	}
-- 
2.45.1.3035.g276e886db78b


