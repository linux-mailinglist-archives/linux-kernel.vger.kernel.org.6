Return-Path: <linux-kernel+bounces-248862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF192E2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970B0B24731
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9A1552E7;
	Thu, 11 Jul 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ejlan/YS"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DAC78283
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688379; cv=none; b=YGo4cmrianrzXxS7xGI6h6E4NcrqD5g0rGXGWgRSbc/Eu3GyfwNMC+TTpxYSRpk0KY7EZfkXZWAmdplC/KgfgmZF0F15mXNif4iP2RUEeDlntocOHjT5an+5mwQFnogld6LhClx1/gHr5H/wwoAycGWNuvGHuF81lBvfQHVCECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688379; c=relaxed/simple;
	bh=kx4wLTa+Ga/WGZtWGOks3o0GXHnevsr2uZwjCifpqvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJXmifuyeHJBB+0hSsmCGGfMnmZ+PHx4JkwRe71K+tKboBSU6bSvM81bOiAGEiUIx/hSnkNZ8WOtb2gKXmcQw32mVLH+FbeUGVE6wcOOo0NcJgeA5ULrP2lWVGbbXF1QjkJPQNacmoKDCddgjXOUQ62OFJGyohykz7PyNeJ7+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ejlan/YS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7527afa23cso75848566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720688375; x=1721293175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYHfIzh6nXI940hKuAxpyqgihORM2bu69bXzo1+glS8=;
        b=Ejlan/YSya4TCmhs81lJmXvLCVxrvLK2v0GGsDEG+D2KsQi+A7ZFYTLrvF6VbG/UZ5
         wuCHPO9CAnCC009zjZCJJCRxpWPl3VYCYmnuE55ytFAXQ1LWxGeOMZr+RTtfdeGS2L1e
         pyzxH0nDhK3ZdKx+b7UynqhSs9Jt3Y3CLoBJudHNrDynqsps/mj2lX0ptmNvAqFsA0S+
         LZUhww5HyQfeOPk+667M3ImwtjYmWxh0USvi4bG3FhEhODAisaGrq+R6LEP6bP9B3/Rs
         TwmmW2S1bygVec5G6kIsPyOmQetL2FCcqlnjvYep69XGJWunBLuMf27oYIcqzWejgZY8
         3Nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720688375; x=1721293175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYHfIzh6nXI940hKuAxpyqgihORM2bu69bXzo1+glS8=;
        b=lAfbIUpXK+GZLJXS5HE6qjrwlIVd8iRzYjcZO80pBn6MV3CWybYLK/07ccIYnIoOzQ
         j2ayle3m3MCfqU4PIRX2+5YlphhWMc5s+CFCrtGJITQX8FWmP5kY7524flrPWoWM1Dc1
         wAxoBlnRssIoIa1cXwweXCTCNvEHOf5iq51GblfXGS/HAs0ZX3jrZByzw+AeAkPspNOC
         awHlmmETETWxgZWKCqnpQ9bg+LRhKqd2xlfQAS0B0Nm6sQtAgPaoAdr1YcG1QFOoT0/S
         dhrvvbHfCxnIli2WD4aoNkdtx8Ki3vGM+QDFYS7f2oGQEedmtscRDd3WOJcTfmimCn/m
         bzrg==
X-Forwarded-Encrypted: i=1; AJvYcCVHG6yEBri7E7zZ8fksVBqraxujw7FN+aaDob1L2LC377BrdNx3yvmF4+thhRjGQdpMb8xCxkz59ye6C5zKePgmQO3QUztuLAhYofRX
X-Gm-Message-State: AOJu0YwADc3+rVSN9IbOJnZbW2Sktx7pBbGDjJyxjxVhPEXN5pbCcCl/
	TedBqeXWfktimHcfDxaHxhFdMJyWrQDFOWEIqtJxH/A8VhvjQbHkC+kXHSB05OA=
X-Google-Smtp-Source: AGHT+IExeC3C4albQGRNoDgw/aHSquAiRuszOsto2bVaKPyevYnsItstoK9CCVVLybUhUJwNqLtutA==
X-Received: by 2002:a17:907:94c5:b0:a77:b01b:f949 with SMTP id a640c23a62f3a-a780b6fee77mr760883866b.35.1720688374667;
        Thu, 11 Jul 2024 01:59:34 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a854a27sm235876966b.162.2024.07.11.01.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:59:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2] dt-bindings: incomplete-devices: document devices without bindings
Date: Thu, 11 Jul 2024 10:59:30 +0200
Message-ID: <20240711085930.26252-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are devices in the wild with non-updatable firmware coming with
ACPI tables with rejected compatibles, e.g. "ltr,ltrf216a".  Linux
kernel still supports this device via ACPI PRP0001, however the
compatible was never accepted to bindings.

There are also several early PowerPC or SPARC platforms using
compatibles for their OpenFirmware, but without in-tree DTS.  Often the
compatible is not correct in terms of Devicetree specification,
e.g. missing vendor prefix.

