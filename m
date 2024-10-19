Return-Path: <linux-kernel+bounces-372885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475A39A4ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6873C1C24206
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E05187849;
	Sat, 19 Oct 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxlqf4BE"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D13183CA6;
	Sat, 19 Oct 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349358; cv=none; b=RIc/MHWsauXwO8T2PVHm937Jvhbb7WSRZCe7yBaO447oRGzXhCj7rLmk0ATRmqMMKJAfSjD+l1QrMlEIRf6tyhEOKLtEWaRiF6JNYNxeP62+LWs8P24Ofze8Q+v790mSd6kGArUkhP4amcL+3zRSnG0xrW/sEVS7tGqcC22iv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349358; c=relaxed/simple;
	bh=CGRQrWGPCB2wEOhuCY2E3zAM3jIKdHDTmthMvbBL/Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iytr5Weyjstpa3IOHppFpjlmgoivI1AIbKZcSYu0vCN+LYn23LwR4UXXcFzo0NaM3+9uB2vbsKlSnFYZIM5ALj17+i3PQIraG/0bfOUcDXyfqaPyw2LErUt7GQViyhq7pE9fBgUE3NQ4Qa0rAGT24tcunH85h5eV5qv1W4spl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxlqf4BE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so108360a91.2;
        Sat, 19 Oct 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729349356; x=1729954156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhwUQq8xRgyKVXYvEHYbVkf584DVsy+IMqy8IqguQuA=;
        b=Yxlqf4BEtsaXFUmaIgXK4XRKW2H9KfmBj0epA49YD9iDbAKMZ2BFMUiXCVFrL0c/nI
         yjpos5AlWWyMYuYCbRIqu2Bv7y08806D1/CcEO1kkyrTw0uN0RCQerF7ucNLec8lA7dc
         rmU55hTc3JizDMIchviOOeLNQC3JzekxQ+Dtiuh/y4JannplS22ALvgRS5OOJh4fkX2v
         Wg9VKsjbdWuKzhA/52azVtldsxkV85h0Ck1ypx0xucyxFP98B3BUQX+0WxXmsM17IOXp
         MuLfZtdnCWRr+rphI0dNmSFsaV8j8uZuNe2ESs7bRUgojBZ95lpjZih5ZNg55JcametP
         xULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729349356; x=1729954156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhwUQq8xRgyKVXYvEHYbVkf584DVsy+IMqy8IqguQuA=;
        b=m+c0QfBQxQEeQXkFwwVh4bHBlc5Pq0aS1bhJzfScz3HXDjgi1hxOLdPIAgL1Me3286
         5k1DIFzyhmYlpfAm7SeaDGTGQ8nKqkhoLAsXz2qfKTQX/2CRMQ9z2y1/0NYexqifpDXZ
         R7P+oyaJ1G/6KJx2iCTSPFjkc41weveAUKfRHxLoLdE9BIxkc7FC/TD1OpbP01SydqUR
         QUrwKZigiu458x5Gjqd9kuf6ehYmJ8kLYOmthcX+8DJY8BE2p3luZT4gdzntd35/NhSr
         UvTbv1a6xT9I4dZKTVAL9+k41OSQSTfDP87qlLj1GRLRTGbMHxI9TceZdzmQrLHuwex1
         /F0A==
X-Forwarded-Encrypted: i=1; AJvYcCUqmJYf7wH56K+LGT7SSsDxGYjVwZD9grXPVCCy65Aov2RBOd3IDm2pknG3qTgMh7/sDS2CweEqf6Zw@vger.kernel.org, AJvYcCVYAxV75x1hQz3w6qutirTxSMm4AE7CcmmpHl/kDJiKFu+FTaN5e5eJBldq6+QUNAW8CGW/dv2BdHIprjs=@vger.kernel.org, AJvYcCVpuZ0YC8NTsIU0mxKn2L7TIruD6695/iHwo54mljGAFt/tMGCgfRNcQLen08tpLIHpQoGW5EFZguBQ+rJf@vger.kernel.org
X-Gm-Message-State: AOJu0YzmsA4wnVYGvh/6slb7or0eO7DZ7KKGY2xrN1CJgEu0s9cUJbsO
	5jwZOkyGoKmLNUZWdWDkLT4ZQRT1Gt2qseygpGyHwRAV7cGZ014F
