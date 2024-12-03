Return-Path: <linux-kernel+bounces-429408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5779E1E0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E557CB2CB1E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674861E633B;
	Tue,  3 Dec 2024 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdO4b7BN"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEDE1E492D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228036; cv=none; b=C56P5F59rpL5Oorq/odnSOXcXpy9ED3lJpMbXodyH14CghOPaIOmgSKtCd1ZWViQ9Qy21dHMWJZ4wGzmeg0U/lqPEcwIAFarrvr/iyOJvsj9YVrtQ3Mz+ygAWi6R4p2HuF8vb6XNrtVMAAc/Va8Bc2J63cZEGwY0pPhHcin/Yc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228036; c=relaxed/simple;
	bh=W+szB8DHIS9wuynuF+WKAS1RRUY0K1c/z545AfxmLt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L3wB5Ys7nCsCoExNaS46/ctipVG7o2NNUmljHouWiPQ5ONicjeLvXPstC45zBOJ0GfrKZp8+fGRcRKnrMSpOyB6wGSUaM2qqjANNTh3X4tvg49kig2wGnsg9PdFuEBALshTllZ57fqTBv4ziFgqGgDODQ4xg8nvejmHwiVJtfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bdO4b7BN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa5b0d8bd41so679993866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733228032; x=1733832832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWpaKqqVYEb45LFrVAOE9nPtLWbHCab8i1TbI6jQ3+I=;
        b=bdO4b7BNGjxldtopbXr3OfpwxBtDEw0rKeVkOWfFxQDEb2wF2fvj/KbiAlAYChZxTC
         LVRDR+1uzgHK9m/Eg1m96b+cfTTyASByYv8gx25Cl4pSLS+6KpFsCctZo8T/M8VAa9ul
         f4rahCfDVUEtmiX97cPliYTUCHZEwCUTYM5/zN6p5In9V+Prf3ohUQLv/skHm4MKVamh
         Cv9V3Kt1Rx/NtB39GOgCJvheJb9J8Yh4n98Mk3WyDPwWpoyQHLzTzsT827vl6Qmxmr9t
         7R5cpra948Z58253O18oTyT9XKcM9QAwU8aWsJShG4STPTDAiByLfZ6lQOVk8H9iKoqi
         v/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733228032; x=1733832832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWpaKqqVYEb45LFrVAOE9nPtLWbHCab8i1TbI6jQ3+I=;
        b=wVHcPq99B0+2YXWdmFk5nHUDv+MKxfqEBUqipACyj3wTId8+2Fdw6eHFm4/SDelg0q
         ZpCMjHMQ7J0Q7Bq08Wk54G0qOtLhOg3MEbACF7WaG3keO/T/tNCIgH0X204ox8U85drb
         da+lM/4hjWRsgjxfFA1qW6sdY2tvp1oxoJ3lwm3QWb1e4Z7FtitQOxkhD5alIhcA4cDS
         PPF8MKLtm5+nGw+SCd0ka6Y7cCfcNxaG7QCNWUpV8OnWDgsxlNyNM7XHihf/tB1CKQf4
         V3h55TzHMmLGIjOHM8nDPT+p+Fd4QbJZnXgshMwJiSrvL7ndSmGcEuOqnPZ0l+9zsvox
         6nAw==
X-Forwarded-Encrypted: i=1; AJvYcCUwdvMDfd5SAOkqO2s/5YknQnnOyAvoyzTJYIiYHIXT2ZZ7HTiV2xjYbK/KNYlwiIBo/OXcMqUMEprIk3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuX0AGm7KkBt+16fiMfVn0FS/Y+GNF/132oAQPGr6GN3zaqbgT
	NhgJwAVgt6+jQyCIKIByIKcYi3hsFrMNLPs3jWhBCXna66fami2xqo9pT55I0Qg=
X-Gm-Gg: ASbGncuOU292i34Z4//SZwhvRWDquPkR/tY1gsvAkDlb+W8NGlmuXdwzlugEFSgXMW4
	pd2y8501p05k90N9KpoKlddK/IYZh/+NH4Thsq3L7r8+nA/xkNUtcbP15a5cG2NaAwBH4Uqrh7w
	e8a2xvTaooom6WKYOHDSNdxgc0BIVjVn9JeJbrhie6CLqfDhz/IHzSp2IJdUu0o89fH3zulFgmO
	JdK/j3gqLNUlAVESCwSPKMcEsyo+nGIiA4XMsKeeFFfXtxVV2Y2NEMNI6mg82Urx5oAv90Urar8
	cGvcFb8zsKSNH61H71gfV73XoECuqzqdXg==
X-Google-Smtp-Source: AGHT+IGn4eg/NfZJAVu0hqE9cK2q2j0R5oIme9rHukh+yJlN3vdSnhKD++AzSGAOtBHFlLtbaiKfNw==
X-Received: by 2002:a17:907:7632:b0:a9e:df65:3a81 with SMTP id a640c23a62f3a-aa5f7f4f3bfmr155819366b.59.1733228031882;
        Tue, 03 Dec 2024 04:13:51 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c245bsm607603766b.8.2024.12.03.04.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:13:51 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 03 Dec 2024 12:13:50 +0000
Subject: [PATCH v2 2/8] dt-bindings: phy: samsung,usb3-drd-phy: gs101:
 require Type-C properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241203-gs101-phy-lanes-orientation-phy-v2-2-40dcf1b7670d@linaro.org>
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

orientation-switch is the standard declaration to inform the Type-C mux
layer that a remote-endpoint is capable of processing orientation
change messages.

The USB PHY on gs101 needs to be configured based on the orientation of
the connector. For that the DTS needs a link between the phy's port and
a TCPCi, and we'll need to inform the phy driver that it should handle
the orientation (register a handler).

Update the schema to enforce that by requiring the orientation-switch
and port properties on gs101 (only). We disallow orientation-switch on
all other supported platforms, since other versions of this phy (or its
system integration) don't currently support or even need it.

Even though this new required gs101 property is an ABI break, the
intention for the driver is to behave as before if it's missing
(meaning for gs101 it will work in SS mode in one orientation only).
Other platforms are not affected.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* squash original patches #2 and #3
* actually disallow orientation-switch on !gs101 (not just optional) (Conor)
* update commit message to clarify that the intention for the driver is
  to work with old and new DTS (Conor)
* collect tags
---
 Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 1f8b35917b11..c1d16254aeec 100644
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
@@ -139,6 +142,8 @@ allOf:
 
       required:
         - reg-names
+        - orientation-switch
+        - port
         - pll-supply
         - dvdd-usb20-supply
         - vddh-usb20-supply
@@ -146,6 +151,10 @@ allOf:
         - vdda-usbdp-supply
         - vddh-usbdp-supply
 
+    else:
+      properties:
+        orientation-switch: false
+
   - if:
       properties:
         compatible:

-- 
2.47.0.338.g60cca15819-goog


