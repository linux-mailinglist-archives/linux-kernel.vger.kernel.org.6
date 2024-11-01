Return-Path: <linux-kernel+bounces-392592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F169B95F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE401F21D8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FD21C7B82;
	Fri,  1 Nov 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcWT8rA2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061071CA81
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480163; cv=none; b=b2q0XCAW0tgfTvkCeujfZhmQiNmiGyPyZAriTjeKkuoIwBcBEvLoLNP4IikfWr35z6PwJnuP6FlsD9bPmJympzwGUvYrjGtku6UCTp/0RfCOHa+xx8k3u+0JAw1FXAVYBSHMjkHA1d8F/Pxh9KAxDud9jyKl5Ft2JBq6ksxJ728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480163; c=relaxed/simple;
	bh=V68nU6WlWTRHXGvQvaBSwn/SHFJQQV2FAPBVTj9ADb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bwmf4rRC9G+JMjnCCRSJTa2KiEt3mJWJ2S38vNeoXe/7BZ0cbJvC00VX3N2NISfzCFPWpT7LpSuGb4iobghuD36GxB9AlgOMClxxBNHnTAdKlm37ba0pVS500T4KSp0IJYKh/TKCebaYkN9rlmG39Ss8UJLbiCul5ZvL8jmnbQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcWT8rA2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730480161; x=1762016161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V68nU6WlWTRHXGvQvaBSwn/SHFJQQV2FAPBVTj9ADb4=;
  b=PcWT8rA2cUl8s9UZ1mfbw/WTlysKi55pczjA+JhVlkUlW74LAlRj2awX
   1aGg7gcPttgRK3QVg/EBpEdLM1VNAYB669PL/EtNGq0HrcMbTjLtC+wqX
   eyE/tjNsJTG/jySpkHOARsRvO0xOHi3iPySl8luuEJ3pQpjiHRnO0YaKj
   VFCPfynfSXYbcmwLjd7+46gvSSjgqX5qG9NHPiO7EAMW/8UKU6CTiWCob
   zwNd1yP02VylTdSDGmAqToKev9iWoRt9d7JUVrgGh5vLkNCpZBk/z1yoB
   PdtY9Hr/FwsiFZWJYislaJ7aeHDt07z0oz4zwaKcgIEKGLgpwhG2SkRTF
   g==;
X-CSE-ConnectionGUID: 4YKCiQcXSGSLrku56symYg==
X-CSE-MsgGUID: 8FOdL6NITIKrFhqdC42jmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="30364190"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="30364190"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 09:56:00 -0700
X-CSE-ConnectionGUID: +hj1mBU1RKWR2Lp526lMWw==
X-CSE-MsgGUID: TR9pBxZTSNKhnAcuqo3Bcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="88140898"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 01 Nov 2024 09:55:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5E6B22D3; Fri, 01 Nov 2024 18:55:57 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regmap: irq: Set lockdep class for hierarchical IRQ domains
Date: Fri,  1 Nov 2024 18:55:53 +0200
Message-ID: <20241101165553.4055617-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep gives a false positive splat as it can't distinguish the lock
which is taken by different IRQ descriptors from different IRQ chips
that are organized in a way of a hierarchy:

   ======================================================
   WARNING: possible circular locking dependency detected
   6.12.0-rc5-next-20241101-00148-g9fabf8160b53 #562 Tainted: G        W
   ------------------------------------------------------
   modprobe/141 is trying to acquire lock:
   ffff899446947868 (intel_soc_pmic_bxtwc:502:(&bxtwc_regmap_config)->lock){+.+.}-{4:4}, at: regmap_update_bits_base+0x33/0x90

   but task is already holding lock:
   ffff899446947c68 (&d->lock){+.+.}-{4:4}, at: __setup_irq+0x682/0x790

   which lock already depends on the new lock.

   -> #3 (&d->lock){+.+.}-{4:4}:
   -> #2 (&desc->request_mutex){+.+.}-{4:4}:
   -> #1 (ipclock){+.+.}-{4:4}:
   -> #0 (intel_soc_pmic_bxtwc:502:(&bxtwc_regmap_config)->lock){+.+.}-{4:4}:

   Chain exists of:
     intel_soc_pmic_bxtwc:502:(&bxtwc_regmap_config)->lock --> &desc->request_mutex --> &d->lock

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     lock(&d->lock);
                                  lock(&desc->request_mutex);
                                  lock(&d->lock);
     lock(intel_soc_pmic_bxtwc:502:(&bxtwc_regmap_config)->lock);

    *** DEADLOCK ***

   3 locks held by modprobe/141:
    #0: ffff8994419368f8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0xf6/0x250
    #1: ffff89944690b250 (&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq+0x1a2/0x790
    #2: ffff899446947c68 (&d->lock){+.+.}-{4:4}, at: __setup_irq+0x682/0x790

Set a lockdep class when we map the IRQ so that it doesn't warn about
a lockdep bug that doesn't exist.

Fixes: 4af8be67fd99 ("regmap: Convert regmap_irq to use irq_domain")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 33ec28e3a802..0bcd81389a29 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -511,12 +511,16 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		return IRQ_NONE;
 }
 
+static struct lock_class_key regmap_irq_lock_class;
+static struct lock_class_key regmap_irq_request_class;
+
 static int regmap_irq_map(struct irq_domain *h, unsigned int virq,
 			  irq_hw_number_t hw)
 {
 	struct regmap_irq_chip_data *data = h->host_data;
 
 	irq_set_chip_data(virq, data);
+	irq_set_lockdep_class(virq, &regmap_irq_lock_class, &regmap_irq_request_class);
 	irq_set_chip(virq, &data->irq_chip);
 	irq_set_nested_thread(virq, 1);
 	irq_set_parent(virq, data->irq);
-- 
2.43.0.rc1.1336.g36b5255a03ac


