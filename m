Return-Path: <linux-kernel+bounces-350006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2590B98FE9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9E71F2508D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85851411C8;
	Fri,  4 Oct 2024 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx9q7zes"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A11386B3;
	Fri,  4 Oct 2024 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029196; cv=none; b=nKdwSGhTVa+G+4g9z1hF80X7bABIFlmK4cfZpimQEXsHcGeogJvxBsyhdy8GrHyAV8eyx9e6uHXUOXj9EW3hD2pWtMykyenjBKjUKWpisfCUSCXX1cHP3nMNVxmjNtvnhK9h78B1idNT642yWzCbafkH4WqIj7rZSyDxXZ0/Q80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029196; c=relaxed/simple;
	bh=K6n+4UwmtZcKyoNg48rgaxKDNoW0xY/Ch+LlwWp/9K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBVLBbO9A071aoIo/ciOLjemo/Xk6ffV/zDdktL8wfDp4vaxcc5qS9An0USz+8+nc1PPLRuTbGQGadu8EuJ8N3Dvmga2osfDr4NxtrWUf3MTGGQRyRNUk9J+pz/dWo8feOXDdBUTM4V9ai3PwfUqE2P+9Lp/Rq4P2UssW0e8zxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx9q7zes; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71970655611so1760230b3a.0;
        Fri, 04 Oct 2024 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728029194; x=1728633994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn7EDiPk8tvD+amgfWsMTbLvOA9JjMtSP1WSiPFeqcM=;
        b=Rx9q7zesACjujz29S0M6p7X6NQ2rpc0Le+3B/UNz/9G4z5ivs5L5bb7tgb+Bte3Mot
         jFJnokYczQJdoiccpbZhRvOKCnbKrJIgE+0w9HL79+6YH9W6ZGHoJ8JPKW0nEqhuubsB
         WWxkg9AR4WtnuMGyunJhyrm0c97bS+SkpX2+xac6HySAVVWME7kyXc5Y4j2BYLimRiJj
         IIke6Il8vKkP3CsbB8WEX8w7U5CrmYYAb4RIb9dRoArmsVpdNg9I8wOiq4E/5mkS5RBR
         3ETwF+82PvuCo/ky6K0iqZOU3Tr0lFfx2Bjob+IROnNdR4Xi+/Uap8KEjM7Y1Y2wju7Q
         O1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029194; x=1728633994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn7EDiPk8tvD+amgfWsMTbLvOA9JjMtSP1WSiPFeqcM=;
        b=b1hu1mkfrErOrZQ6gGsklIHKIyn+2I8VpqvQeogEPWO1xSxEfvNpP+80Nouf/XWKDF
         3Vcg6JvlvxRiVRQZXRE62iH8bV2G3Lzsf73Dj5uqnm3a6ON/lYtDtMxrMNg/Dp60kpSM
         bivZY0fwRFl5liLNi0aXJKDzcwOTkd1WElYbb2Y2+ZLIkK/TZcsktl+NgfZ+V/gMtHe3
         gwFsyKNGWcTJUV7qe4yKwoKLBUUl3+GNwlkURmufugmRNVIxAs6eIJwqBmG0+aQCoCBv
         6N6GOD4wRj8L+g0zxab7c/+k+Do2+pV3iYoLtNCQPCCE7h/O5+6svRxhU6Z67B9febul
         j/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVR8Y/6Xz7e+k8rdYJw4Z3nLnnT2H3+5zOKl65dU2nBley4S29Tfg5fJy2jePUb5aYGclypL5hseoOwturx@vger.kernel.org, AJvYcCXz8jB69kHXbp+68GnhykEJJVhTHTRArL4E2opp+0pPj0wwvcxhNqqdvOKI+NcutXgzRsQLfgC9Edkk@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7e9pukd9DNT7rVS39bWN9fVKQaq+FG9jUxLtQ3Ka8q0tUnvA
	EreN6vZR2QCFv5Psq/jDFVD3/TNhsyuabS0WIzJ/g4p0eLUDbByU
X-Google-Smtp-Source: AGHT+IEPhKOYkZAH1L27GVScnktHV29Zg6rnYt7Aao9Pj+ivGpNBxOMvq6N+e5012LjWTi4Tl4hdpQ==
X-Received: by 2002:a05:6a00:3c83:b0:717:8ee0:4ea1 with SMTP id d2e1a72fcca58-71de22e8399mr3349322b3a.0.1728029193671;
        Fri, 04 Oct 2024 01:06:33 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71de63d0014sm689798b3a.190.2024.10.04.01.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:06:33 -0700 (PDT)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2044 ACLINT SSWI
Date: Fri,  4 Oct 2024 16:05:55 +0800
Message-ID: <20241004080557.2262872-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004080557.2262872-1-inochiama@gmail.com>
References: <20241004080557.2262872-1-inochiama@gmail.com>
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
2.46.2


