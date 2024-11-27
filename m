Return-Path: <linux-kernel+bounces-423356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A689DA655
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED223B237D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0BA1E1023;
	Wed, 27 Nov 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSnfjJYF"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED5E1E0DE4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705097; cv=none; b=p/5p7BEYnYZoKgdWyzB9YtjjAUGCd0HFiMwQllTJ4NgLmD3hDlPYKU3Sh8e5Q3MwD3lD/b3K0YMW8fOb0pl6/19qveOfdAuLlOK8LZEJLephaO2FDlw82wM4wdTeRkQ1yM7iWZuDwL++QRhgYFdeOZYgCLhabSTlh9IYR5htA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705097; c=relaxed/simple;
	bh=VjxgEP38+L+Ma4q4uehB1/JLcL29L3ctWPsdy4kfO1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ptd4UuwUxN20qwGnj+RXYoAKv7k3OUGpcoXD2W1+n6TMvLCIPtuQlaURZBItmx9qDf7FXHxtFzEDKaGLLbxzzE4i7MJTynBAnCYxxzm450xacTlVftJc6Sjl8nyytJUnESml/bOxljOdmDZ99RQrH7i+iJ7qb7lukzZ4ZsU6vi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tSnfjJYF; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df3078a4dso161455e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705093; x=1733309893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EX57ICOKMzOs0eby+nVmHR92z2ekmaeMdJuyR8QQpCo=;
        b=tSnfjJYFiH5cE+6qkupiG2hOfWrHY7ZaRffpPU6bl4YeOs6bDFLSFN3+RLGeGWzsWG
         ABuB4zm2NwiyEmrzhSckmLRyqwYib8tPCfLjTb6pjEBYTG+mtzBDZcQg92C88fxDwG0d
         xAgrrQ6kK63z30BbMrdqmgU4uw2zdy6NyU7EI6pb/pOOhruyIXGZbeYTTHLjXU4ygBvU
         aNTii7xGLCOvECbdo52AIsTJ1clrUpYSzrudaSfTTKZMM0mXD4guIH5MAkGehQKRqyKd
         yh657vVa7mK50yjHgZvMFztUjCEtyJhhPndiUfwXAqaufwaZvAJMoonuqtzKzU1YwRNk
         DHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705093; x=1733309893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EX57ICOKMzOs0eby+nVmHR92z2ekmaeMdJuyR8QQpCo=;
        b=XrD6ycT/6PyxvxTocxcUvayphIAtVUHekwi3PBfeMChLFPbK1H+BwWS5ldIbTYt7T6
         2es75zJMN0cwzdeSQgX/LKn5uaK1oBHrmBB2p6V/7qsyfeF2XCyzx7WljGo1aSe1A0Ga
         ltKfREV4vkuXtdhIsqJjYUgFTmVku+47q1r8wJFb7u18WCNF5Tvj8yN7dRuccDw8i+X7
         EkdiB2OZyeBwcFYwFWJ9S1g7tPDiWtKaJnRd/n/Lh2VXr5nlS7h0iHE9G/MXaZ9bX4nj
         aMKpmxG/3cUCzmEYmyhY5bYWxhiSvrWF6o4qUu3PjLA6owWFN2pefNi7RdLE4Kw0xusG
         KinQ==
X-Forwarded-Encrypted: i=1; AJvYcCULHZVg6evPRQCcHvMlNgkrJprWrDlgrEZXEe56nBZNB0XBtQAcOeYsyaSZuoqUqY3p456gKvl/8tpONoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISgQz8+Otv9t3yJoREu0CmrvPxFvRHSegktBfwbFRuoPaD8jx
	uu4KnCZcO2EsiJUe4lotu4k6JAHbDpGzJrwK4XB0PfVnTSo52ucxnGAXY0BJTQg=
X-Gm-Gg: ASbGncu4a8voOdBCEy9qiT/2ad2Za+fdCVG2fT8UV4JRRnPsIffJvCyk4fTxjyHHIFk
	rCukrMHcc2Hkx4Ei+rWK9XUPpcR1luREAD4tvjEyT+fVzVIaOJMjF/tb/2N9WQ+FgEbauVpvq3d
	LkvNveRxXyFK3dO9z06Yu5YQW47MSNpIW5ehjx0ibafIcjB7iQhmjQJOt2RE9xH1ffSg0MN6t8N
	XkfqI8lrmTZHSrkMxqPpFto8P2HvrIdqINUEPnaepLHtZype4utu7MoKuv3IOzf46DA36tiihDn
	CnyKgFKOnZntBuLRzmZznsARkHj2v5sSzQ==
X-Google-Smtp-Source: AGHT+IEDZQbqWW03yw4ZJpKkkOp6D2uswnTAhfUmoQ8ZqjktXEwpbL7Kj9opKFu91DPbwMPyQP7BRw==
X-Received: by 2002:a05:6512:3b06:b0:53d:ab04:54ee with SMTP id 2adb3069b0e04-53df0107235mr1294962e87.41.1732705093247;
        Wed, 27 Nov 2024 02:58:13 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54a6db906sm412183566b.41.2024.11.27.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:58:12 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 10:58:12 +0000
Subject: [PATCH 2/9] dt-bindings: phy: samsung,usb3-drd-phy: add optional
 orientation-switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-phy-v1-2-1b7fce24960b@linaro.org>
References: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
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

orientation-switch is the standard declaration to inform the Type-C mux
layer that a remote-endpoint is capable of processing orientation
change messages.

Add as an optional since not all versions of this phy currently support
or even need the orientation-switch.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 1f8b35917b11..6c17a44718aa 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -51,6 +51,9 @@ properties:
   "#phy-cells":
     const: 1
 
+  orientation-switch:
+    $ref: /schemas/usb/usb-switch.yaml#/properties/orientation-switch
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description:

-- 
2.47.0.338.g60cca15819-goog


