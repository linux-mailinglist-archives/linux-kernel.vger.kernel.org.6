Return-Path: <linux-kernel+bounces-211892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B2905869
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB3F1F21C06
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F00A1850B1;
	Wed, 12 Jun 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgL64rbd"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DF18412B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208962; cv=none; b=X8Fhw5tnWxpxErYYufn+AUzGpf73aAke8PHRj82f7tkRkNZiGVBJYV6Wlw6tUj0Z/o0nm4ENcg7tcBKgU4ooug7G3+5n1paYJdP0V0kXPo0vmoZz8NMlsFWr7P7lb+UqQluWlXxhMMpmjzA3HVDLKS0DfBF1FQI1nAu6ku8H7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208962; c=relaxed/simple;
	bh=k3aHGQ35T7ijjTVwTgAA+AUOyeA0WrPr6zQfs8D75H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eT+pfkgjWZPoPFZM9QFw85KXfnqyNW+t8pQ9ivHHO9Xe6rS6AUu+pCBnXLFoVYFteVkoHIi46YD43rPUIdMO8nbdtiMLuRSZWCQGxNwM1yl/XDO4ZlHDvwpMtzVG/1UjSWlqg+GX4A1hDzdk2ILqfONbSBR+chlnnHSie96uwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GgL64rbd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c83100c5fso3088177a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208959; x=1718813759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcbW+JTPzOIFFpOVum5uDUaAmhIV61iigZY7iqshvBY=;
        b=GgL64rbdnpTvG8n8qy6oEiEih1LoIoB3sv+KnuxWXpRbBPfN2BLUFqSCCa9Nq903fH
         /heXeMpOyIf0MTUZ4v0tATJ3/ii3W2qBlgtckLi+qsqwHOu33KJwH+ZR+6S9LX83MIsE
         5nlVJci2+UrHfQIWLJFc5WhBTTh1QCX+UuUYz09RzfpifD4zVKrw3Lbj0CNw8YwydOoH
         mHSDCLNIiPlixnlA92apctAVbtxXSV2rZnnQRSRMUCIXnjRU/9e1WcMKaK26jxYTXOMI
         UHlmveAjI0p3gmjYE5guvAJoSUIVQhDCqku+UeRbADwdR5FFl6VFglURXAGuw4EpASwk
         0vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208959; x=1718813759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcbW+JTPzOIFFpOVum5uDUaAmhIV61iigZY7iqshvBY=;
        b=F+PRr2eXoSsMNcc3h1CwQiicPTPJbT7bLfARW+bGP34aUS8pXT3YSoU9CGKesBjvPD
         5ye7u1XU9W00xNlxdM8fluRTNm8YOhMLYnKc+wUAQe1KrLQFESt+F3SgRy+VXU5oZTXr
         NdQpBwVUDPTL6Va3BE4+4O19F2gi9XKtFOigAblf+mUvzrk+P9bDN8cJFzP1gAs+wA/o
         hhqRTqMQXFHUEO56BVvC6yZMOZMHK/1q0OqTJ6VVIUQ+EfDN+tcQMcHPKZLi84peau9k
         HXbiaYO4BxEln88PqR0ayExGC4V7Aftkau6hDEjkvxFhmBY0NcTCGJJO71bD7VfoC/G7
         hK3A==
X-Forwarded-Encrypted: i=1; AJvYcCV2DW0/bZbVzxTmqhYWCd1D5UDslhEKFiigfo9K87DgHZVkxUM0ZOkXMYI7VBrDDFs6mcLTpbiRbd5cIYbLE786LGb6SnzrbpUr2OrU
X-Gm-Message-State: AOJu0Yyae1iJDDREtNLii0dTQeyq5eRYq7xY+yRmeDT6fZOEllsuxZ8R
	MAX9XTP2TMwGhTa60W9BKRmEMAyuo1VEFdpEcJd5+W/6v7zvndxMa37nhkgXpws=
