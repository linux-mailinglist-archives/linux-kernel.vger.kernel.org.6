Return-Path: <linux-kernel+bounces-304690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D745962396
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE70B1F25E41
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C901167D97;
	Wed, 28 Aug 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOHUc3VU"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747DE165EF2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837770; cv=none; b=QyUYokQeLl+vsv4dkanpElt70ox5HC1ezwTuXUyo++ykHKE33Zz1mPXWZHGWClmWKZktHMaBfqu2RVVmecu2BE/Q+vRs1OmYRgNc0z+zqcVnAwjmoeLKSw4YdMZ8PkG+jJCsV4QhkcHFOKI+84OPBiYlH20WDGw2fsK32MNYow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837770; c=relaxed/simple;
	bh=lLvVZWLA94nZ9XmjPRVxXb58c0i91Nnl65/obNUKLV8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dWDJgEEtiUYW20sQXV73w9rpDc29qa/MXoWeyUa705y4XF2+VJhQOU/sBdeq5k+DydmEd+PMQ2Xq9M1BKvjCTxffXU62ZhaiPNFhL5kxSWOc/4fCTBttffeTzzsqZd6vT5shnBCcCbpAfwZ+MROZhPOEup/g2kqstVt/iB7LyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mOHUc3VU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42803adb420so8141075e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724837766; x=1725442566; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp8qzlM7kPhcJ9e1hKIRPohu0dawiY3efvrm0vcGAng=;
        b=mOHUc3VUZ39yeQKv97m4NqZEhoOySjlzONmZOnElg6umjzbn+AID0+JlvPBClD/vvk
         IB0IEFOpvdMHmbwLbfbsT2z906oeVr5tnfp+IGUst9s2S5L7f9rRk04iB+M/DF7F/wjL
         d2HDtsDTsRcH6eZhp6Qxdm+rk52f20uqD0v62n/9lVFncw8tWx8ps/tVWJXwisOsqVY7
         6G9PoLOlxSbCuSuY3EvTdOpJzwIJ3N5S+PA5DPPH5/N3wZZtQhV4R/7DK8GroQy8M53G
         Tek10fYYwTb7jIRss1NGPdTVbpAEue2F4VgTUHJ8j0VRBJAD6tkAmAQjAOBiHruUwVv2
         atMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837766; x=1725442566;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kp8qzlM7kPhcJ9e1hKIRPohu0dawiY3efvrm0vcGAng=;
        b=OAQ4AT9bvLpOOLqYc+XdEIxFmXrOLCqqW6veHzq2oDPHCabAWuH1XMoMSz5VUakjgM
         NEDYKxPYV0b6qVR+YtJeRoIPK/BF/mlbVMVIfqetw8BqTS2WYgtvDbKJM6nb8w1M1HHz
         uPtFJlQq2hvH1c88JzaWITZlFwXe06aHpujqBKLQCusMj6JgZ7jBuC5D1PGrNpdVb81W
         Cb4pU4Of/eNCjZKRDLgz3IAfhcPNpNtPO+0/dZpf5wocXLAxBykq12utlfOUQgKhZ8aS
         wagRdvHfyur5R1kX75XQagRW8ofbYrxC0Ij7gy7Ny1h/D9VFH9rFwm4T04NuPqsJVSaV
         Vshg==
X-Forwarded-Encrypted: i=1; AJvYcCUwVMYLGbmrX9VPKG1WveMNv1ghKcO4NeWYwxBGMDagCvNbP/1MrSrjX+lDcm/rLiPueRndy1aWSBC9gvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjlAWnR1mLmlc2G8qRSd2BvH/qAiuzi1bbNPa1S6yiDC4XPel
	iF3cbHtJKyq2Jbzr9w48CUip3IBUyBCWB6+QMcg3WXZ/f0LKfqALZgfzQss2c10=
