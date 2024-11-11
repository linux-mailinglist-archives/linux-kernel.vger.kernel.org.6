Return-Path: <linux-kernel+bounces-403562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5839C373C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FCE1C2149B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D89414A0A4;
	Mon, 11 Nov 2024 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJZBb5h8"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69C2595;
	Mon, 11 Nov 2024 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297708; cv=none; b=qQARnP4TxRN0Nfbo6KqDIuelG+dffZ8lArhs0RtFHj8A06veBtQGy9jIJl2GSPlhTPmeaEeWSm6yvWRSOlLygTFO7kEQHYMXC5KF6YdLkdoCED44wcuUhpPIoH0cglgWYFGd3W3oG+qdB38fvIbv89nsB6w0mov5cDENtjIl0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297708; c=relaxed/simple;
	bh=B7rNC05z3ig3dMog4AogDbn2qu8s5SQA6WyErnTnIzo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XxY1w4tbx7zam4Gz3GNx+H0SpO0e1UsZLKAPxId8bFZBgs0WQ07fnGSCP1fq0Bbk10BVlP4BYdVhA8s/f2BT6ZCRjaccvEMcluZu83KkWXsOHkkBkrLzxDrWjaOhARs2xDEvSaGM4cJZyjnAiriKMlPCn1VkRJTE27YJOqqiaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJZBb5h8; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso2443976fac.1;
        Sun, 10 Nov 2024 20:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731297705; x=1731902505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyhBOJdbdb7U/MAw6LoCSVUFgTElIIRFybioC9VTZuM=;
        b=DJZBb5h8llu84Qa+25l/YMNUKTo5/FmHTlgwhT4OdKbzGD4X2scfLa2MHNMPabn/FQ
         OOLmsGE2ZImX1kT1CaAMQB1iMdR7KSHlJSGYG9mKAKaE3srNU+h1TfxkKPKNrr8X97gm
         BIfQqOLBPKvsiOOR5ZMJv1/RjYsxYtzUHO32AOyF0pBO8+/Y/zI2wRnXo2II8jJzxJ7S
         UVUq2WOaEBxJIBvx0/1gAh7gN/2U8QsFQiY2VT6cPlq0f4a5xzkFcrYIdzz84CWEHHhw
         +oFMVjPOWjoGGC3fmhUKhFcNoW86cqLCCR6amop67AbJ5xH1XoR4oefbkB8L0MkwU1x9
         y8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731297705; x=1731902505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyhBOJdbdb7U/MAw6LoCSVUFgTElIIRFybioC9VTZuM=;
        b=rQWLQmunQgdNe8x31qOsr9jNONYzI1kBwwP7EmUd7EnUDEABRTh7qw0klksICxt7XK
         jVdCVvk4A5bU0uRR6eUgN3WL76RUNJezmhBGFxCmSXaHSDKC/vW1i9shg7AaTSe8lg0M
         NZEDjtMoJTi6HU6vbdCsj5+eIS3ZXgh/htSfn/mkkE/aQZdDwHuMtTcDqSF9MqO/vgbL
         IEIWzogfeu9B3b4fxa8Js1BiU0HEpYXEOe6pesdz3CeWwKw8qqPQllSuLIpSp1da9tEu
         YzDpfu19AHFBXczJno/cNTKFOTgcm9laBqlh6gkzV7VPF+RRUa4WHMRLP2080MgOQfiz
         BJVA==
X-Forwarded-Encrypted: i=1; AJvYcCVdZrRUKnEllQ7AoEZjde27xmeMuJn4rkuhp2+GK1Tl0Hy7eEWVwTeB4kvlmv19V4Q5zN3OJKMTiA5J@vger.kernel.org, AJvYcCXuB0NDgNvTckkYxlXsvG8hLiE796LXrT0ZgnCA/qjlD/DDIPtoapZkjFogKr+Igl1Rm4hvIn3pRlN0U9DX@vger.kernel.org
X-Gm-Message-State: AOJu0YwdmpBFDPj1nioXKO+e7E6+xMTr+8lVJnSfo/9JZyFJMdYJnEjq
	n2IjmPiT53UQaHlDpjluEcIeSlcYvuuHmcY6mUfmopMxxoDjNB1h
X-Google-Smtp-Source: AGHT+IExdqCVvtfANRWv9lUO362sv1gaRUggc3/UVeXpal0yMHNBYIFFnDgdeYQf/09eHGl1kDf7cg==
X-Received: by 2002:a05:6871:7a9:b0:287:e3e1:15f2 with SMTP id 586e51a60fabf-295601585f1mr8943535fac.25.1731297705248;
        Sun, 10 Nov 2024 20:01:45 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546d0085csm2622580fac.22.2024.11.10.20.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:01:44 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI
Date: Mon, 11 Nov 2024 12:01:36 +0800
Message-Id: <5186bb9c7feebb87136eb5e5e117fb1142dba4c2.1731296803.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1731296803.git.unicorn_wang@outlook.com>
References: <cover.1731296803.git.unicorn_wang@outlook.com>
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
 .../sophgo,sg2042-msi.yaml                    | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
new file mode 100644
index 000000000000..9fe99b74c211
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
@@ -0,0 +1,78 @@
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
+  sophgo,msi-doorbell-addr:
+    description:
+      u64 value of the MSI doorbell address
+    $ref: /schemas/types.yaml#/definitions/uint64
+
+  sophgo,msi-base-vec:
+    description:
+      u32 value of the base of parent PLIC vector allocated
+      to MSI.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 64
+    maximum: 95
+
+  sophgo,msi-num-vecs:
+    description:
+      u32 value of the number of parent PLIC vectors allocated
+      to MSI.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+
+  msi-controller: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - msi-controller
+  - sophgo,msi-doorbell-addr
+  - sophgo,msi-base-vec
+  - sophgo,msi-num-vecs
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
+      sophgo,msi-doorbell-addr = <0x00000070 0x30010300>;
+      sophgo,msi-base-vec = <64>;
+      sophgo,msi-num-vecs = <32>;
+      interrupt-parent = <&plic>;
+    };
-- 
2.34.1


