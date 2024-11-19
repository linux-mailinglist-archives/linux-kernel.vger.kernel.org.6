Return-Path: <linux-kernel+bounces-414223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0599D24EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AF01F23233
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454C81CACD9;
	Tue, 19 Nov 2024 11:35:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2AF1C9ED3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016116; cv=none; b=SYcd9jjVL/2phE+7wFhUe6KK/mTKlcxoQ8Xt7RHmBahB+FhbDT5dZwZ+PXyUNEFE8tdfi1nmVJlGFCF3/klN4y2CgcZRs6GgNkUoAdDcAv00WzK98WDXsGCNLRf4LgzFrsMDN+IyCG2K7iN4o/SQtGHlxd6QiRj9FTCwl6WZwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016116; c=relaxed/simple;
	bh=KdVStOdD/uuuDQWXB4cY0gjv4M2fNzhz+/kAvPe2m7o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bmEmatxf4IyhAvV7YWXo5/cJtuvMG5V35bc+UtHC0xBDyZPv8DawECVcoUyD1ZjVxw1t2EHDl1Y2I6vfIihTr3aWpvS6qxMPMsPkOTo+7Shhpa+VcAA0rxLk+YKLTLJ2ofwgzYfP3ILS1940o4g6I9XEsLpcLcRvRyQYgljOSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMVl-0004hW-SC
	for linux-kernel@vger.kernel.org; Tue, 19 Nov 2024 12:35:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMVl-001YfU-0E
	for linux-kernel@vger.kernel.org;
	Tue, 19 Nov 2024 12:35:13 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B42B637706D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:35:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 976C6377032;
	Tue, 19 Nov 2024 11:35:09 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e1a4d7b9;
	Tue, 19 Nov 2024 11:35:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/6] ARM: dts: stm32: lxa-tac: fix gen{1,2} boards and add
 gen3 board
Date: Tue, 19 Nov 2024 12:34:57 +0100
Message-Id: <20241119-lxa-tac-gen3-v1-0-e0ab0a369372@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOF3PGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0Mj3ZyKRN2SxGTd9NQ8Y12LlKRkYxMLw+RU80QloJaCotS0zAqwcdG
 xtbUA6TzJgF4AAAA=
X-Change-ID: 20241112-lxa-tac-gen3-8dbc3481ce7a
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=KdVStOdD/uuuDQWXB4cY0gjv4M2fNzhz+/kAvPe2m7o=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhnSb8kdLP2pJrPOQrGCSeFot5V5/u5Pl7BuFG8X7Weu+u
 ny6O7uzk9GYhYGRi0FWTJElwGFX24NtLHc199jFwwxiZQKZwsDFKQATsZ7B/od7gUFrsF+RgFuz
 qcmhkEALhmrR3Ev3j/r8mmCvf1SQr5nT/4qWqrnzx3v855O0S2+eX9Tr8bEzX0aap6Jt3o/ffhw
 vjr73CzguLF7i3rArryxf6SjL+l0lAqLZG7SlBD5xvG//JLbpx+ev5pW3VczmTJL7M2fFd4+aT/
 f1XmhNnJF9c5dxlGNbuv1Ci4Q3HUuzpkqFcxrk6BkYelzZk5F7Nn9Sa8N2TR1Gu9X7jM5+yb0nY
 RMl0DtBbHaIeOLKB+uqumzvqmX65D7yPs2vfp/p1BJp/2kGSx+tnKp3c636U4WkCKElHW92V1w8
 yZlmLnHqmYa5gKHncf+Ii9FX3hUnBE//fuJY0aSOl/89AQ==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series fixes some problems found in the lxa-tac generation 1 and
2 boards and add support for the generation 3 board. It's based on an
STM32MP153c, while the generation 1 and 2 are based on the
STM32MP157c.

regards,
Marc

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Leonard Göhrs (6):
      ARM: dts: stm32: lxa-tac: disable the real time clock
      ARM: dts: stm32: lxa-tac: extend the alias table
      ARM: dts: stm32: lxa-tac: adjust USB gadget fifo sizes for multi function
      dt-bindings: arm: stm32: add compatible strings for Linux Automation LXA TAC gen 3
      ARM: dts: stm32: lxa-tac: move adc and gpio{e,g} to gen{1,2} boards
      ARM: dts: stm32: lxa-tac: Add support for generation 3 devices

 .../devicetree/bindings/arm/stm32/stm32.yaml       |   7 +
 arch/arm/boot/dts/st/Makefile                      |   1 +
 arch/arm/boot/dts/st/stm32mp153c-lxa-tac-gen3.dts  | 267 +++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen1.dts  |  84 +++++++
 arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen2.dts  |  84 +++++++
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi      | 100 +-------
 6 files changed, 455 insertions(+), 88 deletions(-)
---
base-commit: b0191a5cbc222fc7af3f9511b44d1f330ef980e9
change-id: 20241112-lxa-tac-gen3-8dbc3481ce7a

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



