Return-Path: <linux-kernel+bounces-284218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FE094FE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB901F22743
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30682183CD1;
	Tue, 13 Aug 2024 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MqRT43RU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LvJ85/s2"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC47136320;
	Tue, 13 Aug 2024 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533467; cv=none; b=vB4mN9Zk2UBulJvTSE+oNwlMinVzptfmqtRigwjAqk0WIetyvnwWvnVVmWDXoTG4YgYZ8YWkIXTC2AJqAM/yP/CLPEyT+TJ4btacSzx91tygGs2wQHoB0+7wZxniB6ov+ahmiPecdj2VXYZIavBqjEFS6g6ziFrmidU22YE/TkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533467; c=relaxed/simple;
	bh=nhIeSd9kRM2yqcH8KvFzw/LrxryjxTjoQpjXhev75M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tyr9NfgFGFwVdPKeNtBKvuuWp+ZpNfSYTqZkQzslDiGcPMQvvrRUg393S/ihAatz3YulA9f6ssYVFyL80cAJ+I6khNVcXGcmvIOgB2w5oFRxsraJMaYxBH1xocaRVRKI2XU4pcdYoAx++Zy/CyLMjVzxWU9MEBol69j/KxspzYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=MqRT43RU; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LvJ85/s2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533465; x=1755069465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JvGWUHXSkTSJ2NT7irXYfjwumvGi93rvVGPlKl+xKGs=;
  b=MqRT43RUK47fnJ2bFzNjVWF7y1UzAjZoyUUIjm/5BPjYESoRFFSZfn9f
   eu37EN2lq9UntdvTCME4HNn+P4An+dqplUYP3ZaYEdEcIj3e6PF4hsqqc
   VHLdxkrW+2UNM/uX/kJVaRdNhaN+WjngIrMsKAOpGEqtbbnRuNfl4qfhk
   wdFbT+tV2xqntQNl0ELeIQjnXMCoZ8R1MEWiaJGSnRRZqPdfI2epeyZJV
   271NktgMI8U828LKurTlMQuov6c5JxpyfJvLocPMWehaD09gAg7zofppM
   Z7AYIft8KMxseb/YtavBQgCoybctqPOxSCbeKFAMAvPSsAZgRDHeer4h/
   Q==;
X-CSE-ConnectionGUID: 2jousctqRQOXpsn5Vtr42w==
X-CSE-MsgGUID: AotgFRE2R6uclfjUTpQePQ==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375851"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:17:44 +0200
X-CheckPoint: {66BB0898-1-FF00FE11-F2A862FD}
X-MAIL-CPID: 8861E1AFBA8EF29FB1258C2E58EE16DB_5
X-Control-Analysis: str=0001.0A782F1D.66BB0898.0108,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 864BE16423A;
	Tue, 13 Aug 2024 09:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533459; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=JvGWUHXSkTSJ2NT7irXYfjwumvGi93rvVGPlKl+xKGs=;
	b=LvJ85/s2bY/cj7As1EvSeGGP4Vnfqoo458BhI8WT6mFdJq5KwUM1ZP70mDmPyGcrwE6LKn
	Vspw/XxFWTZa+xwJWMoKOzQaqd9Ow89wnEfg5hQU6IxFmWVfL8ZHNAYogBi3ZyyNU2fbcn
	/z1wg6+883aZT9vBawTdw2WV0QJIAnvr6dBKc1ctpp8m1qcMe1PnwsGtBeqTzn2uBaDC/k
	jfhHyUPhlYU3g2fygGFWnBd6q4xGKHgaTSTWKv0n+tE8NpHxAxM8+L7sS0q8oxI72Mp5cm
	0yVRyCI2Lh7uaNJ4UShuGPkl1fV6yoHobmX0aJijsmaAXM5Mum1AFnp2wlawpg==
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
Subject: [PATCH 08/10] ARM: dts: tqma6ul: use licensed as used by included imx6ull device tree
Date: Tue, 13 Aug 2024 09:16:34 +0200
Message-Id: <20240813071637.72528-9-Max.Merchel@ew.tq-group.com>
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

The included device tree imx6ul.dtsi is licensed under "GPL-2.0-only".
But the imx6ull.dtsi licensed is changed in
commit 3428d14d8a912 ("ARM: dts: imx6ull: Switch to SPDX identifier")
to "GPL-2.0-only OR MIT license".

Device trees from the tqma6ul are also used for the tqma6ull.
Therefore, all device trees are placed under the licenses used for the
imx6ull device tree.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi     | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi           | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi           | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi          | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2-mba6ulx.dts  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2.dtsi         | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi        | 2 +-
 arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi                   | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
index 6ab109e00793..080fa5da241b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
index b5a6c7f6d8c9..a9c91bf30067 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
index f66a240d37b3..6b355736e06c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts
index 6110caa9690c..ecf6238a1943 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi
index 02ce7cece882..e27d3f8a4503 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
index 03659eaf7d65..2b45bae7f1d0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi
index 8b49ea9d3dd0..c4181d486b8b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi
index 0bcf3fec9c5b..06fa1fd10483 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi
index 8481aecff77a..bd2345d6e5cf 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2-mba6ulx.dts
index d844c8d39e71..4239b55d82fe 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2-mba6ulx.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2.dtsi
index 56890d849a0a..7e5e3b2d32f7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts
index 6b37519374de..4d64951e5c1e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi
index bbf0180117e3..28ce7d1e901f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
diff --git a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
index 5bff672339cd..0772543ddef5 100644
--- a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
-- 
2.33.0


