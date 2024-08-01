Return-Path: <linux-kernel+bounces-271570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEECE94502E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64241F21F64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4BB1B372C;
	Thu,  1 Aug 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQSSnFX8"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2413D2B7;
	Thu,  1 Aug 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528614; cv=none; b=AS/nOEszG7coGcCRJqIJYS8Syc5U27gI2ij9VhbR650aG/ACgemeZ1NGwh2zbYsg4liDbmDXivsHJj8lf93oHc6+OayxyKM6mkpPTZPAe0dtqXc7ZQ2eQfcN9yRabwlL+l6DzZD0uYQqXdzsfAjTZSxvduFM7XAPVf+Kwa5eZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528614; c=relaxed/simple;
	bh=4pChm78yzUZYkBODR25icmBnQyjSdqC0ovXtf4wASkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egBJu+a99JdwcJ48VLzb2kpxbImmAJlZN14WWYlMcg3Cra6nQl+pcdLi5r+nY3LpK1e8tl6pS24vLJhMPYT3z/ppzahkexujR42Bn4TjKuZWACsJWf7mLt3KrIhN2fkHKOypX7Vl35BjylUbCeyCf4R28ZI76LHsuCJiINlzdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQSSnFX8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so89916691fa.1;
        Thu, 01 Aug 2024 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528610; x=1723133410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSqxnB1qj3oa3BzlEabSl4i4FnXyObTkkpAcKedzajw=;
        b=JQSSnFX8tkEklThQD+jbJtEG0CRXEa8S7s6uY+FW90VSFfpsyEOLDSHpH+vUa8DoO9
         cGoGLRSN3adQWXXRr/m9ng9xnXVxcAmO8YyeWl3Lqz6NCUb6zuHdX4MYkO/HjuqsUE34
         svRpJAgf8Bju2qcLZaG8Cn7fN2Ip72k2i9QGyEF8domYijxhSNlcK7FxNbTnQOjj0k6B
         CciS47HXsAvJSUuryyT7g53a1SqjhfMDOGbuWu4zwqHZp/zadz+HiDPfJTvwh2sO5Prv
         GUQvCY3grniJpigYgI4Kdnzsi1c+93oCy/neouDWNyfoffxO5UHOC8kdvZMvd/azGClU
         k86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528610; x=1723133410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSqxnB1qj3oa3BzlEabSl4i4FnXyObTkkpAcKedzajw=;
        b=pWMuvID5o4PMeIVttZ2912dQLJ1hs6qCLGVnz5/8ENnhysvCD21dwOZzS7UGfVu9HC
         WP1PaDlPXPdMe/1CiLZ06AZ0zX6cKXoZyQUWz5eFkqyLMQkKiaSoErCVl2lOJfeD9WRF
         mjVmh1gvatiM1KOblaX5KvGOMxHvgbz39653of37Mau88VjLHtLDhjhMubmGAiuWJo8c
         KhUHLnYPzCHwGOlk1gNkzNROmSstW4rvSWC1PZgh/G3B+nb2IAR2aZzniGdetOI0Xe5f
         vDiIyclza6Y7ZfNBFEUXcxMkqF2IpY5eTSEZHsfifeugaL949/Lsu5ypK/ZMNgXU5R5k
         x3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5YFBYrG2LHRfzMkkhlagadnUB4L0dsLhW5/vs/d+7TY4XlFm3uKyZfKpCo5gAsceK7wMoiKtIyp+lk8scmK8HdY+WMiOcjerH1Is952Rcli5mQomst029gc5Tn2JMqG/mjzGPpw0iog==
X-Gm-Message-State: AOJu0YzvMUuKy6/GX8BTMGo69I3rTJNFdoZlZ5QECZJG+2XZ+zTuy/uw
	6Vz84r8LZqmtcnX2tSg8tlvQDW573LU15NWnsSrrqJVCk3skirFP+izDsDkr
X-Google-Smtp-Source: AGHT+IEbew2cwVmwwv6Avkf3QcG+viNoQjIS6yMKDzwv225YfGUt3hJqGwAJeQOTpTAhbjViqmLdMQ==
X-Received: by 2002:a2e:b048:0:b0:2ef:2b38:8796 with SMTP id 38308e7fff4ca-2f15ab03fcbmr6220731fa.32.1722528609821;
        Thu, 01 Aug 2024 09:10:09 -0700 (PDT)
Received: from alessandro-pc.station (net-37-119-36-202.cust.vodafonedsl.it. [37.119.36.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e7d615sm1802005e9.29.2024.08.01.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:10:09 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	skhan@linuxfoundation.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: edac: Add Altera SOCFPGA SDRAM EDAC binding
Date: Thu,  1 Aug 2024 18:10:02 +0200
Message-ID: <20240801161005.120111-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the device tree bindings for the Altera PCIe MSI controller

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v3: moved yaml file from arm/altera to the edac folder, removed items keys, added general node names

 .../arm/altera/socfpga-sdram-edac.txt         | 15 -------
 .../bindings/edac/altr,sdram-edac.yaml        | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
 create mode 100644 Documentation/devicetree/bindings/edac/altr,sdram-edac.yaml

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
deleted file mode 100644
index f5ad0ff69fae..000000000000
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
-The EDAC accesses a range of registers in the SDRAM controller.
-
-Required properties:
-- compatible : should contain "altr,sdram-edac" or "altr,sdram-edac-a10"
-- altr,sdr-syscon : phandle of the sdr module
-- interrupts : Should contain the SDRAM ECC IRQ in the
-	appropriate format for the IRQ controller.
-
-Example:
-	sdramedac {
-		compatible = "altr,sdram-edac";
-		altr,sdr-syscon = <&sdr>;
-		interrupts = <0 39 4>;
-	};
diff --git a/Documentation/devicetree/bindings/edac/altr,sdram-edac.yaml b/Documentation/devicetree/bindings/edac/altr,sdram-edac.yaml
new file mode 100644
index 000000000000..31bcee4274fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/altr,sdram-edac.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/altr,sdram-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+description:
+  The EDAC accesses a range of registers in the SDRAM controller.
+
+properties:
+  compatible:
+    enum:
+      - altr,sdram-edac
+      - altr,sdram-edac-a10
+
+  altr,sdr-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: 
+      Phandle of the sdr module
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - altr,sdr-syscon
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller {
+      compatible = "altr,sdram-edac";
+      altr,sdr-syscon = <&sdr>;
+      interrupts = <0 39 4>;
+    };
+
+...
-- 
2.43.0


