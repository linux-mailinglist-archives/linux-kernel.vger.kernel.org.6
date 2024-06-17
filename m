Return-Path: <linux-kernel+bounces-217297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8D790ADEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B561C215E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDCF195984;
	Mon, 17 Jun 2024 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6x1WrJo"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66A190052;
	Mon, 17 Jun 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627335; cv=none; b=ISXJNOmkBatElJatEYM9nHfKjkfASND2H90j6rAPe5fp5WjirucUbmUagl3n4SZfwaX5xYh5KuUcvDQlD0xlJpaPjK9QbwqFYbZI0waR14E4V13IyDyQBrz5kz9BFp3M0mUHzNj7XTsDz79BpamYWueBkoI1ZTMmqMndxzq7a/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627335; c=relaxed/simple;
	bh=GviW3vyE7t+vL36TePuj3TAtuG/gJm5Rgr4v+yi5ads=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nM9nrYcF3lCWjAJHm2sadGLfIQguie4WVbZ3Lq/ZuSX8CKJsbvnRWyoHUJIGPLPs5Gg3dULSlD9xJwcLZDJPhMorQjS6VzUZO9cG7XLK2dfACZ8ZGGyYtR6tfSrHaoEBp2RkGDUUFwS6MRVhdvUyYx+xd6Ym5xzKOvb92uCIAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6x1WrJo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-707040e3017so1078713a12.3;
        Mon, 17 Jun 2024 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718627333; x=1719232133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UWyVc4M7eTb5AGiP+8W1B/GV5kGh/LRVFNVuCTnSM0=;
        b=D6x1WrJoW4WSazZKMoSgiq5USWB5lshG5rayb6Me56YUM+VD9TUt7BQrpdTZJgF7TP
         6FaN8j83KpGvKBtz6oy2w+NatnobWbJ+Yv5vnQClPFGEuq3pddx5Iooc/thBlaDAQPMs
         VDvMz57ZcUfB59nB0NHDmFWjtsjtneGOWh1FIGQFsgMjsP+m4VEDRCCz8v4eqDKAzcCi
         yo8bvHZfmcnyUiYiyGjFWRVRECh1Eyr/8MoNcmXL6rOPvHBSzbayH20544iWUsQtRUPw
         qXhI+SnNWCGhv7St23AS8SkbXt9rt4pEZ3VMyVElHY3FmUbbNXvJFRPFtw+sJeS3Ngk4
         AjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627333; x=1719232133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UWyVc4M7eTb5AGiP+8W1B/GV5kGh/LRVFNVuCTnSM0=;
        b=nCIXWWwM3aHtH82xVa17HZ6RDYbGekuYeKN53l99pGE9vsYHIb1Ib+jm9bj07gfZYQ
         c7/VNalF2kOJODVdmom1ZwozBQ1S3L20EQuagjzgUIAfFIUjRdO3nMgZgJ2YiL25m/SZ
         oycFPeybrR0wAdXgYRgMslUNnk1aocPSONkdY/yLS5bTAkdM49fSYJcAMVzvIqHX9zcR
         XPmjjFv7j6jEgQzhkT6leGyDruOoxprK214O9Fs6ZNkef/30HJNZ9qwFAaZxdvZGV3n+
         2nJ3cVcP6DtArWuQ6P115ClRU7RKqDZ5jLozMf26uA3Y8K9zf02l8WVt+G9NTe/WspwA
         4J9w==
X-Forwarded-Encrypted: i=1; AJvYcCV4qEK/hARsyvhx7POoEvbPb6K4R6JTxE5MpB+NugLsbLi5K/F8HV4avEFRy0usSxhKx0TpsFgUq2XJRZoO5WLpukNMfrBaFAAgCER90anQTDefzzehlqGlZgbpbXD86b59grzHXEmFkA==
X-Gm-Message-State: AOJu0YyyfL+y2Hj7ksjqaPqexXiCTJAFnIf1B3fVvsWP/s6keE6sIbK6
	xUj4BB8j2OLGDfGtAQYjSx5IFwyaxwT54nABW/3bzoxYYeyauAdo
X-Google-Smtp-Source: AGHT+IFX8izB3mF6o1tiQTdc5a0wzAqibuAMkHHzv5Ut0LqmOs9G8XhTl1gow2d9zNLssWlR5qsHrg==
X-Received: by 2002:a05:6a20:6a0e:b0:1b8:9d79:7839 with SMTP id adf61e73a8af0-1bae7effc98mr12104061637.29.1718627333484;
        Mon, 17 Jun 2024 05:28:53 -0700 (PDT)
