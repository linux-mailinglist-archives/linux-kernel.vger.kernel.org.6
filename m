Return-Path: <linux-kernel+bounces-437431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A1D9E931E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCFE188557E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB712236F4;
	Mon,  9 Dec 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4KQCnq/"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB721D008
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745646; cv=none; b=KjyCTqA/PXiIRTOUrZ3GKkiPWBGY1RIaPxRc5DhrZxYiBw8Rw+G6duZEjOXKPt8irhlFpJfvHjXJhgaRLEMNmZR6W6ZZUOXF+c0FvQM49q8aPnV1YXA+xDxZISX4iYyRnGqJP/wi/5xAvtXZ7USSsxkVC3SKUmpETperudKtus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745646; c=relaxed/simple;
	bh=9sRQt+fEILRzDTNPp4NsJSUXPScp1R8Q7XAPeUZ+iqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9zRYVOi1J85SEgeD5Omb+Kh3Z1AMHmE4wxlEXFDA9GLpItcmVMOq8iuV41xrshJAGKn+KejJ3SdrAjSCAo6lj0DTMP1daNrR/SL1qQ+wSUFNN7pKsOOnGMx/4ntlHhuxQYF6ELG2g7BKiQXPTBingDEq+fQ6kDY/tsA+AOz2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K4KQCnq/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6647a7556so35243766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745643; x=1734350443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvMgTCziUbKV8Sn4Rfvx0RhbjGii00C0EWsPPIrd18s=;
        b=K4KQCnq/hfqhtgHsnUP45TFxjl2Bri2zKrTzaXOtWDFYlpRSEmL4C8iM4FUUQPeuRj
         is+3ndJO1cM96gBPSQkghKYGv4exQwWzk7ZcfPr818shHKEGAOCwm7nxsr3/63DKy1Ao
         P7RT4tKVa/gyp7FUiwR+fEEX2djEMJOsGnhG4JHnpy9iV22dl/pCuCSANHfceOLW0+Ga
         dpEq72O8GmixvniS8lXFWcOWhauj3YCD/tybXPSt6/wZdq5NcgyizNx9/GCkK+Y1qnX2
         +00Ol30jq8lBDW7wo6V9CnyarG0jHjUNKrAmvsRe7gi9T8C6O9IGuULIvOfl0ZBiQkVy
         LrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745643; x=1734350443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvMgTCziUbKV8Sn4Rfvx0RhbjGii00C0EWsPPIrd18s=;
        b=HUMnM2IxXlL1pWa6LFnwN1W9EAwtAvPn45Yr3A25sHWQtnF+76ztbfdS2rR8MQcuvb
         glPM7eazsEj7YM7hq5L05jd2f1R5fTRVEA9Di9HgUk9Mp4RsiM03VyItPKYS9UWem8He
         cKzKZO6voCyNcGRu5uJhk+75/MgiX4L/7AuvcGckbHNLFWqAQ7dvP9vDAIP/74mLihh+
         OXReCplBImCqZD+cjYA2R2W6yNo5shxvw4c+EOqY6Pul7o1UjJG4P21VapUsnrRJS7U2
         gIis4Q7seeRWGwTGMy7cSv+YAZNSoT9ro7WvpkYEx869QG2tMz8hV5tpm0Mn0AmttHHl
         1OoA==
X-Forwarded-Encrypted: i=1; AJvYcCUO6EPlB7pWK+gjpMF8WuYJXXgDO+VddN8rKK5fy+repH2I5TMKOgC2czMIeKbDJez15wIlgNKR49zC6fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOzkZfNA0TNUKCaTQO/olt4/hlUcVqN5Ir4FUSUAqQOyATYJy
	/+R3TcGL40yfxIshQzldHlrqHaRuMqkZET+7FTMCu8rWRm55Mdg1McxvjRg6RDI=
X-Gm-Gg: ASbGncsrEWcuP0Q+GMpEgkSUSUbuMrXFHox3vkeJawaIvCybpkBuYHLKwfMGwHBzF1b
	9lGSt4uzDgmNeCFciPssjIfoXSfhe9ML6GjaFck6g96WCo5QqANZwYu4fec4mP2Wbxu33B5GrEB
	KWoQLg9khF4Dyp0YGTaf2Xh9jnznIRWyTlItBeIFVIcexQNg8PTZa7bKb1fAkNXqySZHkhwJhh/
	Wsp1gjMnXDGt+9ANKh5yQV81QpSYgQtSB1NfPxCt/ZEPS4OWcMfOel2rjL7nW07fw==
X-Google-Smtp-Source: AGHT+IEqH1oaArwnV6wNm6opfU9J8wUrT7nB0JecmzXsIpT8ziyNbaP+FOzBH6K4aWnkqgODWjFUnA==
X-Received: by 2002:a17:907:3e1d:b0:aa5:3e81:5abc with SMTP id a640c23a62f3a-aa63a025e12mr529837266b.1.1733745642780;
        Mon, 09 Dec 2024 04:00:42 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e33f7sm678589466b.183.2024.12.09.04.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:00:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 13:00:29 +0100
