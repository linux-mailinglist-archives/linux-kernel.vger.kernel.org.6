Return-Path: <linux-kernel+bounces-228712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E239165B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E599285ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099E01494A8;
	Tue, 25 Jun 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="K9oc3IOu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ac6olXSZ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B8F1095B;
	Tue, 25 Jun 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313399; cv=none; b=shLIJifAOJ7i0UH8IcoGLRyauEqfSum51U9Z41r1GiLfuMBt0AL/DjK3cMrtG1CttHOTDRy9HI0shgY52CLaeB78KVevovmZ6VsCbNp7tLr8euNWlI+dkR6eWd2SLhUZxq+xDn+nLIz8e0PDIHhllX9AdlI3hhcvy/wJWxxCCQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313399; c=relaxed/simple;
	bh=2ED/SejkirY0ngnA+C3n0UAhdn+TkuobTxtEwfFC+1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LCwt8Ktva6vupAboQpDjjYbo5a16AyhWxETHYOJELIo1p5w8ZNRpmk11oALXxO/GIuDGY2Kd6oOZnSCvLnfmqBYX38zc1sV6Lbo8rCsT3ek2TlGcm9HDUw7lEqxSrItuK4vO8w3sj48hv2Jlv+U28uDK6wZHrICAZRQNtvQI6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=K9oc3IOu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ac6olXSZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719313395; x=1750849395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bbaWUTXPj9nv1NLsqzjMlAjNGXk2+Od5CZ1P9QpcnzQ=;
  b=K9oc3IOunhEcGBVKAFBOqDEEZt9qGaGowPjuukGVoi8MRkZWASP+BaKx
   Sx/4Rlegm3WQQSVQid2urG95tHqveLKx/HewdwCKb0AcVGm1KhxZDYOym
   Lm9eyCrMhX+enX/rfO/vt8i6fMkSYJFt1ZdorWN1bLfRnHVxz3vxXFsVA
   0wYa/aqNTBY9nasjsQjHr1CcirZDH4nfxWpGfXvZUhPq4BwGfOA2xOO/y
   W0Px+CSx0dwJEJvFIC2qKCp6wQCwVoIHUmLpF3r+yGzEOlefnsH5/ysb5
   gcMj7Ql96vNOWaMT5/p2S6NNeeCn8j9au7KidGRk+3ARifMV1Pxv18hMD
   w==;
X-CSE-ConnectionGUID: GhgnSoWRQ2WdbANS02gqng==
X-CSE-MsgGUID: MbJsf2YfRCGBDNl1N6S8ww==
X-IronPort-AV: E=Sophos;i="6.08,263,1712613600"; 
   d="scan'208";a="37574186"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jun 2024 13:03:06 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACE571635ED;
	Tue, 25 Jun 2024 13:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719313382;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=bbaWUTXPj9nv1NLsqzjMlAjNGXk2+Od5CZ1P9QpcnzQ=;
	b=Ac6olXSZ/bfLCnz0jf6jjE5leKzZiXXWkoNCVVcrzLUwrCRvGF5r2g0NVUWEQLMf5ZUDK5
	wJkaWCTWIYYy0dq75m3cq8zI87sQq0h6ed/qmD7xkEjkblt0o2uIbTm3izIEgEsD8wTyVz
	5j8/yMzydHg3z55bqxeTaMZvVU3YQE7HtC5kV3GpcGYNPK7GM/81ZDimyc/wwyw6l/VzwJ
	qH5wsuJu5a2EE84VrdRkMRisQnO72jcDblMzUMwyfIXDK9kAhHrO+WnEdxyCC7bzGDnl+Z
	Sy9E4qSqg6YSTajXadtCVLa22chec6YJQsoONrWsXqDPVYYoKW42lygN34BLLA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] arm64: dts: ti: k3-am64-tqma64xxl: relicense to GPL-2.0-only OR MIT
Date: Tue, 25 Jun 2024 13:02:44 +0200
Message-ID: <20240625110244.9881-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

MIT license was added to the AM64x SoC DTSIs in commit 6248b20e3203
("arm64: dts: ti: k3-am64: Add MIT license along with GPL-2.0"). Apply
the same license change to the TQMa64xxL SoM and MBaX4XxL baseboard
Device Trees.

The copyright year is updated to indicate the license change.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts        | 4 ++--
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi                | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso b/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso
index 79ed19c6c0e90..c4525024ba5d7 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (c) 2022-2023 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ * Copyright (c) 2022-2024 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso b/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso
index 32596a84b7ba1..82f8a21b6cbf8 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (c) 2022-2023 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ * Copyright (c) 2022-2024 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index 1f4dc5ad1696a..c40ad67cee019 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
- * Copyright (c) 2022-2023 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ * Copyright (c) 2022-2024 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
index 6c785eff7d2ff..828d815d6bdfc 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
- * Copyright (c) 2022-2023 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ * Copyright (c) 2022-2024 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
  */
 
 #include "k3-am642.dtsi"
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


