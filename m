Return-Path: <linux-kernel+bounces-577503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E94A71DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4727A34C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36624BC1D;
	Wed, 26 Mar 2025 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O+10IPBP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jo43SzKe"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7987D214230
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012261; cv=none; b=RuX23LmSF2HWeC9TakZLD4IBXwugrSUvnAan3AKJPE6lQD+LZXvq2RmoTjN3h0IjCgPcvMA2tSLr5Dexb9Gcr33EuBRihCtG2+KyILRGCvX8dV3F6Xk77lWnYdvTnFjW9KqBFyS1dKYM/+RmxPYinSyTgxH2VFd5TRnLnfHAGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012261; c=relaxed/simple;
	bh=RPTh1G+eh9LivHTeHvX5D9aZ401Lo/pQklZlCFFOa+g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lM68s8cqUn9e55Mm0qoD9XL9bsAybTBDvbduVEtdiuwDDbV/oB2qgfPuex5Wk22AG7fAJMwH1EsXWqvHtKJHWVWo5yT6uz+WRSHHucuaIfgJJBY22gRwUScn/SJB1iFlAZgjYKRpLQBVwlyITmnuId93cRt2mzph5jCUsNSR9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=O+10IPBP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jo43SzKe; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A82D81140290;
	Wed, 26 Mar 2025 14:04:17 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 14:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743012257;
	 x=1743098657; bh=Nky34RFHSujuIw2dy1Q+oHT6uhlRwUJS3T+rMAseYw4=; b=
	O+10IPBPLHD/N68vzozvAy0KHjMm6Dst/ojP92myPYtvTzYpxe6uvm4Aj7nuJb5Z
	fUGnu7VkQcj3zT0hYeSGyE9s7yKi+DGrtC1bG8hu8s0ENBVzesRxQbaojCjIn5Nb
	NXZkDTmbsLOIB9XiAotA3M1Bv8ZchKH/DVppNKH4YjDjwb+PFb57BxQqfUqeKY6+
	BTj/2+M6Yz1b0Em64CPY7p0FIJC0qANuDxO273e5b/+0PaYBwOEQBOpXEX+UzJmV
	24tisImSY5GgdFxhv8hk+8NbjY7Nwqzf+ozzIaUSHq69x7R2MQI3ElwfuMXHA3f6
	XTSi77KxEoZgrw/tgVQN9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743012257; x=
	1743098657; bh=Nky34RFHSujuIw2dy1Q+oHT6uhlRwUJS3T+rMAseYw4=; b=j
	o43SzKebbLf0lP5Qd61e0H0s6jzYuvYivFHqFPD4WYLgj6s/1JzinUvzOZMpw8CE
	AnA8QFqy9tS6uk7kKNBzZLms5PWtsUxdmBdrLiQLkIWBq7aONT3MEy2nEfbB6ENn
	gX/nMbro7vifpAF++U9egeWxPW8Xyiwm8/ZbdB8bCfuAhrjNVJ0DZ8DjvWVHeoGu
	U85PqtuRny0ZxShtK8zbVWhjich/8xEBHlONe+afNXiMZKgqvbF+d0st/uma2Ux/
	gZUcwRBuzvbqPN7ZOPWYpKdahjJQR7ucvlRRwSYAV7PPSns2ym9vc6cOPeEhnnPM
	hLnV65kmOBPP0QRflm2YA==
X-ME-Sender: <xms:oUHkZzZe9Gu7upDmSjgDlnXA5kDCMT44ebZp4uA6-zyOcQpU8tLTiw>
    <xme:oUHkZya9bnm7YqDyQaUVkT4hfhZFIxuU40Sm5oTCAApGbhDLLeHiUDV_5Ez_rRF6W
    VKNO9jQB7NX8HflFsY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeej
    feekkeelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtohepshhotgeslhhishhtshdrlhhinhhugidruggv
    vhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:oUHkZ18Ff3yAaNchSooBEQtENsU1ouFWbTqDDDGM3WiontRnE3PNbA>
    <xmx:oUHkZ5oPYLsTT2Z0lLgakWnrEM-to4PtDB2D4-Wfu-YedM1V4u2Q0Q>
    <xmx:oUHkZ-rEJkCQFiPrGbPHu4uFcig66HFPZScyT6CUYObKvRe5puC31A>
    <xmx:oUHkZ_SvCho44aeeWUYRV8Luqaf2PbsiSDIHAEbg5kXcnZ-t7yFpaA>
    <xmx:oUHkZxWgld517591LcWNYw0IHilxxv-mbJxd6J_RNxOb2e3EMkeA4hXE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 586012220072; Wed, 26 Mar 2025 14:04:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2e1b8447a49b63d2
Date: Wed, 26 Mar 2025 19:03:55 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@lists.linux.dev
Message-Id: <ba5bc4de-e264-41f4-81b2-757ed275fa53@app.fastmail.com>
In-Reply-To: <1ef00af5-0196-46c4-95f3-7c6b90f3e293@app.fastmail.com>
References: <1ef00af5-0196-46c4-95f3-7c6b90f3e293@app.fastmail.com>
Subject: [GIT PULL 4/4] soc: arm platform changes for 6.15
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.15

for you to fetch changes up to 46367f09b2203f7c63f89293aea9279b875d0ff2:

  ARM: davinci: always enable CONFIG_ARCH_DAVINCI_DA850 (2025-03-24 22:34:37 +0100)

----------------------------------------------------------------
soc: arm platform changes for 6.15

The at91 platform gains support for SAMA7D65, a new variant of the
Cortex-A7 based SAMA7G5 with a graphics output.

The i.MX, Renesas and davinci platforms each get one minor bugfix.

----------------------------------------------------------------
Arnd Bergmann (5):
      Merge tag 'renesas-arm-soc-for-v6.15-tag1' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/arm
      ARM: imx: mark imx53_suspend_sz as unused
      Merge tag 'imx-soc-6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/arm
      Merge tag 'at91-soc-6.15' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into soc/arm
      ARM: davinci: always enable CONFIG_ARCH_DAVINCI_DA850

Geert Uytterhoeven (1):
      ARM: shmobile: rcar-gen2: Remove CMA reservation code

Li Bin (1):
      ARM: at91: pm: fix at91_suspend_finish for ZQ calibration

Ryan Wanner (5):
      dt-bindings: atmel-sysreg: Add SAMA7D65 Chip ID
      ARM: at91: Add Support in SoC driver for SAMA7D65
      ARM: at91: pm: add DT compatible support for sama7d65
      ARM: at91: pm: Add Backup mode for SAMA7D65
      ARM: at91: pm: Enable ULP0/ULP1 for SAMA7D65

Wolfram Sang (2):
      dt-bindings: ARM: at91: make separate entry for Olimex board
      dt-bindings: ARM: at91: add Calao USB boards

 .../devicetree/bindings/arm/atmel-at91.yaml        |  33 ++++++-
 .../devicetree/bindings/arm/atmel-sysregs.txt      |   1 +
 arch/arm/mach-at91/pm.c                            |  47 +++++++---
 arch/arm/mach-at91/pm.h                            |   1 +
 arch/arm/mach-at91/pm_data-offsets.c               |   2 +
 arch/arm/mach-at91/pm_suspend.S                    | 101 +++++++++++++++++++--
 arch/arm/mach-davinci/Kconfig                      |   1 +
 arch/arm/mach-imx/common.h                         |   2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |  76 ----------------
 drivers/soc/atmel/soc.c                            |   5 +
 drivers/soc/atmel/soc.h                            |   3 +
 11 files changed, 170 insertions(+), 102 deletions(-)

