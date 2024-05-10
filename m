Return-Path: <linux-kernel+bounces-175510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D6A8C2092
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284191C21C17
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91E16DED7;
	Fri, 10 May 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SB7tzLbj"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C7161319;
	Fri, 10 May 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332382; cv=none; b=AkgTzXlWDgdAUXkBzvTRnWGme6lr44tQ4GH7xjZnqdgZbTz1LY2ootSbQCTziq3/OwEmTTxQMPe4dMlMWW3LWJ1UXS490a9XdNrtmlVsaeTABu4yhqBR+6/NnecmxK1G7FbqbkotXvjo1OJcn2NrAX0ieQCdy2rDBA+3sAtIjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332382; c=relaxed/simple;
	bh=cTKxscI9A++NK2Pmbc+uA3RQJfbfkFblF1fla3Oe618=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5ksEWJPgnWQ8F2pL2kUsJI7MvEcupPNfkrUDmHmP5s7ZHUsOAGwJzgfT48OgdCY9gyKNw38ghsnuZn/MxuagCEO9ZS+nP2AC3NfBCXdQE+bRE+lnZOjS9AZbLg776K9PB7ofkWfS2VRCe192vgL3GuG8D20Bmww+lDYu+Qxdjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SB7tzLbj; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8CCEF100006;
	Fri, 10 May 2024 12:12:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8CCEF100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715332378;
	bh=bQgoaZsfgswFdd7mMDy6KL8G+EznVwjqFXmnJMgJs34=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=SB7tzLbjeRYjJr5ZPWIDixYFHw1uxlnctqwlLu7W8pdJ8OFyzjyH/JW2skgB5NZgN
	 Zn+2G851sjzl2LkP1eTc+JRgC2Ibo5WjPwzPUzK0pc9yqkNfsk8nZ1xe5jUYYuoBYM
	 KzYDvhqZGPAvUMc3PtXsUtjo7iK7WFkke9T0oBb1Xl8m65nS5ijb+gyrcniQUIiR+9
	 LcQ/D7z+wBP3O9R5OHLv3sZZehB3AAdbga4b07xum7gSs/fKtreBja1pKkS4U++WXi
	 v13x7Gd2MYtOC1YIVXFd+ghnP53iZCn/lyoEvz4zlnFuR+MTn2zI4IIpCBJWqCDMlF
	 FIMKN5Hb/QvOw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 May 2024 12:12:58 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 10 May 2024 12:12:57 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v2 0/4] arm64: dts: amlogic: a1: Support CPU Power Management
Date: Fri, 10 May 2024 12:12:22 +0300
Message-ID: <20240510091251.20086-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185158 [May 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/10 08:35:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/10 08:36:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/10 07:36:00 #25144647
X-KSMG-AntiVirus-Status: Clean, skipped

The Amlogic A1 SoC family utilizes static operating points and a
PWM-controlled core voltage regulator that is specific to the board. As
the main CPU clock input, the SoC uses CLKID_CPU_CLK from the CPU clock
controller, which can be inherited from the system PLL (syspll) or a
fixed CPU clock.

Currently, the stable operating points at all frequencies are set to
800mV. This value is obtained from the vendor setup of several A1
boards.

The current patch series includes:
    * CPU clock controller declaration
    * syspll setup in the PLL controller
    * operating points
    * CPU special power parameters: voltage-tolerance, clock-latency,
      capacity-dmips-mhz, dynamic-power-coefficient

Please be informed that the AD402 vddcpu PWM regulator does not exist in
this patch series because currently PWM A1 support is under development.
However, it should look like:

```
vddcpu: regulator-vddcpu {
	compatible = "pwm-regulator";
	pinctrl-0 = <&pwm_f_pins4>;
	pinctrl-names = "default";
	regulator-name = "VDDCPU";
	regulator-min-microvolt = <690000>;
	regulator-max-microvolt = <1050000>;
	pwm-supply = <&dc_12v_in>;
	pwms = <&pwm_ef 1 1500 0>; // 667kHz
	voltage-table = <1050000 0>,
			<1040000 3>,
			<1030000 6>,
			<1020000 8>,
			<1010000 11>,
			<1000000 14>,
			<990000 17>,
			<980000 20>,
			<970000 23>,
			<960000 26>,
			<950000 29>,
			<940000 31>,
			<930000 34>,
			<920000 37>,
			<910000 40>,
			<900000 43>,
			<890000 45>,
			<880000 48>,
			<870000 51>,
			<860000 54>,
			<850000 56>,
			<840000 59>,
			<830000 62>,
			<820000 65>,
			<810000 68>,
			<800000 70>,
			<790000 73>,
			<780000 76>,
			<770000 79>,
			<760000 81>,
			<750000 84>,
			<740000 87>,
			<730000 89>,
			<720000 92>,
			<710000 95>,
			<700000 98>,
			<690000 100>;
	regulator-boot-on;
	regulator-always-on;
};
```

This patch series depends on [1].

Changes v2 since v1 at [2]:
    - remove holes from the beginning of cpu clock controller regmap
    - move sys_pll_div16 to the end of the clocks list

Links:
    [1] https://lore.kernel.org/all/20240510090933.19464-1-ddrokosov@salutedevices.com/
    [2] https://lore.kernel.org/all/20240329210453.27530-1-ddrokosov@salutedevices.com/

Dmitry Rokosov (4):
  arm64: dts: amlogic: a1: add new syspll_in input for clkc_pll
    controller
  arm64: dts: amlogic: a1: declare cpu clock controller
  arm64: dts: amlogic: a1: add new input clock 'sys_pll_div16' to
    clkc_periphs
  arm64: dts: amlogic: a1: setup CPU power management

 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 70 +++++++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

-- 
2.43.0


