Return-Path: <linux-kernel+bounces-365675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F499E5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9317B2148D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974991E7C33;
	Tue, 15 Oct 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="PaE3q25t"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF71D89F5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992025; cv=none; b=lguSwJozV9KRQ/rE5uZ5Y4Ln1iPcJEifEcYtkOh6DU+mRMmg6kIlKQ8Vic1hnRiQcc3ZojuETM/RSP1XVc3Z8T6zU2+3cuBhOl+ruo345k/bDpQvQdGg/842kwReMS/p4XNjr0dU47KDE/hvdUgtuudWUCgJzFBFv7IvHoXJKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992025; c=relaxed/simple;
	bh=EpSNCNH55EMHDXaxmMg5PL0Q29l93G+4owMmJTlOxC8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OS2zgDLk0cc5kuL0++Ljm+gv3WN6Oq+gzI+xb8BiM45moOUgDWjLwuqOd0M4O22JWeE+Jyc4igt9Z4dphLfVXpPy8Y48izNlx09tmWviq2B4ZG7/tgcuC0u9Kcx/F4JjTqRzMy9N3OXo6gNTi9aBh+kBmNOfhd8Xnf1WucSscOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=PaE3q25t; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d58377339so4091787f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728992021; x=1729596821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+VZqaDNm/nXVhGomDf3heagvr4DLJiJM3bMFD0yQQg=;
        b=PaE3q25t75lym4VjIJw/ObJ9uo8O16mo/L3CwZI43rMkAWmj6miQYZLUhwEULaJfFm
         VoPLShornBVZCeyo0bRFrPkjVsFy4EwowMSfn1V+Epdt4fzWTzCwazNrFVF6rPp5qWVb
         g8qREf5jVa8LIi2Hfy/AojtnaI4glAZgnY8u4HmBgmzFfft4g+q/ucchoLsCXlZU21Gq
         JryNEbBdnhWIoIkgzQ/2/nhmemegcnqjhIiP3mGMtbYfeFa8OOJqk6GhKn+aQvbtDczU
         M4/pgpq76FNCD9TaLoTwZvDSOHbWCLgyi+aUTrizc7dYyNw4jtqZCVSJ8OHKPvHaaNk9
         i/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728992021; x=1729596821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+VZqaDNm/nXVhGomDf3heagvr4DLJiJM3bMFD0yQQg=;
        b=uJmaRZtCOQI5js/IiIJ/9BI4sahLCW/6K3oMt0O4HziGszA723FaP5Cjdil4t+XQ1g
         HpE0hkQmlDAcaytrYXLcMaB7H0ViQhJ8xflm6HacV8Qxp1XGPiCHo25MAL2jLAJQXD8v
         0SGuOfxJDjBdGkYpJlq7/YIZgZJ6EOGtYZj1Kww3Ze1zIfyZUMHoacna0SmLvcYsgc1r
         Dheo/FydLVt05IFx3ranIUPTq/u6ZAFfQEnwZZPCPUe7WN1PJxPtYSJ5PY/Z7/QVF93L
         EIqX/melkJUoiRPA3ExBNGXsKnLZlBmYSpgRi51nEYhxBPpNnppPqCwyALbrOZmav7Gn
         tzrg==
X-Forwarded-Encrypted: i=1; AJvYcCWQxXw1IYZ3qSPw5qitGpddANFF0Kj76cHmz+2uhKCeO9a+QaZsx36ZQ2pFcICKTpWHp88P7rqJtEgwEO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCgHtXs+KjWqrNvAnyJivibiVFSI4P7BzaEDs2KG0phvncVPI
	pqlQJSvKrzjEotrmM8wzdP+K1ET+cpurodK+SkeV6l16sgI8IQIiNI8jhXWXWLw=
X-Google-Smtp-Source: AGHT+IGEWqcYi1ZOd31/pKsjgf+yfqOzpHiaKQGzHak8tGP5ctTTmIcoPMm4LdGfPAUwW5O/CHhkKw==
X-Received: by 2002:adf:fe08:0:b0:37d:39bf:37e3 with SMTP id ffacd0b85a97d-37d5ff59707mr9764255f8f.16.1728992021556;
        Tue, 15 Oct 2024 04:33:41 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314209688dsm12579695e9.14.2024.10.15.04.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:33:41 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sylvester Bauer <sylv@sylv.io>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: hwmon: pmbus: pli209bc: Add bindings
Date: Tue, 15 Oct 2024 17:03:27 +0530
Message-ID: <20241015113329.667831-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241015113329.667831-1-naresh.solanki@9elements.com>
References: <20241015113329.667831-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Vicor pli1209bc.
It a Digital Supervisor with Isolation for use with BCM Bus Converter
Modules.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 .../bindings/hwmon/pmbus/vicor,pli1209bc.yaml | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/vicor,pli1209bc.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/vicor,pli1209bc.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/vicor,pli1209bc.yaml
new file mode 100644
index 000000000000..3647d14e9111
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/vicor,pli1209bc.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/pmbus/vicor,pli1209bc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Vicor PLI1209BC Power Regulator
+
+maintainers:
+  - Marcello Sylvester Bauer <sylv@sylv.io>
+  - Naresh Solanki <naresh.solanki@9elements.com>
+
+description: |
+  The Vicor PLI1209BC is a Digital Supervisor with Isolation for use
+  with BCM Bus Converter Modules.
+
+properties:
+  compatible:
+    enum:
+      - vicor,pli1209bc
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description:
+      List of regulators provided by this controller.
+
+    properties:
+      vout2:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pli1209bc_p12v_d: regulator@5f {
+            compatible = "vicor,pli1209bc";
+            reg = <0x5f>;
+
+            regulators {
+                p12v_d: vout2 {
+                    regulator-name = "bcm3";
+                    regulator-boot-on;
+                };
+            };
+        };
+    };
+
-- 
2.42.0


