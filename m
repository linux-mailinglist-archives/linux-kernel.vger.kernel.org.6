Return-Path: <linux-kernel+bounces-253086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCFB931C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A02BB21419
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297313C67B;
	Mon, 15 Jul 2024 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VHd/xE/7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbNIKKe2"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EBE13A3E8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077001; cv=none; b=DefXHY81i2N7gpn8Hu2y4+jpggO5d94nR/yndHo2/nH/5dCg+MIOaJkPhWWPimYFm+jo0wo2JB9QsR4+OSRYmkruJHJS06hSuQQpE9kjRixCKY0MPS9Oets/7MIa9InTH3+Dxs0I8qxMP0LKe7TPYMfZcLsvn/VQlpzHABWd7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077001; c=relaxed/simple;
	bh=rDISxh/ZqH6TJg3U9p6YS5eMepg7UsC9ssTOrfpCai0=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=KK2ze1OIfBEYLztiXNCVVnPDkHRQ5rrFJF63/umgIWPZOskEdLDtnZh+TEfSurW59EHrCTqfCPYA3kKnULrZ9UQJVDeNflig7TWfBeGZwLCtiQ+S1fi5TYtYkJbNPmq4joxMDHs4BMPv4L9mFZohUbVZsZN0ZJ5NRoCaog1YX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VHd/xE/7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbNIKKe2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A6FC01388B1F;
	Mon, 15 Jul 2024 16:56:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 15 Jul 2024 16:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1721076998; x=1721163398; bh=89
	e6/j8ZWiMcFYzt0hDXdGvhC/f0P0quEQtnmbKN1SU=; b=VHd/xE/7XDJL+WZraK
	BlGrie+Q5pOErxp9Cyk0gAmjTo9a2e20yG5u4Tz40yLfOYT5jzVP1ynodLpmbj8R
	rDeBzHwD/qNqqizfUr/qiPkfcw22Fe5nZwUJ+jD5/PjN9490WhqPzbsl50Adpg4m
	V+jfgKQK+wNrshvh0tgQao2ipKXjQ8+lN+F4PYc38eCNLSPYIUp/dVYtJZQ1fvXP
	4CqLFPRBZD20gv5p0khNue/3fN4SJUfEF7ZWhbfDAwQktJfv6CH24HQ8xEAlhWLB
	6COFPkg5hwLYM3IIIRB50NqyFN7vVJ8BxNeYEjLdv7IODcKU2gGDMoPX3TfnvH+y
	DQcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1721076998; x=1721163398; bh=89e6/j8ZWiMcF
	Yzt0hDXdGvhC/f0P0quEQtnmbKN1SU=; b=jbNIKKe2ttFWlIg5CPZFnAfGh/Z+s
	slsTle/8bODtK/qH3F1OyJIcAPy9hmrqbzbcZaQb1RFoS8frEvW6OV9uzArNpHGF
	WUvnJT2cLB5NS0Ds0hq+jaK0LR5RV4WK2+FnlJsps8lb2YowbgV5h1kIT+jCBd46
	vZBQ+mz/nLNPxCFYWi7ZqJrqBK/PFfihgzCq1dP9ybP6PA2w4yPWuGrx/3LtrKLv
	OJ1GxyzxTr20UuTtEWrs0Dln8YsvXllvptRxmw5D5lspvP3DdN9HUHiOCRQAGiYj
	vDGDlkY0gyeJj+sVlRbr+tLAPmT/vGPdSWlKUaFe+WENzoMUdUZi+7EGw==
