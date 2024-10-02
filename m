Return-Path: <linux-kernel+bounces-347352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7098D190
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4811F22F62
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0A81E6329;
	Wed,  2 Oct 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+tKaBe+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378FA1E130F;
	Wed,  2 Oct 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866091; cv=none; b=kMbpG+S0ozG4iP8x1Bv2y1MrC//rDP6U8eEV65wGL7UAJzrp7JyPJb2k4sq6BpPwf0hW83J05Y6/pcntSWP1WXZ8p7FB18Mvz0/u0qjKIsCNv7PuKO3hT23nYQOLKrDR2iVKNtvgFinRTAMzOVFY0s1W9/t02oRL4JQ6LhGjrXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866091; c=relaxed/simple;
	bh=X7o2wPuerOGCcKjMyOjYiFvGvskMQv5ZlFx2sUQSTyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dv92yvbQ/Tvqxxe03hr94qIQ4fM0rTDXQ1MksaeaJJCif21HIa4xKhZztCqx/PMDwkGxPlySl7cpvSMN9HnUlZf/7vmDq9y8IT41MRMSz/OqBWCktrtcuZG3xYiW+0brxtZNx37b17D7iF0EIaNkpkmHbQAazD2fapmDa5V4s8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+tKaBe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239F7C4CEC5;
	Wed,  2 Oct 2024 10:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866090;
	bh=X7o2wPuerOGCcKjMyOjYiFvGvskMQv5ZlFx2sUQSTyE=;
	h=From:To:Cc:Subject:Date:From;
	b=J+tKaBe++f7MI+YEFi9xRXJVacjUy4gpilwcIWVBCjk0e9Qu280vFYNxNwbzb80RQ
	 rAIS1/BTmlc1ORtGfjCOBn41SKKR3ObPBIuUWN8AUfIul5DuRAg2WqxuyFxDGazn3S
	 Ibaf8ngjEd2S+WjdC6KE2VIwYFLGGvYXxSVYrjiUOSGk5s2/ynMOiWqfL/QPElIL81
	 DabU3tCrfoptb4QzFD0t7/AP5OZbUSgRm/9VLjBcv/Pxs0p598hQZRKq6ZEAS/v70f
	 dPttqa2I3YJkIJ4dbvySE8oNGeiR6Y3MzoBkjsbED9ccnWN5hhfNtQb486bEh6xOng
	 bM19qJfjPRLXQ==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 00/11] Redo PolarFire SoC's mailbox/clock devicestrees and related code
Date: Wed,  2 Oct 2024 11:47:58 +0100
Message-ID: <20241002-private-unequal-33cfa6101338@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7614; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ILkJ4IDwKOG9OkiAKoHGKyrbz7aqasANdjxvroygF3c=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/Ve7fWKHz7dmhqS3/ra7fmFY3m+fNok+lEsZuz37b+ 89hbzDo7yhlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBETC4zMiw+d3qtgnWK343M TOsD2m02RTlHWow3bWv43HzXpeb8JhFGhi8rThdIPGi0Xb/nLfvpyWbMe2PlGl9OmrtqWT+/m+L Cy+wA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Yo,

Here's something that I've been mulling over for a while, since I
started to understand how devicetree stuff was "meant" to be done.
There'd been little reason to actually press forward with it, because it
is fairly disruptive. I've finally opted to do it, because a user has
come along with a hwmon driver that needs to access the same register
region as the mailbox and the author is not keen on using the aux bus,
and because I do not want the new pic64gx SoC that's based on PolarFire
SoC to use bindings etc that I know to be incorrect.

Given backwards compatibility needs to be maintained, this patch series
isn't the prettiest thing I have ever written. The reset driver needs to
retain support for the auxiliary bus, which looks a bit mess, but not
much can be done there. The mailbox and clock drivers both have to have
an "old probe" function to handle the old layout. Thankfully in the
clock driver, the Meson clk-regmap support can be used to identically
handle both old and new devicetree formats - but using a regmap in the
mailbox driver was only really possible for the new format, so the code
there is unfortunately a bit of an if/else mess that I'm both not proud
of, nor really sure is worth "improving".

The series should be pretty splitable per subsystem, only the dts change
has some sort of dependency, but I'll not be applying that till
everything else is in Linus' tree, so that's not a big deal.

I've got all the Meson clock folks on CC, given I am moving their
clk-regmap implementation to common code. There were one or two things I
didn't really like about the implementation, but it is better than the
Qualcomm one IMO and creating a third copy of clk-regmap is certainly
not an improvement on having two copies!

I don't really want this stuff in stable, hence a lack of cc: stable
anywhere here, since what's currently in the tree works fine for the
currently supported hardware.

AFAIK, the only other project affected here is U-Boot - I've got some
WIP work that I need to rebase and send for it before the dts patches
here will be applied:
https://github.com/ConchuOD/u-boot/commits/syscon-clocks/

