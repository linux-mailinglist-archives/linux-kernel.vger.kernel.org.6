Return-Path: <linux-kernel+bounces-253092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C22E931C57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1910F1C217CC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4C13AA46;
	Mon, 15 Jul 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AwbFzCef";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8DDZGa9"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC56C15B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077498; cv=none; b=puYp0iMsdegpnn1CLOdMkWSyFAk+QHkMMd8SsMWlGwwXAZOq4w0SHbWU4jBhz4zRkAAh3tbZD/SY7LLM0uUbtDJuS//GlPFibFhF5xVc3ys9wSAA9+tmtBRCCfrTk5zUWfahe2HQWz4r9Ink0FACy0AxodjbYxfk95OtVMOOYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077498; c=relaxed/simple;
	bh=rFfqDJ9pSJWfP5amMW60tkEKdsdncjQuH9tizWIYEEs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=h4f3BsQ14upVi2y3CUrjk64cv9Brb00ywu7BMGpYnL9KxIUzE9W6lNfWt9rySf1qyCWjvR3Hsry14kU/d1Nglfdg+hr3qcb9xWxlhWIibqK7jvlZxINxGv289zDeRm2wHv/9LZqzR2YxIsqjXHTxXoTDYTxtK8+k3a27dcfYPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AwbFzCef; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8DDZGa9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 511B41147D93;
	Mon, 15 Jul 2024 17:04:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 15 Jul 2024 17:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721077496;
	 x=1721163896; bh=fy7ccMFscxigazJCZ7f8OPFRsDGGruVASwB7I4mC4iI=; b=
	AwbFzCef3fEKZJNT6Jjn0xNV+xp/Dgx33WSzf6HSJT4SvngAbba8Co0SKUrejIXI
	KISDYXmI/GBuEulgg4/n0wy43rhUlI6lHaPkS4A51tfJFo6w7B2X1ogd3vg07sHx
	0ZZ9/9ehjP2VLTlvbYLFnaxEP4HN66vw6Wh4vhQnkKv6Fe4H2FyyGjkTG6lFghes
	psjNUtS/maYhuL5jYkC7YiAmUHT9+w2bF0mVDxtEoMvhohjb/nYqboOxLlKBFW7s
	ube4NRetPE6mGvP7+eg69fAUnF/fUEmn7OswnTvK/hgadg1abXVqgCWKbfb+8ta4
	pmYA7klTVK1NzowgJgtMqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721077496; x=
	1721163896; bh=fy7ccMFscxigazJCZ7f8OPFRsDGGruVASwB7I4mC4iI=; b=e
	8DDZGa9HBH9ScrzRyaSYJCgChony6VHeqO8aDZW+ARrPRCPGvvI/oCPJEG1y+F2O
	WTSBozJ7R9LrvDMQNjxuZAkQON9qP5lA/pObfRYZX7ctNOHqZgujHnB1buf5t8oW
	8UUYkuOnvKtAjD/YrfPuKT0+EazQ/QZtGxwPHR93DIlOV1jk3ILHEIGdAYo066wS
	R7RMIN1/noAvWFCq0UBmQAGl1y8nRfmx5cWuJHr2dFrT+vaA9S8ycO0zdl+jBeZn
	2DrSm+2D3Ub4a9BLyRR1Nyctaae7MaPS60JV94b0W1ggSl5Owk4mp1ta79gjhAJt
	4Djap9Vg/voKeTzJ4b+ow==
X-ME-Sender: <xms:946VZh4D0CYElAYsfHalPLn31zHTAYISq7Y1axwTj0NwMGwI4AnLrw>
    <xme:946VZu5j_JTLpC4Wh9bjga81_16y-HnqeU5D-H10SV_V6rExOF6x35VV1c4Bi7nzQ
    kv1LWY3tjplkrLZ6VE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedvgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:946VZoe4Bqz39emgT-h2t29OaSbondyTPGkzpJFzpawjq_LQpRPJhQ>
    <xmx:946VZqJH_bsCArYa2ld4e6uUC95Uk6uUsJZ89HgNeKSZtrhfknh4YA>
    <xmx:946VZlLQzlrPGGcMTJMn4mZowBcVRJzp64z_-TJQVx_jkpDkFn0GRA>
    <xmx:946VZjz7tiGf4hx4s7f53Yu9Ek3z_cNIeJ32d8cILmjobefxUf1JGw>
    <xmx:-I6VZl0M9XeGMM-5y-xwVoQE_TQ8nZQPPsDk55e3VyzEZKX_M6YN4C-4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 20E28B6008F; Mon, 15 Jul 2024 17:04:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e920ecb-384d-4fca-988d-fd3380c2daed@app.fastmail.com>
