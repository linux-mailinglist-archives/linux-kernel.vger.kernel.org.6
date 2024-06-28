Return-Path: <linux-kernel+bounces-233739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F81591BC69
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8125B1C225C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E6B1581F4;
	Fri, 28 Jun 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BSrs1qSG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF31553A0
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569499; cv=none; b=f+yPbbC+j/y+xjkVWw7PboeCTFoAzIAs6Zxm+rFRIILTMPiYORETR372nJP0rczV7/lQOf9GmIqITY+P3cgnnIhSRQk73hetX2n1XNLwjothaq/+IcgcBrSZ9rU2IJ9GxjJ3gWnhKeaEgAjuuBCAZ2GJhnP2QcH51lhJ7eP7zOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569499; c=relaxed/simple;
	bh=fhQZZ4QjPKXRqv6gWUJ77jDFeIWxAGyZqof8ycl13AE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQQPW1FlEsG9id2UPRGZUmVg5B0Z/f0oWVX/3oSnShyKzKrcT/T7eCowHwXYX5K8Kg4QIsuAfGsFiDcY7tWxFK5JSHbCf2f4Y+Kl8kzPBaEHuLeYeRgNI46T1dHHW7Wp4bMovsAzBfT7zmLdpWIQmQVXiCLbD2+Nxo/6tC/hXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BSrs1qSG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-424aa70fbc4so2951325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719569496; x=1720174296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+rpmUsm4rhHiHlN8KJCEkTWbouDx20N7nNq4S2dVmc=;
        b=BSrs1qSGhfHibYqnC3sxWSAqJ8oJezNrPkysXT3KndW288UYMt7z+Gio4jeNDpDJmT
         nn//If9WgZ0O9Znd2tEnFgUNE05rjViH8ctrjUkltEb3ErRH8RkERtHUX/a9xGbutMxz
         a5xHperN2rxaW+5HHlCHFB1gKySTnnJj/hk4j6mJt9jMUrvBKaX3WH5dIXn/5V3zWZ/g
         gIxdVujUquJX6o2PVmrJLLrQK/KDYowzGkRBJ8K09iofi76oF/Uh3uURBGjK0dRoYAxD
         a7/50B/695PnSIZkCYMmrbhZbc4e4qz3Oxl9d9I2MD7suA/wlQ0YzLAWR9IFHiZ5KlMJ
         61Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719569496; x=1720174296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+rpmUsm4rhHiHlN8KJCEkTWbouDx20N7nNq4S2dVmc=;
        b=sKoXc3uKA1drfV30eAK/UjXUFQTXzNI5bhOGl1Z49fBGR9d6ZneriwAWjIIfZxWgVl
         IUu4/GhXgbKl8ZyfbMPm8LYfEddOyW3B3XJlveqgTgrDE/49QW4YuVD5fDUrh61D3+YU
         86jhlyUgvzdkWpgWwPXhY3UkStCFcDo+X0rw5MtZBgfqRx4aEH4FkCdB48kcoohmgF9+
         KGyugVJi0hPlEzz7+QRAw7lamWG7zHDVlPFFXksN+ZYPnp44VwUG2zbVkgyOk4rrqyNe
         cVTgNtQs01oW29CUDV6Vgu9fO2phH8u49rszTVMj+Ho4lRW1ntl8Yf5w3WRiWEKP/S7w
         icEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1b/ZzA4HgzxWmNxmekFzIgZUtwX9cL95vyAgUMyDreFtE0wxeKfXjOs3wamTUCyIeyA8e0b30xuHzjoc/lukBDdXsyuxCIQnBY3+F
X-Gm-Message-State: AOJu0YzmswoFVS+7c2lrnivblwpITrP70E+lz+J66L6BqLy2aO1ehu09
	wFsB8bmLvL8LS4TG0L3kwCn1XruvabQKWhodbt9Ln6+YCWpd4wcQE2NRJ8MhsjU=
X-Google-Smtp-Source: AGHT+IHonegirDh7c82kEa3PisDCySFJqp+wAI8RX/TRs3710R34yTI3kBy+elemSn3wKoSxmIZJLg==
X-Received: by 2002:a05:600c:1c1f:b0:424:8e3a:d02e with SMTP id 5b1f17b1804b1-4248e3ad244mr124740405e9.3.1719569496469;
        Fri, 28 Jun 2024 03:11:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c15f8sm27024605e9.47.2024.06.28.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:11:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 28 Jun 2024 12:10:58 +0200
Subject: [PATCH v2 4/5] ASoC: codecs: lpass-rx-macro: Use unsigned for
 number of widgets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-4-e9741143e485@linaro.org>
References: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-0-e9741143e485@linaro.org>
In-Reply-To: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-0-e9741143e485@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fhQZZ4QjPKXRqv6gWUJ77jDFeIWxAGyZqof8ycl13AE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfoxAtvV6h0PC01XQmUzFGtHvD3AQF3zcnGj8C
 taRAiVUTmqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn6MQAAKCRDBN2bmhouD
 1yTzD/45YqEc5uhFbMbSBNNU9dkOk2qQUblj+TJdVS1CIW3tMXjwpvGfZ2EgMouWgTcz2afrM4m
 ojDfVCYKekEAXfsmxJmXxB8j/7tSP3/X8N0w8t00Li1mZvz7owRSVfzuBNwOVL2q84aUHsuiRMo
 rS2OokjwAkyBMisqCTsIL+zeHodH8fP89yW8pO5qs4tE6cHuQKLAevWWlUNo/IhYECP11wt91AB
 oTgWswftId8J9ODsqHdEexwnEbdAxMazerRzqnG+D7ysICFPoYgaKxJh0UTCdGnL9H88K/cVP0b
 aK0B5Nb5UyzPkt8u6vkzT/i4HHggRVcrf/k+TRMZo4r2Kz1omfz3DdRDHWzXJT2WRlqg+aBKG1o
 2uDRekyO+GCnC1YSedO1NvDjlT0aakVvWscVK/nxtiNXNixDD6ASS8YANb/LqIqQE1fSca8OSvE
 rZGcD/+vE7efrAG/TClGGgax/qKYyOLgD6OkzYMDHi2mY2gNu7bEQ8XQYBVO7B7kM4fBA1j/sU8
 orjdW8G858pBkCMdi7gOCUBvCrbOAQTXKdw0raRamLxk7IWq0FWjdyU35ceP4cWslU+eKUkPXKA
 kfv3h9M3DyeKRw2YWYZbRkV83sCteLle+5kRMh6IsHmnBV9PZIfgsxuXtFlMSieb2JyV9rmJSCq
 MBGNjmdoo4g2Xmg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver uses ARRAY_SIZE() to get number of widgets later passed to
snd_soc_dapm_new_controls(), which is an 'unsigned int'.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 1d2dce1f600c..c101d0b8995a 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3612,8 +3612,8 @@ static int rx_macro_component_probe(struct snd_soc_component *component)
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 	const struct snd_soc_dapm_widget *widgets;
 	const struct snd_kcontrol_new *controls;
-	unsigned int num_controls;
-	int ret, num_widgets;
+	unsigned int num_controls, num_widgets;
+	int ret;
 
 	snd_soc_component_init_regmap(component, rx->regmap);
 

-- 
2.43.0