Finally there are also Linux-specific tools and test code with
compatibles.

Add a schema covering above cases purely to satisfy the DT schema and
scripts/checkpatch.pl checks for undocumented compatibles.  For
ltr,ltrf216a this also documents the consensus: compatible is allowed
only via ACPI PRP0001, but not bindings.

Link: https://lore.kernel.org/all/20240705095047.90558-1-marex@denx.de/
Link: https://lore.kernel.org/lkml/20220731173446.7400bfa8@jic23-huawei/T/#me55be502302d70424a85368c2645c89f860b7b40
Cc: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Rename to incomplete-devices.yaml
2. Add many compatibles based on Rob's feedback, rewrite descriptions in
   the schema.
---
 .../bindings/incomplete-devices.yaml          | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/incomplete-devices.yaml

diff --git a/Documentation/devicetree/bindings/incomplete-devices.yaml b/Documentation/devicetree/bindings/incomplete-devices.yaml
new file mode 100644
index 000000000000..d690d44560fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/incomplete-devices.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/incomplete-devices.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rejected or Incomplete Devices
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description:
+  Some devices will not or should not get a proper Devicetree bindings, but
+  their compatibles are present in Linux drivers for various reasons.
+
+  Examples are devices using ACPI PRP0001 with non-updatable firmware/ACPI
+  tables or old PowerPC platforms without in-tree DTS.
+
+  Following list of devices is an incomplete schema with a goal to pass DT schema
+  checks on undocumented compatibles but also reject any DTS file using such
+  un-approved compatible.
+
+  Usage of any of following compatibles is not allowed in Devicetree sources,
+  even if they come from immutable firmware.
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          Rejected compatibles in Devicetree, but used in ACPI-based devices
+          with non-updatable firmware/ACPI tables (via ACPI PRP0001)
+        enum:
+          - broadcom,bcm5241
+          - ltr,ltrf216a
+
+      - description: Incorrect compatibles used on Macintosh devices
+        enum:
+          - adm1030
+          - bmac+
+          - heathrow-media-bay
+          - keylargo-media-bay
+          - lm87cimt
+          - MAC,adm1030
+          - MAC,ds1775
+          - max6690
+          - ohare-media-bay
+          - ohare-swim3
+          - smu-sat
+          - swim3
+
+      - description: Incorrect compatibles used on other PowerPC devices
+        enum:
+          - 1682m-rng
+          - IBM,lhca
+          - IBM,lhea
+          - IBM,lhea-ethernet
+          - mpc5200b-fec-phy
+          - mpc5200-serial
+          - mpc5200-sram
+          - ohci-bigendian
+          - ohci-le
+          - ohci-littledian
+
+      - description: Incorrect compatibles used on SPARC devices
+        enum:
+          - bq4802
+          - ds1287
+          - isa-m5819p
+          - isa-m5823p
+          - m5819
+          - sab82532
+          - SUNW,bbc-beep
+          - SUNW,bbc-i2c
+          - SUNW,CS4231
+          - SUNW,ebus-pic16f747-env
+          - SUNW,kt-cwq
+          - SUNW,kt-mau
+          - SUNW,n2-cwq
+          - SUNW,n2-mau
+          - SUNW,niusl
+          - SUNW,smbus-beep
+          - SUNW,sun4v-console
+          - SUNW,sun4v-pci
+          - SUNW,vf-cwq
+          - SUNW,vf-mau
+
+      - description: Incomplete and incorrect compatibles for unknown devices
+        enum:
+          - electra-cf
+          - i2cpcf,8584
+          - virtio,uml
+
+      - description: Linux kernel unit tests and sample code
+        enum:
+          - audio-graph-card2-custom-sample
+          - compat1
+          - compat2
+          - compat3
+          - linux,spi-loopback-test
+          - mailbox-test
+          - regulator-virtual-consumer
+          - unittest-gpio
+          - unittest-pci
+
+      - description:
+          Devices on MIPS platform, without any DTS users.  These are
+          unlikely to get converted to DT schema.
+        enum:
+          - mti,ranchu
+
+      - description:
+          Devices on PowerPC platform, without any DTS users.  These are
+          unlikely to get converted to DT schema.
+        enum:
+          - fujitsu,coral
+          - fujitsu,lime
+          - fujitsu,MB86276
+          - fujitsu,MB86277
+          - fujitsu,MB86293
+          - fujitsu,MB86294
+          - fujitsu,mint
+          - ibm,axon-msic
+          - ibm,pmemory
+          - ibm,pmemory-v2
+          - ibm,power-rng
+          - ibm,ppc4xx-spi
+          - ibm,sdram-4xx-ddr2
+          - ibm,secureboot
+          - ibm,secureboot-v1
+          - ibm,secureboot-v2
+          - ibm,secvar-backend
+          - sgy,gpio-halt
+          - wrs,epld-localbus
+
+required:
+  - compatible
+  - broken-usage-of-incorrect-compatible
+
+additionalProperties: false
-- 
2.43.0


