Return-Path: <linux-kernel+bounces-544342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4375EA4E03A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E103217963C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF6A2066D7;
	Tue,  4 Mar 2025 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Z7rOUb83"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A5205AB3;
	Tue,  4 Mar 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097170; cv=none; b=n+LUA9KesA4xgdUPoYo8O8k7+joU6eRhJ7+kTCpffZ89x/qdsH2W9Fr3zO7/QN2Wa1iXcuRM4g8CvcxGiqkS09os8wJ9lwrobcLwAoZC/ielBxsO4Tvtn/dZAbU47vZu8xGanvwD+pTuRKjvrUXz0Gvxtu7RzHgttZFBSahOxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097170; c=relaxed/simple;
	bh=U77fvGsb7UogkOQ+LsQfoZI1eneuo5KtvBOeXmS7+30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcXTbmM9gzzYg8cUZ9Vupss6MRKmLnSac9D5uA6y3cMdyNu/ccCy90JerW1ScSgKxMVvl1Ulqj3UPl5havjy/TaJNjMeqsy+TO0gkQ5DrdiYipQ0jjKvs64zocsorO8NnwIk6EpfXbpEaKZyWFYCNUd1dhaXE+Z4dYBRZWU8yko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Z7rOUb83; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52472HNA003809;
	Tue, 4 Mar 2025 08:05:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=aLBWcPlv4Ce01YAJgS+V4dJdPBqKcZ9oSMYD/rAPGD0=; b=
	Z7rOUb83W0LI7am6Bs1pMXbJPlJwU/xwvPykmukbJokm1WAKue08PrfKOVdxMJzb
	OSa0TkzleuMMdAnDdlmdeTs5cmt0EmnwhBKoqg5UlHcjSKGUbiadg/buLcCM/z/t
	Cw4BG2qveXOkNhpsGCUzPD1/75EG5fEi8WFsAcHYsflB9ZBumSg2exS1/o7TkR5O
	tqNQgee68So/m+z69sa1wbZkzw0BePN7t1SIljj2q9weGsT6+RvdinYcFunTwz8A
	TIJ6TLri/mLZ7TeGT1akuke7PUbvKZCm8LM+3+0vS5t0m/8saVBPYGvuJsJGOalE
	YxK9bbJwHlNlRib3BzOe6Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj0ts-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:05:51 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:05:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:05:00 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8C40F820270;
	Tue,  4 Mar 2025 14:05:00 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peda@axentia.se>, <andrei.simion@microchip.com>,
        <nuno.sa@analog.com>, <paul@crapouillou.net>, <oder_chiou@realtek.com>,
        <kiseok.jo@irondevice.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <srinivas.kandagatla@linaro.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 09/13] ASoC: atmel: tse850-pcm5142: Use SOC_SINGLE_EXT() helper macro
Date: Tue, 4 Mar 2025 14:04:56 +0000
Message-ID: <20250304140500.976127-10-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304140500.976127-1-ckeepax@opensource.cirrus.com>
References: <20250304140500.976127-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yXevSVPnnrC9w5WP3f3vczALSlb5frvn
X-Proofpoint-ORIG-GUID: yXevSVPnnrC9w5WP3f3vczALSlb5frvn
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c708bf cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=0mOSjS8g2lfFcO4yiOgA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

The TSE850_DAPM_SINGLE_EXT() macro is an identical duplicate of the
core SOC_SINGLE_EXT() marco. Use the macro provided by the core.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v2.

 sound/soc/atmel/tse850-pcm5142.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 0a9efd5f28615..2a1d0408a4cf1 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -227,16 +227,9 @@ static const struct snd_kcontrol_new mux1 =
 static const struct snd_kcontrol_new mux2 =
 	SOC_DAPM_ENUM_EXT("MUX2", mux_enum, tse850_get_mux2, tse850_put_mux2);
 
-#define TSE850_DAPM_SINGLE_EXT(xname, reg, shift, max, invert, xget, xput) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = xget, \
-	.put = xput, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
-
 static const struct snd_kcontrol_new mix[] = {
-	TSE850_DAPM_SINGLE_EXT("IN Switch", SND_SOC_NOPM, 0, 1, 0,
-			       tse850_get_mix, tse850_put_mix),
+	SOC_SINGLE_EXT("IN Switch", SND_SOC_NOPM, 0, 1, 0,
+		       tse850_get_mix, tse850_put_mix),
 };
 
 static const char * const ana_text[] = {
-- 
2.39.5


