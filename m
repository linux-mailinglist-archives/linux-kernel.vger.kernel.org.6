Return-Path: <linux-kernel+bounces-180935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952088C7527
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C600C1C221C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ADC1459F1;
	Thu, 16 May 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LmVHVuQv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rOBMwhYf"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447F143747;
	Thu, 16 May 2024 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858634; cv=none; b=qpRlsyEFqOgztpnBr+wQVXIHLaJjzwyWXMIf5u8JRAyCyCSbOGCPHTdz1VxOiiwVhHSIT+U205OJC5hoWNLiQZMf7oVf0w1qQ3Wu/aj0rLLWzgR5BBCx9XPU0hgDgrR4Sg89T3rw3RWuEU1TZ5qdkYTPA8uCl/iXDHje0yeALVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858634; c=relaxed/simple;
	bh=/gj7iIwcvKFWR02PQfrKrZc+tVj5Yu6eNlj7UaW4tMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iYG0pWjbWcrUkbzOt4oQFp16djUElzJKY3LorzyHHPZqvK2aCOu9MqhfwI9qP4rOPnkpDKSZFxkseJXPwcYcM1bAWusfHTZQC0VSz0iq5MIUhdWaVkjZZNSf7oih7spA8JSgd9nzW3EvCqOAgn2pABsP2ys9wYifNWi48bIx90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LmVHVuQv; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rOBMwhYf reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1715858629; x=1747394629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3PaondP2vCY+Il27mm6X+8OdOJ6oWIlMkkq/jKHGv2w=;
  b=LmVHVuQvjZyFHwBqhDBV/yW9EOM04I98cP4WAjpdW66qJIwVnArCGiQe
   fxubUkizMov1T+5bE/MfhnslTwnh2ayOwvYQBT0E+ve5mWems4Zkhz7/F
   K/JYupboUx07wSRBTHcaU1pRP74k4TJatXtEQcLyGCPPvptC8pUKBKBUE
   6WtBhtHNShFScE+j2s0zpn+7ZO0xtxx+EVGOOtsTPjKSog8pUXnmUF1ZE
   ggDIgkTRuD8zTepibkTwFgM6ujI+fYk6QvxSmJg18U1HpAryd5xOQmvk1
   DeqhZjeCKizA0Synho0e8iCPxLyHFYeQ2DcG+ARt0QHjZIxyKbB2JCXHu
   Q==;
X-CSE-ConnectionGUID: zZZTLLukTNSm1kpKsSkEmg==
X-CSE-MsgGUID: mGnkgi9aSVyBwKK5iJZKqw==
X-IronPort-AV: E=Sophos;i="6.08,164,1712613600"; 
   d="scan'208";a="36936022"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 May 2024 13:23:46 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82FCE173BE2;
	Thu, 16 May 2024 13:23:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1715858622; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=3PaondP2vCY+Il27mm6X+8OdOJ6oWIlMkkq/jKHGv2w=;
	b=rOBMwhYfi9zcrF/Ns7syh3UduzyJT9xhsYYXTIwo70uSQeLWGuhJdWmtrYszXSqqui1pDF
	ZMqSJUUnQhPX7hdcQjZhjXriw1MAbKp6nDEauSY6ehYS12emkSAoWvBGjYXOHgYqyKFbq9
	cq7/8Ofk7LpDrQRJiMSRTYNfu0Y1Qlp6z7vwkCpwZA9sceyYRyO/eYAISKKvbTVxUXtI/5
	Z1QfEMsePoPFWwzTz76VNnjfMOA6KbEoI2TLFSZU+ovaX5UVoCIOuFn+ojbocxiSLeVsKe
	VVvAgeTVXruVGtffCQL6GEk2H7RxXAVbn0OCTA8hO05Up/HSU1QnYIEQVQpkWg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: imx8mp-tqma8mpql-mba8mpxl: Remove unused ocram node
Date: Thu, 16 May 2024 13:23:43 +0200
Message-Id: <20240516112344.200166-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This node is unused and origins from downstream kernel where it is
used for the DSP.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
index c51ed7d991d18..ae64731266f35 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
@@ -222,11 +222,6 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		ocram: ocram@900000 {
-			no-map;
-			reg = <0 0x900000 0 0x70000>;
-		};
-
 		/* global autoconfigured region for contiguous allocations */
 		linux,cma {
 			compatible = "shared-dma-pool";
-- 
2.34.1


