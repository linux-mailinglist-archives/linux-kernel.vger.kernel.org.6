Return-Path: <linux-kernel+bounces-203845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455128FE123
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94391F22D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0936413E3EA;
	Thu,  6 Jun 2024 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeP3/fd2"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B776613A418;
	Thu,  6 Jun 2024 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663015; cv=none; b=ucTxQwLLv9ZbZ4L9CDiU5TS51zg7h3of+dYY9PqCgnw6LqEWTTFKMx8NKejPTwE8+4kWtfs20gs5r6TYPEk/wxUyvKiJnXtM/lHZr1Tvc9lEuERLcO3VQ46dbj/RGV24jlla0MBmbz/Su+Mmv0SLeUsv5QdVNqEDFI9lx33eH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663015; c=relaxed/simple;
	bh=1qkXhGuDwQbkduummPFAe8udiVcUZ0MifdSnhOYj6io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUNnFb3+3a9iWCf8o7RPrHfvL2GuJqoZ+gEnPJPhv3mzEE/GDpNCCoRmrcqKLjD4fd78E10oNDgt+fnzWjGyOcfQJy8/ik5CHHNJFdyhXScfar84GkKSAodUiGISqNNFDg7N1pFl6O4WCzBVICXGC2k7vTyPGWJ6q9mpn5BZYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeP3/fd2; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso285029eaf.0;
        Thu, 06 Jun 2024 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717663013; x=1718267813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgmkF5ExFKBr8taCn+NKyhoAczSfK0mT7IU3apetrZA=;
        b=AeP3/fd2nTicF2e9VBBS9wwikSJn/uoDRiKxgOaoUhA9UWGuSN9tGJd9PnEVuWDuPF
         zojoamo6Yy61zF+HhY9tkCEdzgTWH5QPsG5Rzr/D6YwocLh6+4DbUvx3MFI38vd4lKZx
         XTGIc/+g6s1TockJ4raCYcJykSloPqi/3ltaOZX1jGCGdbh3W+I/8Y3AMQRnNoGhXzxd
         oslvdf/MNne8b+rj/1vLdtY1lfDLkZ1ttA879/whp3Vic1OR2fn/PQwf8UBK/5ZydtrM
         EiRzhg1TnnBTQa+BwJKWvv7423C5QkQXNa+bbvixFXLT5oYw8gJA6/XlZ5npLsJCx/Xo
         zkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663013; x=1718267813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgmkF5ExFKBr8taCn+NKyhoAczSfK0mT7IU3apetrZA=;
        b=jVs+mh8D2qoDzMktcE9/PYa5YGTcP3fv9szbzqNOVE5Z7yKyal3o7U8ZBwDmBkpjfT
         QSfKSUXwaT6/PQhEOWzHdIhB7Et2pYxMWTvdBX6OD3XIkjhgeijGq7bchcPVEvonE6nv
         2z8lA2EkjPefzuT3GYU8nX4sh2qAOJfkwYgpUcc9YwcSFp9jAwT7QBA4EyiX1NVgBiyF
         yFT/+QPPY7DYxRqVw7CZ1KOr7zXBwvFMKnq8ujaL31yweG/Gm0CvVn36DdGXOiqDkKk+
         HgLvJNDqeP3RP6TOBkubKsiEFc2rXmJbXxnn8MbbWvwj8oIlnkd+sk7M821Ct63dXof3
         js9g==
X-Forwarded-Encrypted: i=1; AJvYcCVRYeszYo88yPlRy0F/BN27DIb7aA7gpc3LLxT8hI8IYF++sxv0X8HPZF48bwtWXTuVaEJRE779V+Smk4Xgr63i6W8W+mcsAs0VRFVc3m5gWZufg4mimW8Kzbeu7SuF63qO84J68/I5YggVq2khZrApi4HItmzIyQ3AjEg/J7lY0arNhw==
X-Gm-Message-State: AOJu0Yz2ylDvDyHqVnPFIWBKNWA49n1SJYAQUFtyxs8yoXqsKSQJEThF
	1BVyvKaxkhWDZHos7xqHXIDmLFCwBDekHyleO0uNudpTwcT1BSXF
