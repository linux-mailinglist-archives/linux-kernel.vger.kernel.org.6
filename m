Return-Path: <linux-kernel+bounces-211897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F75D9058D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3E4B2B9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736E318756F;
	Wed, 12 Jun 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TM0SN/6r"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173318754C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208973; cv=none; b=mdi+x2VpGjWiZQZAYXQWZD3Ajao291N8IUWv6I8GCWGA1ola/pCD5TTHjSu+WG81awOjThwzrVKS552q6kC2hJcLVXJsnj30Rcgvjg2BywIBX7bGCp9a/X6aLQRcQbc/Gs51lPThEUawK0Dy4Cv1xv2CeVpxAVn+uNamIYNn+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208973; c=relaxed/simple;
	bh=L7ZFNWdOudYPqFvlRankjfRpsFdGgmRFWod0+Jmn7g8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5e7q9SOsvAF6crUNU2+TRfOwEzpXJc4NsYtUipo4iSOk4+1I/F91nBxqNlogjyStvpmTtuY3zq4pUQlAnsA5jhnIcJJX3eHJaU3jWuH+MiH2H8jX1QHMeY8G6PuE+SQijQsha26YUKx+Laaa9A7zDj+rf+Zev1NJNOar3cMaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TM0SN/6r; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso7263166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208970; x=1718813770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIfrWBZ7ZLY2KaGKe1FyMOfZUNjl1h6UvB70qr9xbUw=;
        b=TM0SN/6rRG5/FgkbVvFteZm0FfmR9/kaABf9KomFmvPKf8YhWa6Kk1vy0sQhfjBClv
         Q//Lvedat0D03zdsNJtLLbbFmgPosjHnsl3NXpVCMI0fIn0mwZ3OfxJGnVvhBOkj5I5j
         9d6Qkmh3fsCPQ6h8rf0zs8CF5sv2LMUZgQZQk31Ptt8srfeiR98rtDS3PN8LTPFEyLN+
         7nKQO24P3aZaLtG2tSI73K83xCPcavXgWpvf9WnuDJK1hfUdClgcyxzL0NOGhm9by/+b
         u5sx6LHsKl0Os9Q4D7CpHjI7ubGYNtf6J1jIHFI89nIsN7MKUz4SbS4WLfARHHRz3is9
         ayZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208970; x=1718813770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIfrWBZ7ZLY2KaGKe1FyMOfZUNjl1h6UvB70qr9xbUw=;
        b=BPt3+K+1Kcvd4Rddw0cWu3BP0uX/6sKSqy7813AE6TnPPYNXud+gDlYgQXOagHpela
         FptXt5ghz1JMB+EwA2rsW1lK+fNZr8RQKKme5RG2uAzyqRa3MYjn0vfC+lDlioXaJg+4
         Bmw0cRtEK+pRW0z5TqzoqRrgk59DUQLygmvs2R37zllhFjzOQtsP09ToglnsQE+VEdfL
         EQzuPjlrD6GCL1xwjivyRsQI8sJYuj8aQgWBEDPwYrv6YbYYwog8RzuWxPrKl9wcl5LG
         tbV9BpZUf5sjammcZKveaDjwwzYTTEaGN8jivSldWopTlBZ0q6pFdgujnDxZTNJEUbuL
         ChDg==
X-Forwarded-Encrypted: i=1; AJvYcCWp+78ZCpPhmo6aatlIF9yqClTXH5FzTw1PzLFIRGJ+o+WtpsUC1xW0fo9A2j9ktbRCJtDLvc7GebTupvfoX8ZXGHI93hgp82JFtN4N
X-Gm-Message-State: AOJu0Yyaq+fWm/egnwBCx/vcQQuI0ucBzt+QClZy0aHX9TE/wU5bBOvW
	IBa78gE/mP7o8Xo8H2IhsZQ012hJHpt7Fv9J1vLFYai7BBGBaWNYSYoc+xEC/mg=
X-Google-Smtp-Source: AGHT+IGSObf0l0L2zRr/AQv9YOpjrm5YjJDqPglWmuOwaiRYlRdW4JCSS3SNNzuVyfXhGmKq+JKeQw==
X-Received: by 2002:a17:906:240c:b0:a6f:f7c:5c7a with SMTP id a640c23a62f3a-a6f48009fcamr129872066b.67.1718208970622;
        Wed, 12 Jun 2024 09:16:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:16:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:31 +0200
Subject: [PATCH 18/23] ASoC: codecs: wcd938x: Drop unused RX/TX direction
 enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-18-0d15885b2a06@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=605;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=L7ZFNWdOudYPqFvlRankjfRpsFdGgmRFWod0+Jmn7g8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmnp8+JwFr9BLyBT5edp/Eaw49lg2Z4J6xVC
 SGfKz+ZVdeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJpwAKCRDBN2bmhouD
 1y43EACagGw23sHs3N4XyJvnbu2pem/kbPuMolndb3vObHn7C2gJcB4lJImAorSaETGl3R8moji
 7+UiE0M4ksdkq9A6rQOPAYl3EXd4X3QoN1IJruNg8/bLaxaNP0+MvN1oCP58DKeGgw2Iy46N/AU
 aJEAOJoyAEjkdq/d2uFGrZmljKF//Z6N7c5v5repECj1F12Ej4E9kMxnDxgsDBSU4Ki4VnoTbrk
 wefVaVxFyBh92uM63FpE8uMuTFj4I26k5vqXxbeOhgzmbMKdOssG5InJcPZRnHqnTBluKdngsbN
 ncIWO2+P9sUSwYYYF8nGUvuFcG87Frn1UQbE7K7QB9z6QMen/NACugh2jZBio9u2/3pi140/vVN
 EXu6ws+X/qu6Co+jvhGnb8Mr0ZOcNJWjYEEcJNlbjfM3RbG8qmUEBoBaYyUbkpbmBoNGiI4aPzz
 u0da8W/jNrSFqTWp4aBSrzbiGT8AtfA+ztYjbGkppEWPBTceb1IkJ7+HrLDpohpmJH89QG7Pexl
 bcs35XIj0wQ67ax4HA98ZiZOmVJKMzTljElnOsjwfLsfX+m5App7UGILUFCInTv9Tn7624Lvohm
 RVtqGqO1rZbLbeYEW/U85SRC4VtTqvLJ5cH/CHJY/0UZmWYYa1rX3na7FmuZlbKTQJzAXCpiZ6m
 y9x+UOuk1gsdjSA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The enum with RX/TX soundwire direction is not used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index 09e39a19fbe4..45b7de242209 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -642,10 +642,6 @@ enum wcd938x_rx_sdw_channels {
 	WCD938X_DSD_R,
 	WCD938X_DSD_L,
 };
-enum {
-	WCD938X_SDW_DIR_RX,
-	WCD938X_SDW_DIR_TX,
-};
 
 struct wcd938x_priv;
 struct wcd938x_sdw_priv {

-- 
2.43.0


