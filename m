Return-Path: <linux-kernel+bounces-387548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4D9B52B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CF0B22D01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FBD2076CD;
	Tue, 29 Oct 2024 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W82yHHrh"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B722076B9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230168; cv=none; b=NyKNvl9Qy5eomAKlRww/wPHgW97+ygRVEc/d5bWmsvcYOJLUWOUVvnS0r/+YeMBByW4pTqqjkqISSmexPdte90a2q3gp/wwKECZ5acUxj80WAY6y2d0/HzlWP4rTWHK8CTR5OMltJPc/Y8FIYIlxchfl0ARQ281JCT5BA89ybxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230168; c=relaxed/simple;
	bh=B34viA+MM65CdrXgUsW5Dp3t9NZOdkgqu5Mg4s7zNz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HfSHOkhMaFRuDJY/RC8YHDfB1qgtPr2PBVEbBZ9lJniIIUSkdgtkp6iQiEkP8FB8+wagxriDGSqvobpKYfyW8Q/fi05HdExqUPTWfwylZ+1GPRGzqZ+NEvFkwljl1fxpNfDrXem9YuowEJpWLx1WXajjQYcTig4ULZTBZv0P9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W82yHHrh; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7180dc76075so3041912a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730230165; x=1730834965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGUVNbD0P2PUChlIpa6bQKf2kJo/Yt/Ozq4hpa/Va30=;
        b=W82yHHrhM3MaVrF3VIu+DToxJvuQ7qb5wjnc0n9rN+Kb2mWKhSo5R0RpEzBRz22+mC
         UrGToCj4w5Ai80RLg5zAe0jYICRsfH+E63IMPB0/uykcBI464fISy/D9K17c8PZt9tFt
         VXZ0wRdNvfddEPdZOd2hIxR2Q75gzIOs+ONxBxmQg6f5MlUqjjOQpNO21sT+HTs/oZ6J
         /gEl673QfEYt4c3DuVS6WIXO1KQrKjYjPrnB5jnGxAAhEvm3BulzD2aEzUKR3nEiMKVv
         GX9QTlqaflQt+ghzqirnic1YptAhPdoCdMvpxL6QBFG19luN3TvHeV01lM/xY0VWqU+Q
         pP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730230165; x=1730834965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGUVNbD0P2PUChlIpa6bQKf2kJo/Yt/Ozq4hpa/Va30=;
        b=lXC/rAGsznxI/NTwEqh2wOXgUN+TKcDkJ7W9Gh9EzFhLBPJAveByKhAmk4w5WqDdaV
         VGnSuDAOPoAly93JaqBt2AY84GF4UV3B/YdApszKtb9ojLKhnqmebCfd6eOVIteCIsCp
         V++9JGmP+fxe46s91zXOEv49OTrSdibjMIV95S1sPcR4Czlf2IVAV+aaTFCLldlqz4XQ
         f7nbAR0FR/buJExP0F9LxOyyNXvRekKEvGrCyp/Sp0BHu8NOIWQI5lbn67vtTF8FlHha
         Bd0caLZaORZ980sU5XOsQApICTYySv8BSI6AHk5dpfRnathEAMmWVnWNlz3M1E78BZBW
         8bJA==
X-Forwarded-Encrypted: i=1; AJvYcCWqI0Pr7RX/Sfm/7/BQBI0nKCapTqiN+m/frHssjqrlxzGxGt+PhiQAn5gsfPwsA565eM+OD7Ny4TayyRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrturoF1KNI2zk2DWlQBn8Q2O5Cz/tqTZORnj16OIET+zhLKd1
	f5KCAU+P3t7nqvQpscqJoXj9hL/5lh6JkWK6uWOMTsKxNAdBhD32tKhxKUPJPQc=
X-Google-Smtp-Source: AGHT+IGE0tgvTOYhl6F6bmPumOXK81X+mAvwcn8J4Wmk4yCW9mIalh760l6gAYLCoA/c+7MA2f4sdg==
X-Received: by 2002:a05:6830:4188:b0:718:a7e:85f4 with SMTP id 46e09a7af769-7186828f9camr10938259a34.24.1730230165409;
        Tue, 29 Oct 2024 12:29:25 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec18598e79sm2452495eaf.14.2024.10.29.12.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:29:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 29 Oct 2024 14:29:15 -0500
Subject: [PATCH v2 2/2] dt-bindings: dma: adi,axi-dmac: deprecate
 adi,channels node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-axi-dma-dt-yaml-v2-2-52a6ec7df251@baylibre.com>
References: <20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com>
In-Reply-To: <20241029-axi-dma-dt-yaml-v2-0-52a6ec7df251@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Deprecate the adi,channels node in the adi,axi-dmac binding. Prior to
IP version 4.3.a, this information was required. Since then, there are
memory-mapped registers that can be read to get the same information.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

For context, the adi,channels node has not been required in the Linux
kernel since [1].

[1]: https://lore.kernel.org/all/20200825151950.57605-7-alexandru.ardelean@analog.com/
---
 .../devicetree/bindings/dma/adi,axi-dmac.yaml         | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
index b1f4bdcab4fd..4a4295e699f0 100644
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
@@ -123,17 +127,4 @@ examples:
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