X-Google-Smtp-Source: AGHT+IHallguT4PxyrQghFBfZ/+SXZtizB4Ap4bngp9OJIMgVqGsUq9nh+G5gQuGKEr1ALmSMhImPg==
X-Received: by 2002:a05:6820:1504:b0:5ba:3f33:d59d with SMTP id 006d021491bc7-5ba790f3770mr5185187eaf.9.1717663012529;
        Thu, 06 Jun 2024 01:36:52 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b49a7sm178995eaf.18.2024.06.06.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:36:52 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v16 2/5] dt-bindings: clock: sophgo: add RP gate clocks for SG2042
Date: Thu,  6 Jun 2024 16:36:44 +0800
Message-Id: <8f096a8a763605973719d7d194c00f919634ea2d.1717661798.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717661798.git.unicorn_wang@outlook.com>
References: <cover.1717661798.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the gate clocks of RP subsystem for Sophgo SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 49 ++++++++++++++++
 .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
new file mode 100644
index 000000000000..1491fb8ef6a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-rpgate.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 Gate Clock Generator for RP(riscv processors) subsystem
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-rpgate
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Gate clock for RP subsystem
+
+  clock-names:
+    items:
+      - const: rpgate
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-rpgate.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@20000000 {
+      compatible = "sophgo,sg2042-rpgate";
+      reg = <0x20000000 0x10000>;
+      clocks = <&clkgen 85>;
+      clock-names = "rpgate";
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-rpgate.h b/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
new file mode 100644
index 000000000000..8b4522d5f559
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-rpgate.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__
+#define __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__
+
+#define GATE_CLK_RXU0			0
+#define GATE_CLK_RXU1			1
+#define GATE_CLK_RXU2			2
+#define GATE_CLK_RXU3			3
+#define GATE_CLK_RXU4			4
+#define GATE_CLK_RXU5			5
+#define GATE_CLK_RXU6			6
+#define GATE_CLK_RXU7			7
+#define GATE_CLK_RXU8			8
+#define GATE_CLK_RXU9			9
+#define GATE_CLK_RXU10			10
+#define GATE_CLK_RXU11			11
+#define GATE_CLK_RXU12			12
+#define GATE_CLK_RXU13			13
+#define GATE_CLK_RXU14			14
+#define GATE_CLK_RXU15			15
+#define GATE_CLK_RXU16			16
+#define GATE_CLK_RXU17			17
+#define GATE_CLK_RXU18			18
+#define GATE_CLK_RXU19			19
+#define GATE_CLK_RXU20			20
+#define GATE_CLK_RXU21			21
+#define GATE_CLK_RXU22			22
+#define GATE_CLK_RXU23			23
+#define GATE_CLK_RXU24			24
+#define GATE_CLK_RXU25			25
+#define GATE_CLK_RXU26			26
+#define GATE_CLK_RXU27			27
+#define GATE_CLK_RXU28			28
+#define GATE_CLK_RXU29			29
+#define GATE_CLK_RXU30			30
+#define GATE_CLK_RXU31			31
+#define GATE_CLK_MP0			32
+#define GATE_CLK_MP1			33
+#define GATE_CLK_MP2			34
+#define GATE_CLK_MP3			35
+#define GATE_CLK_MP4			36
+#define GATE_CLK_MP5			37
+#define GATE_CLK_MP6			38
+#define GATE_CLK_MP7			39
+#define GATE_CLK_MP8			40
+#define GATE_CLK_MP9			41
+#define GATE_CLK_MP10			42
+#define GATE_CLK_MP11			43
+#define GATE_CLK_MP12			44
+#define GATE_CLK_MP13			45
+#define GATE_CLK_MP14			46
+#define GATE_CLK_MP15			47
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2042_RPGATE_H__ */
-- 
2.25.1


