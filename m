Return-Path: <linux-kernel+bounces-198447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BE98D7847
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312A4281412
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825986E619;
	Sun,  2 Jun 2024 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="JiLWe6aO"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53859EDF;
	Sun,  2 Jun 2024 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717363875; cv=none; b=heoWNSSXHP1qwqLlz232hdhLGIhwDl9duL1Wa+SZLUpDfnGRSCyufWJ2UZKGDuPVK+rQ/yBvVRRm2E8JtdV5jALaUgftPWORDKd/3ugq8Bjn2n6cQZHMRYKf0xC8tjwx5+Tawh9Jlw0kDVh7SOjuXFsUcEVNsR6s5ZTRzGHYY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717363875; c=relaxed/simple;
	bh=QGydLqg5nD7goLUdbsX1bHCF1IzK/yJxggqZg1PvGhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TURl7SBJx1jSuU9rXoK4VudqVSbaQNKF7WDXDHVsQlmbDrmqRrBpfYazmuljs6doRG5rRijQQIjn4U/GPKCWKTfqXAMOAsj1s2+Nf9DhjsINpoVbecwffELdwrkZVtmtSxEM599sRKA6Cr/8aAo+OkklQQKP+Q0OWRKdjVSzS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=JiLWe6aO; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
	by shout12.mail.de (Postfix) with ESMTPS id 5EC0C240AF1;
	Sun,  2 Jun 2024 23:22:33 +0200 (CEST)
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
	by shout02.mail.de (Postfix) with ESMTP id 3D0A3240BF0;
	Sun,  2 Jun 2024 23:22:33 +0200 (CEST)
Received: from smtp01.mail.de (smtp04.bt.mail.de [10.0.121.214])
	by postfix03.mail.de (Postfix) with ESMTP id 1AC1C80065;
	Sun,  2 Jun 2024 23:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1717363353;
	bh=QGydLqg5nD7goLUdbsX1bHCF1IzK/yJxggqZg1PvGhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=JiLWe6aOXiY8MqxPHwwnpommmxQuAzd9xnFV9HqgiODg0WYoFanwH2ubKSGTvfQAn
	 r1EYSOfAzkEt2yOmIQmLqProJwZRKOVjSt9LEWzs2B75Q0mVv+5hCftr8cShGio/Ef
	 K0BXKnT3UOUxAYfX98s2xDdOMHCzHDzmchEev/TkUqkUubgFs/ehDMukTuWlOX+MSO
	 IqQco5uLmKjzJVL2aHtgGiJsoUmFUCF6xB/zA+l/6Hb2HOWq9Q9u5tSkohwQK8pNT0
	 gclExeVxIc9FrsrZ7ipI0UViFgfF92OO67qdWre1j4AAiHeUYPlSuSTuOkNFhlnUpI
	 1u4H5WACYCLtA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 1721F2409AB;
	Sun,  2 Jun 2024 23:22:28 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sebastian Kropatsch <seb-dev@mail.de>
Subject: [PATCH v2 0/2] RK3588: FriendlyElec CM3588 NAS board support
Date: Sun,  2 Jun 2024 22:08:18 +0200
Message-ID: <20240602211901.237769-1-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2883
X-purgate-ID: 154282::1717363352-1CB7D338-9AE4CCBC/0/0

Hello!

This adds support for the FriendlyElec CM3588 NAS board.
The board's device tree makes use of the latest upstream advances on the
RK3588 like USB3 DRD and GPU support as well as the latest Rockchip PCIe
driver bifurcation fixes, but some features such as thermal management
and HDMI will have to be added later when SoC support for these features
is merged.
Since the hardware has similarities with FriendlyElec's NanoPC T6, the
device tree for the CM3588 NAS took some inspirations from and also
partially shares some sections with the NanoPC T6 tree.

Minor issue:
The device enumeration of NVMe SSDs plugged into the four PCIe M.2 slots
does not follow the order of the slots on the board: The slots are
physically named from 1 to 4, top to bottom. However, they do not show
up in this same order in Linux when all slots are polulated:
   - SSD in physical slot 1 shows up as nvme0
   - SSD in physical slot 2 shows up as nvme2
   - SSD in physical slot 3 shows up as nvme1
   - SSD in physical slot 4 shows up as nvme3
This is the same order in which the data lanes are mapped for PCIe
bifurcation (dts property: data-lanes = <1 3 2 4>).
I could not solve this by using aliases for the PCIe nodes in the device
tree. Perhaps this is something that can only be solved at driver level?
I am not sure if this behaviour is even considered a bug or if this is
intended behaviour by design.

Devicetree validation:
`make CHECK_DTBS=y rockchip/rk3588-cm3588-nas.dtb` does not give any
warnings or errors, tested on Linux next-20240523.

Best regards,
Sebastian Kropatsch
---

Changes in v2:
- split dts into two files (CM and carrier board)
- rename fixed regulators with preferred 'regulator-' prefix
- use preferred 'gpios' property instead of 'gpio'
- add 'pinctrl-names' property for every pinctrl
- add several pwm nodes
- drop HMDI PHY and VOP support
- drop unneeded &wdt node
- remove i2c4 since it's not availabe according to the schematics
- &sdhci: drop 'full-pwr-cycle-in-suspend' flag
- &sdmmc: drop 'cap-mmc-highspeed' flag because of no-mmc
- &sdmmc: drop 'cd-gpios' property, unneeded w/ using sdmmc_det pinctrl
- &usb_host0_xhci, &usb_host2_xhci: remove default 'dr_mode' property

---
Sebastian Kropatsch (2):
  dt-bindings: arm: rockchip: Add FriendlyElec CM3588 NAS
  arm64: dts: rockchip: Add FriendlyElec CM3588 NAS board

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rk3588-friendlyelec-cm3588-nas.dts        | 705 ++++++++++++++++++
 .../rockchip/rk3588-friendlyelec-cm3588.dtsi  | 660 ++++++++++++++++
 4 files changed, 1373 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi

-- 
2.43.0


