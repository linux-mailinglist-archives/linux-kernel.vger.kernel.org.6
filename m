Return-Path: <linux-kernel+bounces-527504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814C6A40BFD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F359A189F003
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4E2040AF;
	Sat, 22 Feb 2025 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z1JaS5f7"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADAB1C84A5
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740265234; cv=none; b=uZl4kqii3egtZszwwaFXyMs8eGwKWM9AuT5bHw7NJfJ3nqs7hX24ZRjBewk13UmC6x2bUtffO3RbgRBx8926oC1U5BeE7V/+zd0cgCaoC/+dAP2LmtHhSds91YlQkW0x4Dg6YROq8jzyHju27rGG+l4L8mhWbP839hkLVcVtnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740265234; c=relaxed/simple;
	bh=weyJQCCpqnRXieyV4rRzTMb3+DBN8uIOV9pPVLVw0Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OqA15o+8THl+7C4SuCpKfi+Ge2QRrstsuxkJSyMFaks5qTtcB3mtNnf3Y3FGbYB75VK8JYf6S7BVtAPmd4/xOm3QFmpTtbQU0JPykl8p/YShvRnEwqSKBCKxt2dl9Ce0H4NkDarkMEIQoRrlInsh1sqXARrRkOyuA3FsaujJVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z1JaS5f7; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740265230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G/zujhcm9qd+jkKX4xcD1vV7CqxNf3l6ZPiM36RzLDU=;
	b=Z1JaS5f7UPGwX9kTebeq3QY6oV24hx5IwxxaqoqwtVPpu4G55btBgGjGq5bqlC9laFdrd8
	5DlmI7ebFewcMd8pgO+Plf9OEAoT4lxcAK93kUPLpIwbw/onh5yo8qvLjZXwWbuUeiPAmH
	2p2uuA8+bUxAANaT7beT60Whgk4GU4A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: atmel: atmel-classd: Use str_enabled_disabled() helper
Date: Sat, 22 Feb 2025 23:59:25 +0100
Message-ID: <20250222225925.539840-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/atmel/atmel-classd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index ba314b279919..1f8c60d2de82 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/string_choices.h>
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
@@ -275,7 +276,7 @@ static int atmel_classd_component_probe(struct snd_soc_component *component)
 	dev_info(component->dev,
 		"PWM modulation type is %s, non-overlapping is %s\n",
 		pwm_type[pdata->pwm_type],
-		pdata->non_overlap_enable?"enabled":"disabled");
+		str_enabled_disabled(pdata->non_overlap_enable));
 
 	return 0;
 }
-- 
2.48.1


