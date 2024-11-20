Return-Path: <linux-kernel+bounces-416405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815659D444C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF471F20C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5461C9DCE;
	Wed, 20 Nov 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QVIDEKoy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neYVqGiY"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA61C9ED8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143796; cv=none; b=qp/CdLKgzMWgRnb/wAtif7Q1VOgQg2A+e4umK+umNr2pkP9W+Ua+ES6dNWTfb+KEF4yJr8dgOVv/5OevProjQoTqyd1dhYZqBd1QqErQ9miutCGdaJYAAzsUY7QNb1zIqmfTlXMIDt6aKBvYiNlmlyvMieZMkevAf90B63BHH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143796; c=relaxed/simple;
	bh=dKoF82NqBnhzfxJdFoRE4eZCQlxE0wRpc9oVewuzhLE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ceLhMF+C3oZHNiHSrOFc7uh4XjOEMx2xSyNslLniyQEIeQ9agwo967bRjUB5mNwtKzhpFPTiWnIg90wa+KikuAbnhtQAVDglGKswFZNkwMti7SY8DYQgTS0RMxEA+t06P5V5Bf1JMXAyZ1DLsbB0s4VsKHaFNvHXGk3vBInAIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QVIDEKoy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=neYVqGiY; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F38F1380258;
	Wed, 20 Nov 2024 18:03:14 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 18:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732143794;
	 x=1732230194; bh=uw22jCZoEwcjBnN6PMmaEAXVlXl4VGvOeXE3IOt4lBQ=; b=
	QVIDEKoykCePUFIMau2BLuR/h6CXcPW3iPjwQ5CJ5JiP5goYY7rusWEgfey4ll4/
	BMxAYY86w4gFghoUDrUwHfuxCMrtOTgKc2BfM+oeRDS6KC5E9k/TyuX3vhCQ2mGy
	+z4NqKCK8Fq5DVKuiWJ2vy4tleJR6q9Dz5TGISDXBQ4HMAQstxybeif/l2KcMdj8
	zBwY5v9aDYWlmxROj3ChEXYAkEzjr0oQqJYM5Evg9SRV+kxq2EH1p0w9a2iJF6Xr
	mS8ZGNueiuK9C1pvklE7w7MWdIjK3/vzy90wkBOeC/T8kfBlByzPLbFoill5bSYM
	3c5QJLTJmm9KyqpKDLSUcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732143794; x=
	1732230194; bh=uw22jCZoEwcjBnN6PMmaEAXVlXl4VGvOeXE3IOt4lBQ=; b=n
	eYVqGiY5FThxgfSF9/JJudYQrtegp4os+CN4oxRGyCs1ANrUc50M/ynyKNhdGqrx
	m6ORtZJIiCS5XjAVjSdzkCOjpBQEKmthXS9JZKwHIUbZlgfaAQUnJ9e3te6wAxsk
	nTAqdIo20bLwT5p6xfVnLxyd4Wsp8JTF6mriZ3o0XuIu7Gx+zdz0IEyH675rFpZh
	VYiH4Z8q2EV4Y33najW2koX2tXYu7VFEkrYJsSaGNmQBJTQBmbPLlXCdwcv9rNwo
	4+JBUZV1eKZOUAGWapXYyKS2sOz/iOlCqWsnaLGctFzhmfFdkbqTlaNQHPh1AMI2
	SHCkFlSSkfUST+jhdAHVA==
X-ME-Sender: <xms:sWo-Z0uCJzowT7wwMiKnnv0du0X-N_SjlpdG00t1vIUMpEw11SzKiw>
    <xme:sWo-Zxf4-7DQKNjzEZR8CGda55Hx0N_5Bwcwnpk1lPNgvY3IwCl4PKx7N0iIPxEt8
    O57AlOMaa4Pw2NL5Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeefffelleduheehleejtdfhheegtdffhedtffeileeh
    keetffevtdegheduhfeiudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlih
    hsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhotgeslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sWo-Z_yjwVr4KDvB_9vFLBQBR3dklP8tD9xEJNO7Z0egnYVD9Irv-A>
    <xmx:sWo-Z3Om-pbqlKu7vhb01kq6hOZTT88epZpnIdShIFE_rI-2H_0cdg>
    <xmx:sWo-Z0_1i-LzvTFOcR4evUM_37c027Mdb2stv9sDeGp_ksyu3EZdrw>
    <xmx:sWo-Z_UIt1shYvLxqB-eEtaHndgyln9jvmw1NA8DqMibs-fkx6YgTQ>
    <xmx:smo-Zza4Od35ggJaClJXMoxcbt9RYPzQAIDzqr0dB-YtcF8rDI7bfxbb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC5522220071; Wed, 20 Nov 2024 18:03:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 00:02:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-Id: <8eb10ff6-08f3-4efc-8839-1d7559bb8c6f@app.fastmail.com>
In-Reply-To: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com>
References: <d58cbbc9-e5b0-49c3-8cf7-d0726e796e92@app.fastmail.com>
Subject: [GIT PULL 3/4] ARM: soc updates for 6.13
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.13

for you to fetch changes up to 9c6cb0377534e77265ea673fd4834f858d5d1a6f:

  Merge tag 'imx-soc-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/arm (2024-11-12 23:14:50 +0100)

----------------------------------------------------------------
ARM: soc updates for 6.13

The SoC specific code updates for 6.13 are fairly minimal. One Broadcom
SoC model gains automatic configuration for the debug uarg as we have
on many other machines, the remaining changes are trivial cleanups.

----------------------------------------------------------------
Andrew Davis (1):
      ARM: imx: Switch to new sys-off handler API

Arnd Bergmann (4):
      Merge tag 'arm-soc/for-6.13/soc' of https://github.com/Broadcom/stblinux into soc/arm
      Merge tag 'samsung-soc-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into soc/arm
      Merge tag 'zynq-soc-for-6.13' of https://github.com/Xilinx/linux-xlnx into soc/arm
      Merge tag 'imx-soc-6.13' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/arm

Florian Fainelli (1):
      ARM: bcm: brcmstb: Drop custom init_irq callback

Gaosheng Cui (3):
      ARM: samsung: Remove obsoleted declaration for s3c_hwmon_set_platdata
      ASoC: samsung: Remove obsoleted declaration for s3c64xx_ac97_setup_gpio
      ARM: zynq: Remove unused zynq_slcr_init() declaration

Linus Walleij (1):
      ARM: bcm: Support BCMBCA debug UART

 arch/arm/Kconfig.debug                  | 12 +++++++++---
 arch/arm/mach-bcm/Makefile              |  1 +
 arch/arm/mach-bcm/board_bcmbca.c        | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-bcm/brcmstb.c             |  6 ------
 arch/arm/mach-imx/pm-imx6.c             |  6 ++----
 arch/arm/mach-zynq/common.h             |  1 -
 include/linux/platform_data/asoc-s3c.h  |  2 --
 include/linux/platform_data/hwmon-s3c.h | 10 ----------
 8 files changed, 43 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/mach-bcm/board_bcmbca.c

