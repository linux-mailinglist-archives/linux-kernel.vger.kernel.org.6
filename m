Return-Path: <linux-kernel+bounces-414226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589C59D24F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE57281D62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB201CB317;
	Tue, 19 Nov 2024 11:35:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF771C9ED4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016117; cv=none; b=J5+WLZMKzNNBNYvi+VO3MPr107LWnv/73M1uviLZm8WLqQy1MgjaqYHCfAc1uQohyKd8EWLQbati93HAa3NWpGzgEggEzZXT72qzdDfiPBBhptRM97H10NqgglDTqQpeSe9cVFOBboLv5fwZiFuTFOL+ePBBsJO8jbUei5I3tdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016117; c=relaxed/simple;
	bh=+4IDQSK4i3obdYQmYdlnswzo0H/KGhodu2StCIGA9as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNC1P0ATpprK7iv+AZwG1G6BkGLjmY+leQ1aslt/chvD050BkVIBkGfe8FE8d5JD5e1xg3SNB0pT9XJV3TQvOEglWvd5o0dFtIwYFMAbur2RKCtoByRx7BYCb075EOnbYgynagmh8XHrCcS/kqk0YTvq9H/KHVtnRs0V118HlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMVm-0004i8-1t
	for linux-kernel@vger.kernel.org; Tue, 19 Nov 2024 12:35:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tDMVl-001Yfc-0j
	for linux-kernel@vger.kernel.org;
	Tue, 19 Nov 2024 12:35:13 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C95E937706F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:35:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B201E377033;
	Tue, 19 Nov 2024 11:35:09 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4f931d1b;
	Tue, 19 Nov 2024 11:35:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 19 Nov 2024 12:34:58 +0100
Subject: [PATCH 1/6] ARM: dts: stm32: lxa-tac: disable the real time clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241119-lxa-tac-gen3-v1-1-e0ab0a369372@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=po5CXcX3jorgEXwSQF/93cCwkgDI9gDb0IppJ1bPcSQ=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhnSb8ifKwh2t2t95JF/NOiVsmDzJJaurfZq0psCp1pUiK
 fX9bzs6GY1ZGBi5GGTFFFkCHHa1PdjGcldzj108zCBWJpApDFycAjARQ3H2/0496Sxz/1U363W8
 6/p/9lbhvDXSPgKHPNuDG/fLpp2rX6Z/smzbNu3H32ztYoo5tp0/dbbVR/jt7QoGD1ZtuX+uscs
 t416ciDmj9//coivNxvNqRJ8V+/TJZix+GxNhrr3scfY/yWlHchpkovy/Kaz7yLJOQ+WhzPr1f+
 KzOf1zpkjsO7Lzk0dbyf38oKgVJXoehfuOxr5g+OmySOGcpN3nifNbN/c+uBItzNmSOnHdnY2vX
 j1cKZrHKVoc3Tylavd9wTPR1vmPtswQOOXEKtJpZG/LyJBqcKfBas/5Yi6rf3O4pXqr5FVXfGXK
 uyrbYLZjX4cwB/ufv/u2iXdZLhPun1kZXyChXfjrx8lTAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Leonard Göhrs <l.goehrs@pengutronix.de>

The RTC was enabled under the false assumption that the SoM already
contains a suitable 32.768 kHz crystal.

It does however not contain such a crystal and since none is fitted
externally to the SoM the RTC can not be used on the hardware.

Reflect that in the devicetree.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
index c87fd96cbd91897bb724a235689e425f7dbf39f6..abe4c7fe7678f2801683e0995dadbfecce434e81 100644
--- a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
@@ -379,10 +379,6 @@ regulators {
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &sdmmc2 {
 	pinctrl-names = "default", "opendrain", "sleep";
 	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_b>;

-- 
2.45.2



