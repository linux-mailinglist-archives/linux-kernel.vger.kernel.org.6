Return-Path: <linux-kernel+bounces-537828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D67A49190
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51AE3B7AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88E31C5D44;
	Fri, 28 Feb 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OV4NH9uG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899211C4A3D;
	Fri, 28 Feb 2025 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724127; cv=none; b=AB1EndzQi0LMSUAc2xaSkopjtIq2O08jZJMgaYefpJCZYOC3vSvysXu5+kzfx4zS27ogIrgBKPCdbWupZM02E/uGLE4ZvKS66QSVaNJv/B1fhRQ0aRC0MKx74SfIW1RbgwJaS3g681vfa2DOD15B01wb0SkkcOtFGg6e/WCPJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724127; c=relaxed/simple;
	bh=e7a2cCCwX7XNrpGn1XdJxR3IeQTxmfvf2zp8jE434LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ee8z8hCWTMddmHMUjO0Zvda10XhjX0JYqwnWWU1P+qAYCjD/cL3cgUP8Nw0jmlugCN0U9EVBjs1NFsD/gJCvcumBpl1THonI6W1GUeFRPe28sYCVr0nbuIn8EI2GCIM9tfEyVONQ9opBQyAGn4gLwR526m5oa6viKQisv12p/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OV4NH9uG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740724125; x=1772260125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e7a2cCCwX7XNrpGn1XdJxR3IeQTxmfvf2zp8jE434LA=;
  b=OV4NH9uG68wzi17Bum+Ee2Ye47mnre5SR20lOZmkWtt4M88OOQG+kVfJ
   dOCgYmUtAgomkpJvYOWlhNDng8lErdu4jTcEbJU6xVNYO6LQvgoNiLRd8
   +PJXQBIEwzcW/V7Fe/FEX5ImHNMVUnsL10RGZDwXWanhPX5EuTJDFWElV
   y2hKECkKg7DdJnzrdwxraxmcUkDtcxVdDlUrpQNRhJAcfyZYzqP6HwcGs
   TtWnsJK9S4J9AB9lyEmVYhg5cyxw3+KWZWVJppsdlT4YgjKxiPiafQEOI
   ieanC6bTwS7+cI07CFloxBCjcWHAZ8EkSrKfvln/EAaM39kgjcsry32RE
   w==;
X-CSE-ConnectionGUID: 0MhFZWJZSpu9liSaKyFAiA==
X-CSE-MsgGUID: cbvhgDK5TWSyaZdTpgs3rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41560606"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41560606"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:28:45 -0800
X-CSE-ConnectionGUID: 96XjMWfTQb6L9luGeC+NBg==
X-CSE-MsgGUID: Rln090DUSDuuM/IToxvhYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122265287"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 27 Feb 2025 22:28:39 -0800
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
Subject: [PATCH v2 4/6] ASoC: uda1380: use devm_kmemdup_array()
Date: Fri, 28 Feb 2025 11:58:10 +0530
Message-Id: <20250228062812.150004-5-raag.jadav@intel.com>
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
 sound/soc/codecs/uda1380.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 4f8fdd574585..c179d865b938 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -766,10 +766,8 @@ static int uda1380_i2c_probe(struct i2c_client *i2c)
 			return ret;
 	}
 
-	uda1380->reg_cache = devm_kmemdup(&i2c->dev,
-					uda1380_reg,
-					ARRAY_SIZE(uda1380_reg) * sizeof(u16),
-					GFP_KERNEL);
+	uda1380->reg_cache = devm_kmemdup_array(&i2c->dev, uda1380_reg, ARRAY_SIZE(uda1380_reg),
+						sizeof(uda1380_reg[0]), GFP_KERNEL);
 	if (!uda1380->reg_cache)
 		return -ENOMEM;
 
-- 
2.34.1


