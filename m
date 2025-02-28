Return-Path: <linux-kernel+bounces-537827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8F2A4918F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801C216E41C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3801C5496;
	Fri, 28 Feb 2025 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2snQm+p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1011C5485;
	Fri, 28 Feb 2025 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724121; cv=none; b=rxAlBZwo8uOHn4XW7huJ6VPEmTP/iXEni+j+wt6byb85woSnzlBW8zxnOUeDbSWNxgfxlmDbh8fYudAMjHyOkTAA+e+faW89giF1KXfPV7uJFAqzQhphFwdelspwkZvH4m52CB4s7BM/AQKyLyF1ko8QQzMVOjwGkmHrkgNgz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724121; c=relaxed/simple;
	bh=NSXN9VYfQFUizYJYR++h6usWkL8OeRS3X1QV/7FBf64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ch9S3SajrKq7UBqVk57/CklwPvDML4ofeG6BcywT/yjZLxlrH4CCRnQqA8N7YgUQoDTZekHjSXaBBreznibZrTUcvAdiUCNtCn7QcvbcmqCJjSBbtljMX5c5v1LYPo6Na15MDLiBMEgbDMXqnIodgAhYEjbdGEYPRdrJw0jaMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2snQm+p; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740724120; x=1772260120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSXN9VYfQFUizYJYR++h6usWkL8OeRS3X1QV/7FBf64=;
  b=d2snQm+pMM+IHTToIwxlPqQxsHSxo7ZeWxmQHPTyHlvc4Jm46RgXWQJw
   b0uCcTxIFuaLyOcUh2CZ5PWMZ/l/XS+MVAezueNG02SUG/F/BF4EZvthr
   ABWLzGfTxUc352E/tmqOzEFOBeXubezrndO/olyxjBnDnmot/+MZR4e0i
   liGT3gyJlVahAjQwfgBjCUpktn6TrGTCJjU7lRhqdKSUn02y/rBgxL9u4
   wauPKj/CQSr4o3YfD/f0D6SwSkBL72E8d/M69oo4TV3LILrfg7ko/I0Y3
   2zQ5nlDZLxyfpiNE/dBm9ehb1k/tKQh/QRLcowVP4muEdaYOYCOFiVxUp
   Q==;
X-CSE-ConnectionGUID: cqk+OFlETIqJ+xbQSVMjCw==
X-CSE-MsgGUID: kT9+ZUdJQBWFY5Us1D83Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41560594"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41560594"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:28:39 -0800
X-CSE-ConnectionGUID: lAVzdclkRwC1xcaXxpdT9g==
X-CSE-MsgGUID: zlE0fJP9R+2JlmFwC4PWQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122265277"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 27 Feb 2025 22:28:34 -0800
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
Subject: [PATCH v2 3/6] ASoC: tlv320dac33: use devm_kmemdup_array()
Date: Fri, 28 Feb 2025 11:58:09 +0530
Message-Id: <20250228062812.150004-4-raag.jadav@intel.com>
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
 sound/soc/codecs/tlv320dac33.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index fa46f51d4341..423b9264a205 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1477,10 +1477,8 @@ static int dac33_i2c_probe(struct i2c_client *client)
 	if (dac33 == NULL)
 		return -ENOMEM;
 
-	dac33->reg_cache = devm_kmemdup(&client->dev,
-					dac33_reg,
-					ARRAY_SIZE(dac33_reg) * sizeof(u8),
-					GFP_KERNEL);
+	dac33->reg_cache = devm_kmemdup_array(&client->dev, dac33_reg, ARRAY_SIZE(dac33_reg),
+					      sizeof(dac33_reg[0]), GFP_KERNEL);
 	if (!dac33->reg_cache)
 		return -ENOMEM;
 
-- 
2.34.1


