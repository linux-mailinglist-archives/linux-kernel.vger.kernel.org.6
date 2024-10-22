Return-Path: <linux-kernel+bounces-375626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060709A985C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1761B1C22DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4509126BE0;
	Tue, 22 Oct 2024 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZZt2I4q"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE95137905;
	Tue, 22 Oct 2024 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574971; cv=none; b=FKJWFFwK9898LjqVE55cXKCvUKL32vmHCaJ5UnCwBBDC18DLY7y/TW6mS5HP02CiFC1gFyE8JFqZG06cimIoaFQEu+PjX3+bcp5brflVccaeSJJWJFoyNadIrCk8IO6lpPhoyufNF9zZIH5lGTZ2HosFMLQDaObI9MzeOawE33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574971; c=relaxed/simple;
	bh=2snPqlWjIc4JweFOHGTrcGGcoMxsa52Lwe6qkOTEEQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IuSjXmHwyEOyAILTIBwrvSd6NHtmWm3kL1LRx1MRcOPHH3Q5IsHTOLZWxRwHgToxVnQ8j8megT1RTt6AWt/E1aVrekeAqRKDSID0EcoOuEN5r/bvTUR0IRMc9nwAWX3TVnbRjz5+AKORAB+sCGf9Zriilg8MyteaT8FGQ5UGPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZZt2I4q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e7086c231so3944025b3a.0;
        Mon, 21 Oct 2024 22:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729574969; x=1730179769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=167i3gL3f9FJHwvcoDI4s7hogxThkzsLXjS2RB6NVLc=;
        b=GZZt2I4qEr/ENLTkXSqzevLGqNM8z2YqPp7gu/PzSsXn+dZilVMEyhmERe4wM/nSeA
         cjmOF2KiQaZKqakWGBAuNv5PYw47EWZe10MZfthl+CC2t9jOiuZvhV/9bN9Y+TC+7pg0
         evalmFdoOIa6kcaiOvLJMVrOoWlysIbr9s+0AWF74qKppIzbweQpE4bLsdlQKSda5Upu
         dyZugdRGQGhHGQ9WkF+zN0gGcs+RQ/DvzhKLOLVePBvfpwDRqeOmOrLCvqQw14DyjXOu
         7nKtnMGgg4gBriyheh/POED6Ez9OzboLThxyGHHI0wF9K1wSDVYCRU23o0vDpcrx/gUe
         aX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729574969; x=1730179769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=167i3gL3f9FJHwvcoDI4s7hogxThkzsLXjS2RB6NVLc=;
        b=njSW0Pxz5YWr5N0J2xcruCGgb/xak978k0udncOcvm6Ozd6kLuHXkly77s80b+oA7l
         Vv7RaB3mJVZchgpCsc9tT/gXudR1EbvaMlYZPhlfVi/t4WBO8sVSa3vAtcDgAG6FVO1z
         SAaBhk7avSPvDq7hISHTzgs6fZKyxpgTUq73n87WisK7m6GR9Le5WWQglqcQSGnGyjZr
         cv5F+qEDRyujSKTcTLNdYBLlQqV5xKQoF77Qs00koSMQV94WN9EI4cuJqk/E3kF48JLM
         MytSYwWL8XYy6BS0OKT7VNLQLwnWRNRo6Qo068h+LyivWg+vtikX71tMyDeOMnaD52CL
         H1iA==
X-Forwarded-Encrypted: i=1; AJvYcCVBR1cdFT3Cm+IZHlQ+IUY1h84F7gOHFhSFGEu/XEwTwBC/DHLI7E44jKXD0AmwhukK4PLC7rOXjA6W@vger.kernel.org, AJvYcCWe+NEtwq30sP6Hgwqudlno/Bu2FahTNHBNnV9XMLXqP36vNenP6ptWcv+4+xTxtYt+cjYv584uFJHL@vger.kernel.org, AJvYcCWpozsR/oLRI3EBPs0ZsaUsOgurvJhLDaPeemExGSlUh1GLZdXXaCvQ0a5RfzvAG78kPdDZ9Po/rgGfAQ7R@vger.kernel.org
X-Gm-Message-State: AOJu0YxNW2j5M6mEVAn83scrip/QaJLO9dfBm4ToB6QS2gi6TKLqrKG1
	KGGiGb1Cqf6mEdA1fiQtPMcCIWFmWtHZ+2PKipxXGLoaxiFQjwDB
X-Google-Smtp-Source: AGHT+IF3sO4XRfDwYLFySORRia6UR/7WN7FmmQLcNkR/mgPiyBoVArailRvzQoy4IWgGcqg0jyxoFQ==
X-Received: by 2002:a05:6a00:3917:b0:71e:7ab6:8ea6 with SMTP id d2e1a72fcca58-71ea3354b33mr18248374b3a.25.1729574968932;
        Mon, 21 Oct 2024 22:29:28 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec141505bsm3845846b3a.219.2024.10.21.22.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 22:29:28 -0700 (PDT)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com,
	kcfeng0@nuvoton.com,
	DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com,
	Rob Herring <robh@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
Date: Tue, 22 Oct 2024 13:29:04 +0800
Message-Id: <20241022052905.4062682-2-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022052905.4062682-1-kcfeng0@nuvoton.com>
References: <20241022052905.4062682-1-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ban Feng <kcfeng0@nuvoton.com>

Add bindings for the Nuvoton NCT7363Y Fan Controller

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 .../bindings/hwmon/nuvoton,nct7363.yaml       | 66 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
new file mode 100644
index 000000000000..c1e5dedc2f6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NCT7363Y Hardware Monitoring IC
+
+maintainers:
+  - Ban Feng <kcfeng0@nuvoton.com>
+
+description: |
+  The NCT7363Y is a fan controller which provides up to 16 independent
+  FAN input monitors, and up to 16 independent PWM outputs with SMBus interface.
+
+  Datasheets: Available from Nuvoton upon request
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct7363
+      - nuvoton,nct7362
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+patternProperties:
+  "^fan-[0-9]+$":
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+    required:
+      - pwms
+      - tach-ch
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon: hwmon@22 {
+            compatible = "nuvoton,nct7363";
+            reg = <0x22>;
+            #pwm-cells = <2>;
+
+            fan-0 {
+                pwms = <&hwmon 0 50000>;
+                tach-ch = /bits/ 8 <0x00>;
+            };
+            fan-1 {
+                pwms = <&hwmon 1 50000>;
+                tach-ch = /bits/ 8 <0x01>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7fb3..86a65a7d9721 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15882,6 +15882,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
 F:	drivers/hwmon/nct6775-i2c.c
 
+NCT7363 HARDWARE MONITOR DRIVER
+M:	Ban Feng <kcfeng0@nuvoton.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
+
 NETCONSOLE
 M:	Breno Leitao <leitao@debian.org>
 S:	Maintained
-- 
2.34.1


