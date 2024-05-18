Return-Path: <linux-kernel+bounces-182796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CAF8C8FFB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 10:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F75CB21458
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 08:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA805DF55;
	Sat, 18 May 2024 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLs4UKQj"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069E8479;
	Sat, 18 May 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716020226; cv=none; b=rlzajCW5Zo4afy+8aURFl8TGqeAUdHaI5y2yWkJe+IaoU3Lo+vaEJv4RD0Um0U6CUz3oPbA93OcX+RcZ7KMFCvDRKn/SpxkVThZ9ovJEpG09nKMXt3mDRZxC3EXkWFtZiD6vab8Lz8F00OrI4OxJ2JU0j6HcpPYkg0n5wGuT+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716020226; c=relaxed/simple;
	bh=b/By+qlaoHXuYxguwQzmC0rOTdsZjjVfrK/a8IvLpTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I2MHJtuAJAHmSnevGip6UuiBBYoqryWvGS1BEjclYE/+hRgijD89UqWHL+8dN8b8UgtOyirm4KnFOQC7jUqbQHeYtoA3rOvEOk9iN0bxGL4jouIQVLKrfo7LncdBaGq5enIOgHMazs709WlaSWV+Vx4Ye4LZnXptYqGoJFpPnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLs4UKQj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee38966529so9326515ad.1;
        Sat, 18 May 2024 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716020224; x=1716625024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEo3Oc4cs0XxLO515UB83B0dN8f7TDFENOMb1E+m+II=;
        b=DLs4UKQja5WEFcHUNA1McVVmzRXq5PIA3nnjYIQhKURxklVnqfYxecF6Ke2J+dIOYz
         fGOyCrtlSp49KowFP3lgb2/z+Bo3MSqOXLtoLxeGRXYjD8gyrXqAKJhukle/3AdGbn1H
         fg0lgfLPkXqoJnLAMYD0M8qNcdcozDPXEMcPZ3cNmUSjBOVTAqPTPkQdRFoNBmOMbZQh
         xXzCs6yZBHLI+hvtvkjpQmkF5NLQEN4Kt7uz2xJ4qmpBQcYIEt7ozRuRxQaof2RWLElT
         /QVwD0mDFMmbXZhHoo49i9dLYPLiTTQUyb8HoIr7HOBUvrxvNAxxx5sY2Jz8O99X9T2h
         r7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716020224; x=1716625024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEo3Oc4cs0XxLO515UB83B0dN8f7TDFENOMb1E+m+II=;
        b=rpBVyZSltPJ47Nl94ikhNIMXpAcDpfuMmdZgW0KCfMlIKLvqk5RzO6JBsP9ObDZ1Nf
         ZryhJWm7AYBbt+xX5JH5hZdZGP6StiMIXLyZmVk+9Jp+578vnuM7jXBMlIi5I6WSv5qO
         Gkj0KR25gdldPGxUGjDRFWok8Nw6vrilOaQRl6b+r7SecVposrl70/W1oDXqZ7CVU1IM
         duP+y08+UrtBqYo0PouIG1ypHPZkN+iuDQB6A0LqMlRSsV7aa4LgSc7coeJ2e9IC0JUr
         DadhDdJicZVBBCNOU56KQzMXCDiymCiK0B5+w3TCaUu0us8RYmV3hy6jjaKpRnSuVRFW
         1i3g==
X-Forwarded-Encrypted: i=1; AJvYcCV7g2uEG40FHRQMelRqbWWB0H855oIvqwEsaWgLDt1CUl6ax7wSbpiJl4y6kKCIXiUCWEWOrC6xI9E2JDCuRDjzVkS/hW4T6h+uXtwLM+B+v3JYQ4qAEwh382EVPOrDGJ8idor6U/s2n6iq4Acuu9erMqfeTay+arBqMAcb97sVi53CvyaY
X-Gm-Message-State: AOJu0Ywbcn18zaN/FSVi7c9yKAcOx/2Qd2kwpin1gfDMdN7ufXYQKFqw
	vqFd6A1gOyv178UsAC0csVloNxnNuyayyBgS8OLzD5LFQmcwyBuTd3u56IAxlrc=
X-Google-Smtp-Source: AGHT+IEYClpcc2JB0wkn40mXXwzYlNasuTlZSZlGFYWxAd2QzUJBsoDR4nrPV/Qk0HVeQiS8uVPOSg==
X-Received: by 2002:a17:90a:e616:b0:2b6:214a:71ac with SMTP id 98e67ed59e1d1-2bd60353110mr1829100a91.3.1716020223591;
        Sat, 18 May 2024 01:17:03 -0700 (PDT)
Received: from localhost ([103.139.191.219])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2b67158c36dsm16543849a91.38.2024.05.18.01.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 01:17:03 -0700 (PDT)
From: Kartik Agarwala <agarwala.kartik@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: Kartik Agarwala <agarwala.kartik@gmail.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: dt-bindings: mt6358: Convert to dtschema
Date: Sat, 18 May 2024 13:46:22 +0530
Message-Id: <20240518081621.63386-1-agarwala.kartik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Mediatek MT6358 Audio Codec bindings from text to dtschema.

Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
---
 .../bindings/sound/mediatek,mt6358.yaml       | 47 +++++++++++++++++++
 .../devicetree/bindings/sound/mt6358.txt      | 26 ----------
 2 files changed, 47 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
new file mode 100644
index 000000000..f57ef2aa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
@@ -0,0 +1,47 @@
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
+description: |
+  The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
+  For more detail, please visit Mediatek PMIC wrapper documentation.
+  Must be a child node of PMIC wrapper.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6358-sound
+      - mediatek,mt6366-sound
+
+  Avdd-supply:
+    description: power source of AVDD
+
+  mediatek,dmic-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Indicates how many data pins are used to transmit two channels of PDM
+      signal. 0 means two wires, 1 means one wire. Default value is 0.
+    enum:
+      - 0 # one wire
+      - 1 # two wires
+
+required:
+  - compatible
+  - Avdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    mt6358_snd {
+        compatible = "mediatek,mt6358-sound";
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


