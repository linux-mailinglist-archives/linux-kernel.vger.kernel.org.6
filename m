Return-Path: <linux-kernel+bounces-521067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B8A3B383
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDB918969C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327731DE2BE;
	Wed, 19 Feb 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="X9bM2el4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jsa6/6hH"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E91C54B3;
	Wed, 19 Feb 2025 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953119; cv=none; b=Dn3oxJ1im3tci0XvkYqUHIgq3tsn0iJKvtjFrKAdj7H+ZMW4mrDxzNZu5iLdQSr9mqTJio8z2r7S1dtT4o3BsJ0IxH+q5NNqVhjjDkMRVC0CCg7pbw0KrIVVvhSWOH7zsabmWQ2v1OW1iaqt6+bHggI6Xyb+QFG1y65en8wylsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953119; c=relaxed/simple;
	bh=WnDWirbLSxiR3Erofiq5GXOiKd6VTErbh01iHm+nBC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ix7T93KA/8JGYxzUncePKJTyz4NskUqUvg89kByr5D6aJ6/Kr/dVo9pnybQmHShL+/aBhsthGjphVzFUGDXPbM7BgJuizPHKxKNOyS5z138ZcXwpd5pqePz3SGOdEDphcLiDBmszNFsnP0Ua1BpV5Enh29jTAVXfo3fMu26sCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=X9bM2el4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=jsa6/6hH reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1739953117; x=1771489117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XWJSQqgv/BGAC3SGvS9AWPMU0gfUh9CUB1ZZemk53vs=;
  b=X9bM2el4cvv8xrBgCSVwAM9J41+CY1flSfEJYOaq0OG3W/4H+xti5tEv
   N1nU7CKSvrdzRSFBr+TwAQOttCwEZUj8edntCpbEEpdEki54f1tvfgNuv
   A1FvN5b4g4+GhINYCuO/qRYvLkELqn9KgGZZd2Nquxpy/5ejcPJy/B8qd
   0nhUkjHs4J97ZV11+zM05sPQtOgDuDzavGpkwJ4GLyJ44cKm9LX2AWulM
   xg16U3kyOYPBqvXh7mSmBjt97e0BBz6hUz9Qtghf5sj1fYLo77yRYxOiH
   j62yTE6YnTfdY5PpZR60vwJi1yf/aEf/zi/DeTQdgLFmkenhHN6bnjz6O
   w==;
X-CSE-ConnectionGUID: VTYo9hwBThqxhEcVqZeMkA==
X-CSE-MsgGUID: SgnDI1rARWGeU6KlAJvA+Q==
X-IronPort-AV: E=Sophos;i="6.13,298,1732575600"; 
   d="scan'208";a="41945164"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Feb 2025 09:18:35 +0100
X-CheckPoint: {67B593DB-38-B8541F8F-E50F9B0E}
X-MAIL-CPID: F34EA9B9402CADC0B0AD7EE8166E3D9D_2
X-Control-Analysis: str=0001.0A002119.67B593DB.00B8,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96C6D16D476;
	Wed, 19 Feb 2025 09:18:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1739953111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWJSQqgv/BGAC3SGvS9AWPMU0gfUh9CUB1ZZemk53vs=;
	b=jsa6/6hHFrprwlcOf7gLmRiCrWeRSmzcx0FTcKH7bLLb3nzGiamIBcPjbyojXm6dtYa1ga
	O5ugPZelYw0e0a5lBNMhPzC2Riegrm1eCP22ZqvcIxDLEV6KJfMs6l85N1YTOVDIoRO25w
	vsCuqfcjtXY8MMvwuGvxGWqoaq84uvMZcgTl0Z+8vyjVegSd2q8vltPa47DkJi+FDb4f/p
	yPKiiArohfsmnywPC3t/KZyK1IV/Am0Wk7A8blobZS0UgGdK+GztQmKUml6bnwJGGMkoxy
	WpCRUNWq/gOr4/8zRj0GIb40iXmbHKl5BjQNh2qDYZlJJWgB0aNcjYOFlhGK6w==
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
Subject: [PATCH 7/9] ARM: dts: tqma6ul: Add partitions subnode to spi-nor
Date: Wed, 19 Feb 2025 09:17:42 +0100
Message-ID: <20250219081748.1181507-8-alexander.stein@ew.tq-group.com>
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

The bootloader adds MTD partitions in this subnode if present, or in the
spi-nor node itself otherwise.
Setting #size-cells in MTD nodes itself is deprecated by mtd.yaml.
Fix all this by adding an empty partitions node which the bootloader will
fill with configured MTD partitions. Remove the deprecated properties
as well.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
index 1e4022cba3cc5..2dd635a615cb8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
@@ -164,12 +164,16 @@ &qspi {
 	flash0: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		spi-max-frequency = <33000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
 		vcc-supply = <&reg_vldo4>;
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


