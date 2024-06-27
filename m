Return-Path: <linux-kernel+bounces-232255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C0991A5D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00229B20B21
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DCC154C0A;
	Thu, 27 Jun 2024 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXtqHyTk"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3314C58E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489364; cv=none; b=YA4vBsxRPmQwW99Ln0McMO4R/FGLuKFg7j0gVftXwXHOJAgwopxEYRdnL/CkylVSjUH6xDoSHA3wiQp2iOFi2fEzdxZFRa8MzErWjf4GhcLIdkOo6tafhZNTuD3xBZJpvKj4ZPIGh+GroJK3iaxQtWrcEsvR2MFIsCC38qpvyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489364; c=relaxed/simple;
	bh=9h2qcrpoMJqhhywZCecMu80SrM7XnP1kk9SFCuNDm9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggY9Jqk4O1/BMXbefn/CJXL1Yv0vz8ViusQk7XaJ81TiKy59OJ/v4AUbXiupDxtlddqyi5F7aT+LvKvgHoC1fEovkcFB9HiTpGlWGNmsTi2Tgg1k2lfxlyNx3oVrdVTTZmDztHuD+epzlgfayfEiwcgiSwzYc2cf6YcA+6Q0iVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jXtqHyTk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36742cc9c12so481280f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719489361; x=1720094161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQkTyAteb5scd6wwSGd6gcSdcAYbAHAYfVMyNIn/xpY=;
        b=jXtqHyTkwGLX7ro23rrKkwZoQgYAEjSxbeKmDxzw7vczM2ubcry1ahSDX3uLuWNxzJ
         Y5BPouvzhS2jmV1ZuIfBPZ016bwr1sSiP1hLzueD9YAY9EuwFdgfw/4JKdjmWP36SYgY
         NGdDXPp4QzuETGd7fDI6WLHuoKQE2LZFb3G1DExESd5HJ8SRNLxgzpvF9cambvW27yuJ
         M4QakLrJMJuWNHw+2orwQIxnTTyLjd4wDPLZB1qAyKulQfQMWFTyIm5jFr0fixfIxg6y
         zpJUNbMZ+jaelSjnVujbvtBYPqRrguonW+9Z0Pp0fSf+zdRrYGaxZ51vfgABXqHWqV6t
         umxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489361; x=1720094161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQkTyAteb5scd6wwSGd6gcSdcAYbAHAYfVMyNIn/xpY=;
        b=flyJCgBzgu1edrauL8EDmdCFBN8u4KcGtyIWKT3nXkiNeskEVeG2xQYZXFwjt3B6tk
         N/e6PsK0k5oB7KVM/KH6NoVbjejkNAhpv1FDvJuf0rF/z4Lyt94kDHn7TUz9TqbmKnPs
         bNsQ8TNl+GxQRlj9Lpcc09EWufY4U/tiSSAlSbNr25f9GBFOQvEDViDpBvfInhm+putT
         AkGsAIEJw46HCrH+52fM2zKXA+aaTY+ZGEk5rW9jqs7jmVjucu7rz4iyiVKACULvgR2j
         arSG5a3hfub/S2T1gCkcKP4N3GpQnKkBdD2aBa5G9QZjOxg0sY0X9HZGl+QscLrfTzy+
         aWFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzSdFTyPvmVIDKMx+34giAJbu5YyuYybdn6SYvq1R9eR+ZlkJtrcMQdMjUv+QV2cnZvYUXvO10tMP0NhOp2ghp8IvQPIM0Gc8YRJHd
X-Gm-Message-State: AOJu0YzB/RILj0tMd/135awqfdEbRl7G37zr86DtehFMtEHhBxGrg8Ge
	OO46OhQL1iCiF3yDurLcOat2FgISPTVpRb+gMlXah5Gx9gSnYRJ3H5XvIGIgGPo=
X-Google-Smtp-Source: AGHT+IEvySmQxU5UelHvcHtqpuhdOW6EjC0yNYf7f6/v4w6iuTt7cS5NAQr7ZFDjG5jJuRh0GQh/YQ==
X-Received: by 2002:adf:ce0c:0:b0:361:d3ec:1031 with SMTP id ffacd0b85a97d-366e94d152emr8445646f8f.31.1719489361249;
        Thu, 27 Jun 2024 04:56:01 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674369980asm1597552f8f.80.2024.06.27.04.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:56:00 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 27 Jun 2024 12:55:18 +0100
Subject: [PATCH 2/6] ASoC: codecs: wsa883x: parse port-mapping information
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-port-map-v1-2-bd8987d2b332@linaro.org>
References: <20240626-port-map-v1-0-bd8987d2b332@linaro.org>
In-Reply-To: <20240626-port-map-v1-0-bd8987d2b332@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=9h2qcrpoMJqhhywZCecMu80SrM7XnP1kk9SFCuNDm9I=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfVNN/jaGM/HtFpEzFVuUA0E9budoN92MdAdGO
 mqOUIOy79uJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn1TTQAKCRB6of1ZxzRV
 N3B2B/sEKGfd/FUn+br9tS/11gSupaR+3TgZKVnsqecnVlh9xuS9uT9XOYzF8NhJkYn7BzDXbLD
 zVD8VM+FKHB5ifuv2oYHSG5kGFIIYiOq6i72J4i44116J56pFw6/e0FvJBGELqiq2Nre2WVkLRs
 GXYDIWZBI93WkhUuULf6Azo3RCEbUVtwwihhfOCt1NKwz9d0hFRL5m//15I4AWvhb0jSnuVkcJw
 DTec8AY81GsgGpyq36I6j+rubCfQAX2Sp4rygiir/0p7jUot2XCCHDqA2tQdXpHzLedQOTOV2ox
 fy9pJsbObZCRchRYg3rGH7l1lcq22UEHaybqVmOf6WUnN6jy
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

Add support to parse static master port map information from device tree.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index a2e86ef7d18f..43156d39480f 100644
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
+		dev_info(dev, "Static Port mapping not specified\n");
+
 	pdev->prop.sink_ports = GENMASK(WSA883X_MAX_SWR_PORTS, 0);
 	pdev->prop.simple_clk_stop_capable = true;
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;

-- 
2.25.1


