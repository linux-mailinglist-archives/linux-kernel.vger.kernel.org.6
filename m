Return-Path: <linux-kernel+bounces-521062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4047A3B373
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA4D17244A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D31CAA81;
	Wed, 19 Feb 2025 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="fYYV8ZBk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="B4WuRgD1"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB61C5D70;
	Wed, 19 Feb 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953096; cv=none; b=E6eM9q5Nzvd2I5Dz/OkQg1BrflLWYbuyFxMzeDBbxq+H2m4KHPTDNIMTswASBXLJMyCGAJSXG5sifwLKc4UH4XqUrPuvSLwEe1BkFyT9vhQCggOrzQ+Hdxqs3H+cekxovKOAWyR1kgFBDoH1tcLkK29VAQzonwMyah5NbPHP8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953096; c=relaxed/simple;
	bh=FgK32og4F4FLany8zADsAth/vrk/6UqyRqg/3jnEALk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIUgqmVm24xNCZaToeBwz/XuwWV8v1yR9KHMowk01fr0oJlGIdTpMSewG9y49fAzED5/C/KUAXoPq3kygDyID2Tvwnodp20BbQwrlMAJb5A93zwjmmN79v4oRuGnI5QOV8J/Kjicr0GVvCTrr187Y3g5qwK10LdU7nesFdO04xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=fYYV8ZBk; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=B4WuRgD1 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1739953094; x=1771489094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5J2XktkVZupz+grzl0L3lVM8YCbDvKpOyQ/u9CNoYZs=;
  b=fYYV8ZBk9V3fGrrQQ7m0O8Zp61XK6hMdYbSE9HsmteYxoL79p0M9yVfS
   +rDB/T8+zpUbfbGWKTZ+aO3ivyBuDn0/JJ7uF5nXZiXoPyzd2AUeNft94
   FrcH8rDsmTnYjyqPStnBKZvcK+mrfxfDfW8XB5PjcwL8vFJ61vRPTbuNO
   qjzUrEcgepftKhU+2rvqZhJVCqIlBC/Ixg6joe2DEGWRR2ByrJexFv2Qy
   wJh/jBxilsrOE9AIKalfqTNfSD0rKnST/F8yMFVs1Vxc7w0tnbXJp28TE
   5BXZOCcc9apaKxW/SCwxsX0GEXiZOrw7ohTPQmzO+YjbV4pKrc9EUcAGJ
   A==;
X-CSE-ConnectionGUID: /IX5oq6pRaGVwxOo+5u4vA==
X-CSE-MsgGUID: x7HDVl4ESXacCfgnsd69jQ==
X-IronPort-AV: E=Sophos;i="6.13,298,1732575600"; 
   d="scan'208";a="41945131"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Feb 2025 09:18:09 +0100
X-CheckPoint: {67B593C0-30-F75C4246-F0BD6D90}
X-MAIL-CPID: 11E601656B77042673F6C9590D4249A0_3
X-Control-Analysis: str=0001.0A00212D.67B593C1.0074,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D33B16D33A;
	Wed, 19 Feb 2025 09:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1739953084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5J2XktkVZupz+grzl0L3lVM8YCbDvKpOyQ/u9CNoYZs=;
	b=B4WuRgD1onDLsR8yVDsSyD7ZUquLG274RIqM9VpHZOc8AN2KkgKxbl6zgqMy8zhQj0TRYp
	StTqkH8kBHSKRzknLcvOwrtq3/4nnqjRWfK3HII5yVYeO30gsckK1igPUnyTbnzXKNFWqp
	oBOko5Ni8Ua32w2I/quw9N55KgiaRy8bPErS6SouRsk1yh0NWJmCp5OI+zsxDz7RNKXEdp
	hqUqrcjszganWqJJ0HtU9i14c90l9A8/NBbWSL+vH2V8gmJqKOQyTjuBhDcDjm7rpl0FwV
	roBXzr4wOkjrdClv98+nBaaxL6BGNcj9dbwnyEESpzdc4le7DwQHoiGC3XdqBQ==
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
Subject: [PATCH 2/9] ARM: dts: imx6qdl-tqma6: limit PMIC SW4 to 3.3V
Date: Wed, 19 Feb 2025 09:17:37 +0100
Message-ID: <20250219081748.1181507-3-alexander.stein@ew.tq-group.com>
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

This is a fixed 3.3V rail supplying several hardware on SOM.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
index 303def00cdfa9..68986fb3b8df3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi
@@ -119,7 +119,7 @@ reg_ddr_1v5b: sw3b {
 		};
 
 		sw4_reg: sw4 {
-			regulator-min-microvolt = <800000>;
+			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
-- 
2.43.0


