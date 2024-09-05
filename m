Return-Path: <linux-kernel+bounces-317242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D293696DB5E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C817285831
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C831A01AE;
	Thu,  5 Sep 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ywswRn4O"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0919EED2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545621; cv=none; b=J/ulc0jLEA0rL4XCnk3TR6yNJyBZ44tN59pVtV7C7tbFZhqncCPU59zVn6EIunBms9bG9IRw9VJSW6wvdHopxv6HOpMoqizJN1OsB1OAHHiUX3kAG0WeOPIhpnSq+m27+98vg/1zv1e5g6AM7DIjMZHHOUr6zxARF6tilW0Wdzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545621; c=relaxed/simple;
	bh=Xv0vuHB6OmJEPDWj7YbALy0svxpRq+MGIQhgNIVXe28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQY9EGCF09tBamxio52CQjbhTfdAvUM/wwiXC/DJx4D6NtlG2vdJ5foGTiHziIOmD2SnVXLyYbOKAtc2zgi1zHVsb+o9VAuqKcVnGzhxxZ130EDvfOHvMvS/yXiLFgpLWobrnyQTifAOR2XtThjTX8XnfRntCvoSyDbSalT+fjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ywswRn4O; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c1963cb6so513352f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725545617; x=1726150417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcCu+DWFXbg2fAQ79jKiLK8pzJONU6/x+rmv87WbABM=;
        b=ywswRn4Or1nrAsGScSkmKV7oXwr0FVzkPl4SkzwNhksSKMjCPIVybeZLvvdZKHFnoG
         euQxr5EAI0eGZm9ulXuJs3v5+xOGtV5cZr2TkYjeBO7wBnNpAAM68E0Vrsw6aUGvQEzW
         Z8LGuGHzFEAYJQ86f6l3FMqZuBCNYlOsIO/E7gW9U9IcwYauoaWy5dAU4liCzipyhsy5
         MrkbvZAL7WfrpXfk6tL9L7Nchp4QmlJmctOd6t9cLT3TiQP9yNsRdC7lChNbyMDG4mer
         s4oYFEYfMHGXOg46gZ9EMZPvKffBFNZycIpF0xhxngf9OegpTp6NBpxmSmER3MN9DZ1a
         soZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725545617; x=1726150417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcCu+DWFXbg2fAQ79jKiLK8pzJONU6/x+rmv87WbABM=;
        b=IuRmXr0yHCC3B1WP0kkhfiiKQAOYA7UcljO+Sb96PXl2398s8FY49Xe8eYuBYDjCib
         gF0/yaD7xdhh5uwKBwK2QxQ4wYTsMBk6mee9S6okt5vYdC0wh4lxQkOAzRLZDEVh5rw5
         o5zr+Gz9wPcMde/JeZLWo/i2/0zW/OmjlP+mHCoJgPoou8evUevi2Ij0Ju/hgN4F2wLi
         L+T/oJaiYscdYVXA5ZjXK1lbMl1BBss5SX/6ox0G5yzYo4GBhrQvLVN4q/+pIAf+tThW
         G7Q6aXTeZGjfsi3vNm6zmZIRSNmEJk2wayY8T5gnJsttWH7fzeYgWXa6JGlEk0bP6V4Z
         8QQA==
X-Forwarded-Encrypted: i=1; AJvYcCUsw6hKjF14R6hRdEV098lR8t+SFKgqLf+10mHlHzOfBVHVHYT4AI7omXtJWr7HC4jRrgWIbOndYKe+96s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUTpEb879OKtZwyUQQL2gbrLz+q+WP8WgukRErEzOlhvrm3sJ
	nUwFPCWtf5YW7ysboHATPUJ3YEhVW66cMAS6AbtJ5oS2TZ1qKYN9775sDkDZnTc=
X-Google-Smtp-Source: AGHT+IFIEHR55riZlgeQGJQjXuyOXmmTN+5SiNQQq3UpC9AB9eRnK6WUg+y3HQedvVtwF3WTVV2akQ==
X-Received: by 2002:adf:fa4c:0:b0:374:bb1b:d8a1 with SMTP id ffacd0b85a97d-374bb1bd9c6mr11130169f8f.13.1725545616938;
        Thu, 05 Sep 2024 07:13:36 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:4763:343b:23f3:f45])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749ef81146sm19514621f8f.82.2024.09.05.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:13:36 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 05 Sep 2024 16:12:56 +0200
