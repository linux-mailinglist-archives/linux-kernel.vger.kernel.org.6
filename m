Return-Path: <linux-kernel+bounces-240076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DF29268DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDEDB214D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BE7187570;
	Wed,  3 Jul 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="snxCe3va"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2941A81;
	Wed,  3 Jul 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033929; cv=none; b=N8k3i0AJvLgU4E2UFOFrGy1lzkeKohv1yzWNE07gxoSgaMeDa79QJBC9ekxQy5PrNMFwQbzerSSKxAWmM2oogOEs9+8jKb1S+aclRy2MCTQzgFjGUEY25VAlDcWUuBzub7en+8gtkBU80JjRp9LA3OM5sbDvX5fy4vdnJO6U8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033929; c=relaxed/simple;
	bh=N2yseTzSknHLCuz9k9d0iGU8jXJUX7vZr9eibLokf1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKOPACptDTvG4pJIaFRhG9N+oO+GLwuQaZyqiRS1QKOKDAtILkXHItsn8zm5Nkji+C6LvM73n1h1m/DjmusenXl0qKarFhuGlZ0IbX4/yPuBjVa82mkyNZmYTbU+QxbhzgQCWEqrrh67lpUqlUW9DFfdGLgBlGAMCkCeBhafuO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=snxCe3va; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id AEB3F100004;
	Wed,  3 Jul 2024 22:11:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720033904; bh=wR4UhQBrxz9Tl2V3D1+Y+i8wbjNl2gzDlSVQGT2T3Kw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=snxCe3vaTvNrSqB+OqExmDsR5hkNW6T5WrWagR5Zmw6kNNsIgD08LQC1ViVDn1Uxt
	 f7/4+gSP/G+sAXP4pVy28CIZBBJaCJ0oA8PeSUBb/+F9LvYiK6ZCeUpsKJruKd1NMf
	 LEjFW9zq1cGMphVk7SGqA3068A+Prhci7fLLyXhSPHx6QyZxeY5FvIsdXMo35m12pD
	 fu7DyVjKHzzsvC9nZY8IgXerTmrj1b1cFYq48L2aelgC7hXADzX0fRGLqcAkAHi7VK
	 ZQyHagO9Up5gnJxjJf8cLJ5v/cDR+1ZaS7MJNOsvQHUyTzpOa6R71R62IFu0fyBD7o
	 Y0HPbuSe7G7uA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed,  3 Jul 2024 22:10:47 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 22:10:27 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] ASoC: amd: Adjust error handling in case of absent codec device
Date: Wed, 3 Jul 2024 22:10:07 +0300
Message-ID: <20240703191007.8524-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240703164028.32806-1-amishin@t-argos.ru>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186315 [Jul 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/03 18:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/03 17:02:00 #25823003
X-KSMG-AntiVirus-Status: Clean, skipped

acpi_get_first_physical_node() can return NULL in several cases (no such
device, ACPI table error, reference count drop to 0, etc).
Existing check just emit error message, but doesn't perform return.
Then this NULL pointer is passed to devm_acpi_dev_add_driver_gpios()
where it is dereferenced.

Adjust this error handling by adding error code return.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 02527c3f2300 ("ASoC: amd: add Machine driver for Jadeite platform")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v1->v2: Comment updated

 sound/soc/amd/acp-es8336.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
index e079b3218c6f..3756b8bef17b 100644
--- a/sound/soc/amd/acp-es8336.c
+++ b/sound/soc/amd/acp-es8336.c
@@ -203,8 +203,10 @@ static int st_es8336_late_probe(struct snd_soc_card *card)
 
 	codec_dev = acpi_get_first_physical_node(adev);
 	acpi_dev_put(adev);
-	if (!codec_dev)
+	if (!codec_dev) {
 		dev_err(card->dev, "can not find codec dev\n");
+		return -ENODEV;
+	}
 
 	ret = devm_acpi_dev_add_driver_gpios(codec_dev, acpi_es8336_gpios);
 	if (ret)
-- 
2.30.2


