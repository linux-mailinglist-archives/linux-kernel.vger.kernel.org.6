Return-Path: <linux-kernel+bounces-371578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE99A3CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F45C1C2546A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFCF1D7E4C;
	Fri, 18 Oct 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="M9cQWn5S"
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3620262E;
	Fri, 18 Oct 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249690; cv=none; b=cbJDSCXQS52MqtXpL7Cflv7kVXRQnyBWyODqbiyqX8k+uy7WIbEvhFKKxK11jCJRGIHfMKamamGTdDy3YN2nPHh+2/VykVVtPQH3EK9Aw0d6n7fW5XjN0Ycffc0w1jpgmtGcpnjWi7Yqu3vtExiWURKccFN2IzrDskgBgq78MmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249690; c=relaxed/simple;
	bh=roZL7Fo4RQ8XJx9gSRchXoZs7X/th6UYrkxC2F/4bsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jWlWNaBJk2gysmPL9w6oVm5b1emcZ/StAERgcg1mA6hLrlvPElSEx+q0Wf4ZJ6zYYcbp+rq4YR+M8zve0H4/+zq4o6d2ZDAeRyXdwiYZMoUikBXaLy0bg2TNwPMbB0/1O5cEDmFpxsiOaWbegd3ypv0sLm6QsYQ71cOblajLi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=M9cQWn5S; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 3F9A3C000A;
	Fri, 18 Oct 2024 14:07:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 3F9A3C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1729249676; bh=mN9Vl+iYWRUJkFg62eJEHwY5V2j4me6G+dqs5tVdAuk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=M9cQWn5S7OaZp80mCs74SdtvBJM+T8EMXz0gIsQmgppcQhpzak/1W0+BXvPK53cP0
	 hjPGqiXR7hZu0vIB/EOSgkvLkKLMnPwMVb1XWXQqswZrAfYs7qCOkZOPN2MKp3ZsV7
	 Rva8QWgbc/bosCWL355g5/nSJ8FPW0lqJi+GzGokoxmX0YQccmuyCR7CDhUU5O4hIq
	 M+MO2KBJ5qDF/6LkNhXql5SwkNOxY7akFPOihkzn8gFEL7WEqGOFhiJLdzIYNxFbKy
	 ZzYEyTGCU2ZFhfFSa/xwF+Ywv5SiHVWvqFkARdSQK7iuHtJocFagYDufX97oDGRr5O
	 LvvUVqT3PgdxA==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Fri, 18 Oct 2024 14:07:56 +0300 (MSK)
Received: from localhost.maximatelecom.ru (10.0.246.97) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Fri, 18 Oct 2024 14:07:54 +0300
From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
To: Liam Girdwood <lgirdwood@gmail.com>
CC: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Seven Lee
	<wtli@nuvoton.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] ASoC: nau8821: check regmap_raw_read/regmap_raw_write for failure
Date: Fri, 18 Oct 2024 16:07:41 +0500
Message-ID: <20241018110743.18786-1-v.shevtsov@maxima.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 188530 [Oct 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 40 0.3.40 cefee68357d12c80cb9cf2bdcf92256b1d238d22, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;maxima.ru:7.1.1;ksmg01.maxima.ru:7.1.1;81.200.124.61:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/18 09:34:00 #26770281
X-KSMG-AntiVirus-Status: Clean, skipped

The return values from both regmap_raw_read() and regmap_raw_write() are not
checked despite they can fail. Propagate possible errors to caller.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: aab1ad11d69f ("ASoC: nau8821: new driver")
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
---
 sound/soc/codecs/nau8821.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index de5c4db05c8f..edb95f869a4a 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -287,10 +287,8 @@ static int nau8821_biq_coeff_get(struct snd_kcontrol *kcontrol,
 	if (!component->regmap)
 		return -EINVAL;
 
-	regmap_raw_read(component->regmap, NAU8821_R21_BIQ0_COF1,
+	return regmap_raw_read(component->regmap, NAU8821_R21_BIQ0_COF1,
 		ucontrol->value.bytes.data, params->max);
-
-	return 0;
 }
 
 static int nau8821_biq_coeff_put(struct snd_kcontrol *kcontrol,
@@ -299,6 +297,7 @@ static int nau8821_biq_coeff_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
 	void *data;
+	int ret;
 
 	if (!component->regmap)
 		return -EINVAL;
@@ -308,12 +307,12 @@ static int nau8821_biq_coeff_put(struct snd_kcontrol *kcontrol,
 	if (!data)
 		return -ENOMEM;
 
-	regmap_raw_write(component->regmap, NAU8821_R21_BIQ0_COF1,
+	ret = regmap_raw_write(component->regmap, NAU8821_R21_BIQ0_COF1,
 		data, params->max);
 
 	kfree(data);
 
-	return 0;
+	return ret;
 }
 
 static const char * const nau8821_adc_decimation[] = {
-- 
2.46.2


