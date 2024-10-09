Return-Path: <linux-kernel+bounces-357972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4F69978A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59510B22ABF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671D1E3DD5;
	Wed,  9 Oct 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3sYvsnd"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88915D5D9;
	Wed,  9 Oct 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513879; cv=none; b=sef7fIs8r9kaPEsQ2IbR3yGPhoV3jj7I57ZOFSNWKPW+2s5JUrUngY97Rz9+0k6xBFOieoCPq4xIvoMfWfhD8Gr8w1LdBMYigKNh+ksUysc1OhVFGtCs8dA/9/e315SG8x7d3z6guad5iZoo3OUPp1Q4FSFFUTAJx92iayCxwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513879; c=relaxed/simple;
	bh=gcle2kdS3BWSkQLXu20Bgu7PwfvPpeFMKvX5BbdgdLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYPMOiwpC2ghRvvZvaIWvihOD4P2O5ByKdGSwfRW7TQQabq8iSP1taHz9G7ko8LAjBC9ym0X2kkVJtQzZKdHyIJXqZZ2NrFiaGLV92ejQ9nG3Vn1kADTPEuAMMnPcAEaTFcxEZwZGSVv8hW80Q2PGfFTXbqDylhEB7HVHFTfO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3sYvsnd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c70abba48so1667165ad.0;
        Wed, 09 Oct 2024 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728513877; x=1729118677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm4CsYMN2YsRkev2KFCV0kWlKGRxeTSpqxFYXStuCkY=;
        b=b3sYvsnd9ZAXFX3ahk3p6ExUdCTW+HruE6/2Z8M20fjElkNyRmyYjy5rxrevKwlM/K
         pYC8GfbJ4Glgm62yd8JGomc7gC2SXdRAgV74zc5q+FOZ9cq5hUmOXZFZmWKVe87zvbns
         rx305qn5PAVlKQRRUURbXDWNDc+UQVRlZdmDNRjIx0askvCja7w18m+cN1Wcedc5EQpA
         Hxtx9PgM66U70pthG2eWoh3WjSsBAj7nEWq7bEvY6Y9TtZLQ6srdkU7TaRw3hwB0GdvF
         RSTpc8/HSV7jr4ChXs+38d/3c8guFcNhM+34MgDy5t4O/1xKS5LZn3IBsbg1PI0mGIFW
         qfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728513877; x=1729118677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm4CsYMN2YsRkev2KFCV0kWlKGRxeTSpqxFYXStuCkY=;
        b=lgGI6jpW0WaXoze10WYO4gGdF148H7nMPB8ayMwJIAvO0ucOPcdGrsA235c8gTGWLh
         pAFnnLBr9/8s3PxiXjD3mjeoad57huIBqOqTqSn7MM0FWEvEVmo5AawlFNRV2QbFH72s
         julS4KVGl25Ko7vLiBtqkoZ2/TtPe75fzUfVs0sV6c0mJkCrSwYz3CdOCdnFvLiFRooi
         JmLKDe873hAEaDpmrb1H6sWFNUahXwJwW2tapCHLYvj+dZAX6hP0GYOU3eDPnRc5Tnub
         +n06TEf5rpORCf282GY1Upy8/vuYPHGsAilMDeucOQ/W+POOWGExP+0LY3gkT+KKJhf4
         RukQ==
X-Forwarded-Encrypted: i=1; AJvYcCVufpgBS3ob94bH0ZZITfFbj1yrDdv5k5beJAtVP5CWdbWT6KV0rvgo1Va3EDZ8ON3ahgHJgri9c/KEnadf@vger.kernel.org, AJvYcCWdPAdDNcQQ79ye5q/iyiPpdOX2NG2TDFmy5Ug0Eys3P0cpz7RCWUCmWMQq4dr3ZEUYNDRHQVMv2/df@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhoRhNFZDEpgp39MEmISUoAy18LYRIpixGhU+Hdj2sfWN1zaG
	JwmjD3LprP4YA92annBEsKidURU3knFYW1Pl9IB3YrgCFgkv0zn8
X-Google-Smtp-Source: AGHT+IEKuoY00MBONYoYEZvNUwHwFgGZe++kurc8BivmtPoW128dTz3seqWpdUhyU5wFto11gZmpkA==
X-Received: by 2002:a17:903:189:b0:20b:b0c1:712b with SMTP id d9443c01a7336-20c63726b02mr69101965ad.15.1728513877101;
        Wed, 09 Oct 2024 15:44:37 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393107asm75591135ad.156.2024.10.09.15.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:44:36 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2044 ACLINT SSWI
Date: Thu, 10 Oct 2024 06:44:07 +0800
Message-ID: <20241009224410.53188-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009224410.53188-1-inochiama@gmail.com>
References: <20241009224410.53188-1-inochiama@gmail.com>
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
2.47.0


