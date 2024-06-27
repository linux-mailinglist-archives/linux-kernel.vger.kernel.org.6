Return-Path: <linux-kernel+bounces-232490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949691A993
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D3B1F24FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF61974FA;
	Thu, 27 Jun 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEImIsAh"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145019884D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499491; cv=none; b=u4OVhgOM0dj9IOLDj7vDWiDerXjXOWtwFvVxm+RrKjEpw/2FN3qSifIZbV/vDCY7QKSHEyc/ak6GABRJWRy2dwK1lJNCkGS6xVxsozVAvz8+f2kGq/KXcoPESN1MYwXS8kxeYw08KdX9FoUcGqFYAxX04J4OLxIb+pAfB9OXYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499491; c=relaxed/simple;
	bh=F35vvznymN/8f2H0UImbT7wPJ9fTXmwdtHkeoQQ+rQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/1zKox+edc4NP+xtvsd94YD0HA+eo3+SIg4ikQPzpIbH3l8i01Uwma/xkpx2uoRUnseR5fGaXKPxn1T3pUb5ZrRzTqKlPxtxzs1bwJCGKExpHrKdM7FBIPNe3QF0NXHfGUqY05n6dehy4vPs9zwI7QS1MmeJtTLRyZbZL5/EQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pEImIsAh; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so90678931fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719499487; x=1720104287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlNY/dyZo4bLPWLizU4SMkpFGmMEgHoN8M4MjWgPapY=;
        b=pEImIsAhDxgFCI6FkeI5d3TNr3bszxFWCx2INF533HXvlMQzAZru9FJgUoDfddP1M0
         uroBM4KwEZEkuI/kmeM/U9eiWkiFdpK/uOY8UIuqNIohedXolPYgIBtj099XDlWR6zpV
         W/bBlH95RR2vfA35BheOVqv446AQ/9Ouv7Spts2t3SaNx+frz+oroccfPXzaye380oCa
         NzsNWzJ46WU6rhBCFUD2SpHkYY04DZfSlGzvZiFPmA56HEUuDIfVJHEfROV+tjBaSjcl
         GCRnhwNA7Y2Yk/oxzHySydbmjZjPWRrd/Dc+NEN3FFkgcD7LDfd/daD0HJTNu6XMMXH7
         Qbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499487; x=1720104287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlNY/dyZo4bLPWLizU4SMkpFGmMEgHoN8M4MjWgPapY=;
        b=t18D9//Rd3K/3GyuR8Hqemq27Lpooaj24u+qYoFo9sATYz+V02OCiVEezN//U/4JCm
         gwJwspVt+z8p071JMMQW/l1uXXn2c4ddsklow6YyB9mN+B1Oc5NxnC5Kyctyuxl2lbi4
         7qVB20NFtunnyMu0maUEqZwwau/A9tHSOuUmLs44cQiQDX4eV351G2TPej1Pfe/v3Hn8
         C/5BYolxztLJZHry1E+neukC9b2Gkzv89QRh/C4Ha9K9NPK8QWo6xldM1yCUZJLmE0X2
         +1KYsgyZJFk3qFM8fnf/bIINfVus/XdAdfn6Ooc9UCs2l0EZMAacHKekRdfsIEmhSM3t
         +Qsw==
X-Forwarded-Encrypted: i=1; AJvYcCXBFYiMfB8ty13w93HmGtu0lnhTkBJljCbWqrEGz1YsolhvAoktv0Qn1Oq2BubSeRES90i03CtNOMiv1hVVAnJtzydkoa0ZZj4hQvb4
X-Gm-Message-State: AOJu0Yzy5B3I7DWV0BQh8yor/kbDpS7NyWSyRRouD1eI0T+xTjZ/hc4Z
	HNizMz40Ft+Q0sobHs6En+F5H6TEqz5Tm4V+23zE5LQWuEUGnTNLxGOloLUi8GQ=
X-Google-Smtp-Source: AGHT+IF7MinfYvXVoTXJi5SETWWXqYH/k8D5k7VHPbg+6myxhpRpGj2sS5YLKdpHsMBPQimcfJStLA==
X-Received: by 2002:a2e:bc88:0:b0:2ee:4c72:204e with SMTP id 38308e7fff4ca-2ee4c7223e0mr13713361fa.0.1719499487248;
        Thu, 27 Jun 2024 07:44:47 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b7b7c1sm31254075e9.23.2024.06.27.07.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:44:45 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 27 Jun 2024 15:44:39 +0100
Subject: [PATCH v2 2/6] ASoC: codecs: wsa883x: parse port-mapping
 information
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-port-map-v2-2-6cc1c5608cdd@linaro.org>
References: <20240626-port-map-v2-0-6cc1c5608cdd@linaro.org>
In-Reply-To: <20240626-port-map-v2-0-6cc1c5608cdd@linaro.org>
To: Banajit Goswami <bgoswami@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=F35vvznymN/8f2H0UImbT7wPJ9fTXmwdtHkeoQQ+rQs=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfXrYdYtEgJSwT/6tXfD237j0hmBqYC3Ai+LFf
 uvQizkgZgyJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn162AAKCRB6of1ZxzRV
 NyDtCACJtoKKlxy2htKGj3YtUwpRZwvO/uEyIApp3T8ZS37ZV/CqYNLXodSsxp/aZ3+YqxD/ZGH
 995VMVZ0aB5Z9TL63bvifep1aKuH9nyJuQaJFeRqG3vMyHe22T+ODBZlxOeHxl6fCs3eTv1XdsP
 kPGFKixVGZFfP33jxRmndIphWK4VCm8LijB1dp49PkK33wJ3UWQ/hjXVwEh2/FsiQr8hRXVPZZg
 3RftzNggXmHQ1vvnXibfpibFeubdq4GJYNILbUurD6dW8TjopF+NdbWGew15Kd0q44Z7CEXznn2
 hf7pVnjeNmV+DdPt1F1fjuyGXdAh4mCciyK86uBNCfklHoIp
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

Add support to parse static master port map information from device tree.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index a2e86ef7d18f..5443a5c4100c 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1399,6 +1399,14 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	wsa883x->sconfig.direction = SDW_DATA_DIR_RX;
 	wsa883x->sconfig.type = SDW_STREAM_PDM;
 
+	/**
+	 * Port map index starts with 0, however the data port for this codec
+	 * are from index 1
+	 */
+	if (of_property_read_u32_array(dev->of_node, "qcom,port-mapping", &pdev->m_port_map[1],
+					WSA883X_MAX_SWR_PORTS))
+		dev_dbg(dev, "Static Port mapping not specified\n");
+
 	pdev->prop.sink_ports = GENMASK(WSA883X_MAX_SWR_PORTS, 0);
 	pdev->prop.simple_clk_stop_capable = true;
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;

-- 
2.25.1


