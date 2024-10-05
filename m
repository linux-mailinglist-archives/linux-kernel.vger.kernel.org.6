Return-Path: <linux-kernel+bounces-352082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF239919EC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76561F2289B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B346816A930;
	Sat,  5 Oct 2024 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPtQuIvd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC6215F33A;
	Sat,  5 Oct 2024 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728156640; cv=none; b=huBM0E+bcpplVrqMTMs4bOdqHXv7aH/ce4VcU9i9HWeo69h3IcnoOAdEh/YEEXLrN0+gSQSTIZIMyTZDgpCc99SjKld5bu7AfflNzeRypOT0yjpHzS8xZIYOh/VfvzzgMYkvUeocuif/VRHtFyNZ8/lkDTevbEMWOfvYow/L0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728156640; c=relaxed/simple;
	bh=j5C+wV8o7xDlVdCIwvLduo0gXkkzc8nwnFr1kOxnNR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1GUzHxC/C0w946t4q4bMP0fcuoNwV6O14C9rIsCou9phxIdfpZNGxRhPti+WLmlusqFyPUV9AfwZXCXPfWc4ImsjbVAq6xsFRK/W9ZHT3X6mDq3LRArrqN9vUO4GO3EPbXYJmrFIrnO+/wF9zRbazquvOJdqfQXwDNnS/rHvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPtQuIvd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728156639; x=1759692639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j5C+wV8o7xDlVdCIwvLduo0gXkkzc8nwnFr1kOxnNR8=;
  b=mPtQuIvdKuhPUuIqvdWvV17CchzJ4rUdNP+8i9fyJyilFw8lwPmEqocU
   kiu4P0i7QDKgLVqmRHWRgCMvbsoCAmM0+E+jhDGJuVMcWHj+pTmVZciuF
   C5Fj6ZfpDXFS8djgWkYn6zdQAU1efymv10XWy8g6clUqCJ+hkbkkoBTVB
   8udl0kMLFZicGQUGfAjn72nQWJOJEDsCyxG0wyiK6Vaj9ykqpjzGiSOd4
   RyDN2GgAWmTbG9hCE0KOoPAacRX98TBtAfvaCall+k9+hvXiKn+ct+VZ7
   Xs/5EkV1HorZtzXRFqj84LAXTtiRR7GAV7YLIPBzceRb687tJuLHh4m4N
   Q==;
X-CSE-ConnectionGUID: 7boLnBFFRUCwifED0EP0gQ==
X-CSE-MsgGUID: UO9nwQzXSoWkbBLTLPk8KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="44879468"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="44879468"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 12:30:36 -0700
X-CSE-ConnectionGUID: 8zc6f3OQSq+ab6bjEWa+zQ==
X-CSE-MsgGUID: +PdO7DZwS/SeS/2WtotuVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="74861629"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 05 Oct 2024 12:30:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 107AC197; Sat, 05 Oct 2024 22:30:32 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 4/4] mfd: intel_soc_pmic_bxtwc: Fix IRQ domain names duplication
Date: Sat,  5 Oct 2024 22:27:07 +0300
Message-ID: <20241005193029.1929139-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241005193029.1929139-1-andriy.shevchenko@linux.intel.com>
References: <20241005193029.1929139-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For all of the devices regmap IRQ may try to created the folder
with the same name which is impossible and fails with:

  debugfs: File '\_SB.IPC1.PMIC' in directory 'domains' already present!

Add domain_suffix to all of the IRQ chips driver registers to solve
the issue.

Fixes: 39d047c0b1c8 ("mfd: add Intel Broxton Whiskey Cove PMIC driver")
Fixes: 957ae5098185 ("platform/x86: Add Whiskey Cove PMIC TMU support")
Fixes: 57129044f504 ("mfd: intel_soc_pmic_bxtwc: Use chained IRQs for second level IRQ chips")
Depends-on: dde286ee5770 ("regmap: Allow setting IRQ domain name suffix")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index fefbeb4164fd..b7204072e93e 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -148,6 +148,7 @@ static const struct regmap_irq_chip bxtwc_regmap_irq_chip = {
 
 static const struct regmap_irq_chip bxtwc_regmap_irq_chip_pwrbtn = {
 	.name = "bxtwc_irq_chip_pwrbtn",
+	.domain_suffix = "PWRBTN",
 	.status_base = BXTWC_PWRBTNIRQ,
 	.mask_base = BXTWC_MPWRBTNIRQ,
 	.irqs = bxtwc_regmap_irqs_pwrbtn,
@@ -157,6 +158,7 @@ static const struct regmap_irq_chip bxtwc_regmap_irq_chip_pwrbtn = {
 
 static const struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
 	.name = "bxtwc_irq_chip_tmu",
+	.domain_suffix = "TMU",
 	.status_base = BXTWC_TMUIRQ,
 	.mask_base = BXTWC_MTMUIRQ,
 	.irqs = bxtwc_regmap_irqs_tmu,
@@ -166,6 +168,7 @@ static const struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
 
 static const struct regmap_irq_chip bxtwc_regmap_irq_chip_bcu = {
 	.name = "bxtwc_irq_chip_bcu",
+	.domain_suffix = "BCU",
 	.status_base = BXTWC_BCUIRQ,
 	.mask_base = BXTWC_MBCUIRQ,
 	.irqs = bxtwc_regmap_irqs_bcu,
@@ -175,6 +178,7 @@ static const struct regmap_irq_chip bxtwc_regmap_irq_chip_bcu = {
 
 static const struct regmap_irq_chip bxtwc_regmap_irq_chip_adc = {
 	.name = "bxtwc_irq_chip_adc",
+	.domain_suffix = "ADC",
 	.status_base = BXTWC_ADCIRQ,
 	.mask_base = BXTWC_MADCIRQ,
 	.irqs = bxtwc_regmap_irqs_adc,
@@ -184,6 +188,7 @@ static const struct regmap_irq_chip bxtwc_regmap_irq_chip_adc = {
 
 static const struct regmap_irq_chip bxtwc_regmap_irq_chip_chgr = {
 	.name = "bxtwc_irq_chip_chgr",
+	.domain_suffix = "CHGR",
 	.status_base = BXTWC_CHGR0IRQ,
 	.mask_base = BXTWC_MCHGR0IRQ,
 	.irqs = bxtwc_regmap_irqs_chgr,
@@ -193,6 +198,7 @@ static const struct regmap_irq_chip bxtwc_regmap_irq_chip_chgr = {
 
 static const struct regmap_irq_chip bxtwc_regmap_irq_chip_crit = {
 	.name = "bxtwc_irq_chip_crit",
+	.domain_suffix = "CRIT",
 	.status_base = BXTWC_CRITIRQ,
 	.mask_base = BXTWC_MCRITIRQ,
 	.irqs = bxtwc_regmap_irqs_crit,
-- 
2.43.0.rc1.1336.g36b5255a03ac


