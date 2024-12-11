Return-Path: <linux-kernel+bounces-441192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777259ECADC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E73F169E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A08211A14;
	Wed, 11 Dec 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8XKzB5Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78367211A0A;
	Wed, 11 Dec 2024 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733915369; cv=none; b=i6lbd/ofxU3HeJG4yaV+8gTmE/GDwyIDkxMT7qFWrgA/QF9qqcqmiS/tse/CAuVjSNykDgrWWdyWpBRAIbGYM788tKm1ZpqW1Kw9OdXiHGllvOVR/jX2bVdbZCbzUquO5BynkMvrrpuylGbKHiJ6yQmXrgyzvoTRv1waIW7udtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733915369; c=relaxed/simple;
	bh=bDgWz1MVeXMv9PDk9q82fqFPvxQ3Bd8kwrxb7p7Mohw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKQnoPuTup8ZRutertA6XXR5BDvowPq3dbGdzcFv2ZweOR4pasdQu3AVAZFEzMOEG5zTTA67r5mhKfhLz2iPJwAXFJ5X1VMZFkddpceJMQAzClknNBcBE4K1qNuG/R8FDymmyl3U9lj8kyVuX5slrU9fqyXPwgrh0QrJyYJkWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8XKzB5Z; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733915368; x=1765451368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bDgWz1MVeXMv9PDk9q82fqFPvxQ3Bd8kwrxb7p7Mohw=;
  b=n8XKzB5ZgMbYJoUwtrX+zKmQLnVcdJk8DkqSTC++/+taTTBO8u9WfOOa
   GP0Ku1d7LeC1v8XEcgxfPQ5xj3LqZELe9zX2OtkJjxWrppQw1UIK00CB5
   h/AqncYkIrkbolaUZ6WQMDdabABB9IaX/1drVDiDQlaWeo/5KWOzMaom9
   MVFaolO+f6xIiMyc5Q+SAmZiR40Lt0bWBAZAWtN4/IDbMhs09afy2cA9L
   ofiZ1JMXzx9YSfs0zbXJzlxVa+yLuDmP8T9qUcwgn+v0F9/HD4PFSpv8l
   NKfYcA4CT+xhtEb/cBhGOfZkKS8kBfeo4c7Bs1nwf4Cni6D1Omz+I4xen
   g==;
X-CSE-ConnectionGUID: lU4/OFfmRCy1qqGnb3oJDw==
X-CSE-MsgGUID: dK+anhrAQxm8qs2crV/DoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="59682791"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="59682791"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 03:09:27 -0800
X-CSE-ConnectionGUID: npfScrdLRiy5PImrDjLIpw==
X-CSE-MsgGUID: SoEfcApnTT+5QyjMU8vxZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133147006"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orviesa001.jf.intel.com with ESMTP; 11 Dec 2024 03:09:24 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 1/1] ASoC: Intel: avs: Fix return status of avs_pcm_hw_constraints_init()
Date: Wed, 11 Dec 2024 12:10:10 +0100
Message-Id: <20241211111011.3560836-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211111011.3560836-1-amadeuszx.slawinski@linux.intel.com>
References: <20241211111011.3560836-1-amadeuszx.slawinski@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit a0aae96be5ffc5b456ca07bfe1385b721c20e184 ]

Check for return code from avs_pcm_hw_constraints_init() in
avs_dai_fe_startup() only checks if value is different from 0. Currently
function can return positive value, change it to return 0 on success.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
--

I've observed KASAN on our setups and while patch itself is correct
regardless. Problem seems to be caused by recent changes to rates, as
this started happening after recent patchsets and doesn't reproduce with
those reverted
https://lore.kernel.org/linux-sound/20240905-alsa-12-24-128-v1-0-8371948d3921@baylibre.com/
https://lore.kernel.org/linux-sound/20240911135756.24434-1-tiwai@suse.de/
I've tested using Mark tree, where they are both applied and for some
reason snd_pcm_hw_constraint_minmax() started returning positive value,
while previously it returned 0. I'm bit worried if it signals some
potential deeper problem regarding constraints with above changes.

Link: https://patch.msgid.link/20241010112008.545526-1-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/avs/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index 4af8115803568..945f9c0a6a545 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -509,7 +509,7 @@ static int avs_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 			    SNDRV_PCM_HW_PARAM_FORMAT, SNDRV_PCM_HW_PARAM_CHANNELS,
 			    SNDRV_PCM_HW_PARAM_RATE, -1);
 
-	return ret;
+	return 0;
 }
 
 static int avs_dai_fe_startup(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
-- 
2.34.1


