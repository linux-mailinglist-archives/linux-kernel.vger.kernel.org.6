Return-Path: <linux-kernel+bounces-374703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48B99A6ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9041C22770
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8321CCEF9;
	Mon, 21 Oct 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgKD7dWE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9571CCECB;
	Mon, 21 Oct 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525985; cv=none; b=Ps8yR9HpHCwxbPzALYxbeOKM42u0JDxey2PlBEN096A2a9xWLC5hJk8HXOHgxe/inPB8RC3nPVZSBOZhP0p+HMaHLlcBuEGsiLIyoAeE/4Q8Zy5TaGiqEKvRRDi5heBNUASk1EndC10mApKIBgAEyRdebcelYPBWA8MCP8Wqb9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525985; c=relaxed/simple;
	bh=8DwlMG0kaTgTPAzPaMnX+0muBG330uuBVIxDFS2ZISA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVaQrFdPG5BhTXYTzfMnyzIUXDWgKfm1X4GhK3itYe3NzFT3lQNz7JwfxlZldTFkPQL4ww04hrjXHzHKNAqrwiW9g2Y/tMCuNO0vTYorpPGBqYfFtRsLZ7Lu1TZmNlle4fADi3jJpC5FWWxmd8Pb3m/0vsapZKfDXrPCNGtR6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgKD7dWE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539eb97f26aso5246033e87.2;
        Mon, 21 Oct 2024 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525981; x=1730130781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxDxKHmPqECT4R1a7bYe2JPLBE82BXjHNnePjstN3G8=;
        b=CgKD7dWEQtT9yrE0azmwx9DWjAkqTAO7aMHCLfdrkMmCMlMGPpnrB3wF907ADqvAYl
         x+1tFushPugiKXF2Ics8DvZuyB4h/0psui4edEQL98es1Qq0tuF72Z+vw4LThlssvKVa
         U03QZrZTnnczCFbgcmHaAZnr/d2R8LAM329NvYfSBC/bC0yDR4gjiM+/Yh/w8GyeBK9O
         sLe7O2hmNzftIictn+OdcSccohmR8il2aWH+Spfjj9FLYaUryTe2VRx6IFgBKkccUeij
         BJMCAtglHnlHZ7xfCqYRWqSrbzVwxq+y30ES0CcRZ5WQbOBocBg9UuWN8Ped6c2XbKjm
         YTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525981; x=1730130781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxDxKHmPqECT4R1a7bYe2JPLBE82BXjHNnePjstN3G8=;
        b=h6IcVpeuqWNt9k6Y+Zh7uUoLE1b7J7XqOxFgxBEKGs62EQaiMQc4K8tuin8QA0JGXn
         DImUUciMVZI8pvaVNWzSt3PCLD3yqM3lMFmDBzInFPXzwd92bxt0Q3DHXLHQTEBE106B
         la52Nk0nJmmItvSRtS/9HTqMc9vD+t82H7abol+M2YQECWUQf4d8gt6NbrRxT59kGVZo
         MuBDC/QtQ66n/GkTQDjkDjzq1kcx7zS//3IxeMGrEJAp5XQ+kVpDx69seDck7fxXw/lW
         s5ibNLsbmhwrgHSmHXAkwU0Xy83n8KXEF6OVmjJ6QCsxK2L67g77HTg8c0sSRXxHAWms
         zc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3m0Xe+tcKeX6/VaP/qZgE1HXSQE24/9D+ZZSlkqwniUhiMkDqIrZU38p0/ocl7+LqUAGtGETrKP1tp6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3to4zSfSU+Fsz53gWniUjEgPMxWHiVb0cJpV/VwDxH+JRt7wV
	GbeVf2yYnIljBjUs2GNUTa3tdH6luMnG7Qxr9WMNYHjncvICmjm/
X-Google-Smtp-Source: AGHT+IEOvF+I3X7eV/ZzXFntHrBLK7yKO+DyOsij8aWog9rupEjDGCjyG3yo/YkcA/eyGDm3liIWaw==
X-Received: by 2002:a05:6512:318c:b0:539:9490:7257 with SMTP id 2adb3069b0e04-53b12c04223mr241778e87.30.1729525980930;
        Mon, 21 Oct 2024 08:53:00 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfd0sm218614366b.67.2024.10.21.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:53:00 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/6] dt-bindings: dsp: fsl,dsp: fix power domain count
Date: Mon, 21 Oct 2024 11:52:16 -0400
Message-Id: <20241021155221.112073-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
References: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Per the current binding, QM/QXP DSPs are supposed to have 4
power domains, while the rest just 1. For QM/QXP, the 4 power
domains are: DSP, DSP_RAM, MU13A, MU13B.

First off, drop MU13A from the count as its already attached
to lsio_mu13. This decreases the count to 3.

Secondly, drop DSP and DSP_RAM from the count for QXP. These
are already attached to the DSP's LPCGs.

Thirdly, a new power domain is required for DSP-SCU communication
(MU2A). With this in mind, the number of required power domains
for QXP is 2 (MU2A, MU13B), while for QM it's 4 (MU13B, DSP,
DSP_RAM, MU2A).

Update the fsl,dsp binding to reflect all of this information.
Since the arm,mhuv2 binding has an example node using the
fsl,imx8qxp-dsp compatible, remove two of the extra PDs to
align with the required power domain count.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 31 +++++++++++++++----
 .../bindings/mailbox/arm,mhuv2.yaml           |  2 +-
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index 9af40da5688e..ab93ffd3d2e5 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -99,14 +99,35 @@ allOf:
           contains:
             enum:
               - fsl,imx8qxp-dsp
-              - fsl,imx8qm-dsp
               - fsl,imx8qxp-hifi4
+    then:
+      properties:
+        power-domains:
+          minItems: 2
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-dsp
               - fsl,imx8qm-hifi4
     then:
       properties:
         power-domains:
           minItems: 4
-    else:
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
@@ -157,10 +178,8 @@ examples:
                  <&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
                  <&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
         clock-names = "ipg", "ocram", "core";
-        power-domains = <&pd IMX_SC_R_MU_13A>,
-                        <&pd IMX_SC_R_MU_13B>,
-                        <&pd IMX_SC_R_DSP>,
-                        <&pd IMX_SC_R_DSP_RAM>;
+        power-domains = <&pd IMX_SC_R_MU_13B>,
+                        <&pd IMX_SC_R_MU_2A>;
         mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
         mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
         memory-region = <&dsp_reserved>;
diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
index a4f1fe63659a..02f06314d85f 100644
--- a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
@@ -197,7 +197,7 @@ examples:
             reg = <0 0x596e8000 0 0x88000>;
             clocks = <&adma_lpcg 0>, <&adma_lpcg 1>, <&adma_lpcg 2>;
             clock-names = "ipg", "ocram", "core";
-            power-domains = <&pd 0>, <&pd 1>, <&pd 2>, <&pd 3>;
+            power-domains = <&pd 0>, <&pd 1>;
             mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
             mboxes = <&mhu_tx 2 0>, //data-transfer protocol with 5 windows, mhu-tx
                      <&mhu_tx 3 0>, //data-transfer protocol with 7 windows, mhu-tx
-- 
2.34.1


