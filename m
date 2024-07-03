Return-Path: <linux-kernel+bounces-239872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9E926649
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101E41F2313A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBFF183082;
	Wed,  3 Jul 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="OXxrza6w"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82AF1822F8;
	Wed,  3 Jul 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024934; cv=none; b=dFT5iU16a0wjV+RndXI4dG80/k88WrJodXOcU6vb92Ns0ijBAMkfpEzPg+AFUEy97lu08ID0Aoz6UbXp1jZu9rh4E8y5vp9QSPHj2tMp2XYTZy3ZI4cgeMopUd8pCmPNXxHEVGEyFTaJpTPypMYDOCQprsGjKRyvArxLQ4mx0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024934; c=relaxed/simple;
	bh=aS05j7cqiVpGJkb8TVm9ieLHw6OH/xlV346wSSb/3Jg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eOE0BfMFKmfi/RkP/Elqvj04xyZ1iz0lM0dGW2k/xeTAw+NkElykaS+a5DnipzL1ycRuMnbrQ6eV7UxVS+ycno6sFgfmmJ8TagbMFpRYAzxziozUQ1/clO37YdUcZ57tJrJ63gvbd3ZKMJT106u2S0UaSQ8XV+5xnYdr63yRyKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=OXxrza6w; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 9FCD5100004;
	Wed,  3 Jul 2024 19:41:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720024912; bh=7HOsXZ+t5H5CIixi19Qsdci4dDO45Md8eG5cPokiVA8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=OXxrza6wRh6yQcpNWs5G8kueSc1lprPnGTaXfRR10Xe8YVzBRNFfyqILnLmhcTtsz
	 m4tEP3LjXSlMkHXMWvgxA2SDVrqpsZWyQVEK+L02T1ySKOAYqyUHBAoUOB9ExqkAoA
	 ybZDHFb8VyBUEe+kJebMmiHLFgmUYHuTYbN2IyeZreKgUbVcmBV+CSYHbLHgY40U8e
	 yVVWLd7WmLsxQ4m0/jEQq2Ew5NbItpBZht/cs5oIaqr7Z+41yxHSsle67i0HOOrR/V
	 uuf8ts37djLW9taay2j2aRZYuaCla+WxQvZ92R6tWuK7JatbMg1gkcVh+IPsvu0M/2
	 UOM3Wcjq/Hokw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed,  3 Jul 2024 19:40:57 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 19:40:37 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] ASoC: amd: Adjust error handling in case of absent codec device
Date: Wed, 3 Jul 2024 19:40:28 +0300
Message-ID: <20240703164028.32806-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
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
X-KSMG-AntiSpam-Lua-Profiles: 186313 [Jul 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/03 15:42:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/03 06:16:00 #25818842
X-KSMG-AntiVirus-Status: Clean, skipped

acpi_get_first_physical_node() can return NULL in several cases (no such
device, ACPI table error, reference count drop to 0, etc).
Existing check just emit error message, but doesn't perform return.

Adjust this error handling by adding error code return.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 02527c3f2300 ("ASoC: amd: add Machine driver for Jadeite platform")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
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