In-Reply-To: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
Date: Mon, 15 Jul 2024 23:12:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@kernel.org
Subject: [GIT PULL 4/4] soc: arm platform updates for 6.11
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d=
58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-a=
rm-6.11

for you to fetch changes up to dead06c5e110c25931bafc8cf017e3077b871ac5:

  ARM: pxa: fix build breakage on PXA3xx (2024-07-15 13:53:28 +0200)

----------------------------------------------------------------
soc: arm platform updates for 6.11

The majority of the updates here are Dmitry Torokhov's cleanups
for platform code in the pxa and tegra platforms, changing custom
platform_data structures into DT-compatible software node declarations.

The other updates are for the MAINTAINERS file, correcting some
stale or missing entries.

----------------------------------------------------------------
Arnd Bergmann (3):
      Merge tag 'vexpress-updates-6.11' of git://git.kernel.org/pub/scm/=
linux/kernel/git/sudeep.holla/linux into soc/arm
      Merge tag 'tegra-for-6.11-arm-core' of https://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/arm
      Merge tag 'imx-soc-6.11' of https://git.kernel.org/pub/scm/linux/k=
ernel/git/shawnguo/linux into soc/arm

Baruch Siach (1):
      arm64: layerscape: remove redundant EDAC_SUPPORT selection

Dmitry Torokhov (10):
      ARM: tegra: paz00: Use software nodes to describe GPIOs for WiFi r=
fkill
      ARM: spitz: fix GPIO assignment for backlight
      ARM: pxa: consolidate GPIO chip platform data
      ARM: pxa/gumstix: convert vbus gpio to use software nodes
      ARM: spitz: Simplify instantiating SPI controller
      ARM: spitz: Use software nodes to describe audio GPIOs
      ARM: spitz: Use software nodes to describe LCD GPIOs
      ARM: spitz: Use software nodes to describe MMC GPIOs
      ARM: spitz: Use software nodes to describe LED GPIOs
      ARM: pxa: fix build breakage on PXA3xx

Drew Fustini (1):
      MAINTAINERS: thead: add git tree

Jeff Johnson (1):
      bus: vexpress-config: Add missing MODULE_DESCRIPTION() macro

Krzysztof Kozlowski (3):
      MAINTAINERS: ARM: airoha: add entry to cover Airoha SoC
      amazon: MAINTAINERS: change to odd fixes and Tsahee Zidenberg to C=
REDITS
      ti: omap: MAINTAINERS: move Beno=C3=AEt Cousson to CREDITS

Linus Walleij (2):
      ARM: spitz: Use software nodes to describe SPI CS lines
      ARM: spitz: Use software nodes for the ADS7846 touchscreen

Rob Herring (Arm) (2):
      arm: vexpress: Remove obsolete RTSM DCSCB support
      dt-bindings: arm: Remove obsolete RTSM DCSCB binding

 CREDITS                                            |   9 +
 .../devicetree/bindings/arm/rtsm-dcscb.txt         |  19 --
 MAINTAINERS                                        |  16 +-
 arch/arm/configs/vexpress_defconfig                |   1 -
 arch/arm/mach-pxa/devices.c                        |  55 ++--
 arch/arm/mach-pxa/devices.h                        |   5 +-
 arch/arm/mach-pxa/gumstix.c                        |  24 +-
 arch/arm/mach-pxa/pxa25x.c                         |   8 +-
 arch/arm/mach-pxa/pxa27x.c                         |   9 +-
 arch/arm/mach-pxa/spitz.c                          | 284 +++++++++++---=
-------
 arch/arm/mach-tegra/board-paz00.c                  |  50 ++--
 arch/arm/mach-versatile/Kconfig                    |   9 -
 arch/arm/mach-versatile/Makefile                   |   3 -
 arch/arm/mach-versatile/dcscb.c                    | 173 -------------
 arch/arm/mach-versatile/dcscb_setup.S              |  33 ---
 arch/arm64/Kconfig.platforms                       |   1 -
 drivers/bus/vexpress-config.c                      |   1 +
 include/linux/platform_data/mmc-pxamci.h           |   4 +-
 18 files changed, 264 insertions(+), 440 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/rtsm-dcscb.txt
 delete mode 100644 arch/arm/mach-versatile/dcscb.c
 delete mode 100644 arch/arm/mach-versatile/dcscb_setup.S

