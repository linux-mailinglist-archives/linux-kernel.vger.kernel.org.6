Return-Path: <linux-kernel+bounces-423358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E29DA646
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3721642BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46A81E0DE9;
	Wed, 27 Nov 2024 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9AtM3pn"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C81E0DD8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705097; cv=none; b=AkxdkVcaberLuEi6ZneMbRzASEpOAF9GNX+OvLI1zdVNcHDy4w3mz3mU8R02dwfkil1DtU5IvbkdfkVz7aBDuAsRNLhfimG5M8Pd0GMbw61bI2EiAhnARrRh1fJ2lIadCWfGf4tu5cjgscn98jbt6afc8d8IIr2ljGfsvI9DXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705097; c=relaxed/simple;
	bh=TfasP76fahywas4AK7WSi5yqPxkwwsGkTVawo7HIu/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UwyRf6kuNL3jq+GdKdCOSvrG2WkJDDJkdFrSegvWYVLALLvM15E1imaPEYZfPH9Yo0o7/fGUjMAvZZC65oVTWkhjOPz5qt8kjBxVlPIBE17eZnbTGtuHYjWv9hl92fru9MUGucVsE+OW0yoxhjMhzabNA8tSdzAFZ230MobbFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9AtM3pn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so1080094766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705093; x=1733309893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3bheMto3E1kl1HdoApxqJvOhczEZkMy970AMWo89Pc=;
        b=H9AtM3pngNBTujVz2aYeH72mK1naCxWw82J9A04+dpIanOAW399zVQ+C1A7GIkIW9t
         V7tqy+kGGXyBDT3hMPztQdDRVXmOTd+gVhFAjm/y2dGk8y2plcmKOqdDyCSA9QHE8DT+
         l+k22raOnG5d0LgjYgLcXUfJ2ZoWsU+DfLJzlq3WuWmUfjiyob6hz31WFnHw88qtM2PP
         CCPQsuaz8G76D3rZn8WwU5tAZk7t1dL5jiPCz7+hp7wnZxE7Jtg2bMWtLtRjZNSu8dRe
         JO8LzSHqViLyq45W4RAb6TSsFN1Wc7AxrolultMoqS55Xs83mETCXYieW9cFR2OYPVKz
         7+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705093; x=1733309893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3bheMto3E1kl1HdoApxqJvOhczEZkMy970AMWo89Pc=;
        b=cCQYLqdvqYPJDS+JSHic98NZ50pBSok0sKW9f/M4pCoi4dWe19tVBPSj588DZusnLn
         NnMUTIBfcGmfjbzy3iybzuSyYzEOGOf6tPvffPrhGNhrQpOSSAf6EN+Hjzk3zxchqL1t
         quguM4Nxm/Pzr0Wwk9CCAweE4bhLm/Z7F6m0qePmMlhsnXGGQ7djIcDO2NiK9Kp7CMPj
         9mWlEa3imM0hDJ4yaCMTudFpso9Osx0Rn2FFXU8JxH4mt/turr1yirLtQnuUDuDVpJyO
         p+DvduVEnF4NjR8jJRMOIfMVtE55U3ytO+9zro1b8OrdQ5jAgXySVt4Df0OTTArZf+We
         U4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSjuiSXHxJJi0kD/wC/TfHGYrvjgYSX2HQa/PmArU/QLDGZFgvW3KZ++6lX3kLrhxIxxq5k/kifbpecno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/U/7pQAfM8+fBaxZ+he1I0PQyIf9CqoGaBSxULtOg1Sv2z8L2
	rqd7bGJWsIT/zp8Cj8G2yqkZ/IMWluDgiTMx+ckZO5iwvzl/TPoLAC3NMdcDd9g=
X-Gm-Gg: ASbGncu+plJ0J26TFiDPv5fKb0CXcdx5mIgCCAPfhoTCbk3PnmS7U69BVGLQA83i5Ht
	BzssLDq5Z3EIQarqBTI+dQ6fv+u1JsP7RXIjoFasWB5TF8SQBhrWvTR838xPFEA7Hsh2sIPUCPU
	2RfpBZG12lp+j6b7uPoYVVNUdJgAmuMTSdZcV0hzr8VVvW+Vy+ftkhoJSO1qZCCK5IpsGuWWZsL
	l+5nf8Lj6BzgB4SpAnAXq54rgS1P1qhMlXExWPQo8zTpmKMhFen8l9KIfBtdkEhiTlYL8jNkxlf
	6rVeyB7mO1LrXekEtILQ2Tx9lsMqBWiiOw==
X-Google-Smtp-Source: AGHT+IFtopTo1T9muj6iS22tvZolqFiyxg9o/3wQpSGJ1mFMEg0qDXnVqCgHodOTVAcp8106njbuHQ==
X-Received: by 2002:a17:906:3d29:b0:aa5:63a1:17cf with SMTP id a640c23a62f3a-aa580f23e33mr198057666b.20.1732705092771;
        Wed, 27 Nov 2024 02:58:12 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54a6db906sm412183566b.41.2024.11.27.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:58:12 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 10:58:11 +0000
Subject: [PATCH 1/9] dt-bindings: phy: samsung,usb3-drd-phy: align to
 universal style
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-phy-v1-1-1b7fce24960b@linaro.org>
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

In [1], Rob pointed out that we should really be separating properties
with blank lines in between, which is universal style. Only where
properties are booleans, empty lines are not required.

Do so.

Link: https://lore.kernel.org/all/20240711212359.GA3023490-robh@kernel.org/ [1]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
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


