Return-Path: <linux-kernel+bounces-349408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8EC98F57D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1391C2180F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B71ABEAC;
	Thu,  3 Oct 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keU7xXlv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148E1AAE2D;
	Thu,  3 Oct 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977425; cv=none; b=JBceo3lwYljd4S70AWWWZa1xniXvqKIyMza1lHHvUvJ07ay6YaJ30TWUyx8CZvdmhRtjSkkGH85u+Un1iSCF479in5TrPi0xyVFlWywr6yWE6SSpk2UCt3EIyGS9lOD76cerG7vqLrqmOjUpTrqoIoQ6KFNrY8gxQecPwbj8XHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977425; c=relaxed/simple;
	bh=j5C+wV8o7xDlVdCIwvLduo0gXkkzc8nwnFr1kOxnNR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpumBujd20lTdqRw7f+r9Owmd4w1WkBgxd1COFihyBdJ7Fc7ZIn0j2BbvdN+l7Ry2an2wklMbL1n26BRQ/RRSS7HEk9zrnQWZ085nRFyAWYW6H4SGFAYXKKPBa0Q8K6qVESF6Qylon8l9XbpVJp/YHxHNo+ZehQb+dNQGxqR8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=keU7xXlv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727977424; x=1759513424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j5C+wV8o7xDlVdCIwvLduo0gXkkzc8nwnFr1kOxnNR8=;
  b=keU7xXlv6ymiDWseLVuLs0hxnxR86ydOF3cRhB/73D/VtD2pMdlpk7r6
   osPJln9w6hXIOa6sGGUM1UxLBjW5Dg69gnr7u1PIuQT7BmEXrgOkdtYTA
   5KIHaWndqrunFoc7fb5BGX63RWuFi4dfyeJmWoVHtAK0B/J08ww54n+iP
   1nV5h8mBxy0yBEHgHWE8cGVySWOI9w2+9DxyH43mAiWxQ3XwIK330C6QF
   GLDlJCeVjBZ03NePrbFQ7wj5nwnwXq65v/RUV4TnICVyw6b4R2QyqstBv
   5+uJFa72sX2Aa7Ba91XZl6LdohPTDAw8csZR/nfNSur6QbejA5kNgHaJ6
   Q==;
X-CSE-ConnectionGUID: TliylAcqQMyXaNdkLj0tvQ==
X-CSE-MsgGUID: GpNvwQEfTlydpbFMvJlXFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="49714622"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="49714622"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 10:43:41 -0700
X-CSE-ConnectionGUID: 0WbymxU2RRSjeLBmm5JsKg==
X-CSE-MsgGUID: R/O/8tVdQAy5YID+WLAu8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="79396010"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 03 Oct 2024 10:43:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AE6B93E3; Thu, 03 Oct 2024 20:43:37 +0300 (EEST)
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
Subject: [PATCH v1 4/4] mfd: intel_soc_pmic_bxtwc: Fix IRQ domain names duplication
Date: Thu,  3 Oct 2024 20:32:04 +0300
Message-ID: <20241003174252.1190628-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241003174252.1190628-2-andriy.shevchenko@linux.intel.com>
References: <20241003174252.1190628-2-andriy.shevchenko@linux.intel.com>
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