X-Google-Smtp-Source: AGHT+IFoMfXb+WWx1yjisZev6AjKMqEcuFJYjO6od7ItJYTgj84FW6NPi9z47XnCmZ/0UpXvL3thPg==
X-Received: by 2002:a17:90b:4c4a:b0:2e2:c1b2:26b2 with SMTP id 98e67ed59e1d1-2e5615d0c2emr7712513a91.5.1729349356130;
        Sat, 19 Oct 2024 07:49:16 -0700 (PDT)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e58390d63bsm1325747a91.0.2024.10.19.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 07:49:15 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sun, 20 Oct 2024 00:47:31 +1000
Subject: [PATCH v2 1/3] dt-bindings: sound: Add CS42L84 codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241020-cs42l84-v2-1-37ba2b6721d9@gmail.com>
References: <20241020-cs42l84-v2-0-37ba2b6721d9@gmail.com>
In-Reply-To: <20241020-cs42l84-v2-0-37ba2b6721d9@gmail.com>
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 James Calligeros <jcalligeros99@gmail.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: asahi@lists.linux.dev, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>, 
 Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2909;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=n8Yfex3MYwMbSMbMmYbe3nbFOPKUbAErSFcvPImRrUw=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnCx+7beGrpH+3ce4JJPvdz8wwZU88d5+7/+rI80SVpw
 QfVE74qHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAExES4bhn1mLrHLGpeyWJXuj
 OMV3Lva2etOlcXl/Xe/b8/vO+HiEtzAyfHg1OeKwmf3uCINT5vcX7wm6seap9YJJ/l25av9EmHI
 dmQA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Martin Povišer <povik+lin@cutebit.org>

CS42L84 is a headphone jack codec made by Cirrus Logic and seen in Apple
computer models starting with 2021 Macbook Pros. It is not a publicly
documented part. To a degree the part is similar to the public CS42L42.
(The L84 superseded L83 seen in earlier Apple models, and the L83 was
pretty much the same as L42.)

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
---
 .../bindings/sound/cirrus,cs42l84.yaml   | 56 +++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 2 files changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7f8338e8ae369bc529ac3cf35041d5a7b9f3e6d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs42l84.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS42L84 audio CODEC
+
+maintainers:
+  - Martin Povišer <povik+lin@cutebit.org>
+
+description: |
+  The CS42L84 is a headphone jack codec made by Cirrus Logic and embedded
+  in personal computers sold by Apple. It was first seen in 2021 Macbook
+  Pro models. It has stereo DAC for playback, mono ADC for capture, and
+  is somewhat similar to CS42L42 but with a different regmap.
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs42l84
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      jack_codec: codec@4b {
+          compatible = "cirrus,cs42l84";
+          reg = <0x4b>;
+          reset-gpios = <&pinctrl_nub 4 GPIO_ACTIVE_LOW>;
+          interrupts-extended = <&pinctrl_ap 180 IRQ_TYPE_LEVEL_LOW>;
+          #sound-dai-cells = <0>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c1a2c296446c0724a0c6e70c845e5e5e1e693fd5..f5f85714dc4e8ca9c60b3f6963b2cec1ea33fdd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2132,6 +2132,7 @@ L:	asahi@lists.linux.dev
 L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
+F:	Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
 F:	Documentation/devicetree/bindings/sound/apple,*
 F:	sound/soc/apple/*
 F:	sound/soc/codecs/cs42l83-i2c.c

-- 
2.47.0


