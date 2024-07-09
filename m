Return-Path: <linux-kernel+bounces-245591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D792B4B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE4FB21D05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4C156243;
	Tue,  9 Jul 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZZBkraPr"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1260275;
	Tue,  9 Jul 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519646; cv=none; b=HQL3sYfodoTTvQ6NwEFMlsyC+a3sIdob0p4siaWDXuUiekblQWUdX6CxuQrPuDjRfC+4p2FMGc+eIDNc9N6I+N1XpNTHufPJ59cZgY+owdBHLzolS9qcQBs2o9WQNz8vy2O2WgarPhNVbZsIjYpMQlpn2qs75p6UQd5Hj9Nricc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519646; c=relaxed/simple;
	bh=9/G/GqAyndEEPYXXqhml/xWHy6WN18ZRU0cozK1HbQE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YdIa3X1g+hRNt93HcdAD+eivzFu2+QvSW2NGKqqiIQpjlzxSVNe07zbwQcxNZPgSxWVvHjt25Amj+n8OtF0yUmv/T6E2T0fxNkm6bzc+vea1R2D/bH406O9ixb11jmcsEkx5QogA7ksL4QWiFcIK2lmS9iO7kfMjV8ZcAkp4mGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZZBkraPr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9BCBF40002;
	Tue,  9 Jul 2024 10:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720519642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2H1eC2RhJwRtaKrShLbPvmd+hHIztSofnjas5VApbIo=;
	b=ZZBkraPryArJgdBEYWibidjRIUA2Haa7axtM61ab9XvXK+bi2mo9eMh/mjuuceIq9byUQT
	lCPzB396TuLB4G62YakjC9No/kQilc6VN0D66qV0cD1ce1qAQauiw/q/8FYAVygcPieb4E
	V2xy8SwmSl6cjQA+17tCRWXut60YizQFE/JrRqkjbQuudxrYJxC1kjBHbkRvfLA98Kyttq
	RaUmiZQGfbo4D2ThOqyMvynm+Vv2e/JTGUTJdfmUCiOaXTtJOkOuMyh+8fKEmib/jNEjgx
	wk9G46mdSz5sTX5p5fGCWblknqNlXdAnlRGepAMeJLD48ToIEML6fWYtmMD8WQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v3 0/5] Add board support for Sipeed LicheeRV Nano
Date: Tue, 09 Jul 2024 12:07:15 +0200
Message-Id: <20240709-sg2002-v3-0-af779c3d139d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANMLjWYC/3WO3WoDIRCFXyV4XYMzuq72Ku8ReuHPmAjtWtawJ
 IR997opNEjbyzPM951zZ5XmTJW97u5spiXXXKYW5MuOhbObTsRzbJmhQCUGGHg9oRDIrYyBIKK
 Wnlh7/pwp5etDdHxr+Zzrpcy3h3eB7fpLsQAXXMY0GnBGKAMHX8rlPU/7UD425zeAsgOsB+UtG
 Guc+wcYOwC8Dl6aQCapDthmLvicpkH8gNhAQumjTDpKMf7ZpAE7AKwbzOCSNkr3Teu6fgEAZU7
 qagEAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Chao Wei <chao.wei@sophgo.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

The LicheeRV Nano is a RISC-V SBC based on the Sophgo SG2002 chip. Adds
minimal device tree files for this board to make it boot to a basic
shell.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
Changes in v3:
- Remove /dts-v1/ directive from sg2002.dtsi file
- Add disable-wp property to sdhci node to avoid having a write
  protected SD card
- Drop changes in cv18xx.dtsi and cv1800b.dtsi
- Add fallback compatible to cv1800b in SDHCI node of sg2002.dtsi
- Link to v2: https://lore.kernel.org/r/20240612-sg2002-v2-0-19a585af6846@bootlin.com

Changes in v2:
- Add SDHCI support
- Change device tree name to match the Makefile
- Add oscillator frequency
- Add aliases to other UARTs
- Add aliases to GPIOs
- Move compatible for SDHCI from common DT to specific DT 
- Link to v1: https://lore.kernel.org/r/20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com

---
Thomas Bonnefille (5):
      dt-bindings: interrupt-controller: Add SOPHGO SG2002 plic
      dt-bindings: timer: Add SOPHGO SG2002 clint
      dt-bindings: riscv: Add Sipeed LicheeRV Nano board compatibles
      riscv: dts: sophgo: Add initial SG2002 SoC device tree
      riscv: dts: sophgo: Add LicheeRV Nano board device tree

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
 .../devicetree/bindings/riscv/sophgo.yaml          |  5 ++
 .../devicetree/bindings/timer/sifive,clint.yaml    |  1 +
 arch/riscv/boot/dts/sophgo/Makefile                |  1 +
 .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 54 ++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 32 +++++++++++++
 6 files changed, 94 insertions(+)
---
base-commit: d20f6b3d747c36889b7ce75ee369182af3decb6b
change-id: 20240515-sg2002-93dce1d263be

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


