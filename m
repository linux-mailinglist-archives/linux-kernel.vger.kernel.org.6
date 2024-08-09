Return-Path: <linux-kernel+bounces-281186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC3E94D417
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2CF1C20C97
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561221922DB;
	Fri,  9 Aug 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KSIeOAqe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUk2IQK1"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC4198A0F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219215; cv=none; b=eA3hve3PhNo/bM0Fvx0Z+93q2YVdGN5CFlEiJwLK4mW19kwpmsdY7QsULPfbG/wOhF7d2+lBYDXAXlSvuL7L1OF60aOLSgePzGtUheJ0kVYP52BEfc5vFYHBGwDh9STM2ZHXSJsMCV+wWzH2BKatBim+Oghfs2JzF2Q8HJD7b5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219215; c=relaxed/simple;
	bh=g0zJKP7UfSwSGJHsiiB/cxJ+gM8c+Sttd9cfbV9YmTc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=dg1499L/xALN2SRo99TnnHQ3f/cK9/M2VNjmx9kf2/oZGo38H4cONqs19uhirEje4GgP8QbOXBPm6xSeR5ByoxmvFUYYRzGlGwD6HfqDz6jX+2B7HEQ2lR84fKJfXpvkz76ejarUVCKdhezbXhRdTIgJMryp70WCxunHmdUvFNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KSIeOAqe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUk2IQK1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 066A0138FC65;
	Fri,  9 Aug 2024 12:00:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Fri, 09 Aug 2024 12:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1723219212; x=1723305612; bh=z6
	KzBzXeafkZblPznJTixRwjIgV1GVdoejv+2wiuTU4=; b=KSIeOAqeGOFVAxThW/
	urcDL0VxXX27giz+YhpE+GRHDGP+z21RErQbkj2XtGWL1NP2zOZDG/lYUXyS625P
	sTWn1R97NtuT4eqPdh+KcPViUHjFOrzoB1YnW3R4HnZ+BJPNm6l+iJg0bfW2TEcf
	FUrTJsod5n1M4lx3s7H6Z2blFxkfNKhMFxuFzviAVCKrRM9Vpg69N5T/xPvTmDR+
	ZgzTb086PkpFrTx26S3t/67Jf1Rc/a06YelJuTdmLr5PHAWAzND7BEsDJNc30XWt
	xfNpfgBTCPqliiGSh8OAMoNX9xa8TMpP3mB/9B0Xazpy/RFlFb/L6Cq0XnlgMjaY
	Y3rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723219212; x=1723305612; bh=z6KzBzXeafkZb
	lPznJTixRwjIgV1GVdoejv+2wiuTU4=; b=XUk2IQK1dfYJqdn/T4vj2VDHb5gBZ
	xkp8R+Yb0Vc/gSjq8yCagRuWiyvX+r/0dRLEBeJwF/csMHQqq8oENFvnsAaNtUqB
	qXJ6DSNbrEXMyIXFN7j0Jso0dnd3g1DqY8n1OctlJSHhckvwLWJAqDZ+Js4xcatI
	Fv4ZHQ3zAzDBmbsaptD2QFxCNKa+xxagLj3izpBvHIG3RRlcw56RTNhF8KgVtGIM
	rtBlw1W+Hbk7IfNQHkPW2JGBexsxiruZEsU04LayuuZ448iZpusXZa/OnWjakSm3
	Lu95FvEcO24+ZURXbzq3moMEXAkOhiyq0ovDJnpN9sYV/wxsjDZaplB7Q==
