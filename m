Return-Path: <linux-kernel+bounces-330910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62C97A5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971071F268C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90F71B5AA;
	Mon, 16 Sep 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Jjwu9Ewe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SPSC1aRh"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1A13D62F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504241; cv=none; b=MLrqB4wCVEBpJDbh2KsbuVcJbWrj8WDlc/L5VTCeRZvDKYPkhRzkTtw34I4D6pKoNUXOre9FseMrMTeHxDWxycDia/jvjNliN79spamXLWJ4VuSemHr5ezDW3SG+OPyqyzc+JEgMzNSnDn59HOFI1FsP12QehbFWf7gL4jh8w2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504241; c=relaxed/simple;
	bh=c9jB8rjPZbRXyHJrR9Zs2btAHumNoQQLRT1p8/sv7L8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=ofBJkXSE42lBpo/PB3C/p7qE5FxxNhoKL/1fcUC0P3jbpoTurBRFE5WVDQNboOMoubpW0ZYTjebNxTxOQECjxx2Sp05KkUGiv6eXM24qmGe+/wYyaB223ZHJ8DKk68FPz31uL9JhEjINdLgLsuusBQyj7IamkHwPuJ0ENFo+bXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Jjwu9Ewe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SPSC1aRh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 834B51140322;
	Mon, 16 Sep 2024 12:30:38 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 16 Sep 2024 12:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1726504238; x=1726590638; bh=TO
	ErWWmlsrN6/7w+l7WG9QUiNt0psI2e8M+zi33bnpc=; b=Jjwu9EweZK1zN1wFGD
	douoptrL+3OFzTNtAMt/V4q3RvgsQdsRChPnlEFsZuEOrsIIJwT6fdvqph36GCwW
	ay8Zb5X7ydw/6G1H26O/V/YTdVlUjvCk/Bn6cD+xR2Bu4GSDvdvM8rfFfBkHsvxL
	+RucP1S/gwtvszQxvaILbw5nq3T8T4Q1W+QuVRGbGFAnDiTrHr41jLhxNbOdsbHa
	YuUHMyjlEC7kZ5azyUPpHRlto2cnZPJJKAt84Z7Rjo1YWfqTPhFz7IZYq/RNNMix
	fJpmKtRxutkI/8vNPVGqTaD+a8aJlJtDq3HpAYfKt7nebm3eIHZ8PTW5P0vY0M++
	LBPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1726504238; x=1726590638; bh=TOErWWmlsrN6/
	7w+l7WG9QUiNt0psI2e8M+zi33bnpc=; b=SPSC1aRhAA39kc0nIfNP5rjgX1cKy
	PoIXfjdHedPAr2BPlpkcOnDJgugUfpYMViYX4XCIrIU4Op1U4EOg9DFc2eMjiycu
	N9IveiiaxYdM4Ryco0LsBbDClas/1E/0M/b16sIpZCqrEiME2j5tJPyzx0YXOkcm
	q5ywojycVWtoirsAOIdlPCKQvm44xgzl3327M3RtZxEHFSFqwowwDLSqRTEg+woT
	cPBPfXdx0+o1y+Gjoo+TPGLfz3TYobBTMI8tqjUrFZM33TM55GhBcINxeF0xJD9n
	RHvNC+4IP8jRisxs1awoqPSYGM+aD3dyQTOL6C9tTr9l2HazlJ2coAIOg==
X-ME-Sender: <xms:Ll3oZm42iB_gzmb_xcysooULcPZJnh_Smh9Moi6G7-v8RStdMzuOeQ>
    <xme:Ll3oZv4cRKetJVujOuvyRCpD7KIQEOlJMZxL_Y9LLml9u0fbwtnNtiXB3r0eTyqPp
    wIqK110ykecvF6vRew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeelveehkeffgfdtheekveehhfdtheefkefggeekheeu
    hffgheejteevgfdtuddvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehsohgtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ll3oZlfklF9X12kbua5voodlyrQf-PIelxyguA05YpYGYPis0I9q0A>
    <xmx:Ll3oZjLPoq4vzce2nUVpCjIMyZc12axhHhRZh9eJ7BPSKGEa6R-meA>
    <xmx:Ll3oZqLo1DsfUTxMImF_ZjEvgh8Ljl47gVqSCz9-MqtpNAtuq1_2kg>
    <xmx:Ll3oZkw15zR8ojJJ8YaF8NcNZwu-0KdjLIahyACRSHM1Dye8-xBipg>
    <xmx:Ll3oZm14jDkCJmiaJvgx0cfsyKyOAbc_WborN3QT5VLWmBk0wfRZ71jw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 08272222006F; Mon, 16 Sep 2024 12:30:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Sep 2024 16:29:47 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com>