X-Google-Smtp-Source: AGHT+IEN9rj2+7IxBP1nbcBt9m7CJsmICBXS9QNlv8TKrqAIqhUGB4qf3LQZ9NZjbSz+56EqZjtyAQ==
X-Received: by 2002:a17:906:8411:b0:a6e:f701:384d with SMTP id a640c23a62f3a-a6f47c9ef68mr138716266b.29.1718208959469;
        Wed, 12 Jun 2024 09:15:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:15:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:26 +0200
Subject: [PATCH 13/23] ASoC: codecs: wcd937x: Drop unused enums, defines
 and types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-13-0d15885b2a06@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=k3aHGQ35T7ijjTVwTgAA+AUOyeA0WrPr6zQfs8D75H4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmiUZs1tlbK6jnBBYnES4RTFwj4cUtfFCOno
 R4s7gGO52qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJogAKCRDBN2bmhouD
 1+tcD/42Q1kKDqlMFYK6egSvrDjb4I3laIlWnthXZ8q/mP9P/VxLLWKe7SKkna8H5vuR2rE5l6T
 cmSj9/GPYecCXoPSdWTKTbhBkREhIEk4Y+t+7cN6oK5ZoaHTJuUfy6TDKixktFYHx9hu/VfW/4O
 J6CGsTtWiVKWgiIY+VmQbPbCBNjJAtmrQELlqovmVej1yKPAFzSNjgcoE7hIHxUnoteR5KFpg/Z
 YzHXBjwy5EuFYyxU3MRKFhGajmJUWjnXMw2CAWuNodCx5eWwq77/7GIHaIeiE9DwZobMpd/ciOb
 gaqSzQ2AaiNpChSnnZYRVnlEWROQ5UtDTW9tkYBFnxjo5bYGuVMZnFBUJ3L9IELS6fcKZ/sYyN9
 nXqJm5bRSeunVFnT6eoCAyaTpAaqz9xltxWp2Sqb97A0c+a48MsPHT81MuI76SrA/mmy/o0myaw
 q+ZM13T6b2t3w2mIthMaepqU3iXyy2+dHNSUhfQ/bJEudXyAAqBnrwKgX9LE4GwqDi0JTEOsfek
 iBVgz26+46X+CVPOhFp1fPyVpg4BNGuZV7JJOjjQtN9C9P93fXhJYJTLNtHTlCMRVt1U++FrqUk
 fdW8z5HQ8ziDaldRy22lPOuGzDe9d7Fja5OiYl04I5DDRWv1LYxZ2HC+ScDNxzdVfF07oazsdKx
 Yi3lbgwGryYWV3A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Few declarations (defines, struct codec_port_info, enums) are not used
and can be safely dropped.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd937x.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index 6f857ce7d8b7..834a3e7713a3 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -488,23 +488,6 @@
 #define WCD937X_MAX_SWR_PORTS			5
 #define WCD937X_MAX_SWR_CH_IDS			15
 
-/* Convert from vout ctl to micbias voltage in mV */
-#define WCD_VOUT_CTL_TO_MICB(v)	(1000 + (v) * 50)
-#define MAX_PORT 8
-#define MAX_CH_PER_PORT 8
-#define MAX_TX_PWR_CH 2
-#define SWR_NUM_PORTS 4
-
-#define WCD937X_MAX_SLAVE_PORT_TYPES 10
-
-struct codec_port_info {
-	u32 slave_port_type;
-	u32 master_port_type;
-	u32 ch_mask;
-	u32 num_ch;
-	u32 ch_rate;
-};
-
 struct wcd937x_sdw_ch_info {
 	int port_num;
 	unsigned int ch_mask;
@@ -570,12 +553,6 @@ int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
 }
 #endif
 
-enum {
-	WCD_RX1,
-	WCD_RX2,
-	WCD_RX3
-};
-
 enum {
 	/* INTR_CTRL_INT_MASK_0 */
 	WCD937X_IRQ_MBHC_BUTTON_PRESS_DET = 0,
@@ -645,9 +622,4 @@ enum wcd937x_rx_sdw_channels {
 	WCD937X_DSD_L,
 };
 
-enum {
-	WCD937X_SDW_DIR_RX,
-	WCD937X_SDW_DIR_TX,
-};
-
 #endif

-- 
2.43.0


