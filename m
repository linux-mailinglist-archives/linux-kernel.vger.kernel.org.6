Return-Path: <linux-kernel+bounces-510778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D25A321D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9C73A20AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD2205E05;
	Wed, 12 Feb 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GVFYKxZ5"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AB1D63C0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351594; cv=none; b=ChFnDYrykzXpBFGXprb6s0QqG9vXaHiPbsypO1V8l0EZcztQMPAZE1ezFVtX6p2jtucEDhAwft6NF7tHecJoK7wAbdFLLVsUJGI9myHuBWVwhBYrzjQP40T7CQYfyXZ1lFuhNapKxs2J/BuUNg3eIw8J2MCEt7fLX3xPcB7ZSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351594; c=relaxed/simple;
	bh=E9lu+GG0AYXIafs+8hw2iWDNPfH1dvmIXwviHzeIWsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvrfCvswRxQr6hDl1h65M5kwkku36u2yDazIkq7A491pQQkO+e44ZN0MmSO9vD9+ojtQ0sePGM/P2dcCWphiW/fwuVGFgEAOdqX8plzb1CGTfgfaNF7V9K5ouM1DiyTTp070Gg1dwRxKNXkznUrD3kWQu9EFTwrGW1qRDGlrfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GVFYKxZ5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739351589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GLTcxnoejq9g8W1Zy6A2WIqaQC5yyGpPrqr18o1paAY=;
	b=GVFYKxZ50LRjTxhPPZs3jH9Rzb7ql8wztw+/QJR2oxlY/HjZ3dJqOSXRwk42FjrJRQxQvO
	NFrP7Uu3v0o5MUtAqxYMEBCkZ6UQPtnekL6pPjbdGpkpcXq0zDdZZWa2R8s45EUXgylolJ
	B2cJZNmEvWo28V9eHinGDkHVMH8M4h0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: avs: Use str_on_off() in avs_dsp_core_power()
Date: Wed, 12 Feb 2025 10:12:26 +0100
Message-ID: <20250212091227.1217-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_on_off() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/intel/avs/dsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/dsp.c b/sound/soc/intel/avs/dsp.c
index 7b47e52c2b39..b9de691e9b9b 100644
--- a/sound/soc/intel/avs/dsp.c
+++ b/sound/soc/intel/avs/dsp.c
@@ -6,6 +6,7 @@
 //          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
 //
 
+#include <linux/string_choices.h>
 #include <sound/hdaudio_ext.h>
 #include "avs.h"
 #include "registers.h"
@@ -39,7 +40,7 @@ int avs_dsp_core_power(struct avs_dev *adev, u32 core_mask, bool power)
 				       AVS_ADSPCS_TIMEOUT_US);
 	if (ret)
 		dev_err(adev->dev, "core_mask %d power %s failed: %d\n",
-			core_mask, power ? "on" : "off", ret);
+			core_mask, str_on_off(power), ret);
 
 	return ret;
 }
-- 
2.48.1


