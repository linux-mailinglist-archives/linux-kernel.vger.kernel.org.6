Return-Path: <linux-kernel+bounces-175513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E638C209A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EBC1C21C62
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5772016D4D9;
	Fri, 10 May 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="jxlqELik"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25F171672;
	Fri, 10 May 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332385; cv=none; b=ISavljd1sSstUHIr9E4RHFX6PtWNN9vsXtkY9YqsCg3S5OpeOWgGGkwTm3mhf9GkBH1bHVcyfd7NkXnZkC/9FbOuq2XSgxBtH4BcGfsQ0F04g2PYC1r1dvBV405Uo7RpIgXZAAwiMRy5Ovri3Sh4X7/fCK24KMKiGeBEkUj6HYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332385; c=relaxed/simple;
	bh=z+Mptn/z7ZKJXSU33cdkBzJukmEjIK07JNvDqa5zQ2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMr6LEk0fU241u2gPRLdfxbc5TCGcSLD7n04wop5Go8mPgpC7gqIGpsNnstpl1smWx3K38GY0iOodgM5Phwa4nUunlgbDMk4nuyuk81k6PKyNI7dluIgdo7Tl5ZY4frJtqmsLeUBfGhm5zNdsxZiyZcnM/+z1KOhaWG0XE1oqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=jxlqELik; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BC1DD120006;
	Fri, 10 May 2024 12:13:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BC1DD120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715332381;
	bh=JSRcxYPeGuJ4x/7rMS2s6r0b5V5PwlUZiy7xcqffNMg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jxlqELikL32otCnH3MZUQY1WzhJo/wsNGLfuEnhTJIyZOrMx/4Lk7lcJYZTa6qobb
	 oyap/BamCL40it5+LKoACbRL835RkqIbHW26QTLM8c1m3vhVYGqE+Qp9186KjO9XBh
	 gOFWytrFpamEIFrKMljkA62F3WD8rTZJtEKe7Z+59Mp4KzYWGzIqVy/IZ2iTot/vSu
	 PQA3fLCG/FQkAdls6ajP+bDzaujiYiBwstRtmGijURR+eUaC9QFG5MpGYIwg3OICiH
	 ISpVuuNOc7FctuFUlkBn622gSznGxfP1Q86qFo+AVh9RZUy41bLo/aRHFmOlJK/cOZ
	 KzLteD969iIcQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 May 2024 12:13:01 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 10 May 2024 12:13:01 +0300
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
Subject: [PATCH v2 3/4] arm64: dts: amlogic: a1: add new input clock 'sys_pll_div16' to clkc_periphs
Date: Fri, 10 May 2024 12:12:25 +0300
Message-ID: <20240510091251.20086-4-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510091251.20086-1-ddrokosov@salutedevices.com>
References: <20240510091251.20086-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/10 07:36:00 #25144647
X-KSMG-AntiVirus-Status: Clean, skipped

The input clock 'sys_pll_div16' is a clock with a fixed ratio inherited
from the main system PLL.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index afb5d7361177..785778f3a7da 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -747,10 +747,12 @@ clkc_periphs: clock-controller@800 {
 					 <&clkc_pll CLKID_FCLK_DIV5>,
 					 <&clkc_pll CLKID_FCLK_DIV7>,
 					 <&clkc_pll CLKID_HIFI_PLL>,
-					 <&xtal>;
+					 <&xtal>,
+					 <&clkc_pll CLKID_SYS_PLL_DIV16>;
 				clock-names = "fclk_div2", "fclk_div3",
 					      "fclk_div5", "fclk_div7",
-					      "hifi_pll", "xtal";
+					      "hifi_pll", "xtal",
+					      "sys_pll_div16";
 			};
 
 			i2c0: i2c@1400 {
-- 
2.43.0


