Return-Path: <linux-kernel+bounces-282306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D9494E1E0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0B71F21482
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D814B94B;
	Sun, 11 Aug 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YERIm9ll"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08C13634C
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390515; cv=none; b=kjTccJssEHQbsgntM6uWJ2uwcFhd+8vXwoKXbmB8ekVsYk9J9dLEHyUvxk+iUUZvnMUehXyGOtfwCOaY1I7Z+yaEpk63NFN7HpFO9Ej6hV398mhln5yWgRVYSw2tT8zd5JojONddCFHalIVaGcTlTDVAaKgg8u839rcYZ7CsvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390515; c=relaxed/simple;
	bh=QAvfaAbOsXk9UVQP4PWy9GMW+2u2kGRbEaUXFRTPYgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iofg38gl/BomDOBmtU9mKRJBDjEstxHJ3jncWP9VnB80tzieUfEjooXthBj9XqDQw5XfbKDZ17W7KN7Bhg7MLJKbgJFbH62XKDKYzJ12aiIMN8tlKm4hXghoCq8H3GqFgxeW69AmIoLlWAXq7T7fiO/l9IYMOaAOE7Qb9wKyRtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YERIm9ll; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f1798eaee6so34069861fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723390512; x=1723995312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h512tKUzrukolR3pPpaZsPrCSEQtmis2nYDZ65tFXrc=;
        b=YERIm9llauAiZBlbFVdyOYCpCbIiwd3+1seB123iR7TGo2UfplVNHMFuCetDusmhSC
         pculRWVDdPzD1Ea1TvaaMGGBrS4eGdoyLclrP24Pt2PTa056d0lA6sZRAUh+bo72PeV3
         7ndhTOdGuh1KSOrW/cqz4ULYv4iJTJqIQVPXvWFHlngkEmvExMVyrKwT4ShkAA5zc9G+
         RfvD/syiM7lmpibAhTvm6+2jVWYl2jRgRsO2rPjkrQu2rkaengTV3+w/VBh4lMSofNGR
         0tsr3GPdOLtPrBWTRSGEcHvdSml9w0RMbv3EqfpJf/gK4FsDoRnL/2pp7rlVrvZ2wBqn
         kFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723390512; x=1723995312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h512tKUzrukolR3pPpaZsPrCSEQtmis2nYDZ65tFXrc=;
        b=EDOJlxFL2HYFMyGgT4b9jmL0ta1hqNn4/nTluYOE9Aiz9av1CeWqle+wkwQfJsOCZX
         oiRdnxcgjCYjpAgD/Q35dQy+L/N2Q+CrKyiD2OXfy0J52tRzbuqabAiKvz1U4FhQ8LLQ
         xgFDJqSkxqO2L6mZ9tAMZV8VxBCRRc0OrjFDbJVh5I8oKMFIXuyryHBZvjT0Vzf03A/9
         b0a8J5BOcUk/7LXpNWr7zgrjkxx8a+2qk/6jv5oXJfEq/OKQSpaP7ocTiwaF5QUNMkxA
         zlAhy8VULe2t/8CZ7wMta8cSIKZqXSg1seAXkXQDx+0F4HUFEE7GR9wCxipUkbdWnLu0
         jpuw==
X-Forwarded-Encrypted: i=1; AJvYcCXYw0qeyFS4UePLgBVLt9t0wpUpOtKnEkBiOZGe/OmKV4gGuUoNPz8WUjWh99FkVrac+hILCS0OAxn+JAJZ8NYoZsOc9lMCAmoGhIc/
X-Gm-Message-State: AOJu0YxKL43g02sQXJdgUx+sbPxD9S/pJRcOryE+k+lOTtN00E95JoLt
	5xQNSOng6negvIDsn+N4AJeQxp2zqHGRDkunsRi2ykyS0uXllPOMB6VKEVksBzw=
X-Google-Smtp-Source: AGHT+IElBSdZkuVW6lgNALLxjJCeoQbC1iMNNU5r3lu53hIis8YE+kgaeavVnIQrSshX/1V7GzgJ9Q==
X-Received: by 2002:a2e:611:0:b0:2ec:1810:e50a with SMTP id 38308e7fff4ca-2f1a6d3201amr44316581fa.32.1723390511583;
        Sun, 11 Aug 2024 08:35:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72d69esm158276625e9.5.2024.08.11.08.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 08:35:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: fsl: fsl,rcpm: fix unevaluated fsl,rcpm-wakeup property
Date: Sun, 11 Aug 2024 17:35:07 +0200
Message-ID: <20240811153507.126512-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the RCPM consumer example from the binding (LPUART device node),
because:
1. Using phandles is typical syntax, thus explaining it is not needed in
   the provider binding,
2. It has 'fsl,rcpm-wakeup' property which is not allowed by LPUART
   binding so it causes dt_binding_check warning:

   fsl,rcpm.example.dtb: serial@2950000: Unevaluated properties are not allowed ('fsl,rcpm-wakeup' was unexpected)
     from schema $id: http://devicetree.org/schemas/serial/fsl-lpuart.yaml#

Alternatively, this property could be added to LPUART binding
(fsl-lpuart.yaml), but it looks like none of in-tree DTS use it.

Fixes: ad21e3840a88 ("dt-bindings: soc: fsl: Convert rcpm to yaml format")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/soc/fsl/fsl,rcpm.yaml         | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
index a7db0aad2b25..03d71ab930d7 100644
--- a/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,rcpm.yaml
@@ -80,17 +80,8 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    rcpm: global-utilities@e2000 {
+    global-utilities@e2000 {
           compatible = "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2.0";
           reg = <0xe2000 0x1000>;
           #fsl,rcpm-wakeup-cells = <2>;
     };
-
-    serial@2950000 {
-         compatible = "fsl,ls1021a-lpuart";
-         reg = <0x2950000 0x1000>;
-         interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-         clocks = <&sysclk>;
-         clock-names = "ipg";
-         fsl,rcpm-wakeup = <&rcpm 0x0 0x40000000>;
-    };
-- 
2.43.0


