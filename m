Return-Path: <linux-kernel+bounces-425068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98E9DBD15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201C2281C31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6CE1C2DA1;
	Thu, 28 Nov 2024 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfIRmogW"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3711C2334
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732827169; cv=none; b=qCclVck3dtQ8opCnp4Z03KItgMlyNuKub2kEEOJ0XbwFxEbo7/QLrIV3Nm7tOCfOP6wemnBeAqKmkCrSg35RFM6mQT8y8bhu9r/HHNxy61BbLOwIxsx1rZZrYoJDQhr6lUHX+uSld8KOPX/R1s0YYIQmYa1xmotFNETjhsDw6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732827169; c=relaxed/simple;
	bh=I5YCLO6EscYmRHuFv26CuhdZFgeTmhHZGaOy61Yx4H4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kJrS/d4gqg0n3ibpJ/nzrJMQybvqFPCQN97eqFKbH5ywE+mtdma9dWpNUGohJrxGZmP88Iqyqf0+1Ch2FwwajCrX9BKN0DsPok4VzWWdIphT/OOUAcReqUqAURr4JqYGlsIjBEjwnysgfl46evzf+qgK9uk4ie7EjkmtoNusn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfIRmogW; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa53f3b3256so60559466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732827166; x=1733431966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qob0FBpsUU/sx2eCBfCzGQ8cEgowX6VKZMzDfM9xuIE=;
        b=rfIRmogWeYQX2g0YozyJPx3Cba+tx6O94LzoYQ7m5/seN/0aAePthcHN+7XBdEryOW
         U9a5DQnXYQCvu9O3ab8whWG7jTbrnby8KXZfqcd3CwALR4gVX7R3aHxGydGTKm2/I5lB
         b0xxj8I4Wvg+Gf3tGU6//CeFCYUDHfsszlsDIdvaf2Hm4NBtt93wb1D1QlZyR0D5MKy8
         uB04m+5VrksjuIzZkRPGauJt2qOLet2Jy8JwEb7DiDK6v/XYTEesHZ7dgYeKTaCF/iWB
         YMr4Aw4eATp6FLa1i5K8miUyzrRvKcCmy0g3VfPwCaWbweCuGZNg+n8fVJDT3O9ek3HE
         VhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732827166; x=1733431966;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qob0FBpsUU/sx2eCBfCzGQ8cEgowX6VKZMzDfM9xuIE=;
        b=tUq9C5TJrf5WVmt1S+CdweiiNRr1KyzTyVR0sjisRrlTuRyFSmipmGci47rNWzMwda
         BMpypvJNsKgXKvalvutpsRf2Cw0RuRlIUI2rbqy6r0wnnbn79/kDFMb8mkw9tZSBKm/A
         M1R+LbKmUQ755jeWa3ssdMYXpPV1z04+rJIOD0W0D6OKcOcJyVliN5AYLHtmWamWa7s8
         2htfaSOfCBqPXWYdIU0PjQzwhwn8z2P85DMN8MSdLoXB9AcUXhet6BWx9XqZEpwzQP9U
         apov/0r3E8EMBkV1WE1ZqFIgSAT7F68a0uqYjh4JlJ1whJW0lEkNA58cz/TimpAvmE0R
         hlSw==
X-Gm-Message-State: AOJu0YzZNJlGVjrYkoqr3g3f7+qvlv+7J8Ytpeqf+ZquaMVAlHkz48Bo
	pM0yKkEZu3NsE223kJj0ZAyFu+FfUlzRdkoET5LrYZ4XQTB4kIv6bAZP6Z5qeVWXr38gLRz5NN2
	f5YbFsT0ubFXkUytKCKfW0MYfzTzXgIk7GjMBZnoGu2/Gg/Ny4ssPANHRPjF/2pAweTuWhCCcB5
	hmSjllfRhv0InpwhZ2BpFnlnG58b8/aNKFCsMtKNcinrPjHdbwwwkoxQfU
X-Google-Smtp-Source: AGHT+IHBgsLr3pLJH/ACZefffdWeb80QzhCBRqY4vhCfqkMxxEok2tAWW+nYrVbcV0Ijh3nfSJvgonr+4y2YvgM=
X-Received: from ejct1.prod.google.com ([2002:a17:906:2681:b0:a9a:bf43:6c33])
 (user=mmaslanka job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:b392:b0:a9a:f82:7712 with SMTP id a640c23a62f3a-aa5810664dfmr643677466b.52.1732827165635;
 Thu, 28 Nov 2024 12:52:45 -0800 (PST)
Date: Thu, 28 Nov 2024 20:52:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128205215.2435485-1-mmaslanka@google.com>
Subject: [PATCH v4] ASoC: Intel: avs: da7219: Remove suspend_pre() and resume_post()
From: Marek Maslanka <mmaslanka@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marek Maslanka <mmaslanka@google.com>, Cezary Rojewski <cezary.rojewski@intel.com>, 
	Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	"=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=" <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The presence of a plugged jack is not detected after resuming the device
if the jack was plugged before the device was suspended. This problem is
caused by calling the
sound/soc/codecs/da7219-aad.c:da7219_aad_jack_det() function on resume,
which forces the jack insertion state to be unplugged.

Signed-off-by: Marek Maslanka <mmaslanka@google.com>
---
Changes in v4:
 - Remove redundant spaces from the commit message
 - Link to v3: https://lore.kernel.org/all/20241128155926.1774625-1-mmaslanka@google.com/
Changes in v3:
 - Fix line breaks in commit message
 - Link to v2: https://lore.kernel.org/all/20241128151239.1666582-1-mmaslanka@google.com/
Changes in v2:
 - Rephrase commit title and message as suggested in v1
 - Link to v1: https://lore.kernel.org/all/20241128122732.1205732-1-mmaslanka@google.com/
---
---
 sound/soc/intel/avs/boards/da7219.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/sound/soc/intel/avs/boards/da7219.c b/sound/soc/intel/avs/boards/da7219.c
index 80c0a1a956542..daf53ca490a14 100644
--- a/sound/soc/intel/avs/boards/da7219.c
+++ b/sound/soc/intel/avs/boards/da7219.c
@@ -211,21 +211,6 @@ static int avs_create_dai_link(struct device *dev, const char *platform_name, in
 	return 0;
 }
 
-static int avs_card_suspend_pre(struct snd_soc_card *card)
-{
-	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, DA7219_DAI_NAME);
-
-	return snd_soc_component_set_jack(codec_dai->component, NULL, NULL);
-}
-
-static int avs_card_resume_post(struct snd_soc_card *card)
-{
-	struct snd_soc_dai *codec_dai = snd_soc_card_get_codec_dai(card, DA7219_DAI_NAME);
-	struct snd_soc_jack *jack = snd_soc_card_get_drvdata(card);
-
-	return snd_soc_component_set_jack(codec_dai->component, jack, NULL);
-}
-
 static int avs_da7219_probe(struct platform_device *pdev)
 {
 	struct snd_soc_dai_link *dai_link;
@@ -257,8 +242,6 @@ static int avs_da7219_probe(struct platform_device *pdev)
 	card->name = "avs_da7219";
 	card->dev = dev;
 	card->owner = THIS_MODULE;
-	card->suspend_pre = avs_card_suspend_pre;
-	card->resume_post = avs_card_resume_post;
 	card->dai_link = dai_link;
 	card->num_links = 1;
 	card->controls = card_controls;
-- 
2.47.0.338.g60cca15819-goog


