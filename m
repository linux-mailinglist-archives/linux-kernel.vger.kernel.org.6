Return-Path: <linux-kernel+bounces-526504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB6FA3FF9D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E236719E06ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37764253349;
	Fri, 21 Feb 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXpevhr5"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBABF25291E;
	Fri, 21 Feb 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165593; cv=none; b=CVd0LpkczgSgmc4w4czJGpJOpndMe0wMLUqQd2y25z+HXd/S+yujabaI8LMG3yhGKZehbgFu6t1PQarfwl7cxRBRNsgHkQMpxJiIp/FBc2/LUvtfpE2+9vFMKTIDZU8KyVMFLRMmy2nC6A2ufrSoiY+yIsGECZ0IFMln6rrTLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165593; c=relaxed/simple;
	bh=WkHeujAkkg3Au2pRr/mtGebqPA86rCCDJZj5FRsTOrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XLOUvftSIS2LeoiTs9LuIne3YCsUbz8JaZGaQXntAPfx6HSV7Epr7qKVoDujJKNm5Kavv7zdmZgOQEXPd213fxEYWuYFsUlRCeXNGxvANeT0phrrYMasXhfogCkUdxAN26AJo+Au9/T/li3nFP/ITHVhVuvuuo0CJvxg7dyJloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXpevhr5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso393290566b.2;
        Fri, 21 Feb 2025 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165590; x=1740770390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4b85i48aqXbvqxKxPLY68Yu1QiHGt3S7QqZhpoTlOs=;
        b=ZXpevhr5H2VnIZcf6INRG7xfA8O8lbnUAUxotSMTN3uV2p5GaZSxtceaRGPFpeLTK/
         kG2pFvgD0CM1glRyN6456axcQ6RmoocvqUGQkkNx/Y5UkG3UNTdKcFzyBvvh3LXNs7S+
         vBFPqNFzI48Mn3i8bE/pNZSDTvKWTfScGYfA2nu1VKFzp0sbFp8TVicmyJ2q4TsIzQvp
         yvbg/sJU5oVfP4CXOAnJCLNkK1Q5VGczgYtpokH9Smn6u6R9OaC0qwOyiiBuBiAlyG85
         y4rJoQgKl62wyEYNLPPGLtAPp9lghrHxmthEhXBRGuv8Hk0jXrmdk/uXjt+qXpPIlZcR
         0MoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165590; x=1740770390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4b85i48aqXbvqxKxPLY68Yu1QiHGt3S7QqZhpoTlOs=;
        b=q4Ydx2eJc4JuQFbewmmqkmrnyZ0UhHTaPFCxmSdroYgylmFPlZL/ANAy+zGA+1q+N8
         6+r7/0THexMHfs3JHgDOd1bJZg7bG7VsnXl29z08irwXG2Rklj01t0YJvKOyjdxvpBkP
         yIMDKU43ek2TvID1SFAQyhmcqS+9tCix7tf1fXP+rgsBRHBaf/N+mqDyzLOKbttlKRqB
         Bj4b89wOzxZaB9kx8M4ThOfmB5YVoGxp4UOQ2H/hJdyQoMLytU2iZ9nYfpQOo2ipvhgf
         tHIBLt71Lp54bfo3shMD9T9UfgMR5vMcb3YF/04/fadrTD8qenHRVLT5pdvzUn+8xmMc
         x3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd3z4ANKyPK/e4wQq17OOfZs8nP2TZpfHV+n2T2LvRguTDaE4Bw7yaByJxhB6S8585u9HyMSHj3ZVD@vger.kernel.org, AJvYcCXLv4lBQW+j3GK/CLle5pLBnL2w6xEmmX0kPmsJ2Xxi/qox9GUz2x28qJMkEw+X7IcIWovmafFiLeeza+hW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa1HeJW4EaFIOSAlzG0QHdTArVYf8GI81jQA7Vt1cfjba7tIAU
	5hYy2ve85wWhA6IPeqKFLHrDInh1otP4lhk6yvXO03XW+Xru0SJD
X-Gm-Gg: ASbGncuhqlYRYcaLSXf69JTD2q/JloVZ7WHWzPKxg3eJtXpVuhsIzon1xuJCgjByz7O
	hNyJh6l9JoNgBqMr0M+6fMED2GOUGpWfnPVHj7a7BKWZFty5ecVbBmjdeE/XMpiC0EXSn6Nyk19
	kzJ8d89nZyOPTUPaH3IV1cIsW4q/5R6Zf/mThjfDFPOOMMfzQt532rRCXm90JMuP3fr0jE+ncwg
	xaHPT1QgEx9fdxOo+wz1MSduI0iJRFXsJnSUjaJ+Rt56/tzpY+v4PH6HR3hVEB5+WSnS/fVuEpV
	SYt51GjWJSalC2IZqEbGTZ0qif8nlSSzeS5mpiuOKqLTEoKRDsNPAIi1ejc=
X-Google-Smtp-Source: AGHT+IG6R3La5hbh10fjcxDEk/iLRZQGIPtHw2SJ1aLWwKOtPA+wUEWP+H+spREkJWuxHbG0Va+SVQ==
X-Received: by 2002:a17:907:96a0:b0:ab7:f0fb:3110 with SMTP id a640c23a62f3a-abc099b380emr486410266b.5.1740165589933;
        Fri, 21 Feb 2025 11:19:49 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9cee79fasm995276266b.129.2025.02.21.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:19:49 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: bus: add documentation for the IMX AIPSTZ bridge
Date: Fri, 21 Feb 2025 14:19:05 -0500
Message-Id: <20250221191909.31874-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
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
 .../bindings/bus/fsl,imx8mp-aipstz.yaml       | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml

diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
new file mode 100644
index 000000000000..b0d6eaf70a84
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
@@ -0,0 +1,62 @@
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
+select:
+  properties:
+    compatible:
+      contains:
+        const: fsl,imx8mp-aipstz
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8mp-aipstz
+      - const: simple-bus
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#access-controller-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - "#access-controller-cells"
+
+allOf:
+  - $ref: /schemas/simple-bus.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus@30df0000 {
+      compatible = "fsl,imx8mp-aipstz", "simple-bus";
+      reg = <0x30df0000 0x10000>;
+      power-domains = <&pgc_audio>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      #access-controller-cells = <0>;
+      ranges;
+    };
-- 
2.34.1


