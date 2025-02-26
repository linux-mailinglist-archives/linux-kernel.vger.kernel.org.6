Return-Path: <linux-kernel+bounces-534412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5ABA466C6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D05426F15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5726821E086;
	Wed, 26 Feb 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBGKO0eO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1B3FB0E;
	Wed, 26 Feb 2025 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586764; cv=none; b=YgfNbd6r1cGUsWW/TpoQbF+ffsUcMIvlJ+D9Vj56LygUU6M60vrUOydeSvNAMfDDh5vf8KNOFHkDNudwlOKe9PdRKjPx0uvCfp6QoLiJ1mwoniOVvYXvxWA3hF72DeX8oV/hxO9r9w0sm7iPA7RmGligLDICWuyp7ip8+rGxMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586764; c=relaxed/simple;
	bh=kVAJWJ1n9B5HqAXvAOf2QCSR41y110AB9N77022F3hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rgLEiSGDDtpIfNLfMIfpBaHCUTqHenpNGNzxTzluMr+YeZp5QOz0MEstk5SV2znY3ZsCRHKfeJDpexv+5uDNIuIOh4kQz/9/xedRGr2R9h2vBbYgXaS4T/v9m7GXD1Y9mCvvdrEua9WZ65SGyVxijUnUwf4MtXhGKvcKUcRhHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBGKO0eO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439a4dec9d5so267355e9.0;
        Wed, 26 Feb 2025 08:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740586761; x=1741191561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t7oIbL6Oq4nSHg07LEL+0/DEW8r33JxAc53XxQi3IME=;
        b=NBGKO0eOuTOSDlD8sla8qt2JXaeuCOPy60ZrVKFXgq/OAzwxNkIxmUY0fNnVMJpWKX
         /3O4K0UhzDnGc9ccKfVHQ76S/DYlm7jPQMWfK+tYRdYeLoz6F/DcvgcnTZSxKKSnlTWn
         lywLDeFsWeX+rjpymlPP7RVsjm5w61D8RcV47g4n4Vfp0LyElgoOBzdvSVKMt/htvA9i
         tOUFlB4UNQekGbEDkup5BLZpJ1kdqEau7u+Mhf6y6+Qqg6hVriOekyNmKaFBzCXaKWtF
         XIj62gKEECLN+qqI04ka4SjMh5VSvPhMNtGLxGKjNY74kzllp2I3swu4EnFZpULtejjy
         illw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586761; x=1741191561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7oIbL6Oq4nSHg07LEL+0/DEW8r33JxAc53XxQi3IME=;
        b=VFjLeUwynXK0s9QuDmYSbt0Cg7KhqBwJeRTTRnIwwIXtbE3WSA5sfvkR+K2Z8QoWoV
         dZFWYOh+k3LDmm64+IwM7DOZJzepKBPiZ86EMszBK6MoVqXehIheno99TfJRJ9/pH6Y3
         Lk5FuD9HPBTw7b2Tv6o8VBsimDscG3FCRCTFGcfMWJtrNc6QlM1f9zQTiFggoUfcBYW+
         OiJoQOHnTZwANhEaHOl3xzy9okJGs1GM8HPQLGDhTyMGKCFZDFSGlBlbsViEjzAjVF9F
         gbI5JVkssPwa4h4/I1UYdzcr130c25to7+RtYlyKFglrDAwYqbX2BtyHsqtxtQExeBNO
         OC2A==
X-Forwarded-Encrypted: i=1; AJvYcCXZyFo40EGUT6njLCk18OdKFsXHz5Ltrzwa1Ni8rxW6gH0Mp4s6D4dziDeCCMUEpMNlwXrA8Si1tmSoTNU=@vger.kernel.org, AJvYcCXfrjgepbWw6UfUc18LpcrXjdj7yZyjlD1noOseYjwxs3XkUQbLUmHH8HxfdisL22pEOBJyM1TujeVyh50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81AnIDTlClZwjoIIq5gAAAIAnheO9LXJDax2nzm2LeWbbu1uV
	tJipGrmVPO9qsRuLbHUmxfyEF69wXpEj6MwYfmMz5/qM0HVgk3TV
X-Gm-Gg: ASbGncvvU3oL5oW4WQBGHno7H70QL7vlaN6yt44cTJOWZDW2i8dgzr3EAVUKeVjBdLl
	Ngd4ziTAZBgqzW2h2g1Z3KToGsWnx4SRyw/l3KiLUTWfS2WZO3L/hveMyCeB13yp29vZ6hqgNxZ
	tfsrI+Z9rAgyAp8/nNQ3RbCetNfjVgwzdLm5dlpawavfDxgarfu1tyo3B57GD5oHLjj1IKflcZe
	QvPFFnrUbrujPg6H26Exg6qxXBfnVDfdlPu6s/r+iqENMcLm+GBPn/zfZYPupQjq3BOZynYDW/i
	SWVUqVby372SYs32skJ9rSwZPDU=
X-Google-Smtp-Source: AGHT+IFCHrP0DmNTDiQaKF5lTigPtiLat3d0zHJOGbPCRd6J2ldYAIFvsJPwNG1s+zkxJZVh4LfRHg==
X-Received: by 2002:a05:600c:154e:b0:439:a0a3:a15 with SMTP id 5b1f17b1804b1-43ab0f3c907mr103513685e9.14.1740586761203;
        Wed, 26 Feb 2025 08:19:21 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba5397d2sm27064705e9.22.2025.02.26.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:19:20 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: mediatek: mt8188: Fix uninitialized variable msk
Date: Wed, 26 Feb 2025 16:18:47 +0000
Message-ID: <20250226161847.567160-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable msk not initialized and is being bit-wise or'd with values
in a for-loop, leading to an undefined result. Fix this by initializing
msk to zero before the for-loop.

Fixes: c1e42ec04197 ("ASoC: mediatek: mt8188: Add support for DMIC")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/mediatek/mt8188/mt8188-dai-dmic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c b/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
index 4cfbcb71d2d9..adcea7818be2 100644
--- a/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
@@ -307,6 +307,7 @@ static int mtk_dmic_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* request fifo soft rst */
+		msk = 0;
 		for (i = dmic_num; i >= DMIC0; i--)
 			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(i);
 
-- 
2.47.2