Subject: [PATCH RESEND 2/3] ASoC: codecs: wcd938x: Simplify locking with
 guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-cleanup-h-guard-of-node-asoc-v1-2-397f6385e4a5@linaro.org>
References: <20241209-cleanup-h-guard-of-node-asoc-v1-0-397f6385e4a5@linaro.org>
In-Reply-To: <20241209-cleanup-h-guard-of-node-asoc-v1-0-397f6385e4a5@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9sRQt+fEILRzDTNPp4NsJSUXPScp1R8Q7XAPeUZ+iqY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVtvlv9laKURklc50GyvU7ApINZFdb6iPHFHM3
 IGn+qUM5uuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bb5QAKCRDBN2bmhouD
 10g5D/0WnXxailydX0vc5hIzAjuDVC2J93gYT7B3iaw0AD+lI0E1RdPIuu/k+tW7vMfUimqH4LY
 ZEAaes7CDLoN/zcjv6/1Jogl5pDfoYarlXyV3GqPxNa+/e9TNohSr5FVXl6g5jwLppL7mfjGY4p
 DRuwO/LMFQ/7gVGHRfveij54gk0HHmnnOjTVjdnJsxfoMqf75Awh0HvG70Br3c9v60eTzMaxaoq
 3M/vgtmG580MYG56wpD61wpkNTrmXkpkedLv6W9Cv2LgJ2R13sVJlXXW4Lc5meMyTq/nqmK9BLt
 Bw9tPTv11txl8pRAa//pWM5z51A13bsnxvKGG80OrKeHJg7xvYzzmLzDKPND2UJILjUGnwN72TC
 s3GGfjvrdov8rxt7sHD6i59rYxEKadqyq/3pbUYscKQAzQX1nIybw3z1P6tqn2W+5zcmeq6EwQD
 QllkjqAGpT7jEBvjlhuAGflmBNglf3bSN9vkh6NoKZP5oCESFlUc4izbuZAqTacSbHSXcpFP78F
 OcLiB7dgp6KNAlxJaLhatv7fqDDUMr9Igc/G/4Nuum1400zcTX7acUTEmMfJbCdOToiO9V94z3R
 Ni41kLDvmSZ5BoKyM/VjpM0Gpymve8uVNPQa/GRDRu4WpaU39vPRlXQMJkSooZ20onVswGC+vcy
 8oIzSBX2cCtVVgQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling with guard(mutex), which allows to drop local
'ret' variable and to directly return instead of jumping.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index f2a4f3262bdbc5f828628464bba9ae07ef99af56..0c1377eee5697f79b5075a29190c39d5195da65a 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -1992,7 +1993,7 @@ static int wcd938x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 					    int req_volt, int micb_num)
 {
 	struct wcd938x_priv *wcd938x =  snd_soc_component_get_drvdata(component);
-	int cur_vout_ctl, req_vout_ctl, micb_reg, micb_en, ret = 0;
+	int cur_vout_ctl, req_vout_ctl, micb_reg, micb_en;
 
 	switch (micb_num) {
 	case MIC_BIAS_1:
@@ -2010,7 +2011,9 @@ static int wcd938x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 	default:
 		return -EINVAL;
 	}
-	mutex_lock(&wcd938x->micb_lock);
+
+	guard(mutex)(&wcd938x->micb_lock);
+
 	/*
 	 * If requested micbias voltage is same as current micbias
 	 * voltage, then just return. Otherwise, adjust voltage as
@@ -2025,15 +2028,11 @@ static int wcd938x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 						    WCD938X_MICB_VOUT_MASK);
 
 	req_vout_ctl = wcd938x_get_micb_vout_ctl_val(req_volt);
-	if (req_vout_ctl < 0) {
-		ret = -EINVAL;
-		goto exit;
-	}
+	if (req_vout_ctl < 0)
+		return -EINVAL;
 
-	if (cur_vout_ctl == req_vout_ctl) {
-		ret = 0;
-		goto exit;
-	}
+	if (cur_vout_ctl == req_vout_ctl)
+		return 0;
 
 	if (micb_en == WCD938X_MICB_ENABLE)
 		snd_soc_component_write_field(component, micb_reg,
@@ -2054,9 +2053,8 @@ static int wcd938x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 		 */
 		usleep_range(2000, 2100);
 	}
-exit:
-	mutex_unlock(&wcd938x->micb_lock);
-	return ret;
+
+	return 0;
 }
 
 static int wcd938x_mbhc_micb_ctrl_threshold_mic(struct snd_soc_component *component,

-- 
2.43.0


