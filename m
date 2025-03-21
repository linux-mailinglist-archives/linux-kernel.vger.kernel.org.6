Return-Path: <linux-kernel+bounces-571724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EFDA6C147
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A11D3B1E26
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8122DF95;
	Fri, 21 Mar 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBW8ma+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40BA1CAA80;
	Fri, 21 Mar 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577792; cv=none; b=JFcslEYkp+w3tS8Ays+CptSUcWIkGqL0mWTPt5bJGw783yDOQQX0WEjb5lZho5A6kDzjlSE5QGLa3jeF2oYCQ/JPOyoXnobX1ppReI6o59/BViUgFRhMMccRr8a53P06uhmoVIaV9AubCdY6noBqvIpWeTTTbqtAeWG74YgLc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577792; c=relaxed/simple;
	bh=ALF8uIdVgunXcUP0TGmP+eJ0CmXSJCrrrJygn06nOiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLYK0/6ZaZFKI7F7aMjAREqEOYwDFu2rl3lZM5X2V96FBeuNuTp0D6ucoYa8/M25eQB1USFak2Y3MX0K7qrM/sQdmU21Q06r8flppfcLqtTsRNPGkyY3Mii3n6Ju2/xZuRnakMP+TmVLB+oxxlOGGO6BjANKwWx01bHXghfuATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBW8ma+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E527EC4CEE3;
	Fri, 21 Mar 2025 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577792;
	bh=ALF8uIdVgunXcUP0TGmP+eJ0CmXSJCrrrJygn06nOiM=;
	h=From:To:Cc:Subject:Date:From;
	b=eBW8ma+yGXEACHnQAT1uqCIasZxE+WTQAkhXFnS+npwir/3VFXtY26bPunv+XNyie
	 HXe2TQFw5JeR1PdFheb4r8SzpNDZBViEIuPRWOSUby7cpKPiRYbn0V0/YoKbAhAMLP
	 bVrKSeVO0XCvKZ1DSdggUHL/cGAmmjLRZII7U/4MfA3ZI4kKXCj6/szJ18VuAjIaA1
	 nKAGWI+pLSPB3z2Qs8nPyTLdaWS/z4pnzncmOhuj5cKdFycyEYg+Thr+SJfiClyoBr
	 WwGfXxszZm2EmNC2yod//zm6wXOk45HpDDiCLXxiZdcGjMsfULmzFki42xlCA7G6Bw
	 teEvcE3LTNWog==
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/9] Redo PolarFire SoC's mailbox/clock devicestrees and related code
Date: Fri, 21 Mar 2025 17:22:33 +0000
Message-ID: <20250321-cuddly-hazily-d0ab1e1747b5@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5347; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=v72IsBW2yUvcvDH5N5nR2Mvll104/cwB1qRKakjs864=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOl3F0TsqLATvPxVRrIrN5V7uvMEKb4CgYjTKz6qJL0Qf x7nlbito5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABPhXMfwv9Q1fMecYmvxSw6B LDGv47mD0pvm3F3r0Ka2YfPJA1yzmhkZ5gqdytFb+in49i4/N0VRhRkCp+S1DpufCZPjTl/R+u8 lMwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

(Back to RFC again, as I'm really just wanting to hear from Stephen on
what I did with the regmap clocks, and if it was what he was looking
for)

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
clock driver, regmap support can be used to identically
handle both old and new devicetree formats - but using a regmap in the
mailbox driver was only really possible for the new format, so the code
there is unfortunately a bit of an if/else mess that I'm both not proud
of, nor really sure is worth "improving".

The series should be pretty splitable per subsystem, only the dts change
has some sort of dependency, but I'll not be applying that till
everything else is in Linus' tree, so that's not a big deal.

I don't really want this stuff in stable, hence a lack of cc: stable
anywhere here, since what's currently in the tree works fine for the
currently supported hardware.

AFAIK, the only other project affected here is U-Boot, which I have
already modified to support the new format.

I previously submitted this as an RFC, only to Lee and the dt list, in
order to get some feedback on the syscon/mfd bindings:
https://lore.kernel.org/all/20240815-shindig-bunny-fd42792d638a@spud/
I'm not really going to bother with a proper changelog, since that was
submitted with lots of WIP code to get answers to some questions. The
main change was "removing" some of the child nodes of the syscons.

and as a "real" series where discussion lead to me dropping use of the
amlogic clk-regmap support:
https://lore.kernel.org/linux-clk/20241002-private-unequal-33cfa6101338@spud/
As a result of that, I've implemented what I think Stephen was asking
for - but I'm not at all sure that it is..

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
CC: Philipp Zabel <p.zabel@pengutronix.de>
CC: linux-riscv@lists.infradead.org
CC: linux-clk@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (9):
  dt-bindings: mfd: syscon document the control-scb syscon on PolarFire
    SoC
  dt-bindings: soc: microchip: document the simple-mfd syscon on
    PolarFire SoC
  soc: microchip: add mfd drivers for two syscon regions on PolarFire
    SoC
  reset: mpfs: add non-auxiliary bus probing
  dt-bindings: clk: microchip: mpfs: remove first reg region
  riscv: dts: microchip: fix mailbox description
  riscv: dts: microchip: convert clock and reset to use syscon
  clk: divider, gate: create regmap-backed copies of gate and divider
    clocks
  clk: microchip: mpfs: use regmap clock types

 .../bindings/clock/microchip,mpfs-clkcfg.yaml |  36 ++-
 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../microchip,mpfs-mss-top-sysreg.yaml        |  49 ++++
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  34 ++-
 drivers/clk/Kconfig                           |   8 +
 drivers/clk/Makefile                          |   2 +
 drivers/clk/clk-divider-regmap.c              | 270 ++++++++++++++++++
 drivers/clk/clk-gate-regmap.c                 | 253 ++++++++++++++++
 drivers/clk/clk-gate.c                        |   5 +-
 drivers/clk/microchip/Kconfig                 |   4 +
 drivers/clk/microchip/clk-mpfs.c              | 151 ++++++----
 drivers/reset/reset-mpfs.c                    |  81 ++++--
 drivers/soc/microchip/Kconfig                 |  13 +
 drivers/soc/microchip/Makefile                |   1 +
 drivers/soc/microchip/mpfs-control-scb.c      |  45 +++
 drivers/soc/microchip/mpfs-mss-top-sysreg.c   |  48 ++++
 include/linux/clk-provider.h                  | 120 ++++++++
 17 files changed, 1026 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
 create mode 100644 drivers/clk/clk-divider-regmap.c
 create mode 100644 drivers/clk/clk-gate-regmap.c
 create mode 100644 drivers/soc/microchip/mpfs-control-scb.c
 create mode 100644 drivers/soc/microchip/mpfs-mss-top-sysreg.c

-- 
2.45.2


