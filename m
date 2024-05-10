Return-Path: <linux-kernel+bounces-176189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE138C2B66
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA4B23C74
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381213AD29;
	Fri, 10 May 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aO63s1mA"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4813B587
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375087; cv=none; b=E3LowoRaslatFvPvjXwe3aYLbuflBESZ6ZBFeQHVJkM/fg3MjY3kH0jifFZHH4Bne6hb/O0UH/U3zM2vzaCXP66hFsEv1JUPynO90UGBl0eZhedB4r6r7++/B9xESscyHyOgod+xsmHfIrNUzTafGh+m76hWkYyEEVLoNeE8Q2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375087; c=relaxed/simple;
	bh=VfLBOBFS9px1B2o+hcKJrQSVvzPYkQD50/pPCs8h+tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N1WKnlVhIdnkuFvGn5aVfc4TI/8uUJwSZrnzdOmjpRSItQNaayXDkdsevndY5toDQmEMnLSyPxzBR4PhLfCM+6YaxPq8joQ555UaGxtPBeCZp9ZT5OK3f9SrMaTkeSLv/AC7qFQoZM7Exlr7ZOxTAsIHzc09zPm7nh8+0IOx4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aO63s1mA; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23f5a31d948so1473921fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715375084; x=1715979884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qEYue/AOjuByQSAvDWI/eVpcJ2TVmrbfHj6LOCzHZ/s=;
        b=aO63s1mAzpq1Xm8ImptjXKZfduimyDfPqEQzrUcGeikuPfZ46qOb+9mp8apOKcl0N6
         RQkO91RuxPU2t2oxPqJaBZGvUxMdJxhdUuLIfz0OzgOvT05+45F2mpP26tUY7E23Ue68
         VvwbBibQBEJ/wtFQjg3hyV3kZeFMFLJ3bso+QRVlRypyjKxHPrp4gxxU/7OyGtlTPGnH
         nQy9sazTAX1M4qEgyISyo620En32HfNKRRLrEnZbDUgGC7HP6CfqwVmdHcwk9mFGtsDl
         a4oVHgms0+wWXAyGyaWTUBUAJ7ByFUQ9kz5D7u9CtxHU4XJGMmiMoU7Z1rYrdilC6XEn
         nIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715375084; x=1715979884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEYue/AOjuByQSAvDWI/eVpcJ2TVmrbfHj6LOCzHZ/s=;
        b=LS27Xe9A1gjeqg+hnPV1qsIHHIlxmtGfK2BC/hxobw0hA5PhcRviP1T1TKKI0twq9A
         sU2YcuuBmpIvbWMX4OS0ngCeRcZNysm/9Sgc/K8z9ouWNAcc7PqimWMoT9KSWcQD4zrQ
         28NiWVkm6iMDne1ASg9zhXBUTrQgTpCm3Zo5pBUrjJjb+Mf+UXj5uE/uf5amsOdf2jpX
         4wGfaFTVVYL8FbaNQXN+39oEjNmebH1cd1yGvybPPAtWrvltXVpwjRv/zxIiSTBbnzE3
         gAsZcfWwWL/8z7cdCspuQ8zslrOjgEHnPv1j7sBeeCpW1rfc0eRCftMXMlXeOXQ5DzQd
         KkRw==
X-Forwarded-Encrypted: i=1; AJvYcCWcw75nqyhL4LiBNpjNcTa2aiEcFvk1GvIxSqnwukuWOAvZeOICjdcYNSW9Bj3RVOCuZEDLyTLmqPh1XtbsavBGB+C3cGaACrL5F2ZI
X-Gm-Message-State: AOJu0YxeMQivL7XJbwX3D/gZSSYWGyeJCC8/KLXu9NbiREDscWc/LIqW
	XRMokKUl4NltLQLGgsZ49NsosC4PcUvc52yvYpYhvUP50q6ElkKvUvu9gA43Juk=
X-Google-Smtp-Source: AGHT+IE+Z9Gv0mEoyVq7GkQVyxM+Fbs//42IwhhbeCYp7oKZf4jj5u3ny+Hd+41J/i0ScY8ge+nQ9g==
X-Received: by 2002:a05:6871:3311:b0:22e:dfbc:4d9d with SMTP id 586e51a60fabf-241728f4fe9mr4400114fac.1.1715375084498;
        Fri, 10 May 2024 14:04:44 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01cc159sm841521a34.40.2024.05.10.14.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 14:04:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: adc: adi,axi-adc: tweak example node name
Date: Fri, 10 May 2024 16:04:38 -0500
Message-ID: <20240510-b4-iio-axi-adc-dt-binding-tweak-v1-1-a1f633c4602c@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

It is always recommended to use generic node names for devicetree nodes.
The documentation [1] of the AXI ADC IP core says "The most important
part of the core is the Receiver PHY module.", so using phy as the node
name seems appropriate.

[1]: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index e1f450b80db2..9cad4c439045 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -57,7 +57,7 @@ additionalProperties: false
 
 examples:
   - |
-    axi-adc@44a00000 {
+    phy@44a00000 {
         compatible = "adi,axi-adc-10.0.a";
         reg = <0x44a00000 0x10000>;
         dmas = <&rx_dma 0>;

---
base-commit: 5e3c5871138da700796587aa5f096d39135f9d36
change-id: 20240510-b4-iio-axi-adc-dt-binding-tweak-054f97a78bff


