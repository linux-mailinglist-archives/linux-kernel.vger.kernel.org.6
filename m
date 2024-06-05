Return-Path: <linux-kernel+bounces-202258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AD08FCA59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478992823E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BCF192B9B;
	Wed,  5 Jun 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWOssg0x"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3468F6A;
	Wed,  5 Jun 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586604; cv=none; b=q6NjNtjjVL+ixUu9XzCFyH7Wsj2K9wVyAioavDVO11g+g45Lg54AwzG+sf7pnDxOyMGXOK6WJK0LRuYyp53leeM6TJrEza/tMysn0WNFHug5N4hEf6DlwLVQ7VOPooJr792WKuKClP6R9T5TACWA2wBCD5Fn243TUKMZAQ43RYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586604; c=relaxed/simple;
	bh=ulQWyHpv4zET4nAlFDTZoIUSCT3nKmoqAd0xhJpllkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8COsvLRQ0niiRfZ9u8lcGAuNxB+jXQ80RX30TxPeZwRG/6y09hz6C5ZuwYqVKkN45anjOjZ8fbJEzmIDv5hifSUAnkDpJpzY5VYm1ShkHjR55ZKJQ3iBu4YKvBLFHGtG82AhIS7BBofukoPp48r1Z/kfSFMAA4tGpfNSGaUGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWOssg0x; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f630e35a01so44109725ad.1;
        Wed, 05 Jun 2024 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717586602; x=1718191402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8lBmo+de872z4HgxVCrHC0+rUnsK/Cm/QHFRT3M9h0=;
        b=iWOssg0xojAnixwXgEbsfo2l6zirRteBj1e1YM/MqhJk0EzYTbFlz8ppX6M/laJ0nW
         dBpZ4JodYX0YI2oVv5sliDGnqEKTeAjmliwcsD4eH8oAAxF5NcBah/T8XJ8ObgDjITzJ
         +Zavp3txhDRC6AW/9X89o0uGWwkbJkHddQbfYI3GnHO01LNl8LS1NY8BgB7m/wbQqQOe
         jvSBYSm3uVQBEA/dfDnGzNm3Bfwgf/ph8b+5iRQjnGQexNyTHwTgF7D4gqeEko1nnglQ
         CHWlk4qz/hDpQyV3DcNlseq2wIAxS3vo7MT0cQZz2gorDTbmJHcEy9oW0B1a/vUeBEu3
         pjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717586602; x=1718191402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8lBmo+de872z4HgxVCrHC0+rUnsK/Cm/QHFRT3M9h0=;
        b=jalggt5N6EHJECfDOwhwzxDlkB5kbX41RdWX8Pn6CGzTymmOPye63AP2GPUBteFGxX
         BKYqz4wDA2et85IOGy4s6UKcosFOd2yGfaVRO4kacoRys6vw2fh4WvEaUoHWCXBzCLdo
         LRMQWccKREVLOII0TFx1wpQVQf5/CjLK0aLAxj8U2aQJ1eENnREGURTBMii0yJQuRKT7
         KWRgw5LBqYQo0PK0PPr8N65gB3hKsQYv0/kvNylSKtEQOo5RzhMwlwdDJ2cmslW2sQ+F
         P4Xlrq5YmFzs9ZpRwqYI5MHO2eu5LAhTcDqwoP48duC3RH5p2Rj6MV8eh9vw2DGW1ErX
         iBSg==
X-Forwarded-Encrypted: i=1; AJvYcCUwHnfaCFYqbOKt3dRYtLjglMHDkSnMNf+H77OLTfb9taUlasBTit1yqOao8J54ibFa7o1w6t+VIf4uwMoT6SdQF9LJVSRo/lY9tnGlv63+nCXZaCEJd5nF5VQWSA8h1mflF7awc9RHndRRREHR48SJ1hLFz8I5fh+7VJEiixp12tXeQqYQ
X-Gm-Message-State: AOJu0YzWpw4W3z1b6/gt2HH63UPqDQ7W0dzKblqiotUbkbU86RH5tpJF
	eq9SEVZ/KAudFhgwmtzfAwqkFw7fBnrd3wR9i7PQLwyvSPfTz0LUkgq8uiNX/pw=
X-Google-Smtp-Source: AGHT+IHkzDjzFHveJzOdoOOxAJAdaeEfu/ITXQnJJFI/PkEOl0kZbARGpPlkahBZfq5bftPE4Fs0CA==
X-Received: by 2002:a17:903:2292:b0:1f4:64ba:af9f with SMTP id d9443c01a7336-1f6a5a69a3dmr24294085ad.48.1717586602201;
        Wed, 05 Jun 2024 04:23:22 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241d378sm99866595ad.301.2024.06.05.04.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 04:23:21 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: linux,spdif-dir: Convert to dtschema
Date: Wed,  5 Jun 2024 16:52:55 +0530
Message-ID: <20240605112301.8171-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the dummy SPDIF receiver bindings to DT schema. Make bindings
complete by adding property "#sound-dai-cells"

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../bindings/sound/linux,spdif-dir.yaml       | 34 +++++++++++++++++++
 .../bindings/sound/spdif-receiver.txt         | 10 ------
 2 files changed, 34 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.txt

diff --git a/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml b/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
new file mode 100644
index 000000000000..61767873200f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/linux,spdif-dir.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dummy SPDIF receiver
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: linux,spdif-dir
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - "#sound-dai-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spdif-in {
+      compatible = "linux,spdif-dir";
+      #sound-dai-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/spdif-receiver.txt b/Documentation/devicetree/bindings/sound/spdif-receiver.txt
deleted file mode 100644
index 80f807bf8a1d..000000000000
--- a/Documentation/devicetree/bindings/sound/spdif-receiver.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Device-Tree bindings for dummy spdif receiver
-
-Required properties:
-	- compatible: should be "linux,spdif-dir".
-
-Example node:
-
-	codec: spdif-receiver {
-		compatible = "linux,spdif-dir";
-	};
-- 
2.45.1


