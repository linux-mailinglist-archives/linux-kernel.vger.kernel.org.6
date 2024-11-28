Return-Path: <linux-kernel+bounces-424851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85789DBA42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF7B280DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99619D06A;
	Thu, 28 Nov 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XF4reawt"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C71AF0A5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806782; cv=none; b=l6DIycc7wAtleU2SEief8JxZ8SDITQJHNnC5Ko6TpkQ6FfUy0hSqjd7Q/isGxhMRFtHlK7q8VVL23VZsGOQI9CeuotRis3LapAURvmeh01hHqGGdDLaVOB9OuDv4vjgDzlzQyySTjl/cm9saNphnj7Dn/zaayk7bNW95NkWjQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806782; c=relaxed/simple;
	bh=jZaFTESlQqgjM5/g0OhUkZlvRLk9iLWdZ26ik6OqKKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GKwnotSje0UeOaq8zqGUzIOSzWx8fqJLurFjXJERvrKtWirH7vAom0mkkBDIKc9i8PliNU5yiuJfOSGL+F2mCiM1N23zfZNHptrhpVZH9jvJ7/u1F+49mtoLTP6tiNakgQgIKH7F8tSb1F4UzUXhb2Hd/LuUITxgv4US5opX98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XF4reawt; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5cfc0004fabso988330a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732806779; x=1733411579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSh6QnXu4JErwCzUbAtARbKC+82Ed2BaKiOEpcdsIeA=;
        b=XF4reawtiXCPTmMVT/lYMnk9pn9ThaxuNV0qg5WHnauWCJd1cYd8YoQkFX1c58owPJ
         R842aUommUSCJ+v5x+idcTSLTe4Jlfcsl99jXFL+yWjW+egqbHWLly7lEpeScyfHYH0V
         fKK4Tov3/BTuilNttqh2gTbCPZ+hmfTZPlilXOO22YwvhV6nlTiGOuE4FLXMjDk5ukMX
         +kEJK5RMLtXmYovfy2WsUfyayyXYUNqwpITaPVMejd9KXGMbVP6WJIaIr6fCVjnCsEaa
         ymshp1fnscMb+5APVey63tKzj+U1lfEZYynD2Y3rdzefv90E4gXtswTmkf9Pdxbdum99
         Iw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732806779; x=1733411579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSh6QnXu4JErwCzUbAtARbKC+82Ed2BaKiOEpcdsIeA=;
        b=vYEyl96E2r/PMAaas8sKuUW5Tnnd5PK1wqy/mfOzalaBEXRueYW39nMM2fV6agsPq2
         pIOdWdnYa3RxK9Vhi14em370fak/08wDAgf0aTdo3fB6bK1oMdYqTflNmOlalqujih3V
         F1VOTR9lgeh2asgvqqWgk8XMJC/j8+CVohHXMT86He7H0ypy+D12YGvdi2r5Y0geXZ69
         Xdzuf1DIe18PydnOyZsZ/A96eMRIIg6P1qrWZesU07NMz87LkjQNRMHQdw2Ww2evG6b0
         KxXuaDfOcvDe26bCgwqOvW7haI5Kg/O+ty6BFejJaPnCnhw2ns/V19wdweAFhqR+nAoH
         JFpQ==
X-Gm-Message-State: AOJu0YxaFs+j0bDstmRzKuSU3m6EWW1/RVd+hC9Ht27icF3UJmyOyjK4
	CTT4ZosYGmLb7idLXhIsswoedFt6UisyRLLy7M/EEssCVJKA0bcGgA3Utkdssxa4jpGUfW5ERnb
	lhO1+7qHsk+Qa/LRhQkNFDiQCnTNUhAuTPNdAlqPPFdyI0/v+d0sZaZNaRLBz+q8dWWJCRspFrd
	8RZ4QZ5Fl9I+idRSz02F/KpJpGd/eRYeQUs1HJHJnAFK29Q1vVt62OQxPj
X-Google-Smtp-Source: AGHT+IHq0l2qnpUzY5y+BAxA1IUd+Zn8AezLj6NB6ygY7wGAKaYgh5TGRFSFknDmKi+RWi9rn7z1x+pjDOUKr1o=
X-Received: from edfb72.prod.google.com ([2002:a50:9f4e:0:b0:5cf:8596:18aa])
 (user=mmaslanka job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ed4:b0:5d0:975:b1c0 with SMTP id 4fb4d7f45d1cf-5d09516035amr4028779a12.11.1732806779218;
 Thu, 28 Nov 2024 07:12:59 -0800 (PST)
Date: Thu, 28 Nov 2024 15:12:32 +0000
In-Reply-To: <10062d09-34c8-4e53-b5d7-f96a5b19f6f8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <10062d09-34c8-4e53-b5d7-f96a5b19f6f8@intel.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128151239.1666582-1-mmaslanka@google.com>
Subject: [PATCH v2] ASoC: Intel: avs: da7219: Remove suspend_pre() and resume_post()
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

The presence of a plugged jack is not detected after resuming the device if the jack was plugged
before the device was suspended. This problem is caused by calling the
sound/soc/codecs/da7219-aad.c:da7219_aad_jack_det() function on resume, which forces the jack
insertion state to be unplugged.

Signed-off-by: Marek Maslanka <mmaslanka@google.com>

---
Changes in v2:
 - Rephrase commit title and message as suggested in v1
 - Link to v1: https://lore.kernel.org/all/20241128122732.1205732-1-mmaslanka@google.com/
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