I previously submitted this as an RFC, only to Lee and the dt list, in
order to get some feedback on the syscon/mfd bindings:
https://lore.kernel.org/all/20240815-shindig-bunny-fd42792d638a@spud/
I'm not really going to bother with a proper changelog, since that was
submitted with lots of WIP code to get answers to some questions. The
main change was "removing" some of the child nodes of the syscons.

Cheers,
Conor.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: pierre-henry.moussay@microchip.com
CC: valentina.fernandezalanis@microchip.com
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>
CC: Lee Jones <lee@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Neil Armstrong <neil.armstrong@linaro.org>
CC: Jerome Brunet <jbrunet@baylibre.com>
CC: Kevin Hilman <khilman@baylibre.com>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>
CC: linux-riscv@lists.infradead.org
CC: linux-clk@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-amlogic@lists.infradead.org
CC: linux-arm-kernel@lists.infradead.org

Conor Dooley (11):
  dt-bindings: mailbox: mpfs: fix reg properties
  mailbox: mpfs: support new, syscon based, devicetree configuration
  dt-bindings: mfd: syscon document the non simple-mfd syscon on
    PolarFire SoC
  dt-bindings: soc: microchip: document the two simple-mfd syscons on
    PolarFire SoC
  soc: microchip: add mfd drivers for two syscon regions on PolarFire
    SoC
  reset: mpfs: add non-auxiliary bus probing
  dt-bindings: clk: microchip: mpfs: remove first reg region
  clk: move meson clk-regmap implementation to common code
  clk: microchip: mpfs: use regmap clock types
  riscv: dts: microchip: fix mailbox description
  riscv: dts: microchip: convert clock and reset to use syscon

 .../bindings/clock/microchip,mpfs-clkcfg.yaml |  36 +++---
 .../mailbox/microchip,mpfs-mailbox.yaml       |  13 +-
 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../microchip/microchip,mpfs-control-scb.yaml |  44 +++++++
 .../microchip,mpfs-mss-top-sysreg.yaml        |  54 +++++++++
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  34 ++++--
 drivers/clk/Kconfig                           |   4 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/{meson => }/clk-regmap.c          |   2 +-
 drivers/clk/meson/Kconfig                     |  46 ++++---
 drivers/clk/meson/Makefile                    |   1 -
 drivers/clk/meson/a1-peripherals.c            |   2 +-
 drivers/clk/meson/a1-pll.c                    |   2 +-
 drivers/clk/meson/axg-aoclk.c                 |   2 +-
 drivers/clk/meson/axg-audio.c                 |   2 +-
 drivers/clk/meson/axg.c                       |   2 +-
 drivers/clk/meson/c3-peripherals.c            |   2 +-
 drivers/clk/meson/c3-pll.c                    |   2 +-
 drivers/clk/meson/clk-cpu-dyndiv.c            |   2 +-
 drivers/clk/meson/clk-dualdiv.c               |   2 +-
 drivers/clk/meson/clk-mpll.c                  |   2 +-
 drivers/clk/meson/clk-phase.c                 |   2 +-
 drivers/clk/meson/clk-pll.c                   |   2 +-
 drivers/clk/meson/g12a-aoclk.c                |   2 +-
 drivers/clk/meson/g12a.c                      |   2 +-
 drivers/clk/meson/gxbb-aoclk.c                |   2 +-
 drivers/clk/meson/gxbb.c                      |   2 +-
 drivers/clk/meson/meson-aoclk.h               |   2 +-
 drivers/clk/meson/meson-eeclk.c               |   2 +-
 drivers/clk/meson/meson-eeclk.h               |   2 +-
 drivers/clk/meson/meson8-ddr.c                |   2 +-
 drivers/clk/meson/meson8b.c                   |   2 +-
 drivers/clk/meson/s4-peripherals.c            |   2 +-
 drivers/clk/meson/s4-pll.c                    |   2 +-
 drivers/clk/meson/sclk-div.c                  |   2 +-
 drivers/clk/meson/vclk.h                      |   2 +-
 drivers/clk/meson/vid-pll-div.c               |   2 +-
 drivers/clk/microchip/Kconfig                 |   3 +
 drivers/clk/microchip/clk-mpfs.c              | 114 +++++++++++++-----
 drivers/mailbox/Kconfig                       |   1 +
 drivers/mailbox/mailbox-mpfs.c                |  87 ++++++++++---
 drivers/reset/reset-mpfs.c                    |  83 +++++++++++--
 drivers/soc/microchip/Kconfig                 |  13 ++
 drivers/soc/microchip/Makefile                |   1 +
 drivers/soc/microchip/mpfs-control-scb.c      |  45 +++++++
 drivers/soc/microchip/mpfs-mss-top-sysreg.c   |  48 ++++++++
 .../meson => include/linux/clk}/clk-regmap.h  |   0
 47 files changed, 541 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
 rename drivers/clk/{meson => }/clk-regmap.c (99%)
 create mode 100644 drivers/soc/microchip/mpfs-control-scb.c
 create mode 100644 drivers/soc/microchip/mpfs-mss-top-sysreg.c
 rename {drivers/clk/meson => include/linux/clk}/clk-regmap.h (100%)

-- 
2.45.2


