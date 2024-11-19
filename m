Return-Path: <linux-kernel+bounces-414225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF609D24F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71D7281EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEB91CB30B;
	Tue, 19 Nov 2024 11:35:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86A1C9ED8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016117; cv=none; b=TIiDfNAv5Ic+USq9r4W/ZXHKw5SH926DQ2FhwG9RSwyT1LAo6sKc/xzL8dNlySeaqWJpPZQ/UgGex6a2rZ1S2gBwc6PkKQCjanzIVtazpeWSe8IHg5OsZpBpSrMCDT3ViRXXt7TFsTAno/UYCjP1bi4NDT4Zbvp65NkyPobJvWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016117; c=relaxed/simple;
	bh=r6guT239clBkd/pX1+4jQQlLUgD7iiqQrOKyFLV+ZH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXXIERrgPXpEJGSySz5EjoXHSvNbxbpdxkw2ijJBHgMoX3zm8ggwPKlYfgASN8UJ3F7/dRPjPYOqetJlWlGYXzRQCcKZR8oZRMgjQvBu+EN7/ga5DEjXLwHJFKagQu03EWpiMW/kSbLHexOq72UeHhfYFH86FoCdZj2ew6ngoeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMVm-0004ib-Bg
	for linux-kernel@vger.kernel.org; Tue, 19 Nov 2024 12:35:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMVl-001Yfv-1J
	for linux-kernel@vger.kernel.org;
	Tue, 19 Nov 2024 12:35:13 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1C54E377075
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:35:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F29DA377036;
	Tue, 19 Nov 2024 11:35:09 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c96e1107;
	Tue, 19 Nov 2024 11:35:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 19 Nov 2024 12:35:00 +0100
Subject: [PATCH 3/6] ARM: dts: stm32: lxa-tac: adjust USB gadget fifo sizes
 for multi function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241119-lxa-tac-gen3-v1-3-e0ab0a369372@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=lUNKFRhW2UkaCb89yA9/rUW4JI9Xi4k+6AExYcnVVQo=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnPHfnm9EuEwt/tRjFfIpjwQLdKwYSVtGSwEc4T
 INmRMDHYBSJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZzx35wAKCRAoOKI+ei28
 b7VnCACKzGe+WQG3WTzwPAJ8bAvxWc0tn9KthZ6HijeH8YGh3eY2g0+dkNbiwbC30Kht6kSM4wH
 5bjigA6PKRkuNXk8GtlIr4IFN9jSRxXcER+mhkjqKRR0wo4GYDI2/G/69vjq+RDfCnj1/HEGo9l
 Q2N3IuOjB8TcqSbdYwTOUMuUC6v+SqFPP1g4MuIgUjiDHU5IU1z99ooCsJpH/ASF1G116e2SkrP
 ujCcRSsgDJ974klH+qgKEkMHyEf7RutseXpdGeN0I6VJjUDEeC4AoF3tkFuSlSqTMlqkrpP0tyu
 8YWauqDNYKq/cP0uCbcB9G8Ac9vldsuBe62Z/gpC78URh4/d
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Leonard Göhrs <l.goehrs@pengutronix.de>

Allow providing the Ethernet and mass storage functions on the USB
peripheral port at the same time.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
index a97708423ec8f2ee2c471b07ff9dfac19e605b3b..d9b9d611a41e8b4ca35ab771d26fdf9067d73814 100644
--- a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
@@ -580,6 +580,10 @@ &usbotg_hs {
 	vusb_d-supply = <&vdd_usb>;
 	vusb_a-supply = <&reg18>;
 
+	g-rx-fifo-size = <512>;
+	g-np-tx-fifo-size = <32>;
+	g-tx-fifo-size = <128 128 64 16 16 16 16 16>;
+
 	dr_mode = "peripheral";
 
 	status = "okay";

-- 
2.45.2



