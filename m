Return-Path: <linux-kernel+bounces-532850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC951A452EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CA919C28A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C721884B;
	Wed, 26 Feb 2025 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M54MdYpp"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FC216618;
	Wed, 26 Feb 2025 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536113; cv=none; b=eS7e4/1rjigsVvOYB8qz91WNhsb50PAK5DX/L1/ecRVnOEC+8eC1wU8EwHE/aOx52FNWDHchVLCN/hKDOJvK/chWziYHh85Te9zyOPDJdx8bPJuKtcp2O+lDdiVnrcVLcFmgQAG33oCB6+3WdQyhbselHpueIK33WxQQTls6guo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536113; c=relaxed/simple;
	bh=sWYsoy1AYKSOnbYc4dyUR2ZMRQ0Z/zhcfav6WfQD1cQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3z4qGO+uPV3rnlGOgQ3+n1xZGFm/snVsIUyciIoC+VyrMIQUYxrBunfS+zZhP0Vj+whDH+90Ie8Jy3oms/4hsZgvTtCCDLWVq7y2qDNDuk4iKAtciVJ5w/haOMipapnoMgKokwqk3rcJbO31ldRjt9XCcOHKnXmQwkENMYusmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M54MdYpp; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e10e6a1ceso1665928a34.0;
        Tue, 25 Feb 2025 18:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740536109; x=1741140909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSwGNN0SIOhmXf5jKWogh0gmEP1MjDJlYVwfiVZRhNw=;
        b=M54MdYppat5W58eXf6byUgZpabsJEo1uC+eAvDkos99BxbEavu3YfbbpFeR9QtnJrR
         aAFz0feGHpHeeytfbgmncceyl+sZZkI1goEO11jqCOGGBhjz1cjtH1gKpkyXETX3zdsd
         YZ36lEyFKPxw+qlMmfbHriXyxxE1K3l9q62evJw8BGlz+CHhe4Sa2oVRmw1R058iuzWO
         EZidOOcIXHw1/3ucTmbI44x3ENZVGNd5THT3toaYKDs4e1LcmCia1PfeYWmQztMXDGZx
         3hy1DdEiTUffEC6rOFplK4Ji4NR2S61WZlRktrq8ZCds2KZgi+YHroq9ZMu5yYzZEOK9
         xTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740536109; x=1741140909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSwGNN0SIOhmXf5jKWogh0gmEP1MjDJlYVwfiVZRhNw=;
        b=w77b3bdgB/17BlMfXhitHXZlnH067sdYLJsr+9WtkFYFHn40mxEdrcac9BV7O/OfrE
         5bDF2kylOF8BFW/4vHfl6wQOyC76JIh6KjanqWt/NA2OdjWrQ8ZvgLiBlLmV9MGM4jLd
         Tnz/URJrmfU5S0+6hJnjDzT7df3GVZ2Y+Z9s8Tsmqkn41gKBFVM/MbhHeIlQNA70iWxH
         pf5v5ZX5gKEqoUF0YTXtJhmkU3s0LUaFZZJm/Xv1TWnf8hMd0WwbscC6lmivYdCxbB1P
         xGv4S6T62k/J78XbkqQuZ21kClPd0EImnNk2geUal5L6foyQKj+OrHs8iLekCaW2+XaN
         XyMw==
X-Forwarded-Encrypted: i=1; AJvYcCXN3YOdTAS8/bpQWTZVokGonD94/AyMnnJLrFvKJDxCq79Mv+1N0+LitKy5bHpkN1sO6HwYhz3FzhyC@vger.kernel.org, AJvYcCXUpMdqaS4nwOuwr8gEAuAwWY2tDYba3aReBKlz8otyB3N8Ni8WhdtSi4qvKuSoKO5Z20iRfhNoVqZKH/0q@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqn5XdQ5Ew1I8EJ0B3mp3jQuZQphGacbDZGHHxD+ZTLern4KD/
	1yZ1CwcdfNnwZk4NB0/IgGlfGswpFEPCDymGGgbTUDJk0Sn5emdL
X-Gm-Gg: ASbGncs1rYSTfQjHAHuqpQaBzKhPLK3usrXozXfA69YJzkAyHaacI/ys6XdQoCE9V8z
	Hm8xu4BIzIZfAvYVgH3O5o1MAHfcaahAEHTnHAfCj6pklPR+80VyDPPH68kbmgdDZiHVELNU4mf
	TBVTdTg8Nj94Kcn5FHVwng6YCXpb6QM4Ww74slK9M2KdHSX7C136g0COpU2oKeciN7LqQKPXmak
	86S2KmerHIfCFX2yjyO3njp1wiipH2Ronxy9plsZuL3WDdEEjDCNhTHcxYfX5RGVvAw6GUPVpxG
	ccGp4u5BtFM5TuYDOfyya1mNzjFSkWrsI6vj
X-Google-Smtp-Source: AGHT+IHm1jbA3PRpFiPlRgdyJBzf/dyx+1/asA4Sg0xYUoO4ugWiSAPfuJPn+/X752gLUM1QYWGjFw==
X-Received: by 2002:a05:6830:6a90:b0:727:3380:66ce with SMTP id 46e09a7af769-7274c568347mr14173878a34.25.1740536109482;
        Tue, 25 Feb 2025 18:15:09 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289df4ec4fsm532272a34.46.2025.02.25.18.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:15:08 -0800 (PST)
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
Subject: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI
Date: Wed, 26 Feb 2025 10:15:01 +0800
Message-Id: <44de02977624be334ba6328acfdbb2a375f2071f.1740535748.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740535748.git.unicorn_wang@outlook.com>
References: <cover.1740535748.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add binding for Sophgo SG2042 MSI controller.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


