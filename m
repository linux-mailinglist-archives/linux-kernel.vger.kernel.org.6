Return-Path: <linux-kernel+bounces-185506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49808CB5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121DC1C21A59
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C1F14A4C5;
	Tue, 21 May 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="azYnNpfp"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05B149DE5;
	Tue, 21 May 2024 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330189; cv=none; b=pnoYdc2uuyhCfRkaISTgOJjztSUwW3YBMj3OVpzcJhe7f+axg6kj9bXEusfIGsTERdt5Bn5JQQTwU+LSXyAAj6Tpk7357TikIIZ2aHPL8IixSkAj4PJ+TdXCbQlBk03Eqc3pDt+Ftk1kgQ/OCb+69clhpy62FbY2btbUa0c3X8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330189; c=relaxed/simple;
	bh=lT0go+khrIBtFYj4jcepsMnSbYwOAjo0s7O87/hfYSE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GBwyx45sOQjK/TmqgqDcM+zrEjgDLtMWz6/G3jNUYchBACKBodyRZ11LJ5SQxrH3FVeFx4AQhmalKHT2hSmcC97B5op5YbFERbDcYI2Hc2MygXfiS2AwRfoEh32NbW8l9zTkg8osAKU+3SV5neMbescXQqOnX1oLyQA1EtrRLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=azYnNpfp; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B98B1100013;
	Wed, 22 May 2024 01:23:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B98B1100013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1716330183;
	bh=CZg76scw7v97dA0RfUhhSpMZL+RjQmhtnVdo0IGU76s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=azYnNpfppiSYmIT828TB71EKKKOpRNG//yHacsHcbgs4+t4RXrVevSBAPpzyYPOC0
	 HcQArDScq+RvxC+Tr/db5qO56fQSilYqkT9s7n6Gp1Zt1ZundkxvFHsR5qcsNLPlIl
	 7ENARXbh6mlDzEJaIsPP6rO60LNgsrvwfnx2qzSMHdqJnHxEKd/Fi5ZqwDm5upqFuM
	 M+7QVo+dNIHPiC5YTE4u6YO5R/V3+oYNphQCo7c8AKWIoG2FkPn7JBbSuQKRYlfzxw
	 yltDNktVf81Gdtuf65FnkryDPsuA2qN4P2C6RaUIQXgnzqkKCQ/egH0YUx5VC/w9Un
	 fuyxWrY4HSHvg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 22 May 2024 01:23:03 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 May 2024 01:23:03 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Dmitry Rokosov
	<ddrokosov@sberdevices.ru>, Jerome Brunet <jbrunet@baylibre.com>, Kevin
 Hilman <khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Lucas Tanure <tanure@linux.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Xianwei Zhao
	<xianwei.zhao@amlogic.com>
Subject: [PATCH 0/3] Introduce initial support of Amlogic AC200 board
Date: Wed, 22 May 2024 01:21:52 +0300
Message-ID: <20240521222155.28094-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
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
X-KSMG-AntiSpam-Lua-Profiles: 185400 [May 21 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_smtp_not_equal_from}, sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/21 08:41:00 #25230763
X-KSMG-AntiVirus-Status: Clean, skipped

 - Make some cosmetics in existing device tree files;

 - Add the board.

Jan Dakinevich (3):
  arch/arm64: dts: ac2xx: make common the sound card
  dt-bindings: arm: amlogic: document AC200 support
  arch/arm64: dts: ac200: introduce initial support of the board

 .../devicetree/bindings/arm/amlogic.yaml      |  1 +
 .../dts/amlogic/meson-sm1-a95xf3-air-gbit.dts | 87 -------------------
 .../boot/dts/amlogic/meson-sm1-a95xf3-air.dts | 87 -------------------
 .../boot/dts/amlogic/meson-sm1-ac200.dts      | 22 +++++
 .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     | 87 +++++++++++++++++++
 .../boot/dts/amlogic/meson-sm1-h96-max.dts    | 87 -------------------
 .../dts/amlogic/meson-sm1-x96-air-gbit.dts    | 87 -------------------
 .../boot/dts/amlogic/meson-sm1-x96-air.dts    | 87 -------------------
 8 files changed, 110 insertions(+), 435 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-ac200.dts

-- 
2.34.1


