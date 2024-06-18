Return-Path: <linux-kernel+bounces-219955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70790DAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017961C233D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249BE13FD72;
	Tue, 18 Jun 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PpMFgl0r"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127D13B5B8;
	Tue, 18 Jun 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731901; cv=none; b=tzgUpvIWciaYLMUbSaNBtfQlNMWsHtA7vw2f8PnulG1pe2qEf0GnkFIpzigxpqVFdY1s4JWFNisBS86Yn5QvjRjdjvDU/7+aWZNa5QIrJmg2rYtBvr1tE0+D9BjWBPmrN7QKixgsJVb5NAIZL/7YDGfadRJ4Z8j+OSL+RR5yGLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731901; c=relaxed/simple;
	bh=LDh/6uc721IbrI5OVRqiiZkDLJnJ41uZdcZfmyEKkKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJCcUeWr2RZJHX75z33wioX/yxCs/XzhVIjmLWBVff6FsGjioUeCvd1Sa3M7uHKZID+xC/etFdR+u079oURE9UliXKOAUdmbW24+J4j3xsxPzu2Wscun+nBLjk6nacbqfvmr6QvucWkcJBOhhOCLH5HE0DlunPHpOHOXT2kdfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PpMFgl0r; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IHVQVc089668;
	Tue, 18 Jun 2024 12:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718731886;
	bh=TpptANxAKQ/YzWp6VLz1yfMEiiZrROXM3asZbo6gXXE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PpMFgl0rFTRHjnqoyY6MNrdqdhVERSlQIQpQNkGkbQHpxy/Yuw56G0JTDfrrqgl9u
	 i2fDZuzSZDJF3WQdeGUPkEwVcWibjCIiYUe5E6bpLyxrRHsJH+LmCOaFohI/sKRUuG
	 OhLvqwVoYX18sqaggmdo9jON1OieNJUXHF5QipJ8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IHVQn4048880
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 12:31:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 12:31:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 12:31:25 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IHVP37065567;
	Tue, 18 Jun 2024 12:31:25 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Vaishnav
 Achath <vaishnav.a@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j722s: Add gpio-ranges properties
Date: Tue, 18 Jun 2024 12:31:23 -0500
Message-ID: <20240618173123.2592074-4-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618173123.2592074-1-nm@ti.com>
References: <20240618173123.2592074-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Jared McArthur <j-mcarthur@ti.com>

The AM67A/J722S/TDA4AEN platform is a derivative of AM62P platform
and we have no single 1:1 relation regarding index of GPIO and pin
controller. The GPIOs and pin controller registers have mapping and
holes in the map. These have been extracted from the J722S data
sheet. The MCU mapping is carried forward as is with J722S, however the
main GPIO block has differences that needs to be accounted for.

Mux mode input is selected as it is bi-directional. In case a specific
pull type or a specific pin level drive setting is desired, the board
device tree files will have to explicitly mux those pins for the GPIO
with the desired setting.

Ref: J722S Data sheet https://www.ti.com/lit/gpn/tda4aen-q1

Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Note: this generates a 'too large' warning for
pinctrl-single,gpio-ranges -
https://lore.kernel.org/r/20240618165102.2380159-1-nm@ti.com/ for more
details

 arch/arm64/boot/dts/ti/k3-j722s.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index 9132b0232b0b..84441a8ed4f0 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -83,11 +83,28 @@ &inta_main_dmss {
 	ti,interrupt-ranges = <7 71 21>;
 };
 
+&main_pmx0 {
+	pinctrl-single,gpio-range =
+		<&main_pmx0_range 0 32 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+		<&main_pmx0_range 33 55 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+		<&main_pmx0_range 101 25 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+		<&main_pmx0_range 137 5 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+		<&main_pmx0_range 143 3 (PIN_INPUT | PIN_GPIO_MUX_MODE)>,
+		<&main_pmx0_range 149 2 (PIN_INPUT | PIN_GPIO_MUX_MODE)>;
+};
+
 &main_gpio0 {
+	gpio-ranges = <&main_pmx0 0 0 32>,
+		      <&main_pmx0 32 33 38>,
+		      <&main_pmx0 70 72 17>;
 	ti,ngpio = <87>;
 };
 
 &main_gpio1 {
+	gpio-ranges = <&main_pmx0 7 101 25>,
+		      <&main_pmx0 42 137 5>,
+		      <&main_pmx0 47 143 3>,
+		      <&main_pmx0 50 149 2>;
 	ti,ngpio = <73>;
 };
 
-- 
2.43.0


