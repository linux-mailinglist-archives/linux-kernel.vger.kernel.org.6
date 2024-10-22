Return-Path: <linux-kernel+bounces-375567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BF9A9766
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195A31F22E84
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC84784E04;
	Tue, 22 Oct 2024 04:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEA/3VnD"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5B824AF;
	Tue, 22 Oct 2024 04:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729569764; cv=none; b=VTA3JvmaeQHdnmcNJsaCr+G5fno+faOnKuu2+7Z5dWulBDj29BcAUmHHucmq/YO+uq72Ja8PiG7ptuSCwlBIH6MwjNUIuTnBijM2phZn2+Aeehq/8whITpDjHK5kg7L6zAaTlksncMDRdZF0gVpSVhuH7uK9lGeYYWjtAhkGvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729569764; c=relaxed/simple;
	bh=Lp4HSqJ6YWFFaJg32TPPyN3xtxBIYCPVwnRg7qOIRSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOZexmA5YNDT8ehbceTb+8E6IFarPt2H6hoA4p61yXUxtHUfikcvlArjk1OlSVDU2Lzgxe9R6hA1IfEhmkV2qhMqSjqBrIbx/DRwqGA4Q2HpBYXIt5Lyz2R7m5DHllYNWbv5orfgPQ+e2m1n2xIGRYPE5cQGQKUDjwQGYNn7S/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEA/3VnD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71ec997ad06so1201863b3a.3;
        Mon, 21 Oct 2024 21:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729569762; x=1730174562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESpVDdqvWArJZ/zn9KV45HICoQoUKaqzB0C6fhXH0e8=;
        b=bEA/3VnDQ5rvJDVAQL48m+Ppd4UzMkiKHJ4I0FVWUXToaJfrtLv0riReq1rQo4maYy
         ZqRmahyQhIt59JzsX/5D9xi1TJ+LHjv1QsegwjbYQvhN0ZbK3Cix6Lzc4SeFy1ffD4Tw
         9ZEHvpYQIID0eSuHHklJcj7TBCWntkaoMX5xQjIdHIzMEtCZltkUkP+XsZnAc+kdOT8s
         InSGLmQkfuxcbFkO9NfCf9yLb2EF3ks2OI2gKytlVG/SFvPc8tEyy/0BRLz6bE+B3jnH
         SD1wa83utAL7CmABE/+4ZwjEp7y7n7ipX9kMG8UEeXj8IlHz6FoLCY1i6u2IZaFSYzyc
         CJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729569762; x=1730174562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESpVDdqvWArJZ/zn9KV45HICoQoUKaqzB0C6fhXH0e8=;
        b=MOgaAEAmzcbdAzinSb4FaPyCG7/PBEKQ3tgMOl2qxBB2UY6JQg4f+1T8sk/WwaLrWk
         wgTO/GplAyxDzk+NeR2jCtk5exLKo2c5/CdSiIODhS6iPVgydq4PZ8jr/+SaLgRmrgFn
         GGHRuGbd+/olBtf3IF3TjIRNJFaBjtFYAJGEEDK4oULXnLTEhxSKKSApLRtZxIN0Fuwg
         cvKOaJIGXZFuSq8ObR2QVJg/MF4rnxuF3VRWHp7XjxHitgFFx9T3PIF5dJj/OWSgtiQH
         KkuNimTUKUSnhgQJeGg80YKA7owx1Ck2UXfRfX1AbR0qh3x3b68SlX9mKqyluBYRqEcX
         4HwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2XOr4lJUrOjgYjVCy9aCICaw2zROehcure9Cn+0iq9QtgfbqweQvlSK/wsIhOfUV2PEmRGV9S4sNAAwKb@vger.kernel.org, AJvYcCXNY3SLZE51BrWkKj2mFkPmHcrqMnL1SXQEerfA8GNjGcgNYRg1VWw3Gi5p9FuC2fIbYC2wcY5dM1kt@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIdOyE7P26czltrN8NnFvN78bFV2RfxHWMuACQzZXthZEPfYh
	2fYmTr+PAg1io2DQKoIHxzBAa95OebiLU2KqH67IyrAa4roDllcuNyNwag==
X-Google-Smtp-Source: AGHT+IFpvbKAGMcBFfuBrPC9vCpoH+zVcNDvH81Wljcvo2dEo6JSn4vRv3yO5yMxJ/YDoSwbgcxnyw==
X-Received: by 2002:a05:6a00:9282:b0:71e:587d:f268 with SMTP id d2e1a72fcca58-71edbbc153bmr2884829b3a.4.1729569761875;
        Mon, 21 Oct 2024 21:02:41 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1338c80sm3718457b3a.48.2024.10.21.21.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 21:02:41 -0700 (PDT)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2044 ACLINT SSWI
Date: Tue, 22 Oct 2024 12:02:15 +0800
Message-ID: <20241022040218.450573-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022040218.450573-1-inochiama@gmail.com>
References: <20241022040218.450573-1-inochiama@gmail.com>
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


