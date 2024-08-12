Return-Path: <linux-kernel+bounces-283295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B7F94EFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6FE1C218BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518D9184554;
	Mon, 12 Aug 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="cOxIWoJg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Z8eC3qOq"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627691836E2;
	Mon, 12 Aug 2024 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473302; cv=none; b=u3F5xxhixoD7DX8P0aC6jpr8SnNGBxVIbhF2WqtJYLMxcenZuxpnlYO25nP505AJTaLaXAhC+bIXInu2U2vUOseELFMeybSH9t0sb1cHFiMsz5u07wtPPK6oUM5q/tb7jXsa7z5Ez+UzlRlb5rreQaCx55Uyqbmb9mBqNm0dHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473302; c=relaxed/simple;
	bh=bj/VV9G2eqEk65QqwUpKk84CIzh52ClavkvhqTaR3go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RtbBcAigNRfDuL1Rwd6t5+HDeo4t4JyrdES4bNnkl1EwxJEzZ8NMhpSZkoaW5OYfuYinIMRCiEeSWxWQzk6R9tI5jwia5lzG+Pv7uDKXQkCAcSafoXtrw1KBdaOvIw2lhIBgx2DO1tVtYXNfm1/zanaJK91pZPGU+Ich1fxIB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=cOxIWoJg; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Z8eC3qOq reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723473300; x=1755009300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AFhGcL+XVaPj2vc+EIgiNYlY3sR/olQUv7UwVtTOVJ8=;
  b=cOxIWoJgUlIo74xhEwD+FEzPIi/yQBb2hck7NaVfellhxj/J5kTVsczM
   VX0qwNASxSEfrRUXuL06ebMLZMbmU/oejVexlxq16C+Fg6mZ+Nwlfmbrh
   QxnAfcx2fFEbsdzvEZmE6ug83V9Sm2RqthuR1cPN52z3E/ncUAybGuveI
   jvfq2YEhJ1VXQ9mq5APUXuZtQFlIPOhwYR1+eXxPj3JLDsAikjhsnssJ5
   AOMoPwEtNZIr+CAtZ4QaYMQBqNynX8kK/q4FYJGn27fghzZnot6Ak5tF8
   BDGD4s4BM6fcRdVJqwVb8nckzBS4xRCKbw6nVSHjtUcDN/NrQ4J2zw/LK
   A==;
X-CSE-ConnectionGUID: p7+HlikYTkuL9p2F0C3j2A==
X-CSE-MsgGUID: q9lQ1UuqSIWz2WEyDbElWw==
X-IronPort-AV: E=Sophos;i="6.09,283,1716242400"; 
   d="scan'208";a="38365810"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2024 16:34:59 +0200
X-CheckPoint: {66BA1D93-6-78509F09-E532FC2E}
X-MAIL-CPID: 4FADB42A9F296772E502E13CDFB1E63E_1
X-Control-Analysis: str=0001.0A782F25.66BA1D94.0032,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D188164773;
	Mon, 12 Aug 2024 16:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723473295; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=AFhGcL+XVaPj2vc+EIgiNYlY3sR/olQUv7UwVtTOVJ8=;
	b=Z8eC3qOqMVxtS4QOm4FbDXEERK9oplbbDf7QtUz+Vhgjo8nLOmwOrAr51rzOedEFV9IQXN
	cElxdLraSuFc+ziBtnzlhO5EgD9xzONhhJ+4hGt/MNWdDC9LPibLv2XfbDaltvhBhWPohP
	vpJWhQMw+JlI4rcnjL1k1xTGvF4iq7fa0l4pl/ubABfkGdhxN6CvkhF84LSoyvNPEVFQ4e
	nIYAbCDqdaskN1u033Fq/U7BnOCarrtfLYI0hcoKUGPWgDiVf8F0uIoMlRpjOjHJQfAXYS
	8oTQM0IryRMCeDKMLwQqAI14vG+NB1KFrZWvku7Kt9L+F+gRX/Y4uREnEGJd4Q==
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
Subject: [PATCH 4/5] arm: dts: imx6qdl-mba6b: remove doubled entry for I2C1 pinmux
Date: Mon, 12 Aug 2024 16:34:30 +0200
Message-Id: <20240812143431.98323-5-Markus.Niebel@ew.tq-group.com>
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

Since the muxing is described already in imx6qdl-tqma6 can be reused
by this variant. No functional change.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
index eacd230b97d5..c7bbd6195fef 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
@@ -50,12 +50,3 @@ rtc0: rtc@68 {
 		reg = <0x68>;
 	};
 };
-
-&iomuxc {
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b899
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b899
-		>;
-	};
-};
-- 
2.34.1


