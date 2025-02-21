Return-Path: <linux-kernel+bounces-525201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1423A3EC59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510CC3B5E47
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900E1FBEAD;
	Fri, 21 Feb 2025 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO05cEQK"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B471FBCBE;
	Fri, 21 Feb 2025 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117010; cv=none; b=i0Vo4Nq4OWUNLQK8xa5hSkHqduDpVJwtiqsPDFTx11qTZgoSwblAhYLj01GbaAANIKRXcwe5t8WrDkGd5PLwVI4UE11IwwEAzi2N0pLgpXPVj65Lc2ZjOJf0Pb4sQUT2+V25tsw31+JVebXQ52gGyxcAR5+FyWJ/OnRwo5PHzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117010; c=relaxed/simple;
	bh=0V8bm9nzriraNvDqqVVQpkqXQu1gmEonWBXcVsudgRY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MK9F5xY3P59Ib4/aOk1z9zV3Y8a5+Ty4gEFJ+U+NiOU1Y4UjbqofjlmpeOMRRbtwGGKnPrm3B+Qdmr4O8XvPiJ97bC5p/tFI2rOpqxjZ2UTwlV3v3FH72ox/diuktgP9HwoNk9jTMtyvzywwGOwU1KGuaKqZjZz0VS7qeYWQhL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO05cEQK; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fa8fa48ee5so483163eaf.2;
        Thu, 20 Feb 2025 21:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740117008; x=1740721808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIuCoBmmJbqWh/4IUDnMFO7CbsX53Ig+Rbn9kTn8z7k=;
        b=QO05cEQKEHs4mqp0gD1kZyvz9w1HWfxyX7Acwj/dmlo9gOTJ6If2bR79jUuse0lWEW
         DLm3W/gDl6z4lZ9QrewTDCxC1RkymgEGhY6LwVrm9GBOhjjP/A8FWNgxWrJYv6iU69O8
         aRdsKsL1G6S2ViQ9F92x5Cu2z6qEEetgXEpwUhpYunJNURWvCnP3s67WypIYBcvqwq6/
         hhTKOFFng9xezJS4Da7bDI84fpuUk3NLLQfatYI0+OPKyJ6VOpsYmBQxOPE/u1b+TNcP
         vV8bktalQeqFPI7QJdhoTm9N/SSZ86otnSkbUe5Y7tqiVLI7Zg1eaI4ayjBr+CKmfj7T
         m6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117008; x=1740721808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIuCoBmmJbqWh/4IUDnMFO7CbsX53Ig+Rbn9kTn8z7k=;
        b=d/JXn5AHJ1YGRrDyGtX6fqcQwK+HjGM39MNcU5CfoL1TvNUQtkNyftAnolKOkaD2c9
         TXjWCZBMPqV/HjkTnG6Bbou/jTrXHOi6i5M6NcODokfORBnZYbgzEvrMFIwYNRo8CJY6
         WlyR8BIZ+XE3xZfCQsmW9H7XVoptvE5NnI0ZtRo4Xtfi5DDosXzCW/pPe8jJKsEwxma3
         6qWPE0U+YG3iUqOFTa5c2FW4ZrovrPccNK6/WOg3/xpMOC/2sN/UcySPX3RBJyNIX6aJ
         OWpKCEGXDKhFIeys82+9eeeVbqMdNYvcFlyKyKUqr98JTUZGxNrRBSDEEyqswzzE34NS
         wDjg==
X-Forwarded-Encrypted: i=1; AJvYcCUh861y3kjDqxJb1kVnwIq4H+HEesPDFj785JipIFpPZgLZA200MPKMAJ0xhEXwA6Ya1/mNuF6jSKD2Qt1J@vger.kernel.org, AJvYcCWsYjVjP7L63vNI+pGQXAlXIOX7c6u5wg3gx+L78jOBdhEmX/XqzikcpP5YgiDbvVPdXw0APKZMSaU9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/+i6uu3qgAu80OL6w+4rJ7t782OfkTSuei6R4XPtQlEmkhVn
	UTvjQl2+tL/u5SFzLva7FLQfONgboMigNCJlcza1P/XHs5Wyq7Co
X-Gm-Gg: ASbGncvzQNO9GCvfSYWv2gzEZY25q2mzVphU1uGTDt/+Q7owPVgRF3TtcfbxKpp7yGJ
	Kx35O4qnCi1epw/GbI1Tn8kk/MBblWgJAr2b5t0IngBNjx6QNMxmloRNnfIF+5dNT6QbcfRqcNN
	XiBH9BxQAqKIWLgxbUMJmDf5A3kXwoXnoj11dpZOfWyZVStxLpOGPvho8oA87fttIfDGmkqYsZj
	Wg5O1kTkU2iy4truB7oWFcp7lgbjxhszUSTDc1y+pkpSFH3K/06o9mug5Rtc3KwqcaEogfSi8vG
	GxvyoUVDcS3ap5zn0zzSsG1E1tK8e59H4GIh
X-Google-Smtp-Source: AGHT+IE6qBeK9TsEn1fLuU8i6GxNLg8V4wjLi9MJTyltzbCchkV4pktYUBjug+y2v4gbUzIrXIxHKQ==
X-Received: by 2002:a05:6808:80b1:b0:3f4:c2b:def7 with SMTP id 5614622812f47-3f4247e3c50mr1406598b6e.33.1740117008010;
        Thu, 20 Feb 2025 21:50:08 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f41bc57784sm550230b6e.32.2025.02.20.21.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 21:50:06 -0800 (PST)
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
Subject: [PATCH v4 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI
Date: Fri, 21 Feb 2025 13:49:58 +0800
Message-Id: <4967e01306c07908caebd60736f898579412765d.1740116190.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740116190.git.unicorn_wang@outlook.com>
References: <cover.1740116190.git.unicorn_wang@outlook.com>
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
 .../sophgo,sg2042-msi.yaml                    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
new file mode 100644
index 000000000000..e1ffd55fa7bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
@@ -0,0 +1,61 @@
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
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    const: sophgo,sg2042-msi
+
+  reg:
+    items:
+      - description: clear register
+      - description: msi doorbell address
+
+  reg-names:
+    items:
+      - const: clr
+      - const: doorbell
+
+  msi-controller: true
+
+  msi-ranges:
+    maxItems: 1
+
+  "#msi-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - msi-controller
+  - msi-ranges
+  - "#msi-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    msi-controller@30000000 {
+      compatible = "sophgo,sg2042-msi";
+      reg = <0x30000000 0x4>, <0x30000008 0x4>;
+      reg-names = "clr", "doorbell";
+      msi-controller;
+      #msi-cells = <0>;
+      msi-ranges = <&plic 64 IRQ_TYPE_LEVEL_HIGH 32>;
+    };
-- 
2.34.1


