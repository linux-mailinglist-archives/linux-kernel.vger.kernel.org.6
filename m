Return-Path: <linux-kernel+bounces-276079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5C3948E22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4593F28A741
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8543E1C5791;
	Tue,  6 Aug 2024 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlZ41MIW"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D451C461B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944985; cv=none; b=a9BG3JXeRZtqu9ro3bpk9+K0Q9AtF8fm/LF4OJL79ryAjpU9JQkAn1Nde36OB9FUjbqJiTXb5hhgGAaAmXiPKu8gDOToSImpCm6uDflCTUG16tNtmevACCEj4QmgPI7EZqtptLkHOWJ4R68FJErS46XjrMeDPVgId52cYPZeza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944985; c=relaxed/simple;
	bh=Ezp1DEESNAuzSnaq1SG6uwRupUnI1fkxIZaCm2O+49I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT7OKrRUVlkA5KtZom8Ncas1YbF3NMOQMuUz5sL9ekGCWztGw6+he5ZzmXxE5a855qA3a+w9mlB5NuCUc5tLN6cWCxQicxMqvpnrfIhTMrUyyB7MZ/mx0p9OFdNFrw1oj0VsNkQ9EDURFGDqLx2x3CFv6rS0H1xvSA12pxR+qtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zlZ41MIW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so4233555e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722944982; x=1723549782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMlV2qVo85xWYVBMYhrk0PfH/1B6nF4UrxaGSSozyTw=;
        b=zlZ41MIW91eleJp6jQ/cNAGsszGoWa1MyQY2J9lpfpvVAHZJN5ygagEcVSmOHAh5EJ
         MRhlrZNm9cpce2/bhCPIcHMSH/RDF3eABEiNm8Mkx2sX+SaVIJ8na8J4aToA60hf9Xdg
         Tfyk/uKY0eggPguFHx42CUzxeqIrcQM4KmbD7cNvm7oT1Lm1qHfMO9i8WLVUtpEDfQ23
         3JYIZpM7zSqBHPNTPpBRXmwafNJ30pwPubjlMFLnBjtRQlb7wZAMMi9zyNOyZ7zBzkqT
         67IjJAzjeT0up639F395Qjb9t2HtgrYg8QGTQBAt4MSbYAI/kmd1Xuph80Yj9iJTh7id
         /u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944982; x=1723549782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMlV2qVo85xWYVBMYhrk0PfH/1B6nF4UrxaGSSozyTw=;
        b=h5ts8lIyp+LkmGb7lGheqgvl5wIH5SAWPuXQOqH0UDk3LSVe1jq6yadHfcRW+AqbCl
         GTPTFBzS16NZyrRJDpNZLWueMivxJGkDEzJK5iRK651lsd/QGUfS9hv6nj3A/Axn2LIt
         j+pl9tOaZFFv8NITYE5djnpuyf7Uw2dpZGM9r8laj+KrmgAIW0QZP3NCzEbFzG+arq/H
         nO57o9cIJznmabaUwARvT59lqlvRIt/mQnkunoQKw9PfWLlCFQaWA4YlHxPYtH3YHDiu
         yl0vNnB+boptMstjNIj/FmceXwsSHXhgJaI3qqd1hUlgpeSgGb2Gt6PX0ChxsoHA9UPR
         32ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdkXmM/pVgbUTi1d/r3Sxmz4llxf827H+44irtwgbafp6+DP3RwBZCCgO4ITktmwLeZ9R0SN0HJNjqOH9Gcm9sGyUS28YGlqzi7R9c
X-Gm-Message-State: AOJu0YwKkdqEbgHfBAvUfAHzPVDBj55GwjSgrm64DnJ2US+oBpg2fJEo
	OLBtDpppRNdZZB6Z9PQpUruiJz9XqIqGAPjzpRH3T1op7nrXyoelwPprqBnKuNQ=
X-Google-Smtp-Source: AGHT+IG0OfTvajOEg5ehvoF4v0jk7nAbAB0WzN58qCZhXcth2JhU2Xeyj9qeu3b8QEUJOcwwmdcrrw==
X-Received: by 2002:a05:600c:444f:b0:426:5b3a:96c with SMTP id 5b1f17b1804b1-428e6b78e3amr101124575e9.28.1722944982501;
        Tue, 06 Aug 2024 04:49:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm180287485e9.12.2024.08.06.04.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:49:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] ASoC: dt-bindings: qcom,wcd939x: Correct reset GPIO polarity in example
Date: Tue,  6 Aug 2024 13:49:31 +0200
Message-ID: <20240806114931.40090-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806114931.40090-1-krzysztof.kozlowski@linaro.org>
References: <20240806114931.40090-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset GPIO of WCD9390/WCD9395 is active low and that's how it is
routed on typical boards, so correct the example DTS to use expected
polarity, instead of IRQ flag (which is a logical mistake on its own).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml
index 6e76f6a8634f..c69291f4d575 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd939x.yaml
@@ -52,10 +52,10 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
     codec {
         compatible = "qcom,wcd9390-codec";
-        reset-gpios = <&tlmm 32 IRQ_TYPE_NONE>;
+        reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
         #sound-dai-cells = <1>;
         qcom,tx-device = <&wcd939x_tx>;
         qcom,rx-device = <&wcd939x_rx>;
-- 
2.43.0


