Return-Path: <linux-kernel+bounces-180304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670B08C6CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2041B2853F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A857215B103;
	Wed, 15 May 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="JiRAtee0"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF515920F;
	Wed, 15 May 2024 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800458; cv=none; b=MmUzsc0ugT15llcYBdnji4Yb13eq00BD82TkwDDirV91kWYGhUUfxLFXWZ3+tsdtlst8DuVksKNobY3z44hUY7HelhnUxtel44E9zY8d0vpqCp/6AYFpfdvgdwqdbksZj26qmIq2xW8NdsmtO6cY+E/XUaGkiUSu/yoW+/nQ9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800458; c=relaxed/simple;
	bh=JPxSaIcJCEhzfwwCn4PZ26mkyAtBvBBkzwb9GRef39w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrZA1bQD09VyDtkU7SlRrDruHPnmBLpH0e6FRRnKMeKl6hLVSdkt6ODSPjeuEHE60C7yXEeFJZsx0V5SizJ+OxgZTamF56k6x2UpNDtSMWANaNqot6WURJiSlS/qn5x98BbBl3oaUgdYQI2ao/mJpzVbDXVqNySJ5PgbPkEr8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=JiRAtee0; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 65B9012002A;
	Wed, 15 May 2024 22:14:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 65B9012002A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715800454;
	bh=ZpnmzvxchVxol/81bNqqZ7Usi3DvPML8tgHPrv90gm4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=JiRAtee0eCPy7hhgO1tXrzkP7Toc/NeyqXJDCU/w8AI3y4AzGb5FBND7iw4sqdEKU
	 OZUeqEeA2Z9heLTK2UNEEWWBXtgHC/9FewFmX+3pkhylESuLmyUVVNJwwpx/gVRr1v
	 IK2335DfpDmoiaHEGafmwEe/hO84JarE0WB2nBSjvsVZBqfhJ7izz88vb938VO4Vza
	 ttIvINUcqJm+ySIW61oBW6Lg1972XtiQm5FIMu93R2jrVq6S5xN3st5NoSe0DJfGKK
	 8fdjtdi5mto7a+hJ7rhaJ8/l4bwr3u6Y75H1qDE70anQg4mSRoGZYyYWTP7UnwYaFG
	 JBAw4qeJj8GCg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 15 May 2024 22:14:14 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 15 May 2024 22:14:13 +0300
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
Subject: [PATCH v3 3/4] arm64: dts: amlogic: a1: add new input clock 'sys_pll' to clkc_periphs
Date: Wed, 15 May 2024 22:13:52 +0300
Message-ID: <20240515191405.25395-4-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515191405.25395-1-ddrokosov@salutedevices.com>
References: <20240515191405.25395-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/15 13:12:00 #25231738
X-KSMG-AntiVirus-Status: Clean, skipped

The 'sys_pll' input is an optional clock that can be used to generate
'sys_pll_div16', which serves as one of the sources for the GEN clock.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index afb5d7361177..f73bb7d1f381 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -747,10 +747,12 @@ clkc_periphs: clock-controller@800 {
 					 <&clkc_pll CLKID_FCLK_DIV5>,
 					 <&clkc_pll CLKID_FCLK_DIV7>,
 					 <&clkc_pll CLKID_HIFI_PLL>,
-					 <&xtal>;
+					 <&xtal>,
+					 <&clkc_pll CLKID_SYS_PLL>;
 				clock-names = "fclk_div2", "fclk_div3",
 					      "fclk_div5", "fclk_div7",
-					      "hifi_pll", "xtal";
+					      "hifi_pll", "xtal",
+					      "sys_pll";
 			};
 
 			i2c0: i2c@1400 {
-- 
2.43.0


