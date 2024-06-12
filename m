Return-Path: <linux-kernel+bounces-211901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11F7905888
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EEB287768
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F38194A6B;
	Wed, 12 Jun 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TeHcD1kD"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680651946C6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208979; cv=none; b=eNExs9f5ds0ufV0TwbGB28JjTCb4QHClH3SKgkokpmJwengc8fzz+wUxb3CptM+vNTAujNRVgoQJeJ6AB2efaQ2TE5Mu37aOe0hGcpcaOPFpDC4UuEoTTd1DbiNOia53h8/DjeLuyBIj+h90jPizyi5ckYJny618Rynvwd3vLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208979; c=relaxed/simple;
	bh=kdpxzyNuweZKr0aRSDH2rz6ZRs35AU6E2D86EkplPOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfnSTEMhzRuC0RtK7xigQR4pVa6G5MIdAahm5lFbPHbduqZ24d11VFq3cgGCRlnLwUA+IcxpKxLvjfLMn5KI1aIzwBDbv9Oy1440wZFT7vOe5SDRoeNRG6MDk9aJwIKEs46+LuLMoTBu+CTk/YdEIHmaq4TuNTCcItj/xm1O2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TeHcD1kD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so3529306a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208977; x=1718813777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZaOcybsRppKpT5g6NO45LPBfW4VWvjoUX43728185g=;
        b=TeHcD1kDvc9yiwSDdTi04Z1dL2dyXvXa1LrI5BsOeS28je5K08Cp7Uvn5+fxm0tAu0
         KCCtDU7Nq8w4DpVviLjyu7WPt4WG4XxkVHWqFPNvIsEPKcE8qEtlxNTBdTLaor0WoUZf
         s++YN7DrmRFnETBesFK9sbBEpAVBZ3HUjRUV9wGIUz0PDJ009ViZI/tZBgOxUhmfrTwM
         IC5M814Zn2wzLyp+an2CyJr8/sy8nwA12TsaEZsM4KlSgkb6VDPJ3q0RRVJT6OUuRfB1
         AOFA47VbI9hT7i5gmOov/iaFNUytSPzLDcsSypQ54Hgbti2DXjNto3jhDJBvOVjTEAij
         SYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208977; x=1718813777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZaOcybsRppKpT5g6NO45LPBfW4VWvjoUX43728185g=;
        b=S6G0MnsdNz7Tod5/v3O2lxVSOJKlgUDTVMDgKHu+nC4k9VjxE92wkV9FIEwHFSO0k9
         +zQ8ToILIQipCQhMxz1ZtGNA+mlhL4yKxDJez0/vbzxFmbh0swcacwgiRtknvpPm6oyc
         9cUGSI2F2KELEAAEA0K6R2X/ubwCnWs6M2GF7h+odwiWseTBIPUwywRGjFlST8rxmcik
         Dc9aEfpSaiq4OW5kXnJJ6hElNq2SspkQ8SzfIG3Xm3L/PNjxCQmCf+pQOXzg25kkuCif
         FI1VhjONu712QR64v0aeAF/wvfKlq77s34xiu3qqW8J9fX/AL/mZBvFsJyiTfhKEOTzH
         8xmw==
X-Forwarded-Encrypted: i=1; AJvYcCUhzz3Q7ct6X5Takb1qOKHXtVwFCN+IXiERMLbxwEPc/2xKbO0NGe5/sowwA9F5C6tlDulYvbRDwoBbQ4m240IiL6ikDGbu8d/+Zesx
X-Gm-Message-State: AOJu0Yxyp61VWJ+/k+DxEzgVlSLjfF2Y7GZAlVIbyoSy6chiPBdYxGOA
	Jejgj/pFyeVgzDTMfnzNo9vD0CgnyI6YNSTvC2EhP05mivcEUpa3CohiRtPdYGg=
X-Google-Smtp-Source: AGHT+IGBStgBwHDaeCOJIdElnx3jY9hewrQLo1+/oRczrEHocXLAooxE3WopQIuwsEkaMPbx5CZtUw==
X-Received: by 2002:a17:906:1ccf:b0:a6e:d339:c095 with SMTP id a640c23a62f3a-a6f47d56e10mr143448266b.47.1718208976945;
        Wed, 12 Jun 2024 09:16:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:16:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:35 +0200
Subject: [PATCH 22/23] ASoC: codecs: wcd939x: Drop unused RX/TX direction
 enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-22-0d15885b2a06@linaro.org>
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=623;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kdpxzyNuweZKr0aRSDH2rz6ZRs35AU6E2D86EkplPOk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmqTiI7/MPDpOR/QPOCYLLqnTtbJ9lWR7mV2
 wJ7BGfzhXeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJqgAKCRDBN2bmhouD
 13e4D/0ZkltMoAyKX0mzksxtBOvUUWkNcgLlpCvNqdmlMIhR/r8kKBSwdJQOS7fvCxRSbJXVPjC
 m/7fMpyDfcF5VUMWPlZzObRfzr8W/odYj0k1t0TmXbAEUE5AG+/XqjQfv5VSJnlz9AlEFemViYR
 THjQKv2vWpVBVtWPfcQktJBaM56Tg+uN4uix+o4fccx2ZgmtV2fTn83UkubIbS7zRqQLIw0n21b
 qg77mcw7AdaW2uhqZjeo/NdlzsdyQxAR4gGfSmGIhq+OwP6xSd1CGDCknjPwVuWjK9XBso3qpdr
 NaTolQ9xCwPFpHERkFINSC+klwCJwlz25ESPB5SWzAFXC+W6ZvM3RNYjA5Tu1ZbhHXYDT0M/Qfs
 OhbPOuGRRUljpD1Z5pfwRR6kJhl/Toaj+UTz/VD4uGwnvUeFbnCgL3ftsmdOqJjG3hLwKoGJmSM
 RtRQCqxWIv/WvcOyG9c3qD2HnBsg6JYn/zIM539PqLbXzq2sui7zNaPY8NnzYwBZVdBAqCY6ity
 ceczjgqxXDBIbm7Cd+DUHClBXhgurZiEeRRHTzzlh3Gvk4/Rc9X3wD7MtBrk5/bsBNo+9ue5zfS
 NHK5FKcXGJlddS0XtxjxoSaXHaAbQwSHpGCsFyQnas6U36X3Wv0C2vARmWWXlEQEYT1q5DGBTgv
 KRWlakkVEDkoy2w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The enum with RX/TX soundwire direction is not used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd939x.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
index a6c9c6cee056..0aa4d9d542c6 100644
--- a/sound/soc/codecs/wcd939x.h
+++ b/sound/soc/codecs/wcd939x.h
@@ -903,11 +903,6 @@ enum wcd939x_rx_sdw_channels {
 	WCD939X_HIFI_PCM_R,
 };
 
-enum {
-	WCD939X_SDW_DIR_RX,
-	WCD939X_SDW_DIR_TX,
-};
-
 struct wcd939x_priv;
 struct wcd939x_sdw_priv {
 	struct sdw_slave *sdev;

-- 
2.43.0


