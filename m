Return-Path: <linux-kernel+bounces-447028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA69F2C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B1E1889857
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F420101F;
	Mon, 16 Dec 2024 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ESGcP4dJ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31D20101E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338934; cv=none; b=GlxUgYwCupTTSs8Ru/1K3V4zm2BN1H7Urpu9XdHzUzA1MgbebJZG/tgbA/uJCl+TNgkVMEKoYx4kubFkNmJ6WM65zC/J03qY+qJRGndeayT2Ct9HHJd3AdsNAmXm+/i4cdEuHLCk3ZitusJHQ2kRls880xfV6vT5k2HHAHCfhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338934; c=relaxed/simple;
	bh=QiMGpDjHJVbEJ7WtU+aAmU5WmhVGH1iQ/fXC0sMtGgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxiTfntPsYuCv9xJX0VTR40hu0/LrzCD/EFZeldu57Y2dHYnM+5kGMtWhI4GphIuV630ME0lsJLn8+cL1XTqEhLWoYZ/dUzJdoVtgTsix4WmyYeeIGgJc8uj+Jx+uD1PRAV7LeIC5HfMnHde79YzRDd4heW5+eQq+g29xbnqfUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ESGcP4dJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2156e078563so28460045ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734338931; x=1734943731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssg9a8o6gZjpZvchZzGUt0Qt044T+B0HdxLRYjAYuuA=;
        b=ESGcP4dJXv3ZI0kvKH/rncqICV+ot2WKiFJBT+t+y/HmIcp//K2MPOdIZvz+IjDkH9
         nPx6L7Xx6lFMTx3k58DOwfhDu5ib17GRZ+6wj5sJZYybRmC4Upmt8sGIBucwjkQi94rO
         rbuTRKL/XRkHhMPkIzK3wLJQamMISdZteztPjWci1l9TegAk4cGYIYFm1wa5PcfDST0l
         XkOej55cTgV3lLiZbd8H6VZPCOKH9F0cxDAokgiPhmm8g1wTtbR4biv2V4QSC5hxwpza
         QcG7PBycoL6Y+tJ5IIZz9fFhYbtYkbrK2RN5osqwOqDt9yJ+IYCoaCY9lLjzs4uZzwRI
         xN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338931; x=1734943731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssg9a8o6gZjpZvchZzGUt0Qt044T+B0HdxLRYjAYuuA=;
        b=RpKowARq8+BBtoviFiaUdev1bRvnTo8tQgMa7tQlyrKUwzUp0l2f3/P80uxFpQfwz2
         P0JUxHknmOcEXxEltisuwB0z0SMO3rhSHIiPgwN4xGh478crdQs6Yl6zjQLtR7JKE472
         LS5RFhd3ee8IEfxmWynJ3mjsX5ihVK63Cm3ZDbuZi/2+zIyj0XZwrDUtJRUbqbSGzhdM
         eR1sdcJdH/eD3zBSu5/KD1uU93F8AcwduSAcOul9drz49gnwKJH+qXzncoD4uSQ7z2R4
         raaBpj9PZR8rZILgrOiP+CoiKK8E884vH3qn5Unj61oeFImW90GifWdVueT3kIIRwpSD
         wfuw==
X-Forwarded-Encrypted: i=1; AJvYcCV/8/oR99+PY+/7EmMfnk3JUVAszeKxvhfcfn+lbRoK5zYaQTsvPz3qqjRcrIzjsf4HY+iVnzH3gzHg+ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4F3Hgdl+WzRxohW6V+smG8vFuWyysxca3jcp0AcNUwWHPkk/J
	BSHpWg2jSZoEkQKdIgFw6wIVHdEgFVvbygGsGBox553GWogkEDvwPMfBB9A6vUM=
X-Gm-Gg: ASbGncvMulU4f/h2KfaJtnAe4epuRhTZ/xAfxGbAol51xTdJsURt16eOpDZl13IkWlc
	YalTRD6ihVLPaHv5dVTgpoz7NQtpcAm7XDxeJVJkF+GnveolJuwHQHnnwKMJj+jNkiSa12LWsA7
	Rhj6RZmvAVFut0DGnJYoNTS0v49Ku58EFA+/4tcJZTzQzDFaIEJpVrdSgywUCMh3wQMBpO2Aqic
	RlTzV/q6RSgma8kdlOw+q3diAtWk+j9RkWf9xhFvaKw0MeslzgyfwULTq90elbUxiduxfR0Mwal
	8yJiRfPWXZh72l0=
X-Google-Smtp-Source: AGHT+IEjkG82UTaLNxVZ0a1jk6JfxX7g2yNmmqLUOhK1uOCG12kx8FsqZmcvvvLQulkpsVPnYWSQaw==
X-Received: by 2002:a17:902:ec89:b0:216:770e:f46 with SMTP id d9443c01a7336-21892a74611mr174024415ad.54.1734338930854;
        Mon, 16 Dec 2024 00:48:50 -0800 (PST)
Received: from localhost.localdomain ([223.185.130.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e501d0sm37711495ad.116.2024.12.16.00.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:48:50 -0800 (PST)
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
Subject: [RFC PATCH 3/8] dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
Date: Mon, 16 Dec 2024 14:18:12 +0530
Message-ID: <20241216084817.373131-4-apatel@ventanamicro.com>
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

Add device tree bindings for the RISC-V SBI Message Proxy (MPXY)
extension as a mailbox controller.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml b/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
new file mode 100644
index 000000000000..8a05e089b710
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V SBI Message Proxy (MPXY) extension based mailbox
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V SBI Message Proxy (MPXY) extension [1] allows supervisor
+  software to send messages through the SBI implementation (M-mode
+  firmware or HS-mode hypervisor). The underlying message protocol
+  and message format used by the supervisor software could be some
+  other standard protocol compatible with the SBI MPXY extension
+  (such as RISC-V Platform Management Interface (RPMI) [2]).
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Supervisor Binary Interface (SBI)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+  [2] RISC-V Platform Management Interface (RPMI)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+properties:
+  $nodename:
+    const: sbi-mpxy-mbox
+
+  compatible:
+    const: riscv,sbi-mpxy-mbox
+
+  "#mbox-cells":
+    const: 2
+    description:
+      The first cell specifies channel_id of the SBI MPXY channel,
+      the second cell specifies MSG_PROT_ID of the SBI MPXY channel
+
+required:
+  - compatible
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    sbi-mpxy-mbox {
+          compatible = "riscv,sbi-mpxy-mbox";
+          #mbox-cells = <2>;
+    };
-- 
2.43.0


