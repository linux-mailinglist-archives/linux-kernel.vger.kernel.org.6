Return-Path: <linux-kernel+bounces-416404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7EE9D444B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80696B23675
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F601C9DDF;
	Wed, 20 Nov 2024 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BDqfMPB5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s1Mr92xG"
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458B1C9DCE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143761; cv=none; b=Z0BPhY3wZtyfgS6OSl2jDAMIT0bLbFoi3gpaHjATvTqJqoMzEqUkRC4HMpZ926DauxpH9oj+6fc22xIqBRaJmz2xJQ+dVflCO4WjpcDbpIRnsxhR4kuk4VsAzfHoE+xjmbvxmwG+pmdbQiB5UKayxp97PpHJmfkEdvbsDFmxmos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143761; c=relaxed/simple;
	bh=65cja3GLqAPgZTRQurSeNRYC1HigINlbwxieHmzKrUo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dose9oenPgMuq2uZ5+hIGObJbUPbwfmqjVxkiGGn75TJ02teYBWAiFI8TWsbfeOrBHvCfB993eTL9TzFEZulhPrBFGV58f8AhHThOlBU9xe4MhT8NClJcmcf5no4YZA5OCtaKREbwTqZsOlmU8YR0PCfz7zLJScY7tTZWa8uREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BDqfMPB5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s1Mr92xG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CFDF114011B;
	Wed, 20 Nov 2024 18:02:38 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 18:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732143758;
	 x=1732230158; bh=+tOl6rSvZsKNggveupEMbGpTcJr/+iEv+wbu7ZX4M4o=; b=
	BDqfMPB5gVL4POujedGPXgY+5Y3bsnsa4FDbFT6CRgvc0/dEMvyGogMIbarOHSeO
	AkKnLyYCiijMGSJ4aTGuw897UdvartOSY9i4mQETG3dHiC7SbL72h/kRHfdb87eR
	CYkYpvJTmphLDu5mZZx5Q4C8eMo3pg5Dt4rjNDrw9BFQGOWCchDeXHSmS/3nH7PO
	ZnTQ6h8elOn/hlykdTWZMNjxMYByLH4Hv3lf/qQ+d7jNjRBqExaPem43B2m6HXkg
	dhKsiP5sK2CR6/7Px0CNKiivI8PrVsFwbAur7QYBg34P1XcTPlPV7FuqAh5wto1h
	Q2hvzgxkbgNgoG1pkfN4iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732143758; x=
	1732230158; bh=+tOl6rSvZsKNggveupEMbGpTcJr/+iEv+wbu7ZX4M4o=; b=s
	1Mr92xGe+iXUCQ1Qj34DDZgtI3DceVGrIPK5xYsgdya7DQoRMQIaJcwYfM6A8jjj
	BB3TZboeF/st/fYPWqxfivXktK7nVgBaAYtblD5YLGImpbFey6/edXRct14RO6ay
	mQ45NXbR3AMpgNiv6+0eaMAzUnbKd2CPfw0x7GOi43vI7X/Tq1fzj+YZpdpaTncA
	XqJtnhTeAQ1AcjDswTtyXNVRXlsRIubPIl7dy6/ZSCrP34LZ3j1H1HGLLvhnxmoW
	CvbYeiyAbaw8bJ/8SKUD2a2vlru1CtcH7HbC7KvqTFpneDfpBgfujCe/e76sZVgU
	kGGu8o9yV8q64rvYP3CLw==
X-ME-Sender: <xms:jmo-Z7ZvmHoQVGNG7n7yQszewy3JzP_5JZSmBnAR61ojQbXLiZN1Hw>
    <xme:jmo-Z6YwAz9fhnXj1F_DVsxs9snxvKDT6Atgbt-JaOxpo_0khsfhW39rh6ZkniVuS
    zMkvQY3tFp7cQ8Wf44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeefffelleduheehleejtdfhheegtdffhedtffeileeh
    keetffevtdegheduhfeiudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlih
    hsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhotgeslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jmo-Z98yeXYdC44bOs3Km_vOlSVrvdg-MwauVfuG3iFUUkNZpls0dg>
    <xmx:jmo-ZxpvxuEqO1fsM254RFPEYpxQ7lWrx431rhkUFL9dtcjbpi5P9w>
    <xmx:jmo-Z2puip3eGCITk9fdwCC8cxny7CLUkQRQw_EwEnXsLxNL0bp2yg>
    <xmx:jmo-Z3TbwqkhrJy_LoCl0KgRP2gEYv-DGHQZ05HuFJSG_M9i2mcS5A>
    <xmx:jmo-Z5W715FPWEsO6kZwPw1z6Mu_UrBmDrSJ8sXoKnUlAP_F_DsmsLLy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 54DFE2220071; Wed, 20 Nov 2024 18:02:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 00:02:17 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-Id: <77eaecac-c423-494d-91f0-e08322fbb0d8@app.fastmail.com>
In-Reply-To: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com>
References: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com>
Subject: [GIT PULL 3/4] soc: defconfig updates for 6.13
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.13

for you to fetch changes up to de6dff2090ddfa74ae53e3e52243a9b9f3ff8526:

  Merge tag 'at91-defconfig-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into soc/defconfig (2024-11-13 22:49:50 +0100)

----------------------------------------------------------------
soc: defconfig updates for 6.13

As usual, a few newly added device drivers get enabled in the
arm32 multi_v7_defconfig and arm64 defconfig as well as a few of
the SoC specific config files.

The main visible change is the inclusion of (reduced) debug info
by default in the 32-bit defconfig.

----------------------------------------------------------------
Andreas Kemnade (1):
      ARM: imx_v6_v7_defconfig: Enable drivers for Kobo Clara 2E

Arnd Bergmann (6):
      Merge tag 'arm-soc/for-6.13/defconfig' of https://github.com/Broadcom/stblinux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'imx-defconfig-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/defconfig
      Merge tag 'renesas-arm-defconfig-for-v6.13-tag1' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'ti-k3-config-for-v6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux into soc/defconfig
      Merge tag 'at91-defconfig-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into soc/defconfig

Claudiu Beznea (1):
      arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3

Florian Fainelli (1):
      ARM: multi_v7_defconfig: Enable debugging symbols by default

Mihai Sain (1):
      ARM: configs: at91: enable PAC1934 driver as module

Taniya Das (1):
      arm64: defconfig: Enable sc7280 clock controllers

Wadim Egorov (1):
      arm64: defconfig: Enable PCF857X GPIO expander

 arch/arm/configs/at91_dt_defconfig   | 1 +
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 arch/arm/configs/multi_v7_defconfig  | 3 +++
 arch/arm/configs/sama5_defconfig     | 1 +
 arch/arm/configs/sama7_defconfig     | 1 +
 arch/arm64/configs/defconfig         | 6 ++++++
 6 files changed, 14 insertions(+)

