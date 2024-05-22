Return-Path: <linux-kernel+bounces-185915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F578CBCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD748B21989
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B77FBC8;
	Wed, 22 May 2024 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="x2urkOHF"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C57F7D1;
	Wed, 22 May 2024 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366232; cv=none; b=lMBNQVDG5uc8C2GqaAb1A00URBz2YPjKe5OCRT6zJgTuExyXiRsNwO0ZapqwX1d6OR4VV81QNORHEbZInigY39Zst0xD0cq3t+lY96fNUl42vUaMa/SeqdsvQGvYiFuRgW9Q6Cxq5zu1VGVkVzEGbgnmvZ0WhuT6PPKww9SyGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366232; c=relaxed/simple;
	bh=Ov8Q2FoJcHutLV6yrVaydJ7WnCy+f3co5Usmn+goUCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3zjeGud0+a9Tt0fa1O3Azk0xBxu8cY1am9xp+7jKp2oDWWw53XugKgxceYuk/n1Xtjg/P9mkElgpmC9M1aYXq5eyLjVo3rfxFFDnGOx8mC5weNJtGIuJBfPi/xDZpl+L71nfQSAA/TbEoT5QXGEymDld7wF864oDhmA/6zjqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=x2urkOHF; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=q10IEafkKQVKlW5UPxyIdH8rk365Jnk+tsww6VNTTEs=; b=x2urkOHFgOh97UWsnWhSBWOcXS
	lNuqiP45YfO+3b+Y8Hx5hBmImSBAuvYUKN0gDK/66skh7cPLSSO0QS9JiTE8s36RM3VfpBpVg77N5
	mbjRgq+M0HDJJWXPNDxq5DtDhpJ0wnfWhR9dLPQJH84XLROFeIfG1OsV1+SkGCck37Fddhn8VH3hI
	xHSLX4CxYKrzdwTYhXAbe4W8IqQxtJn08TAKyrzO4sZ41VaBWD6lXjmqn855N4Z4+WrMdKy8bczvE
	ua+V20xpVCi72pyQZBtNridLCq9iJKUR4pb1fx8lFpVL5amPbOBsyN5prWWNpspeyPZ/mYujAIYxh
	4eNZiYKQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1s9hGF-000FPO-T4; Wed, 22 May 2024 10:23:47 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1s9hGF-000LzZ-2f;
	Wed, 22 May 2024 10:23:47 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Sean Nyekjaer <sean@geanix.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: stm32: osd32: move pwr_regulators to common
Date: Wed, 22 May 2024 10:23:30 +0200
Message-ID: <20240522082332.2471337-2-sean@geanix.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522082332.2471337-1-sean@geanix.com>
References: <20240522082332.2471337-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27282/Tue May 21 10:30:22 2024)

According to the OSD32MP1 Power System overview[1] pwr_regulators;
vdd-supply and vdd_3v3_usbfs-supply are hard-wired internally in
the SIP module to vdd and ldo4.

[1]:
https://octavosystems.com/app_notes/osd32mp1-power-system-overview/#connections

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts | 5 -----
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi     | 5 -----
 arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi       | 5 +++++
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
index 854dfecd801f..36e6055b5665 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
@@ -147,11 +147,6 @@ &m_can1 {
 	status = "okay";
 };
 
-&pwr_regulators {
-	vdd-supply = <&vdd>;
-	vdd_3v3_usbfs-supply = <&vdd_usb>;
-};
-
 &rtc {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
index aa28043c30fb..c87fd96cbd91 100644
--- a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
@@ -379,11 +379,6 @@ regulators {
 	};
 };
 
-&pwr_regulators {
-	vdd-supply = <&vdd>;
-	vdd_3v3_usbfs-supply = <&vdd_usb>;
-};
-
 &rtc {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
index ae01e7a5339e..2022a1fa31ca 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
@@ -215,6 +215,11 @@ &rng1 {
 	status = "okay";
 };
 
+&pwr_regulators {
+	vdd-supply = <&vdd>;
+	vdd_3v3_usbfs-supply = <&vdd_usb>;
+};
+
 &usbphyc_port0 {
 	phy-supply = <&vdd_usb>;
 };
-- 
2.44.0


