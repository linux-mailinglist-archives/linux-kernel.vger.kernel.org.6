Return-Path: <linux-kernel+bounces-330917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DFD97A612
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE771C26E20
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4B5158D8B;
	Mon, 16 Sep 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Omy2mdbx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RwT2LOkE"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912E21340
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504398; cv=none; b=t8hZpRCoVbAhHipv9mfxq4P9nnMWEtgCG4koBQAGG0Io7S8pnZv7W8oCf2ZoiOsrA/GVU8Rs3DO5FcySJFnF7s3+JsVVpAwuIId4Cp/MYxypnkGGtojlg6/BDDZ2F4DowCXOkZQ4NfguHGTTtWaGleGGrkxYaqWQe1GGsfqGSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504398; c=relaxed/simple;
	bh=3BKT58+hQPxQZ0xlTp38ewfazRlSDW0RZvBc6idyQ/s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fjVfbhjVXHMtaAbL+SyFrT5XhsxYal03lNBcCq31gH3DNTQNp12gyHLzJuZnBbwalUN+tiFLJr+rn8U/7uU7GCRowkd/5KQK5TIAgGW7LkrUWjg6sNMibap5aFlDQLLTzvVe6Fmp+rw6rp+I06ABfW047RIGc8Fp076hC1NEUQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Omy2mdbx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RwT2LOkE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D47711402C0;
	Mon, 16 Sep 2024 12:33:16 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 16 Sep 2024 12:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726504396;
	 x=1726590796; bh=vZIcbrAnjSA4s0p+zFS0c7vxQRLPVZtsGWABr76p9TM=; b=
	Omy2mdbx6J6goCyiYQrovp/HecGw/tZLTLQzm2LFZ4oGGY4qnoBmS29abgnuITc2
	IEUUiamm1/p4qPrMynfqSd/44x17lzYdQ/wL6GklDIb6LELrT4mjBDuGKj7BEBMX
	bz6wFMTUUFHYDEQ8BYErcw+TBEkhgn7J9dkwMeNikNXeVL4pq1IJwoOdLiinTXMI
	w2QZqPyE63iPuwUVtd1z4Xn3SD3F3K+XTnkvdAFnO1Jj/7+li+KgtuTPP+u5dSzu
	4Aq3W2sFJTFyeb43uiZp8H1PSMUzFu8sM3F1NGpHyA6BQ8HwAhAK5w3xCRx8aWY2
	xnpA5ZGm84/p0yDf6A0/NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726504396; x=
	1726590796; bh=vZIcbrAnjSA4s0p+zFS0c7vxQRLPVZtsGWABr76p9TM=; b=R
	wT2LOkEIDa1rzyvQvZfkmxfwDwb7JLLygkgTMszEwpIBSwpxQ/a7OpoQVgUjfpRK
	izoioPQDcTrd3tamZN4UDc/ikDkoXnj39Wzi/wWwWRuMpOMHjVA4lGHBb4sZUQAx
	WnOfiG0PKyzqg+p7ZrzOF9FZMKOek7qqgNS+0S6kxyzIF+3qq+5xpwPaZJ7cZkOK
	FH0zAo63hMCAemnKITP7Kd1HQcj/8AVcgJpPTaWs1jNWgCyVclFTsFbSs9x652Qf
	YYF9bdHIaBGuUdKl3MIk4JgzYtgpnJgynWPHv+nvF7TjYQIbXbdpu5ThabOGnchN
	7ZxhUBPwpmo6FODZhnSvQ==
