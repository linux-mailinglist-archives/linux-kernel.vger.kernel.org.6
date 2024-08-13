Return-Path: <linux-kernel+bounces-284220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F80594FE92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C76B24CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82613958C;
	Tue, 13 Aug 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Cm4PpMbV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lFqoxGmr"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0EF189BB1;
	Tue, 13 Aug 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533475; cv=none; b=K7o89+eFlbviJvEFJCoz91BlkxQ0RrE/y4MyVPXzCz7GJItbasN7xFBuElnJZlEa30gX5iJEJH9yubcU2iKqXb4XqfFlp8xszPJhjZXDFCOTEykYXoYacGhbgI54sh4Gp6RKDLceM/zTYIpMJrb48gDjBtmdAUaphctKoV6l7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533475; c=relaxed/simple;
	bh=Z8xOfcZHk8vMeGNF785fOWaSG9UPd8klNoQ23vntWyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgYKYw94fNYEIXdYkw73kOUI4YIiTsUXNta8+kMgHmcWEArDCSS2LysKLC3VkDOeAVCRG3i2/CrMRBMIA20E81zFVWNkz83cVvGbV9UiVg5rA/91eY/AfXlb8C6W3h13Qu3W2gSXfJwnkxohOvMH8IINKGIXBDur06LRdW1PI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Cm4PpMbV; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lFqoxGmr reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533473; x=1755069473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oS3CvCuspSgDcVNPV15uToPe08f2Wogfp5h1cRL3+TE=;
  b=Cm4PpMbVY7pzzh3aJ4Vct9Qq+oqB3AT74iRm5GahIM7g1rfXK6lExsto
   pqNJytZLqIDZDMS4+9i0ffJX+EuXkAoFqBXUllNFwZEAT+bvlp3pk+sFf
   mKPnsS5fIit1sd3nT4n8jY/ZZ679boWKu87Tgqj3FmY1I9bgfsN5CVAnV
   JGbL0SQcW2DeEm+wy7I0IHaaWdBHBYWDcRpE5dY1bFl6RoSx8NrNmm0p/
   hGVpbgPxcr4xSvDRmujoHU1k+iPi/4sum1nUrmEnIR3zDv9V6L67w/vlh
   kLscjd0rSRmc4pT1zg3+id8XKKMUsVRW8d+OK9DJAojtxvyoB0ymo4pUC
   g==;
X-CSE-ConnectionGUID: 9XOBsU0TSemZ0MbLcoZ2vg==
X-CSE-MsgGUID: vYJNhZDZSM2FA0V9VGg25g==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375864"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:17:53 +0200
X-CheckPoint: {66BB08A0-31-E9ED6009-C4B0BEC8}
X-MAIL-CPID: F05CC513CC245D2B93E9B160095DB18E_3
X-Control-Analysis: str=0001.0A782F1D.66BB08A1.004B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8742F16423A;
	Tue, 13 Aug 2024 09:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533468; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=oS3CvCuspSgDcVNPV15uToPe08f2Wogfp5h1cRL3+TE=;
	b=lFqoxGmrLYrSdkHJg2i5UoiQ23XemKYQhohtisiWWy8A2r2B05s68GBcUCaOc36JClQ8Z5
	2tAm3fgm4KpnHGmqg77luZnTYa9zA+IvI4lWEoShg2it/RBzmakZN773G4vbPRWVCcDOPv
	BdPVacLF6AGicGXCOqQ2BsomB1hSmeTGxQHR6RTpmjvwHuhL8zyRWuQKILxmv5bYJ0nzxl
	wjFeMVnVGIriJnATZlzzOYcuw1HGuSIC/mantRJcx6+KEVJSgfIpvUGcewRmeHeqkd2vYG
	y/VpQ+7I7qxKillvPC7GmliExj5cyXl5WK+2jLa1G64WbIr8Ah0MtSj6y6AyHg==
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
Subject: [PATCH 10/10] ARM: dts: tqmls1021: change copyright entry to current TQ Copyright style
Date: Tue, 13 Aug 2024 09:16:36 +0200
Message-Id: <20240813071637.72528-11-Max.Merchel@ew.tq-group.com>
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

Unification of TQ-Systems copyright entries.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts | 2 +-
 arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts
index d441a67fb4ee..d294b9f6b086 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
- * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Alexander Stein
  */
diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi
index 2f9387c34ca3..229a30b84c36 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2013-2014 Freescale Semiconductor, Inc.
- * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Alexander Stein
  */
-- 
2.33.0


