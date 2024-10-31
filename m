Return-Path: <linux-kernel+bounces-389998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC319B744E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0679284455
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB29145B0C;
	Thu, 31 Oct 2024 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl0Cxjz5"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AFB13DDA7;
	Thu, 31 Oct 2024 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354975; cv=none; b=sXPbMn/w8yiJ7E37qzy4nl2sD/z0vKK9h1D9VJZ5tCeUhYgDBQbYq4saZ6+93cNtYm8qcksOTLg8lvPo9vwBOqjrzBATORkvyzf+yRhX0b3GCD7395FpOJWlty9sa3AlRy6C3fzxVJptUJrxlG2o6Fql/Y/gB366eMEDentRA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354975; c=relaxed/simple;
	bh=yEaPe5+zBJKHNj1cJxHgERtG+/xoMeGrDSaxjIaQrts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJD7fz8ll0YvEjd/wz5Afs46ShT6RSrKocrTy+h2/uqkSkxSkXbJL+w74TyC2UB41SZXA7FSYOvs5wCo/VAp19We4VGQKwKdzSWLzF0rBYanlte06gx1ThccDd3dGU4+iU2sktEOtN6tU/UzcAbJoGcL6AXsfhtkH0JGIU7a8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl0Cxjz5; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7180ab89c58so271397a34.1;
        Wed, 30 Oct 2024 23:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730354972; x=1730959772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc02FLxhfy5Xf8qTwvd6Nubgfo1jmCVxaCk2RIUB6RU=;
        b=Tl0Cxjz5HyicOzWjwuWN3W179D/VjgQGev4TlDwubORImAUDN+Ds7Zc+TE8MqDwZPK
         36f1tpemzQen75dWGh5ndU/37Dsm5ecr1bQrF8x4f3ybLkxB8DDm5sYtoYnsxyZyaDNz
         zL1FmSaGtdKnx611PPFuN5DLjdHLaz3a2aMhc3UmDOuiWJP2PWJ3K/nIVRSdsHK2hy3l
         Gb44fKaqcEmaeXUzXtiGXzrct1VkoMGpN4/E1jY99Cd0YMVNIzshDHIs+MZ1Z042Oz7C
         vGBfc7QWmKJoUDyufmikZTRaOWlNsfXdWSRzRbavOLh4KJyxj987GZSJXb0kv3jdPhPA
         MQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730354972; x=1730959772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zc02FLxhfy5Xf8qTwvd6Nubgfo1jmCVxaCk2RIUB6RU=;
        b=rgZ2dP9Jqanb3nNpUF4a9UGrnlDzRm8jXZ40EmqUwiF/ZwLi34ZbgqI3V6EQsjvF+v
         7jk5dUJdrGflI4u0fw7zAtYXsVf72DArM+QD+PfcQICNjpp8m0Gq0e4icyPyQuFIMH+f
         m5hBuLRnCpnL7WHdq5jlUjVctibi1EBhR44cl/hxwK+ByTBG48Q0ST0Q0g74o4SzGzCU
         yIZQKfgICl2Z+ssm8AxeYBADerxBlzbpPd8B1efESkDFlkekBMmQiTCBC8LqUxLFbRM5
         +zTR5NbcpC1lSgpyedn9UIszprP0hWp1SrRf+YyoVVKDCwwFwlyz6tenP3jPy676vjOc
         3Tjw==
X-Forwarded-Encrypted: i=1; AJvYcCUJE4JeK3b2msXcOYOR39Oi0pYvO+aibT5ONroCvlcmGdzNYbjacpcmrly/hKxC/rm1EDFTL0JFMv8s8S3M@vger.kernel.org, AJvYcCUpQHMGiqnQ/o2m479WH7/CBJdVbBEOhA96fta9yt+l3lYNm3ZTMak2VNWITTF23aQDXhSNgjnXuQKK@vger.kernel.org
X-Gm-Message-State: AOJu0YzccQgYEDJdOjkKr6/PdJMrW+t6AJDx5gng4V5L5bNG052E0AK/
	s7vLBpMesqCwAZvsuFW1B5J/lN61elRoQz4/3B42Z+yWZ2dQdz8o4nflNw==
X-Google-Smtp-Source: AGHT+IHmQUwN5TmL28+PKCqGNDrUt7hwzuLbah0KAI2f5gIPh+ZYAz6Cypl98SuyGh7fKujgz8DCMA==
X-Received: by 2002:a05:6830:6015:b0:717:fe2d:a4e4 with SMTP id 46e09a7af769-7189b4f40e0mr2421240a34.19.1730354971846;
        Wed, 30 Oct 2024 23:09:31 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459fdee2sm491505a12.58.2024.10.30.23.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:09:31 -0700 (PDT)
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
	Yangyu Chen <cyy@cyyself.name>,
	Anup Patel <apatel@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2044 ACLINT SSWI
Date: Thu, 31 Oct 2024 14:08:57 +0800
Message-ID: <20241031060859.722258-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031060859.722258-1-inochiama@gmail.com>
References: <20241031060859.722258-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sophgo SG2044 has a new version of T-HEAD C920, which implement
a fully featured T-HEAD ACLINT device. This ACLINT device contains
a SSWI device to support fast S-mode IPI.

Add necessary compatible string for the T-HEAD ACLINT sswi device.

Link: https://www.xrvm.com/product/xuantie/C920
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../thead,c900-aclint-sswi.yaml               | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
new file mode 100644
index 000000000000..64559ddc931a
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
+  The SSWI device is a part of the THEAD ACLINT device. It provides
+  supervisor-level IPI functionality for a set of HARTs on a THEAD
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


