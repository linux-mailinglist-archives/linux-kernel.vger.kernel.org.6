Return-Path: <linux-kernel+bounces-200404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97B8FAF97
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA811F225E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC6A1448EE;
	Tue,  4 Jun 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E+DvwRIS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D0143C7B;
	Tue,  4 Jun 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495899; cv=none; b=nBaZYB+h0Tqj1GjG+WieQgBzBmOZ1cvwNkyd52dydCWZCCF6DORVXIw61YcrGEvuZn+a5sdYRl4OeBEXRUQzfrq2h4TG1ogSiqeck3wW0ceocOJD1jPHdFByKuqQWa4fPc6IZPT90PZXUoUdfgK2E/fFpy5wgnHhDUoPCQKEQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495899; c=relaxed/simple;
	bh=C9QZlpACMYy1Zfnu2NImSG8I/J6FWYhPgPQBtPiN+aM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NIvKm2GOmUg34V61BNa6gqXWwMrsVQLcgO81xICclx11PGK/aJBNc8DvY8EZbkDqsh/R7n+GyjwfGXOYwKTP6dlOq4LIVJP/XbL5b3YLxY3He09+1jnbxMqBuBDilamxVhLYd7WbXybZAyPE6zfqlBKXlmiNiV4ah2ptBK5sFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E+DvwRIS; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717495898; x=1749031898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C9QZlpACMYy1Zfnu2NImSG8I/J6FWYhPgPQBtPiN+aM=;
  b=E+DvwRISWsIp+FV/u1kORVbvpHp2sBvN7oIIjGDxK+46ugBXY7bNHKSC
   3OK5wYRj9WMWmb55fBFjc2JLq3Ic9PoIN4fhu4sLAzIp5wJJz778SLIMM
   BIfwPYIfYQdHd57TptjkCwCIvTfhKYbBML10zW9EphJjmcu6oYz1IulfU
   7jAYmgrdgatau5DUvjlcBAEkV8a/XzPfqiUmFA1JSzDfUkCFIrCl13aM8
   3hcUj0+JimlYaC00p/s0TIaPDxhjyCwcSoaVOip9SRomyAFJ9ff3qshWD
   mhT6LpS/XluSbdbvQYOFuC1QNNF71/yZ+6s0c496IHE6ZmKLPzzozVCx1
   w==;
X-CSE-ConnectionGUID: wEzRrHHTQXqTSqyPNngmpw==
X-CSE-MsgGUID: VmTWgr6UT6GmI5MeZ9Sbbw==
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="257789211"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jun 2024 03:11:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Jun 2024 03:10:49 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 4 Jun 2024 03:10:47 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <kuninori.morimoto.gx@renesas.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH] ASoC: atmel: atmel-classd: Re-add dai_link->platform to fix card init
Date: Tue, 4 Jun 2024 13:10:30 +0300
Message-ID: <20240604101030.237792-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The removed dai_link->platform component cause a fail which
is exposed at runtime. (ex: when a sound tool is used)
This patch re-adds the dai_link->platform component to have
a full card registered.

Before this patch:
:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: CLASSD [CLASSD], device 0: CLASSD PCM snd-soc-dummy-dai-0 []
    Subdevices: 1/1
    Subdevice #0: subdevice #0

:~$ speaker-test -t sine
speaker-test 1.2.6
Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Playback open error: -22,Invalid argument

After this patch which restores the platform component:
:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: CLASSD [CLASSD], device 0: CLASSD PCM snd-soc-dummy-dai-0
						[CLASSD PCM snd-soc-dummy-dai-0]
    Subdevices: 1/1
    Subdevice #0: subdevice #0
-> Resolve the playback error.

Fixes: 2f650f87c03c ("ASoC: atmel: remove unnecessary dai_link->platform")
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/atmel-classd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 6aed1ee443b4..ba314b279919 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -473,19 +473,22 @@ static int atmel_classd_asoc_card_init(struct device *dev,
 	if (!dai_link)
 		return -ENOMEM;
 
-	comp = devm_kzalloc(dev, sizeof(*comp), GFP_KERNEL);
+	comp = devm_kzalloc(dev, 2 * sizeof(*comp), GFP_KERNEL);
 	if (!comp)
 		return -ENOMEM;
 
-	dai_link->cpus		= comp;
+	dai_link->cpus		= &comp[0];
 	dai_link->codecs	= &snd_soc_dummy_dlc;
+	dai_link->platforms	= &comp[1];
 
 	dai_link->num_cpus	= 1;
 	dai_link->num_codecs	= 1;
+	dai_link->num_platforms = 1;
 
 	dai_link->name			= "CLASSD";
 	dai_link->stream_name		= "CLASSD PCM";
 	dai_link->cpus->dai_name	= dev_name(dev);
+	dai_link->platforms->name	= dev_name(dev);
 
 	card->dai_link	= dai_link;
 	card->num_links	= 1;
-- 
2.34.1


