Return-Path: <linux-kernel+bounces-537826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CB4A4918E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DB2189179F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DAC1C5F01;
	Fri, 28 Feb 2025 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lms55KFZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DE1C3C0F;
	Fri, 28 Feb 2025 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724115; cv=none; b=LXoFvJbLDQgSReHRS/H/fg6/d9YQYlo75G8/8z6oL5lasbfDPGo7WCx5glTQHU0z/Pu1+MaY6hApa6e+R9gq225kTrfNVqIRVSZnbpbvPwOMYelnq/x2JjI9nkFddkw1/0KlT8VvLd7acK8dwBvQGaGDRFCbf7a7ru+P4VSWXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724115; c=relaxed/simple;
	bh=AUJvMFsICvoCmVfWj5JN11a/sKwael8x29G4HCF3zLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4op/Ta6DFHw1WBd9SCob4ssQpxL5J81+f7hfypDeH1tu4M4sTuSJUmnLJxOtSFde7MMh9t68nbYgGwLo1l+yJAbq6b/FwaL0zGv7T0ppwrAIlsEF3sq1+XHUaaCRn92aArHqVHZKFH39TCHxXqjPzUOilAa1eKhjSiThnHNAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lms55KFZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740724114; x=1772260114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUJvMFsICvoCmVfWj5JN11a/sKwael8x29G4HCF3zLY=;
  b=Lms55KFZ8pzOq9lZYxuOb4+/G+fbmUHP2lXi6HBE7iz3IiNRmmIBtgvi
   Cp1Y5T9jz99sayvskDjrJy0O5fDfKlP+Uz0pAP3umHcWZE5MuAmANjkCb
   WmigQ8WAOymnrZWg7SM2y5GDSqbDBVgwidgGJndWB5wsCBgThS6oQKP6y
   6RwQV36lhfy5wMbnQEyOJv+5XPnt8XfmWPtw9dvsqmJMjREL+eX9u+hPu
   jTO4I4het4CtCt9udXAcZOw9BVJJFkF8mMcZB3ggZWVRcr9WmoREE5dNY
   sSOUpzRMq3VCehRMYuiaZ+dWihxwAuPyOvxrO72aDNUTA2PhZf7UVYiZZ
   A==;
X-CSE-ConnectionGUID: rhNPxpCLTESKcN0pDIccyw==
X-CSE-MsgGUID: 79vTxGR8R7qmprp5OZ32rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41560585"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41560585"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:28:34 -0800
X-CSE-ConnectionGUID: iwnW2x5ATfyJwdWnnr8JBA==
X-CSE-MsgGUID: djKSmC+hQfeb2rQ6oJ0Pbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122265267"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 27 Feb 2025 22:28:28 -0800
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
Subject: [PATCH v2 2/6] ASoC: hdac_hdmi: use devm_kmemdup_array()
Date: Fri, 28 Feb 2025 11:58:08 +0530
Message-Id: <20250228062812.150004-3-raag.jadav@intel.com>
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
 sound/soc/codecs/hdac_hdmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e1a7f0b0c0f3..3bea5d09219a 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1017,8 +1017,7 @@ static int hdac_hdmi_create_pin_port_muxs(struct hdac_device *hdev,
 			return -ENOMEM;
 	}
 
-	se->texts = devm_kmemdup(&hdev->dev, items,
-			(num_items  * sizeof(char *)), GFP_KERNEL);
+	se->texts = devm_kmemdup_array(&hdev->dev, items, num_items, sizeof(items[0]), GFP_KERNEL);
 	if (!se->texts)
 		return -ENOMEM;
 
-- 
2.34.1


