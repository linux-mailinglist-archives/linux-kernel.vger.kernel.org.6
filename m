Return-Path: <linux-kernel+bounces-534467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 355BEA46751
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E970E189057E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF88224228;
	Wed, 26 Feb 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B703/0uo"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CEA22258E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588866; cv=none; b=XtOCFehRMRO24CFsFu7zpc/z8e48p15ajXeFTIKr4LbN+XLpHLqCBLFUJbZm5LjgtabsWUJ+by8Hd5ANmyRHI1IKLmkj3bRQ2BA0Sa5BS2qz5/n5c1g6g8d3k6R8KsHTTQ8AffNz1iSDkXieHox6O4abQJ4ls55hUg0kFsU1ts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588866; c=relaxed/simple;
	bh=C2Mob+k4J3IoAbjsCJdN2Pf4fKN/wfPJXERox26zYvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JzVcIkdW3jkUyAZH1/ODAlR18si7+kvhGLsTVi8NbefpSSx98VsEJmmB81DRQVnb3U6iPUMmy+0So7VgBx4kQ59aSUVNVQIZY0tjTSdZnrGHoIwwWYNzDG6jt+upAUrVb3qNNR3wwVCgu3pBBKAFr/CPQuwFvZk12HzZZLEic/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B703/0uo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439950a45daso195185e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588863; x=1741193663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuMNXFiz3GQQsxpeqmzCHgRVoLvWr6tPdor7ZIiVrdE=;
        b=B703/0uoW+BJN6uaPF6RWRc0PfZ0M/2Pkg2/uiks+44+dStni5mkPtwgx6hbmmyxsF
         0OdBSCRxVu8k8bcgJ3pxaC7urA2a0KpY2JWI90ltdJo4FIY63s34jbYmmcd824kplEgU
         ZvD62HSk84WW7ocOMvYOURDVmPZtrtgraRzSj/rE2FfiWRHcadEssFrAb/3bhhRP7XqW
         vfhfHdF+/nwMftSFUZi6gXWYq7c2RVewpXj3Kz0qJ9ldzOn4ZYBFcuqNb6/VzfOUb0KT
         j9Zt8cCeqhJGWwuSuOOKLJ+2Xk1VLrPuLYu9+aPDonOJsoNMFOfvC/U7nChX1/LzXvMD
         b6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588863; x=1741193663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuMNXFiz3GQQsxpeqmzCHgRVoLvWr6tPdor7ZIiVrdE=;
        b=YW7QADMMzmbmeQgDt9ovt7xK2bcvadcLd55IcfdGtMbeHiWZSM/s/+IUy7b7T4SKxs
         82uYhPT7BHbLLceKk9hKIkzlsbEgfEzt6J7WAUTyOWlQwazNLIXIwBSM8WgaPh6wuA4w
         65mbPpi6m354Wt00lCRpJ44jWk5InRp9az0Aej56NFDz5y6SNrkTIdRJiRCcYyb3tBD1
         dYFygQ8Xig81qnPFilJGJaX+06qKTGPPYRAzQouh98vHbIHtHfgsBHC7iu5wYFAGk2q8
         4Gp/U+PRvosUdfwLnUNB9wv8LScUeW9Pcem70wZL1FsuIRwe6T5hSy9eyzfn1f7AyEux
         VQZA==
X-Forwarded-Encrypted: i=1; AJvYcCVFP+5yug9VDTzFbrZCzG8MhCxbnqsnzod+Ce99Q6TeDWjlyb9fJU1Hzrlx4ba5/b9b57ITPdxNHjYTWI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/+xrz17YdcKiRf9Y9lr6ZMQR1rsE3vdaCYK0d+s3C4LHIPLG
	PqH+Ok03fXHE6/sq2C2w2BXCWHHXz09uEa98IqisYaJqgqHWGika
X-Gm-Gg: ASbGncsx/xaNc81Q/z95z8n+5I3NnFDJuNNZt9wbj3t+muDYJJoVCxfcXyHA9fCnY6s
	n2NePtpOYagJPjyuf5jAWxhGyF2opJ4BfZtM13afj9U5HHFFYP3zzAJHT/KsubQ7Ec9W6837fyR
	y3hvUYsrvSieRuZ5mBxTjAWf0vQRyMvf0UxUS/cCCZ2/bCmECwafDR9G2+cwfwVi7a+UhplsJuP
	yERET1pedfpeTEfs35hMZw0QUKnyG2Bj84Gqm8sh8LQOjwh+Z7Qm37JtXjdYPjdDekin3qBaKSF
	8BQmQ+q/OSptSob3DAT0pMyoJn5ypUZLP/duSBfSXHkB4X/IegjtR5ZPLG2C5tUH
X-Google-Smtp-Source: AGHT+IGzw1JxAgCRr2hkHehSx21ZaK94xm+T4qbqC1Q9fKPlmg9xMtjNJBFuBwKL4xp8lj7A86l4rQ==
X-Received: by 2002:a05:600c:1ca7:b0:439:9898:f18c with SMTP id 5b1f17b1804b1-43ab0f72a40mr64043405e9.26.1740588862923;
        Wed, 26 Feb 2025 08:54:22 -0800 (PST)
Received: from playground.localdomain ([188.25.208.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba587163sm27672515e9.36.2025.02.26.08.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:54:22 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: bus: add documentation for the IMX AIPSTZ bridge
Date: Wed, 26 Feb 2025 11:53:10 -0500
Message-Id: <20250226165314.34205-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
References: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add documentation for IMX AIPSTZ bridge.

Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/bus/fsl,imx8mp-aipstz.yaml       | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml

diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
new file mode 100644
index 000000000000..dfcfe4a8ae74
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/fsl,imx8mp-aipstz.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Secure AHB to IP Slave bus (AIPSTZ) bridge
+
+description:
+  The secure AIPS bridge (AIPSTZ) acts as a bridge for AHB masters
+  issuing transactions to IP Slave peripherals. Additionally, this module
+  offers access control configurations meant to restrict which peripherals
+  a master can access.
+
+maintainers:
+  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8mp-aipstz
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#address-cells":
+    enum: [1, 2]
+
+  "#size-cells":
+    enum: [1, 2]
+
+  "#access-controller-cells":
+    const: 0
+
+  ranges: true
+
+# borrowed from simple-bus.yaml, no additional requirements for children
+patternProperties:
+  "@(0|[1-9a-f][0-9a-f]*)$":
+    type: object
+    additionalProperties: true
+    properties:
+      reg:
+        items:
+          minItems: 2
+          maxItems: 4
+        minItems: 1
+        maxItems: 1024
+      ranges:
+        oneOf:
+          - items:
+              minItems: 3
+              maxItems: 7
+            minItems: 1
+            maxItems: 1024
+          - $ref: /schemas/types.yaml#/definitions/flag
+    anyOf:
+      - required:
+          - reg
+      - required:
+          - ranges
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - "#address-cells"
+  - "#size-cells"
+  - "#access-controller-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    bus@30df0000 {
+      compatible = "fsl,imx8mp-aipstz";
+      reg = <0x30df0000 0x10000>;
+      power-domains = <&pgc_audio>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      #access-controller-cells = <0>;
+      ranges;
+    };
-- 
2.34.1


