Return-Path: <linux-kernel+bounces-175511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7F08C2094
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC201C21A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A313C17165E;
	Fri, 10 May 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="BooSQd2W"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D016D4D9;
	Fri, 10 May 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332383; cv=none; b=LLHxgtnWcLtuvsY2d3pGT1aOs7BjsjJUy2y+jMgDwW++O/xXdI/DnjJLGKCE2+wmkq67CktPOptNaPhSzThjD2BKymbVY5jVVWUuxmyMMM2TvCnN/GhyrwAvCXTM+5S/dDwGDxoM1yaCcsH+6N7UE4xtxVMjws9bB4B5emWCw+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332383; c=relaxed/simple;
	bh=GQZ9Je+l+3DtSIEv/ZsJFs5g6JhcmSivLOzNUVOFScc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmPuLGGaAFJZqWppI0/PGP4v3z+IXUxXJ7iVo/L8/Y81NlYKJLB1NPbO6R13BxQN27Z88FIoJpDGWImjOzEkd01Xc4rqGOq1uT1gXLcsiRroSe3EYk52xLuuo/sCr7Za0FeeXIJ+KUUrfuzeWkVAxFFLTRupFL+dnY23LJU2t+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=BooSQd2W; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 163FE120003;
	Fri, 10 May 2024 12:12:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 163FE120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715332379;
	bh=gQ9FhGrXLgPhVgt8ePrWVQvsA5pd7mfVzSDQoNepqLM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=BooSQd2WWgBd1Q+ranGD+5mmTzkBVYop0Q3OwU25F0BW7OQANkci3KWsC/HGbteth
	 ODvHQwcemtcbZ3sJnnofiaYUVZ6QBwHtHo63L+cAKDf7fmB7MvUa7jKwzMYKgcXRiq
	 kpB488GJTatgX6HJyO7DTRJ6xE4LoxhYGjy6sgfiJ/Ad19N7Hb/09FcXiQ30ugftsR
	 3/TxSGoMoYOReOrjO5A29l8C+K1W+9WoMRe+8cVtZEAPjGd5qkvTG1e/J4azZU7Tld
	 WGY3mVLjSPsA4l8sxxYrf4l09g80WTGlULHmVMAkeG3Re9oh+OfT3JMFgyiWjhWwUC
	 eUPNUU31D5srg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 May 2024 12:12:58 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 10 May 2024 12:12:58 +0300
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
Subject: [PATCH v2 1/4] arm64: dts: amlogic: a1: add new syspll_in input for clkc_pll controller
Date: Fri, 10 May 2024 12:12:23 +0300
Message-ID: <20240510091251.20086-2-ddrokosov@salutedevices.com>
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

Input clock 'syspll_in' is needed for the 'sys_pll' clock and is
inherited from the Peripherals Clock Controller.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 93b85b26199c..feed2bd7ae48 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -889,8 +889,10 @@ clkc_pll: pll-clock-controller@7c80 {
 				reg = <0 0x7c80 0 0x18c>;
 				#clock-cells = <1>;
 				clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
-					 <&clkc_periphs CLKID_HIFIPLL_IN>;
-				clock-names = "fixpll_in", "hifipll_in";
+					 <&clkc_periphs CLKID_HIFIPLL_IN>,
+					 <&clkc_periphs CLKID_SYSPLL_IN>;
+				clock-names = "fixpll_in", "hifipll_in",
+					      "syspll_in";
 			};
 
 			sd_emmc: sd@10000 {
-- 
2.43.0