X-ME-Sender: <xms:BY2VZrpD_i7M7UmOM-SU2GKU2efYcaKIdBeRAkZLOwQsGZh2N5_C1Q>
    <xme:BY2VZloOinY_xJKpBm3pvtCm-ZddAFoWRzDojAUjXwEqKwGU9Dn4vDZIHsRsCYSSd
    o7M9HDunIQCXafVZQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeefheelfeetheelvdeiieeffeethfekvdehheduleetveeikeehhfeghfevkeff
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:BY2VZoNQBcCoa6zuHjY_uN0jHn1UcGF97MyoLAVRIzMdshFLZ23XvA>
    <xmx:BY2VZu5lQKDU2dnaGfdHWphGLYDSa0uw3Q1tHVRkTk5j5xL8PNv8Cw>
    <xmx:BY2VZq7-qq7ehDsR67VsafggBsc3k_-2EQbCAVBfyIDcxzQjpGV3NA>
    <xmx:BY2VZmhg7Szkf9xl49sJ41VK93wZkX9OFeLBc1a8n4B4rSbbpkPlcw>
    <xmx:Bo2VZglrKqbc2nXoHBBHzs_OiYX4HPS7zkwTmA_87MVW2JFnYbYdh6eU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6039FB6008D; Mon, 15 Jul 2024 16:56:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
Date: Mon, 15 Jul 2024 23:03:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@kernel.org
Subject: [GIT PULL 0/4] soc tree for 6.11
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here are the four pull requests for the soc tree.=20

We have again just over 1000 non-merge changesets in the SoC tree, from
62 pull requests plus some individual patches. About 80% of this is arm6=
4,
the rest is arm32 and riscv.=20

Not much sticks out in the contents, there are three new SoCs and a
fairly large number of new machines, but it's spread out over a lot
of platforms, with rockchip and ti having more than usual.

The overall diffstat is
   0.4% Documentation/devicetree/bindings/arm/
   0.9% Documentation/devicetree/bindings/
   0.2% Documentation/
   0.4% arch/arm/boot/dts/arm/
   0.4% arch/arm/boot/dts/marvell/
   0.4% arch/arm/boot/dts/nxp/imx/
   2.1% arch/arm/boot/dts/qcom/
   2.1% arch/arm/boot/dts/st/
   0.5% arch/arm/boot/dts/
   0.6% arch/arm/mach-pxa/
   0.3% arch/arm/mach-versatile/
   0.3% arch/arm64/boot/dts/allwinner/
   1.4% arch/arm64/boot/dts/amlogic/
  14.0% arch/arm64/boot/dts/freescale/
   2.9% arch/arm64/boot/dts/marvell/
   4.9% arch/arm64/boot/dts/mediatek/
  21.9% arch/arm64/boot/dts/qcom/
   1.1% arch/arm64/boot/dts/renesas/
  16.5% arch/arm64/boot/dts/rockchip/
   0.7% arch/arm64/boot/dts/st/
   9.5% arch/arm64/boot/dts/ti/
   0.3% arch/arm64/boot/dts/xilinx/
   0.5% arch/arm64/boot/dts/
   0.3% arch/riscv/boot/dts/allwinner/
   0.3% arch/riscv/boot/dts/microchip/
   0.3% arch/riscv/boot/dts/starfive/
   0.2% arch/riscv/boot/dts/
   0.2% drivers/cache/
   5.2% drivers/clk/qcom/
   0.2% drivers/firmware/microchip/
   1.3% drivers/firmware/qcom/
   0.3% drivers/firmware/
   3.1% drivers/platform/cznic/
   0.2% drivers/reset/
   2.2% drivers/soc/qcom/
   0.2% drivers/soc/xilinx/
   0.2% drivers/
   0.4% include/dt-bindings/clock/
   0.2% include/dt-bindings/
   0.7% include/linux/
 958 files changed, 66982 insertions(+), 11316 deletions(-)

There are 232 individual contributors for this tree, the most active
ones are

     67 Dmitry Baryshkov
     61 Krzysztof Kozlowski
     52 Konrad Dybcio
     42 Frank Li
     37 Luca Weiss
     26 Neil Armstrong
     22 Bartosz Golaszewski
     22 AngeloGioacchino Del Regno
     18 Marek Beh=C3=BAn
     17 Michael Walle
     16 Siddharth Vadapalli
     16 Rafa=C5=82 Mi=C5=82ecki
     16 Jonas Karlman
     16 Geert Uytterhoeven
     12 Tengfei Fan
     12 Alexander Stein
     12 Abel Vesa
     11 Marek Vasut
     10 Nathan Morrisson
     10 Krishna Kurapati
     10 Dmitry Torokhov
     10 Andrew Davis

        Arnd

