Return-Path: <linux-kernel+bounces-284217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DDF94FE8C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B101E28557F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DE417C235;
	Tue, 13 Aug 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lAklHniK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iOjLtDHY"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451612B143;
	Tue, 13 Aug 2024 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533462; cv=none; b=NoOYPBPnGbH4MkrvgFK6fgTAGIuvbTHwFg9VUBl/8cm2x+vsWN6qxNS2iaLBsh3IIoef8aReDb/szYPGSroZaaZuGiQwD5clZGeakqZPj77I154Bb+YoRQzfuMngm5byr2/gUR14xEdxnyVkMNyNHjavWdOUjprUWkLtP9DBrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533462; c=relaxed/simple;
	bh=fatmmjUatFI1sPhla+MQihPhNcLu7Q9mBS5koEae0iE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duDgMoiI0mZXorZj3WNb2bVsiwA549fgwfU1xKimrpeXw58+W/WaHatSZyfvwFh6otwwskg1wwO46FNsSPOsGL7+eH2a7UqPK90J1vS5MXKbIwcO3C1/dOcjOycgV8vK5H3enlh8R1nkVA+ohA/eKtGVX0a6oIhqRe6ImpDlF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lAklHniK; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=iOjLtDHY reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533460; x=1755069460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yjUp31rgCDU0cCoYQSwBCvEeWKvqwPQANqmOrF3mNjc=;
  b=lAklHniK+K6nQgSMUCJl4ZjiEowBYh8LBjlgSmhG3hcUA6iNLoGESItf
   ZTim+rpEfAxNJzL0xk2hazsiQvSX7SSLyKnp9bos+ORu5e/kxrSyk33IL
   RMKal3W8ZdU4UO3BA1Zop/jFy+ty+k+RfjHx8g91N7xl4/bDb6ZAI/WyW
   +s7E4BlFydQXascp5u/ynhohCBxavNhw+LYVnQGuiwdCLFc9tov/T82/A
   dmIL7pnKbY+EJDknbVYpxKjnKXL8fdQ3qxurnmwIFD7zbKmZWvpbP4/38
   I9Q0Dbi++PMBjUrxL/jgJryRvNFg+4Duytz9mYJent2LaedVEaQ3rcwjy
   g==;
X-CSE-ConnectionGUID: vf6VFbSSQZyb00qH4LptIg==
X-CSE-MsgGUID: Esz7tr6gSaqKb94+7M7Bng==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375847"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:17:39 +0200
X-CheckPoint: {66BB0893-13-751552D8-F91D2344}
X-MAIL-CPID: DE8625E360A667F8A53CB07ACB964DFC_4
X-Control-Analysis: str=0001.0A782F21.66BB0893.0114,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 143E4164737;
	Tue, 13 Aug 2024 09:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533455; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yjUp31rgCDU0cCoYQSwBCvEeWKvqwPQANqmOrF3mNjc=;
	b=iOjLtDHY9DSSrl/+rzxsE84DFMopEQ6gQg9YP/yE9AAds+es1oJtWwBQO9FE3o/Q5m/xje
	3uDEO85oOBVxZHz9jVqjQhd8A3WQMYQYwHRBb5LTioc6g2gTj1fHEgbyvGkg0JA6lL764Q
	a0WTbcoP+VXXxrFhRQk+dwtCo7bEhvlAyEYdgiATg14SmQ3KsgRcaL9UfzTKCOcEjcIm9v
	397UeGD5W7DrSUkUuohc8BG0abItqTOe9y89sy65Eu9taylA1wb9Mtrn58vPOTMoPNQDml
	ZXC1UibJogZ2zHfOk8Tz1c97E5aVgogW4Jmwu1Q7kuiaNxe/zC6S8ceeEEmbIQ==
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
Subject: [PATCH 07/10] ARM: dts: tqma6ul[l]: correct spelling of TQ-Systems
Date: Tue, 13 Aug 2024 09:16:33 +0200
Message-Id: <20240813071637.72528-8-Max.Merchel@ew.tq-group.com>
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

TQ-Systems is written with a hyphen. The incorrect spelling with spaces
is therefore corrected.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
index 063802edd76b..03659eaf7d65 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts
@@ -11,6 +11,6 @@
 #include "mba6ulx.dtsi"
 
 / {
-	model = "TQ Systems TQMa6UL2L SoM on MBa6ULx board";
+	model = "TQ-Systems TQMa6UL2L SoM on MBa6ULx board";
 	compatible = "tq,imx6ul-tqma6ul2l-mba6ulx", "tq,imx6ul-tqma6ul2l", "fsl,imx6ul";
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts
index 6696262aaae1..6b37519374de 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts
@@ -11,6 +11,6 @@
 #include "mba6ulx.dtsi"
 
 / {
-	model = "TQ Systems TQMa6ULL2L SoM on MBa6ULx board";
+	model = "TQ-Systems TQMa6ULL2L SoM on MBa6ULx board";
 	compatible = "tq,imx6ull-tqma6ull2l-mba6ulx", "tq,imx6ull-tqma6ull2l", "fsl,imx6ull";
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi
index b81a0c204567..bbf0180117e3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi
@@ -10,7 +10,7 @@
 #include "imx6ul-tqma6ulxl-common.dtsi"
 
 / {
-	model = "TQ Systems TQMa6ULL2L SoM";
+	model = "TQ-Systems TQMa6ULL2L SoM";
 	compatible = "tq,imx6ull-tqma6ull2l", "fsl,imx6ull";
 };
 
-- 
2.33.0


