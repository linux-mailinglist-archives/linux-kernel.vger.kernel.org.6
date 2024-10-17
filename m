Return-Path: <linux-kernel+bounces-370482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A39A2D65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE8E1C23086
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FE221BAF3;
	Thu, 17 Oct 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="E+NvFb8S"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5D21D17B;
	Thu, 17 Oct 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192191; cv=none; b=ffzOeeSIJS7DoNuu+VupPzeUpR4k/XxFzXFKLLaqyEd6/QUHl3JUZp50R2Np+G8XtlPYt3qhv6tmRnn4GjZuUv68GjIQqjPO7XKg+wMki539HJM9bjdsvbVTCVTO3pES0yOOE+nN+FXDhM1X8h7N6CXwDDS4+8muFZAmnSxd08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192191; c=relaxed/simple;
	bh=a2ngOE9pZh2AkpcrV/7hwnsX0CaivApvLgp7ULpnE3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naGTmpIdvGP4dlJ3AFUYbXSH4BHG2nnvpOLszREUOFUAYDkePJSfJ72M4SHtJzoh8xbzJH5pPLF9kuka1MIgbzhIcyVzTfAHpQ8sE5hP2fu120rjq3hfE8AcC7GcaO54rSvdVY3xRjVnPRSu1HkrwHH1pq3sSGf3V0a+zwx6w3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=E+NvFb8S; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D4C5589024;
	Thu, 17 Oct 2024 21:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729192184;
	bh=V1K0rrehWqifWgC92YbC5mRbc/LwHLiXPIyw+pJanAM=;
	h=From:To:Cc:Subject:Date:From;
	b=E+NvFb8SWxJ0DS7Xhihi+no/YM3kBbIrS+1mKfttRW48VU7JtQAwVZFETXKf37Oc1
	 BIIdICDeWSIOJvbKekLWzdYXcFqP2x/tNZgMdd/8YshtIwQccB8LOK3lr9P9dUTCaM
	 TukrLy1PHwJ0FV0QpPwY0l5BdGdUyLraTAjlba2rHqxMvB6aEaXKgoRIsLTPIj//Gk
	 1sH7qqHX+qFncutU5foEQrnrMIeYmTXdXEqsZXOWOB5SuaiWbnryixlMxXiHNFTEJ1
	 jfMGj0J6BriRDwoYrj/iykhQaKF9pgscn3zMxxt7k/3MPYUHrafw0rdQsp7s45ordx
	 RWFyaThCZGpjw==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] ARM: dts: stm32: Describe M24256E write-lockable page in DH STM32MP13xx DHCOR SoM DT
Date: Thu, 17 Oct 2024 21:09:18 +0200
Message-ID: <20241017190933.131441-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The STM32MP13xx DHCOR SoM is populated with M24256E EEPROM which has
Additional Write lockable page at separate I2C address. Describe the
page in DT to make it available.

Note that the WLP page on this device is hardware write-protected by
R37 which pulls the nWC signal high to VDD_3V3_1V8 power rail.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: kernel@dh-electronics.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
---
V2: Fix up the M25256E in Subject
---
DEPENDS:
- https://lore.kernel.org/linux-i2c/20241017184152.128395-1-marex@denx.de/
- https://lore.kernel.org/linux-i2c/20241017184152.128395-2-marex@denx.de/
---
 arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi b/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
index 5c633ed548f37..07133bd82efa6 100644
--- a/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi
@@ -202,6 +202,12 @@ eeprom0: eeprom@50 {
 		pagesize = <64>;
 	};
 
+	eeprom0wl: eeprom@58 {
+		compatible = "st,24256e-wl";	/* ST M24256E WL page of 0x50 */
+		pagesize = <64>;
+		reg = <0x58>;
+	};
+
 	rv3032: rtc@51 {
 		compatible = "microcrystal,rv3032";
 		reg = <0x51>;
-- 
2.45.2


