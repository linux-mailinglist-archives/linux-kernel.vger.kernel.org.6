Return-Path: <linux-kernel+bounces-397901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD169BE220
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F8F1C23085
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B891D88D7;
	Wed,  6 Nov 2024 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="JNuVFKJq"
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C4183CD6;
	Wed,  6 Nov 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884565; cv=none; b=o7G8WraeHQdJrhW+ZmxoFGb7xKks1PpsJFS6xjgX094+CWXgK6LFCgx/3gYTCgZLXWsRkEcmZRjfNDAxh8z02+ANbpPVOgHHw+7Tax37m0nypQIZgs/BGe9ms7a14wivOHT5QPyqLf7/3SD2fI8ls+MWaKJR/4yOThvg8u2Z5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884565; c=relaxed/simple;
	bh=0MsT+PRcmMBQxJvoT42iJU1htJ6YTamf0usyHQ6hKUs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sX+qetgA7aPT41nP4Sq1Fq2oRNVUyXX75SumUfnWzjom+IThSCycdZGOk+3Lg3pTAtX/DgTCz4XyffDjaQrJ60Rge7OrQjPFsY0FOgO6d7gVpM9KFXFP11+qvauuUM8ka8mWuJiA/I4u7GDIf4WmTw6rmDlu1Jj7HYQkxbrPYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=JNuVFKJq; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 6BDADC0002;
	Wed,  6 Nov 2024 12:06:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 6BDADC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1730883996; bh=zsIfNjJuQRzVx0PaAaQa+PRTtSriwy+5ltfs2Vpbja4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=JNuVFKJqi9u8k5MpQyyQzuSqrmDj/Rn0L23cdQUe0AJUr/vgQMAH14DCBj138iDNe
	 9bmUD16ABkOu2w5RBMKm6mo9NmB4yYS+9QoD/iCybitc8uF+IBEwDMDhrgZihmVh0H
	 bYs/UKNsW+JW5t7QY0G62Abosa1A1eSAZatMbEIQ0uSj1msKyZt7wV7MuT7PPhVsdz
	 FQHl6L7Sm9/D3fCpmwCjcq+hKdm+pdt5AEfe12zM8hmt6T8mLKrMvUg49x9+vvLE/6
	 lVJXIo5AzOWhat7N3Q4aHWppInjIU5HigRQiULX3R4ScniVdWlyF368lbKg9s5dvNC
	 bRT67QAbfgdhw==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 12:06:36 +0300 (MSK)
Received: from localhost.maximatelecom.ru (10.0.247.43) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Wed, 6 Nov 2024 12:06:34 +0300
From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
To: Cezary Rojewski <cezary.rojewski@intel.com>
CC: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Liam Girdwood
	<liam.r.girdwood@linux.intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] ASoC: Intel: sof_wm8804: add check for CLKDIV setting
Date: Wed, 6 Nov 2024 14:06:02 +0000
Message-ID: <20241106140603.14516-2-v.shevtsov@maxima.ru>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188984 [Nov 06 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, ksmg01.maxima.ru:7.1.1;maxima.ru:7.1.1;81.200.124.61:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/06 04:26:00 #26824941
X-KSMG-AntiVirus-Status: Clean, skipped

Currently the return value of snd_soc_dai_set_clkdiv() is not checked for a
possible failure. Despite it cannot fail as long as the second argument is
either WM8804_CLKOUT_DIV or WM8804_MCLK_DIV because wm8804_set_clkdiv() handles
both of them it is still better to add this check for the sake of completeness
and correctness. Also this is the only snd_soc_dai_set_clkdiv() call site where
the return value is not processed.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
---
 sound/soc/intel/boards/sof_wm8804.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_wm8804.c b/sound/soc/intel/boards/sof_wm8804.c
index facc6c32cbfe..d7ac54e9d0a8 100644
--- a/sound/soc/intel/boards/sof_wm8804.c
+++ b/sound/soc/intel/boards/sof_wm8804.c
@@ -123,7 +123,12 @@ static int sof_wm8804_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	snd_soc_dai_set_clkdiv(codec_dai, WM8804_MCLK_DIV, mclk_div);
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8804_MCLK_DIV, mclk_div);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "Failed to set WM8804 CLKDIV\n");
+		return ret;
+	}
+
 	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, sysclk, mclk_freq);
 	if (ret < 0) {
 		dev_err(rtd->card->dev, "Failed to set WM8804 PLL\n");
-- 
2.46.2


