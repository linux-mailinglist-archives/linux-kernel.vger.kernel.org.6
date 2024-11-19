Return-Path: <linux-kernel+bounces-414147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B81D9D23BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE642829B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C031C3F0E;
	Tue, 19 Nov 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFh5Xjb8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E471C1F3A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013035; cv=none; b=ECQ2rNgvcwwl0tNykIiJ/NOi6hYw+MouBkMi+f2GY3Fr0y7kffJXyeYuPkq7RCDJ15Y+eEyVBqPPG63x0mn9PVhztgd2CzqarkesqVOv51TIR4DR0SV4TAbLXx29o7JL1v67JCruYnLd3lNKhk4i2/R+e8LYYTFddNykXvSR+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013035; c=relaxed/simple;
	bh=0eB57OXktMTVfWwJ2tKKtqLAr1e19V1PNE8AWBCJze4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUuPQ4yTCNAtdT0LPVUelHhMPf9AMoFUziykbVGvi90dlyfbWuwZjiCHIugm7CM5xZ5iIWJ0+eQ15NzEL+r8Lp67R3TXMG9cVhObYQS9ZC+D7kxvJLnFgWbXMdMpHHd9gObu8Xku6ecI9guF5SApl5e14W3jq+8+q7HlF7S69w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFh5Xjb8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732013034; x=1763549034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0eB57OXktMTVfWwJ2tKKtqLAr1e19V1PNE8AWBCJze4=;
  b=NFh5Xjb8pP/atux8PmvKFF5wxNcpnifIH8Hs3SXbcP0mkZByuqStkP2R
   n7F98m/KUY2t0Xe2oGtXbC0TrQkJqjGeW107+aDlTXLHw1hOoXMqFyxHC
   rutq3yiiJkRrp9CxDWrvN6FQurQTmrV79hS8uMKLszbUZbLkXGwaW4pN8
   135GW3p+IwJf0pbUvgV2CWHiqqeF7P0+51QjORQC0aS/ifwfAwbJLroEF
   GJFFmVimO/0H/XA+MQ+ChREAQYUxJ1Gq7hBvC3ISIhAVR1rBM1kPqmb1I
   FV5HwXQeMos6WNkwPrlosQTzStVbwMkwaSAU1l6o0Uw+ud0dpt1tNMqF8
   A==;
X-CSE-ConnectionGUID: Nc876bcURba4luN3Yu0hkw==
X-CSE-MsgGUID: E+EclADSSTKgNZgbo6vftA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="35913983"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="35913983"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 02:43:50 -0800
X-CSE-ConnectionGUID: pTISQvk0Q8ihZRtZvFmJQw==
X-CSE-MsgGUID: TmFPKcjcS26r4iwzou9Z1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89925596"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 19 Nov 2024 02:43:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 78915251; Tue, 19 Nov 2024 12:43:45 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] genirq: Reuse irq_thread_fn() for forced thread case
Date: Tue, 19 Nov 2024 12:42:35 +0200
Message-ID: <20241119104339.2112455-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241119104339.2112455-1-andriy.shevchenko@linux.intel.com>
References: <20241119104339.2112455-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The irq_forced_thread_fn() uses the same action callback
as the non-forced variant but with different locking decorations.
Reuse irq_thread_fn() here to make that clear.

bloat-o-meter statistics on x86_64 (GCC-13, clang-18 shows no difference):

  Function                          old     new   delta
  irq_forced_thread_fn              118      55     -63
  Total: Before=13845, After=13782, chg -0.46%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/manage.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 310fbeed4d7a..2d9993f86fde 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1213,11 +1213,7 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 	local_bh_disable();
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_disable();
-	ret = action->thread_fn(action->irq, action->dev_id);
-	if (ret == IRQ_HANDLED)
-		atomic_inc(&desc->threads_handled);
-
-	irq_finalize_oneshot(desc, action);
+	ret = irq_thread_fn(desc, action);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_enable();
 	local_bh_enable();
-- 
2.43.0.rc1.1336.g36b5255a03ac


