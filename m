Return-Path: <linux-kernel+bounces-447032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9B9F2C48
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5D7167584
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD391202C40;
	Mon, 16 Dec 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VXEkZRrc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94799200B99
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338955; cv=none; b=qUTlOzwIy/Dj3RUm5tXziJuLp8IsnkSCAdxcrRGFpBHyoKXUs2Y1LaWSJIB3QI3prWlHSPbsz1EOtmBxVrf5F/P1R8R6BuFBIzzJfw5ymMrRm0bOgzIB3AJg3UqisSKiLAG+q9jlBoyGeB99TB34VMSKUgJ8Vqh9fycAuToAhYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338955; c=relaxed/simple;
	bh=9KAfNFXRr4/c7x9cdy5cq58RiwlnEO0rVAtxnjEBwcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5a3hSH9EcdN3L4vix0eWGBEjPcn3PxmVDFTm/q79L+hH6qhqQMwhqepZKTjkWMVU7ElmNcc7+vopvH1QWgeNycOyeLzutYN1yVucqOwv8Tl1xi90ahEEShJ0ralBWATvLwIV5/1Y+8CAt4gydn5WnbA7ZnGo2XQHUZGLxk4tww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VXEkZRrc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21649a7bcdcso34973975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734338953; x=1734943753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTD9xjQhkwZ+fm306dP2P3Gi4nTgLSlKokzAF6+8eeg=;
        b=VXEkZRrcA6Vk6vvyxlSw7CtRP7ACofA1vdIS59c9E8a0pmnf7yK0DxjV3MOcYkaSJL
         TibRvET79nrzSXe/bK4xq+Sb7skQWeeIvRdeqkIaY8Fv2ux4LIVVGNzwM7vMDQhqePYs
         YSY/q57WSF068ojxPjxboCClwQnnGwzlCFBhkuGgF0MBeDqODSK49Zua+iqMIMTxB2Hi
         7jy6POQZ1j6pLRJ3hwq4m0vn0VGVAXYw0V+76l6iLt0U3ilX8M4m8+ASkF5u2wAJGTdv
         an2HQ5CTl/xHgcrOMuNT291gyGAR7QNHRDJpTo4bbfYKcXAtPQTbuxOIm1w6j23qq/AV
         B4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338953; x=1734943753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTD9xjQhkwZ+fm306dP2P3Gi4nTgLSlKokzAF6+8eeg=;
        b=L3kyx/ekdJeVnX7VORp5adFKpAM/wQH1vgE91by1mCvA2WTGJgUCvNvk8/hbnP1XmX
         4Jc+rCOCl83p10UajQl5WQnvIHodxIZ7fPDpsYs1NtEhJ7Hsox3HwkP6mDDTj/AKU3yn
         eo1+TQodK7qzmj1WM36bvWONr21TZw5ctqu2WVZIug3PelpkQcV1jEDbKp+Yq9YCi/iV
         FuRAErG0MoNRGsqfTF/1NTYUiVtf/vnBpoRHutW4yMWK3wnunC5S5QSn8ULX1Z5ZfnJK
         VGXU/C+e1/bl9/Tzoc1WOmfIcIuQebpTxrhC2r5YvXR+wnHqQVNIgLmF5jo0SxE5CboG
         52Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWYCQGrpZUSyfQ093amphSvdMB7g3sho2FhA/yHrJ92nC6HMMmNwupvRwUvFIJXCJrO31/sP3sRXF1JEsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE9hJHl7+3xNOGWQJKEA7Rzho7Mj9899tzZOSror16pFIVMYOD
	t/OMTp/RfroRhOpvJagaZ3lmqE0+6Qjm4kqPE3v3DdF7OlPYnLpu39S+9j6ul3E=
X-Gm-Gg: ASbGncux7qSzvolBg/WIRKiXKsl3qZ8rCos/Sb/fGVDPIuraxlfylUvOJ2OIZ7qyqp6
	/+lbIbU389b02YVZT5n93JTLVWI08lNPXSafU/Eg0hRFcGrfmejKvdvL6lL0ddYC2fZLswS5IAe
	fDm1JKkuw+eooKtJHFOsTSan1JAwCR+MfHO3WbxC0zIn8VXPDbsxgDv/k3gtbBzyBF5XTZd4SoK
	3xmZ72n3EnVFLaMJ2WwclAavk0zUgMveXaZk1jE+BO++KynKGC7116pt6TZVAJz2NxNo7RhJaO1
	OkvwBv9xjhWNbtc=
X-Google-Smtp-Source: AGHT+IFZAXk9i2QTSa1ARsAF//7P/a/eyeUKUtrq2KyDoH6hHl6V/6vbY1bhBC88LnxU0+wlfpf9Tg==
X-Received: by 2002:a17:902:db0f:b0:212:fa3:f627 with SMTP id d9443c01a7336-218929b78admr165235345ad.16.1734338952799;
        Mon, 16 Dec 2024 00:49:12 -0800 (PST)
Received: from localhost.localdomain ([223.185.130.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e501d0sm37711495ad.116.2024.12.16.00.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:49:12 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [RFC PATCH 7/8] dt-bindings: clock: Add bindings for RISC-V RPMI clock service group
Date: Mon, 16 Dec 2024 14:18:16 +0530
Message-ID: <20241216084817.373131-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216084817.373131-1-apatel@ventanamicro.com>
References: <20241216084817.373131-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the clock service group defined by the
RISC-V platform management interface (RPMI) specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/clock/riscv,rpmi-clock.yaml      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml b/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
new file mode 100644
index 000000000000..9dd98e390708
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/riscv,rpmi-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI clock service group based clock controller
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a
+  messaging protocol which is modular and extensible. The supervisor
+  software can send/receive RPMI messages via SBI MPXY extension [2]
+  or some dedicated supervisor-mode RPMI transport.
+
+  The RPMI specification [1] defines clock service group for accessing
+  system clocks managed by a platform microcontroller.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+  [2] RISC-V Supervisor Binary Interface (SBI)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          Intended for use by the SBI implementation in machine mode or
+          software in supervisor mode.
+        const: riscv,rpmi-clock
+
+      - description:
+          Intended for use by the SBI implementation in machine mode.
+        const: riscv,rpmi-mpxy-clock
+
+  mboxes:
+    minItems: 1
+    maxItems: 1
+    description: |
+      Mailbox channel of the underlying RPMI transport or SBI message proxy.
+
+  riscv,sbi-mpxy-channel-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SBI MPXY channel id to be used for providing RPMI access to
+      the supervisor software. This property is mandatory when using
+      riscv,rpmi-mpxy-clock compatible string.
+
+  "#clock-cells":
+    const: 1
+    description:
+      This property is mandatory when using riscv,rpmi-clock compatible string.
+
+required:
+  - compatible
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    mpxy_mbox: sbi-mpxy-mbox {
+          compatible = "riscv,sbi-mpxy-mbox";
+          #mbox-cells = <2>;
+    };
+    rpmi-clk {
+        compatible = "riscv,rpmi-clock";
+        mboxes = <&mpxy_mbox 0x1000 0x0>;
+        #clock-cells = <1>;
+    };
+...
-- 
2.43.0


