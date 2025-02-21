Return-Path: <linux-kernel+bounces-526662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721ADA401C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB8E3B5CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8B9253F06;
	Fri, 21 Feb 2025 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Jv+cISC5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DqzVx0ug"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69732253B62
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171909; cv=none; b=GJ3M26RFLJd1V/2d2kHQG9HMYLBCBKk5XTfdO54peYQ97hSrZptT5NUP7nr/vtlFi949X0BGXi0JZa7RchOeeAlBdu6OeO0fmb+9T645eC56VG/pW/AR7PY8XigleumvmV/WV6TcH5ML2cxV6UipxB+qGa2O850iRkENTEMTFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171909; c=relaxed/simple;
	bh=zCf1fGnjwEaXW2uXPOmlkzNxN8T0BhAcjoGULfwsoXE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=D0buArYXUT09CIC6Em8Exr+d2S1R20zCg4FC3nqow0KOUirBeNdq/X8qR7fpZpdu2gJXPEHOoaiKDu3ch4jX+Sst4wlBy1gVHD8yFQf5ke8V1nR9o32sSHxxpuhh7gV0Ds7Gvb45v3+BLdgZSepqZCVNrja4rOZj4KfSwEuFR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Jv+cISC5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DqzVx0ug; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 53954254016F;
	Fri, 21 Feb 2025 16:05:04 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Fri, 21 Feb 2025 16:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1740171904; x=1740258304; bh=h6
	S9aTUxsv5QV59pv6B0q9blu0YqRJjwoZGl3ssFhSU=; b=Jv+cISC5xfPQU8CRNL
	PO+ja6DMGHvkZlDsfvt5HlVjtcWJ6navKlqE/KLH5RBQERqXxb4rMWoQtwnumrgr
	3O+JhfP4ERA7Q5/tcHe1MmnX8lRzt9hxHyZUvx0v1XmdyktCMurKXhCZ2L2L6K2H
	ujEqu8cUbwtvJsrcUBRG4XvVD1E8d8H53vpWWF5B/AO0z5BNmZ27wqSGPDMl+XKH
	nwTsy3gD4ivesin8tYkfvzSQkjATt8HJILrSTcTtzXwQru4JhXwjbSd3AiAzjALu
	iyXwIKy/Y1cW9wnL+0DawyYjW2YgW3VvtY7MdagC45+CASYtwaTKtH1L4ypOOqfE
	ZgcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1740171904; x=1740258304; bh=h6S9aTUxsv5QV59pv6B0q9blu0Yq
	RJjwoZGl3ssFhSU=; b=DqzVx0ugVyIb8qBSu+M4FGkp5v9tMwwHvWTlh5V7++DA
	gzasp6in3Y5bSe0oG7ECEtRa9UF+8lMyN0jnPmqSU+JIPAehDdfjJCsCwJzgaDX2
	fYRQuSzBRglWSCLQ0Sle/IYerRNaWajzFxM80Zj0Um9HAUWgYmOiRPIq2Lx1YFm5
	/qFYNevut0aTiSxpRbfqs7TMadMjVmJZQb+NxOYImZN7XVPEyQ6OweT52aTEehZs
	k8g/S+5Pa22psqXQiPJo18BKJt8lw1wrQAosHl+7gGEZOHgIdjH949AVkEQoC818
	eGpSfqu3hntbLqRO8VF5S7WHl85d8H0E//ol+4noyQ==
X-ME-Sender: <xms:f-q4ZwtfKpsYRlHykYaB-GA8n1Cx-zjmYVf5QgD3atSqDdLw-jCphQ>
    <xme:f-q4Z9d1iJI86qgjJ_G89LDJFftT8enB8zi6kWuqopVzltcpV4vDBSuz7r3K_Z2ff
    TTbN4V48-SKQHlzwcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejuddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeduleeigeekveeugeettdejtddtleeghefhvdfhueeh
    tefhudelffduvdeuleevteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopehsohgtsehlihhsthhsrdhlihhnuhigrdguvghvpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:f-q4Z7yujQmmDw9RvvXZ3r4p7oOCCP3IyGmdgL7vcTCJN9g0FY4WxA>
    <xmx:f-q4ZzO6g76F2WFZyP1jrzEVqMSsDSUFPaQwgiw_-77RC_N0_lPquw>
    <xmx:f-q4Zw_ep5QPPzB3j9DYCjO1Gv-W9Z_2_2bR8LQnF791rtJ7k3lmsw>
    <xmx:f-q4Z7WitVULrcEx5XD3U1MjNpw7inadO1V1qsMicctRuYWl6-7zLA>
    <xmx:gOq4Z_bJSbHscvxf3Q4rYO7clnJ662l20fclJBnQtEt0A2O3BzoMPLHm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A518D2220074; Fri, 21 Feb 2025 16:05:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Feb 2025 22:04:42 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-Id: <22f7e0e5-1ccc-41bf-a474-6cd09b23a26f@app.fastmail.com>
