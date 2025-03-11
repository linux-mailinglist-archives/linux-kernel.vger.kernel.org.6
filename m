Return-Path: <linux-kernel+bounces-555594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC05A5BA00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755851895681
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3716622DFAD;
	Tue, 11 Mar 2025 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="XF90eSKT"
Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F0225A31;
	Tue, 11 Mar 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678549; cv=none; b=K/PMOOie8/WZxYnsuDW1D4uW7QtoUJ1Yuex+FYpnisdQR3Hu0gWcROjZH3oYVsGN/Ih2/U5C99lyICZ5X91ozPSNayRvr16IqGnGGHnkrpmnyoVFarIT6m/exyLblamGGA9cvyhh3O2NHplTW3yTTWO4mHjb+XjwU99NvJUFa6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678549; c=relaxed/simple;
	bh=qeUqFJ/XMVvzusQ5Xy9z1HmZ0fH2eXJgXXxVlj4pokU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+TKHyaDxqr9Kfv7eAdlftJIpDGKAjnlOC58JtEZN8ac9jbW0sQHGuVbY9PWOgjH8tdvUAB/QxyGgOLRcuLk8Pn5SksMFd9GT9YD7hlVaSDFFEa3I6cuRF7ASsNtMQnUk3CA71Biruz+ZfcuV2KcpdLvGEL0OCls8FvXGy6hUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=XF90eSKT; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=2010; q=dns/txt;
  s=NAESA-Selector1; t=1741678548; x=1773214548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qeUqFJ/XMVvzusQ5Xy9z1HmZ0fH2eXJgXXxVlj4pokU=;
  b=XF90eSKTB1TUCF+Fsa4ttuNfdx1CPNfA3jAqPW58L2tLyLUJJWSEFni7
   zfnDu1IOxPFsi3pGt+AAisxYY+nwm1QQKmYHaKuRGa9qzixD9rxU6NjVr
   cjFllmTigYUruKCTVx6hmT/HG5ey962mbndBpfR58rz0XIqBPxEQRAW0a
   zcMzxh+EEFy4ePOOoZW0Z6W/InOO0QMnh/BTPBQ6FCFyECxQmZvfxdNdA
   LsLn5nUAdrdaUAaX93a3XEbjwjI5dIsb9I2rIakQNY98lo3PsJThwqqem
   u9ggWWZ/I2GrCRu5Jm1O+okhzhyh7HVZM8X9x4ERGj8Pp3bOZgQkFxAQf
   A==;
X-CSE-ConnectionGUID: Sn7f/E7eSle+Eb1bclP7rA==
X-CSE-MsgGUID: xZlukMyvSXWajlo+0qlbLA==
X-IronPort-AV: E=Sophos;i="6.14,238,1736838000"; 
   d="scan'208";a="20386384"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 11 Mar 2025 01:34:39 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Tue, 11 Mar 2025 13:04:32 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl,
	Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] dt-bindings: riscv: Add SiFive HiFive Premier P550 board
Date: Tue, 11 Mar 2025 13:04:26 +0530
Message-Id: <20250311073432.4068512-5-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Mar 2025 07:34:32.0906 (UTC) FILETIME=[082632A0:01DB9258]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add DT binding documentation for the ESWIN EIC7700 SoC and
HiFive Premier P550 Board

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 .../devicetree/bindings/riscv/eswin.yaml      | 29 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/eswin.yaml

diff --git a/Documentation/devicetree/bindings/riscv/eswin.yaml b/Documentation/devicetree/bindings/riscv/eswin.yaml
new file mode 100644
index 000000000000..c603c45eef22
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/eswin.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/eswin.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESWIN SoC-based boards
+
+maintainers:
+  - Min Lin <linmin@eswincomputing.com>
+  - Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
+  - Pritesh Patel <pritesh.patel@einfochips.com>
+
+description:
+  ESWIN SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sifive,hifive-premier-p550
+          - const: eswin,eic7700
+
+additionalProperties: true
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..901d0e0adb25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8572,6 +8572,12 @@ L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	drivers/net/can/usb/esd_usb.c
 
+ESWIN DEVICETREES
+M:	Min Lin <linmin@eswincomputing.com>
+M:	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
+M:	Pritesh Patel <pritesh.patel@einfochips.com>
+S:	Maintained
+
 ET131X NETWORK DRIVER
 M:	Mark Einon <mark.einon@gmail.com>
 S:	Odd Fixes
-- 
2.25.1


