Return-Path: <linux-kernel+bounces-259871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6FA939E87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D741F224B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1793714E2EA;
	Tue, 23 Jul 2024 10:04:01 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2014D701
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729040; cv=none; b=V/jT7Q4anRq0bEeM/jCUrczmwO5lTFWYWLzjc8SEOTcgKEnTqbGDV85juJ9VGJmzn7sNGQxz2zVCZ7FMxaFg1HN5G71DSxlV8mVkGb6OvXBg61xw0/WgPpjhufGznS3W9VQ+Cq1C/Nblqs6bdFUiHuYfhNUD48jyKn6rVJZOvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729040; c=relaxed/simple;
	bh=wqK3ZM2gH4B+wxHaNHVG4kwPF+usQdDLmeiKw9Nb0JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7+8H1o2WBimHa4qhEboU0R1iePhVKjcaC8GS0VpE+KYGIT63mlmRp7Ya2bOuCOZEtDQgFbNeKLtXhESA6GmFqhxcp5IfLq5Ooq96rqhspEgIgFNFrB3dItmxwVC1ap2GLibMpQNCcTV577VnK6u+ynV0T2kUwI3HkKsk/0slQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sWCN2-0001BC-Hq; Tue, 23 Jul 2024 12:03:48 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: ukleinek@debian.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/14] Expand available features on Qnap TS433
Date: Tue, 23 Jul 2024 12:03:47 +0200
Message-ID: <24954892.kmuVQn2iE0@diego>
In-Reply-To: <172170324698.205262.12290895401170418124.robh@kernel.org>
References:
 <20240721173723.919961-1-heiko@sntech.de>
 <172170324698.205262.12290895401170418124.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 23. Juli 2024, 04:57:37 CEST schrieb Rob Herring (Arm):
> 
> On Sun, 21 Jul 2024 19:37:09 +0200, Heiko Stuebner wrote:
> > Thanks to the nicely supported rk3568, the hardest part for adding things,
> > is to pull things from the vendor-kernel and translating them to mainline
> > standards.
> > 
> > This series allows the TS433 to use all 4 bays [0], wiggle some LEDs and
> > access devices connected to all 3 usb ports.
> > 
> > The device runs stable now and might be usable for actual usage.
> > 
> > There is still a todo-list though:
> > - the ethernet mac address for the realtek chip seems correct,
> >   but the gmac0 interface currently uses a wrong one
> > - i2cdetect reports devices on i2c-1 on addresses 54,55,56,57
> >   model_Q0B20_Q0B30_10_10.conf from the original rescue image labels them
> >     VPD_MB = I2C:0x54, VPD_BP = I2C:0x56
> >   the meaning currently being unknown. Some eeprom maybe?
> > - The regulator tree is slightly dubious. Everthing seems to follow rk3568
> >   reference designs, but especially the regulator labeled vcc3v3_sd
> >   seems to supply some PCIe functionality. So I guess the device's
> >   schematics will look quite different than the regulators added to the
> >   vendor devicetree.
> > - Quite a bit of functionality is provided by the MCU connected to uart0.
> >   According to the model.conf there should be fan-control, a number of
> >   additional LEDs (status,locate,usb?)
> > 
> > 
> > Thanks to Qnap engineers adding an easily accessible header for maskrom
> > mode on the board, replacing the bootloader is also quite a breeze. A
> > branch on top of today's u-boot master branch can be found on [1]. I'll
> > submit that code to u-boot once I can cherry-pick the dts patches.
> > 
> > 
> > changes in v2:
> > - add patches for tsadc, gpio-keys, cpu-supply, pmic, gpu and io-domains
> > 
> > 
> > [0] I only have two drives right now, but I tested both the internal
> > sata connector as well as the PCIe connected sata controller in different
> > combinations.
> > [1] https://github.com/mmind/u-boot-rockchip/tree/dev/qnap-ts433/v2024.07
> > 
> > 
> > Heiko Stuebner (14):
> >   arm64: dts: rockchip: add PCIe supply regulator to Qnap-TS433
> >   arm64: dts: rockchip: enable second PCIe controller on the Qnap-TS433
> >   arm64: dts: rockchip: enable uart0 on Qnap-TS433
> >   arm64: dts: rockchip: enable usb ports on Qnap-TS433
> >   arm64: dts: rockchip: add stdout path on Qnap-TS433
> >   arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
> >   arm64: dts: rockchip: add board-aliases for Qnap-TS433
> >   arm64: dts: rockchip: add hdd leds to Qnap-TS433
> >   arm64: dts: rockchip: enable the tsadc on the Qnap-TS433
> >   arm64: dts: rockchip: add gpio-keys to Qnap-TS433
> >   arm64: dts: rockchip: define cpu-supply on the Qnap-TS433
> >   arm64: dts: rockchip: add missing pmic information on Qnap-TS433
> >   arm64: dts: rockchip: enable gpu on Qnap-TS433
> >   arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433
> > 
> >  .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 539 +++++++++++++++++-
> >  1 file changed, 536 insertions(+), 3 deletions(-)
> > 
> > --
> > 2.39.2
> > 
> > 
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y rockchip/rk3568-qnap-ts433.dtb' for 20240721173723.919961-1-heiko@sntech.de:
> 
> arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: sata@fc400000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#
> arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: sata@fc800000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/ata/rockchip,dwc-ahci.yaml#

fixed (and queued as a fix for 6.11) by:
https://lore.kernel.org/all/20240720205705.776384-1-heiko@sntech.de/




