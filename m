Return-Path: <linux-kernel+bounces-370088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0FF9A2731
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C97B28384F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFE47D3F4;
	Thu, 17 Oct 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fdel1XrE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBcyfC6D"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622CB1DED68
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179868; cv=none; b=qh9xIAKWJAG6InLB84nK6kcVZ3+0y7hw/s3UpIe+ZdzfIRBDIXE1vWkrF6JNh8kxD3d5zXDMjr837f9T1YPxBmEcEDYm43V2hnbH6E5QT9X7QIlIkTzbt0dQ+I/FU35nh+yDWIeND/BSBGUqneHTL1zUkVIv7Lb1f7qB+SV4Zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179868; c=relaxed/simple;
	bh=FRxkecjtvUvwte0xSUSYZxq2kF/Dmn4parCodFu2Leo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=S2ORVaeY7W+Z0iY4e/qE/Rti0DQfxe+tyLHhzctf9zb/5uBk9nvzRmE8QlZMzzmNhaJjpTXb9QUPbVJHfmG/8EYIFzRCruzpk5zTMd/nkbTWG5YVxnG68BVEBHkqu+xq9J9r3znsbw7VUj1wQk75S1U4WMffCQTkgD8nqyurwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fdel1XrE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBcyfC6D; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8413E1140567;
	Thu, 17 Oct 2024 11:44:21 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 17 Oct 2024 11:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1729179861; x=1729266261; bh=7c
	pF33KFxEOvQ38NTBG4ubLmixGF6wSWjOOxuK17G3M=; b=fdel1XrES+zMYQJb/K
	4IX9YIqgBJIFYDodbpzSU2vjaYa+tg3Geg0jOvSB6UemlK2zIAo12Sd56s23tsaW
	fBYyA/B0+9TLvQB7dESTDVLSeJ3fGLylZ/laH3FCcaBzU24ADFOhiX9ER/ehIji+
	YiWsM1M/EgbQNkGaSaHS9s8lINJXW5CASMvtohwebIo35visYowENabfx4A9uYfC
	kNdv7GvvYocVULIkkYX3iAXkwjdLHEfIVrUva3YN8wDUbKLWD54g+/zFVS06apN4
	4mBSRNEvOV+N6l75jkMB9n4ClCbrF8CgQ6anzV5aZBKrdlbgtyyM/12THYDnKyPE
	5Z3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1729179861; x=1729266261; bh=7cpF33KFxEOvQ
	38NTBG4ubLmixGF6wSWjOOxuK17G3M=; b=hBcyfC6DvUocnyir0JHxH8RedTcPY
	m9QGnPm457JxQ6uKhD75+C2YuShDtszWUVECRArUBCO8sxAExQBBTEFTSRTwkbVO
	KoqF9JV3Ojtl6ZH0SSeItBMp1LSt+IxZoQOQnZxqw1W4uKRCFLbqyZcEqOcqM9d5
	F6CXwqzjt5jiGmgrypHzRGmDYEik3oe58Ze+nPFZGFIISSQG2MZAENYb6BVSQR3o
	azF+id7KyoUwyNLX9kUUa3ypOx30vD5Q0DdirUBHjbGRfRf1Ms9hMewMnaLFYWfg
	ovuzc30D4y7eNO7klg5viiWh7fuxeKXrlEWtpq37oBjN9nxrNcPABkf+Q==
X-ME-Sender: <xms:1TARZ7CQ48Lhe35xHq4eUEFUEvzY8G8kfcSzeRmCVkoiVfg-bIaNZg>
    <xme:1TARZxjXGLlH5j9-8SUqLRqBFc7YnOVfxq-TassSNIvnqCEvzBByLjY7nSmA5ZWHe
    i0l59xvE7yjj4cfkl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkffutgfgsehtjeertdertddtnecu
    hfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvg
    eqnecuggftrfgrthhtvghrnhepteetgfejvdfgtdeiteelvedvieduieekteeludetgfdt
    uedtuddvtefgvdduuedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuh
    gsrdgtohhmpdhpvghnghhuthhrohhnihigrdguvgenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprh
    gtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghp
    thhtohepshhotgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1TARZ2l9UzJubX_GWK1B563cQLP4SNJwZE1oC8v5GAaoaHpULav1AA>
    <xmx:1TARZ9wn6F8uJcOoAXC1kqTOd2D6QhaDwuYYT6uvH2Wayp1ahLKgIQ>
    <xmx:1TARZwRlvCxZWzFQpVWXcK2aYlnA3pTQNz8-N1lNBDoBNkctNyLhIQ>
    <xmx:1TARZwY3j2cOmoL8mN9zbSQ77XaHHKQT2SOiV_DjjSZcaB7VoBosXg>
    <xmx:1TARZ2c3KeDllxOIvFWFwnu3GrgB7zOtxLsfbVhKeqDKDGlaXGRI9kV_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B1582220072; Thu, 17 Oct 2024 11:44:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Oct 2024 15:43:42 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-Id: <5547084c-db39-4a92-968b-413f5d843582@app.fastmail.com>
