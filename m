Return-Path: <linux-kernel+bounces-432674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726509E4E83
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C81628262F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9A61BD012;
	Thu,  5 Dec 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXLASvK+"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2DE1B218C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383998; cv=none; b=j1sGiyNymJ5vWGFqpD+AX5jM7QNR3jrcYUdLIsPM0LLyozBUGYJCKQA2G5Q4vxGsyD5KdXal7WltIm6S7v5pEcPwGidycMm2+3yUM9int/ksgTLYo3arIGn+scGwCOwLQ7w7BJTYilv7CK8eDRvGR+zLkMXrxnylw1Dqgy/imRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383998; c=relaxed/simple;
	bh=Jp2ObEzqJQpaKbhTocAaM82TdjXKoBGT2+8/pE/oY9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvjm2TICCSXqu9jQ3JpVNfjshjZAVBvBlpsEYSw0Y9UHVIHGQzOUFjYthJCZbF7Py2KMrCZh/EHwE/1dTuPDs9QBGx3XPJ5zK/ZjEVmzvrcmA9tqSt4HbiMlSBM6RiMeYsVBs1UD84ClE+YI7qaKdDyxCUUqUu7DjhTP5UK6ZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cXLASvK+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso103071466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733383994; x=1733988794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKgkddTbsb36SqzZl1dMALspeUepmvmFxGiaTIa2E3A=;
        b=cXLASvK+Km+N5kXgYqdRMahJFBxycETuH2gwM8NTOqkkpumbqpK4tcH3yspfMM7nEC
         sgPr0H1wXUzjLyMcVcyQlpTlePVU2LA8xwS2H9VpvyVwnnN181+7i7She3Kk+pbfG5/O
         z4ICU9Xj/qjDmsC1g0+munHBn2kDbIiKKatJPZUkWlt7ij9DmBYvH7ycFadVj8xkZP4d
         FJNxkFlOksBBYrcqPQ+ODsM/TR9OvWj3pTX8WOnwcloqEJtg4J/8KagljAvcBYi2jmTt
         PmhPhT+1VR6PH12FjhnmuhlVGIsg9vPtUyS96H0DdZza2Pw9Q+dIrWi9oEyBmUn4jsmu
         fIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383994; x=1733988794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKgkddTbsb36SqzZl1dMALspeUepmvmFxGiaTIa2E3A=;
        b=eznArbAMY3aWT3L8LaSXDjW/5FXy7IHnhOD66e9SW0DB7Wn/iqqiLvyMe/5UCyRHdQ
         5Ol9PAyIx5Xg33LgRkYoNNHwYZupDk5N/JOFiPr6LGa/a3skSIZV4co/E90zjH1OMoU3
         kTG/SR1VZSDJHvHgT4VssyvX3VxeVSjq68TU9xAbeQwvnQclB5htp/J7xVvofa5IfDtF
         bL7BdbaRY/T1e6qy95NRkqOWt3OuXQFGMeCZwqkUm8N2f9w/Ox8V5SzUhD7smBghKUI3
         wQGi9fg88dJRWJYFMhMEvPjXhFVpbySKkZGHlFjhCRLB1b44JplyKzH3jnzHNLZ2SAjv
         /xqA==
X-Forwarded-Encrypted: i=1; AJvYcCUKFv2dZPb8rzz8nPlr4ep3XS3OjR4Qxy7xoDk4br0WrVnx7sTS3sszDStertsCRkVAbdCCQ3ztLIYHA/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpNmumnk2Mm2Bw9cSyKJcdVg1PSvga5QcQNcO0cR8xZu1Xg0n
	bbhniKo964dR7Q0wPsvlRvokHcFZ3um8xFuTuoqxYBM18OgzH3Bw12HLhSci/Blt23CHPAwM5zQ
	ZA3o=
X-Gm-Gg: ASbGncu3h+5UU3hegRSnMfGLaW1x8Nv7XNiTjftN8ZzLaO3yC9aFVc6uwefiPO0xPmk
	xQAxhVTApauUGowx+sf3vfCN44r54mTUaeOMTtCTnQtj3fKiA/ijmxXt+ABi3+KUaBd4BPfzql6
	52Q2wXT0c+i6ByfXfmzRdUgFEEUPkoYOlBzuG3eDnYtzYNdvzoByN4rlyQLOF6UceOkCMyjb0GH
	wFqLPlBgtEHJtrI/8gArAkeuJj5CWVWgliQRZxnYAkw/UrWIWKJYANY5z70mgOU9squyjRxo/c1
	pX+iCotIMZ24RSFG8dLrK4OtXlodG1gkoQ==
X-Google-Smtp-Source: AGHT+IGYmzZiBrRm65PFSu05U4htcrBOv9KSue7aaItOd1Hb+mwmtbhHeeF7rqrAtH/3fEru33bthw==
X-Received: by 2002:a17:906:3d22:b0:aa6:1917:42e7 with SMTP id a640c23a62f3a-aa6191743fdmr306308166b.22.1733383994490;
        Wed, 04 Dec 2024 23:33:14 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260888casm53371766b.133.2024.12.04.23.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:33:14 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Dec 2024 07:33:13 +0000
Subject: [PATCH v3 2/8] dt-bindings: phy: samsung,usb3-drd-phy: gs101:
 require Type-C properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-gs101-phy-lanes-orientation-phy-v3-2-32f721bed219@linaro.org>
References: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
In-Reply-To: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
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
v3:
* update as per Rob's suggestion (I hope :-)

v2:
* squash original patches #2 and #3
* actually disallow orientation-switch on !gs101 (not just optional) (Conor)
* update commit message to clarify that the intention for the driver is
  to work with old and new DTS (Conor)
* collect tags

foo
---
 Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 1f8b35917b11..27295acbba76 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -114,6 +114,8 @@ allOf:
           contains:
             const: google,gs101-usb31drd-phy
     then:
+      $ref: /schemas/usb/usb-switch.yaml#
+
       properties:
         clocks:
           items:
@@ -139,6 +141,8 @@ allOf:
 
       required:
         - reg-names
+        - orientation-switch
+        - port
         - pll-supply
         - dvdd-usb20-supply
         - vddh-usb20-supply
@@ -198,7 +202,7 @@ allOf:
         reg-names:
           maxItems: 1
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.47.0.338.g60cca15819-goog


