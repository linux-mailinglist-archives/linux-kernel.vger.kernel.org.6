Return-Path: <linux-kernel+bounces-304691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE25696239B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FC32860EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365DE16A37C;
	Wed, 28 Aug 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNpDDIDg"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60271166F34
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837772; cv=none; b=UHr3hk4Rl8pRGj7mhJxr83rN5N/+zSTos88nbhCw9++j8tX5WBmsUTtLXlY/N9ytDZBYQ3GXGl4WXBrs7WktsFLttsGyKglvHBIEq0DJSmz2iwA7DIvxbqIRrK5R367zAQNhbcXj72XEVZt0qSU8o5SDCqOSN9F9mueGhpteQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837772; c=relaxed/simple;
	bh=kIOSKTwBhCJNE2xIsjLzrlpi4h7Kklqz+lUuDimv5hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QvUlmag5Fch6a52RtLnk/UdAkDxQ6LtQMxI1WIMnzMwltSQ8KQ1u/lKd8ypbEUuXGlTKIehrJXIzJ3i/3BLDhgmDTEKq4kQUu32fspUEePcu0/pfEM8Q+LlhosRHPqqXHqJ+YofogNmXyQbbv76HFiQoe2xKkyAP0FGVfXXQljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uNpDDIDg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42808a69a93so9210575e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724837768; x=1725442568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hC9j7IbumBMQnEMKyG95jmRuI5phudBOANwkQ4Y7dbw=;
        b=uNpDDIDgie9oXdHelEwah/xJEwmTXmBOsvtCfa+dv8Xkp4aSJ+ysaGH3j59FZUEf4d
         +wTokVCmAkqZaeRiWTWh1UeiC0MqAdtRsaBWuzYc6YImggWu5biVqgmE+WeTFlxsRGw1
         Ua4sQFrFWyoIXbIm4bFb/3vNVOpFUX2sNiteyfplX2iQeFC1UF0Su0lzQHw+h5RdZHwo
         qT6hQ53T6rA6KASN/jTMxSksr/F9pyJy5FJ4zup2skNIgouVJH/V2GoXjUYLkoTyuDKc
         JsreFFyPmie42ipY/aJApZa7j3dWTSc8ZQYNRb4h1m4/cMQxwMJWbPNr2UWZ7TTyiIaq
         FWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837768; x=1725442568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC9j7IbumBMQnEMKyG95jmRuI5phudBOANwkQ4Y7dbw=;
        b=cZ3NM0Gdv+hLrFOukiWAmJyWqrxYDKp+aq7qf4VK8rYy8hjpO5dNAksKKrECHLQFMZ
         yEkZrHUxliSosUdiY6oKKE2KczuISrYuy3Q6YhOIMTeoyr3R+/iJ7SM7L1M3ePsKfvYn
         D5ybCw1Otfurz1fm3azjaL6ZST1Y42wR4PL+XW6qaQq5IG3dKyfJrYI/d7z6Rtrfm6Jo
         ueRZbpaUkwaDvHCY8lXPHrgsnuqAxpoaD1G+7f7aAUvrb0YZqQS1KYMA8ot+lPIz3Z7D
         nVN/5yEHByNME/6X9jYeco6cRKTi208jSPwVpjChvs9ZCGj63dbCDBL4mnliBAN3x9Vd
         VUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3J6RhxtwkMw5gmxBIqqGWBlfw7Mql3ws4yGBdkIgzQGg5j98EzZK3dQ4h4lpnlvprjJ3aE288We4YKIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Rwsq9skt70+KjB8gyXynUDH8sspV0KK4/e5m2AOdD2juVBaD
	M/0RbsH+CdknWPTns5fbENprE7efy9aahHRpPKaFsLaeOIXqVE3dhPyjh4YcJNA=
X-Google-Smtp-Source: AGHT+IEB05FnP91FMO0l2HovbTESQKRe9ADpJRmnFhcHlQ0GZzcE4pg5vT+W4mPVe8NOnL+reyup/A==
X-Received: by 2002:a05:600c:4445:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-42acc8a55f3mr70030375e9.0.1724837767566;
        Wed, 28 Aug 2024 02:36:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63d7d3esm15270825e9.37.2024.08.28.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:36:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 Aug 2024 11:35:57 +0200
Subject: [PATCH 1/3] dt-bindings: gpio: fcs,fxl6408: add missing type to
 GPIO hogs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-dt-bindings-gpio-hog-v1-1-63b83e47d804@linaro.org>
References: <20240828-dt-bindings-gpio-hog-v1-0-63b83e47d804@linaro.org>
In-Reply-To: <20240828-dt-bindings-gpio-hog-v1-0-63b83e47d804@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=732;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kIOSKTwBhCJNE2xIsjLzrlpi4h7Kklqz+lUuDimv5hc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmzu+BI3YnNLbD7GXCWVvb8IPUEsEVvnR7tGUMm
 fnaF2hkquWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZs7vgQAKCRDBN2bmhouD
 1y4RD/4kIDO9WQFkJe5J0o3puadA1mzoZjLceOTI/W6erd4nCkfkBl8dLOOsbEnNLqQdlS3svLt
 b3P4G7aRcKvhJxZkobZptlNOGxppkpJd4FD0JishQcRytMjO/fFUk70suDUcJBRJ0DjQ4IE3yv5
 0Dt0Typ6dj/ifqw3Y4jRd52LsawOxWfBpSkKGHPgTmpup6nVCsERkF4TY4rweGSasxFVpcXGi9Z
 Pihlg1+DTXQBEfVDFWZe5VuBX3aArl6cHPi9AlV9O2WpvNe2wYaGA8adpUChHqGUS1OQPsJDzq1
 I6FIZS3LCjCEBlFHHuCkchxpWB/3/W7+YqSNfRrS0qby+OCzMH6F55BpTQIAxxtanAJlC62naDv
 9bbxHIppITRogk9zPZTsSeh9IDSbYJ8wFoySiHQ81VlDi1VAnmpPbU7FiQIU+KeLoSGx8woo4b1
 0h46g4jd+wRdqAcUUqgdJ3wexn8BHvEz90abuaSm2KWEDSE+h1iTJ3LNDFnXRszUItkoxtqiqH2
 3HBN5FzPcaPowWVB3iHDgzn7VG6mM25RfaH3NZmvaPkYxoi44gVBwDRhaYzlAkjGwrlCsY4IUh0
 7HhPxrhF21phN/6UOi0Q9FP+lyJaZyhaDn7H33i0AWS30xtf62ttknUHPWO1lQtxaI4DsOwnfr1
 qb+psbOCgQcoMgQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

GPIO hog nodes should define type, otherwise "dummy-hog" boolean
properties would be allowed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml b/Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml
index 65b6970e42fb..b74fa81e7d05 100644
--- a/Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml
+++ b/Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml
@@ -28,6 +28,7 @@ properties:
 
 patternProperties:
   "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
+    type: object
     required:
       - gpio-hog
 

-- 
2.43.0


