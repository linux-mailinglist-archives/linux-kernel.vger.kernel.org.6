Return-Path: <linux-kernel+bounces-207528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 157F5901884
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 00:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5611F211C6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 22:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0938155885;
	Sun,  9 Jun 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="39zNmJkV"
Received: from shout11.mail.de (shout11.mail.de [62.201.172.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765043B784;
	Sun,  9 Jun 2024 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717972028; cv=none; b=XJXjmwYtDL6WU3Vvj4bYWYbEmcuSovChYBLRi2T5fj179DZ6DIZDW2kH8Ti26ISL7A+wX7QB6WR6Q/RGjVrLjRVlntmZvyMaokYt0hcQmtZ6Nxz0sD6oFM6A9UhKjD+ygcmicsd4M0QwxdDo/w+l1Oba5gaGHreuio+ZAay59Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717972028; c=relaxed/simple;
	bh=ZtpP7xUC8YMjEeXjZcAOLEg8ab3YVKQ27bfu4A7cBCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6EblUsBCBtSXuFoIiTwbhY/MQ/xJkcQ8119RhNN+dWDa7el0d+CTBYcfB7XpAa6WnUkOHHYmQUVCpCLKZ62WNx/7X/c8NtFqOVBsobpQAAuS+CVlzw6NESHGT3wAbhpqth691wN49QvUqykGI0gKFB8wQv7TLANWXqJu2NfXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=39zNmJkV; arc=none smtp.client-ip=62.201.172.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout01.mail.de (unknown [10.0.120.221])
	by shout11.mail.de (Postfix) with ESMTPS id 58201241909;
	Mon, 10 Jun 2024 00:26:59 +0200 (CEST)
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout01.mail.de (Postfix) with ESMTP id E7A32240CA5;
	Mon, 10 Jun 2024 00:26:58 +0200 (CEST)
Received: from smtp01.mail.de (smtp02.bt.mail.de [10.0.121.212])
	by postfix02.mail.de (Postfix) with ESMTP id BC489A00E2;
	Mon, 10 Jun 2024 00:26:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1717972018;
	bh=ZtpP7xUC8YMjEeXjZcAOLEg8ab3YVKQ27bfu4A7cBCw=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=39zNmJkV+bWkj90p0YJDG2lWE8SFy1O8Wu7p36sKtjy7SYtS8DdULuTH+KeKBmS/j
	 9UKh1yj26KNo8RjQ2gTqsVZ715LyCXKIf9hYBw8SVC6oApiXBKC9TVQXnC9bcZlytP
	 gECh86fb1el2d81HBfLodFhYEf5uBIrtMclucLn0F9uK3utdOF1LcByVhEx+MPNF1F
	 sv0eG9XLRlHgQJQUzq6bleoIv0hzseL8Vxtu11EzoqfgEoYgZX+2KUYuvwjCSPWKjz
	 96hCT8guoNkffurqeA5uKMlgdZ59Auoj0dbpHBye5EEB/GYqUGTetDrQV5Ul9gk6pR
	 dAWIOMIh5Fc2A==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id C327F240A27;
	Mon, 10 Jun 2024 00:26:56 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Space Meyer <me@the-space.agency>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] RK3588: FriendlyElec CM3588 NAS board support
Date: Mon, 10 Jun 2024 00:20:15 +0200
Message-ID: <20240609222428.134977-1-seb-dev@mail.de>
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
X-purgate-size: 3493
X-purgate-ID: 154282::1717972018-FED2B878-86B4AC69/0/0

Hello!

This adds support for the FriendlyElec CM3588 NAS board.
The board's device tree makes use of the latest upstream advances on the
RK3588 like USB3 DRD and GPU support as well as the latest Rockchip PCIe
driver bifurcation fixes, but some features such as thermal management
and HDMI will have to be added later when SoC support for these features
is merged.

Issues:
1) pcie3x4 BAR 1 fails to assign, see dmesg:
   pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: assigned
   pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
   pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign

2) The device enumeration of NVMe SSDs plugged into the four PCIe M.2
slots does not follow the order of the slots on the board: The slots are
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
warnings or errors, tested on Linux next-20240607.

Best regards,
Sebastian Kropatsch

---

Changes v2 -> v3:
- add vmmc-supply and vqmmc-supply to &sdhci
- remove duplicate combphys
- add 4 times the same regulator for PCIe to reflect the schematics
- fix USB vcc_5v0_host_30_p2 to use 5V as per schematics
- usb-c-connector: disable sink power delivery, enable only source mode
- &u2phy0_otg: add phy-supply
- rename some nodes
- minor fixes and some additional helpful comments (some sugg. by Space Mayer)
- collect a-b tag for patch 1
- v2: https://lore.kernel.org/linux-rockchip/20240602211901.237769-1-seb-dev@mail.de/

Changes v1 -> v2:
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
 .../rk3588-friendlyelec-cm3588-nas.dts        | 759 ++++++++++++++++++
 .../rockchip/rk3588-friendlyelec-cm3588.dtsi  | 655 +++++++++++++++
 4 files changed, 1422 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi

-- 
2.43.0


