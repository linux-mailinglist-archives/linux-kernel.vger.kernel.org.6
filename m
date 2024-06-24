Return-Path: <linux-kernel+bounces-226705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA79914285
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB351F21231
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC686219E2;
	Mon, 24 Jun 2024 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fNTGICP7"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236913FEE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209584; cv=none; b=L8S1lLWaY6h1qU5dqWIxLqAFpPuMt09kSjeUuyTur0B7qRK29q2vdOkQ5nzuqH17Ilu51Bgzb3hvUE/fdv5bH1KFiUdKkaJwp6vrbRcXyccX+S0p/bh8zB5xr3kt2G4CG+XGz4j/bUgYEDyR37kTh7p/3J8HKlA+e+/pq4VSziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209584; c=relaxed/simple;
	bh=aVHsVqa3Mw1s5TW5A0aHgn6rbR2d5USDh5nbiQUnUzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5Lw4CNM6w3FZavD5NPrlK1GZmnifILUbRJrh1wXZVUl2YzJP7K5AqLalgnlY+W3sczuxLCNY5xYeSQn5HsB/t/M/kFi0xC/bfvRWTZQ60CwChULZD8yuGnbIf2nPHVJYu6Z+G5GtJi8gdLk4r1BEcgtgVha67FTYIXMn+liEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fNTGICP7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-706524adf91so1886511b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 23:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719209582; x=1719814382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4N2wMnACbjcCz14LY0USvKoVXrjwARwQKVYyLGYLpXg=;
        b=fNTGICP7L4PPagNQGZZYQ93XSI5ql0aHiM6yphO2C3o/0uIywNvjd/tyBJMRtWcPL4
         5mkafq7FG7jWM9y1LLOekaWfg8JlOD1gOL9HoiqLa9KFnGM4ULhXfpJIEvy3CJeEsXK0
         vEgnV6kWPetAd4uOnEACDPSdXOnP+mZHMds9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719209582; x=1719814382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N2wMnACbjcCz14LY0USvKoVXrjwARwQKVYyLGYLpXg=;
        b=tQ4pFQ8BoAXTnsS6wNGYoN+c6erHphU5UjhSa72Fuh3ANd1Oq+RKYmVNkmcRllgbZw
         2dTy6rGORGsM3H4IK83onnGZBvh0Dl7AeyBIsOyVoGZM/3I6nVytIyryFeUuZX9JVQvY
         UaTKsrclA0rT6NHDSdYqVv6ZdCKkrpEKboaxNjHeZArnJdpnAq9F7jyneSoO6v6m6Nt+
         1Oq4qj2Fcegzt7JXvKVep9EE4HSz8PT9P+Aspqqba6CTMM8MwEzXCJwOB/gAcjKbOGM7
         Dl61NOAohsT7y9Tz+lpwCK760t+Dlv1EsTfmtLoNX47vY16AUB9PxDtWoUbFS9DXf9z/
         vrjg==
X-Forwarded-Encrypted: i=1; AJvYcCWI/ilvSIfuawQRl9HLZD5EaBXRBn5zKtua6k4rL8dAtKNtCvBe1xV75YbyUmk6s7MdLpeIsU86JcsmJqJiS7FEgVVaUTNohnq+OJZp
X-Gm-Message-State: AOJu0YwmALpg9HXsCjHCqQOkNMt23TFUrJ5ksrl/eRO8RMlZHofSQXAt
	gOKtaZXUxqAFaxMDqOt/xnUCa+2cvTCb2cyqE/ooGWXzTZTFYIkCVztqO2QJ+e+L0W2j84IRxB0
	NZkSE
X-Google-Smtp-Source: AGHT+IH+UlRR3GoF9E4C1DBHIOVlzoOCBHgWIsZ6epuQKT65Zpk0Nz9eUaoHFwng5u7QIXrd2vEFwg==
X-Received: by 2002:a05:6a20:c120:b0:1b6:cd8e:4a5 with SMTP id adf61e73a8af0-1bcf4479e51mr4136921637.19.1719209581937;
        Sun, 23 Jun 2024 23:13:01 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:62a6:1858:61eb:37a2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb5e5629sm54687965ad.220.2024.06.23.23.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 23:13:01 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Trevor Wu <trevor.wu@mediatek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] ASoC: mediatek: mt8195: Add platform entry for ETDM1_OUT_BE dai link
Date: Mon, 24 Jun 2024 14:12:56 +0800
Message-ID: <20240624061257.3115467-1-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e70b8dd26711 ("ASoC: mediatek: mt8195: Remove afe-dai component
and rework codec link") removed the codec entry for the ETDM1_OUT_BE
dai link entirely instead of replacing it with COMP_EMPTY(). This worked
by accident as the remaining COMP_EMPTY() platform entry became the codec
entry, and the platform entry became completely empty, effectively the
same as COMP_DUMMY() since snd_soc_fill_dummy_dai() doesn't do anything
for platform entries.

This causes a KASAN out-of-bounds warning in mtk_soundcard_common_probe()
in sound/soc/mediatek/common/mtk-soundcard-driver.c:

	for_each_card_prelinks(card, i, dai_link) {
		if (adsp_node && !strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")))
			dai_link->platforms->of_node = adsp_node;
		else if (!dai_link->platforms->name && !dai_link->platforms->of_node)
			dai_link->platforms->of_node = platform_node;
	}

where the code expects the platforms array to have space for at least one entry.

Add an COMP_EMPTY() entry so that dai_link->platforms has space.

Fixes: e70b8dd26711 ("ASoC: mediatek: mt8195: Remove afe-dai component and rework codec link")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

---
Changes since v1:
- Reword commit message with more details on how the original commit
  got things wrong, and what this commit adds and fixes
---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index ca8751190520..2832ef78eaed 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -827,6 +827,7 @@ SND_SOC_DAILINK_DEFS(ETDM2_IN_BE,
 
 SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
 		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,
-- 
2.45.2.741.gdbec12cfda-goog


