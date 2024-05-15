Return-Path: <linux-kernel+bounces-180301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9E18C6CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38D41F21C30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989C15ADB0;
	Wed, 15 May 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ogkPrCcr"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A1446AC;
	Wed, 15 May 2024 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800457; cv=none; b=oG/szs1Y8E/yeIDGr09Jk6gTRyJd9bR/JO9RzTfvxzSeQpBMEkqXaShWzGwKhTkKifdG1+vmJSpSXv6vALbakJi1vl3oAollk4AF9Dn6CXurjZZhB5WQrrHoMz0eZEFnmO3iqC2K4dKN977OSWMMy/cRIY0L42usY+W/nmwiaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800457; c=relaxed/simple;
	bh=SIaYPtAmZYzaVPwYzy+qBnZV2xxtM7JyJlPkIEJKfyc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CvPfi6UU1JPpyH76JSOLk6x1YknaOb5WH6S/6YPvZI/E+RoHI8vNoTazH2ZO4Jdf6HukELv0Ou4NFTDL+3tHtkdnNcVg7baBVLRg/iA//GgUy9+a5PflOWsS/rtCXoxawms/NGe94qIGYrxfsRxEB/lzup0DJK+zvLtqldEP+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ogkPrCcr; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3791610002D;
	Wed, 15 May 2024 22:14:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3791610002D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715800452;
	bh=yh36czi3oiCiH74hnOG7P+ArHnzezMkpMG45lt+1orI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ogkPrCcrKyO61s28WFqtpPmAzLZ+8RRCcNyLeipRWtiAB9OgSZHEjhx+nxfVZP2Yo
	 2Jc3u0nVSA06D379coLls8r/YC4trQbkLdIk3gnkZtyG/W33mD6bKJ+Jf5OIvfqWgB
	 /pW9qJDa0iIcD3W77VwcICQI86RnnxsByZtS4YC9kC/blMxg9GV4hw3jbDvYhNHxOh
	 bRjuAtV5Z9TB8EIaClVXUfaiX4AKjJ8LidnYjwRTDkoJQX83pQXezWIj1G9Z0uhQsR
	 +YrY/Sqlfx0K3GrU5WA0gaJ1eE0yUHuA4KrrMRZPML590LSNOggar3L/qSjUfh8zrp
	 hgJ5+yhJIf8zg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 15 May 2024 22:14:12 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 15 May 2024 22:14:11 +0300
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
Subject: [PATCH v3 0/4] arm64: dts: amlogic: a1: Support CPU Power Management
Date: Wed, 15 May 2024 22:13:49 +0300
Message-ID: <20240515191405.25395-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185260 [May 15 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/15 12:35:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/15 18:39:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/15 13:12:00 #25231738
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

Changes v3 since v2 at [3]:
    - move sys_pll_div16 clock from a1-pll clkc to a1-peripherals clkc
      as Jerome suggested, so dt connection is changed too

Changes v2 since v1 at [2]:
    - remove holes from the beginning of cpu clock controller regmap
    - move sys_pll_div16 to the end of the clocks list

Links:
    [1] https://lore.kernel.org/all/20240515185103.20256-1-ddrokosov@salutedevices.com/
    [2] https://lore.kernel.org/all/20240329210453.27530-1-ddrokosov@salutedevices.com/
    [3] https://lore.kernel.org/all/20240510091251.20086-1-ddrokosov@salutedevices.com/

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Dmitry Rokosov (4):
  arm64: dts: amlogic: a1: add new syspll_in input for clkc_pll
    controller
  arm64: dts: amlogic: a1: declare cpu clock controller
  arm64: dts: amlogic: a1: add new input clock 'sys_pll' to clkc_periphs
  arm64: dts: amlogic: a1: setup CPU power management

 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 70 +++++++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

-- 
2.43.0


