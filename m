Return-Path: <linux-kernel+bounces-285372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B327950CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03406B226F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCA31A7061;
	Tue, 13 Aug 2024 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qWfOiFjv"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116A1A7041
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575523; cv=none; b=CeX94uIfn3kNBjRi9jsTIy6PEShRMku4b+DD1+SggyNPVS6gSejzO0x5MT9S/Je/7oHV3LDZa8kHRyM7OhxWgXQOCX2GCTglgUSbqTbglWXohWiPb93arConf8hkjFNGC7zXa+EGa5I8s48Lzv7nOCopgUJ+z5E3a7/yTizRuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575523; c=relaxed/simple;
	bh=cgKJ86aFQSXRkOjVomh98YNMu7bmzApkdVedZLziGQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q69ODHKcA2u4tdqPiCoiu0QhU+p+JOl8aSw/NX/eIigUw+6OfaJ6cBbgQxBhhUSp8eUc2X1XPct4Gj8THrsGiKf1AI2xzdqyI6gwOw9xeFiSi9FX2ooU6Q3vi4CFQ0A74GNFkUdHBhWETvh3QcRZBqxjAqvS8FN4PHeXN0yu71o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qWfOiFjv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ed741fe46so6322033e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723575519; x=1724180319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUV4XHIlWDdmSvDrr/xcQAhn7NeKcNTvFWfePKkt2OE=;
        b=qWfOiFjvafyFjK/BMEWr1YZgOL5h2I57oiPSOX0QdINpGG0sI9WIiNPWeJs3yFZbs0
         UIBfX5K8BFBW14TtKnbKAqP2d0GE+hHxwAB5V7EDIX9/k2CVPhv3gfgdDGYcxgAFjDj6
         N4ZKn0B8nMX+I1e3ponl0nD2UReqevGHqJduBYhHYKiM4fykc1s+0VLtCLI6e5RlWROD
         ptIKrlxwS0KizXOnQl3kv11wHLPfjd4qT/8E/RMpux25qbLCcje5cihTnT17mj1kSjnD
         8Q4EToNB0mX0mwyiV4gw8iqbFQNbXWitzOaQEu4sWxmkWeTyFaF9ldrjp8C4AZON9JC1
         MdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575519; x=1724180319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUV4XHIlWDdmSvDrr/xcQAhn7NeKcNTvFWfePKkt2OE=;
        b=kaCnE7/feya8ACbSr7m398k7kMwJGP4Y2cml9bZ4xvxgVW0IZYLurqrjKSdYWa0zjj
         zxHcMV3ASLhfdYbGt6pxaEf9bk8x6W2eEkbIWxGeN8BvdUEbfQsV3TXq5m+JGq1TRNQC
         UXCRlF3xjqI9C7B3PWZit20bx8o0f8XaZK3x7kTV5kvFZHjq8z0IlEn1ALex1IwSlH/Y
         +j6mlpX91zs7mi1N3fDLjhEkvyXd3GZ4/9d7yyiEnidkxMSn3zaPB35P+c/5FtaE0LqG
         f6UANvgWgbI1/uZqOSkmZj6XBeUyQ/jh//VhbBn4rCGvGWSr69AztQ9U6lJpTFPC++4D
         /hww==
X-Forwarded-Encrypted: i=1; AJvYcCWVOCdCoZnftJepG9rRRATl593k72r6l1jtXm9XxmrsnVcAECEh7xzP9uJAvllcjc+5MBRwrlqpSWF/TqpUGKDGk5adiv8TIBQl/ldG
X-Gm-Message-State: AOJu0Yzh3b1ta75TcVFSgP2itPTStSPopoA++Y7MycZgFrSMmXeMjYuc
	sFph8lRFOcwBOD+bvyegwWcCnjbxX2D64bOnE04zI+D5FeuhnGRol6evQ5LwQZ0=
X-Google-Smtp-Source: AGHT+IGlYNi54ow/y9t4POWEbVoEw86CSboMPSwBpuuHQA7APctLUhJ3CK5aCCTQbHdiSdknwVbK+A==
X-Received: by 2002:a05:6512:39cc:b0:52c:d626:77aa with SMTP id 2adb3069b0e04-532edbbf2a5mr203953e87.58.1723575519313;
        Tue, 13 Aug 2024 11:58:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775c509sm151208145e9.44.2024.08.13.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 11:58:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] regulator: dt-bindings: qcom,qca6390-pmu: document the swctrl-gpios property
Date: Tue, 13 Aug 2024 20:58:27 +0200
Message-ID: <20240813185827.154779-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813185827.154779-1-brgl@bgdev.pl>
References: <20240813185827.154779-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add support for the swctrl-gpios property which contains the phandle to
the GPIO indicating the clock supply to the BT module.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/regulator/qcom,qca6390-pmu.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index 6677939dd957..11ed04c95542 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -68,6 +68,10 @@ properties:
     maxItems: 1
     description: GPIO line enabling the Bluetooth module supplied by the PMU
 
+  swctrl-gpios:
+    maxItems: 1
+    description: GPIO line indicating the state of the clock supply to the BT module
+
   clocks:
     maxItems: 1
     description: Reference clock handle
-- 
2.43.0


