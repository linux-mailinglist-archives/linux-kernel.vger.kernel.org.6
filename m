Return-Path: <linux-kernel+bounces-216515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACDD90A062
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 00:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEA41C21337
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D436E61F;
	Sun, 16 Jun 2024 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="G4coktvc"
Received: from shout11.mail.de (shout11.mail.de [62.201.172.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64D6E60E;
	Sun, 16 Jun 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718575067; cv=none; b=lt0OySqc/cQrxvcboNpDUwOEu8al/aBGqMBlh569q5kPXIl9RQsJWbgGZfstpx9bGlMQcIdrSkVq1HzvS79FmuIN0lJgao0Qxqd0kmo2A3pQu6DGkWbnKd2aSzSmAqDi/BpZf4nMgTI6eHmKCIEhy2V5q0ECRQyE5q6Nj7hQK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718575067; c=relaxed/simple;
	bh=VA9M7v4eEcTFIGe9sguFMYB03s/n6Nk/uy2b91FlJMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTfdH3xIsrsjhJ6xhXfYhLHF8Fd0R++c/q1iaBloBEA78441kaokcMs9N9dwiA44VOrwnTo8p0oYeY8kc7GdIzz18ThHGGY4lE9ra78XXFyDMn5aPzJSL9XL1PjifmrNvmyYPS5oZigSz8/f/AwyvO8cSRCjLrPmB72hegS8CKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=G4coktvc; arc=none smtp.client-ip=62.201.172.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout01.mail.de (unknown [10.0.120.221])
	by shout11.mail.de (Postfix) with ESMTPS id 108F2240BD1;
	Sun, 16 Jun 2024 23:57:38 +0200 (CEST)
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
	by shout01.mail.de (Postfix) with ESMTP id E3765240D0B;
	Sun, 16 Jun 2024 23:57:37 +0200 (CEST)
Received: from smtp01.mail.de (smtp04.bt.mail.de [10.0.121.214])
	by postfix03.mail.de (Postfix) with ESMTP id BDAE880226;
	Sun, 16 Jun 2024 23:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718575057;
	bh=VA9M7v4eEcTFIGe9sguFMYB03s/n6Nk/uy2b91FlJMk=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=G4coktvcMtVw+tiddomq0c4jR1B1K91yJqg+f3MKtBTyIV9RMBs3oHFqWRqS3zCdR
	 2P0cHlWoM5so8+2k+ARxneMpqCsHp08mDZ3svfHSJz2rWQeD4zL2NKORyMR5R4Dr3K
	 ioQ/+TYCCwGecvpbXZ242PELgeFTrJutrMGsoEYw2LecLKqMM/KOfYEu50762G1h9K
	 golqrngvpN3fLsU1qXpblqLG1YMsmAmv213Y4IszVGbu1FiUH7ysh3S9gHzamvYY4O
	 Ozw/+stSXpcHMHiw8+XFnsYLKu/0GdQeNynt9hN54jZj0Bp0CeX0NkEacotkh8jn1o
	 orxecWhCs/3bg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 79138240AC4;
	Sun, 16 Jun 2024 23:57:33 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] RK3588: FriendlyElec CM3588 NAS board support
Date: Sun, 16 Jun 2024 23:48:28 +0200
Message-ID: <20240616215354.40999-1-seb-dev@mail.de>
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
X-purgate-size: 3762
X-purgate-ID: 154282::1718575057-057EB338-7BB368A9/0/0

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
warnings or errors, tested on Linux next-20240613.

Cheers,
Sebastian

---

Changes v3 -> v4:
- add pwm-beeper node
- add ir-receiver node
- leds: remove deprecated label props
- usbdp_phy0: add mode-switch prop
- minor fixes/comments
- collect r-b tag for patch 2
- v3: https://lore.kernel.org/linux-rockchip/20240609222428.134977-1-seb-dev@mail.de/

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
 .../rk3588-friendlyelec-cm3588-nas.dts        | 778 ++++++++++++++++++
 .../rockchip/rk3588-friendlyelec-cm3588.dtsi  | 653 +++++++++++++++
 4 files changed, 1439 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi

-- 
2.43.0