Subject: [PATCH 05/13] ALSA: hdspm: drop SNDRV_PCM_RATE_KNOT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-alsa-12-24-128-v1-5-8371948d3921@baylibre.com>
References: <20240905-alsa-12-24-128-v1-0-8371948d3921@baylibre.com>
In-Reply-To: <20240905-alsa-12-24-128-v1-0-8371948d3921@baylibre.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Cezary Rojewski <cezary.rojewski@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, alsa-devel@alsa-project.org, 
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=Xv0vuHB6OmJEPDWj7YbALy0svxpRq+MGIQhgNIVXe28=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2byBQJXpw0tKm9S1aoNQuw0gFMk22/TxwdNAJ
 DQo1OePFpeJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtm8gQAKCRDm/A8cN/La
 hb6CD/44tlADSXvh8LtznvSCnCRWDjibNp3ZPrngVla5rHZENvj/3bhJd4z2yqP+n5D9sGXGqDG
 4xNTMjbtLBxWXfJQTNFD1EkV6IIjuGJvW0i5NwXFyIS34ysoOE0hI9Q8FqVDCddEonzuY7wcjy5
 RnJBiUvZoKOO9WcpWEP3gm0VGniXudhEWa0SBL7G3ojs3j7TOXDF1Mceym7wTQKYJGZlZDCUohC
 H91vxd6zdshPH/qzyMI9jqGpjwkqY2lpHww/KZ9tQqPpy2VS2MXPgl4llQyPpIxxvbcQj56iZcR
 CsjdRZRWF4PE/aTCl1T8mbSUU/XmInE7C+yqydfXqxp0jd0vFsy8ZojjGp6JDfs6NgGn16EYbS6
 ViY4U2XOqdcXgXkg8ttNgs6JaEhjx1XrkRddp7NYnj11EVJIwwo/zODYBuBCYZJNSctuqG3MvJG
 IxM9AEefJBxIgyfUskHexjjJBa6NJhU/6ux0FNEN/ukrTRbxmCOFacv1jZ+uqo2BL71xYSl8GNq
 oAny7kUhtzHYyMG7I8Ifp0TH9qEtXeY5QApAGE+oIPYKpe8btMam/nMJCyBhUY7PotLSrYd97T2
 yQ+H8YXAew9HF16sTUciTp1/QB5QSU3YEVOEMQOpwc/MS7pQvwWhwZQonuGU/QQHJOQwvSsMelf
 DIHwWZKP7oiAz4A==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The custom rate constraint list was necessary to support 128kHz.
This rate is now available through SNDRV_PCM_RATE_128000.

Use it and drop the custom rate constraint rule.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/pci/rme9652/hdspm.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index c3f930a8f78d..dad974378e00 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6032,18 +6032,6 @@ static int snd_hdspm_hw_rule_out_channels(struct snd_pcm_hw_params *params,
 	return snd_interval_list(c, 3, list, 0);
 }
 
-
-static const unsigned int hdspm_aes32_sample_rates[] = {
-	32000, 44100, 48000, 64000, 88200, 96000, 128000, 176400, 192000
-};
-
-static const struct snd_pcm_hw_constraint_list
-hdspm_hw_constraints_aes32_sample_rates = {
-	.count = ARRAY_SIZE(hdspm_aes32_sample_rates),
-	.list = hdspm_aes32_sample_rates,
-	.mask = 0
-};
-
 static int snd_hdspm_open(struct snd_pcm_substream *substream)
 {
 	struct hdspm *hdspm = snd_pcm_substream_chip(substream);
@@ -6096,9 +6084,7 @@ static int snd_hdspm_open(struct snd_pcm_substream *substream)
 	}
 
 	if (AES32 == hdspm->io_type) {
-		runtime->hw.rates |= SNDRV_PCM_RATE_KNOT;
-		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				&hdspm_hw_constraints_aes32_sample_rates);
+		runtime->hw.rates |= SNDRV_PCM_RATE_128000;
 	} else {
 		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				(playback ?

-- 
2.45.2


