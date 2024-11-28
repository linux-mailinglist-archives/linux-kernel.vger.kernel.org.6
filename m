Return-Path: <linux-kernel+bounces-424899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910F59DBAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EC61644C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02411BD9C1;
	Thu, 28 Nov 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjrDBsu4"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7B3232
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809627; cv=none; b=tVy8wqzojyA2CJHIHQxeXn9xGrTqyQoBhoq/NO/Q6snMebYibFZ0+v5g1gDC1PUO4oBDfgSmI0Wy/6OpMCFw8IHNHyKkTy4eP9zyDgZFrTLgtUB4pdfaVm8rGAa3/Adb9OCOIqth0bDtJlSGFOs2lD56U0PNfZ6HGTLSMliqAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809627; c=relaxed/simple;
	bh=CEPCLyGcP+5TlVcrY9sskKx8WTDeCpweS8+NStxhbuw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BbAmXbrOY3k8F4qajelnlfpPgAjn6x+sXicqTC7cA/s30ZYN6DiPmQroIyIyOp3uKyy+S3odiBEA7hFXAOgdd1deynL9Z1dX9eqauy5EhEvYKWzcgf15mGLgBDWJ1L92C/pEzGB6qOc7YvgsZgXlC+lut0k55rsospBoS6qIIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjrDBsu4; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5cfdc574679so652763a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732809624; x=1733414424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HCg1Km73Sbp4/xSTNme8D+2Uw46vaSy0dpia+RIb3WE=;
        b=VjrDBsu4UMXfwI2w7VJHCPDTNjl2Isq9XJYFX6K/ZOygu8fXUTkYwMSyIXdcAaqe5I
         TXUxJGcDGxU/D08eatGJDMp0UxD29VHKDi4qBrNvfc97k76XEajBOTO8ENTRaQY3x9PO
         LmbCybEVz8j6fe7wrC3V5uHgkLW0JcaWYUIyXDkRCOhkg1IDFxfZKD33Tc+KNKDMfJrx
         6jFZZFAVuPDYk6BOuhR5fSmS3mdF4+92+XAJ/ES4SE86PLDW/7svqq0aGA04o2zW/GBv
         NUKcY2yXx9z6JOU6EJYLjuBbUZ0fgW3c4daHfFfOHNwF6I4RbYDmgfJ2ut+Pz2n6LxP+
         o5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732809624; x=1733414424;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCg1Km73Sbp4/xSTNme8D+2Uw46vaSy0dpia+RIb3WE=;
        b=p0CtdjP+NBk92syW8Lgqd/3W+lBGialkmnZbENGq7CDdnEXNpzc2YxKq+c3EnImS1N
         BoqXkK7oUcekp2gy1Z0cAW3uXe1z0GoLLZwv9ZxEyLgZIfb+oNdF2IngIAMpoXDWpTzc
         YKOjlTQiuCrbuPI3sOpLUqkIJzen0udZTANjU/PIXO74PXPSo2a/MOijTyzPKeRlE0cI
         +jYs8XQSakEbZFvzhVz++bYJ4KNGT7rdFyG8aysm0r9vTeQuLsl3LfHnIw3fnz6DUR2F
         /MZVY/tq4qfKYyUjWpILRfJ+ZBwxGuXX8Z216J5KMIRqy7n29AxDXDRVNZ4VOipDtdNI
         MqJQ==
X-Gm-Message-State: AOJu0Yxo02lc52iT5l6IpMB9Kc5rpT+DRGPsFG0eAR5FW0ucZp6zGh3I
	dtkHyy63uMJwf35ugYZUdDu9ZxU7TAe3lJq9VMESLHWJadGgMhVpJvsRBE/89Ir3t0zXfxOleMw
	eZi9WZ46jrCTHRvclAcvaMYHC1XR+JFE9+BmbBdL6J6DM5tY50Z5qKxVSt14YLVWX1V86GLBbIf
	HOx17ikUce0zln6eEl1rg6UYs/YKJuVN/PBI+0fwa2XmF5rS982DMmS6vy
X-Google-Smtp-Source: AGHT+IH7O2F88sy1YkGak+ZTUuWwKlxn8SdhOmaY7RlKSth26WNlQQxcOCfxKgSD/+8oTPB23XqZRw9oivubtks=
X-Received: from edal21.prod.google.com ([2002:a05:6402:2315:b0:5d0:83b1:b8ab])
 (user=mmaslanka job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1e93:b0:5d0:8f29:73b9 with SMTP id 4fb4d7f45d1cf-5d08f2974b0mr4346712a12.28.1732809624031;
 Thu, 28 Nov 2024 08:00:24 -0800 (PST)
Date: Thu, 28 Nov 2024 15:59:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128155926.1774625-1-mmaslanka@google.com>
Subject: [PATCH v3] ASoC: Intel: avs: da7219: Remove suspend_pre() and resume_post()
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


