Return-Path: <linux-kernel+bounces-424652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC09DB789
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5012E16345A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0499D19CC11;
	Thu, 28 Nov 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="00I8nUBl"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DE156661
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796861; cv=none; b=lap6CgrPiOtWFdzR4VTYXSsyg8BOg/OOvAIhYXJ3Togs66oAAnZ0YSfiln7GD/C94CFX8OCpRGkvOT1CdBOYLobbamqugLT3HiyWYMqhDro9QbogItzs2pS3ah8wDBSrL9e/20HfTr7DTQdazhWSpcjZ7cDwvoRzgfByDq0NWuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796861; c=relaxed/simple;
	bh=rnOC0uH0wL+DXjz2H6rqda5uQT4oyuQ5UJk1N1XxOts=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tXi9O/pfzEWxF1TatkDdrrkeWIE/DTRKSN5gaso2kbSDZBK092xdJdkTGBAa8jNFWTAk9EFPAR9dwW1OVVjYecgsJP2MxJk4ckzbmuaYbQf8b9MycfjE9uoBEQUX5QpPpDNdpeS9buIP7UgkQSJoI5ClKiFefQgw2nEDlaxaI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=00I8nUBl; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2ffc87a45cdso2626151fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732796858; x=1733401658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hHScKB5wW3lYyaHNo3U+czR+30FvC0SvhNqkl2ETsUM=;
        b=00I8nUBlWoCUS7ZdgnWeqUs+/nrJcN5JIuFNuVuXLJGpsitE/38wQ1CWxv6Cs2yjly
         XVhizOh5qVpxE86fDIipu8Sst+NwfpCukGKA7aNK6lcfYLZ1rADbY9/ve0MfadnTVSuu
         0h45v8h6tr/UX4oHFvzrrZtZbRbFAw/E2RgEYXQgRA91hNw/SIXvE8/Z4r3kw8PYDiat
         hWI8FmaoqLqqFWx5t9FAxH/o3XVt0vcUKYR8aeegvvqnpF13YHKj+Zsh15MZWStpkx3A
         XPGM2RJsDYAtkCAX5zqY8d0IlGo+M3VL5CGqtUD2NKmSG8f29z7lBaevwLMNldtlnllm
         5qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796858; x=1733401658;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHScKB5wW3lYyaHNo3U+czR+30FvC0SvhNqkl2ETsUM=;
        b=jgpyyyG5XH8nhwENH513XVYrEo5UhIXiWaSjlFRBAvf8oHmxghSS6U8pjpd0AIopOD
         msvnVNgTR4L0bNXoh+FpEAd9dTk3pWFamDUT5kMNz2Ya/kuunzlTGwDRpPed+vTzlPrP
         01RKysYVJiEX/UhnF8P5OP1LfV4kK9kMM1iVGkQCBXAn5A1fVdO4WARxQaYvpAJ3+9CT
         2uzlTsnQ57Uxz9f3TRgUpw/R8uSzzy91/dh3yIewJ0wMDh7UwjudfhmB7yD8V4JIRDeZ
         ArF719jEfR4F+GBy3MOibMmX+EatcmUVeI61/J5Faze5YP0s34nqEiLotNNCCYFnYMf7
         BEVQ==
X-Gm-Message-State: AOJu0Yyu5uC80cZlpp9SFqCcBge60pRGduIPT7hW66UibSfhzDtfV/Mm
	E/bbf/nhd4XTzHef3k5eXK3ERN4Ns+x9TKpn3uCF3IxYwqhdmLOxmTsCIXsT7mG3ZykP1QXHgGQ
	wVVy0CQDi2/oa+rBIYMa88UZIG+2xFeYpWKqOAVDw4WKEJsMLmNhOn4hxSF0kPB1HbMgt3i7hrN
	n1nSDcgxtnq6/SWQL9+S3iuHA3sf6ghqAcxYc1pcjg01fS8J+i6Ulhdwju
X-Google-Smtp-Source: AGHT+IG386o/8+zflhUeB+C04ILmkl0WNRST1JorMAgcHdNp8s7vWtrSpAiv3PMxUfmbfhdDnCwCZO5eIeiScQ4=
X-Received: from ljqn20.prod.google.com ([2002:a2e:bd14:0:b0:2fb:48a0:ba68])
 (user=mmaslanka job=prod-delivery.src-stubby-dispatcher) by
 2002:a2e:bc22:0:b0:2f9:cc40:6afe with SMTP id 38308e7fff4ca-2ffd6043995mr41060741fa.14.1732796857921;
 Thu, 28 Nov 2024 04:27:37 -0800 (PST)
Date: Thu, 28 Nov 2024 12:27:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128122732.1205732-1-mmaslanka@google.com>
Subject: [PATCH] ASoC: Intel: avs: Remove component->set_jack() on suspend/resume
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

Removed calls to component->set_jack() during suspend/resume to fix an issue where an inserted jack
is not detected after resuming from suspend if the jack was inserted before suspend. This problem is
caused by calls to the sound/soc/codecs/da7219-aad.c:da7219_aad_jack_det() function during resume,
which forces the jack insertion state to be unplugged.

Signed-off-by: Marek Maslanka <mmaslanka@google.com>

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


