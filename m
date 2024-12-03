Return-Path: <linux-kernel+bounces-429407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD99E1C39
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5DB2A5D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52CF1E5721;
	Tue,  3 Dec 2024 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6KLJc8k"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FDB1E4929
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228035; cv=none; b=jvxAH9wiransV903sihpcJY6PCCdyEcD6db6HKw5KKwdn196zNyZhH6AJFMcYHsK3IplWpZ3ednBLzjPejj911FbPcJVnyDqKmZRHavi8W9QtOJZYnnwEZrWtt0n4Cxmu6LczCfaNeosqOqrKw9f1DXqR4s5v0+P9YOu1i09wRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228035; c=relaxed/simple;
	bh=8f1ebbMm0N0iPdui/HfTmFaUKVc7p+YLaRGLnewiZls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9TgHLvlJcZbydselnMkPK4Yjn/2qvnS+31r/CbFqNEEmHeoc9ZszFQvkMKPz9kumuIN7roVKSWlnLeEsgop0WLowiJvcNf1OS2hepVdEkD+N4VB2BGi2ynHhdATClRHwhmTJ2nHQdnuIs0O3kp9O63lQjmfiRFi1rnOiFYhl/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p6KLJc8k; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de79c2be4so6499443e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733228031; x=1733832831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxSILp22APpVBx5tHexHUV/Y8I0r0x3nASsEN7dt3nk=;
        b=p6KLJc8kycitWHgF6pf9n7BxxwlxjxDDYGyL8h3P7SWc56JugB4I3u46+eTDtnnojR
         KA6cxNihI6IlPj3nfwySEOTVR60EO9TIViD/oVCMFhSVDdHLJ2sOADGDgjPZTHYJLgbf
         FObkck/D4UaFGN1IjsOk4GLnBD7g4HSaFyboIivrOJ8OaoX9E968LjdEgA2z7Tm8c45t
         2jdF86rHxKSDPKAVK/W55Cj4rED1NmQz9ebkpdRYJi8d82+oABWiLPFlg8emlkQ7AfZW
         wQfqeuAiwejkCyYa/wQgWrZcfobeM25G2z680AaqUjdEnoBst1/4J3bh4H2MS7f3Eho2
         jhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733228031; x=1733832831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxSILp22APpVBx5tHexHUV/Y8I0r0x3nASsEN7dt3nk=;
        b=fJYvJm+GzmlRaoNJvOW4fooplNQN0DpczTFmaLzAe2MiXDPqR34IH+BziqR36APScB
         5yrYXfc0Lq2qw/h6gSunITiFeBhAA1rh0b1Ai/BqHvAGigrRQ9Zxhk2Hp6soYSHrysXS
         hDIXlqd2jLbMF25tm8mm5UhhnIFgAp5PQeW6UeBGrQupwy2YBkEuIXp0gLYFHLc462dk
         ewPNpwAnvPM8LKLjow28c7ghkIVdvlveg8QbWt7mQFlbW15U+7Er9MOqD35dRvvYdXJ3
         m63JN23ShD5WxLu9v95BXzVoea4O3K//CCqJWt1ZbLacRsFskqg5rw+/wGOzh6vmE6/g
         J8+g==
X-Forwarded-Encrypted: i=1; AJvYcCX5m2TxCJq3Fm/Qvsob/9BEtG2v0DHOSUay/2NOpna+P6RCPSs9id6InZzhD4ZgiQzn5DBvvPU5865ZgI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nOJwE6P0UVGZjvTp4CcqdzG3O9Sq/DXrx9EWFWkKQkFMERJs
	f6zLVwmcbvAeTrV4I/aEnihHcUgj2tkOMgL5snoybH6kF83+yKjuEaSoGz+C5xw=