Subject: [GIT PULL] soc: fixes for 6.12
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.12

for you to fetch changes up to 1b59d6c19c2ca4e705effee5c2f68fd8ab307c90:

  Merge tag 'scmi-fixes-6.12' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes (2024-10-15 20:39:43 +0000)

----------------------------------------------------------------
soc: fixes for 6.12

Most of the fixes this time are for platform specific drivers, addressing
issues found through build testing on freescale, ep93xx, starfive,
and npcm platforms, as as well as the ffa firmware.

The fixes for the scmi firmware driver address compatibility problems
found on broadcom machines.

There are only two devicetree fixes, addressing incorrect in configuration
on broadcom and marvell machines.

The changes to the Documentation and MAINTAINERS files are for
clarification only.

----------------------------------------------------------------
Alexander Sverdlin (2):
      dmaengine: cirrus: ERR_CAST() ioremap error
      dmaengine: cirrus: check that output may be truncated

Arnd Bergmann (7):
      Merge tag 'soc_fsl-6.12-3' of https://github.com/chleroy/linux into arm/fixes
      Merge tag 'arm-soc/for-6.12/devicetree-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      firmware: arm_ffa: Avoid string-fortify warning in export_uuid()
      Merge tag 'reset-fixes-for-v6.12' of git://git.pengutronix.de/pza/linux into arm/fixes
      Merge tag 'mvebu-fixes-6.12-1' of https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into arm/fixes
      Merge tag 'ffa-fixes-6.12' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'scmi-fixes-6.12' of https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes

Changhuang Liang (1):
      reset: starfive: jh71x0: Fix accessing the empty member on JH7110 SoC

Florian Fainelli (1):
      firmware: arm_scmi: Give SMC transport precedence over mailbox

Florian Klink (1):
      ARM: dts: bcm2837-rpi-cm3-io3: Fix HDMI hpd-gpio pin

Gavin Shan (1):
      firmware: arm_ffa: Avoid string-fortify warning caused by memcpy()

Geert Uytterhoeven (1):
      soc: fsl: cpm1: qmc: Do not use IS_ERR_VALUE() on error pointers

Herve Codina (1):
      soc: fsl: cpm1: qmc: Fix unused data compilation warning

Josua Mayer (1):
      arm64: dts: marvell: cn9130-sr-som: fix cp0 mdio pin numbers

Justin Chen (1):
      firmware: arm_scmi: Queue in scmi layer for mailbox implementation

Konstantin Ryabitsev (1):
      MAINTAINERS: use the canonical soc mailing list address and mark it as L:

Krzysztof Kozlowski (1):
      Documentation/process: maintainer-soc: clarify submitting patches

Su Hui (1):
      firmware: arm_scmi: Fix the double free in scmi_debugfs_common_setup()

Yan Zhen (1):
      reset: npcm: convert comma to semicolon

 Documentation/process/maintainer-soc.rst           | 42 +++++++++++++++++++---
 MAINTAINERS                                        |  4 +--
 arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts |  2 +-
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     |  2 +-
 drivers/dma/ep93xx_dma.c                           |  9 +++--
 drivers/firmware/arm_ffa/driver.c                  | 13 ++++---
 drivers/firmware/arm_scmi/driver.c                 |  4 +--
 drivers/firmware/arm_scmi/transports/Makefile      |  6 ++--
 drivers/firmware/arm_scmi/transports/mailbox.c     | 32 +++++++++++------
 drivers/reset/reset-npcm.c                         |  4 +--
 drivers/reset/starfive/reset-starfive-jh71x0.c     |  3 ++
 drivers/soc/fsl/qe/qmc.c                           | 11 +++---
 12 files changed, 92 insertions(+), 40 deletions(-)

