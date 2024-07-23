Return-Path: <linux-kernel+bounces-260366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A870793A7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6474128412A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F2143897;
	Tue, 23 Jul 2024 19:55:51 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42241141987
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764551; cv=none; b=uOFn+cq+sU9GuGFJjK+cevZrWISascT98DxqyOtDsgB7qkY3T1FRWJLV7zXBd5+G0bXEo6xoZxs4e+MhGqEvPhVxNmqd/zvNG6aEl4dgiIOFVuxLUkxRzIU2NdCFVBQVGtqOU5Q1GJYeESqmldTRuDJAFdzH5rpFus9F4FasW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764551; c=relaxed/simple;
	bh=u8SM0rH7i95R/WI+oU7QzK3ZPEOB1zEHzsWHlNNP0jA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jZcS+XaOMuMU927VQA9yzpGbztoVn9mSPT7ftwJn0IwlidSchabHOGh99ZHlv3t8yhes0Lx/RgrcOLXz2sF3AprhZ3zGQPaNJkgQoYYURqluh3xlz+GbEcyfLTwdQqnZabY1m3lYNTvKeTMnqTMa3eEvlY6O9oXjNsedTXOYopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sWLbr-0005iD-Ph; Tue, 23 Jul 2024 21:55:43 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/14] Expand available features on Qnap TS433
Date: Tue, 23 Jul 2024 21:55:24 +0200
Message-Id: <20240723195538.1133436-1-heiko@sntech.de>
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

changes in v3:
- fix the two regulator node-names, I noticed after sending v2
- add Uwe's Tested-by tags
- fold in some of Uwe's suggestions:
  - remove some phandles
  - more comments to explain what is connected where
  - handle the two RTCs in the system, though not by hacking around
    to disable the pmic-one, instead just make sure the real one
    stays the first rtc
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

 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 546 +++++++++++++++++-
 1 file changed, 543 insertions(+), 3 deletions(-)

-- 
2.39.2


