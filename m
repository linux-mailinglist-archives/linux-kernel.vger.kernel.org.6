Return-Path: <linux-kernel+bounces-180000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37A48C68B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE61B23EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CDA13FD9D;
	Wed, 15 May 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2t1Fa+M"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A613FD91;
	Wed, 15 May 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783372; cv=none; b=E8VL1C001CH5VPp9zafX6L43ZedBxChyPdVU8n9IL8e+pNHlBeKt6aOfcbsXLJHHom58LgWQl/7TEKFVrflAM8BZk/ZTK77jwZfPID07RM9sa8YZ/qfqCgUOFq2HyXW8UP/8ObzVuo4RmnW8zBbrlWbkDB0KXv7Q3YN+d2oYZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783372; c=relaxed/simple;
	bh=TRVnJRHosck1j/4uWB7HnrKYDtyXW31g0p/z87IkX4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jcW+/iWths4T8a4feVIv8pKIJKOKWERGvT+Uvg2KREvG9gWKaYDRLW799aAspr71CsZKYyBlfT5vJipHEoA3fJLu+A/XqwayhuSWKRUij9DafoESow278CvBOpH2+sKEf1c9JHGQxas75RUyZPG/H8jUD+BlhGe9qFxMWcG57lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2t1Fa+M; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so104361041fa.3;
        Wed, 15 May 2024 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715783369; x=1716388169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r84fA7yzIYREcIBzE0fr8sOvYOU8oStQlBXw3lbHnrw=;
        b=b2t1Fa+MjDlBgCF9bKPZQ1e6lOn2RhlrPxsz7qzAP1ZLr6+zMbdI8fsWV2Rr7EVGbH
         6YodNjjlfl+nfnVoChfxopvbvKiy/iMaY8deLxAdlNDg+BfKNO4IrVYc82y5Be9qga4B
         WpDMqHWIbwtutpYqG6NS3AEn21k7bEMmvVDfyWat5LNhmIM/Ioqb+67aBH5MbSRmE2o2
         A+z0HBPiGbr6O64D5th6f0lTI9CFUxH8HSDQo2qR8SJDH4fFITnSq+bay6LkuZOUqnyk
         T3PLpav8V5bTBH3GPAk3I5riKN3khKN1727dWqVG6uRxG+sRV8bzrjptkbbA3Cnmms+W
         D1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715783369; x=1716388169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r84fA7yzIYREcIBzE0fr8sOvYOU8oStQlBXw3lbHnrw=;
        b=DGGsIR2K0kjrA19TQIr1m6gyPDL6BWBjnZiTkuCkgcJkiEALdWuo1cf3pNdGXVlik9
         eb1TBvN26TvqO8i/qGvUrkF+leEK6ONeJfVaUCODrpbARiduCNZYxllfcMT1ikkBB3mJ
         dieeM5aCeVNKH2MV8p/CNIwvDKI9NrZ2qDpYNl8DM65DW7Bi1OUHMgBuDsEpa8E7mVg9
         1MIuJK19ACtoIlq22q4qOzHLKKMCSmKWCUstWbg/BSOdT28eefBv8oZKnMOaRojOfVIo
         OlRU/kSme3CtHjVfMOBaORvqgz8u3rQ7sm22G4ou/rU3NowCoiEmOxGsueST3LQtZalW
         LRkA==
X-Forwarded-Encrypted: i=1; AJvYcCWEgRqMV6qjbb9UF/hie5QvdzslwG5KsxK91N4St0krBmIX7tU8f8mXuOUW7GUPOzTnv5wSEuBv2P0Nt2x46d+wI5Puej9ePtTDKkkaV1HNDYLqaRpQxq6GDAzKXO5DYZFn+/h9+chf2g==
X-Gm-Message-State: AOJu0Yyb7djAWPysnXnV8CmdMPPDnKUA/wR1xVk9LXCNSL6X42fCQI1m
	aEV9qweUH3EoQRqgSy3w9sZF3/C3KMFke6u5N1i5F7aYjpVlT3zK
X-Google-Smtp-Source: AGHT+IESLHg+n32H9cZa3MfpHKGKrD3xpNpQtTGGkrPB74A1r8sdzU/4Ati2GqBfcv6Ivyi/5EpHnA==
X-Received: by 2002:a2e:3304:0:b0:2e6:e46c:a24e with SMTP id 38308e7fff4ca-2e6e46ca2a9mr42067821fa.52.1715783368562;
        Wed, 15 May 2024 07:29:28 -0700 (PDT)
Received: from pratik-IdeaPad.lan (customer-145-40-29-195.stosn.net. [145.40.29.195])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2e5cf80dd3fsm13203041fa.74.2024.05.15.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 07:29:28 -0700 (PDT)
From: Pratik Farkase <pratikfarkase94@gmail.com>
X-Google-Original-From: Pratik Farkase <pratik.farkase@wsisweden.com>
To: 
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pratik Farkase <pratikfarkase94@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: nvmem: brcm,ocotp: convert to dtschema
Date: Wed, 15 May 2024 16:29:25 +0200
Message-Id: <20240515142926.68153-1-pratik.farkase@wsisweden.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Broadcom OTP memory controller to newer DT schema.
Created DT schema based on the .txt file which had
`compatible`, `reg` `brcm,ocotp-size` as the
required properties.

Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>
---
 .../devicetree/bindings/nvmem/brcm,ocotp.txt  | 17 --------
 .../devicetree/bindings/nvmem/brcm,ocotp.yaml | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
deleted file mode 100644
index 0415265c215a..000000000000
--- a/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Broadcom OTP memory controller
-
-Required Properties:
-- compatible: "brcm,ocotp" for the first generation Broadcom OTPC which is used
-  in Cygnus and supports 32 bit read/write. Use "brcm,ocotp-v2" for the second
-  generation Broadcom OTPC which is used in SoC's such as Stingray and supports
-  64-bit read/write.
-- reg: Base address of the OTP controller.
-- brcm,ocotp-size: Amount of memory available, in 32 bit words
-
-Example:
-
-otp: otp@301c800 {
-	compatible = "brcm,ocotp";
-	reg = <0x0301c800 0x2c>;
-	brcm,ocotp-size = <2048>;
-};
diff --git a/Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml
new file mode 100644
index 000000000000..58091e69594e
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/brcm,ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom OTP memory controller
+
+maintainers:
+  - Pratik Farkase <pratikfarkase94@gmail.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - brcm,ocotp
+      - brcm,ocotp-v2
+
+  reg:
+    maxItems: 1
+
+  brcm,ocotp-size:
+    description: Amount of memory available, in 32 bit words
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - brcm,ocotp-size
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    otp@301c800 {
+        compatible = "brcm,ocotp";
+        reg = <0x0301c800 0x2c>;
+        brcm,ocotp-size = <2048>;
+    };
-- 
2.34.1


