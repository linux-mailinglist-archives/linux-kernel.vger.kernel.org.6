Return-Path: <linux-kernel+bounces-288041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C8953211
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9C51F21F93
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177119FA8D;
	Thu, 15 Aug 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smnwWAAy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D8762D2;
	Thu, 15 Aug 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730489; cv=none; b=BayNDNfTlfbJzdajmfPOXQYBYMkm+xGU/qF21vlTLkiKdee7pQ5t+ECotp5uXPFOpU/6RvmwH+SygMe36HBNXUvKbpIgLb4ChOBHyo+8Unfx0tk+rNw3EIW9nIZv7yzaOPJA5JAonXYOICCOdOrunjk4lXSc3aq3qnrotX0ISy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730489; c=relaxed/simple;
	bh=DNInlNG/vK4ckeb+8xgzOm1Bl+lN6I8I+KXntSQlL50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGhBfvzvxZkuBWj1CyHDE9av1dz89ds2dLii+xhDZ6tBWba/Yij3Db4P2UrawPTlMqOkK7FvGnCb88lGGuKhZQNw5HNOG3j5ZriifQoGHEwN50sH9YGxSH2G0YkBzCQQzZIbBwHWr6gKev5xAibttGfmrPGxmNsr4iyjxzb/NM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smnwWAAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64A1C4AF0A;
	Thu, 15 Aug 2024 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730488;
	bh=DNInlNG/vK4ckeb+8xgzOm1Bl+lN6I8I+KXntSQlL50=;
	h=From:To:Cc:Subject:Date:From;
	b=smnwWAAyZbZXJbodG6DIIrH1IWH64cQTvO2C0iaEtWyYSACg3jqgfNhXBlyPkWwlU
	 Zum/2/xUHWKaVrzdccbbmGCPH2yOW/FQ/ygfLNOoSMndXHAhWRY6QUJWA+PxeNBznh
	 mRZIBg4IHvvnJfUWVUMIVTm7dHH1eVm4gMSbahUdky8B6mnqCJ1DGQgGATLoQLRXvv
	 Ry/qWBLAzty5wiEd8Q2O8L/XIe2RbjIoz2IBKY0XtoH9b4uibIO3B1uS0Io2XvvmlJ
	 M0pcLDlK9xKq9q1KDw+H+vbHa+4npyx/Xr3pXt+95Lxv56CgRUjdcp/Tr4wBo2OckZ
	 l9irnjvBtGBbA==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/11] Rules for simple-mfd child nodes
Date: Thu, 15 Aug 2024 15:01:02 +0100
Message-ID: <20240815-shindig-bunny-fd42792d638a@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2691; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=6W4I3IDEnGueXh4X8Qvm9in4zEu8EDRlMOj9R/7XdMM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uLS3nlxavjFe6lDBan0tw6VLNV7IhG5Ju/6G5bbG4 fLeJ8GcHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZgIhy7DH64HCx+ai/0WqCr9 VPGw2s9kd/a1CymCJb92vMnyta2LZ2T473M/lKf6nJfg0cOmD2oFrQ4HsFx9vHvW10uyD35LP/9 wjQkA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Yo,

Please ignore the whole thing, except for the "dt-bindings: soc" patch.
As I mentioned on IRC earlier, I just do not understand when it is or is
not appropriate to have a child node in a simple-mfd and what the rules
about it are. The patch itself repeats the questions in more detail. The
rest of this is here for context and is very much something that is
WIP...

Cheers,
Conor.

CC: Lee Jones <lee@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (10):
  dt-bindings: mailbox: mpfs: fix reg properties
  mailbox: mpfs: support fixed binding (TODO: always use regmap)
  riscv: dts: microchip: fix mailbox description (TODO drop 3rd syscon
    from here)
  dt-bindings: mfd: syscon document the non simple-mfd syscon on
    PolarFire SoC
  dt-bindings: soc: microchip: document the two simple-mfd syscons on
    PolarFire SoC
  reset: mpfs: add non-auxiliary bus probing
  copy meson clk-regmap for now
  clk: microchip: mpfs: use regmap clock types
  dt-bindings: clk: microchip: mpfs: remove first reg region
  riscv: dts: microchip: convert clock and reset (TODO: fixup phandle)

Lars Randers (1):
  hwmon: add a driver for the temp/voltage sensor on PolarFire SoC

 .../bindings/clock/microchip,mpfs-clkcfg.yaml |  33 +-
 .../mailbox/microchip,mpfs-mailbox.yaml       |  10 +-
 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../microchip/microchip,mpfs-control-scb.yaml |  54 +++
 .../microchip,mpfs-mss-top-sysreg.yaml        |  53 +++
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |  44 +-
 drivers/clk/microchip/Makefile                |   1 +
 drivers/clk/microchip/clk-mpfs.c              |  81 ++--
 drivers/clk/microchip/clk-regmap.c            | 186 +++++++++
 drivers/clk/microchip/clk-regmap.h            | 137 +++++++
 drivers/hwmon/Kconfig                         |  12 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/tvs-mpfs.c                      | 379 ++++++++++++++++++
 drivers/mailbox/mailbox-mpfs.c                |  46 ++-
 drivers/reset/reset-mpfs.c                    |  86 +++-
 15 files changed, 1055 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
 create mode 100644 drivers/clk/microchip/clk-regmap.c
 create mode 100644 drivers/clk/microchip/clk-regmap.h
 create mode 100644 drivers/hwmon/tvs-mpfs.c

-- 
2.43.0


