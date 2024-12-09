Return-Path: <linux-kernel+bounces-436872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDE9E8BE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDC1164126
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01B214A7A;
	Mon,  9 Dec 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVlnplTY"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0B214A77;
	Mon,  9 Dec 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728306; cv=none; b=jFgHjvB9+6VUa0YJjCgRvNM4HEIofWUL/aMvb6yHlAaC3OUL7aMLgXYwICmtcjBehUZURxq35CBCbBSZm2XF3CRjiIo3NvaGgu71H/ucd8dDpKHA8zgcM4n0Qw480YTP/7/m6x12g9i+g+fbcE+R8l8fjfX2G/Xm+NMeKwYSOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728306; c=relaxed/simple;
	bh=s1qT7iof02FIuyzl4eJeLWsZextQdndEKgPUXxYnHdQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ukf23iFWLtT0PJ5ujvrEsGnrg36MWlHgnnwqr6wStpwbxyMLqsG0Nqx9WC6RgqhA/PmDoQrZPgJVt/YuNwY4kKk7HxcPvNM4zQ1wqpVAgalwpYQv2HoOmA1k31/feCAIfvd0HzPproND8Zqfn9NR9QAn/i+Ewj/GzOCwXzUo8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVlnplTY; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29e5aedbebdso2056227fac.0;
        Sun, 08 Dec 2024 23:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733728304; x=1734333104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=klPRAQmrviFZDy2vInQr+pcPkAn+YtkoFZF3QW1QD8Y=;
        b=YVlnplTYFYNlQ27LV7uqz4u9AepCtD9LL3+xoJe6XhfIOKQm+oP3F1mGwu0htm57TJ
         zK1APmEsAxLrrYHXFwuB6bkD3c52BkYpv9U2zkwOF3W137ozgVFYid69j0SLBMbtsk5C
         6UnE97BjxaREuh/+MrmqFdUFi7139cwpZtoCjLUJUVFwHYjCEn1bScjnSNZTOBJpLWru
         +N3n6R04kEWmFlxMuyKE5OlR5YUryb+xhxHjJUP+NJClRN65M+BXal0Bnjq0Ktizv/4c
         2ibgnT4uCBXcy2VtRVrmG8iKG4e79NuoFbK4x4o5LZJUHPhzMsUGb6iq3wSHxgubUMEJ
         XvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728304; x=1734333104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klPRAQmrviFZDy2vInQr+pcPkAn+YtkoFZF3QW1QD8Y=;
        b=Rrz1v8Ct8RbXOr6o7TqL7YJzwX7Q1jMQ4eA/aufBebngYB7dOL78p+Pl3hDhGvDVVh
         58K8NUQudLUq6SEoTXtBKjbjAnoLs/7vQjNxU+s0hEFsI6RoLpr2IBGP/bW6F0Fv84/m
         j7t9OYVvJyYD1c+U7Be5n8pWKg6P0YRNY/ScD7xuSGx+HEwEGMjlfYgQRrjVA16mDm7z
         iPg6d0ZQPs34j8h2X9byDhhKNhBaseS7nGQfe21I8Kv34bx8qAHcTChGjcja51yRH9xI
         fUlZ1U1pDBo92UGl/2ULoV8QlO8pO6UDUIN6KFwg7FeDu0vnfGwCUYA09dKg8hpYdo+x
         R53A==
X-Forwarded-Encrypted: i=1; AJvYcCV9Du4pssuHdW/r98g75a1QchiyEyL1k0vE+x7MSQwQYFAzWiL++B92iEGk9AfLi/kF9ZiQCQWXQ2h7@vger.kernel.org, AJvYcCVedtKEWbIgIfpTFAs1Q03nZ9hO7EhHQE6YBAm8KqQpm8BQn+lyRquCP+BU8Jt7VCCYOrn5xLxhG+szO8uB@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGuudPP67bhMcyXP7++tnxgm2tE91UC0ROX1jw0jR928pdSeF
	9/WqupDq8hCyP0+B062ZKUGjMer44LfIVbx2qJN7rnu/uYHLhn0Q
X-Gm-Gg: ASbGncu/mq3uI0Ceo8DZtfqHnW8xF6Ehxmwnna5cMKzDafjHu9V/lwUcPvogJzGkKEt
	aeypvkv50T2g6spADuWgNXM5U/g0/BBSuEpeQ519r90cozbNR0j0EUhE9J6YRE53Juw/Cy0naQb
	pktO/vw4b4kZvN4HGKtGBXnFOTGm16i/YgbVHV2S7SVuY5lmeEnkezx8+4k1+uNNELCgWlIg28H
	z2/t9ycR90f76EgG7b4zoloJROxzNMe7hoshDpAcoy3G8teP+Zh49pXJk0z
X-Google-Smtp-Source: AGHT+IGmImEDzFh8sIAAPI0/7eiLKaOccUhREzWI4+bMl5GKhrC4BuLz5gHeJhmGOaOCZkUsv0Go6g==
X-Received: by 2002:a05:6870:9571:b0:29f:b1d4:7710 with SMTP id 586e51a60fabf-29fb1d5172fmr2511485fac.24.1733728303752;
        Sun, 08 Dec 2024 23:11:43 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f56665801sm2532803fac.4.2024.12.08.23.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:11:43 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH v2 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI
Date: Mon,  9 Dec 2024 15:11:29 +0800
Message-Id: <8f857ba0d281010ddfb53d12b3dd66733ee6a810.1733726057.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733726057.git.unicorn_wang@outlook.com>
References: <cover.1733726057.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add binding for Sophgo SG2042 MSI controller.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../sophgo,sg2042-msi.yaml                    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
new file mode 100644
index 000000000000..0c9e9d07e5ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/sophgo,sg2042-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 MSI Controller
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  This interrupt controller is in Sophgo SG2042 for transforming interrupts from
+  PCIe MSI to PLIC interrupts.
+
+allOf:
+  - $ref: /schemas/interrupts.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    const: sophgo,sg2042-msi
+
+  reg:
+    items:
+      - description: clear register
+
+  reg-names:
+    items:
+      - const: clr
+
+  msi-controller: true
+
+  msi-ranges:
+    maxItems: 1
+
+  sophgo,msi-doorbell-addr:
+    description:
+      u64 value of the MSI doorbell address
+    $ref: /schemas/types.yaml#/definitions/uint64
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - msi-controller
+  - msi-ranges
+  - sophgo,msi-doorbell-addr
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    msi: msi-controller@30000000 {
+      compatible = "sophgo,sg2042-msi";
+      reg = <0x30000000 0x4>;
+      reg-names = "clr";
+      msi-controller;
+      msi-ranges = <&plic 64 IRQ_TYPE_LEVEL_HIGH 32>;
+      sophgo,msi-doorbell-addr = <0x00000070 0x30010300>;
+      interrupt-parent = <&plic>;
+    };
-- 
2.34.1


