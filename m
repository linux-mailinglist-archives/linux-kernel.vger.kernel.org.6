Return-Path: <linux-kernel+bounces-211923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E49058ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575491F22D26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A9181B84;
	Wed, 12 Jun 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXbrMDLs"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23522094;
	Wed, 12 Jun 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210255; cv=none; b=M+UCSquaWmRl7Wt05J5xiP2iCsliE6UiaP9/qu9GKp7HkswP1haJinwIZWiXSg9vHCMoxboOUqH6MwXgRp3z+Q6CmoYcsERe9Xh8qeALuMVhzn3PnF04kcf6KvYg9K+imO/FH/oBn4Zy4BiM8eUwBasVLBASZc8GFBrPpw4eF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210255; c=relaxed/simple;
	bh=obA7dlhSLgFk6GyFI/xPqD4492ZshW5iL6G2Dk15AU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7znp07iVB30muBIKM1JMqeL8xsx7hfXq6ZAAChldGswa2uwIKIoc5+mRtnRyt0KVT7SDm811AOgqnrb6kjwh4HJb5kKI5A76BVhFHNHeEgTdxgO7f9BfZy1mTD0CrX44nNvkN7AvcU5vcmwTiler1C5VHElkPUIimDO3mQ93Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXbrMDLs; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-797dcb558ebso113156585a.2;
        Wed, 12 Jun 2024 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718210253; x=1718815053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12/jhHkXdDAL+9rJ1s3aaCTv3iaFjJjz+V4lIsM94NY=;
        b=gXbrMDLsJeDgN+yYQfnB+ktxcDeGMxgvndNFeEIkziVcufztCyPMmiQfUt4QgFy/SH
         tfddgE8EQsL2OnAznGP3pf1w0UhGkaJe59izCnffSqzvszW8kB7b54Jrl065KBP9F2f8
         F/73FMHVHrjUOAPLM/L6VsYFYSqrGJNhsSMKaubF1FmFGoqSuFw3fy94ta7hZ2VCS6BY
         vBIT11iIMTkxwUPlIDFwstlMIFZXtruTs1PS9oK3sIleHBFQhZNxG9M0AU+DuTA1YRPp
         2bgI1al/7liC6ec0q3fQXSp9qDhvbu/8WnB3AqsKO8PYcd3tAqpQMu6J0iwPDIvUNIwh
         q6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718210253; x=1718815053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12/jhHkXdDAL+9rJ1s3aaCTv3iaFjJjz+V4lIsM94NY=;
        b=I4opOWoxW0L/kmYeA5ZrAwQWfxbwqdLF3imLbMBAfZ5CdruXIOsvnVzs++/559pO3/
         qdJmrwJdGI3N1IinqnPsufPUma08svqAZK8hSjjB0YCTFJwsAFwvb4pkYsZdDhhIc4Xb
         phCqU56L+wZEjdKufOcO7Y3a0+JZsx5aAZLhTmo4FtfqBQorQA+vJD2wfTMy9ccqg7KI
         gYSkSnpJpEIRz2PyfOfanZL3B5Vbk6+4U9TDUBjCdWykh5AvZCFBAviklLchQyhgvZ71
         s1Sz1ZOk7rCsmNJYGj7EqlVyv77RYfHiOYTMoxkWwzy2jZuxfE6GwuOCqsSm/m7HA9Xi
         BGNg==
X-Forwarded-Encrypted: i=1; AJvYcCXLVCYdC6/BBQiuevhjYudCgfM0Mbglaii3KHiUjKze5wUm931a807UaapHfRRJ2uawQuZQWw6v6Aj5ZDBowPc4kALWBVK3BphoVY6EvczkrOkEqIcrXmCv6MtL7zhKllcjJRlSeri6q97gtcQKS19uAbFmc6EN78XFvLurb7g3M7OPEoWG
X-Gm-Message-State: AOJu0Yw+K+5r5jbBk/ZyR8j3USCmPSH2O2E16G+UMRDpuVanNQL2KA9k
	JKbuz+qwtfXe/p9x2brePZYZznqVD7szVTHs4EhdYo5IMeNCSeyB
X-Google-Smtp-Source: AGHT+IFT8k3qNR332tNPZA9c0rkrNYavg+MmrQQZneJutNHAF0if1JXV2r+bKb3HjpJA8HF6Xh0RVg==
X-Received: by 2002:a05:620a:1a1e:b0:795:1e16:b22f with SMTP id af79cd13be357-797f604746dmr274415385a.33.1718210253302;
        Wed, 12 Jun 2024 09:37:33 -0700 (PDT)
Received: from sheun-Legion-5-15IAH7H.phub.net.cable.rogers.com ([2607:fea8:bad7:5400:f2b7:e8f6:98dd:a423])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532813a2dsm615143685a.20.2024.06.12.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:37:32 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: sound: Convert max98088 to dtschema
Date: Wed, 12 Jun 2024 12:36:50 -0400
Message-ID: <20240612163730.515819-1-abdulrasaqolawani@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the max98088 audio codec txt bindings to DT schema.

Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
---
Validated with dtschema and tested against `nvidia/tegra30-lg-p895.dts`.

 .../bindings/sound/maxim,max98088.txt         | 23 ---------
 .../bindings/sound/maxim,max98088.yaml        | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/maxim,max98088.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98088.yaml

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98088.txt b/Documentation/devicetree/bindings/sound/maxim,max98088.txt
deleted file mode 100644
index da764d913319..000000000000
--- a/Documentation/devicetree/bindings/sound/maxim,max98088.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-MAX98088 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible: "maxim,max98088" or "maxim,max98089".
-- reg: The I2C address of the device.
-
-Optional properties:
-
-- clocks: the clock provider of MCLK, see ../clock/clock-bindings.txt section
-  "consumer" for more information.
-- clock-names: must be set to "mclk"
-
-Example:
-
-max98089: codec@10 {
-	compatible = "maxim,max98089";
-	reg = <0x10>;
-	clocks = <&clks IMX6QDL_CLK_CKO2>;
-	clock-names = "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98088.yaml b/Documentation/devicetree/bindings/sound/maxim,max98088.yaml
new file mode 100644
index 000000000000..e4a2967e1e81
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98088.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98088.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX98088 audio CODEC
+
+maintainers:
+  - Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - maxim,max98088
+      - maxim,max98089
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: master clock
+
+  clock-names:
+    items:
+      - const: mclk
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        audio-codec@10 {
+            compatible = "maxim,max98089";
+            reg = <0x10>;
+            clocks = <&clks 0>;
+            clock-names = "mclk";
+        };
+    };
-- 
2.43.0


