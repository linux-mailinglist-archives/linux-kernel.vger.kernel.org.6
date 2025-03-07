Return-Path: <linux-kernel+bounces-550644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD99DA56263
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F4C1897C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22F1B3929;
	Fri,  7 Mar 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMBMPdqH"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642221A3A8A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335253; cv=none; b=RpSUF6x6zN8eI3WOivzDcvN9541odD+RMmyvQLN+zyoK8ZbTYmpeTzKnIl66bGt58EBMqJo5RsfD+Njf4AbqpS3KVKOU9XT3owUNTnzvUr4bE2qwDxyw7eWZ0xb5IK61fYayu7udN6Rc3Kd9oyarDaV8y+otJpVNVYLP54/Sya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335253; c=relaxed/simple;
	bh=ifGvzz7OBeukTcY2WHZgJTC0sTUnzBW2FA4VRpqiGVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ce+u6IMYNRr7b/2NKJH2Cor5Q5j207kkkmlNnH4gI6TmbW4qMhAAZvXAN0SBtNoAlsAqFJAGAm2q5+6eA3igAJrUC4p2vwOaRsze9J5DzkJlr/SShq8IopUNk017vaI7RyjymVVxDyh6cTsxX9eESU/Cy23YjYnoyLe0J9+aT6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KMBMPdqH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bc526c7c8so2041825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741335250; x=1741940050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dC1LPCsdF2Z42Jp+jxNOAqnbNIqpSsoAUsorj5VopVg=;
        b=KMBMPdqHIcvtrRYMqa1cuM5cYuFr4kR2eMIkNJiGRsCjrgmJirF/zIWLq3aHvzdqlY
         RZyeCv5Ki8zgKhMJ4mgIO9rrG8heCihpx6qyw7Ohu0kYS7xSg/MBycQ4V7jMUO+IiIMg
         KzIp+sgisv3yxD/v/UVEl4Ie5opmHkdAvTEARu/7dnIiQr+feSEzt59U9oAe9g7h8k2g
         mgFfgILr8JQnX0CVmBaZsmETUM2cEfLVBolRnW5k4h0Hvz2nB2MkIfrzdeZegyefahkS
         3LZ74EoL+FjvgL4gbAvfiuQVV2rIeh8JGVV6pUBfR+DW/uEZfC45uE9bmW6ftu6iFO+Z
         Rruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741335250; x=1741940050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dC1LPCsdF2Z42Jp+jxNOAqnbNIqpSsoAUsorj5VopVg=;
        b=B/LB4ar8ZV1v1kMIC5/oJMYsGCd7610hzJXWZBCEAQjZil2Hd2A5jsYnzgGwkHsX1d
         HzRtWVrV6xH3KZa17zXWcZMVlyP8sQ96atURzAQo82sMcd0Y/VpMdeKF315esqFwS6cr
         kgPipefNJxCo9PoMrX1X0Uhm/FcfkBiRM6++kfe1CuPxGspDP+3QMAliU8BfQuvvwnXk
         m0TMbSR9gSwG+U/ZYbtMIc7H/uYVSvD2dcG6r8XeZCVQaigj3MCkGGSsWU2Q0YzlWV7V
         nqvnw8CUdsgjarx3wCB30bG1JE8C7Vv7wn8IOsy/5sG4H+5HPzqA3Nyp33EQCmQlwg4V
         clRA==
X-Forwarded-Encrypted: i=1; AJvYcCXn0f5bz0QkyfD9U9qQCUiojwXiShHgKZRcViLPSQUjQtGP13md7SzAw6sPdo0CpnLnK6htc5Wqpn5lihU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyqd+X/3E8g6nDucQidbvdHV/8kEwdc9Rrc+CibvWNfL/ohPfL
	nT0+vjEXmlEjc3Y6EMl1RYTxmpbwv5zHxUElcoPDMTpM9bPBQA5/Z5P0Rk+djgM=
X-Gm-Gg: ASbGnctteUyB2ZK5+i8LXrumTkFf9TRaMm74oYc7ncqBCJH1VbisZywkGkCEMcgEgHe
	5Ib3nJ0LGMdEPu5hxl8/TZE6gtasQxgtYErWaUL0bdCXEb7JUB5aICLRp3YLXsGzm58JsZLvSuq
	+1ZXQBZcfrbMmKz3lAGeAdWbGYFCc2gCdMJWB9vS4LcmmtogHSOkKTZfzKydFr82oT6TigfA2Ud
	o7LZnK+Wi09vRar+tJlPqnKy7dZ7cXnpeauUoRI2bEPuN7HyU3ZzfRnsUuxI6vrQfjDvoRfD/Rv
	pwXGhFslHsZCQ/pZ3RFAUId1dNT+FtjgRHyg45wHNRsYhQuAZTnHelzw1Ew=
X-Google-Smtp-Source: AGHT+IHUpH+Xyh16N+1wZEqp2m7qpL812EuSHBMLvRKqepcXSU9SdbYHDp2gAq5aCXZu0H8xpH08Dg==
X-Received: by 2002:a5d:6c62:0:b0:38d:be5e:b2a7 with SMTP id ffacd0b85a97d-391353f0678mr390435f8f.10.1741335249622;
        Fri, 07 Mar 2025 00:14:09 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cb82sm4691799f8f.51.2025.03.07.00.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:14:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Daniel Golle <daniel@makrotopia.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: rng: rockchip,rk3588-rng.: Drop unnecessary status from example
Date: Fri,  7 Mar 2025 09:14:06 +0100
Message-ID: <20250307081406.35242-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device nodes are enabled by default, so no need for 'status = "okay"' in
the DTS example.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/rng/rockchip,rk3588-rng.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/rockchip,rk3588-rng.yaml b/Documentation/devicetree/bindings/rng/rockchip,rk3588-rng.yaml
index 757967212f55..ca71b400bcae 100644
--- a/Documentation/devicetree/bindings/rng/rockchip,rk3588-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/rockchip,rk3588-rng.yaml
@@ -53,7 +53,6 @@ examples:
         interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH 0>;
         clocks = <&scmi_clk SCMI_HCLK_SECURE_NS>;
         resets = <&scmi_reset SCMI_SRST_H_TRNG_NS>;
-        status = "okay";
       };
     };
 
-- 
2.43.0