X-Google-Smtp-Source: AGHT+IGoDsdqy8j9+OnIPj9MpjKsin3XMlSfq166GCfQGpaVuIaeJ6QaRw3LIgNycTwVYzwU8jICAg==
X-Received: by 2002:a05:600c:511a:b0:427:9f71:16bb with SMTP id 5b1f17b1804b1-42acca17489mr69343365e9.6.1724837765624;
        Wed, 28 Aug 2024 02:36:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63d7d3esm15270825e9.37.2024.08.28.02.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:36:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] dt-bindings: gpio/pinctrl: add missing type to GPIO
 hogs
Date: Wed, 28 Aug 2024 11:35:56 +0200
Message-Id: <20240828-dt-bindings-gpio-hog-v1-0-63b83e47d804@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHzvzmYC/x3MQQqAIBBA0avIrBuowYV1lWihOdlsNDQiEO+et
 HyL/ysUzsIFFlUh8yNFUuyYBgX7aWNgFN8NNJIeDRn0NzqJXmIoGC5JeKaAmmZLht2sLUFPr8y
 HvP923Vr7ABWHv1tmAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lLvVZWLA94nZ9XmjPRVxXb58c0i91Nnl65/obNUKLV8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmzu992mrrPM2WxuwVtWclMQbM8qZU+tTUPk25H
 UOxPSA2JVeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZs7vfQAKCRDBN2bmhouD
 195eEACAS1+/AYVFAiRhEC9zw6dnuj7PARvegrA15YKhjMoXTc2ElDIgHxhb/2fTde4RIOlhzSt
 A+3xOss/CRdrGQWU5BY0nv/gMMnhIR2WZlPdcn9s0OP1yp4rtTT1RtIaMYWYWXJLhhwqdxe2i2X
 F2e78YGou0d/lcZNZVMtiJG7rIKC+FubeNfzcPM22wdUS638O4YLausVhdJlRkJA9nCUT238MV3
 m0BGeKbFBEQZq3X5gLkyAiaLXhnwiqicHcyFvhsKu/wlF3+xPyqKXvAaMcOejkA7B++kj4//3zI
 qE9IFSiNQG7DCqL50WXeiVGj/zvV3nPfJFRbth1PDhTZYZw6pbsyylg4M9bkRlqUjScZIa1VvVH
 eq8nGwJLnDMyQZzGGya1bo0wxSYFC4G4b3GmU6PYV0UrGpAGd+iCPBNexAx46Gyyh06cp69dQVT
 W0yk6aZ4L2OHdS2CNu8ZCG/VDFoDnbfe80NE9Y+ZdRyXswJxnlj+tF2R9bv6kMKspL8F+DKhj8u
 +pGMjsgDxXC4J9DDQabR+EUFbsq8uoOgFWeNxUeLsVVwb4n9ZyFeuk6rhRuGpGLrHbNCauUVEhH
 se7ShE8UXBteVw6sAwyDCMaJoHkojpB54wCM9MzAskg5rNpKVdRHKRWOiJhcGqYXwcrp3IQi0Vm
 Xz2eQPo8pq4HlnA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Merging
=======
Patches are independent and can go via different trees.

Description
===========
DTS like:

    device {
        compatible = "fcs,fxl6408";
        dummy-hog;
    };

should fail, but unfortunately it does not if "type: object" is missing.
Add missing type, so this will properly trigger warning:

    dummy-hog: True is not of type 'object'

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      dt-bindings: gpio: fcs,fxl6408: add missing type to GPIO hogs
      dt-bindings: pinctrl: qcom: add missing type to GPIO hogs
      dt-bindings: gpio: simplify GPIO hog nodes schema

 .../devicetree/bindings/gpio/fairchild,74hc595.yaml          | 11 -----------
 Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml      |  1 +
 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml     | 11 -----------
 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml     | 11 -----------
 .../devicetree/bindings/gpio/microchip,mpfs-gpio.yaml        | 12 ------------
 .../devicetree/bindings/gpio/socionext,uniphier-gpio.yaml    | 11 -----------
 .../devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.yaml    |  1 +
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml          |  1 +
 .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml     |  1 +
 9 files changed, 4 insertions(+), 56 deletions(-)
---
base-commit: c79c85875f1af04040fe4492ed94ce37ad729c4d
change-id: 20240828-dt-bindings-gpio-hog-429a28eb94a2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


