Return-Path: <linux-kernel+bounces-174234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAEC8C0BF6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA83B284BD8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D941494D2;
	Thu,  9 May 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lr/LXdoM"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3113C830
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715239897; cv=none; b=T45JPjuQqHaer9baxeqVJaYunTnaBLjETGr36V5/JRBdDu6oyaCe3FNpKalh+9IKlsni0uJsBQO51V707nfbOqQHMtQjSnZLF+MuDWMXI4cV7vw1zYPXcmTxQjDhcN70CUf7RnoTJ7ie2kpYhCBVZ6ZLZ1xb6RSOJAg8mfY7cCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715239897; c=relaxed/simple;
	bh=hKlzg7n2M91QHuHzIH/i/jIkyPsZmX7wBR+g4EMToUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BxFHS3tZ5luKk3P4o8cKkgxwBL30Z44C52dgdBiXlb6PhYp7KdFah9G7wKvtHxbkModmEIZLAUJobxDAcSsx62TXDNKFu3oy5aCcJu0o2OIwWqfSf7W4SXhyUTP2QuZfdnALACoSrvABgEYgk9U/HOSaVM+3cISigkVXhDZZyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lr/LXdoM; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b2733389f9so138979eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 00:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715239895; x=1715844695; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFIJqrgUYRufZO44ifi0BeHH43Pj5mRVkX8VaE4POmU=;
        b=Lr/LXdoMbExDeLTbSKvH0ycJjU5V9bM7H0nFJRN5U0jfbF8CvKMGkociBxhie2YERj
         yOvmCYLeI3vRMQ7CUU13LEA6Nt0kknsMkdeHvpjtpeCJ0bHz0ioyopVD4dePZpCptJ5w
         tYaT0UsBg/NnC13AwQTy+N4vZ3sgb58gauj40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715239895; x=1715844695;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFIJqrgUYRufZO44ifi0BeHH43Pj5mRVkX8VaE4POmU=;
        b=C0AjWf7U1deYcl/1mCQly2/46WD8fwHgKjPGD+RRIM19rsedkVOivptqann1qFy058
         bEl12x/5x7+dIOBVZoQtEIXXt38EAMWIb6smrvlkeEr9EfN2bflWy3sCScWWuDaHVjF2
         wIE3TFrZCY228Iy/VCgzShCneqwnUKxJ/QcVM1FA9bQ5shmTyxXJxTos1K06Y0R4z6oU
         kXNAQrHyHUVjcs8MiIYMgQQESgpXwzhAgYaoIF6LX9d/z99EX9fjnDkpdAGJ1gSxVFn/
         4cqtbfJcBGy4eHfywQu5U24XUdm18Ok+v5OszHf0tIwKfTrD/wDOtWpaAnQHwZy83pSv
         SKTg==
X-Forwarded-Encrypted: i=1; AJvYcCWOtpnqlMK/te4hI9aMSfUCLVaf8gvYItlPA297lhytTnDvOl3KmSV7Vj7xlfBtaczqqgb6nNUj/Y3tNIiAbTpAWoT0MwSIdN504fYh
X-Gm-Message-State: AOJu0Ywfhi/4RZg0dVpRWQtZRGLXw/7nZ5tvW1RYwl2evgNxKQHmfyyB
	IJW2XDE/KJyMsxigs2ZdVZpp/iAHgcKMih3lHUfDquktF9OOYnSxfiQP0QyPOQ==
X-Google-Smtp-Source: AGHT+IFxCbiVVPSFIyPcWAzqs1t5rme6BYl/0xBEXZ775m3VFUNpwbdtD+YpUNB1N0N06kSsvGevfg==
X-Received: by 2002:a05:6358:54a2:b0:18e:a0ce:a35c with SMTP id e5c5f4694b2df-192d2c2b383mr578760355d.14.1715239895370;
        Thu, 09 May 2024 00:31:35 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (150.221.124.34.bc.googleusercontent.com. [34.124.221.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346d46sm586459a12.79.2024.05.09.00.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 00:31:34 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Thu, 09 May 2024 07:31:29 +0000
Subject: [PATCH] ASoC: mediatek: mt8192: fix register configuration for tdm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-8192-tdm-v1-1-530b54645763@chromium.org>
X-B4-Tracking: v=1; b=H4sIANB7PGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwNLXQtDSyPdkpRc3eSkNKNEc+Nky5QUYyWg8oKi1LTMCrBR0bG1tQD
 PHd/7WgAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.12.4

For DSP_A, data is a BCK cycle behind LRCK trigger edge. For DSP_B, this
delay doesn't exist. Fix the delay configuration to match the standard.

Fixes: 52fcd65414abfc ("ASoC: mediatek: mt8192: support tdm in platform driver")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
index 9ce06821c7d0f..49440db370af0 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
@@ -566,10 +566,10 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 		tdm_con |= 1 << DELAY_DATA_SFT;
 		tdm_con |= get_tdm_lrck_width(format) << LRCK_TDM_WIDTH_SFT;
 	} else if (tdm_priv->tdm_out_mode == TDM_OUT_DSP_A) {
-		tdm_con |= 0 << DELAY_DATA_SFT;
+		tdm_con |= 1 << DELAY_DATA_SFT;
 		tdm_con |= 0 << LRCK_TDM_WIDTH_SFT;
 	} else if (tdm_priv->tdm_out_mode == TDM_OUT_DSP_B) {
-		tdm_con |= 1 << DELAY_DATA_SFT;
+		tdm_con |= 0 << DELAY_DATA_SFT;
 		tdm_con |= 0 << LRCK_TDM_WIDTH_SFT;
 	}
 

---
base-commit: 45db3ab70092637967967bfd8e6144017638563c
change-id: 20240509-8192-tdm-cbf2a73c9dd3

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


