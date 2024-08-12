Return-Path: <linux-kernel+bounces-283293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A746B94EFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4DC1C216CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2463184521;
	Mon, 12 Aug 2024 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="P67OUa7p";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LMhkEMaj"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8C183CAB;
	Mon, 12 Aug 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473293; cv=none; b=vD8LvWIEYXobJdydti7B4KFL9NAUsJdr35/QiW9qIDCF0ZFmq2gwvLRRVSOfZBm4d7iCKYfx72cD4jxfQNGGGqgU1dElKqNK8Hl9C5EB/uPZMwqoi6L3gV0DrCjJ9NOFHzllZy3juzjwdjIAPdI/g09atb+yHmn1iQ5i4ktnfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473293; c=relaxed/simple;
	bh=el+2+VhKC5jRMs8MZz1/cuPsTUlb59NhVTipPykuCUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lyTK6pARa+StZFabEU3pMWw5oL9NyP+KeE8LqyM6WpE2tU+3LGgFznGnGVfrd3K+fW8K3TJbG/k1sOTNDf2J/nOIgsoX+nExBZqtta7Sl+x2R10KetBQHYeicFKuUvTk2ysIJ1Drxhn5iQYTk7174r6qE+i6xPIcWY4XPyjMxiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=P67OUa7p; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LMhkEMaj reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723473291; x=1755009291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J83UG3eV4YQ3ivPf6c3chMTQMdfxEsFuu/CCNABYO94=;
  b=P67OUa7pLFL2TDwqcOiv5zgIC/pxm+6Fi8T4s7Ya7b5Bq04xTwSGo4kn
   l+gOVBMa+N3p3L6HxDE2qGdQH8xHRXCa5e4/+ZFCD/njG2zo18tgBD7Hh
   THO7Ui/6wG5kRtg7CStB53lGnPvSzL3lLbtHmKSoTDCe3T6551PRsjpyQ
   Kn89si5Dw6YrKyLB2Troj5HZp8zG4qrpU1qgteO+GxhY1l9ifIXcdPwfw
   C1+EMTu6F3dK3uHjWzURTGhLSooP1f9Cfxwe72irTCuVu8EwRDMSn2CdU
   8MS6sX2lv65f7VfQ1lUvNZNNvkfJTxIMd39MAV8B04VviDnXU0odnU+aJ
   w==;
X-CSE-ConnectionGUID: Vv9imb4LS/C2zYEGUpdTKw==
X-CSE-MsgGUID: qOLalxyUQR2c3vbmX84oSw==
X-IronPort-AV: E=Sophos;i="6.09,283,1716242400"; 
   d="scan'208";a="38365808"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2024 16:34:50 +0200
X-CheckPoint: {66BA1D8A-10-78509F09-E532FC2E}
X-MAIL-CPID: 89D413C7B7F41B6DD5E8ED534025D977_1
X-Control-Analysis: str=0001.0A782F1F.66BA1D8B.0008,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60ECC16476F;
	Mon, 12 Aug 2024 16:34:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723473286; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=J83UG3eV4YQ3ivPf6c3chMTQMdfxEsFuu/CCNABYO94=;
	b=LMhkEMaj9rd64ot23Wqh8LKSR1s5gMnJRsOoAbUnJg+ofc+b47uWYKH1Kq7V/q2aY/qRlN
	63V8vhEfQPQpoP+Yy16ncDVVw37LjhC74otR93h8iXwQl3jkUP1wO0X/+Gdv019lKbNdqA
	TmL92fLXAYTlhZEpi2S8L0NC+BolmiNIyNBylz6iq+SLKWN5TZEyvmScYixVlBYP/doEAW
	GLD53HnWaLCWJS4RWB28DHvRqSZrGeOzk2eN5d36CihTgN0DgLYGrR5nByEgWjXV/fnjJt
	yyyo/8v5JRuXs7Po+VyLkmDFx0ljiHaBsaZris+W5yqWkDTjyjsQzpuGyFbZzQ==
From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 2/5] arm: dts: imx6qdl-tqma6: improve compatible for LM75 temp sensor
Date: Mon, 12 Aug 2024 16:34:28 +0200
Message-Id: <20240812143431.98323-3-Markus.Niebel@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812143431.98323-1-Markus.Niebel@ew.tq-group.com>
References: <20240812143431.98323-1-Markus.Niebel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Use national,lm75a to specify exact variant used. This should cause
no functional changes.

While at it change node name to 'temperature-sensor@48' to
describe the function of the IC.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
index 68525f0205d3..828996382f24 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi
@@ -27,8 +27,8 @@ pmic: pmic@8 {
 		reg = <0x08>;
 	};
 
-	sensor@48 {
-		compatible = "national,lm75";
+	temperature-sensor@48 {
+		compatible = "national,lm75a";
 		reg = <0x48>;
 		vs-supply = <&reg_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
index 53e78f1aed38..1d0966b8d99e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi
@@ -20,8 +20,8 @@ pmic: pmic@8 {
 		reg = <0x08>;
 	};
 
-	sensor@48 {
-		compatible = "national,lm75";
+	temperature-sensor@48 {
+		compatible = "national,lm75a";
 		reg = <0x48>;
 		vs-supply = <&reg_3p3v>;
 	};
-- 
2.34.1


