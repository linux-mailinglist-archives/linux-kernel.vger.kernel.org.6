Return-Path: <linux-kernel+bounces-537830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD1A49192
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DEE3AD126
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02A1CAA93;
	Fri, 28 Feb 2025 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hV85Cdfq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8F1C8617;
	Fri, 28 Feb 2025 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724138; cv=none; b=efyc2kp36spBLhwbaPzuc0Jpki9J67P+aEf8dDjr5IiKw2HHRBnliATKm3iK8vB3dn3VLJN+vobFtXvzyr3LAdUZmR0x7mkpTHuTcSuKR61fCfPPBcQPuZO5/FuvT2jn7Aei67zaLb2WEOHFHggr4rdEVwEXQ4iSwzQdb0+oSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724138; c=relaxed/simple;
	bh=rmG5AJg763QuUwHiI4zIJ8TFRtKX3Nej46Hu42LYCJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyhJLWwxNLEksQ15zBI0ouNA9hdaFT63Mm9uxB+4kRG0CU0No/35HPMiz4iNxnBnejhz7gPXo5e11J+5uqYpqlHiXReS1ogihO3eC+HgzmjNAjlMV+8Rn2FHw5LZtTTuNLIqsruJankrmkSLdBpmqM70XtCofobWfjooJtxuElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hV85Cdfq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740724137; x=1772260137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rmG5AJg763QuUwHiI4zIJ8TFRtKX3Nej46Hu42LYCJw=;
  b=hV85Cdfq8zejDqpnk1Btu6Rde3UHhegnJ6gEiKeiwYqanvhIUZ3LB6ZL
   uf3aJ/4HDWX5m38V3jXxtbVVp5gNw15cW5D4n1n3WEfYFth1HXiysvBQE
   Jxp0HVf6aQnS1ncVDEwpAcjCZRVSre33thkaVAcv6OFiY8Tc6hN3l6IGT
   fNKv7sdjPXOhyypJxfGG/NU9beKkz+TtEtO7h4UIlI39uOVTqaci/lfti
   KqWGwaonjcijdBorv8IY6u4rL2JLzqbizqZVwRzW/jYnQvqFQmxKgLCVQ
   6VkIss6HNUraXB30CJraA0E+M2C5G50ULZYSQPBy/gWvAjAN9KHNbYMVS
   g==;
X-CSE-ConnectionGUID: foJAtLvkRWeBEF/Snrxf4Q==
X-CSE-MsgGUID: pFLkqEzBRh+gSkRQJs4RsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41560630"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41560630"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:28:57 -0800
X-CSE-ConnectionGUID: snnp9cdgSBGIN7HAUlvi6w==
X-CSE-MsgGUID: wUo0Lp6XQW6Zcl2fymuOQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122265335"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 27 Feb 2025 22:28:51 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	andriy.shevchenko@linux.intel.com,
	cezary.rojewski@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	jbrunet@baylibre.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 6/6] ASoC: uniphier: use devm_kmemdup_array()
Date: Fri, 28 Feb 2025 11:58:12 +0530
Message-Id: <20250228062812.150004-7-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228062812.150004-1-raag.jadav@intel.com>
References: <20250228062812.150004-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() and while at it, make the size robust
against type changes.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 sound/soc/uniphier/aio-cpu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 470f129166a4..3224c11a527f 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -762,14 +762,10 @@ int uniphier_aio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	chip->num_plls = chip->chip_spec->num_plls;
-	chip->plls = devm_kcalloc(dev,
-				  chip->num_plls,
-				  sizeof(struct uniphier_aio_pll),
-				  GFP_KERNEL);
+	chip->plls = devm_kmemdup_array(dev, chip->chip_spec->plls, chip->num_plls,
+					sizeof(*chip->chip_spec->plls), GFP_KERNEL);
 	if (!chip->plls)
 		return -ENOMEM;
-	memcpy(chip->plls, chip->chip_spec->plls,
-	       sizeof(struct uniphier_aio_pll) * chip->num_plls);
 
 	for (i = 0; i < chip->num_aios; i++) {
 		struct uniphier_aio *aio = &chip->aios[i];
-- 
2.34.1


