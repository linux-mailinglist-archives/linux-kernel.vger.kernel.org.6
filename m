Return-Path: <linux-kernel+bounces-258271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E29099385AE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8785D1F21175
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD116B39A;
	Sun, 21 Jul 2024 17:37:37 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A801F5FA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721583456; cv=none; b=KT3M98AtxeW6OeQSyceTTft57x7r8CasZLGqIUnbeRzmFnA+cCR6/NBwRzcQmPnieq39G2+qrd3uoYV4Rv03K9v2/HQ4XABOoHVfcOEuS/52WhwOJhSd5CIEtSKRHbjDXiENjmFPS8dAcfEFpSV/wL5SC/cqIg6pvoBoVdlzv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721583456; c=relaxed/simple;
	bh=riDZDNsvY+1BD0rRSouZFECLzSj7ycSOiImML3n43uA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=akV1LrB6/RuCt0uFTNw2nr/Swm6iqi+GlkvXtxxF1cUmp9635KNCMy16rW1hSPtRckQB/6eFtzHQ2Oha3tql5dmGgkP1fpMWOs3eTT07bxte9HO6OyaAFqV/vheCKkyceG0zyNdMAcYgoxPDYoTl4gujLnFnJm/lp2UcqSlftKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVaUz-00075D-7P; Sun, 21 Jul 2024 19:37:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/14] Expand available features on Qnap TS433
Date: Sun, 21 Jul 2024 19:37:09 +0200
Message-Id: <20240721173723.919961-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to the nicely supported rk3568, the hardest part for adding things,
is to pull things from the vendor-kernel and translating them to mainline
standards.

This series allows the TS433 to use all 4 bays [0], wiggle some LEDs and
access devices connected to all 3 usb ports.

The device runs stable now and might be usable for actual usage.

There is still a todo-list though:
- the ethernet mac address for the realtek chip seems correct,
  but the gmac0 interface currently uses a wrong one
- i2cdetect reports devices on i2c-1 on addresses 54,55,56,57
  model_Q0B20_Q0B30_10_10.conf from the original rescue image labels them
    VPD_MB = I2C:0x54, VPD_BP = I2C:0x56
  the meaning currently being unknown. Some eeprom maybe?
- The regulator tree is slightly dubious. Everthing seems to follow rk3568
  reference designs, but especially the regulator labeled vcc3v3_sd
  seems to supply some PCIe functionality. So I guess the device's
  schematics will look quite different than the regulators added to the
  vendor devicetree.
- Quite a bit of functionality is provided by the MCU connected to uart0.
  According to the model.conf there should be fan-control, a number of
  additional LEDs (status,locate,usb?)


Thanks to Qnap engineers adding an easily accessible header for maskrom
mode on the board, replacing the bootloader is also quite a breeze. A
branch on top of today's u-boot master branch can be found on [1]. I'll
submit that code to u-boot once I can cherry-pick the dts patches.


changes in v2:
- add patches for tsadc, gpio-keys, cpu-supply, pmic, gpu and io-domains


[0] I only have two drives right now, but I tested both the internal
sata connector as well as the PCIe connected sata controller in different
combinations.
[1] https://github.com/mmind/u-boot-rockchip/tree/dev/qnap-ts433/v2024.07


Heiko Stuebner (14):
  arm64: dts: rockchip: add PCIe supply regulator to Qnap-TS433
  arm64: dts: rockchip: enable second PCIe controller on the Qnap-TS433
  arm64: dts: rockchip: enable uart0 on Qnap-TS433
  arm64: dts: rockchip: enable usb ports on Qnap-TS433
  arm64: dts: rockchip: add stdout path on Qnap-TS433
  arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
  arm64: dts: rockchip: add board-aliases for Qnap-TS433
  arm64: dts: rockchip: add hdd leds to Qnap-TS433
  arm64: dts: rockchip: enable the tsadc on the Qnap-TS433
  arm64: dts: rockchip: add gpio-keys to Qnap-TS433
  arm64: dts: rockchip: define cpu-supply on the Qnap-TS433
  arm64: dts: rockchip: add missing pmic information on Qnap-TS433
  arm64: dts: rockchip: enable gpu on Qnap-TS433
  arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433

 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 539 +++++++++++++++++-
 1 file changed, 536 insertions(+), 3 deletions(-)

-- 
2.39.2


