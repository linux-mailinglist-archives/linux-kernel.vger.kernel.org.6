Return-Path: <linux-kernel+bounces-448146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5689F3C35
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3754918884E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707701DED49;
	Mon, 16 Dec 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XGZnfwfw"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EA1D6DB7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382279; cv=none; b=T73af/HLKIQyZfGCnos2to+9hPgmm+F6/gK5fAtrpqEYy0keJCXZxg18os8/rtsRaSqMq/VnvHkLHpHnjcWqOKNVcbrzHUhepvDS9Uv8a/sRNeiwGcHa3VnJQ9tdd85PoGL5jy7Ks4L8TN2v2Hn+3toT5SQJWLJVGCJCWiIJwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382279; c=relaxed/simple;
	bh=isHw0ite5JlatyQHO72XqgSTdGngKj29ojD1OiqbJNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ck2Os/awTqH3f7NQve5lQJY13/N+2j9yIDuKnapaH3S5bQyBmdthUHOQtogYDgJwEq1UKwUwMa/Eh8Cq98yYAETbFdq5uwSasxAKPpoAgKlNXDjZ0G+U+6fAr/CZk+r6Zdd3gz+DPgocr0N+0319eTjoRSL9qiFMD+/iRMkhXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XGZnfwfw; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3eb7ca55c3bso2436405b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734382276; x=1734987076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Py2D0wervPIISRW98FoJi7A+7b16UWm4ihveQpPZjpM=;
        b=XGZnfwfwX/xSzLdXodzV+TP2UHjEz9QwEa/MyAMSL3pX/eHY+HPWZNI0IK2gMLR4fD
         6ViP0UQBL10VeR54dV1LN1BiD7PBLMBtEkiZQZzCM648OPzI7yCZdg02W8UBkPHFSHk5
         u7GYsO30ZIme4TZfC6ElEwg2ER6zNc4o/VhQfqjtCHF7LI3VNcCWiOnAk6jf2sYjj1on
         tZ7GI2BxnNl+loIBojLuTYgkW1NnkbMRN9bPAaeR9Iw8SQBDq9bna/4EZgQeOPC5hyQf
         ffa0vspxp9lvFtGyev91WHoQZcAMLpngRujhUGHbSFrQPWSqv2DZP2vJAhzZ0/4w7Sv6
         jI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382276; x=1734987076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py2D0wervPIISRW98FoJi7A+7b16UWm4ihveQpPZjpM=;
        b=urOpXid9qCutWHM3Tmqz4JTFbTxww8SXT87ZQiDHznTFvIT0jq0VqejKn+P8RIgU0d
         YcLVgEmIW/l9vwKUHybBmWDMzOj/Rsb8DZeNVWnl7QzstJU0ToX1TD42PinaUVeGbCuK
         xT/bX0pijTDrR1P1gegm4FMa+R/53nYF+2AZBcxA4usZxFgnqTS9MTn/JTPfvm5w71N4
         xuHu37zO4GoQyGGoCmAv7vHtR23y2j5MQEZ1BNquDNg4+WQXsXq8BYGPO+XsRm0QFa/u
         w6ckuP4xrJ9jlUKbGYvI83+NQsduPGcLJ+r4VgF8f5EY0CTAFbTlL2L1RKgBFofL0JhZ
         gs5A==
X-Forwarded-Encrypted: i=1; AJvYcCUlXyrNaxOUUwhsy4yBQrJuLlLUp2LZIyUoOyrLyIog/QTARaXWb8MbYwfcFxjebASIwgbnObMePtwdpYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBCJ2jyxiNbfw2k//bt2F+dWGryk06UFiiSfXa3lEhAlgNT00
	FmsEyAiQ821mtB/almC8u9vlWAllPDJzW3sWJ2GzUOPkhLT6osY4YCil9acuT1o=
X-Gm-Gg: ASbGnctU9kFffYwK0V0z3IgDboir4r7FIhac/zl+mS7xbbJnSi5zgG+aT6vIynKdCgj
	J3O75xyLvNEqW2B+KS6+7BgIP16jVgPdRzvqAe3Omw8v3RFyDeJUDGysrVmqX0T7yPT3FCNgeb2
	w5lRd6AKenGDHei02rim7O4qdPG0P5e5tFFZxzccAaIP3BzC/LrkU+mQkTCjRCW+jK6Y1UdN44t
	1pxMscYF5S4+ZwX9e7USlGVRsHSYZ+dGa4Q/DDWyFc7uMKrMp1R4BhhcVeVmVe+8D89oD6mkTgU
	rg56iE3DGIPs
X-Google-Smtp-Source: AGHT+IE7X+nUDMlIJJp0XMjYhi35arAe0SORBM36Z5jpEQmusepUdkQp1J6sS6FZhGvxwaQtYKEf8g==
X-Received: by 2002:a05:6808:138a:b0:3e6:6203:fb5e with SMTP id 5614622812f47-3ebcb258830mr158477b6e.2.1734382275832;
        Mon, 16 Dec 2024 12:51:15 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48355dc0sm1649022a34.25.2024.12.16.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:51:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Dec 2024 14:51:02 -0600
Subject: [PATCH RESEND v3 2/2] dt-bindings: dma: adi,axi-dmac: deprecate
 adi,channels node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-axi-dma-dt-yaml-v3-2-7b994710c43f@baylibre.com>
References: <20241216-axi-dma-dt-yaml-v3-0-7b994710c43f@baylibre.com>
In-Reply-To: <20241216-axi-dma-dt-yaml-v3-0-7b994710c43f@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Deprecate the adi,channels node in the adi,axi-dmac binding. Prior to
IP version 4.3.a, this information was required. Since then, there are
memory-mapped registers that can be read to get the same information.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

For context, the adi,channels node has not been required in the Linux
kernel since [1].

[1]: https://lore.kernel.org/all/20200825151950.57605-7-alexandru.ardelean@analog.com/
---
 .../devicetree/bindings/dma/adi,axi-dmac.yaml        | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
index b1f4bdcab4fd373b6ad7bfae763f70209eb1b65b..63b6fb0423c2052c32d188353abbdfd7c0711a7b 100644
--- a/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
@@ -33,8 +33,12 @@ properties:
     const: 1
 
   adi,channels:
+    deprecated: true
     type: object
-    description: This sub-node must contain a sub-node for each DMA channel.
+    description:
+      This sub-node must contain a sub-node for each DMA channel. This node is
+      only required for IP versions older than 4.3.a and should otherwise be
+      omitted.
     additionalProperties: false
 
     properties:
@@ -113,7 +117,6 @@ required:
   - interrupts
   - clocks
   - "#dma-cells"
-  - adi,channels
 
 examples:
   - |
@@ -123,17 +126,4 @@ examples:
         interrupts = <0 57 0>;
         clocks = <&clkc 16>;
         #dma-cells = <1>;
-
-        adi,channels {
-            #size-cells = <0>;
-            #address-cells = <1>;
-
-            dma-channel@0 {
-                reg = <0>;
-                adi,source-bus-width = <32>;
-                adi,source-bus-type = <0>; /* Memory mapped */
-                adi,destination-bus-width = <64>;
-                adi,destination-bus-type = <2>; /* FIFO */
-            };
-        };
     };

-- 
2.43.0


