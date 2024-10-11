Return-Path: <linux-kernel+bounces-361354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C13099A724
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA3EB222BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C2B194A60;
	Fri, 11 Oct 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQZbK0yl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108F187FE4;
	Fri, 11 Oct 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659152; cv=none; b=R2COjx7jVJRhI7T91r51WtcHaiDP1ydJG/7fGo1LJWsiRUGQkG02Eq3NimEovX5cwR4W+0LHGmiwRVvmz2aMnEjXmQ4CG8ECgOqaGC9dX9ymmZXEjPdhtAsTKKdvT1PodsYobtB/uLoBvMbsM/uDIKFMhRGtmCDfZ1FsdSicV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659152; c=relaxed/simple;
	bh=P+yE5KdCcIMm14HPs4c/lUI3dwW9bilamH4sLkmXczw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhJB8qAuhI2ZGC26usDZ2Q/ISINWgRbllPHOaQ66tFw77dqq79FT8hP8FWhczQSNshV3geeH3iYs42V3NY/5/c5biEEreO3VYZw2zVk00WiSfmdsdDwDl8rwy4ZUGbJhAixh/OMy9DK6lsH5kSRbnzVDNRO5ijTl+7jKgJzPOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQZbK0yl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53997328633so3673740e87.3;
        Fri, 11 Oct 2024 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728659149; x=1729263949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6d2HEGva1FumwMFJbWr9u9NWQ5NOhQR6SBLNsRd724=;
        b=ZQZbK0ylAxUw9ylT2zsT98RXKKWi5o+d6Lae/mvonD2qROURQpH+Codft7Qy7v67cz
         U0nrml4epESwO7ACw3RMyvqujg8rskt2Ez8XCFCo7EhanEDCZo3JJMzs7av4eunFelw2
         V5CtDZky9s9neyjO5CaAbvQpo1lIon7g9XseqQT4kuy+9kV5PMw8JOfP/+STPdjngNPi
         6AXJMl8Ahur0QJ7vXq1wSkfYWW02HKaF01OcuNwPqssKit9FbCs6LSnCUzJDPLzdBHOK
         hIkQmofTJP+Uw7+0kKcdXvHRhnWoXJyuHF3L5XEx73IDBKkuAopCg3QDpA4nbiuZdnd4
         YieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659149; x=1729263949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6d2HEGva1FumwMFJbWr9u9NWQ5NOhQR6SBLNsRd724=;
        b=igZXQ4HBtzGVrmrv3ehFb0LxwahInECRcnek20BbC50mvA9xHQVfMQKIvsmOK1Wkly
         jKO+XzMXboe/EPMauhzg4d6v4N5rYMsuM58j5V0KISUiwVh+Fdjdq1YeuOXgR84qvviR
         I4tMKCETGgVky64McJBXy9VdgdoWtAUieozgi1VKm8iNvFmVlHVoaaQ2lYsU+CvBR6kn
         rinLowPzW5MIYtEPZ9T0pa9E1dZdKl2WOyvpU3Fi3wXZIu/VZijcqOB2VnZZJ/NruRba
         1Vodt4EnhD5wZ33lS8nEFkC48fp3Z0ThwXbiVcAQPjB+P4ZDmYu8/mJtPuapl8Z7cl60
         HppA==
X-Forwarded-Encrypted: i=1; AJvYcCVkH9z2OTOlzmXy++4rxYtW9R8l/yNV0VI/nVnZBpeL+tvwmn0ZxHrtVaTElXWJxdRJ8Qwp1IfVmpzrZQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OZp4jHQrnC3vCla/3WzQLMjY28Pun4Vls0zlmnoDxjE7Azij
	9W+oI9mXEiYzGPVCDbt0LEizhYBMdlVVkz84f8tSZaecHvGCC9Jt
X-Google-Smtp-Source: AGHT+IGwGf+d6KP0pDSl5JptpFK3ku9j3zBqS2D7qrlBlzrhKGLUNO+lTF/x4nO5NF3hbj3e4pBmwQ==
X-Received: by 2002:a05:6512:b17:b0:539:8fbd:5218 with SMTP id 2adb3069b0e04-539da5938a6mr2681944e87.56.1728659148651;
        Fri, 11 Oct 2024 08:05:48 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5b0b5sm220879366b.94.2024.10.11.08.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:05:47 -0700 (PDT)
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
Subject: [PATCH v3 1/6] dt-bindings: dsp: fsl,dsp: fix power domain count
Date: Fri, 11 Oct 2024 11:04:34 -0400
Message-Id: <20241011150439.4027-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
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


