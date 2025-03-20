Return-Path: <linux-kernel+bounces-569540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE0A6A44D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D507B279F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BDD226D07;
	Thu, 20 Mar 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="FfLsEbwr"
Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FFD22541B;
	Thu, 20 Mar 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468165; cv=none; b=Ip6QtxqUld/mwFvxgBSE01uU88W+1jopZTi49fHhHe6z7LM9+1RruuSa77vv6p3C7ZFdc3FdYtpo9A/aUmmchfAoeuduS6xs4hZsGM3oDSrmNw5rQMXoRAf6bQ3YPaj9trehziyw7xgHxdC2ObApVq3vaW7/Lu+YQuxLM6/cbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468165; c=relaxed/simple;
	bh=eS3MaGonIoU9nAIFGQh9EPnwWnxVAYDNEq2SAR0mRpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fcxuRj2sAIozOjUzvUVuoiF/nbDOCsBjHDbTMcb1ODQuQlsO1eD9HjXeP59VKjTsP2QJleYzK1nI7hneMCTC4ycPHWkF9yfCxyblmxxTiU/Mq5UvJ+ugnMz+JbZC4uR/2O2agPL3GXVKc8cSFYkEwHo6xlXJjyUOs6mutDWO6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=FfLsEbwr; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=2124; q=dns/txt;
  s=NAESA-Selector1; t=1742468163; x=1774004163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eS3MaGonIoU9nAIFGQh9EPnwWnxVAYDNEq2SAR0mRpQ=;
  b=FfLsEbwruaypYfw0Ryhn+uowQa+nbREG9SFjQEEn3afF5f0x5xP3p3/F
   BwxbanEUhP6QPnKTyC6OhXIpD88r0BFlAn46tKp/EHp+jnTNNAzM5DWbK
   rWQrJZuKgCH0Ulb6qp1sny3jetZ4LGH/HoF5aLqNOy48hI2acHGlKJjcY
   vDRb/3sPV58yqGXNO9QzchQk0wSpPfC6sYE77M3OlEm+Siz7OJa6CuMpk
   ANJdDejSmJ5r8R8EiDlO7s61r53+eazO8Nb9nCXrzf+zI+yKDwRZ6nfKj
   0/fgNAp/0PPa9lO/+BedVsTGwdmjqWs3HZcI+DYEzSwUN19qLBenRVYSB
   A==;
X-CSE-ConnectionGUID: Pr/umfDXSQ+TrwdZ1Id4Hg==
X-CSE-MsgGUID: fmZ4pZN4TXmNx7DKPsL2HQ==
X-IronPort-AV: E=Sophos;i="6.14,261,1736838000"; 
   d="scan'208";a="80263103"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 20 Mar 2025 04:54:56 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 20 Mar 2025 16:24:49 +0530
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
Subject: [PATCH v2 04/10] dt-bindings: riscv: Add SiFive HiFive Premier P550 board
Date: Thu, 20 Mar 2025 16:24:43 +0530
Message-Id: <20250320105449.2094192-5-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
References: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Mar 2025 10:54:49.0835 (UTC) FILETIME=[8083CBB0:01DB9986]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add DT binding documentation for the ESWIN EIC7700 SoC and
HiFive Premier P550 Board

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Reviewed-by: Matthias Brugger <matthias.bgg@kernel.org>
---
 .../devicetree/bindings/riscv/eswin.yaml      | 29 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++++
 2 files changed, 36 insertions(+)
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
index 25c86f47353d..fc3c9191b00f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8572,6 +8572,13 @@ L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	drivers/net/can/usb/esd_usb.c
 
+ESWIN DEVICETREES
+M:	Min Lin <linmin@eswincomputing.com>
+M:	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
+M:	Pritesh Patel <pritesh.patel@einfochips.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/riscv/eswin.yaml
+
 ET131X NETWORK DRIVER
 M:	Mark Einon <mark.einon@gmail.com>
 S:	Odd Fixes
-- 
2.25.1