Received: from localhost ([103.139.191.219])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-705cc96ad04sm7270453b3a.64.2024.06.17.05.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 05:28:53 -0700 (PDT)
From: Kartik Agarwala <agarwala.kartik@gmail.com>
Date: Mon, 17 Jun 2024 17:58:24 +0530
Subject: [PATCH v2 1/3] ASoC: dt-bindings: mt6358: Convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-mt6358-v2-1-5d9f0e99941e@gmail.com>
References: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>
In-Reply-To: <20240617-mt6358-v2-0-5d9f0e99941e@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Kartik Agarwala <agarwala.kartik@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2904;
 i=agarwala.kartik@gmail.com; h=from:subject:message-id;
 bh=GviW3vyE7t+vL36TePuj3TAtuG/gJm5Rgr4v+yi5ads=;
 b=owEBbQKS/ZANAwAKAXiEk+OPlULqAcsmYgBmcCvzb44A13hQbJW0d9knuBiV2aIhmZMQt5B9b
 Li6sNgX6emJAjMEAAEKAB0WIQSJkbnrkCGnamD0k/R4hJPjj5VC6gUCZnAr8wAKCRB4hJPjj5VC
 6h7yEACO+1WuhhLpKGdAP1zmh186r4yNnl3tAWy0/iiH1rmNtLmooqWEB/6c2vr4MKJtQsihXvk
 y88oe4TCDC+dChZOlTTm2z+HaFg2315xokSnvewkjkctYYoJczspb8htCsgXy5mamSYqpNtTFpt
 FsM0vVGG/SLz3lVITh6jd+PWHWNnDFCSGvIIc/Kt/AWr86sxOy5RXoPx/FR7FgAxBNcAl1S9yPh
 8CfxuHz0IPso5X9PyUrCNpbhFUdquFoVPzsSKQPMk9KvAM1qhXlv5ZYs+E/+x436RFeqXRUvOhO
 hyAOWEMel7lHOsmP60TVqw7zR86Og6feoJDlBZkc7Q7e484tprwVcHJGABJNnXPZWd9XkoYvGsP
 0O2oiZF/wAZFhi17hn4QVL2tZ0xzxjjvlDfR6K+lJhsYT1yBpFYaVV6w4XqKZgbhaGCc0hkJPyL
 dtS0rQZxMh0TxjQhOMg1cc9FvecFmCMUM2kRpF85QdC9dAxaDForWax7uPIh/loaCg4HI2rOHTe
 Z5s6t/j7+mX/BaWZy8aPBUfIxc4f2Moqt8MKOv1gTabe28HQcOGIBEWl3o2/VJtIcclNeuJtl1H
 mSZivqkYIKAKBBYE14TiAvgZmb8BLlb99slcgHvSwu4N9ZoEvaR3Dv1MOYvdlz/Cf7+H8/5m9U1
 PNAR/fEp9snz31g==
X-Developer-Key: i=agarwala.kartik@gmail.com; a=openpgp;
 fpr=8991B9EB9021A76A60F493F4788493E38F9542EA

Convert from txt to dtschema
---
 .../devicetree/bindings/sound/mediatek,mt6358.yaml | 51 ++++++++++++++++++++++
 Documentation/devicetree/bindings/sound/mt6358.txt | 26 -----------
 2 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
new file mode 100644
index 000000000..336d2d969
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt6358.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT6358 Audio Codec
+
+maintainers:
+  - Kartik Agarwala <agarwala.kartik@gmail.com>
+
+description:
+  The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
+  For more detail, please visit Mediatek PMIC wrapper documentation.
+  Must be a child node of PMIC wrapper.
+
+properties:
+  compatible:
+    oneOf:
+      - const: mediatek,mt6358-sound
+      - const: mediatek,mt6366-sound
+      - items:
+          - const: mediatek,mt6366-sound
+          - const: mediatek,mt6358-sound
+
+  Avdd-supply:
+    description: power source of AVDD
+
+  mediatek,dmic-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Indicates how many data pins are used to transmit two channels of PDM
+      signal. 0 means two wires, 1 means one wire. Default value is 0.
+    default: 0
+    enum:
+      - 0
+      - 1
+
+required:
+  - compatible
+  - Avdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    audio-codec {
+        compatible = "mediatek,mt6366-sound";
+        Avdd-supply = <&mt6358_vaud28_reg>;
+        mediatek,dmic-mode = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/mt6358.txt b/Documentation/devicetree/bindings/sound/mt6358.txt
deleted file mode 100644
index fbe9e55c6..000000000
--- a/Documentation/devicetree/bindings/sound/mt6358.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Mediatek MT6358 Audio Codec
-
-The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
-For more detail, please visit Mediatek PMIC wrapper documentation.
-
-Must be a child node of PMIC wrapper.
-
-Required properties:
-
-- compatible - "string" - One of:
-    "mediatek,mt6358-sound"
-    "mediatek,mt6366-sound"
-- Avdd-supply : power source of AVDD
-
-Optional properties:
-- mediatek,dmic-mode : Indicates how many data pins are used to transmit two
-	channels of PDM signal. 0 means two wires, 1 means one wire. Default
-	value is 0.
-
-Example:
-
-mt6358_snd {
-	compatible = "mediatek,mt6358-sound";
-	Avdd-supply = <&mt6358_vaud28_reg>;
-	mediatek,dmic-mode = <0>;
-};

-- 
2.34.1