X-ME-Sender: <xms:y13oZjDxMKA-11zLBsST4FdmnGiNdVur_LBVDoKcFeFZqPu_FpIG7A>
    <xme:y13oZpjtvW1w84AGbRBSAH38Xd4jhonvh6ODSPSjyGuRmx3U8BEIYQ288IFwovVPs
    cI5nY0HAXaqyThbD_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeekvdeuhfeitdeuieejvedtieeijeefleevffef
    leekieetjeffvdekgfetuefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepshhotgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhorhhvrghlughs
    sehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    grrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:y13oZukR1SzPug3tf5XswXKO6kGdCtQebFHDH8Bwa2SaVBfGhiZZ-w>
    <xmx:y13oZlxif1pGDGOzhEn18T4s1TxfvATCsdG3B9c9mIAKy5sbq2obSg>
    <xmx:y13oZoRNr6tlua6TC5CMJeAixAS9SmpRZwNdBgcS-woGMat3UxD-Ng>
    <xmx:y13oZoY13wexUpWikjKNfN8gNO9MSb480YJf4ZZYBG2DtXRIXd0waw>
    <xmx:zF3oZueFCoK86f37f6LE03UgamHS4QmWegeM5Fw3naBsAl7c0ByGtrVb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D37D5222006F; Mon, 16 Sep 2024 12:33:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Sep 2024 16:32:53 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <3618c698-8305-460f-bddb-67e4e06f524a@app.fastmail.com>
In-Reply-To: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com>
References: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com>
Subject: [GIT PULL 3/4] soc: defconfig updates for 6.12
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208=
399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
efconfig-6.12

for you to fetch changes up to 7eee0f8bbd1b6946236624d25a938cb34c1ba2a9:

  Merge tag 'v6.11-next-defconfig' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/mediatek/linux into soc/defconfig (2024-09-11 09:05:18 +00=
00)

----------------------------------------------------------------
soc: defconfig updates for 6.12

The updates to the defconfig files are fairly small, enabling
drivers for eight of the arm and riscv based platforms.

----------------------------------------------------------------
Alexandre Mergnat (1):
      arm64: defconfig: enable mt8365 sound

Arnd Bergmann (8):
      Merge tag 'at91-defconfig-6.12' of https://git.kernel.org/pub/scm/=
linux/kernel/git/at91/linux into soc/defconfig
      Merge tag 'renesas-arm-defconfig-for-v6.12-tag1' of https://git.ke=
rnel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'tegra-for-6.12-arm64-defconfig' of https://git.kernel.o=
rg/pub/scm/linux/kernel/git/tegra/linux into soc/defconfig
      Merge tag 'ti-k3-config-for-v6.12' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/ti/linux into soc/defconfig
      Merge tag 'imx-defconfig-6.12' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/shawnguo/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.12' of https://git.kernel.or=
g/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'riscv-config-for-v6.12' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/conor/linux into soc/defconfig
      Merge tag 'v6.11-next-defconfig' of https://git.kernel.org/pub/scm=
/linux/kernel/git/mediatek/linux into soc/defconfig

Chen Wang (1):
      riscv: defconfig: sophgo: enable clks for sg2042

Devarsh Thakkar (1):
      arm64: defconfig: Enable E5010 JPEG Encoder

Dmitry Baryshkov (1):
      arm64: defconfig: build CONFIG_REGULATOR_QCOM_REFGEN as module

Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Enable slab hardening and kmalloc buckets

Inochi Amaoto (1):
      riscv: defconfig: Enable pinctrl support for CV18XX Series SoC

Jon Hunter (1):
      arm64: defconfig: Enable Tegra194 PCIe Endpoint

Kuninori Morimoto (1):
      arm64: defconfig: Enable AK4619 codec support

Liu Ying (1):
      arm64: defconfig: Enable ADP5585 GPIO and PWM drivers

Niklas S=C3=B6derlund (1):
      arm64: defconfig: Enable R-Car Ethernet-TSN support

Varshini Rajendran (1):
      ARM: configs: at91: enable config flags for sam9x7 SoC family

 arch/arm/configs/at91_dt_defconfig  |  1 +
 arch/arm/configs/shmobile_defconfig |  1 +
 arch/arm64/configs/defconfig        | 10 ++++++++++
 arch/riscv/configs/defconfig        |  7 +++++++
 4 files changed, 19 insertions(+)

