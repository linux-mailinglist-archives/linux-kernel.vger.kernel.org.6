Return-Path: <linux-kernel+bounces-426689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C4E9DF6B4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D742DB21639
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB7F1D89E5;
	Sun,  1 Dec 2024 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fxl/9jb/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B91D88DC
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075246; cv=none; b=mWLE/1mQaZy0ttrL3ngkNdd45HFkUTl1QDngaJ/Qvx5K7kihx8x4ocICVTQzfbGK3h8TH599NOHDqYdyDF5LZ9X0ggtPjfTTikmDYbWrNNYZ0RhuIBtntDktczDaebHPg2exLlZ0rD8VUDBTAil+RLDtC8OY66/IcSfoLbF+NmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075246; c=relaxed/simple;
	bh=z0V5Gl9oP95XYAidqMBjgfFtgx9xsZSr/31PbkxMc5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvq17RB+6agBYKQs+NIWnXarpmDcrNpxRDPl7emlWhrd2he6wqrvSzA6JpHAhHNuxlu0s5Gxldb5jVWLv1W5clIAt+b74fxZr/Sr/SdaByoI8plSLPRVotn4+LK0HtM4lLSxqSiX6+4e8GqJRh7zJY4bjc6zzffQZdUDGP/9LrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Fxl/9jb/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5b0d8bd41so373374366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075242; x=1733680042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta60IQaIhWAnkSstQ5gFLSU/BoHgdvU4T6DFjF2nino=;
        b=Fxl/9jb/V/x99d28HE4THVGWWpQCNL+xWVb2NBugm6exIfdWYMqENc4eJcChFe+Ppk
         M+Hhc6bnGheRQM8NAknfJjqjS3DgcfieYKLRGdUVsdTOB2+oOnemBXtNSg+udDtgKkw0
         wEFg1OFt4Qr/szuFmPMY1AgBVqjG6gfkXEN9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075242; x=1733680042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ta60IQaIhWAnkSstQ5gFLSU/BoHgdvU4T6DFjF2nino=;
        b=UGGU5DkG7AJMY5y+04U8EJoajJWx9aX4ctKglIqfChpLPrUhoSJrt3wgSOd2I5wE7d
         piaJT6BmyC+rDjZDWQWRv4lqzKcYBwL2tr9lpaeC60ugUGl/HeDckVMcbf/q3Klffe+1
         9pOGNuzq8jPt004sPQxXj2+4j0tXWq/iG4AoWja+jVxRwqpecv5AelPxh1WZZKRY4L43
         uFjc/FthKO/E5e63YSYJuRIvneuQ1L078fl77PSip7OhiSmDIy0O0zv5Rvy7mJ/wPVTT
         7uiCqZOvHv/vERp4jy9nZItbpY2545Wlt8s3j8NMs3wqhC4ODPqZ7tZgSL26whcLGMiP
         Y9LA==
X-Gm-Message-State: AOJu0YxiihaRUX6cZPi76WjR7eniPO6tt2iL+JcBZw40SFHd6+dYuaD4
	SoUvkBwjOuX2804Rjxus0KCJ3th6gcDDB8YZaoVMZqbwdrBc45rgWkNL/QCGxXubTFfJFQNnLZd
	g
X-Gm-Gg: ASbGncuq516vTDNATG43k+6IOmM24O4V/t4aEOrg6cO4A59aPBBEqs+ZwKaeTquf4NY
	3ADUxRVyuklCnzQ0ELageSjRsCOOwTpkcr4z4v8lNSObcRSuLZ6oGYtlEQ0mGF5oLagyEt5ogk1
	TwKU801TPvHGBW1rdrlsINzsxpG9v0fQGZX5CgWUqRO5hOUhbKrZl9wCw7EPsfHAZxzjBke1K+H
	/sWJBAHSU6CK+CMs+/WPLuhFwvbIArvhtlK6ChCz/va5JM+UQ/Gsksiu9JlHXkCi7P3fRX721gr
	eXWtUO/d2UWLyG5OS//wFMGOMYieEuYcQ4n3Ghe9XAUz8S1cfCyg7l6IR6WjzgcmEkSIudnP37q
	U3hcFU7vL0bKL5d4s
X-Google-Smtp-Source: AGHT+IFgxSmMaUuIfgqqx9wN9WkSl2CULWn6wLzUNHeYGK/zmvXMdPbcdrCJqoIfMbNoh6JOnFaSiw==
X-Received: by 2002:a17:906:3153:b0:aa5:43ee:2ff6 with SMTP id a640c23a62f3a-aa580ee8d40mr1783857066b.1.1733075242627;
        Sun, 01 Dec 2024 09:47:22 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:22 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v4 03/18] dt-bindings: clock: imx8m-anatop: define clocks/clock-names
Date: Sun,  1 Dec 2024 18:46:03 +0100
Message-ID: <20241201174639.742000-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define clocks and clock-names properties of the anatop device node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

 - Added in v4

---

(no changes since v1)

 .../bindings/clock/fsl,imx8m-anatop.yaml      | 53 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
index bbd22e95b319..f439b0a94ce2 100644
--- a/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
+++ b/Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
@@ -30,22 +30,73 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+
   '#clock-cells':
     const: 1
 
 required:
   - compatible
   - reg
+  - clocks
+  - clock-names
   - '#clock-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mq-anatop
+    then:
+      properties:
+        clocks:
+          items:
+            - description: 32k osc
+            - description: 25m osc
+            - description: 27m osc
+        clock-names:
+          items:
+            - const: ckil
+            - const: osc_25m
+            - const: osc_27m
+    else:
+      properties:
+        clocks:
+          items:
+            - description: 32k osc
+            - description: 24m osc
+
+        clock-names:
+          items:
+            - const: osc_32k
+            - const: osc_24m
+
 additionalProperties: false
 
 examples:
   - |
-    anatop: clock-controller@30360000 {
+    clock-controller@30360000 {
         compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";
         reg = <0x30360000 0x10000>;
         #clock-cells = <1>;
+        clocks = <&osc_32k>, <&osc_24m>;
+        clock-names = "osc_32k", "osc_24m";
+    };
+
+  - |
+    clock-controller@30360000 {
+        compatible = "fsl,imx8mq-anatop";
+        reg = <0x30360000 0x10000>;
+        #clock-cells = <1>;
+        clocks = <&ckil>, <&osc_25m>, <&osc_27m>;
+        clock-names = "ckil", "osc_25m", "osc_27m";
     };
 
 ...
-- 
2.43.0