X-ME-Sender: <xms:Cz22ZknCYBo_ojixRGKwXLSKQdOzKqe-mIR7Zdl-NJkeZbzD1GamOQ>
    <xme:Cz22Zj1rAtvi3Q-kwvVK5Le85rlEmqu1XhErSJ2A4DZOMqMYQVlSSr2bVAOR8vrh_
    nu99sU1DQBftfPbHSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkufgtgfesthhqredtredtjeenucfh
    rhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqe
    enucggtffrrghtthgvrhhnpedvieeggefhhffhgfeuvddvledvffdtgfdvffdtvdfggeeg
    hfektdefuedtvdeugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggs
    rdguvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshhotgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhn
    uhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqd
    hkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Cz22ZirP_CVzf9Y4rG1Hz1i21i3e-WIe4-f-NIuEhLtHI21JyQGJjQ>
    <xmx:Cz22ZgldX_rqdeMYHYYthh7EscHtOyloachBdPzhEYPpA15V7qUh7g>
    <xmx:Cz22Zi13wBZoaW6Zd2MUqKtTJuCA7NK6s4Pox3t8k25fqg1y8Weuuw>
    <xmx:Cz22ZnvIZ_9LPW7gZAW-pewLFRs0XmdjD7R-AR9CP1tWM0xeCL_gSg>
    <xmx:Cz22ZnyiVKZikuUsYstTebM12X1U3us84zy1IrOdqz11e_7cd2v0V7zi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7069EB6008D; Fri,  9 Aug 2024 12:00:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Aug 2024 18:00:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <3e7ea374-c321-4f80-b22b-96ce34cfaa3e@app.fastmail.com>
Subject: [GIT PULL] ARM: soc fixes for 6.11, part 1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f0=
17b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-f=
ixes-6.11-1

for you to fetch changes up to 6b1124c4526fb1648a3921a441515ea8a98b92e4:

  Merge tag 'ti-k3-dt-fixes-for-v6.11' of https://git.kernel.org/pub/scm=
/linux/kernel/git/ti/linux into arm/fixes (2024-08-07 14:45:45 +0200)

----------------------------------------------------------------
ARM: soc fixes for 6.11, part 1

There are three sets of patches for the soc tree:

 - Marek Beh=C3=BAn addresses multiple build time regressions caused
   by changes to the cznic turris-omnia support

 - Dmitry Torokhov fixes a regression in the legacy "gumstix"
   board code he cleaned up earlier

 - The TI K3 maintainers found multiple bugs in the in gpio,
   audio and pcie devicetree nodes.

----------------------------------------------------------------
Andrew Halaney (2):
      arm64: dts: ti: k3-j784s4-evm: Assign only lanes 0 and 1 to PCIe1
      arm64: dts: ti: k3-j784s4-evm: Consolidate serdes0 references

Arnd Bergmann (1):
      Merge tag 'ti-k3-dt-fixes-for-v6.11' of https://git.kernel.org/pub=
/scm/linux/kernel/git/ti/linux into arm/fixes

Dmitry Torokhov (1):
      ARM: pxa/gumstix: fix attaching properties to vbus gpio device

Francesco Dolcini (1):
      arm64: dts: ti: k3-am62-verdin-dahlia: Keep CTRL_SLEEP_MOCI# regul=
ator on

Jared McArthur (3):
      arm64: dts: ti: k3-am62p: Add gpio-ranges for mcu_gpio0
      arm64: dts: ti: k3-am62p: Fix gpio-range for main_pmx0
      arm64: dts: ti: k3-j722s: Fix gpio-range for main_pmx0

Marek Beh=C3=BAn (6):
      platform: cznic: turris-omnia-mcu: Make watchdog code optional
      platform: cznic: turris-omnia-mcu: Make TRNG code optional
      platform: cznic: turris-omnia-mcu: Make poweroff and wakeup code o=
ptional
      platform: cznic: turris-omnia-mcu: Make GPIO code optional
      doc: platform: cznic: turris-omnia-mcu: Fix sphinx-build warning
      doc: platform: cznic: turris-omnia-mcu: Use double backticks for a=
ttribute value

Nishanth Menon (1):
      Merge tag 'ti-k3-dt-for-v6.11-part2' into ti-k3-dts-next

Parth Pancholi (1):
      arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs

 .../testing/sysfs-bus-i2c-devices-turris-omnia-mcu |  6 +-
 arch/arm/mach-pxa/gumstix.c                        | 11 +--
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi  | 22 ------
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi         |  6 --
 .../boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi     |  2 +
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi          |  3 +-
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi          |  3 +-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 25 +++----
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         |  4 +-
 drivers/platform/cznic/Kconfig                     | 80 +++++++++++++++=
-------
 drivers/platform/cznic/Makefile                    |  8 +--
 drivers/platform/cznic/turris-omnia-mcu-base.c     |  4 ++
 drivers/platform/cznic/turris-omnia-mcu.h          | 42 +++++++++++-
 13 files changed, 129 insertions(+), 87 deletions(-)

