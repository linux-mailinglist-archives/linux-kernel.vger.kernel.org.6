Return-Path: <linux-kernel+bounces-373226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E939A53FB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 14:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C5BB21A02
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1A192D66;
	Sun, 20 Oct 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFPYPSqU"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B29191F7E;
	Sun, 20 Oct 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729426253; cv=none; b=nMOWuYuVSP20q6Cc3BepOD4SmymO6RYvdDNPqHAzE0lgnHUTKcte/ItrYjH2dSYWxFV2CAUE33WxyLNzH79H5s4Ov9C/W7Hg5y8A1fxCjgphuVNnmaMG79I0raOMM2YACgN1CFYHP7p96XzxAhXiMZIaJRxA9Ep5Zx1TUelYfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729426253; c=relaxed/simple;
	bh=Lp4HSqJ6YWFFaJg32TPPyN3xtxBIYCPVwnRg7qOIRSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkA9wNCICCeYX2nZQeOpSvyXnbWmt+kaHDt7fNbo6Y3RcUw1qloOSA044lXwmNYp/EUyJP308kBvyk/Pvgkvf4hKi4ubacVhTU9Xtyo9g1clr1MQvt+gHF5dwxjp/x975UNQqVUUDpvF0XXk0tFUmNYC8frLvvRA2jhyR0s31LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFPYPSqU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e625b00bcso2683878b3a.3;
        Sun, 20 Oct 2024 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729426251; x=1730031051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESpVDdqvWArJZ/zn9KV45HICoQoUKaqzB0C6fhXH0e8=;
        b=XFPYPSqUWMfXvvbMoMfkvN/9wubn8cUJuh6WXaxdGr7dFq85TuhPAxbIKToRsBCzzI
         hPDKQ5YRSwEOarFF1AUzXh7SCMr+dw2kvl2VSysbAi9tyo4s8depN45eAWXgdvYtM6Am
         2323PeIFcZTPcTqfXBumFQ/RLzprQBY2U2XcX8G8Jp/tN2TJp6z3Azwnrxlm3OQZ7P5o
         uMdmHTZz+3JYoA89P1y/4OFGr7PesZ6NMR/6J31cM+ilEwQz4UxaGMAUas//e9S8z9Ky
         bTGwcy6I+RzliJgpTrjcvNNzhqkX9dZt/4wk0eSHayfaLNZkTIn4NjWKlxoYEUIMl5PM
         Asfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729426251; x=1730031051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESpVDdqvWArJZ/zn9KV45HICoQoUKaqzB0C6fhXH0e8=;
        b=hgW57EQ/4r8w1B712hFRF1zXC+M/Udtyo7cVg8wbcnMBNNjiOCPqMFwmGqG9O9OfRd
         pgjbro1j+04sH+7HNAVn5IsuiwkYsn2K1GrXu8IUfmt56Nk4tBbpRWUTH+dQrvWyFyEP
         lDEeL8M9BKmrqNmvJlsJXw+Csue3COE1HBkCCqxF9p8YEonHDtN4dEENO34Mi41tO7D8
         7Wrx+U8WLR3x3RgOQVAgbwDnVvsJ3ab7CfbY+nN2hWOtJtQr6XyJ3ArsAmxa/DwDJ5Ml
         zIPQ7V47vjWCl1M9CDpt+77xOMs0zKDG7FIuXDBwjY9RGJoIDo7UxHCuTYjwSmr1hux4
         FfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCViCdjgPso426FLeDOQG8TRvESJQJF9JeIctFyqD1JNMpgbE/9eFJaNZCcdyFuCfmkjKuov5+6FRVKQ@vger.kernel.org, AJvYcCXYdyhx6AyFZxgfxCe0vzhyWAh84UrPR1vlhx1/0He6HbPFd4sqUZ41QXyCm8wzxvXuzd9vIZ4JEJLPq0iJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1T7EyxSSJkT/5q+IPIpWdNTGKTt08DbXYLWXmgzuBxoaA7fu
	VPFPbEZdo5xyj+fiI7mjyKlnEt3fbS8FAF/phD/7uB0uv/vHf46Z
X-Google-Smtp-Source: AGHT+IFxdNKHpEyAEhs+OtgWVnS/3mbcUWbugIHe2isaXwnze/x4LhRIbxctqs3KZKUSftj8na/ugw==
X-Received: by 2002:a05:6a00:21ce:b0:71e:8023:c718 with SMTP id d2e1a72fcca58-71ea31f627bmr10972565b3a.8.1729426251183;
        Sun, 20 Oct 2024 05:10:51 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eb08asm1097140b3a.173.2024.10.20.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 05:10:50 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2044 ACLINT SSWI
Date: Sun, 20 Oct 2024 20:10:28 +0800
Message-ID: <20241020121030.1012572-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241020121030.1012572-1-inochiama@gmail.com>
References: <20241020121030.1012572-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sophgo SG2044 has a new version of T-HEAD C920, which implement
a fully featured ACLINT device. This ACLINT has an extra SSWI
field to support fast S-mode IPI.

Add necessary compatible string for the T-HEAD ACLINT sswi device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../thead,c900-aclint-sswi.yaml               | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
new file mode 100644
index 000000000000..0106fbf3ea1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclint-sswi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo sg2044 ACLINT Supervisor-level Software Interrupt Device
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The SSWI device is a part of the riscv ACLINT device. It provides
+  supervisor-level IPI functionality for a set of HARTs on a RISC-V
+  platform. It provides a register to set an IPI (SETSSIP) for each
+  HART connected to the SSWI device.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sophgo,sg2044-aclint-sswi
+      - const: thead,c900-aclint-sswi
+
+  reg:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 0
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4095
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - interrupts-extended
+
+examples:
+  - |
+    interrupt-controller@94000000 {
+      compatible = "sophgo,sg2044-aclint-sswi", "thead,c900-aclint-sswi";
+      reg = <0x94000000 0x00004000>;
+      #interrupt-cells = <0>;
+      interrupt-controller;
+      interrupts-extended = <&cpu1intc 1>,
+                            <&cpu2intc 1>,
+                            <&cpu3intc 1>,
+                            <&cpu4intc 1>;
+    };
+...
-- 
2.47.0


