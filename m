Return-Path: <linux-kernel+bounces-332870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CC297C00F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFCE1F22390
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2781CA69D;
	Wed, 18 Sep 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZzrxeKt"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF651C9EBA;
	Wed, 18 Sep 2024 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683737; cv=none; b=mMIvB6jZ2grTseFihSlpbt89Go871jHTm2tgcdp3tSR+3iM8bnX3FzsEounaj6EA7tLxebKGJmAhA5qVxN2fL9NRlbz7x8g6hpnHk8e0mdONg3mMH2jHZTqlEbpou5HYxPSQ5Jup3sxKkBxYjWe4LD2KIkMOJIjDYaoDYwTN6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683737; c=relaxed/simple;
	bh=UC56d/wDo4fWA78feoHg6QDV1PCP6dZckMEAl67t3qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=No4ksEhkBvHN3wrz1G2qEtfsJxCVhH2NKO2T+jkJCYfBPZ60baZdPS0cj4P4XwU6lJn/rq8l7TAYyiP6j1r/1aPYzer9zDUG4mEpNMCqEQ0i97QdUhiKFErHrGndNOGdEz2bMQWDNkglapbmb0ckK5Bs7KbUUG32kHU8uLVBDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZzrxeKt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5356ab89665so8258215e87.1;
        Wed, 18 Sep 2024 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726683734; x=1727288534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSJkyW7PtmsR3xBcC4s2dK8tXSEoVtyj6mYraRaugmc=;
        b=iZzrxeKt0KD6bFSDezetu65dGIvP6kcnMrhatSPCOe1u7r+mOzhsEvbrd+Bxo0WauP
         YTbJhT7ANzBmLsgsNW1UMizbkEnRHGqVb6aAVjBuSlZ3qSHIUUi1XJsHkhUjbVsqL51X
         OmSIfsWkMML/kRSrq3owAkewU4oU+9uda0Ote32RXRAtK3XM26xnWCSkEhMT1hDHr4rX
         ercjatbTBX8N+IUvzO4pjokfGXCwozzRbHhNcO+3xDsf2kEnI9qIb8u1hrq0kKL/6nwn
         PJskgUPZDOgA3uND3IJsj/5ouWLd5Kw/6GzakmeBTADnvpDVCMhKRKCZw5/mHqrpypqq
         oK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726683734; x=1727288534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSJkyW7PtmsR3xBcC4s2dK8tXSEoVtyj6mYraRaugmc=;
        b=n8vdAi+dVVKeRJcgxp/G1Kb/bhyIyM9SK1RGAUkONX28XMQel3bc+vJnz01GAFRMmW
         1MOpyRVbPDUM6DGhwDPum6eGUzBzp6HF5RnXCr3lJUx1jpPRSF5lUOGkw7KG5qs25aDt
         HOAMreda46u7ynKLyy6cUwT3mfuRxVRXvrHPRElQk04eYW824RtAdjyVMaTF4v6hB+Cn
         u7Wp9K5aJOC6DqgdxKKIwml2tKksys5A4Qfq1tSYm7+JQqnUS8xOEhkwIsyIu+PyFQhu
         LJZycBBqUZyFm0J1EUo3ocy5x2L8bjo9QlkMSGwzHXquooSrZsDSf8zRI4Gwa/WxLQOz
         N7gg==
X-Forwarded-Encrypted: i=1; AJvYcCWgisyPDoaTc64vAkwgMX813U/Y3DfiuBjVB6F4SJxZGRMrH+LQYbTxk0Rog2sULbnYEwcKRwDnNeLVM3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtsjCbEauV9yHnUvVwwLLztQVXIvtiNyVzYqXO0pX4rb2gKvL
	C5dPTbbovaRXvOQH/UtqbD7s1stZziieYH47O4Fjhsa2dIDXNDknWWYs4sYX
X-Google-Smtp-Source: AGHT+IFrDGvV5858WGdycyJ2YnkzCRsAgTv/brwvViai7wsUYS2uRl7bXI1hX02jiCpLYUubqCIlOg==
X-Received: by 2002:a05:6512:1052:b0:533:508f:edf1 with SMTP id 2adb3069b0e04-53678ff4e66mr11144621e87.60.1726683733341;
        Wed, 18 Sep 2024 11:22:13 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5312dsm5200146a12.23.2024.09.18.11.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 11:22:12 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: dsp: fix power domain count
Date: Wed, 18 Sep 2024 14:21:13 -0400
Message-Id: <20240918182117.86221-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Per the current binding, QM/QXP DSPs are supposed
to have 4 power domains, while the rest just 1.
For QM/QXP, the 4 power domains are: DSP, DSP_RAM,
MU13A, MU13B.

First off, drop MU13A from the count. This is attached
to the platform device of lsio_mu13. This decreases the
count to 3.

Secondly, drop DSP and DSP_RAM from the count for QXP.
These are attached to the platform devices of the lpcgs
(used as clock providers for the DSP).

With this in mind, the number of required power domains for
QXP is 1 (MU13B), while for QM it's 3 (MU13B, DSP, DSP_RAM).

Additionally, two extra power domains may be required in the
case of QM/QXP DSPs. These are IRQSTR_DSP and MU2A. For the nodes
using the "-hifi4" compatibles these PDs are optional, while for
nodes using the "-dsp" compatibles these are mandatory.

These changes reflect all of this information.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 62 +++++++++++++++----
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index 9af40da5688e..e2f016af1048 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -51,8 +51,6 @@ properties:
     description:
       List of phandle and PM domain specifier as documented in
       Documentation/devicetree/bindings/power/power_domain.txt
-    minItems: 1
-    maxItems: 4
 
   mboxes:
     description:
@@ -97,16 +95,55 @@ allOf:
       properties:
         compatible:
           contains:
-            enum:
-              - fsl,imx8qxp-dsp
-              - fsl,imx8qm-dsp
-              - fsl,imx8qxp-hifi4
-              - fsl,imx8qm-hifi4
+            const: fsl,imx8qxp-hifi4
     then:
       properties:
         power-domains:
-          minItems: 4
-    else:
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qxp-dsp
+    then:
+      properties:
+        power-domains:
+          minItems: 3
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qm-dsp
+    then:
+      properties:
+        power-domains:
+          minItems: 5
+          maxItems: 5
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qm-hifi4
+    then:
+      properties:
+        power-domains:
+          minItems: 3
+          maxItems: 5
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8mp-dsp
+              - fsl,imx8mp-hifi4
+              - fsl,imx8ulp-dsp
+              - fsl,imx8ulp-hifi4
+    then:
       properties:
         power-domains:
           maxItems: 1
@@ -157,10 +194,9 @@ examples:
                  <&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
                  <&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
         clock-names = "ipg", "ocram", "core";
-        power-domains = <&pd IMX_SC_R_MU_13A>,
-                        <&pd IMX_SC_R_MU_13B>,
-                        <&pd IMX_SC_R_DSP>,
-                        <&pd IMX_SC_R_DSP_RAM>;
+        power-domains = <&pd IMX_SC_R_MU_13B>,
+                        <&pd IMX_SC_R_IRQSTR_DSP>,
+                        <&pd IMX_SC_R_MU_2A>;
         mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
         mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
         memory-region = <&dsp_reserved>;
-- 
2.34.1


