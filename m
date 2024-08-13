Return-Path: <linux-kernel+bounces-284212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5C294FE81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC881F2512B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CAF13B284;
	Tue, 13 Aug 2024 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="IWExHqFl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YFbv3Jyk"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292B13A244;
	Tue, 13 Aug 2024 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533444; cv=none; b=emezQsUb/wv4qpniCD7crbdnSTMtVkMG6WTJ0LXERx3DXQbV0vWFPgslUVyT5diEc7W3ZJ/vbJalubWPZBbtPvRKw7jOqyRQ5OiLe1As6Da6l5XEQu1L0uYAXeVMmTjQivr32aaPtcf/mG6zdd5ME3kPU3wrzFDRKHOe7mBCfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533444; c=relaxed/simple;
	bh=HfmmxIu0h/qgtQUxLyUPCFivYCA+wCuo9fUSBcadr4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqQxskEuuxsEUbdlSq21nPUql3hz0K+lWwok5vFG9GW/TF8yfpr2RBINq+vFIcDPRhYERf7JD3A/2qwj9S8BLJTJnoD5hUDKrbyCihtxzjdL06s66D5kNPMlV0q2Y6fESQyU6hDu5sm5G/VrvbR0x2mOORe4CjjNsAs1wzvAdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=IWExHqFl; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=YFbv3Jyk reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533443; x=1755069443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SKsYNi2c1rJOnLl+Z/fg6oO77oLGyMVZddh+RNs+jpQ=;
  b=IWExHqFlW9H0Q2zp+yCnMT/fzn3I3AKuzBXNrIOBbeLlvohJz/TlJxUu
   o+SlpNVdQn2pFmjGlOrcEspVIezGqDnVg89sCrC8kHZZJ9A3/Gk6sK1Bm
   iwp8FumjdAn1/KUMvj2vi8eqj8SZH6Pg9sOq/5lW5LmPIrsoAhsqoMJnm
   Ha7CTvlisS9WuRw9+8tA85R9f++bb1VfRb/lFbNOhJdINmJGJ0QfX5zq7
   bhAXKl+QwTFQstukG9/yYiNTIRnvDntNxGt/HfYU00kwEs9TFMgi1ssJl
   bMzTKflNelbQDt8D40uuiDS2IrIwq3c2uU2xbrN7KO5OoUzsx9WmnJ3v8
   g==;
X-CSE-ConnectionGUID: 7SkVdI+GRL6do56eQRljUA==
X-CSE-MsgGUID: c1jWyx6EQ/iFpXw+t5nVvQ==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375837"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:17:21 +0200
X-CheckPoint: {66BB0881-20-2C7A84BB-EFCBC4CF}
X-MAIL-CPID: FD28A98480EA23D9A44F5EC5986829F2_2
X-Control-Analysis: str=0001.0A782F16.66BB0881.0151,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 161EB16A128;
	Tue, 13 Aug 2024 09:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533437; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SKsYNi2c1rJOnLl+Z/fg6oO77oLGyMVZddh+RNs+jpQ=;
	b=YFbv3Jykw2LmhL2x3LP5phVaIoPoQ7+Y2emcBJQbY8OCQH4/dsEHqluDetX702g/UAtKnZ
	Oi15bANcHZh5y9OXd4jiDq3WHVDVBPTOXuCNwl9m/BXohFZLoxjiR2ujAwiGUxezkcPzR1
	8Zt8awVadwcdQ+tB4vYhcm4MdFu22kpR3onvm46mx3k288YQYFi1lP8aGdA2sqY8M2Y8LN
	dIqKrZXr9nTIq3sWW5HyWOR54w+lNmgLwE7T5B9ACygPY/+Qo9DWCG427pJXHXlmLz+muR
	ZyeEVyWXTpC8vtjG/laTRhaIfhsCeMXwfCXRNyYjOOTlXF4xbOagHGYOpL2bXA==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] ARM: dts: tqma6: use GPL-2.0-only as used by included imx6 device trees
Date: Tue, 13 Aug 2024 09:16:29 +0200
Message-Id: <20240813071637.72528-4-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240813071637.72528-1-Max.Merchel@ew.tq-group.com>
References: <20240813071637.72528-1-Max.Merchel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The included device trees imx6dl.dtsi and imx6q.dtsi are licensed under
"GPL-2.0-only".
Therefore, the licenses of the tqma6 device tree are changed to the
same license.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-tqma6b.dtsi   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qp-tqma6b.dtsi  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi
index e891ef9b0091..1708195fc93c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi
index 38cd8501a886..6755beefe2ae 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi
index ab4c07c13a13..e88efe26963f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-tqma6b.dtsi
index 7224c376c318..0907088d3aae 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-tqma6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-tqma6b.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
index 344ea935c7da..fce5ea4a5320 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
index 68525f0205d3..777fe8624dfd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
index aeba0a273600..8b04ffa91437 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qp-tqma6b.dtsi
index bb6ff7c64b27..145801f01537 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp-tqma6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp-tqma6b.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013 Sascha Hauer, Pengutronix
  */
-- 
2.33.0


