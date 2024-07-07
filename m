Return-Path: <linux-kernel+bounces-243744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D408C9299FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 00:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E81F21472
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418587345B;
	Sun,  7 Jul 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="Pbg16VQE"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857CEDC;
	Sun,  7 Jul 2024 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720391860; cv=none; b=oU3imAEiu9imooB7lRUq285zVCjemg7yBuu7851avbloWDhofhI2HRjorStuJCJQI6pjYJMx/KFAORLJ5C5V0dbD7GJEWizrfDSShP5ms8R1bYdTC1yZc4kqjCLklcwRtmOaeEdp2JePYKAG5M/lkVdumv3ISvf+EoWgLZ4LQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720391860; c=relaxed/simple;
	bh=O7XVQdyMHMxbunVATdf/LX5GcM2hGQPm9TlJn5WdkTA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SP/V7SJ5bSlPe4nmOng0cEdOQL7LHhGxm8xm6UGfxZG+4x8fWcQIhi7lbRwrdAcmKwbIQekJCkNvhbhzG3MJbPTycf2cr/6xs3inCPe9JwyH664llsJ4h+M+wYpgdmZ42f7zlyiaZCV4wOoQqHsnhOBA3/d0bTKKnmWFh1qsGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=Pbg16VQE; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720391849; x=1720996649; i=j.neuschaefer@gmx.net;
	bh=k/2wUJqCS/1bOuRYIc422cgLx2nAzXVqfJrn7v4mg+Y=;
	h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pbg16VQErMMKQt5uc4D1u5x1W0FuGQcf/eUELyTC8PJrW7abo+4yCloLDuXikIyl
	 Z7eJaQJK/kl4qEN8jBqa3ZVdmkuQggzNOcDSg+j66+DESfjqoMkvov6ICz7dNrELM
	 AnoWgJKF7S2cCNkgNywFTdDAY7FKZQ1NFTNAThdyTftlriDzLA3su/0EUctjixSGX
	 yZhOb1eeiXlKIlvxUiIfOMmjOLsoshF9KlAGDCHYIF0P/i2sbieaJ6ZGJHaHN/CKO
	 WM/Cloojr2Y4So8j1jh8lvup4aFU434BIq9an36m6+PebEiNKBkBYeEno9qdnzPoT
	 pktlTQmHF1P530IruA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzk3-1sszQ13jFx-00Z6oA; Mon, 08
 Jul 2024 00:37:28 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH RESEND v12 0/6] Nuvoton WPCM450 clock and reset driver
Date: Mon, 08 Jul 2024 00:37:13 +0200
Message-Id: <20240708-wpcm-clk-v12-0-1afac539c37d@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720391846; l=4460;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=LHlwXz0xY3IxreqHfZl/rfZVPyckYCVZucb0Ic/3Jx4=;
 b=3vx2VHTzAy3f/sw5YbD5Lfuf7A/GvQe73unYvZpZ28E03+qj3610qUK549NYrgnXfICu28ZlD
 YuF9/CarQxeAAKUllGdrY7uKZBsbqWqwgSvY6kMcHLWYoFUEuCBHQDO
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:jokVZF9njeuTuV9Gdi0f/8ho8RZIo6O2MkwzzTMqajdkEY6TnCX
 V19p+YOnRRDV3l0nbSMkz8trfgtolb/hg0wnbQzpLGZBL7JDfCl8MKdlHyrRRWbh/G0TYKZ
 MbqYQ2PHx0yCkYYcNau8AdWckgh1yyzGomujXx9A9Wt03cWsdpMJ0pgb8/ZV5eErsYkZs3M
 KGtQUNm5CLTupHJpe4zag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZWyB94pXxsY=;z2pe3s+AvEnqbB3e6T2ZITGDJId
 R4a53ndv2bLz5sCV3IqaY02zhPIxkbXqGbHswjvEpoctw+py6DGDVdrVNv3rrKi6Wuj9PqiyQ
 rTB+nXMV6b/zhQht/AdAdb3EkZimjBmA+2tQdCViJJqLeiP89aHbcCHdHwsxlodiNmmWoj0PN
 USRtgUSbclF8FVBfcDyFV8GcHjApwyooXaHGrSRONFNQ98AKrJwV9sqtR+IB1jYm5FO8VMTg+
 Ws49PvqV2ODlStqZl71ZVaMik2xWU0Wv9Xk3G00Na/6ts1krnVyrc8fKcA5jMwzLlcxDAfkga
 t8jyqlroigj3udWfGuX5ziZgL3ksqlRQyTntquJSWzQzzDsG/qnK28aFzqn5hN38QLTIzfYEu
 wwoJxMf3sn6UPBh1rprmkzJoLTytTEXjPSpMAFsxGGzVjtlRCJSRqQhSHE4k2OJsCrxEkVCxK
 BqkfcaN7hPV/eihj2nfJI+ApUqWT4pUpddBb3ual4cR/9QcX4CRZlhIugryUGdSci0p9DCOxW
 jPXp7YO746yHdMzeOBPQT3jjAkB6HfQJHhtOqWsTXeHtnDQ2KQ/t8jptSB67lsTBS7ZktvW7N
 /91Qs3Tf+W5J68a6STVJeubQ9NxHlQV3GmXK8fjh/Tz9I5rdc1+LYsJTWEOKX2MzjC/+B8We8
 NXTLqsYL56y+jbdBrt+HJzCGPaUFHrbyueWzmkKggXfmDvbTGAlSs+hqSqodN9yxQbphhcZ7m
 OcqCdw1Vqu0lvEamWpvJMcUQfOmlf5lYWQotBAz9GgLqQJbrI/aGDfhvd2mHPXbAuIaHClodr
 JWVT5PVYMEiOoXn0SFQdAu7E6gI4TGRpsr6NYu1Uwmka4=

