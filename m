Return-Path: <linux-kernel+bounces-284215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2C94FE88
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14DE2855B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4225716B39A;
	Tue, 13 Aug 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="oahbar7d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="OIV13FPP"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02131149C76;
	Tue, 13 Aug 2024 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533453; cv=none; b=uzzCUPJn7+9pe6M2GO+8/CLSrXObPLfsFB6phrgNpUHl+YIvRrxitlLd0aUzb9lN5lOwQ6NALF1to9dCaZJwiGMCsih22QEffJQgSUjvFhQgrfsw8XNXIJaIzNJNPPdGsi1esDkzXZUxeUOGrNzJC2ohvips+6EbUr3EMPYnNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533453; c=relaxed/simple;
	bh=k8XD25NgkNgHkijJbW9QHr+UXAG0TuxlDIyfMuiG7nE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJ4TAkVH+jZKVLsv+y6RC3Bpl4BaukC7Fe530VsRuu3UprSeRlzAwRPOGPls0YYlr9oXKaTkOb4CMJV80em/CPRMQCEJ3I3lm+l5oDG+WfSeY+WNu44R8qQmOqIICmVrZCBNXurBcOFDRfDbVob/IIUmlLAfHhpkBB1SyleHjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=oahbar7d; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=OIV13FPP reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533451; x=1755069451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q6JufbhN2SpFfmGKaiVLhG+qaQOYQKonK7fnSGDubcs=;
  b=oahbar7d7NnMTf5xzdVYH8InBv/b6oIu0o07EzQRw4kVjIFmWdhqF6Yo
   O+XTtS6s0Rwx6jC9HJhIrq1e2bz+dC9sH8XB1NNY7D66dctrNs6bqIOHu
   9sPECWHMFRhhwmT1VF3waWleouY/SvPC2W/1tcLJz1qNo9vp4tOBr0UPa
   ulJgFPFkREwdfmUFvtCK+j776iuv8DJgZX2L/9NsNIewZfiUqxSpxcDMv
   vmc3jSnLDYKiaSucHctuCxZxRobmvivuZ9f50ut/J5k61i+6VDtQjE8lI
   MCuSj+4BXj49y+8GtVxrR5vUiSwhVVS+VOxCDL5cEwPcWBIJQEsplskNW
   w==;
X-CSE-ConnectionGUID: T+ncJ+lMQ8uyN+0256wYoA==
X-CSE-MsgGUID: 7s7hdqrUS/Ct0LuwdaYugQ==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375842"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:17:30 +0200
X-CheckPoint: {66BB088A-1C-45EF2B36-F6E28480}
X-MAIL-CPID: 8D283177908FC34A360295BA99E32730_0
X-Control-Analysis: str=0001.0A782F1F.66BB088A.011F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01433164737;
	Tue, 13 Aug 2024 09:17:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533446; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q6JufbhN2SpFfmGKaiVLhG+qaQOYQKonK7fnSGDubcs=;
	b=OIV13FPPmljpQnMXysO2efvDcJy5v83B/MumAN4aT7XFRoiTWkqZ+v+ByP+GB6fAjAHBvX
	tnbOKO6a1PNLKkYvz8cDhg3byslSCrgynq7TBZvwrM3jgWbNcklYuxOASX4xhclXa1Nbx/
	8kPXd2sTOWRfX+2VEuiUcAxLGEMd07rryZR4sQA+Y9KwI6dad+cemgjFgdRTjFb3pw19BR
	Bj3wd3HLCYzl6cOkCODY91BajBTWJcd8kIZdP5fw070x0136SqYW1dIeWftXnNwP/IE6ws
	cZlQmOIKx46nJMaxpoyL7KFmvmhinfMI79WPn7OmXBzDGuvlQ9OrcQkJ6Ecejw==
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
Subject: [PATCH 05/10] ARM: dts: tqma6ul: change copyright entry to current TQ Copyright style
Date: Tue, 13 Aug 2024 09:16:31 +0200
Message-Id: <20240813071637.72528-6-Max.Merchel@ew.tq-group.com>
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

Replace developer-specific, personal email addresses by mailing list addresses
while retaining the author.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi   | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts  | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi         | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts  | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi         | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi        | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi  | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi | 5 +++--
 arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi                 | 5 +++--
 10 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
index 57e647fc3237..6ab109e00793 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2018-2022 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 /*
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
index f2a5f17f312e..b5a6c7f6d8c9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2018-2022 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
index 24192d012ef7..f66a240d37b3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2018-2022 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include "imx6ul-tqma6ul2.dtsi"
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts
index 0757df2b8f48..6110caa9690c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2018-2022 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi
index e2e95dd92263..02ce7cece882 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2018-2022 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include "imx6ul.dtsi"
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
index 9d9b6b744a1c..063802edd76b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2018-2022 TQ Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi
index 4b87e2dc70dc..8b49ea9d3dd0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2018-2022 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 #include "imx6ul.dtsi"
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi
index 5afb9046c202..0bcf3fec9c5b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2018-2022 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 /*
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi
index ba84a4f70ebd..8481aecff77a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2018-2022 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 /*
diff --git a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
index e78d0a7d8cd2..5bff672339cd 100644
--- a/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2018-2022 TQ-Systems GmbH
- * Author: Markus Niebel <Markus.Niebel@tq-group.com>
+ * Copyright (c) 2018-2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
  */
 
 / {
-- 
2.33.0


