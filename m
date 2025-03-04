Return-Path: <linux-kernel+bounces-543882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A31A4DB0C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502B316D6B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D0204F95;
	Tue,  4 Mar 2025 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jANpfjcJ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BE32010E5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084696; cv=none; b=r3cpH+Rq/E3m0BGY4HVW1QDWQygYMUURrqRK13Ny2hxs+zNmvMcE+UqBOOavfajfU7jOqqrhYzFccBLKa7S1L4C2xdvZ66gmkW65IB4IpLzExVSj405aWnJnOjnufZrTXmRShhVF02DWoITVqGwqE8q4Dxi1VScJOe6cm3Fj8Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084696; c=relaxed/simple;
	bh=Wam1Dxy8Bbgc/5NwEFi/OZRhWrfo5AHEYP0wl2UfjTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrlUdK1agR8zxXswLN+B1u6Dh4zBr8na3SWvmwlGP5wF5YyTukEA2lX5Cpkumzt96hKa/SUCcGEMufStl1d63ENXdrJhpWEwn1NS9nig7bSVDnZXIGFD0OFKl1tMA5uosUcEX0qt9w6oDz3Ym2cEgw3ptf+Y0s+g8kP3ZjghNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jANpfjcJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bc21f831bso2094255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741084692; x=1741689492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRT6zOAR06y6e5a1u/1hudMd12hMY8AMBwvepK3I88Q=;
        b=jANpfjcJ+9klFJP5zxDmYByJUCIKEF4rTDHsq1rEVZ0D26cDjPi/ABatWZDqSwZ4j5
         EPhH94D8M4PVKHYdrkMuiOyowRezCwbns0KhmJyWJ7TDMAng78lAoolnaRS5zoEt5wT6
         F29WQW27Z05V/8LgBDGP8GF0mqxF7xbbdNBODknzTaC0/XwsVaFBWs8FCQZJLepLQdBP
         JpFGZBxa8R/SFLW3QZeql1dmVabNgMOzJZUDenJAI9yawJK3YnTDXbseVGZWlUzUzhKU
         A2VJO8AAje4AfyEnJMS/QJEvCUEWya6uWiiQaB/ylE3HZ0HUWx8o5ClY2Z4n9ig8CsnF
         TdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084692; x=1741689492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRT6zOAR06y6e5a1u/1hudMd12hMY8AMBwvepK3I88Q=;
        b=d/FztchrOnxKRFJd8fFU3nKyWcSZROPalJOgnXCNShUeRVs9AUX40iAxNad0rVZOnn
         7bjruS6Wn/woKDWjl47r9yGtUBU7Bkeq/SC315hFxkT8Hlz56SdnaZQSZ3ludiunAmz8
         7GfZCm0LH8kjjIneQU6J26zhiYm2x3O5kDmtZm5CmGJYRvpfmtMst9WemSACeYTdy+fE
         +tlhYlhNZX2c0eoQS/DYUmPccrSxlvkVfjGHdaJvyihbkNeSi2S21oSrA8rfhl8R59GX
         esV4OU+vbExbxdIqjnQ2oJ3cxB7MSPvsLzL+w29su+ENhJOJ/MA+lbAzQLh3Qc8UmCxG
         EZjw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Hz01qVYwLm/LbljYTAROpUbNiG0JAwKWlGJhyVBpxcnXDnKGOFnGxVCS7yUJiNNLcwYXazUaGlq9tcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75odqwdc9bB3FCHaykaeT+H+hQs+IDIgqhuioGTXaXMmoJh1Z
	uMt5W5konhvt0i+8B+G22PDqWrT34wwQ9s/UwmCJA4bS23ymQZnmdonJ1m7dCbwlrKVClWtk2/H
	ZL24=
X-Gm-Gg: ASbGncuCqWI9V3KamTJZqCQmXuXVTTpSEL6tgNHLwQhMBZkk+Bh7MojlsM5ZKErFqhf
	MddY7iypeWF7hLedv186gbl28mjLWEjYEQIIkL/tcOqEB3JOKC8Y/YhC3tQcQWjjWBohQR4ImBd
	q/WiiHqDMXr5GMb+MeQNa6uWwBvbseAuCOXgQeLfiLE1A2aAI4zqQDT4sGjH+i9yJGgV8Lx+WWF
	HoDuP8wjZ6KgTxzHi0VBumpeiA9xlLszDEFevqP/MlHLXDKGeMCaFDSHkkIe7exQKVxi1vmiYI/
	eLGjJD+l+TWG1bWOb33cguT2MKmYyso+Z8pKLX0gH2AMNlqHXY/cDBbBitw=
X-Google-Smtp-Source: AGHT+IGfNFBtTCkGMjxpoYoMf9mCyMbqZUVYcs5tbE+Zv0fhEqp67tfpgTNytZPPOfLXj9HjjGF61g==
X-Received: by 2002:a05:600c:b96:b0:439:9a40:aa1a with SMTP id 5b1f17b1804b1-43bcb604fbemr3817175e9.6.1741084692178;
        Tue, 04 Mar 2025 02:38:12 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b694524c6sm198574825e9.0.2025.03.04.02.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:38:11 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Yang <yangxiaohua@everest-semi.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: everest,es8328: Mark ES8388 compatible with ES8328
Date: Tue,  4 Mar 2025 11:38:07 +0100
Message-ID: <20250304103808.75236-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on Linux driver, the ES8388 looks fully compatible with ES8328.
One upstream DTS (ARM rk3288-rock2-square.dts) already uses ES8328
fallback, so mark the devices as compatible in the binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

ARM64 Rockchip DTS use only single everest,es8388 compatible, so this
will trigger dtbs_check warnings which I will fix in separate patchset.

No ABI break/impact expected.

Expected dtbs_check warnings:

arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dtb: es8388@11: compatible: 'oneOf' conditional failed, one must be fixed:
  ['everest,es8388'] is too short
  'everest,es8388' is not one of ['everest,es8328']
  from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#
---
 .../devicetree/bindings/sound/everest,es8328.yaml      | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8328.yaml b/Documentation/devicetree/bindings/sound/everest,es8328.yaml
index ed18e40dcaac..309c4d01db76 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8328.yaml
+++ b/Documentation/devicetree/bindings/sound/everest,es8328.yaml
@@ -24,9 +24,13 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - everest,es8328
-      - everest,es8388
+    oneOf:
+      - enum:
+          - everest,es8328
+      - items:
+          - enum:
+              - everest,es8388
+          - const: everest,es8328
 
   reg:
     maxItems: 1
-- 
2.43.0