Subject: [GIT PULL] soc: fixes for 6.14
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.14

for you to fetch changes up to e31e3f6c0ce473f7ce1e70d54ac8e3ed190509f8:

  soc: loongson: loongson2_guts: Add check for devm_kstrdup() (2025-02-20 22:29:05 +0100)

----------------------------------------------------------------
soc: fixes for 6.14

Two people stepped up as platform co-maintainers: Andrew Jeffery for
ASpeed and Janne Grunau for Apple.

The rockchip platform gets 9 small fixes for devicetree files, addressing
both compile-time warnings and board specific bugs.

One bugfix for the optee firmware driver addresses a reboot-time hang.

Two drivers need improved Kconfig dependencies to allow wider compile-
testing while hiding the drivers on platforms that can't use them.

ARM SCMI and loongson-guts drivers get minor bugfixes.

----------------------------------------------------------------
Alexander Shiyan (1):
      arm64: dts: rockchip: Fix broken tsadc pinctrl names for rk3588

Andrew Jeffery (1):
      MAINTAINERS: Mark Andrew as M: for ASPEED MACHINE SUPPORT

Andy Yan (1):
      arm64: dts: rockchip: Fix lcdpwr_en pin for Cool Pi GenBook

Arnd Bergmann (3):
      Merge tag 'v6.14-rockchip-dtsfixes1' of https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into HEAD
      Merge tag 'ti-k3-config-fixes-for-v6.14' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into HEAD
      Merge tag 'scmi-fix-6.14' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes

Geert Uytterhoeven (2):
      firmware: imx: IMX_SCMI_MISC_DRV should depend on ARCH_MXC
      platform: cznic: CZNIC_PLATFORMS should depend on ARCH_MVEBU

Haoxiang Li (1):
      soc: loongson: loongson2_guts: Add check for devm_kstrdup()

Heiko Stuebner (1):
      arm64: dts: rockchip: fix fixed-regulator renames on rk3399-gru devices

Janne Grunau (1):
      MAINTAINERS: arm: apple: Add Janne as maintainer

Lukasz Czechowski (2):
      arm64: dts: rockchip: Move uart5 pin configuration to px30 ringneck SoM
      arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck

Niklas Cassel (1):
      arm64: dts: rockchip: disable IOMMU when running rk3588 in PCIe endpoint mode

Patrick Wildt (1):
      arm64: dts: rockchip: adjust SMMU interrupt type on rk3588

Peng Fan (1):
      firmware: arm_scmi: imx: Correct tx size of scmi_imx_misc_ctrl_set

Rob Herring (Arm) (1):
      dt-bindings: rockchip: pmu: Ensure all properties are defined

Sumit Garg (1):
      tee: optee: Fix supplicant wait loop

Tianling Shen (1):
      arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts

Vaishnav Achath (1):
      arm64: defconfig: Enable TISCI Interrupt Router and Aggregator

 .../devicetree/bindings/arm/rockchip/pmu.yaml      |  8 ++++-
 MAINTAINERS                                        |  3 +-
 .../boot/dts/rockchip/px30-ringneck-haikou.dts     |  1 -
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi    |  6 ++++
 .../dts/rockchip/rk3328-orangepi-r1-plus-lts.dts   |  3 +-
 .../boot/dts/rockchip/rk3328-orangepi-r1-plus.dts  |  1 +
 .../boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi |  1 -
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |  8 ++---
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi      |  6 ++--
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 22 +++++++-------
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 22 +++++++-------
 .../dts/rockchip/rk3588-coolpi-cm5-genbook.dts     |  4 +--
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi     |  1 -
 .../boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso  |  4 +++
 arch/arm64/configs/defconfig                       |  2 ++
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    |  4 +--
 drivers/firmware/imx/Kconfig                       |  1 +
 drivers/platform/cznic/Kconfig                     |  1 +
 drivers/soc/loongson/loongson2_guts.c              |  5 +++-
 drivers/tee/optee/supp.c                           | 35 +++++-----------------
 20 files changed, 70 insertions(+), 68 deletions(-)

