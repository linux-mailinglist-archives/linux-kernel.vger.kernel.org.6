Return-Path: <linux-kernel+bounces-521064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B230A3B376
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE8A7A394A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420E1D5175;
	Wed, 19 Feb 2025 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="c411+FJb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EKwPUgys"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E31B1C5D5A;
	Wed, 19 Feb 2025 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953103; cv=none; b=sAvLcHNdBMnja1hLvCAXt+qsYEux2htrdI5p+iJTQskNUzl+3haFTrDfFReofcKPidvpCOF/ZA69o+Sp1gfg6Y3Jo+OCwPUAc676kIIkU42QGc3jJrUKfoNpghh4iP5Z1UZNpBQZlITC9PDfCtyAzjjZZPZyAJrUCMryZQzy7Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953103; c=relaxed/simple;
	bh=UV6gAsG+iLRf+KuRuniWUXlsiMoneTFtXelepiaM2jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIr9ca25Na2z9sTapIIqMIy9l893h2OCodO7Pvyc097xi2S6wQA2pN9scjmL3YGAXwgBJHCujHGzxwm5l8BlbMwYxh1XlJq+0TobjDmflp5yTCdfNhDITqz0z3GxwAfg3miFQipq/dlk90o18svgU94C9QGgKIgrosEHxzNcd/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=c411+FJb; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EKwPUgys reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1739953101; x=1771489101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MMwhXv8P9WY+Xb2KVF4+Pr6FW0ZCaljgt7C4V308Elo=;
  b=c411+FJbPPB1T5pyy1XNwRloJ3X+eD8C7I5zvjHj4zWXfRj2mZwLEd7q
   giLzo4bdHyrsbnznO5DRAe9zDV5VnhR/5dEs2qWOocQSq2pWoXtNg6Bqi
   4dO5uOt3jl41mJemUNbQUVoq+SwX9jEbcrAjjAm1GZ2nEm5otbkYZ1n5F
   BbHFcIPXCruhursne6OIRqO+7X+iQNnVq4DttsywaNlm2YrEjZA5huuX4
   BZYCFkkk5/8UeTwQnuOzyjTjw/99I//hUnexQTPgt34eKVgl7YOjnhab1
   B3BgoDMHLpbNbcvhQMVvXiqiYYQ445a75h7p6jaHSs1k/teQp2949DbeF
   Q==;
X-CSE-ConnectionGUID: npq/NqnPS2iQ3j+nmK7d2g==
X-CSE-MsgGUID: S3fJk555SGm5XApH0ngXFw==
X-IronPort-AV: E=Sophos;i="6.13,298,1732575600"; 
   d="scan'208";a="41945140"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Feb 2025 09:18:19 +0100
X-CheckPoint: {67B593CB-47-C21CC984-D1047F1F}
X-MAIL-CPID: AD5A523AA63272FE70A3A68D3939B9A5_5
X-Control-Analysis: str=0001.0A002107.67B593CC.0029,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0323F16D341;
	Wed, 19 Feb 2025 09:18:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1739953095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMwhXv8P9WY+Xb2KVF4+Pr6FW0ZCaljgt7C4V308Elo=;
	b=EKwPUgyspPK/Y/4yb/imhYeVXzhW0gEKeTc3ak1METQgl9khL8IF/SfRzgtQH7QFDSR/FS
	Cw2efIbXBICQNmh6YTjcpnHEW1N97ri5pfQXmMkHADmHb1neOdpT/81sPQkFmcoz5D70/o
	ATJ3CcotpgwdDeoaNOfsWBonPbq+HO2BKsiQSnXWlhX22hVJghZVQT/a5zG2BjgCumv/fi
	Fb9CyJ9RMhKd/sCqii0dZhQVcbQwhbRZJ/CL2PbIq7gc/ELVeMlZLtQkw11NrFU8orEl/Z
	LY2+gHgwQZIUvc/FfyzRSZuDJSmVmjU3Rgp3pwZ3pjJ3P2+RlDhUBbL1h/OTZQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 4/9] ARM: dts: imx6qdl-tqma6: Add partitions subnode to spi-nor
Date: Wed, 19 Feb 2025 09:17:39 +0100
Message-ID: <20250219081748.1181507-5-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
References: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The bootloader may add MTD partitions in this subnode if present.
Add an empty partitions node which the bootloader will fill with
configured MTD partitions. Remove #size-cells from MTD node
because this is deprecated.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
index 6eee1a4b0b19f..07492f63a1f80 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
@@ -17,10 +17,14 @@ m25p80: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <50000000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		vcc-supply = <&sw4_reg>;
 		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
 	};
 };
 
-- 
2.43.0


