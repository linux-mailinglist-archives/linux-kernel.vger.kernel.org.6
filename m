Return-Path: <linux-kernel+bounces-435312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12379E75FE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E5E160F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABDD1F4E3F;
	Fri,  6 Dec 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZ5VoBHc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC361F37B4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502666; cv=none; b=SFW4GoZZBOx4gBdrW6KsCgwN7tQclgPBPsMSYuXO3k/v0GPwx1z8Vl90Q/VruEFb9YxDwi0yNjhk59E+uBpGFtQA55D0DZT1F4fEguMOKb1RQAr1d2i19wYYcxbFH1+VpFRdaZHqf1J670muOHxp/4L3OJh2F0lLLj0rsd0uqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502666; c=relaxed/simple;
	bh=Jp2ObEzqJQpaKbhTocAaM82TdjXKoBGT2+8/pE/oY9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXcOwPkDAtN66QyOkjvRWUaDhgMmoxDuI1+g3r7lpW/fElYzsV8gTqQyAK6Yno9e7kNDGSftIIUWQS9TFWI9PExZ0ICd1TbDYN9ZFQDwX1Tjt1uhqbPS9C+8/t6FMvPUM7peplzxP3vvo4CTz7qFBQzroe9TzM4zP4lrCSA34hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZ5VoBHc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa6332dde13so61676566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733502663; x=1734107463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKgkddTbsb36SqzZl1dMALspeUepmvmFxGiaTIa2E3A=;
        b=LZ5VoBHcwLIPmXLWoqvoD5UnDX1YqYkRUe6j4i5j9Vo2vHFJ51MTseoZJAhbq/o6SF
         vYX2xeL7JAb1/dr5Atg73Paze+6cFyGPFCydRr6M8lwcxYu7qK0+Xc02G6WmPYbJI+Jm
         2COGbCLvSKXBOMKiPYhWQIRre3xyj/D8FLI86Skth7Y6qCWcMMQlZuv364xFayTf3rfm
         TOvSq7cSdAEeZjyFvLMdtJZXpqpJJIukrfBlGlQ7/PnOb/n42st6bAEf7t1IAAO7qOhA
         M+iMJ99/GkOG1bO0dT1vaNBEFAE0JP+dZWMLOwWWjvRNIQWU3Cw98EZPI3NycjwJU6IO
         1TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502663; x=1734107463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKgkddTbsb36SqzZl1dMALspeUepmvmFxGiaTIa2E3A=;
        b=GCecPrvsKPzgShaSTmR2Udls11nvCWc4X5rOKhAhaN8/clssgqw0Lh4m2d42pd2D4j
         9rIVHswo6mQ2SbRLkoMJMpq+SM/fMWdw2KgUR0xThdaZz+i70dMAsVQpEYiILBh/09BP
         cqMV/9fGLldLJlgPURJG/OfvkINrOGZYz6CDuBgIcVVuyPPjiff6IZgNH87vIHWsydlI
         7FJIjd1NJGvku7s1p4iCmigA09sRlGch7L9GvGadgfyhP2eYjjrcbteXKiowNS3RZcB7
         mhpG8kuPzGpvTc94yJkWXO3NpEhpDOaoQse24qb1qmmxurHx99jMPeJP9CkDHFZw53QJ
         uUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEXyS/2WXZS7J2adrCzs2mAdPfc0Dc7JkBN8WsaQRF4hSHZ2YrL/oAgXEoAw9nUX4ktwnAoT3jT7mtu3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmAALWTVaXE0yEISg5Z0EbK3IbP3Z7TnvzzbqMDvLkguP7rjS
	CplYquNABry3bzXD/I7CyIb0uFIvphx/jg1nbnCCIJfj/FmOZT5AUuLWp1GX2m4=
X-Gm-Gg: ASbGncvanpQg5vCdKIxAL6IUzfFudsXhxUk/VgkLoDL5d7dskCHvuqZHE+RY9u53kNL
	xwEg1ebbVlDjnYwrxhhRTKb8eh7Ag3BIqCRy9p3TdgQ2g9khrjxDDLYDeSOepm5/5mWdq+ANP8f
	FhIcCq42ED1pgpD9yWi5gxzaa0Pnr+m+6HsL8KR6t/y0BY8chdKcpnyMFG0jqVWAjbhuFNN8zj+
	DA/1ZJcm8NMVwjewmTpCQNniDKM3dj3pojpDR1rkxCm7Wn2+ewH17NtyvkURs/G4nJun68dFz1f
	9NRzLqmpxEo9XrV6Ha9jzK1elqbUmrpkFg==
X-Google-Smtp-Source: AGHT+IGRlX7BIbgKcq4E8LlKztNa00vBgQAERS4YEdJ5MYW+4Wqp/mGqY/4IqsX/I0DaInCg04SuNg==
X-Received: by 2002:a17:907:7841:b0:aa6:32c0:5d05 with SMTP id a640c23a62f3a-aa639febf00mr320394766b.13.1733502662697;
        Fri, 06 Dec 2024 08:31:02 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e8af8sm257710266b.191.2024.12.06.08.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:31:02 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 06 Dec 2024 16:31:02 +0000
Subject: [PATCH v4 2/7] dt-bindings: phy: samsung,usb3-drd-phy: gs101:
 require Type-C properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241206-gs101-phy-lanes-orientation-phy-v4-2-f5961268b149@linaro.org>
References: <20241206-gs101-phy-lanes-orientation-phy-v4-0-f5961268b149@linaro.org>
In-Reply-To: <20241206-gs101-phy-lanes-orientation-phy-v4-0-f5961268b149@linaro.org>
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


