Return-Path: <linux-kernel+bounces-384213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F24D9B2871
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C41B210E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C222C19048F;
	Mon, 28 Oct 2024 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xs7FcSkJ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0318FDD2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099488; cv=none; b=ZFYKAbX9xcJUk7ZppsY+Lw9B/hWLpGj1fHgg7snReQB6IE5PE7/Rg1c8A3h81XZBx7qjTJlCeZWTqMjsbVTqbCazH89ootXIpKqM1F/OfnYN1zyeN9RRmTbx0hb9HgTWy/r7oUGKm6JIwr+q5fbTRPQU2ZDPxEtPkHpjFecnI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099488; c=relaxed/simple;
	bh=aHpLAYxTlMEVHnv2ecw60I7dlQNyB6DdFCFqSwpslz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PR43vzsWJg1Hu0uWFnTtrFstKCfch0m+DsE6/Dg0fNHiVvCfUVlPaarEn7rv19RcioQkt2rESBvOaMNjr6YyqLHxUY2bj7IXqXRDW7Wisg2MrKTtnfWVDkgGCiqH+hJYITluRdJwZq1OfncxSJsW97beamhWxKkGgqYuXEyiB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xs7FcSkJ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so5224571e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730099484; x=1730704284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULhAbr6+HaJtI9Ia2hfBJx7q7nYh/124R4mEk9Ita7U=;
        b=xs7FcSkJ3iF//R6RTA/Qv5CqRl47BSc/rqkjYkn64+dXHcJXTyDC/l+BRnGrtSLC11
         9SGD60Ok12cs79Qvw/ZyeQa6b3HLRsNTtNEqTqqRRkAiVJCBc+9XaG6+oKXzQDXfE5rI
         ZwCiMmJuhBG8/qvs0h00AiN/VtTZTtVUU5uMBf5D6XurPSdNx6fPOnolufT8ETjzzcEf
         606UenIiyjd7UTdaNk6na9mloNYhdkC2KY0N+K0ijOsO+TVYa9zjgvps2Jlh0DFm+XpJ
         DoeChvj/HWFNC/AvweRDb8NtS9pcz16zXDd7CjXUbje/PB9ehr9y/WixGcUFbIzNbFFZ
         jYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730099484; x=1730704284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULhAbr6+HaJtI9Ia2hfBJx7q7nYh/124R4mEk9Ita7U=;
        b=l2En8NXGRm+NSQuovXK6cVGJQ64a/nJiacyUio5jvMTFZ+xQLi3ugm+O14AI4Ut3p9
         RXbrO+xENuUgBLCtYH+ecCpNYuiweLD0PKkQgU0klQA/0TGjewdrIROJKyjU98SVeBv4
         k1GrqiSnA4lS1a2niWdsWPoKCCW04eiJsiBnvL7wJyEBHArwlsZHIDGp5Ivt8FogUJrJ
         q6K6AnQ10ub8RSInGOzFEQIKPCLFnjzGIa7WpICX7KKN1wCbiwcWBIXdEkjx8jN56m52
         tUFTTdGm0H6cM7jzpOPrYJpROYB0mu9kpJpm+f6XyawtO/mKSjyEyUeCYIBdv0ofwyb8
         dJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD7RQUGyKiBDSTPwpw8AY4MCQA/I8+pRo/uOYVXLillZVwAnLECdd4Yex259xAZ0Gj/kXI55Uag75xBXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyCbGmoZ+86j9ndrgPpDqqCCKnfevF6ytKfzP5ku3e6nQrY2Mu
	NAVhkB8jK9L8xph58A34qYVmLZq345R84lSZ9Znpnr0O8k2jvOdVYR2DlDBXdoM=
X-Google-Smtp-Source: AGHT+IGbdENREQEKPa2RMHYjdoBxo4u7k9A3sGOl3vRkVI04r6XfieN6bxSDI1V5Rhnbmxtn43WARA==
X-Received: by 2002:a05:6512:3405:b0:539:fcb7:8d53 with SMTP id 2adb3069b0e04-53b34c5fa2cmr2771839e87.46.1730099483949;
        Mon, 28 Oct 2024 00:11:23 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c236sm8615383f8f.35.2024.10.28.00.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:11:23 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH 1/6] dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios
Date: Mon, 28 Oct 2024 08:11:13 +0100
Message-Id: <20241028071118.699951-2-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028071118.699951-1-ahaslam@baylibre.com>
References: <20241028071118.699951-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

Depending on board layout, the ad57xx may need control of reset, clear,
and ldac pins by the host driver. Add optional bindings for these gpios.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index c81285d84db7..fe664378c966 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -31,6 +31,17 @@ properties:
       gain of two configuration.
     type: boolean
 
+  reset-gpios:
+    maxItems: 1
+
+  clear-gpios:
+    maxItems: 1
+
+  ldac-gpios:
+    description:
+      LDAC pin to be used as a hardware trigger to update the DAC channels.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -44,6 +55,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -53,6 +65,9 @@ examples:
             reg = <0>;
             vss-supply = <&dac_vss>;
             vdd-supply = <&dac_vdd>;
+            reset-gpios = <&gpio_bd 16 GPIO_ACTIVE_LOW>;
+            clear-gpios = <&gpio_bd 17 GPIO_ACTIVE_LOW>;
+            ldac-gpios = <&gpio_bd 18 GPIO_ACTIVE_HIGH>;
         };
     };
 ...
-- 
2.34.1


