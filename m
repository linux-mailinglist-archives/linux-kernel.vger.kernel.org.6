Return-Path: <linux-kernel+bounces-529681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E9A429D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D9017CD0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E202641F6;
	Mon, 24 Feb 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSeeF1cv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E8264A6E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418250; cv=none; b=XzAYy31JAeZpzhKzgjv38F7EwXHIPF5Ai2OSUO8CwcMh6Hu6TQFdqB0CwV58mJDpMLZDyitrimUXq38i6kHPxXeeG6V5M3/27dzyUAiCSx9nJR//cSErwijE4iKtX9embvETHRn+nxPQS6kbhWMA+bK9r2lPYUYqYNuK+ZDdyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418250; c=relaxed/simple;
	bh=7xUv+TO8IbMC37opWagll0H8eevWflJ9+aQI8RFk9ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJsh77r99yNZmaSuN0HxDCzFTAzpFwhmFZMHP4DRKtX0IXSHdiS3vTGY0S1ACL6Dw49Pc/BiU55GXzdXzdYaPiTH0bekhRZMJn+TznfC7VhnEw0wNt0HsjmSCCL6BeNMj3PK17ToqiBt25Bvh6f3n/BIMCVQYtCmaCnIHz1LVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSeeF1cv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740418250; x=1771954250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7xUv+TO8IbMC37opWagll0H8eevWflJ9+aQI8RFk9ek=;
  b=LSeeF1cvV3vrsvZAyZ1BW3gXNjEta8r+peIsHE+3J9N8X2TnEDQTBL3/
   pG5N4h0sLK61xP56yMPhQqksYcD+8nt7yOMb9YHaPWhvGjUBYLbLmp/gJ
   M8YiWqlB7i+vd6SDF8tqJ0D/hs7/fhyDu6sYYuVxcG2zBiQZiU2ahKEFL
   LhQbksDorexGk5H8jjXWy06BwbMPAEjk5Msfx9aF1bC6SNNi3B+wd+wd6
   m9qvrvmbqMXOIFRP1USHX8gMgDO6Ua+EAnP5nc8tT7p+k2rvieWj5gFb6
   BJFa36Jz4EngwBs3y8FHGwmvl/MiZgD+SJs4kAUY2eRKx5TweGEVWKc01
   A==;
X-CSE-ConnectionGUID: QXbQ8Q3GQv+IZ6P9ZUp7ig==
X-CSE-MsgGUID: WNTbK9gNQLeaPxkP4RQMTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="66555681"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="66555681"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:30:42 -0800
X-CSE-ConnectionGUID: OhmlKL0zSoeFyw+z018vgw==
X-CSE-MsgGUID: ih40IuXyT+WEY0M8EDioFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115875659"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 24 Feb 2025 09:30:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 033A8495; Mon, 24 Feb 2025 19:30:19 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v1 3/7] auxdisplay: hd44780: Introduce hd44780_common_free()
Date: Mon, 24 Feb 2025 19:27:40 +0200
Message-ID: <20250224173010.219024-4-andriy.shevchenko@linux.intel.com>
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

Introduce hd44780_common_free() for symmetrical operation
to hd44780_common_alloc(). It will allow to modify the both
in the future without touching the users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/hd44780_common.c | 6 ++++++
 drivers/auxdisplay/hd44780_common.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 4ef87c3118c0..3f8a496ccb8e 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -366,5 +366,11 @@ struct hd44780_common *hd44780_common_alloc(void)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_alloc);
 
+void hd44780_common_free(struct hd44780_common *hd)
+{
+	kfree(hd);
+}
+EXPORT_SYMBOL_GPL(hd44780_common_free);
+
 MODULE_DESCRIPTION("Common functions for HD44780 (and compatibles) LCD displays");
 MODULE_LICENSE("GPL");
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index a16aa8c29c99..fe1386e3cf79 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -30,4 +30,6 @@ int hd44780_common_blink(struct charlcd *lcd, enum charlcd_onoff on);
 int hd44780_common_fontsize(struct charlcd *lcd, enum charlcd_fontsize size);
 int hd44780_common_lines(struct charlcd *lcd, enum charlcd_lines lines);
 int hd44780_common_redefine_char(struct charlcd *lcd, char *esc);
+
 struct hd44780_common *hd44780_common_alloc(void);
+void hd44780_common_free(struct hd44780_common *hd);
-- 
2.45.1.3035.g276e886db78b