X-Gm-Gg: ASbGncvxxHGoj7/aPdCGCTGa+mXVflNtYxxbhiGP8esNr13dqtqjDa3n2a7Ck4lcFDG
	1bQQYa+ZORDjqjg44AD21Ym3nS8ar5HRlzjmEV6tq4o6UhUOQPIrb+TyC+YDO9GVrs+hULZAqRx
	cLm3bVrTIfhmDMOWxl2j54nljQJLK3rpRkBNTgvKrTxOD0ow1CtjU+jBgqtfM5iGxKXByt4OgX/
	Zb0fWSMBl67QQ+t0Eg7L76cArk11F6/MkAlMHYnRij6cMEbC2Ex0GnuFOOkBkhBCA+beChvFmPO
	JwP7bWVLingoZAl8+AvQDUihdFB+AVopyQ==
X-Google-Smtp-Source: AGHT+IGJXqz+bsjwL9K7fxpkACgJ7CUUYtTsBMRBB8QXiHvyZub3gqPv4SCB1Lxa7PjJlefvUOWsPg==
X-Received: by 2002:a05:6512:3e26:b0:53d:d58a:cb67 with SMTP id 2adb3069b0e04-53e12a26e81mr1428897e87.35.1733228031160;
        Tue, 03 Dec 2024 04:13:51 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c245bsm607603766b.8.2024.12.03.04.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:13:50 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 03 Dec 2024 12:13:49 +0000
Subject: [PATCH v2 1/8] dt-bindings: phy: samsung,usb3-drd-phy: align to
 universal style
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241203-gs101-phy-lanes-orientation-phy-v2-1-40dcf1b7670d@linaro.org>
References: <20241203-gs101-phy-lanes-orientation-phy-v2-0-40dcf1b7670d@linaro.org>
In-Reply-To: <20241203-gs101-phy-lanes-orientation-phy-v2-0-40dcf1b7670d@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

In [1], Rob pointed out that we should really be separating properties
with blank lines in between, which is universal style. Only where
properties are booleans, empty lines are not required.

Do so.

Link: https://lore.kernel.org/all/20240711212359.GA3023490-robh@kernel.org/ [1]
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* collect tags
---
 .../devicetree/bindings/phy/samsung,usb3-drd-phy.yaml     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 16321cdd4919..1f8b35917b11 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -83,14 +83,19 @@ properties:
 
   pll-supply:
     description: Power supply for the USB PLL.
+
   dvdd-usb20-supply:
     description: DVDD power supply for the USB 2.0 phy.
+
   vddh-usb20-supply:
     description: VDDh power supply for the USB 2.0 phy.
+
   vdd33-usb20-supply:
     description: 3.3V power supply for the USB 2.0 phy.
+
   vdda-usbdp-supply:
     description: VDDa power supply for the USB DP phy.
+
   vddh-usbdp-supply:
     description: VDDh power supply for the USB DP phy.
 
@@ -117,6 +122,7 @@ allOf:
             - description: Gate of control interface AXI clock
             - description: Gate of control interface APB clock
             - description: Gate of SCL APB clock
+
         clock-names:
           items:
             - const: phy
@@ -124,10 +130,13 @@ allOf:
             - const: ctrl_aclk
             - const: ctrl_pclk
             - const: scl_pclk
+
         reg:
           minItems: 3
+
         reg-names:
           minItems: 3
+
       required:
         - reg-names
         - pll-supply
@@ -149,6 +158,7 @@ allOf:
         clocks:
           minItems: 5
           maxItems: 5
+
         clock-names:
           items:
             - const: phy
@@ -156,8 +166,10 @@ allOf:
             - const: phy_utmi
             - const: phy_pipe
             - const: itp
+
         reg:
           maxItems: 1
+
         reg-names:
           maxItems: 1
 
@@ -174,12 +186,15 @@ allOf:
         clocks:
           minItems: 2
           maxItems: 2
+
         clock-names:
           items:
             - const: phy
             - const: ref
+
         reg:
           maxItems: 1
+
         reg-names:
           maxItems: 1
 

-- 
2.47.0.338.g60cca15819-goog


