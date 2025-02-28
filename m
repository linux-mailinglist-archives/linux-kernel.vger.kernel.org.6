Return-Path: <linux-kernel+bounces-537829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F02A49191
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B350916E1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F371C54B2;
	Fri, 28 Feb 2025 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4qbzyxE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445081C5D51;
	Fri, 28 Feb 2025 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724136; cv=none; b=SgyNC2Iw/G1KDoX3xH8YzhhGg7xlZuc+A8Ye+t4qubGgW7SO0kbSlJjJ/Zozt4+HnqL1JTfmngpD4vt6/kYbO4sAktIdMpmwcUDYwJwRTcVCOHElCycyD3Z7V/hyoTIeTMTyuEx780uERTY8Sac22LLXG6sP6tzSI9LPYemQf/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724136; c=relaxed/simple;
	bh=9jklcU8zXeb2fq/kZyVr5PcF5WyfIGqHTEgky7Oh+0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UozHAsQ6oxhcqfiXJ+FsnBt7nNByjnYa7UzsAADfxaSAwpKUpzOR6k8tJZ8t0Raa+EN40xl1U/ZhesFpXfso+FW/8myR70xnSiYY6ScYbK445vyZkE6hsA8+wgFAuwx7SoenvU7cZI0ym6VLKz+nGkdCD4S5Rggpbsg/ODenFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4qbzyxE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740724131; x=1772260131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9jklcU8zXeb2fq/kZyVr5PcF5WyfIGqHTEgky7Oh+0o=;
  b=R4qbzyxEyZQXrUaNFnj7cNQU1zsO844mjRCW8eKNKY+uJiQeYded/jCZ
   IAy5+zv++4iWTMMkAxlNaei3a1bwKVcrOTIgplHeFaQQhWTgv2U1gfK4j
   acu55rzz/04fA5cIy89PbbjmMoJ002eAf2rxisewHdTzphNZlwgTAKl3M
   iq1PM7zzJm3c6qCIZbTREPRh4dICLL1h3v3XVr7S3p68oGIFQ+uxsgkBE
   hBGrlIRJY4kCBcZdaKu6AunRQLz42kb2nfUnlh0mLNAHRT+xQ0vM6QZYI
   L6xRl0Vdn5a1Ci0iJFLIyJwXhEcdDpbZ1ZJUZIl/xNzU59zbyR8OXryvD
   g==;
X-CSE-ConnectionGUID: pZ1bp4OWSEK7OgkafmGBGA==
X-CSE-MsgGUID: b5v4jTVdRRO3h9giBCqNiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41560621"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41560621"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:28:51 -0800
X-CSE-ConnectionGUID: BsSPXGf2QzS0uHcld8PrYA==
X-CSE-MsgGUID: RoIU7F6UQPWWh8myrKEe9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122265320"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 27 Feb 2025 22:28:45 -0800
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
Subject: [PATCH v2 5/6] ASoC: meson: axg-tdm-interface: use devm_kmemdup_array()
Date: Fri, 28 Feb 2025 11:58:11 +0530
Message-Id: <20250228062812.150004-6-raag.jadav@intel.com>
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

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 sound/soc/meson/axg-tdm-interface.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 09103eef2a97..421b5d719fb3 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -529,7 +529,6 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct snd_soc_dai_driver *dai_drv;
 	struct axg_tdm_iface *iface;
-	int i;
 
 	iface = devm_kzalloc(dev, sizeof(*iface), GFP_KERNEL);
 	if (!iface)
@@ -541,15 +540,11 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	 * We'll change the number of channel provided by DAI stream, so dpcm
 	 * channel merge can be done properly
 	 */
-	dai_drv = devm_kcalloc(dev, ARRAY_SIZE(axg_tdm_iface_dai_drv),
-			       sizeof(*dai_drv), GFP_KERNEL);
+	dai_drv = devm_kmemdup_array(dev, axg_tdm_iface_dai_drv, ARRAY_SIZE(axg_tdm_iface_dai_drv),
+				     sizeof(axg_tdm_iface_dai_drv[0]), GFP_KERNEL);
 	if (!dai_drv)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(axg_tdm_iface_dai_drv); i++)
-		memcpy(&dai_drv[i], &axg_tdm_iface_dai_drv[i],
-		       sizeof(*dai_drv));
-
 	/* Bit clock provided on the pad */
 	iface->sclk = devm_clk_get(dev, "sclk");
 	if (IS_ERR(iface->sclk))
-- 
2.34.1