Subject: [GIT PULL 0/4] 
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

These are the usual four branches from the SoC tree, with around
900 non-merge changesets from 220 individual authors. I hope to
send one more pull request later for the conversion of ep93xx
to devicetree, but I still applied regression fixes to that one
today so I'm giving it some more time to make sure it won't
cause other stuff to fail.

There are four platforms that make up most of the changes
by size and number of patches:

 - NXP gets a lot of minor DT improvements as well as a
   good chunk of the driver updates, but only three new
   machines.
 - Rockchips and Aspeed have the largest size overall,
   mainly from new board additions, so there are fewer
   patches.
 - Qualcomm as usual has a lot of everything including
   several new Snapdragon X1E laptops.

Another small but notable addition is initial support for
the Raspberry Pi 5, which has taken a while to get into
shape.

The driver changes are somewhat larger than normal, but
are still dwarfed by the devicetree updates.

The most active contributers by number of patches are:
     62 Krzysztof Kozlowski
     43 Frank Li
     37 Herve Codina
     35 Nikita Shubin
     22 Heiko Stuebner
     18 Yang Chen
     16 Marek Beh=C3=BAn
     16 Geert Uytterhoeven
     15 Peng Fan
     14 Markus Niebel
     14 Lad Prabhakar
     14 Beleswar Padhi
     12 Xianwei Zhao
     12 Rayyan Ansari
     11 Svyatoslav Ryhel
     11 Peter Yin
     11 Konrad Dybcio
     11 Fabio Estevam
     11 Dang Huynh
     11 Cristian Marussi
     11 Alexander Stein
     10 Sudeep Holla
     10 Marek Vasut
     10 Diogo Ivo

Dirstat:
   0.4% Documentation/devicetree/bindings/arm/
   0.7% Documentation/devicetree/bindings/clock/
   0.6% Documentation/devicetree/bindings/pinctrl/
   0.7% Documentation/devicetree/bindings/soc/fsl/cpm_qe/
   0.3% Documentation/devicetree/bindings/soc/
   0.6% Documentation/devicetree/bindings/
  11.3% arch/arm/boot/dts/aspeed/
   1.6% arch/arm/boot/dts/broadcom/
   0.3% arch/arm/boot/dts/microchip/
   2.6% arch/arm/boot/dts/nvidia/
   2.1% arch/arm/boot/dts/nxp/imx/
   1.3% arch/arm/boot/dts/qcom/
   0.6% arch/arm/boot/dts/rockchip/
   1.9% arch/arm/boot/dts/st/
   0.3% arch/arm/boot/dts/
   0.4% arch/arm/
   2.1% arch/arm64/boot/dts/amlogic/
   0.5% arch/arm64/boot/dts/broadcom/
   9.8% arch/arm64/boot/dts/freescale/
   1.7% arch/arm64/boot/dts/mediatek/
   0.3% arch/arm64/boot/dts/nuvoton/
   1.6% arch/arm64/boot/dts/nvidia/
   9.5% arch/arm64/boot/dts/qcom/
   4.1% arch/arm64/boot/dts/renesas/
  20.2% arch/arm64/boot/dts/rockchip/
   2.8% arch/arm64/boot/dts/ti/
   0.6% arch/arm64/boot/dts/
   0.3% arch/riscv/boot/dts/sophgo/
   0.4% drivers/firmware/arm_ffa/
   1.0% drivers/firmware/arm_scmi/transports/
   4.5% drivers/firmware/arm_scmi/vendors/imx/
   1.6% drivers/firmware/arm_scmi/
   0.2% drivers/firmware/imx/
   0.8% drivers/firmware/
   0.3% drivers/input/keyboard/
   0.2% drivers/memory/samsung/
   0.8% drivers/memory/tegra/
   0.5% drivers/memory/
   1.1% drivers/reset/
   0.2% drivers/rtc/
   2.9% drivers/soc/fsl/qe/
   0.3% drivers/soc/mediatek/
   0.6% drivers/soc/qcom/
   0.5% drivers/soc/ti/
   0.3% drivers/soc/
   1.5% include/dt-bindings/clock/
   0.2% include/linux/

