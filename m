Return-Path: <linux-kernel+bounces-558355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8B1A5E4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC35178E18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9971F0996;
	Wed, 12 Mar 2025 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/5kjOdJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3D1E8346
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808968; cv=none; b=bRiQ6h7nJtotRwD1ncsahY2sPymujHueYhSfW+YadhLMDAVRfjbBC58LLBGiCXJ2QNLb1RV8Q1U+UnYdw77g7VRMDSWQC4cxhZhbtFEYvHYy+Xi+HygFyLRm3ERk9OvMToTTloi0WK9ezQI+J2QU54yguKQz50kz0JRV5b4HObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808968; c=relaxed/simple;
	bh=Ti1igSpQFrj2iRLbg8INkCYbJeQOHwWHZWFI3mHVIgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QErDlblTArmfPD9PbFjmw6BTRLFc2p8HfzFqKhvrWtmvZPd8Q8coKLpqbAAaZaBlBAshOFvXdlA39nZaOmPoyYVz1wKYadUXBVUjM9foznah4DBAt5+6W00aCfJHMzojL6T24qdY5OJ3+Dhz1sstBJxjb2JyP2eAoaHWZnG563o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/5kjOdJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741808967; x=1773344967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ti1igSpQFrj2iRLbg8INkCYbJeQOHwWHZWFI3mHVIgY=;
  b=k/5kjOdJzgwGpjoofTm4bep3pB4FWagRVD57xZHBryoyxjcFTwym5KF0
   nSQCGSDtOftJodhQ7+F2JYvPm83ksfWQFiiXnOwTTDy2QwVa5gA1b9qLp
   s/PU8H0gutcO/uw3xiraPqeLT+wQ3pMkEz3izO/80MX35cyLKAAhTPd37
   RV26roqqveG543Mg4q51ZZAIB9sjCLEOPd7iXpO2UvUFnFdJ0pX40+/fY
   GnsVx1bLycw+pOFwMvbT+qg5u+QiiyqchRnrOE48EVDqCS4VvLvXzlon0
   OLe5du96LhikMGSGCO0p6UfUcDQ2PD4DM+Ae5yGJjdAkoIGiYBQuIbuHB
   w==;
X-CSE-ConnectionGUID: +ymJxGmNSa2QKAPKHwDtgQ==
X-CSE-MsgGUID: yD+D4/eYTluTmMJzU0cwrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53114874"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="53114874"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:49:26 -0700
X-CSE-ConnectionGUID: LKEHGIaeSgu21tNL5P53PA==
X-CSE-MsgGUID: unt58CmrR2y0cpRRlrqAKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="151554119"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 12 Mar 2025 12:49:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EACF61F2; Wed, 12 Mar 2025 21:49:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] clkdev: Mark some functions with __printf() attribute
Date: Wed, 12 Mar 2025 21:49:21 +0200
Message-ID: <20250312194921.103004-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the functions are using printf() type of format, and
compiler is not happy about them as is:

drivers/clk/clkdev.c:185:17: error: function ‘vclkdev_alloc’ might be a candidate for  gnu_printf’ format attribute [-Werror=suggest-attribute=format]
drivers/clk/clkdev.c:224:9: error: function ‘vclkdev_create’ might be a candidate for  gnu_printf’ format attribute [-Werror=suggest-attribute=format]
drivers/clk/clkdev.c:314:9: error: function ‘__clk_register_clkdev’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors by adding __printf() attributes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/clk/clkdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 2f83fb97c6fb..e0bede6350e1 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -153,7 +153,7 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };
 
-static struct clk_lookup * __ref
+static __printf(3, 0) struct clk_lookup * __ref
 vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
 {
@@ -215,7 +215,7 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	return &cla->cl;
 }
 
-static struct clk_lookup *
+static __printf(3, 0) struct clk_lookup *
 vclkdev_create(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
 {
@@ -303,9 +303,8 @@ void clkdev_drop(struct clk_lookup *cl)
 }
 EXPORT_SYMBOL(clkdev_drop);
 
-static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
-						const char *con_id,
-						const char *dev_id, ...)
+static __printf(3, 4) struct clk_lookup *
+__clk_register_clkdev(struct clk_hw *hw, const char *con_id, const char *dev_id, ...)
 {
 	struct clk_lookup *cl;
 	va_list ap;
-- 
2.47.2


