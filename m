Return-Path: <linux-kernel+bounces-535150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCCA46F92
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E185D3AF4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A320E32A;
	Wed, 26 Feb 2025 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8+gzMDR"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B12620EE;
	Wed, 26 Feb 2025 23:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613383; cv=none; b=OaYqk6AUD3OIYYyanSpbJvy9X6JstemVX6VwzJDjuy2BsWpcSAhID0JxCL4fpnqEZ2MYr4NFPvRdF4Npy3TDsO249IetZ/JynfLaI61d8HOKR7g6vPAJENaRqE7kzEtsPFmzB6XiV4nRPalZhcuAYf/U4VUILr7FhieCYusx7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613383; c=relaxed/simple;
	bh=yB4+HY8mRrtS+9q//3dQ5/10SMQ6N0Qm4zJtdHlCn+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgnIclWWFMJbb59T9RIPAMfA700EwbeVpwcR9fNR/4bFkabsrgSKNoGJUEFZlp3ngWVtWj/Bbb2d2OOIwWK4aKNbxtgzBYHMtfQh/te/olB7OJSNP2hYJ1MyI7c+OK7Outss22eV8/pCrhBzRvIRrDznPsrvsqjcZJ9YEkYWL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8+gzMDR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-471eb0e3536so6239561cf.3;
        Wed, 26 Feb 2025 15:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740613380; x=1741218180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1+lP/WIL+F/rv1NC/9PUv+dZq+2rnJ1+5/Qq+1dd3M=;
        b=c8+gzMDR2WkhJRwHF/vq8QzWIS/VEYXoZ1/Ez36/iKqKl+1ebsANoNK3QW+v39xXcq
         D8HN3qmvxcv2d8RELT+22jaP5NBI4GwR9hCpObaoBK40iSPqpOF3jjSGKp2ZpJ379sO4
         US/EQsOoTJK8kDi6GdOhCw/MINhE0vep5uI5SIvtcvaSa6hY4AaHqAbAl+953DOPwRfO
         751/iO6wCFEJG7dTfs/EgTKpvddtuCCn3idkd/wvEHSQ7bK9oOoeyRhatocBYehbRQZ7
         t5fhiLFe/nr7tEiV8ocIeZYWEZi0DQ0IHuFpgvG0Sq4AJsq8hqSZRcfE9DEEWsWpMbAr
         zbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740613380; x=1741218180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1+lP/WIL+F/rv1NC/9PUv+dZq+2rnJ1+5/Qq+1dd3M=;
        b=DqDaSvoiwn1/F+QdvU1GezhmlfPqFqzRWydVUX7FivUr0kSeO0+kj0tSOyL1VX20k2
         xUurH6sSGrOVfdu0bkR/91PUev5iJFuO7O7uR99QT5tFyLtxey6FB1QpJ23vySDU11Yz
         VkCUKHBq4rSPoga4WbvPcKUIeawsE0JrcTYWYr9WIGVr7ovzRwNWXz571hgsvA4sEPDl
         ny3961vJgUxAcBQHtEv5djlaqmghnmaHRTmmByIoz6bi7cgh5v/MsxraGKXemGX4GEJb
         9FcYXAqLr2f073DJWZJfOYRlWt4HxoxjPNJHF9u8wgDazVc9/N3Ah7tHj2Q8mt0GwFhV
         lwuw==
X-Forwarded-Encrypted: i=1; AJvYcCUhv0nCjZd2LDF7SoknJNCjU9etUez3L9nvRlKWb99jGU+SM86Gd04Yn2iq8MEfRPpW4Az8P6XsLvh4y/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd7XG3ev8mrZghHDBBc0RyO+6ZaadfAaen7z2g6chGr5MVJi79
	+D6b/4XNeM4z/aP7zWDlvRFPTBidk8uhNY2sZGHnngkAZeavqIk9
X-Gm-Gg: ASbGncuIfN28U1tn0zfkg0pGXSMEYgLsyZZ3iK1rbqcSJoKRTl6cb63X7XET7NDm8X5
	Se8QmWPBYAJrYbahAnJtsaqMmEoMZZxWuBDWwo67/pQiuHmJqT3OrwV5Eu0m068mrYddmVeBBZT
	MXzT6sqjEFOAEMxtR31lBtDpqYJ96WgDzYCelUD6yVQMOq93U4VnimYud4cgjLG2xvvl5/5ljeX
	UwmyH1uQ5LJLwtZzrKKTlrahhENvT2jOOD3vjW1SbjTSwUX2I/uCE3n5iNAorXWOLcnStzq8AwT
	vg==
X-Google-Smtp-Source: AGHT+IE44ZeBH/IrSFQFlBWBOeEM9K3xucoChT7wDAEvDlnvzZniYENcKpDmeUtZGqquKBj12bm2Iw==
X-Received: by 2002:ac8:7c41:0:b0:472:1de:c912 with SMTP id d75a77b69052e-473772722edmr140400091cf.50.1740613380578;
        Wed, 26 Feb 2025 15:43:00 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47472430d89sm2637701cf.68.2025.02.26.15.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 15:43:00 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Guo Ren <guoren@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: reset: add generic bit reset controller
Date: Thu, 27 Feb 2025 07:42:29 +0800
Message-ID: <20250226234234.125305-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226234234.125305-1-inochiama@gmail.com>
References: <20250226234234.125305-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SoCs from Aspeed, Allwinner, Sophgo and Synopsys have
a simple reset controller by toggling bit. It is a hard time
for each device to add its own compatible to the driver.
Since these devices share a common design, it is possible to
add a common device to reduce these unnecessary change for
the driver.

Add common binding for these kind generic reset controller.
Check the binding description for its requirement and
suitable scenarios.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/reset/reset-simple.yaml          | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/reset-simple.yaml

diff --git a/Documentation/devicetree/bindings/reset/reset-simple.yaml b/Documentation/devicetree/bindings/reset/reset-simple.yaml
new file mode 100644
index 000000000000..86c33a608148
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/reset-simple.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/reset-simple.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Bit Reset Controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+description: |
+  This document defines device tree properties common to reset
+  controller devices that perform assert/deassert by simply
+  toggling bit.
+
+  All devices in this binding should satisfy the following requirement:
+  - There is a single, contiguous range of 32-bit registers.
+  - All bits in each register directly control a reset line.
+     - There are no self-deasserting resets.
+     - There are no timing requirements.
+     - The bits are exclusively resets, nothing else.
+  - All bits behave the same, so all reset bits are either
+    active-high or all are active-low.
+  - The bits can be read back, but the read status may
+    be active-low independently from the writes.
+
+  If the device is not meet the requirement, it should use its
+  own binding to describe the device.
+
+properties:
+  compatible:
+    const: reset-simple
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+  active-low:
+    type: boolean
+    description:
+      If true, bits are cleared to assert the reset. Otherwise,
+      bits are set to assert the reset. This also applies to
+      read back.
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller@1000000 {
+        compatible = "reset-simple";
+        reg = <0x1000000 0x1000>;
+        #reset-cells = <1>;
+    };
-- 
2.48.1


