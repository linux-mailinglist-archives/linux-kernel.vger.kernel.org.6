Return-Path: <linux-kernel+bounces-414224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE8F9D24F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2C4B27203
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C431CACDC;
	Tue, 19 Nov 2024 11:35:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1C1C9ED7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016117; cv=none; b=Rgj+05X4bGHEYxVBb4vzN+Gd/ij3EKdQo+gfl2RxIlKClVHReTYj+i2UA1TobVtxtg1AuQRbyRSw45P3NSKR67nkNsTc9GNfmaFwW3zsgFcHqjBhoGlBeZFX+jzhqpOeb2Qyna8hV5ZwAZdQaXb50biDGFC4neEwUk8SnFC0zsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016117; c=relaxed/simple;
	bh=Mk8G16aTCF9gycyq+j18Ot1XKcgH973eLuowgb6XDcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/N/0jBlTfTHWZ6ZJvq87MIez/vKAxX4+FcMZgWmkazy75vVGfbIKQw4jtENHYYk8t/fbHSVOEO5kvpodH7KGRriMn0IDWnb1la9bx2+DbWRz12XIcUF1LMFx5Tk6ANFMCtUzu88C1KYch3BYPlwXSk0aNT6NtKARV5WCu5gomw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMVm-0004iO-5Q
	for linux-kernel@vger.kernel.org; Tue, 19 Nov 2024 12:35:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMVl-001Yfq-1A
	for linux-kernel@vger.kernel.org;
	Tue, 19 Nov 2024 12:35:13 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 13893377073
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:35:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id CFA0D377035;
	Tue, 19 Nov 2024 11:35:09 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6601b311;
	Tue, 19 Nov 2024 11:35:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 19 Nov 2024 12:34:59 +0100
Subject: [PATCH 2/6] ARM: dts: stm32: lxa-tac: extend the alias table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241119-lxa-tac-gen3-v1-2-e0ab0a369372@pengutronix.de>
References: <20241119-lxa-tac-gen3-v1-0-e0ab0a369372@pengutronix.de>
In-Reply-To: <20241119-lxa-tac-gen3-v1-0-e0ab0a369372@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=4/0nP6y039SdOp5+OOU7PlcTIP04z82jYwEbyNDvpjM=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnPHfmcPHax0Degh2+FdA7T9xZcMkb5yvqAREbe
 ZeoVU9z3OeJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZzx35gAKCRAoOKI+ei28
 b8jCB/wIKQpO5H7/AStDUmRAXNbzh+Z1Ng3wVpPv8z9yDOsbw0acb7kZ+h0xjdYH3JNEU5U+RcD
 rvvRj+D8foe59+27NWoyKAA1a5jWzDNogKluwXv+E75rceFWHOAk+H3fG8bR4jco9yp9PxXc8n6
 OeS4lf+yRcoEVl1QP42+bBeWNU5Q+OXERlZ3C9CHB8SHdpV4mPqvS1zwSEOxhRRImic2iz2UdzR
 qzJIOdsxBxHL2vNXEnovyKIDcj8XdDivyOWm7ZdvSWhbZpVm4Wopo6wfC71PaIM+g1AYHNv9HO5
 WB5LcO2zB7UEm2wh3MO75xVaSrGiRwXYCF422WsYBufx1aDG
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Leonard Göhrs <l.goehrs@pengutronix.de>

Some of the userspace software and tests depend on the can/i2c/spi
devices having the same name on every boot. This may not always be the
case based on e.g. parallel probe order.

Assign static device numbers to all can/i2c/spi devices.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
index abe4c7fe7678f2801683e0995dadbfecce434e81..a97708423ec8f2ee2c471b07ff9dfac19e605b3b 100644
--- a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
@@ -16,12 +16,20 @@
 
 / {
 	aliases {
+		can0 = &m_can1;
+		can1 = &m_can2;
 		ethernet0 = &ethernet0;
 		ethernet1 = &port_uplink;
 		ethernet2 = &port_dut;
+		i2c0 = &i2c1;
+		i2c1 = &i2c4;
+		i2c2 = &i2c5;
 		mmc1 = &sdmmc2;
 		serial0 = &uart4;
 		serial1 = &usart3;
+		spi0 = &spi2;
+		spi1 = &spi4;
+		spi2 = &spi5;
 	};
 
 	chosen {

-- 
2.45.2