This series adds support for the clock and reset controller in the Nuvoton
WPCM450 SoC. This means that the clock rates for peripherals will be
calculated automatically based on the clock tree as it was preconfigured
by the bootloader.  The 24 MHz dummy clock, that is currently in the
devicetree, is no longer needed.  Somewhat unfortunately, this also
means that there is a breaking change once the devicetree starts relying
on the clock driver, but I find it acceptable in this case, because
WPCM450 is still at a somewhat early stage.

v12:
- Convert to platform driver, but use fixed-factor-clock for timer
  (a necessary workaround because npcm7xx-timer needs its clock earlier
  than a platform driver can provide it)
- Various driver improvements suggested or inspired by Stephen Boyd
- New patches:
  - clk: Introduce devm_clk_hw_register_divider_table_parent_data()
  - clk: provider: Address documentation pitfall in struct clk_parent_data

v11:
- Link: https://lore.kernel.org/r/20240401-wpcm-clk-v11-0-379472961244@gmx=
.net
- Improved description in "ARM: dts: wpcm450: Remove clock-output-names
  from reference clock node"
- some minor format differences due to switching to B4

v10:
- A small tweak (using selected instead of extending an already-long
  default line) in Kconfig, for better robustness

v9:
- Various improvements to the driver
- No longer use global clock names (and the clock-output-names property)
  to refer to the reference clock, but instead rely on a phandle reference

v8:
- https://lore.kernel.org/lkml/20230428190226.1304326-1-j.neuschaefer@gmx.=
net/
- Use %pe throughout the driver

v7:
- Simplified the error handling, by largely removing resource
  deallocation, which:
  - was already incomplete
  - would only happen in a case when the system is in pretty bad state
    because the clock driver didn't initialize correctly (in other
    words, the clock driver isn't optional enough that complex error
    handling really pays off)

v6:
- Dropped all patches except the clock binding and the clock driver, becau=
se
  they have mostly been merged
- Minor correction to how RESET_SIMPLE is selected

v5:
- Dropped patch 2 (watchdog: npcm: Enable clock if provided), which
  was since merged upstream
- Added patch 2 (clocksource: timer-npcm7xx: Enable timer 1 clock before u=
se) again,
  because I wasn't able to find it in linux-next
- Switched the driver to using struct clk_parent_data
- Rebased on 6.1-rc3

v4:
- Leave WDT clock running during after restart handler
- Fix reset controller initialization
- Dropped patch 2/7 (clocksource: timer-npcm7xx: Enable timer 1 clock befo=
re use),
  as it was applied by Daniel Lezcano

v3:
- https://lore.kernel.org/lkml/20220508194333.2170161-1-j.neuschaefer@gmx.=
net/
- Changed "refclk" string to "ref"
- Fixed some dead code in the driver
- Added clk_prepare_enable call to the watchdog restart handler
- Added a few review tags

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-1-j.neuschaefer@gmx.n=
et/
- various small improvements

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-1-j.neuschaefer@gmx.n=
et/

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
=2D--
Jonathan Neusch=C3=A4fer (6):
      dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
      clk: Introduce devm_clk_hw_register_divider_table_parent_data()
      clk: provider: Address documentation pitfall in struct clk_parent_da=
ta
      clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver
      ARM: dts: wpcm450: Remove clock-output-names from reference clock no=
de
      ARM: dts: wpcm450: Switch clocks to clock controller

 .../bindings/clock/nuvoton,wpcm450-clk.yaml        |  65 +++
 arch/arm/boot/dts/nuvoton/nuvoton-wpcm450.dtsi     |  33 +-
 drivers/clk/Makefile                               |   2 +-
 drivers/clk/nuvoton/Kconfig                        |  10 +-
 drivers/clk/nuvoton/Makefile                       |   1 +
 drivers/clk/nuvoton/clk-wpcm450.c                  | 455 ++++++++++++++++=
+++++
 include/dt-bindings/clock/nuvoton,wpcm450-clk.h    |  67 +++
 include/linux/clk-provider.h                       |  26 +-
 8 files changed, 643 insertions(+), 16 deletions(-)
=2D--
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240330-wpcm-clk-222a37f59cfb

Best regards,
=2D-
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


