Return-Path: <linux-kernel+bounces-253091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A4931C56
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91321B215FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776EF13AA46;
	Mon, 15 Jul 2024 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DhaiZquD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RT75lbfb"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E7C15B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077460; cv=none; b=bMctFpdmI0O8YlSt1bbj/m+F2bggg8s3Z5W6kM20CbZpBrr31zW3r0vZ7n9/58I4dqRJR483jzW7J6AYsCAmNI02eYbvBRF8PUazH5w8PtNIFYrP9e1VbZ2UJAL2c9zbUbERiugsV7YZMNjrnG8i2pOVeuqyOQn5APcmAQbE1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077460; c=relaxed/simple;
	bh=hZzwPt9LzPSyjoeZqvTvHsoJ+IwvfjGiZpB3vvzh5zg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UQuQSNp95aKxFS2Pf3cLe34JYSTFnoYx7YaJVQBLSwJMH5TWChnMim52M8piJfJRVMRrrkWGRaUMXfqa3B9cN1767dXxOWv9Qq1DsM8vgmVPPeF6a55OgrGDXZ/b3rOXYFCoYMm7iaFJSkYv+DUSqOU8eJP6j4Je3F/SILEYCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DhaiZquD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RT75lbfb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0FFA0114012D;
	Mon, 15 Jul 2024 17:04:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 15 Jul 2024 17:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721077458; x=1721163858; bh=6xGusI2FeA
	NpJ2Sv7Vopch+IFsdzpSHc3rL7Dr+r41o=; b=DhaiZquDuvy6XLfUHW1yHry4cf
	w0POFmTXzceXp2axaV4g2fGE+Tx+CB9gkt1F06FN7nGOrsJlhjDY75XkCFAeePLB
	mPBU8BhevyQ8q17ktEgspsPuJ5yR+rFplbRLdRJq6llzyyn4ppkVAy7jZiygXaYO
	JigBqMVl92pJDhy4+kgNXIzkc0ZY4xfcGTaiY4dYxrWZ5P5DPMKmJtr80RMK6nQP
	+whqcm8As6LZBt9/vL26VF1k2EsPl8XYxVHEZsRySKbWxMFgZga844SD4ZeY9Syg
	nOK1Wh2g9qyqcRN07x9s7KQtuOtxuGS0owR1USaXaKT4FjfPV+34poLb6ahA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721077458; x=1721163858; bh=6xGusI2FeANpJ2Sv7Vopch+IFsdz
	pSHc3rL7Dr+r41o=; b=RT75lbfbLRFCC6K1D3/2Ng5T+8YcZcTH8+OlcbbNZPc8
	oK1cfqtGwoHhd03vOrI859PBgKb/IwLYQxmt++upg+ILI9YgOrmtRQIiFsGR9L9E
	BbmgKXUS01t/w5zlYe0S0VQqg1Jqo5Qf05uIR4bJEEKhcz2l5HJYpweI2sYM+Ajv
	xV1xEkjdOOKSzk/T9QJK79wyHWIQYrOfQzvknmQ8GuYodRODdINIdPfFE1r91WNX
	ZM0+9gaKNZddZK9VN35TUGtZjYctRtZl7cyU/QOBY9I09zqkz2DTBiDO1LSjGm1o
	wFWxLIQBFfkN2hdfm/sUyG/L39pIhIN5+NPVDMbknQ==
X-ME-Sender: <xms:0I6VZg0G8SEtq3v5qvH1a5tEc5IGZBl9IuUulmgrzZy8bAdwty1Sjw>
    <xme:0I6VZrFdASGawrktzPZmFFqIEgYbS1MddMgLIJni1dg99P7udsEeUgUqN9DKr6R70
    htirIDZVU2MIkk-WP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0I6VZo5CThz0zQR_E21TpNEeoX32pHU569st1NMctGjeQAjuoK3b4g>
    <xmx:0I6VZp1W6SD70cAI0aUUpPtalE_i_BwzLv_1AWLh_5HPowyKjpTisQ>
    <xmx:0I6VZjGzKuLS984oCJ5usHZUng3zq0rgm1tSWot8L0CZOtlfmmU04Q>
    <xmx:0I6VZi_uPtmqpY2cHq2joNKOHXEuHSPCfurdSBrZBQM0alHDzo3KFw>
    <xmx:0o6VZrBKf5q_Ky0-kHRj1E9ld-OzrhPw0N7mih8mcpeAJmPqSzRe3F-4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CB79CB6008D; Mon, 15 Jul 2024 17:04:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e94c0a1a-6e04-4ecb-8985-779c53fd7fc8@app.fastmail.com>
In-Reply-To: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
Date: Mon, 15 Jul 2024 23:11:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@kernel.org
Subject: [GIT PULL 3/4] soc: defconfig updates for 6.11
Content-Type: text/plain

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.11

for you to fetch changes up to 05a01ce77349f60b8f8d8b09df4e02a99d1f16df:

  Merge tag 'imx-defconfig-6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/defconfig (2024-07-09 08:21:26 +0200)

----------------------------------------------------------------
soc: defconfig updates for 6.11

These are the usual updates to enable newly added drivers, mostly for
arm64 and riscv this time.

----------------------------------------------------------------
Alexander Stein (1):
      ARM: imx_v6_v7_defconfig: Enable drivers for TQMa7x/MBa7x

Arnd Bergmann (7):
      Merge tag 'renesas-arm-defconfig-for-v6.11-tag1' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'tegra-for-6.11-arm64-defconfig' of https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc/defconfig
      Merge tag 'at91-defconfig-6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into soc/defconfig
      Merge tag 'ti-k3-config-for-v6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'riscv-config-for-v6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/defconfig
      Merge tag 'imx-defconfig-6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/defconfig

Bartosz Golaszewski (1):
      arm64: defconfig: enable SHM Bridge support for the TZ memory allocator

Besar Wicaksono (1):
      arm64: defconfig: Enable NVIDIA CoreSight PMU driver

Christophe Roullier (1):
      ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support

Dharma Balasubiramani (1):
      ARM: configs: at91: Enable LVDS serializer support

Dmitry Baryshkov (4):
      arm64: defconfig: enable CONFIG_SM_GPUCC_8350
      arm64: defconfig: make CONFIG_INTERCONNECT_QCOM_SM8350 built-in
      arm64: defconfig: enable several Qualcomm interconnects
      ARM: imx_v6_v7_defconfig: enable DRM_SII902X and DRM_DISPLAY_CONNECTOR

Fabio Estevam (1):
      arm64: defconfig: Enable the IWLWIFI driver

Geert Uytterhoeven (1):
      arm64: defconfig: Enable Marvell 88Q2XXX PHY support

Hal Feng (1):
      riscv: defconfig: Enable StarFive JH7110 drivers

Komal Bajaj (1):
      arm64: defconfig: Enable secure QFPROM driver

Nathan Morrisson (1):
      arm64: defconfig: Enable TI LP873X PMIC

Ravi Gunasekaran (1):
      arm64: defconfig: Enable USB2 PHY Driver

Vaishnav Achath (1):
      arm64: defconfig: Enable MTD support for Hyperbus

Wolfram Sang (1):
      arm64: defconfig: Enable Renesas R-Car Gen4 PCIe controller

 arch/arm/configs/at91_dt_defconfig   |  1 +
 arch/arm/configs/imx_v6_v7_defconfig |  7 +++++++
 arch/arm/configs/multi_v7_defconfig  |  1 +
 arch/arm64/configs/defconfig         | 22 +++++++++++++++++++---
 arch/riscv/configs/defconfig         | 26 ++++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 3 deletions(-)

