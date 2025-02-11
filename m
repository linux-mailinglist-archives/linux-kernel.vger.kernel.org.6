Return-Path: <linux-kernel+bounces-510166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE3A31924
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7701888F00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C760268FE5;
	Tue, 11 Feb 2025 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1RApZK2"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E3272931;
	Tue, 11 Feb 2025 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314726; cv=none; b=oT2kEzZq38HFR+QZEU7yTHb3IsQiVXTBXWGV4gJ5Y/xUqmoWZ6aBaAdy56xRHcpE6xFMz2HQ8IkgbthFcCYR8keXymLLruRKKIs7tea2WWt1n5E8QEdQyHa5wtaV+EmYeb2i8J2aa9mt+6NskLYOPZlGPSd/MAlWMzge56xCWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314726; c=relaxed/simple;
	bh=g8kvqIykxXFFp06R0/+Qfir6GGNvMp+sOZWTkvHPhh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqDZcZ5jimfXmYeMrcqk33/SvCRnLj89ulPO0aY2BBx4n2NJBTqsfET+vjUKA7cy0UYWT0feJteuzkEtkre5CFSGRk9+tq4xtZt9z98b2zXR3pmG/rHAlcBT/Aq17WDbM1p4Pkille+jgx6vhJk5UpiXxRpjau+5T6yf+kWF0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1RApZK2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7f2b3d563so49104466b.1;
        Tue, 11 Feb 2025 14:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739314723; x=1739919523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvuS/3+qj3jrgC41XTgu3o3reZxECxd13x0obbo/vVw=;
        b=U1RApZK2h4aWy0QIIzrem3q06HL8fCNGYYr2fW2KIVIFzHOne9pv5+/7qiW6S+euIb
         rgHja9I47zeB7KntjoNrHPPRR2EqQqB+uokytOA9wqeVW/cOTASSvxAh9KqYhJPrmmta
         7XUiTToQT7PooeI+Il3R+2QZrgYD0f13X7bEIXHxsnPz599nskl8BDX6kXTs356A6Rbn
         gwjTmUqMmgBAmCzbc0rCILb2FiKfW8TbCiqrXtiPZmpbzo64d9Hul97yqRUryJcM+m6F
         UhPhpAVNW8AQdsWQ2A5HxFG7LYKqeXDjw7x9pxNcZYNIiRmL6xM1hwnOiMNAeTDvXuKp
         gHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739314723; x=1739919523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvuS/3+qj3jrgC41XTgu3o3reZxECxd13x0obbo/vVw=;
        b=BaaSl3sm7k55c1jNSSMq60Xn11CES4TiRfq2b4YbGTODbh/G58Y6TQhOeODKKt1aKD
         21OZuDoYtpLoOHmrbQXTtTbQdsLHUCVE5tprjnm1nMmSPvcb396yWpuMebkYapikd3ve
         inpanROxswoXu+e34G8Me2f2okpHEoCrjRlhRrW4yIsMJJiFxaZeyKZd1tRzRcXCcDy2
         TLs6biY+wUqivtyMp3B2yGoES/GLdtuUumeFyHUO1cpb8jLsnAV8zPZvpMSdjP7q/YSy
         8aUkaQeEtX3WCiGrXZ1WXVWKIjmy2kjJiEocwQ0zMKBDBFS1xq5iiBKRKMnfZoF6Dr3U
         +OWg==
X-Forwarded-Encrypted: i=1; AJvYcCVPYEGgNzPDVJw9u0LKShNj1F7S3Tt+8qS/oMYojeEEuDFpIHWrWtTlJqSoeo3WmPXFfUWG1zJna5JO@vger.kernel.org, AJvYcCWF6abgKDQS4PzQnXwaDzJJg4sJF+k5r4girx8g0QRQdjrbA+aiqGom7IN3vETGmYVsH2yVWgedD+UF+ysZ@vger.kernel.org, AJvYcCWucM+A/FSKeycgajpn+YeAbNxp9cxRvXrsWtHDV717YQZHoZbDrGEtZwHdK3qgq7bSL1Y4q/FifWrxYp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5cBsNOr+/WoEvU9/UgDd9TRllkpeGlT84UgWH2GQ1T777V4i
	vb+4jG6Qfs9me+vbeKLAYXCzUNGYyF1pujmBPvyZAqAVWNYljCJf
X-Gm-Gg: ASbGncvL1+MO8orGmvmhRAsHSP6LKdOSF80Rsv/LnV2y3o7/nEf0Lqn2X3NKUjDdosK
	LrLyXJmU/o6r3CwfstI7nbdo0oImJVl5uVl/JxM1yxeudNpnIM+Tyy3lFxpNL3G8qHf7rdxII9G
	l9aaA7kKtBjs7EndmRgTiTcxU8qC8QXOrNA7ZAT+ceGV/7UlQGiLLK9XiuqO84UEQhlgyiRWnQa
	jBm43YpETK02pidSGU3HcCWcfX43db4U7b7IYQG6bZemGk4LeEkOU5lcG5f0hWz6e9J7NuCIw6J
	FASHBX++ZpGRWxBdVSDV0fMeIsCFrfWTQCu1Flalk/TvpaHxFnQ73A==
X-Google-Smtp-Source: AGHT+IFmYf1ZrXBMSFnoxbMnODcTZWJfKyjsmmdnqh4tb+GgTGoTQYeo7N465iZhYGFhSbbcOGz2yQ==
X-Received: by 2002:a17:907:6095:b0:aa6:a228:afaf with SMTP id a640c23a62f3a-ab7f34da6f5mr58459966b.52.1739314722882;
        Tue, 11 Feb 2025 14:58:42 -0800 (PST)
Received: from playground.localdomain ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7e9fcd99csm131525166b.89.2025.02.11.14.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 14:58:42 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] ASoC: dt-bindings: support imx95's CM7 core
Date: Tue, 11 Feb 2025 17:58:06 -0500
Message-Id: <20250211225808.3050-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add binding for imx95's CM7 core, used for audio processing.
Additionally, introduce a common binding for NXP audio processors with
Sound Open Firmware (SOF) support.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/sound/fsl,imx95-cm7-sof.yaml     | 64 +++++++++++++++++++
 .../bindings/sound/fsl,sof-cpu.yaml           | 27 ++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
new file mode 100644
index 000000000000..f00ae3219e15
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,imx95-cm7-sof.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP imx95 CM7 core
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+description: NXP imx95 CM7 core used for audio processing
+
+properties:
+  compatible:
+    const: fsl,imx95-cm7-sof
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    const: sram
+
+  memory-region:
+    maxItems: 1
+
+  memory-region-names:
+    const: dma
+
+  port:
+    description: SAI3 port
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - memory-region
+  - memory-region-names
+  - port
+
+allOf:
+  - $ref: fsl,sof-cpu.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    cm7-cpu@80000000 {
+        compatible = "fsl,imx95-cm7-sof";
+        reg = <0x80000000 0x6100000>;
+        reg-names = "sram";
+        mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
+        mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
+        memory-region = <&adma_res>;
+        memory-region-names = "dma";
+        port {
+            /* SAI3-WM8962 link */
+            endpoint {
+                remote-endpoint = <&wm8962_ep>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
new file mode 100644
index 000000000000..31863932dbc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,sof-cpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP audio processor common properties
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+properties:
+  mboxes:
+    maxItems: 4
+
+  mbox-names:
+    items:
+      - const: txdb0
+      - const: txdb1
+      - const: rxdb0
+      - const: rxdb1
+
+required:
+  - mboxes
+  - mbox-names
+
+additionalProperties: true
-- 
2.34.1


