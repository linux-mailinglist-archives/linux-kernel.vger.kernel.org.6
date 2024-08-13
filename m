Return-Path: <linux-kernel+bounces-284225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8B494FE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468CC2859CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627CA16A943;
	Tue, 13 Aug 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="W4xSXkuW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="oUSE8fUP"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD8149E14;
	Tue, 13 Aug 2024 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533653; cv=none; b=F7X/hEVNfPohNaYZarWKrTEicl2wB6hhXSV//RoKCE8NMh43OAd8jLE9Jcv9x+K1fRSXMGDE3M0xCGIjXS5nhMh7DKb+ZcvofjshxxNcbRKXidPbRBW7+bVwNisnTVXmkk332hHCqxGhYbcPtZYfxqundqUvcg7BFLdl3FFHtiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533653; c=relaxed/simple;
	bh=0tBuilHBGrUQW1ICqsR6FL5nQBr5kgnyBNCU3F8jM9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QiI94Wca4Yi8wHsFrctfnmLFBGtZxRafAgn0GJ/V8Bt+XOzrc/RzoeRKxKd000J/j0Nk7U7YZOhWFKOn5iseaYBxfSA4vbH+eDrKYfFLeSz3OBgyGZI8BW9AuvlRPUw6jyQlXYkFnILqyXATIaAsvKzTuJp10j0Tlaa0qxuMNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=W4xSXkuW; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=oUSE8fUP reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533651; x=1755069651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zttlo1JUrt9mIyzB2j5JYriXu4SscjQH5ukbXtFmmHM=;
  b=W4xSXkuWxZ63hjMrbxEnQqgR2l9d9TMnmEs+Dt7GyzRn/G0ID3/8YyVc
   3EcX71W4czxsNrLyYDaEZHzWDH9KSTRB0AkZ946qNL7SB16EAeGzEQwDR
   KEQVuG8piZ5LnW3zzTl8iukldNlmMQlnwJ186BeESGu3jsUlEpJsW7H4u
   shZ9VsYrXRxSGdk0Jr6ElfrZnOSNvGT2o6Jr/jbhEBAaGTNGmVZdkOH6O
   ug0oqhiGTipehNl7OGyCF0rgvDTqGJsIiKlhIPzKY+lnuVfdLyocZguOI
   EsYLE9c/Ergny27V5+6BXIhwlQYeQl6VRGLUvCrxEYISS/NHbutzd2r6S
   g==;
X-CSE-ConnectionGUID: BOvuExhsTlqrAXOMTrMTfA==
X-CSE-MsgGUID: PwT+J9vYTwSc/bayXQLQ7A==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375998"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:20:51 +0200
X-CheckPoint: {66BB0953-2-FF00FE11-F2A862FD}
X-MAIL-CPID: BEAF4EE4977FC7B8D7173AD641122160_5
X-Control-Analysis: str=0001.0A782F1E.66BB0953.003D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CB22163F5D;
	Tue, 13 Aug 2024 09:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533646; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=zttlo1JUrt9mIyzB2j5JYriXu4SscjQH5ukbXtFmmHM=;
	b=oUSE8fUPeKjrJFDJShT1CDLDfRXGOVEpjwd5lJ0a29/tot9YLIF2q/dzuMUPdC1nZaKkuQ
	AyvIk7AlReR7DFGcLzaROPgTQtgE0jevRndhAXNswkEDRAPlG9FBMnr0xOKKcmmL5O8ADm
	8M2PGxGMqtgj487vmrI4+4Jf6m01ODuDpdRHSyuxyBEjYRDpDPAwH5Y5kjcg9AF4oWrc0Z
	dgs8Fbh1NAiwCjfiNGIAE6vDBjOu4tp1wWwQlEcErclJhsHK3z/sYvRBEZ9aUhqk1nTtCf
	vScqFfEZX81IrkK+/KZB1pPhDkH7Cub8lWQBVo0Z7Vi4anhn7k17FBw4eMMllg==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 2/7] arm64: dts: tqma8mq: change copyright entry to current TQ Copyright style
Date: Tue, 13 Aug 2024 09:20:14 +0200
Message-Id: <20240813072019.72735-3-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240813072019.72735-1-Max.Merchel@ew.tq-group.com>
References: <20240813072019.72735-1-Max.Merchel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add mailing list addresses and missing authors.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi       | 4 +++-
 arch/arm64/boot/dts/freescale/mba8mx.dtsi               | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
index 0165f3a25985..603bbd54bdb6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2019-2021 TQ-Systems GmbH
+ * Copyright (c) 2019-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
index 01e5092e4c40..3ff443ccc6a2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2019-2021 TQ-Systems GmbH
+ * Copyright (c) 2019-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
  */
 
 #include "imx8mq.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index 815241526a0d..aef8446bd32c 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright 2020-2021 TQ-Systems GmbH
+ * Copyright (c) 2020-2021 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
  */
 
 #include <dt-bindings/net/ti-dp83867.h>
-- 
2.33.0


